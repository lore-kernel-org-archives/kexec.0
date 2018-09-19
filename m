Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2byq-0008Rs-PF
 for kexec@lists.infradead.org; Wed, 19 Sep 2018 12:54:31 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/3 v2] add reserved e820 ranges to the kdump kernel e820 table
Date: Wed, 19 Sep 2018 20:52:48 +0800
Message-Id: <20180919125251.8181-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

E820 reserved ranges is useful in kdump kernel, we have added this in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region otherwise
it falls back to legacy mode.

Furthermore, when AMD SME kdump support, it needs to map dmi table area as
unencrypted. For normal boot these ranges sit in e820 reserved ranges thus
the early ioremap code naturally map them as unencrypted. So if we have same
e820 reserve setup in kdump kernel then it will just work like normal kernel.

Kdump use walk_iomem_res_desc to iterate resources then add matched desc to
e820 table for the kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types, we
need add exact e820 type to the kdump kernel e820 table thus need an extra
checking in memmap_entry_callback() to match the e820 type and resource name.

By the way, we also fix an error which walks through iomem resources, the
values of the function parameter may be modified in the while loop of
__walk_iomem_res_desc(), which will cause us to not get the desired result
in some cases.

Changes since v1:
1. We modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.

Lianbo Jiang (3):
  resource: fix an error which walks through iomem resources
  x86/kexec_file: add e820 entry in case e820 type string matches to io
    resource name
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/kernel/crash.c         | 11 ++++++++++-
 arch/x86/kernel/e820.c          |  2 +-
 kernel/resource.c               |  3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
