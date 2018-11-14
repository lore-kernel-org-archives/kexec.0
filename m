Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMpd2-0001d9-No
 for kexec@lists.infradead.org; Wed, 14 Nov 2018 07:30:26 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/2 v6] add reserved e820 ranges to the kdump kernel e820 table
Date: Wed, 14 Nov 2018 15:29:24 +0800
Message-Id: <20181114072926.13312-1-lijiang@redhat.com>
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

At present, when use the kexec_file_load syscall to load the kernel image
and initramfs(for example: kexec -s -p xxx), the upstream kernel does not
pass the e820 reserved ranges to the second kernel, which might produce
two problems:

The first one is the MMCONFIG issue, although which does not make the
system crash or hang, this issue is still a potential risk, and also
might lead to the hot-plug device could not be recognized in kdump kernel.
Because the PCI MMCONFIG(extended mode) requires the reserved region
otherwise it falls back to legacy mode. For example, the kdump kernel
outputs the following log.

Example:
......
[   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
[   19.800995] PCI: not using MMCONFIG
......

The correct kernel log is like this:
......
[    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
......

The second issue is that the e820 reserved ranges do not setup in kdump
kernel, which will cause some functions that related to the e820 reserved
ranges to become invalid. For example:

early_memremap()->
early_memremap_pgprot_adjust()->
memremap_should_map_decrypted()->
e820__get_entry_type()

Please focus on these functions, early_memremap_pgprot_adjust() and
memremap_should_map_decrypted().

In the first kernel, these ranges sit in e820 reserved ranges, so the
memremap_should_map_decrypted() will return true, that is to say, the
reserved memory is decrypted, then the early_memremap_pgprot_adjust()
will call the pgprot_decrypted() to clear the memory encryption mask.

In the second kernel, because the e820 reserved ranges are not passed
to the second kernel, these ranges don't sit in the e820 reserved ranges,
so the memremap_should_map_decrypted() will return false, that is to say,
the reserved memory is encrypted, and then the early_memremap_pgprot_
adjust() will also call the pgprot_encrypted() to set the memory encryption
mask.

In fact, in the second kernel, the e820 reserved memory is still decrypted.
Obviously, it has gone wrong. So, this issue must be fixed, otherwise kdump
won't work in this case.

The e820 reserved range is useful in kdump kernel, so it is necessary to
pass the e820 reserved ranges to kdump kernel.

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

Changes since v4:
1. Improve the patch log, and add kernel log.

Changes since v5:
1. Rewrite these patches log.

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
