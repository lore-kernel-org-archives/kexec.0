Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5XBM-0003oQ-UV
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 14:22:22 +0000
Subject: [PATCH 0/3] find_next_iomem_res() fixes
From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 27 Sep 2018 09:21:49 -0500
Message-ID: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
To: linux-kernel@vger.kernel.org
Cc: dan.j.williams@intel.com, brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

These fix:

  - A kexec off-by-one error that we probably never see in practice (only
    affects a resource starting at exactly 640KB).

  - A corner case in walk_iomem_res_desc(), walk_system_ram_res(), etc that
    we probably also never see in practice (only affects a single byte
    resource at the very end of the region we're searching)

  - An issue in walk_iomem_res_desc() that apparently causes a kdump issue
    (see Lianbo's note at [1]).

I think we need to fix the kdump issue either by these patches
(specifically the last one) or by the patch Lianbo posted [2].

I'm hoping to avoid deciding and merging these myself, but I'm not
sure who really wants to own kernel/resource.c.

[1] https://lore.kernel.org/lkml/01551d06-c421-5df3-b19f-fc66f3639e4f@redhat.com
[2] https://lore.kernel.org/lkml/20180921073211.20097-2-lijiang@redhat.com

---

Bjorn Helgaas (3):
      x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
      resource: Include resource end in walk_*() interfaces
      resource: Fix find_next_iomem_res() iteration issue


 arch/x86/include/asm/kexec.h |    2 -
 kernel/resource.c            |   96 ++++++++++++++++++------------------------
 2 files changed, 43 insertions(+), 55 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
