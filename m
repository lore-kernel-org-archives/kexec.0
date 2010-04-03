Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=x200.localdomain)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nxs9u-0003qk-W4
	for kexec@lists.infradead.org; Sat, 03 Apr 2010 01:28:24 +0000
Message-Id: <20100403012814.543517900@sous-sol.org>
Date: Fri, 02 Apr 2010 18:27:52 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 1/4] x86/amd-iommu: enable iommu before attaching devices
References: <20100403012751.834020949@sous-sol.org>
Content-Disposition: inline; filename=amd-enable-iommu-earlier.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com

Hit another kdump problem as reported by Neil Horman.  When initializaing
the IOMMU, we attach devices to their domains before the IOMMU is
fully (re)initialized.  Attaching a device will issue some important
invalidations.  In the context of the newly kexec'd kdump kernel, the
IOMMU may have stale cached data from the original kernel.  Because we
do the attach too early, the invalidation commands are placed in the new
command buffer before the IOMMU is updated w/ that buffer.  This leaves
the stale entries in the kdump context and can renders device unusable.
Simply enable the IOMMU before we do the attach.

Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/x86/kernel/amd_iommu_init.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/amd_iommu_init.c
+++ b/arch/x86/kernel/amd_iommu_init.c
@@ -1288,6 +1288,8 @@ static int __init amd_iommu_init(void)
 	if (ret)
 		goto free;
 
+	enable_iommus();
+
 	if (iommu_pass_through)
 		ret = amd_iommu_init_passthrough();
 	else
@@ -1300,8 +1302,6 @@ static int __init amd_iommu_init(void)
 
 	amd_iommu_init_notifier();
 
-	enable_iommus();
-
 	if (iommu_pass_through)
 		goto out;
 
@@ -1315,6 +1315,7 @@ out:
 	return ret;
 
 free:
+	disable_iommus();
 
 	amd_iommu_uninit_devices();
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
