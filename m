Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvVrf-0005na-7Y
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 16:29:24 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 3/3] libxc: add API for kexec hypercall
Date: Wed, 16 Jan 2013 16:29:06 +0000
Message-ID: <1358353746-1899-4-git-send-email-david.vrabel@citrix.com>
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

Add xc_kexec_exec(), xc_kexec_get_ranges(), xc_kexec_load(), and
xc_kexec_unload().  The load and unload calls require the v2 load and
unload ops.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 tools/libxc/Makefile   |    1 +
 tools/libxc/xc_kexec.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/libxc/xenctrl.h  |   53 +++++++++++++++++++++
 3 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100644 tools/libxc/xc_kexec.c

diff --git a/tools/libxc/Makefile b/tools/libxc/Makefile
index d44abf9..39badf9 100644
--- a/tools/libxc/Makefile
+++ b/tools/libxc/Makefile
@@ -31,6 +31,7 @@ CTRL_SRCS-y       += xc_mem_access.c
 CTRL_SRCS-y       += xc_memshr.c
 CTRL_SRCS-y       += xc_hcall_buf.c
 CTRL_SRCS-y       += xc_foreign_memory.c
+CTRL_SRCS-y       += xc_kexec.c
 CTRL_SRCS-y       += xtl_core.c
 CTRL_SRCS-y       += xtl_logger_stdio.c
 CTRL_SRCS-$(CONFIG_X86) += xc_pagetab.c
diff --git a/tools/libxc/xc_kexec.c b/tools/libxc/xc_kexec.c
new file mode 100644
index 0000000..ebd55cf
--- /dev/null
+++ b/tools/libxc/xc_kexec.c
@@ -0,0 +1,120 @@
+/******************************************************************************
+ * xc_kexec.c
+ *
+ * API for loading and executing kexec images.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation;
+ * version 2.1 of the License.
+ *
+ * Copyright (C) 2013 Citrix Systems R&D Ltd.
+ */
+#include "xc_private.h"
+
+int xc_kexec(xc_interface *xch, int type)
+{
+    DECLARE_HYPERCALL;
+    DECLARE_HYPERCALL_BUFFER(xen_kexec_exec_t, exec);
+    int ret = -1;
+
+    exec = xc_hypercall_buffer_alloc(xch, exec, sizeof(*exec));
+    if ( exec == NULL )
+    {
+        PERROR("Count not alloc bounce buffer for kexec_exec hypercall");
+        goto out;
+    }
+
+    exec->type = type;
+
+    hypercall.op = __HYPERVISOR_kexec_op;
+    hypercall.arg[0] = KEXEC_CMD_kexec;
+    hypercall.arg[1] = HYPERCALL_BUFFER_AS_ARG(exec);
+
+    ret = do_xen_hypercall(xch, &hypercall);
+
+out:
+    xc_hypercall_buffer_free(xch, exec);
+
+    return ret;
+}
+
+int xc_kexec_get_range(xc_interface *xch, int range,  int nr,
+                       unsigned long *size, unsigned long *start)
+{
+    DECLARE_HYPERCALL;
+    DECLARE_HYPERCALL_BUFFER(xen_kexec_range_t, get_range);
+    int ret = -1;
+
+    get_range = xc_hypercall_buffer_alloc(xch, get_range, sizeof(*get_range));
+    if ( get_range == NULL )
+    {
+        PERROR("Could not alloc bounce buffer for kexec_get_range hypercall");
+        goto out;
+    }
+
+    hypercall.op = __HYPERVISOR_kexec_op;
+    hypercall.arg[0] = KEXEC_CMD_kexec_get_range;
+    hypercall.arg[1] = HYPERCALL_BUFFER_AS_ARG(get_range);
+
+    ret = do_xen_hypercall(xch, &hypercall);
+
+    *size = get_range->size;
+    *start = get_range->start;
+
+out:
+    xc_hypercall_buffer_free(xch, get_range);
+
+    return ret;
+}
+
+int xc_kexec_load(xc_interface *xch, xen_kexec_load_v2_t *load)
+{
+    int ret = -1;
+    DECLARE_HYPERCALL;
+    DECLARE_HYPERCALL_BOUNCE(load, sizeof(*load), XC_HYPERCALL_BUFFER_BOUNCE_IN);
+    
+    if ( xc_hypercall_bounce_pre(xch, load) )
+    {
+        PERROR("Could not alloc bounce buffer for kexec_load_v2 hypercall");
+        goto out;
+    }
+
+    hypercall.op = __HYPERVISOR_kexec_op;
+    hypercall.arg[0] = KEXEC_CMD_kexec_load_v2;
+    hypercall.arg[1] = HYPERCALL_BUFFER_AS_ARG(load);
+
+    ret = do_xen_hypercall(xch, &hypercall);
+
+out:
+    xc_hypercall_bounce_post(xch, load);
+
+    return ret;
+}
+
+int xc_kexec_unload(xc_interface *xch, int type)
+{
+    DECLARE_HYPERCALL;
+    DECLARE_HYPERCALL_BUFFER(xen_kexec_unload_v2_t, unload);
+    int ret = -1;
+
+    unload = xc_hypercall_buffer_alloc(xch, unload, sizeof(*unload));
+    if ( unload == NULL )
+    {
+        PERROR("Count not alloc bounce buffer for kexec_unload_v2 hypercall");
+        goto out;
+    }
+
+    unload->type = type;
+
+    hypercall.op = __HYPERVISOR_kexec_op;
+    hypercall.arg[0] = KEXEC_CMD_kexec_unload_v2;
+    hypercall.arg[1] = HYPERCALL_BUFFER_AS_ARG(unload);
+
+    ret = do_xen_hypercall(xch, &hypercall);
+
+out:
+    xc_hypercall_buffer_free(xch, unload);
+
+    return ret;
+}
diff --git a/tools/libxc/xenctrl.h b/tools/libxc/xenctrl.h
index 32122fd..001f7d1 100644
--- a/tools/libxc/xenctrl.h
+++ b/tools/libxc/xenctrl.h
@@ -46,6 +46,7 @@
 #include <xen/hvm/params.h>
 #include <xen/xsm/flask_op.h>
 #include <xen/tmem.h>
+#include <xen/kexec.h>
 
 #include "xentoollog.h"
 
@@ -2236,4 +2237,56 @@ int xc_compression_uncompress_page(xc_interface *xch, char *compbuf,
 				   unsigned long compbuf_size,
 				   unsigned long *compbuf_pos, char *dest);
 
+/*
+ * Execute an image previously loaded with xc_kexec_load().
+ *
+ * Does not return on success.
+ *
+ * Fails with:
+ *   ENOENT if the specified image has not been loaded.
+ */
+int xc_kexec(xc_interface *xch, int type);
+
+/*
+ * Find the machine address and size of certain memory areas.
+ *
+ * The regions are:
+ *
+ *   KEXEC_RANGE_MA_CRASH       crash area
+ *   KEXEC_RANGE_MA_XEN         Xen itself
+ *   KEXEC_RANGE_MA_CPU         CPU note for CPU number 'nr'
+ *   KEXEC_RANGE_MA_XENHEAP     xenheap
+ *   KEXEC_RANGE_MA_EFI_MEMMAP  EFI Memory Map
+ *   KEXEC_RANGE_MA_VMCOREINFO  vmcoreinfo
+ *
+ * Fails with:
+ *   EINVAL if the range or CPU number isn't valid.
+ */
+int xc_kexec_get_range(xc_interface *xch, int range,  int nr,
+                       unsigned long *size, unsigned long *start);
+
+/*
+ * Load a kexec image into memory.
+ *
+ * The image may be of type KEXEC_TYPE_DEFAULT (executed on request)
+ * or KEXEC_TYPE_CRASH (executed on a crash).
+ *
+ * The image may be 32-bit (KEXEC_CLASS_32) or 64-bit (KEXEC_CLASS_64)
+ * independently of whether the current domain is 32- or 64-bit.
+ *
+ * Fails with:
+ *   EINVAL if the image does not fit into the crash area or the entry
+ *          point isn't within one of segments.
+ *   EBUSY  if another image is being executed.
+ */
+int xc_kexec_load(xc_interface *xch, xen_kexec_load_v2_t *load);
+
+/*
+ * Unload a kexec image.
+ *
+ * This prevents a KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH image from
+ * being executed.  The image is not cleared from memory.
+ */
+int xc_kexec_unload(xc_interface *xch, int type);
+
 #endif /* XENCTRL_H */
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
