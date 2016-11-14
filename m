Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6PVK-00008B-PK
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 22:13:32 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v1 1/2] xen/kexec: Find out whether an kexec type is loaded.
Date: Mon, 14 Nov 2016 17:12:52 -0500
Message-Id: <1479161573-12671-2-git-send-email-konrad.wilk@oracle.com>
In-Reply-To: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
References: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
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
To: david.vrabel@citrix.com, xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: elena.ufimtseva@oracle.com, daniel.kiper@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

The tools that use kexec are asynchronous in nature and do
not keep state changes. As such provide an hypercall to find
out whether an image has been loaded for either type.

Note: No need to modify XSM as it has one size fits all
check and does not check for subcommands.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v0: Internal version.
v1: Dropped Reviewed-by, posting on xen-devel.

CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>
CC: Daniel Kiper <daniel.kiper@oracle.com>
---
 tools/libxc/include/xenctrl.h |  8 ++++++++
 tools/libxc/xc_kexec.c        | 27 +++++++++++++++++++++++++++
 xen/common/kexec.c            | 25 +++++++++++++++++++++++++
 xen/include/public/kexec.h    | 11 +++++++++++
 4 files changed, 71 insertions(+)

diff --git a/tools/libxc/include/xenctrl.h b/tools/libxc/include/xenctrl.h
index 2c83544..aa5d798 100644
--- a/tools/libxc/include/xenctrl.h
+++ b/tools/libxc/include/xenctrl.h
@@ -2574,6 +2574,14 @@ int xc_kexec_load(xc_interface *xch, uint8_t type, uint16_t arch,
  */
 int xc_kexec_unload(xc_interface *xch, int type);
 
+/*
+ * Find out whether the image has been succesfully loaded.
+ *
+ * The can be either KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.
+ * If zero is returned that means the image is loaded for the type.
+ */
+int xc_kexec_status(xc_interface *xch, int type);
+
 typedef xenpf_resource_entry_t xc_resource_entry_t;
 
 /*
diff --git a/tools/libxc/xc_kexec.c b/tools/libxc/xc_kexec.c
index 1cceb5d..95d36ff 100644
--- a/tools/libxc/xc_kexec.c
+++ b/tools/libxc/xc_kexec.c
@@ -126,3 +126,30 @@ out:
 
     return ret;
 }
+
+int xc_kexec_status(xc_interface *xch, int type)
+{
+    DECLARE_HYPERCALL;
+    DECLARE_HYPERCALL_BUFFER(xen_kexec_status_t, status);
+    int ret = -1;
+
+    status = xc_hypercall_buffer_alloc(xch, status, sizeof(*status));
+    if ( status == NULL )
+    {
+        PERROR("Count not alloc buffer for kexec status hypercall");
+        goto out;
+    }
+
+    status->type = type;
+
+    hypercall.op = __HYPERVISOR_kexec_op;
+    hypercall.arg[0] = KEXEC_CMD_kexec_status;
+    hypercall.arg[1] = HYPERCALL_BUFFER_AS_ARG(status);
+
+    ret = do_xen_hypercall(xch, &hypercall);
+
+out:
+    xc_hypercall_buffer_free(xch, status);
+
+    return ret;
+}
diff --git a/xen/common/kexec.c b/xen/common/kexec.c
index c83d48f..1148f85 100644
--- a/xen/common/kexec.c
+++ b/xen/common/kexec.c
@@ -1169,6 +1169,28 @@ static int kexec_unload(XEN_GUEST_HANDLE_PARAM(void) uarg)
     return kexec_do_unload(&unload);
 }
 
+static int kexec_status(XEN_GUEST_HANDLE_PARAM(void) uarg)
+{
+    xen_kexec_status_t status;
+    int base, bit, pos;
+
+    if ( unlikely(copy_from_guest(&status, uarg, 1)) )
+        return -EFAULT;
+
+    if ( test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
+        return -EBUSY;
+
+    if ( kexec_load_get_bits(status.type, &base, &bit) )
+        return -EINVAL;
+
+    pos = (test_bit(bit, &kexec_flags) != 0);
+
+    if ( !test_bit(base + pos, &kexec_flags) )
+        return -ENOENT;
+
+    return 0;
+}
+
 static int do_kexec_op_internal(unsigned long op,
                                 XEN_GUEST_HANDLE_PARAM(void) uarg,
                                 bool_t compat)
@@ -1208,6 +1230,9 @@ static int do_kexec_op_internal(unsigned long op,
     case KEXEC_CMD_kexec_unload:
         ret = kexec_unload(uarg);
         break;
+    case KEXEC_CMD_kexec_status:
+	ret = kexec_status(uarg);
+	break;
     }
 
     return ret;
diff --git a/xen/include/public/kexec.h b/xen/include/public/kexec.h
index a6a0a88..29dcb5d 100644
--- a/xen/include/public/kexec.h
+++ b/xen/include/public/kexec.h
@@ -227,6 +227,17 @@ typedef struct xen_kexec_unload {
 } xen_kexec_unload_t;
 DEFINE_XEN_GUEST_HANDLE(xen_kexec_unload_t);
 
+/*
+ * Figure out whether we have an image loaded. An return value of
+ * zero indicates success while XEN_ENODEV implies no image loaded.
+ *
+ * Type must be one of KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.
+ */
+#define KEXEC_CMD_kexec_status 6
+typedef struct xen_kexec_status {
+    uint8_t type;
+} xen_kexec_status_t;
+DEFINE_XEN_GUEST_HANDLE(xen_kexec_status_t);
 #else /* __XEN_INTERFACE_VERSION__ < 0x00040400 */
 
 #define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
