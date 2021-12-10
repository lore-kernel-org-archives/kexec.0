Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvWGG-000iUG-3Y
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 03:07:53 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A64D61F2E3
 for <kexec@lists.infradead.org>; Fri, 10 Dec 2021 03:07:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 0/3] arm64: make phys_to_virt() correct
Date: Fri, 10 Dec 2021 11:07:32 +0800
Message-Id: <20211210030735.53155-1-piliu@redhat.com>
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
Cc: Pingfan Liu <piliu@redhat.com>

Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
One issue is contributed by phys_offset not signed.
The other is contributed by wrong page_offset.

This series fixes them so vmcore-dmesg can work on 52-bits VA kernel

Pingfan Liu (3):
  arm64: make phys_offset signed
  arm64/crashdump: unify routine to get page_offset
  arm64: read VA_BITS from kcore for 52-bits VA kernel

 kexec/arch/arm64/crashdump-arm64.c | 23 +---------------
 kexec/arch/arm64/kexec-arm64.c     | 43 +++++++++++++++++++++++-------
 kexec/arch/arm64/kexec-arm64.h     |  4 ++-
 util_lib/elf_info.c                |  7 ++++-
 util_lib/include/elf_info.h        |  2 +-
 5 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
