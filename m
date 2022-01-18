From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 18 Jan 2022 15:48:08 +0800
Subject: [PATCHv4 0/4] arm64: make phys_to_virt() correct
Message-ID: <20220118074812.27702-1-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
One issue is contributed by phys_offset not signed.
The other is contributed by wrong page_offset.

v3 -> v4:
address the date type in [1/4] and [2/4] 

v2 -> v3:
Discussed with Kairui off-list, 48-bits VA kernel can not handle flipped
mm yet. So introducing [4/4], which judges whether the kernel is with
flipped mm layout and adopt different formula accordingly.

As for [1-3/4], they are the same as [1-3/3] in V2.

v1 -> v2
Fix broken patch [2/3] in v1
Move arch_scan_vmcoreinfo declaration to util_lib/include/elf_info.h
Using UINT64_MAX instread of 0xffffffffffffffff


Cc: Kairui Song <kasong@tencent.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org

*** BLURB HERE ***

Kairui Song (1):
  arm64: fix PAGE_OFFSET calc for flipped mm

Pingfan Liu (3):
  arm64: make phys_offset signed
  arm64/crashdump: unify routine to get page_offset
  arm64: read VA_BITS from kcore for 52-bits VA kernel

 kexec/arch/arm64/crashdump-arm64.c | 23 +----------
 kexec/arch/arm64/kexec-arm64.c     | 64 ++++++++++++++++++++++++------
 kexec/arch/arm64/kexec-arm64.h     |  3 +-
 util_lib/elf_info.c                |  7 +++-
 util_lib/include/elf_info.h        |  3 +-
 5 files changed, 62 insertions(+), 38 deletions(-)

-- 
2.31.1


