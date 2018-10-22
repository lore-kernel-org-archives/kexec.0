Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gEUw0-0006Si-Vo
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 07:47:36 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/2 v4] add reserved e820 ranges to the kdump kernel e820 table
Date: Mon, 22 Oct 2018 15:47:05 +0800
Message-Id: <20181022074707.13901-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com

E820 reserved ranges is useful in kdump kernel, it has been added in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region otherwise
it falls back to legacy mode.

Furthermore, when AMD SME kdump support, it needs to map dmi table area as
decrypted. For normal boot, these ranges sit in e820 reserved ranges, thus
the early ioremap code naturally map them as decrypted. If it also has same
e820 reserve setup in kdump kernel then it will just work like normal
kernel.

Kdump uses walk_iomem_res_desc to iterate resources, then adds matched desc
to e820 table for the kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types, we
need add exact e820 type to the kdump kernel e820 table, thus it also needs
an extra checking in memmap_entry_callback() to match the e820 type and
resource name.

Changes since v1:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.

Changes since v2:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.
2. Modified the invalid SOB chain issue.

Changes since v3:
1. Dropped [PATCH 1/3 v3] resource: fix an error which walks through iomem
   resources. Please refer to this commit <010a93bf97c7> "resource: Fix
   find_next_iomem_res() iteration issue"

Note:
1. The patches are made based on this branch:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

2. And you need to apply the follow patch before test kdump file_load,
   otherwise these patches won't work.
   commit <010a93bf97c7> "resource: Fix find_next_iomem_res() iteration
   issue"

Lianbo Jiang (2):
  x86/kexec_file: add e820 entry in case e820 type string matches to io
    resource name
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/kernel/crash.c         | 10 +++++++++-
 arch/x86/kernel/e820.c          |  2 +-
 kernel/resource.c               |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
