Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1my4ij-008Y53-Ay
 for kexec@lists.infradead.org; Fri, 17 Dec 2021 04:19:50 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv2 0/3] arm64: make phys_to_virt() correct
Date: Fri, 17 Dec 2021 12:19:11 +0800
Message-Id: <20211217041914.68692-1-piliu@redhat.com>
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
Cc: Simon Horman <horms@verge.net.au>, Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>

Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
One issue is contributed by phys_offset not signed.
The other is contributed by wrong page_offset.

v1 -> v2
Fix broken patch [2/3] in v1
Move arch_scan_vmcoreinfo declaration to util_lib/include/elf_info.h
Using UINT64_MAX instread of 0xffffffffffffffff



Pingfan Liu (3):
  arm64: make phys_offset signed
  arm64/crashdump: unify routine to get page_offset
  arm64: read VA_BITS from kcore for 52-bits VA kernel

 kexec/arch/arm64/crashdump-arm64.c | 23 +-------------
 kexec/arch/arm64/kexec-arm64.c     | 48 +++++++++++++++++++++++-------
 kexec/arch/arm64/kexec-arm64.h     |  3 +-
 util_lib/elf_info.c                |  7 ++++-
 util_lib/include/elf_info.h        |  3 +-
 5 files changed, 48 insertions(+), 36 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
