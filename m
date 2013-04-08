Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPHPb-0007Ih-Gl
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 19:07:29 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 4/5] kexec/xen: switch to use xc_kexec_get_range for
 get_xen_vmcoreinfo.
Date: Mon, 8 Apr 2013 20:06:53 +0100
Message-ID: <1365448014-12119-5-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
References: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
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
 kexec/crashdump-xen.c |   20 ++++++++++++++++++++
 kexec/crashdump.c     |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index 13335a5..dfb86c8 100644
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
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index cdd3ef6..b8441b7 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -141,7 +141,9 @@ int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 	return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
 }
 
+#ifndef HAVE_LIBXENCTRL
 int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
 	return get_vmcoreinfo("/sys/hypervisor/vmcoreinfo", addr, len);
 }
+#endif
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
