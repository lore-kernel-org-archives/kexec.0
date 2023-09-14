Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2AEEE021F
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 03:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jSZ/kZ8141Ri3wLQmUmm+fmbRbXAAE0z8iXcq8PxerQ=; b=IJZq1Q+W3r782u
	nmKsPLpN7G5U3rlvBUdGV9JU+TPQk1KqHGwgqGpuJ6R3QAl1mwk3gmz8gfLmI/HQhk2fZQv+4Lzrj
	yGcy/1A/n1tWjiSazdnqGqRH9hk0UZda/iruVchy6og47MxPwPgbpA/Ve4tMzf54cCsbcJywOLdYY
	gaB+I/0pCFzL0r+XIs6szwtTGDjgOOkAyO7bsytkcNmlt/il9GvEup2oAb4SlpFzTv/s/vpnRWKc6
	KrsMNTRKcj6eEOSTyQOXF/o5NXkFM99wCMZzz8HjaqjnNqfSHu2eGWAvpdzfoHH31rVm8ygM0i9G5
	zX0Y0MQcB+TV9fsskMdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5I-007Fak-0B;
	Thu, 14 Sep 2023 03:32:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5E-007FYZ-0a
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 03:32:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694662314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hudU0FKKSfKGoT5NXgs2s+9GzsdTCr22QtjS8oAgCWE=;
	b=YEqY2joo9qPNM7uakEmIFnAFgLRHu6x/kSlytcKjaGa7b1LQO9T6h1fMYfIpOyDIMkMz9K
	JpzfpJ3aLBHrhq5qfTPnsAf/M/a5rynvLnEtVdFHMkIlj76XLscafOPH5AyxZY1vrBtlm5
	p8X4hUqgebXmR9qgRZPG4LHMGIfQnZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-_icoECdnMROGvFx-gn-GJA-1; Wed, 13 Sep 2023 23:31:50 -0400
X-MC-Unique: _icoECdnMROGvFx-gn-GJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC9EC857A9D;
	Thu, 14 Sep 2023 03:31:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 98D0F10085C0;
	Thu, 14 Sep 2023 03:31:45 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	thunder.leizhen@huawei.com,
	catalin.marinas@arm.com,
	chenjiahao16@huawei.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/9] kdump: use generic functions to simplify crashkernel reservation in arch
Date: Thu, 14 Sep 2023 11:31:33 +0800
Message-ID: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_203200_316951_626CCF39 
X-CRM114-Status: GOOD (  19.82  )
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
implmentation code in each ARCH, like arm64, x86_64 and riscv.

I only did testing on x86_64 and arm64 for below cases, haven't tested
riscv. If riscv people can help apply the patchset and give it a shot,
it would be great.

crashkernel=512M,high
crashkernel=512M,high crashkernel=256M,low
crashkernel=512M,high crashkernel=0M,low
crashkernel=0M,high crashkernel=256M,low
crashkernel=512M
crashkernel=512M@0x4f000000
crashkernel=1G-4G:256M,4G-64G:320M,64G-:576M
crashkernel=0M

History:
v2->v3:
- Move crashk_res and crashk_low_res codes into crash_core.c, and add
  <asm/crash_core.h> including in <linux/crash_core.h>. These two fix
  compiling error reported by LKP when CONFIG_CRASH_CORE=on while
  CONFIG_KEXEC_CORE is unset.
- Adjust the if-else and return logic in parse_crashkernel() according
  to Lei's suggestion.
- Make riscv use the generic interface to simplify crahskernel
  reservation code too since crashkernel=,high support has been added
  into riscv.
- Some minor changes suggested by Lei.

v1->v2:
- Change to add asm/crash_core.h into x86 and arm64 to contain those
  arch specific macro definitions for generic reservaton. This fixes the
  compiling error reported by LKP in v1.
  https://lore.kernel.org/all/202308272150.p3kRkMoF-lkp@intel.com/T/#u
- Fix a log typo in patch 8, thanks to Samuel.

- RFC->v1:
  https://lore.kernel.org/all/20230619055951.45620-1-bhe@redhat.com/T/#u
  [RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture
  Dave and Philipp commented the old parse_crashkernel_common() and
  parse_crashkernel_generic() are quite confusing. In this formal post,
  I made change to address the concern by unifying all crashkernel
  parsing into parse_crashkernel().


Baoquan He (9):
  crash_core.c: remove unnecessary parameter of function
  crash_core: change the prototype of function parse_crashkernel()
  crash_core: change parse_crashkernel() to support
    crashkernel=,high|low parsing
  crash_core: add generic function to do reservation
  crash_core: move crashk_*res definition into crash_core.c
  x86: kdump: use generic interface to simplify crashkernel reservation
    code
  arm64: kdump: use generic interface to simplify crashkernel
    reservation
  riscv: kdump: use generic interface to simplify crashkernel
    reservation
  crash_core.c: remove unneeded functions

 arch/arm/kernel/setup.c              |   3 +-
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/crash_core.h  |  10 ++
 arch/arm64/mm/init.c                 | 140 ++------------------
 arch/ia64/kernel/setup.c             |   2 +-
 arch/loongarch/kernel/setup.c        |   4 +-
 arch/mips/kernel/setup.c             |   3 +-
 arch/powerpc/kernel/fadump.c         |   2 +-
 arch/powerpc/kexec/core.c            |   2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |   2 +-
 arch/riscv/Kconfig                   |   3 +
 arch/riscv/include/asm/crash_core.h  |  11 ++
 arch/riscv/include/asm/processor.h   |   2 +
 arch/riscv/mm/init.c                 | 141 ++------------------
 arch/s390/kernel/setup.c             |   4 +-
 arch/sh/kernel/machine_kexec.c       |   2 +-
 arch/x86/Kconfig                     |   3 +
 arch/x86/include/asm/crash_core.h    |  34 +++++
 arch/x86/kernel/setup.c              | 143 +++------------------
 include/linux/crash_core.h           |  49 ++++++-
 include/linux/kexec.h                |   4 -
 kernel/crash_core.c                  | 184 ++++++++++++++++++++++++---
 kernel/kexec_core.c                  |  17 ---
 23 files changed, 321 insertions(+), 447 deletions(-)
 create mode 100644 arch/arm64/include/asm/crash_core.h
 create mode 100644 arch/riscv/include/asm/crash_core.h
 create mode 100644 arch/x86/include/asm/crash_core.h

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
