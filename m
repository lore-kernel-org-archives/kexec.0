Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxBfQ-0000t3-B7
 for kexec@lists.infradead.org; Thu, 20 Oct 2016 11:37:49 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 0/9] Fix kdump faults on system with amd iommu
Date: Thu, 20 Oct 2016 19:37:11 +0800
Message-Id: <1476963440-23039-1-git-send-email-bhe@redhat.com>
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

This is v6 post. 

The principle of the fix is similar to intel iommu. Just defer the assignment
of device to domain to device driver init. But there's difference than
intel iommu. AMD iommu create protection domain and assign device to
domain in iommu driver init stage. So in this patchset I just allow the
assignment of device to domain in software level, but defer updating the
domain info, especially the pte_root to dev table entry to device driver
init stage.

v5: 
    bnx2 NIC can't reset itself during driver init. Post patch to reset
    it during driver init. IO_PAGE_FAULT can't be seen anymore.
    
    Below is link of v5 post.
    https://lists.linuxfoundation.org/pipermail/iommu/2016-September/018527.html

v5->v6:
    According to Joerg's comments made several below main changes:
    - Add sanity check when copy old dev tables. 

    - Discard the old patch 6/8.

    - If a device is set up with guest translations (DTE.GV=1), then don't
      copy that information but move the device over to an empty guest-cr3
      table and handle the faults in the PPR log (which just answer them
      with INVALID).

Issues need be discussed:
    - Joerg suggested hooking the behaviour that updates domain info into
      dte entry into the set_dma_mask call-back. I tried, but on my local
      machine with amd iommu v2, an ohci pci device doesn't call set_dma_mask.
      Then IO_PAGE_FAULT printing flooded.

      00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller (rev 11)

    - About GCR3 root pointer copying issue, I don't know how to setup the
      test environment and haven't tested yet. Hope Joerg or Zongshun can
      tell what steps should be taken to test it, or help take a test in your
      test environemnt.
 
Baoquan He (9):
  iommu/amd: Detect pre enabled translation
  iommu/amd: add several helper function
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables
  iommu/amd: copy old trans table from old kernel
  iommu/amd: Don't update domain info to dte entry at iommu init stage
  iommu/amd: Update domain into to dte entry during device driver init
  iommu/amd: Add sanity check of irq remap information of old dev table
    entry
  iommu/amd: Don't copy GCR3 table root pointer

 drivers/iommu/amd_iommu.c       |  93 +++++++++++++-------
 drivers/iommu/amd_iommu_init.c  | 189 +++++++++++++++++++++++++++++++++++++---
 drivers/iommu/amd_iommu_proto.h |   2 +
 drivers/iommu/amd_iommu_types.h |  53 ++++++++++-
 drivers/iommu/amd_iommu_v2.c    |  18 +++-
 5 files changed, 307 insertions(+), 48 deletions(-)

-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
