Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJggM-0006oA-OC
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 16:57:40 +0000
Received: from EX13MTAUEB002.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS
 id 8836DA305F
 for <kexec@lists.infradead.org>; Wed,  1 Apr 2020 16:57:23 +0000 (UTC)
From: Varad Gautam <vrd@amazon.de>
Subject: [PATCH v2 1/3] kexec-xen: Introduce xen_get_kexec_range to wrap
 xc_kexec_get_range
Date: Wed, 1 Apr 2020 18:57:15 +0200
Message-ID: <1585760237-26924-1-git-send-email-vrd@amazon.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Varad Gautam <vrd@amazon.de>, dwmw@amazon.co.uk

And convert all callers of xc_kexec_get_range to use this. Allows reusing
sanity checks for other KEXEC_RANGEs

v2: define xen_get_kexec_range outside of HAVE_LIBXENCTRL

Signed-off-by: Varad Gautam <vrd@amazon.de>
---
 kexec/crashdump-xen.c | 38 +++++---------------------------------
 kexec/kexec-xen.c     | 32 ++++++++++++++++++++++++++++++++
 kexec/kexec-xen.h     |  4 ++++
 3 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index 2d6b2f9..3f59a0d 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -162,21 +162,15 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
 #ifdef HAVE_LIBXENCTRL
 int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
-	xc_interface *xc;
+	uint64_t end;
 	int ret = 0;
 
-	xc = xc_interface_open(NULL, NULL, 0);
-	if (!xc) {
-	        fprintf(stderr, "failed to open xen control interface.\n");
+	ret = xen_get_kexec_range(KEXEC_RANGE_MA_VMCOREINFO, addr, &end);
+	if (ret < 0)
 	        return -1;
-	}
-
-	ret = xc_kexec_get_range(xc, KEXEC_RANGE_MA_VMCOREINFO, 0, len, addr);
 
-	xc_interface_close(xc);
+	*len = end - *addr + 1;
 
-	if (ret < 0)
-	        return -1;
 	return 0;
 }
 
@@ -252,29 +246,7 @@ int xen_get_note(int cpu, uint64_t *addr, uint64_t *len)
 #ifdef HAVE_LIBXENCTRL
 int xen_get_crashkernel_region(uint64_t *start, uint64_t *end)
 {
-	uint64_t size;
-	xc_interface *xc;
-	int rc = -1;
-
-	xc = xc_interface_open(NULL, NULL, 0);
-	if (!xc) {
-		fprintf(stderr, "failed to open xen control interface.\n");
-		goto out;
-	}
-
-	rc = xc_kexec_get_range(xc, KEXEC_RANGE_MA_CRASH, 0, &size, start);
-	if (rc < 0) {
-		fprintf(stderr, "failed to get crash region from hypervisor.\n");
-		goto out_close;
-	}
-
-	*end = *start + size - 1;
-
-out_close:
-	xc_interface_close(xc);
-
-out:
-	return rc;
+	return xen_get_kexec_range(KEXEC_RANGE_MA_CRASH, start, end);
 }
 #else
 int xen_get_crashkernel_region(uint64_t *start, uint64_t *end)
diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index c326955..afcfc5b 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -64,6 +64,33 @@ int __xc_interface_close(xc_interface *xch)
 }
 #endif /* CONFIG_LIBXENCTRL_DL */
 
+int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end)
+{
+	uint64_t size;
+	xc_interface *xc;
+	int rc = -1;
+
+	xc = xc_interface_open(NULL, NULL, 0);
+	if (!xc) {
+		fprintf(stderr, "failed to open xen control interface.\n");
+		goto out;
+	}
+
+	rc = xc_kexec_get_range(xc, range, 0, &size, start);
+	if (rc < 0) {
+		fprintf(stderr, "failed to get range=%d from hypervisor.\n", range);
+		goto out_close;
+	}
+
+	*end = *start + size - 1;
+
+out_close:
+	xc_interface_close(xc);
+
+out:
+	return rc;
+}
+
 #define IDENTMAP_1MiB (1024 * 1024)
 
 int xen_kexec_load(struct kexec_info *info)
@@ -226,6 +253,11 @@ void xen_kexec_exec(void)
 
 #else /* ! HAVE_LIBXENCTRL */
 
+int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end)
+{
+	return -1;
+}
+
 int xen_kexec_load(struct kexec_info *UNUSED(info))
 {
 	return -1;
diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
index ae67393..94d22cd 100644
--- a/kexec/kexec-xen.h
+++ b/kexec/kexec-xen.h
@@ -63,6 +63,10 @@ extern int __xc_interface_close(xc_interface *xch);
 	__xc_call(void *, xc_hypercall_buffer_array_destroy, args)
 
 #endif /* CONFIG_LIBXENCTRL_DL */
+
+
 #endif /* HAVE_LIBXENCTRL */
 
+int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
+
 #endif /* KEXEC_XEN_H */
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
