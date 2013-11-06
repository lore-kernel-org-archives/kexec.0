Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ve4Re-0002KA-V1
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 14:51:00 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 2/9] kexec: add public interface for improved load/unload
 sub-ops
Date: Wed, 6 Nov 2013 14:49:39 +0000
Message-ID: <1383749386-11891-3-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>

From: David Vrabel <david.vrabel@citrix.com>

Add replacement KEXEC_CMD_load and KEXEC_CMD_unload sub-ops to the
kexec hypercall.  These new sub-ops allow a priviledged guest to
provide the image data to be loaded into Xen memory or the crash
region instead of guests loading the image data themselves and
providing the relocation code and metadata.

The old interface is provided to guests requesting an interface
version prior to 4.4.

Bump __XEN_LATEST_INTERFACE_VERSION__ to 0x00040400.

Signed-off: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
 xen/common/kexec.c              |   12 +++---
 xen/include/public/kexec.h      |   92 +++++++++++++++++++++++++++++++++++++--
 xen/include/public/xen-compat.h |    2 +-
 3 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index 7cd151f..7b23df0 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -734,7 +734,7 @@ static void crash_save_vmcoreinfo(void)
 #endif
 }
 
-static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
+static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_v1_t *load)
 {
     xen_kexec_image_t *image;
     int base, bit, pos;
@@ -781,7 +781,7 @@ static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
 
 static int kexec_load_unload(unsigned long op, XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
-    xen_kexec_load_t load;
+    xen_kexec_load_v1_t load;
 
     if ( unlikely(copy_from_guest(&load, uarg, 1)) )
         return -EFAULT;
@@ -793,8 +793,8 @@ static int kexec_load_unload_compat(unsigned long op,
                                     XEN_GUEST_HANDLE_PARAM(void) uarg)
 {
 #ifdef CONFIG_COMPAT
-    compat_kexec_load_t compat_load;
-    xen_kexec_load_t load;
+    compat_kexec_load_v1_t compat_load;
+    xen_kexec_load_v1_t load;
 
     if ( unlikely(copy_from_guest(&compat_load, uarg, 1)) )
         return -EFAULT;
@@ -866,8 +866,8 @@ static int do_kexec_op_internal(unsigned long op,
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
index 36409ff..a6a0a88 100644
--- a/xen/include/public/kexec.h
+++ b/xen/include/public/kexec.h
@@ -105,6 +105,20 @@ typedef struct xen_kexec_image {
  * Perform kexec having previously loaded a kexec or kdump kernel
  * as appropriate.
  * type == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
+ *
+ * Control is transferred to the image entry point with the host in
+ * the following state.
+ *
+ * - The image may be executed on any PCPU and all other PCPUs are
+ *   stopped.
+ *
+ * - Local interrupts are disabled.
+ *
+ * - Register values are undefined.
+ *
+ * - The image segments have writeable 1:1 virtual to machine
+ *   mappings.  The location of any page tables is undefined and these
+ *   page table frames are not be mapped.
  */
 #define KEXEC_CMD_kexec                 0
 typedef struct xen_kexec_exec {
@@ -116,12 +130,12 @@ typedef struct xen_kexec_exec {
  * type  == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
  * image == relocation information for kexec (ignored for unload) [in]
  */
-#define KEXEC_CMD_kexec_load            1
-#define KEXEC_CMD_kexec_unload          2
-typedef struct xen_kexec_load {
+#define KEXEC_CMD_kexec_load_v1         1 /* obsolete since 0x00040400 */
+#define KEXEC_CMD_kexec_unload_v1       2 /* obsolete since 0x00040400 */
+typedef struct xen_kexec_load_v1 {
     int type;
     xen_kexec_image_t image;
-} xen_kexec_load_t;
+} xen_kexec_load_v1_t;
 
 #define KEXEC_RANGE_MA_CRASH      0 /* machine address and size of crash area */
 #define KEXEC_RANGE_MA_XEN        1 /* machine address and size of Xen itself */
@@ -152,6 +166,76 @@ typedef struct xen_kexec_range {
     unsigned long start;
 } xen_kexec_range_t;
 
+#if __XEN_INTERFACE_VERSION__ >= 0x00040400
+/*
+ * A contiguous chunk of a kexec image and it's destination machine
+ * address.
+ */
+typedef struct xen_kexec_segment {
+    union {
+        XEN_GUEST_HANDLE(const_void) h;
+        uint64_t _pad;
+    } buf;
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
+ *
+ * All image segments will be loaded to their destination machine
+ * addresses prior to being executed.  The trailing portion of any
+ * segments with a source buffer (from dest_maddr + buf_size to
+ * dest_maddr + dest_size) will be zeroed.
+ *
+ * Segments with no source buffer will be accessible to the image when
+ * it is executed.
+ */
+
+#define KEXEC_CMD_kexec_load 4
+typedef struct xen_kexec_load {
+    uint8_t  type;        /* One of KEXEC_TYPE_* */
+    uint8_t  _pad;
+    uint16_t arch;        /* ELF machine type (EM_*). */
+    uint32_t nr_segments;
+    union {
+        XEN_GUEST_HANDLE(xen_kexec_segment_t) h;
+        uint64_t _pad;
+    } segments;
+    uint64_t entry_maddr; /* image entry point machine address. */
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
+#else /* __XEN_INTERFACE_VERSION__ < 0x00040400 */
+
+#define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
+#define KEXEC_CMD_kexec_unload KEXEC_CMD_kexec_unload_v1
+#define xen_kexec_load xen_kexec_load_v1
+#define xen_kexec_load_t xen_kexec_load_v1_t
+
+#endif
+
 #endif /* _XEN_PUBLIC_KEXEC_H */
 
 /*
diff --git a/xen/include/public/xen-compat.h b/xen/include/public/xen-compat.h
index 69141c4..3eb80a0 100644
--- a/xen/include/public/xen-compat.h
+++ b/xen/include/public/xen-compat.h
@@ -27,7 +27,7 @@
 #ifndef __XEN_PUBLIC_XEN_COMPAT_H__
 #define __XEN_PUBLIC_XEN_COMPAT_H__
 
-#define __XEN_LATEST_INTERFACE_VERSION__ 0x00040300
+#define __XEN_LATEST_INTERFACE_VERSION__ 0x00040400
 
 #if defined(__XEN__) || defined(__XEN_TOOLS__)
 /* Xen is built with matching headers and implements the latest interface. */
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
