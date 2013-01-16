Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvVrd-0005na-Mi
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 16:29:22 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 2/3] kexec: remove kexec_load and kexec_unload ops
Date: Wed, 16 Jan 2013 16:29:05 +0000
Message-ID: <1358353746-1899-3-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Eric Biederman <ebiederm@xmission.com>

From: David Vrabel <david.vrabel@citrix.com>

The KEXEC_CMD_kexec_load and KEXEC_CMD_kexec_unload are obsoleted by
KEXEC_CMD_kexec_load_v2 and KEXEC_CMD_kexec_load_v2.

The kexec hypercall is for use by dom0 and the toolstack so we remove
support for them completely.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/common/kexec.c         |   91 +-------------------------------------------
 xen/include/public/kexec.h |   27 +------------
 xen/include/xlat.lst       |    1 -
 3 files changed, 2 insertions(+), 117 deletions(-)

diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index 56bf8b4..a3ddbbc 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -742,87 +742,6 @@ static void kexec_unload_slot(int slot)
     }
 }
 
-static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
-{
-    struct kexec_image *image;
-    int base, bit, pos;
-    int ret = 0;
-
-    if ( kexec_load_get_bits(load->type, &base, &bit) )
-        return -EINVAL;
-
-    pos = (test_bit(bit, &kexec_flags) != 0);
-
-    /* Load the user data into an unused image */
-    if ( op == KEXEC_CMD_kexec_load )
-    {
-        image = &kexec_image[base + !pos];
-
-        BUG_ON(test_bit((base + !pos), &kexec_flags)); /* must be free */
-
-        if ( is_pv_32on64_domain(dom0) )
-            image->class = KEXEC_CLASS_32;
-        else
-            image->class = KEXEC_CLASS_64;
-        image->entry_maddr = load->image.start_address;
-
-        if ( !(ret = machine_kexec_load(image)) )
-        {
-            /* Set image present bit */
-            set_bit((base + !pos), &kexec_flags);
-
-            /* Make new image the active one */
-            change_bit(bit, &kexec_flags);
-        }
-
-        crash_save_vmcoreinfo();
-    }
-
-    /* Unload the old image if present and load successful */
-    if ( ret == 0 && !test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
-    {
-        kexec_unload_slot(base + pos);
-    }
-
-    return ret;
-}
-
-static int kexec_load_unload(unsigned long op, XEN_GUEST_HANDLE_PARAM(void) uarg)
-{
-    xen_kexec_load_t load;
-
-    if ( unlikely(copy_from_guest(&load, uarg, 1)) )
-        return -EFAULT;
-
-    return kexec_load_unload_internal(op, &load);
-}
-
-static int kexec_load_unload_compat(unsigned long op,
-                                    XEN_GUEST_HANDLE_PARAM(void) uarg)
-{
-#ifdef CONFIG_COMPAT
-    compat_kexec_load_t compat_load;
-    xen_kexec_load_t load;
-
-    if ( unlikely(copy_from_guest(&compat_load, uarg, 1)) )
-        return -EFAULT;
-
-    /* This is a bit dodgy, load.image is inside load,
-     * but XLAT_kexec_load (which is automatically generated)
-     * doesn't translate load.image (correctly)
-     * Just copy load->type, the only other member, manually instead.
-     *
-     * XLAT_kexec_load(&load, &compat_load);
-     */
-    load.type = compat_load.type;
-    XLAT_kexec_image(&load.image, &compat_load.image);
-
-    return kexec_load_unload_internal(op, &load);
-#else /* CONFIG_COMPAT */
-    return 0;
-#endif /* CONFIG_COMPAT */
-}
-
 static int kexec_exec(XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
     xen_kexec_exec_t exec;
@@ -1035,15 +954,7 @@ static int do_kexec_op_internal(unsigned long op,
         break;
     case KEXEC_CMD_kexec_load:
     case KEXEC_CMD_kexec_unload:
-        spin_lock_irqsave(&kexec_lock, flags);
-        if (!test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags))
-        {
-                if (compat)
-                        ret = kexec_load_unload_compat(op, uarg);
-                else
-                        ret = kexec_load_unload(op, uarg);
-        }
-        spin_unlock_irqrestore(&kexec_lock, flags);
+        ret = -ENOSYS;
         break;
     case KEXEC_CMD_kexec:
         ret = kexec_exec(uarg);
diff --git a/xen/include/public/kexec.h b/xen/include/public/kexec.h
index 4b7d637..7f2028f 100644
--- a/xen/include/public/kexec.h
+++ b/xen/include/public/kexec.h
@@ -86,23 +86,6 @@
 #define KEXEC_CLASS_32   1 /* 32-bit image. */
 #define KEXEC_CLASS_64   2 /* 64-bit image. */
 
-/* The kexec implementation for Xen allows the user to load two
- * types of kernels, KEXEC_TYPE_DEFAULT and KEXEC_TYPE_CRASH.
- * All data needed for a kexec reboot is kept in one xen_kexec_image_t
- * per "instance". The data mainly consists of machine address lists to pages
- * together with destination addresses. The data in xen_kexec_image_t
- * is passed to the "code page" which is one page of code that performs
- * the final relocations before jumping to the new kernel.
- */
- 
-typedef struct xen_kexec_image {
-#if defined(__i386__) || defined(__x86_64__)
-    unsigned long page_list[KEXEC_XEN_NO_PAGES];
-#endif
-    unsigned long indirection_page;
-    unsigned long start_address;
-} xen_kexec_image_t;
-
 /*
  * Perform kexec having previously loaded a kexec or kdump kernel
  * as appropriate.
@@ -113,17 +96,9 @@ typedef struct xen_kexec_exec {
     int type;
 } xen_kexec_exec_t;
 
-/*
- * Load/Unload kernel image for kexec or kdump.
- * type  == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
- * image == relocation information for kexec (ignored for unload) [in]
- */
+/* Obsolete: uses kexec_load_v2 and kexec_unload_v2 instead. */
 #define KEXEC_CMD_kexec_load            1
 #define KEXEC_CMD_kexec_unload          2
-typedef struct xen_kexec_load {
-    int type;
-    xen_kexec_image_t image;
-} xen_kexec_load_t;
 
 #define KEXEC_RANGE_MA_CRASH      0 /* machine address and size of crash area */
 #define KEXEC_RANGE_MA_XEN        1 /* machine address and size of Xen itself */
diff --git a/xen/include/xlat.lst b/xen/include/xlat.lst
index 3d4f1e3..e2e05fe 100644
--- a/xen/include/xlat.lst
+++ b/xen/include/xlat.lst
@@ -52,7 +52,6 @@
 ?	grant_entry_v2			grant_table.h
 ?	gnttab_swap_grant_ref		grant_table.h
 ?	kexec_exec			kexec.h
-!	kexec_image			kexec.h
 !	kexec_range			kexec.h
 !	add_to_physmap			memory.h
 !	foreign_memory_map		memory.h
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
