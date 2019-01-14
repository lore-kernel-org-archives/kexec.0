Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DV-0000GH-TL
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:17 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 2/8] kexec: implement kexec_file_load() for
 PECOFF+Authenticode files
Date: Mon, 14 Jan 2019 13:47:59 -0600
Message-Id: <1547495285-28907-3-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com

This change adds to Xen the kexec_file_load() entry point.  The
kexec_file_load() is nearly identical to kexec_load(), but with the
added code to handle checking and handling of PECOFF Authenticode
signature verification.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 xen/common/kexec.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index 44ae95d..b013514 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -33,6 +33,10 @@
 #include <compat/kexec.h>
 #endif
 
+#include "ped.h"
+#include "TrustedCert.h"
+int verify_openssl (pecoff_image_t *pe, const uint8_t *TrustedCert, int TrustedCertSize);
+
 bool_t kexecing = FALSE;
 
 /* Memory regions to store the per cpu register state etc. on a crash. */
@@ -1112,6 +1116,126 @@ error:
     return ret;
 }
 
+static int kexec_file_load(XEN_GUEST_HANDLE_PARAM(void) uarg)
+{
+    xen_kexec_load_t load;
+    xen_kexec_segment_t *segments;
+    struct kexec_image *kimage = NULL;
+    int ret;
+    int k, numSigned = 0, numPassed = 0;
+
+    if ( copy_from_guest(&load, uarg, 1) )
+        return -EFAULT;
+
+    if ( load.nr_segments >= KEXEC_SEGMENT_MAX )
+        return -EINVAL;
+
+    segments = xmalloc_array(xen_kexec_segment_t, load.nr_segments);
+    if ( segments == NULL )
+        return -ENOMEM;
+
+    if ( copy_from_guest(segments, load.segments.h, load.nr_segments) )
+    {
+        ret = -EFAULT;
+        goto error;
+    }
+
+    /* Handle signature verification of signed segments */
+    for (k = 0; k < load.nr_segments; ++k)
+    {
+        xen_kexec_segment_t *segment = &segments[k];
+        uint8_t *imageBase = NULL;
+        size_t imageSize;
+        pecoff_image_t *pe = NULL;
+        int j; (void)j;
+
+        if (NULL == segment->buf.h.p) continue;
+
+        imageSize = segment->buf_size;
+        imageBase = xmalloc_array(unsigned char, imageSize);
+        if (NULL == imageBase)
+        {
+            printk("Ooops %u\n", (unsigned)imageSize);
+            ret = -ENOMEM;
+            goto error;
+        }
+        if ( copy_from_guest(imageBase, segment->buf.h, segment->buf_size) )
+        {
+            xfree(imageBase);
+            ret = -EFAULT;
+            goto error;
+        }
+
+        /* Handle PECOFF w/ Authenticode, only ... */
+        pe = pecoff_image_decode(imageBase, imageSize);
+        if (pe && pe->iddc.dd && pe->iddc.dd->CertificateTable.VirtualAddress)
+        {
+            ++numSigned;
+            pecoff_setup_verify(pe);
+            ret = verify_openssl(pe, TrustedCert, sizeof(TrustedCert));
+
+            /* if all is well ... */
+            if (1 == ret)
+            {
+                coff_header_t *ch = pe->chc.ch;
+                unsigned x;
+
+                ++numPassed; /* success! */
+
+                /* point to text executable */
+                for (x = 0; x < ch->NumberOfSections; ++x)
+                {
+                    pecoff_section_t *s = pe->sectioncs[x].s;
+                    if (
+                        (s->Name[0] == '.') &&
+                        (s->Name[1] == 't') &&
+                        (s->Name[2] == 'e') &&
+                        (s->Name[3] == 'x') &&
+                        (s->Name[4] == 't')
+                    )
+                    {
+                        /* Adjust segment info for proper load */
+                        uint8_t *p = (uint8_t *)segment->buf.h.p;
+                        /* adjust to point to start of .text */
+                        p += s->PointerToRawData;
+                        segment->buf.h.p = p;
+                        /* adjust size accordingly */
+                        segment->buf_size -= s->PointerToRawData;
+                    }
+                }
+            }
+        }
+        if (pe) pecoff_image_free(pe);
+        if (imageBase) xfree(imageBase);
+    }
+    printk("KEXEC_file_load signed %d passed %d\n", numSigned, numPassed);
+
+    if (! ((numPassed == numSigned) && (numSigned > 0)) )
+        ret = -ENOEXEC;
+    else
+        ret = kimage_alloc(&kimage, load.type, load.arch, load.entry_maddr,
+                       load.nr_segments, segments);
+
+    if ( ret < 0 )
+        goto error;
+
+    ret = kimage_load_segments(kimage);
+    if ( ret < 0 )
+        goto error;
+
+    ret = kexec_load_slot(kimage);
+    if ( ret < 0 )
+        goto error;
+
+    return 0;
+
+error:
+    if ( ! kimage )
+        xfree(segments);
+    kimage_free(kimage);
+    return ret;
+}
+
 static int kexec_do_unload(xen_kexec_unload_t *unload)
 {
     struct kexec_image *old_kimage;
@@ -1237,8 +1361,11 @@ static int do_kexec_op_internal(unsigned long op,
         ret = kexec_unload(uarg);
         break;
     case KEXEC_CMD_kexec_status:
-	ret = kexec_status(uarg);
-	break;
+	    ret = kexec_status(uarg);
+    	break;
+    case KEXEC_CMD_kexec_file_load:
+        ret = kexec_file_load(uarg);
+        break;
     }
 
     spin_unlock(&kexec_op_spinlock);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
