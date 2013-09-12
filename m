Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKD4j-0005Hx-0R
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 20:01:14 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 4/5] kexec/xen: switch to use xc_kexec_get_range for
 get_xen_vmcoreinfo.
Date: Thu, 12 Sep 2013 21:00:41 +0100
Message-ID: <1379016042-22510-5-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
References: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Don Slutz <Don@CloudSwitch.com>

From: Don Slutz <Don@CloudSwitch.com>

Signed-off-by: Don Slutz <Don@CloudSwitch.com>
Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 kexec/crashdump-xen.c |   25 +++++++++++++++++++++++++
 kexec/crashdump.c     |    5 -----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index 4a5cd8a..b08220e 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -164,6 +164,26 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
 }
 
 #ifdef HAVE_LIBXENCTRL
+int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	xc_interface *xc;
+	int ret = 0;
+
+	xc = xc_interface_open(NULL, NULL, 0);
+	if (!xc) {
+	        fprintf(stderr, "failed to open xen control interface.\n");
+	        return -1;
+	}
+
+	ret = xc_kexec_get_range(xc, KEXEC_RANGE_MA_VMCOREINFO, 0, len, addr);
+
+	xc_interface_close(xc);
+
+	if (ret < 0)
+	        return -1;
+	return 0;
+}
+
 int xen_get_nr_phys_cpus(void)
 {
 	xc_interface *xc;
@@ -206,6 +226,11 @@ int xen_get_nr_phys_cpus(void)
 	return cpu;
 }
 #else
+int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	return -1;
+}
+
 int xen_get_nr_phys_cpus(void)
 {
 	return -1;
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 8d88fdf..131e624 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -157,8 +157,3 @@ int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
 	return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
 }
-
-int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
-{
-	return get_vmcoreinfo("/sys/hypervisor/vmcoreinfo", addr, len);
-}
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
