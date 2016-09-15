Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYCh-0007If-Ht
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:03:59 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 0/8] Fix kdump faults on system with amd iommu
Date: Thu, 15 Sep 2016 23:03:18 +0800
Message-Id: <1473951806-25511-1-git-send-email-bhe@redhat.com>
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
To: joro@8bytes.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

This is v5 post. In fact in v3 the solution is correct. Just unluckily 
I got a AMD machine with bnx2 NIC which can't reset itself during driver
init. It made me very unconfident with my understanding about the fix.
Now with below fix the AMD machine with bnx2 NIC can also work well
to dump and there's no IO_PAGE_FAULT seen any more. Now network maintainer
has picked it up.

bnx2: Reset device during driver initialization
https://www.mail-archive.com/netdev@vger.kernel.org/msg127336.html

The principle of the fix is similar to intel iommu. Just defer the assignment
of device to domain to device driver init. But there's difference than
intel iommu. AMD iommu create protection domain and assign device to
domain in iommu driver init stage. So in this patchset I just allow the
assignment of device to domain in software level, but defer updating the
domain info, especially the pte_root to dev table entry to device driver
init stage.


Baoquan He (8):
  iommu/amd: Detect pre enabled translation
  iommu/amd: add early_enable_iommu() wrapper function
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables
  iommu/amd: copy old trans table from old kernel
  iommu/amd: Do not re-enable dev table entries in kdump
  iommu/amd: Don't update domain info to dte entry at iommu init stage
  iommu/amd: Update domain into to dte entry during device driver init

 drivers/iommu/amd_iommu.c       |  49 +++++++++++++--
 drivers/iommu/amd_iommu_init.c  | 135 ++++++++++++++++++++++++++++++++++++----
 drivers/iommu/amd_iommu_proto.h |   1 +
 drivers/iommu/amd_iommu_types.h |  23 +++++--
 4 files changed, 187 insertions(+), 21 deletions(-)

-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
