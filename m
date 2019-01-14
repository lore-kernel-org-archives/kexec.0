Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DY-0000Hp-AL
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:20 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 1/8] kexec: add kexec_file_load to libxenctrl
Date: Mon, 14 Jan 2019 13:47:58 -0600
Message-Id: <1547495285-28907-2-git-send-email-eric.devolder@oracle.com>
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

This change adds a new entry point in libxenctrl for the
kexec_file_load() operation. The code for kexec_file_load() is nearly
identical to kexec_load() other than the use of hypercall op
KEXEC_CMD_kexec_file_load rather than KEXEC_CMD_kexec_load.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 tools/libxc/xc_kexec.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 tools/libxc/xenctrl.h      |  4 ++++
 xen/include/public/kexec.h |  4 +++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/libxc/xc_kexec.c b/tools/libxc/xc_kexec.c
index 5003556..10762af 100644
--- a/tools/libxc/xc_kexec.c
+++ b/tools/libxc/xc_kexec.c
@@ -112,6 +112,47 @@ out:
     return ret;
 }
 
+int xc_kexec_file_load(xc_interface *xch, uint8_t type, uint16_t arch,
+                  uint64_t entry_maddr,
+                  uint32_t nr_segments, xen_kexec_segment_t *segments)
+{
+    int ret = -1;
+    DECLARE_HYPERCALL;
+    DECLARE_HYPERCALL_BOUNCE(segments, sizeof(*segments) * nr_segments,
+                             XC_HYPERCALL_BUFFER_BOUNCE_IN);
+    DECLARE_HYPERCALL_BUFFER(xen_kexec_load_t, load);
+
+    if ( xc_hypercall_bounce_pre(xch, segments) )
+    {
+        PERROR("Could not allocate bounce buffer for kexec load hypercall");
+        goto out;
+    }
+    load = xc_hypercall_buffer_alloc(xch, load, sizeof(*load));
+    if ( load == NULL )
+    {
+        PERROR("Could not allocate buffer for kexec load hypercall");
+        goto out;
+    }
+
+    load->type = type;
+    load->arch = arch;
+    load->entry_maddr = entry_maddr;
+    load->nr_segments = nr_segments;
+    set_xen_guest_handle(load->segments.h, segments);
+
+    hypercall.op = __HYPERVISOR_kexec_op;
+    hypercall.arg[0] = KEXEC_CMD_kexec_file_load; // only difference with xc_kexec_load()
+    hypercall.arg[1] = HYPERCALL_BUFFER_AS_ARG(load);
+
+    ret = do_xen_hypercall(xch, &hypercall);
+
+out:
+    xc_hypercall_buffer_free(xch, load);
+    xc_hypercall_bounce_post(xch, segments);
+
+    return ret;
+}
+
 int xc_kexec_unload(xc_interface *xch, int type)
 {
     DECLARE_HYPERCALL;
diff --git a/tools/libxc/xenctrl.h b/tools/libxc/xenctrl.h
index f61a61c..6243e5a 100644
--- a/tools/libxc/xenctrl.h
+++ b/tools/libxc/xenctrl.h
@@ -2488,6 +2488,10 @@ int xc_kexec_load(xc_interface *xch, uint8_t type, uint16_t arch,
                   uint64_t entry_maddr,
                   uint32_t nr_segments, xen_kexec_segment_t *segments);
 
+int xc_kexec_file_load(xc_interface *xch, uint8_t type, uint16_t arch,
+                  uint64_t entry_maddr,
+                  uint32_t nr_segments, xen_kexec_segment_t *segments);
+
 /*
  * Unload a kexec image.
  *
diff --git a/xen/include/public/kexec.h b/xen/include/public/kexec.h
index 022e160..eae98d4 100644
--- a/xen/include/public/kexec.h
+++ b/xen/include/public/kexec.h
@@ -203,6 +203,7 @@ DEFINE_XEN_GUEST_HANDLE(xen_kexec_segment_t);
  */
 
 #define KEXEC_CMD_kexec_load 4
+#define KEXEC_CMD_kexec_file_load 7
 typedef struct xen_kexec_load {
     uint8_t  type;        /* One of KEXEC_TYPE_* */
     uint8_t  _pad;
@@ -213,8 +214,9 @@ typedef struct xen_kexec_load {
         uint64_t _pad;
     } segments;
     uint64_t entry_maddr; /* image entry point machine address. */
-} xen_kexec_load_t;
+} xen_kexec_load_t, xen_kexec_file_load_t;
 DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_t);
+DEFINE_XEN_GUEST_HANDLE(xen_kexec_file_load_t);
 
 /*
  * Unload a kexec image.
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
