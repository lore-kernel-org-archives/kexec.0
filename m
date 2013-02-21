Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aFv-00068K-QG
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:48:31 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 3/8] kexec: add public interface for improved load/unload
 sub-ops
Date: Thu, 21 Feb 2013 17:48:09 +0000
Message-ID: <1361468894-18655-4-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Add replacement KEXEC_CMD_load and KEXEC_CMD_unload sub-ops to the
kexec hypercall.  These new sub-ops allow a priviledged guest to
provide the image data to be loaded into Xen memory or the crash
region instead of guests loading the image data themselves and
providing the relocation code and metadata.

The old interface is provided to guests requesting an interface
version prior to 4.3.

Signed-off: David Vrabel <david.vrabel@citrix.com>
---
 xen/common/kexec.c         |   12 ++++----
 xen/include/public/kexec.h |   66 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index 6dd20c6..2cbb62c 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -732,7 +732,7 @@ static void crash_save_vmcoreinfo(void)
 #endif
 }
 
-static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
+static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_v1_t *load)
 {
     xen_kexec_image_t *image;
     int base, bit, pos;
@@ -779,7 +779,7 @@ static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
 
 static int kexec_load_unload(unsigned long op, XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
-    xen_kexec_load_t load;
+    xen_kexec_load_v1_t load;
 
     if ( unlikely(copy_from_guest(&load, uarg, 1)) )
         return -EFAULT;
@@ -791,8 +791,8 @@ static int kexec_load_unload_compat(unsigned long op,
                                     XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
 #ifdef CONFIG_COMPAT
-    compat_kexec_load_t compat_load;
-    xen_kexec_load_t load;
+    compat_kexec_load_v1_t compat_load;
+    xen_kexec_load_v1_t load;
 
     if ( unlikely(copy_from_guest(&compat_load, uarg, 1)) )
         return -EFAULT;
@@ -864,8 +864,8 @@ static int do_kexec_op_internal(unsigned long op,
         else
                 ret = kexec_get_range(uarg);
         break;
-    case KEXEC_CMD_kexec_load:
-    case KEXEC_CMD_kexec_unload:
+    case KEXEC_CMD_kexec_load_v1:
+    case KEXEC_CMD_kexec_unload_v1:
         spin_lock_irqsave(&kexec_lock, flags);
         if (!test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags))
         {
diff --git a/xen/include/public/kexec.h b/xen/include/public/kexec.h
index 61a8d7d..5259446 100644
--- a/xen/include/public/kexec.h
+++ b/xen/include/public/kexec.h
@@ -116,12 +116,12 @@ typedef struct xen_kexec_exec {
  * type  == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
  * image == relocation information for kexec (ignored for unload) [in]
  */
-#define KEXEC_CMD_kexec_load            1
-#define KEXEC_CMD_kexec_unload          2
-typedef struct xen_kexec_load {
+#define KEXEC_CMD_kexec_load_v1         1 /* obsolete since 0x00040300 */
+#define KEXEC_CMD_kexec_unload_v1       2 /* obsolete since 0x00040300 */
+typedef struct xen_kexec_load_v1 {
     int type;
     xen_kexec_image_t image;
-} xen_kexec_load_t;
+} xen_kexec_load_v1_t;
 
 #define KEXEC_RANGE_MA_CRASH      0 /* machine address and size of crash area */
 #define KEXEC_RANGE_MA_XEN        1 /* machine address and size of Xen itself */
@@ -152,6 +152,64 @@ typedef struct xen_kexec_range {
     unsigned long start;
 } xen_kexec_range_t;
 
+#if __XEN_INTERFACE_VERSION__ >= 0x00040300
+/*
+ * A contiguous chunk of a kexec image and it's destination machine
+ * address.
+ */
+typedef struct xen_kexec_segment {
+    XEN_GUEST_HANDLE_64(const_void) buf;
+    uint64_t buf_size;
+    uint64_t dest_maddr;
+    uint64_t dest_size;
+} xen_kexec_segment_t;
+DEFINE_XEN_GUEST_HANDLE(xen_kexec_segment_t);
+
+/*
+ * Load a kexec image into memory.
+ *
+ * For KEXEC_TYPE_DEFAULT images, the segments may be anywhere in RAM.
+ * The image is relocated prior to being executed.
+ *
+ * For KEXEC_TYPE_CRASH images, each segment of the image must reside
+ * in the memory region reserved for kexec (KEXEC_RANGE_MA_CRASH) and
+ * the entry point must be within the image. The caller is responsible
+ * for ensuring that multiple images do not overlap.
+ */
+
+#define KEXEC_CMD_kexec_load 4
+typedef struct xen_kexec_load {
+    uint8_t  type;        /* One of KEXEC_TYPE_* */
+    uint16_t arch;        /* ELF machine type (EM_*). */
+    uint32_t __pad;
+    uint64_t entry_maddr; /* image entry point machine address. */
+    uint32_t nr_segments;
+    XEN_GUEST_HANDLE_64(xen_kexec_segment_t) segments;
+} xen_kexec_load_t;
+DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_t);
+
+/*
+ * Unload a kexec image.
+ *
+ * Type must be one of KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.
+ */
+#define KEXEC_CMD_kexec_unload 5
+typedef struct xen_kexec_unload {
+    uint8_t type;
+} xen_kexec_unload_t;
+DEFINE_XEN_GUEST_HANDLE(xen_kexec_unload_t);
+
+#else /* __XEN_INTERFACE_VERSION__ < 0x00040300 */
+
+#undef KEXEC_CMD_kexec_load
+#undef KEXEC_CMD_kexec_unload
+#define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
+#define KEXEC_CMD_kexec_unload KEXEC_CMD_kexec_unload_v1
+
+typedef struct xen_kexec_load_v1_t xen_kexec_load_t;
+
+#endif
+
 #endif /* _XEN_PUBLIC_KEXEC_H */
 
 /*
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
