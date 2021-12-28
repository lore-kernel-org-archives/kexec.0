Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2CVe-000yTJ-JN
 for kexec@lists.infradead.org; Tue, 28 Dec 2021 13:27:24 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv3 0/4] arm64: make phys_to_virt() correct
Date: Tue, 28 Dec 2021 21:26:55 +0800
Message-Id: <20211228132659.40102-1-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>, Kairui Song <kasong@tencent.com>, Simon Horman <horms@verge.net.au>, Philipp Rudo <prudo@redhat.com>

Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
One issue is contributed by phys_offset not signed.
The other is contributed by wrong page_offset.

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

 kexec/arch/arm64/crashdump-arm64.c | 23 +-----------
 kexec/arch/arm64/kexec-arm64.c     | 60 ++++++++++++++++++++++++------
 kexec/arch/arm64/kexec-arm64.h     |  3 +-
 util_lib/elf_info.c                |  7 +++-
 util_lib/include/elf_info.h        |  3 +-
 5 files changed, 60 insertions(+), 36 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
