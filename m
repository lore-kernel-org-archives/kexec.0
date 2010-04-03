Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=x200.localdomain)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nxs9u-0003qM-Vy
	for kexec@lists.infradead.org; Sat, 03 Apr 2010 01:28:23 +0000
Message-Id: <20100403012751.834020949@sous-sol.org>
Date: Fri, 02 Apr 2010 18:27:51 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 0/4] AMD IOMMU kdump fix plus cleanups (v2)
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

Series includes the following patches:

  x86/amd-iommu: enable iommu before attaching devices
  x86/amd-iommu: warn when issuing command to uninitialized cmd buffer
  Revert "x86: disable IOMMUs on kernel crash"
  x86/amd-iommu: use for_each_pci_dev

First one is the primary bug fix.

v2
- add disable_iommus on failure path
- move removal of CMD_BUFFER_UNINITIALIZED to iommu_enable_command_buffer()
- fix ";;" typo in patch 2
- add Revert "x86: disable IOMMUs on kernel crash"
- add x86/amd-iommu: use for_each_pci_dev

thanks,
-chris

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
