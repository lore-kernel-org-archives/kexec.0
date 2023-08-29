Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E815C83F18
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=abDhusw5Csy6ki5fGSLq2LE20Sgy9CKgdB618jI/zIs=; b=vPF7Qubnb/Sygp
	+kDTBpAAXF4JJkO83UkzPlAmwvRzkc/J9Ho+sLP0bmAYpzX1XkwYiewGZblv7844QISTOlJd+kALS
	GtKEy1lyQBY/+qgtCM84eTAgphZtNQumtcYLD04MtytNPreOFvHjmjS4CCviY/I3gWYdXhXSLzIru
	oUIvp9gyyJoP4UBcuS4cpcTbpOvpQP/OHccnuJZjSXsw63Jn0kLDEMdC5gdn5vZWgk7MoQ2+y7In7
	2FmGDw002rAkYzrr4KtoJ5GeFKJrzr9pKLUfPbDntbF+NPiq1TrDlmf4O1tvWqW5W5HOvXGU391D3
	s7Jm5HUozrXne4Pvh/5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxe0-00BTTZ-20;
	Tue, 29 Aug 2023 12:16:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxdx-00BTSw-0O
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 12:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693311383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V9QpIawjTNUXSAeauUX4fl4M+mXtQMbJ5Ulee2rW8ME=;
	b=edMljgk47+2x/DxDZmSPCKRslpQ1T2EohGAi+P6lGPXwNVX8fQiqugf/Na9nKfoDseO8im
	XLFQu/2M4/RIwuO9owJBpJxgi1EZwI+d5CBh8hvcEzH0LRZ3agL9kqsHLc1GL4U7UMMtmo
	d9ijJx8eaNJTePYi+jNAwj6yiXaPMc4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-Zmligm66Ovu2JRrnNR0kUQ-1; Tue, 29 Aug 2023 08:16:19 -0400
X-MC-Unique: Zmligm66Ovu2JRrnNR0kUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50BE33C36A8E;
	Tue, 29 Aug 2023 12:16:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91C4B63F6C;
	Tue, 29 Aug 2023 12:16:13 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	samuel.holland@sifive.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/8] kdump: use generic functions to simplify crashkernel reservation in arch
Date: Tue, 29 Aug 2023 20:16:02 +0800
Message-ID: <20230829121610.138107-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_051625_273765_FEAA2D78 
X-CRM114-Status: GOOD (  18.18  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In the current arm64, crashkernel=,high support has been finished after
several rounds of posting and careful reviewing. The code in arm64 which
parses crashkernel kernel parameters firstly, then reserve memory can be
a good example for other ARCH to refer to.

Whereas in x86_64, the code mixing crashkernel parameter parsing and
memory reserving is twisted, and looks messy. Refactoring the code to
make it more readable maintainable is necessary.

Here, firstly abstract the crashkernel parameter parsing code into
parse_crashkernel() to make it be able to parse crashkernel=,high|low.
Then abstract the crashkernel memory reserving code into a generic
function reserve_crashkernel_generic(). Finally, in ARCH which
crashkernel=,high support is needed, a simple arch_reserve_crashkernel()
can be added to call above two functions. This can remove the duplicated
implmentation code in each ARCH, like arm64, x86_64.

I only change the arm64 and x86_64 implementation to make use of the
generic functions to simplify code. Risc-v can be done very easily refer
to the steps in arm64 and x86_64.

History:
- RFC patchset:
  https://lore.kernel.org/all/20230619055951.45620-1-bhe@redhat.com/T/#u
  [RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture
  Dave and Philipp commented the old parse_crashkernel_common() and
  parse_crashkernel_generic() are quite confusing. In this formal post,
  I made change to address the concern by unifying all crashkernel
  parsing into parse_crashkernel().

v1->v2:
- Change to add asm/crash_core.h into x86 and arm64 to contain those
  arch specific macro definitions for generic reservaton. This fixes the
  compiling error reported by LKP in v1.
  https://lore.kernel.org/all/202308272150.p3kRkMoF-lkp@intel.com/T/#u
- Fix a log typo in patch 8, thanks to Samuel.

Baoquan He (8):
  crash_core.c: remove unnecessary parameter of function
  crash_core: change the prototype of function parse_crashkernel()
  crash_core: change parse_crashkernel() to support
    crashkernel=,high|low parsing
  crash_core: add generic function to do reservation
  crash_core.h: include <asm/crash_core.h> if generic reservation is
    needed
  x86: kdump: use generic interface to simplify crashkernel reservation
    code
  arm64: kdump: use generic interface to simplify crashkernel
    reservation
  crash_core.c: remove unneeded functions

 arch/arm/kernel/setup.c              |   3 +-
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/crash_core.h  |  10 ++
 arch/arm64/mm/init.c                 | 140 ++--------------------
 arch/ia64/kernel/setup.c             |   2 +-
 arch/loongarch/kernel/setup.c        |   4 +-
 arch/mips/kernel/setup.c             |   3 +-
 arch/powerpc/kernel/fadump.c         |   2 +-
 arch/powerpc/kexec/core.c            |   2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |   2 +-
 arch/riscv/mm/init.c                 |   2 +-
 arch/s390/kernel/setup.c             |   4 +-
 arch/sh/kernel/machine_kexec.c       |   2 +-
 arch/x86/Kconfig                     |   3 +
 arch/x86/include/asm/crash_core.h    |  34 ++++++
 arch/x86/kernel/setup.c              | 143 +++-------------------
 include/linux/crash_core.h           |  38 +++++-
 kernel/crash_core.c                  | 170 +++++++++++++++++++++++----
 18 files changed, 269 insertions(+), 298 deletions(-)
 create mode 100644 arch/arm64/include/asm/crash_core.h
 create mode 100644 arch/x86/include/asm/crash_core.h

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
