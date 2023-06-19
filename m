Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E18EB64D9
	for <kexec@archiver.kernel.org>; Mon, 19 Jun 2023 06:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vuUqgJALyJKKtlzQs6rmiJpcM1X6iRM+oGKm6j5rWu0=; b=PKAeeUmWrJnZwZ
	nuvQfPEChZx8Ey1pmQApbqlP3abLLM49r3ezz8h/A5qKbBYa31NMwzoefi3yyFzFxU9Q5KogkTpc8
	fC07iqudbFk9NC5110SLMvobn+i8ZEowmuMCTWtqLkiPxRHGh6rKFd8Y1HWXUzv+tFhdbsbI4TyLl
	FNt+YKKQI/7GgDyOclWnsxRWxd3WyrXXr5EdS3EOq/Ur0a/pmmH3ZDS5vZS4MFy77r+iRUJS2efGi
	/Kzd7wK/xfxe+SkDr7r6j8X2P5y+b1aTxIIdizWG1rJ453YY1n12mop97bfXoO540s1urJFwkm0yv
	CxbVSOsyoKBv43XMrXag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qB7vx-007Wi7-0C;
	Mon, 19 Jun 2023 06:00:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qB7vt-007Wfs-01
	for kexec@lists.infradead.org;
	Mon, 19 Jun 2023 06:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687154405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Z+NO+U3mF4VkZPV3TiZ9hDCsNGYkiNE2A8dRovLHfw=;
	b=OIDJGIUyECZX1fplz0t5ajGQIrQN9y/uizqaJomAvBbBliyi//ZBtBa1YH8MeFbpn51fVR
	czTkWjZXWGZ/Zwn9lvHmsvb0kI9DZO4iYg+nALDdBN9t7y6kpH+tanzl4ZXZliC5OGNyTd
	xKvrLzifxvn0sL2jSaNcHGW1j13xedM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-e-TQ8zTVO1GPjKCn5TdD5g-1; Mon, 19 Jun 2023 02:00:01 -0400
X-MC-Unique: e-TQ8zTVO1GPjKCn5TdD5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B2E3800888;
	Mon, 19 Jun 2023 06:00:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-194.pek2.redhat.com [10.72.12.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20987112132C;
	Mon, 19 Jun 2023 05:59:54 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	horms@kernel.org,
	chenjiahao16@huawei.com,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	bp@alien8.de,
	Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture
Date: Mon, 19 Jun 2023 13:59:47 +0800
Message-Id: <20230619055951.45620-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230618_230009_140901_3EDCEDA6 
X-CRM114-Status: GOOD (  15.09  )
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

Here, try to abstract the crashkernel parameter parsing code into a
generic function parse_crashkernel_generic(), and the crashkernel memory
reserving code into a generic function reserve_crashkernel_generic().
Then, in ARCH which crashkernel=,high support is needed, a simple
arch_reserve_crashkernel() can be added to call above two generic
functions. This can remove the duplicated implmentation code in each
ARCH, like arm64, x86_64.

I only change the arm64 and x86_64 implementation to make use of the
generic functions to simplify code. Risc-v can be done very easily refer
to the steps in arm64 and x86_64. I leave this to Jiahao or other risc-v
developer since Jiahao have posted a patchset to add crashkernel=,high
support to risc-v.

This patchset is based on the latest linus's tree, and on top of below
patch:

arm64: kdump: simplify the reservation behaviour of crashkernel=,high
      https://git.kernel.org/arm64/c/6c4dcaddbd36


Baoquan He (4):
  kdump: rename parse_crashkernel() to parse_crashkernel_common()
  kdump: add generic functions to parse crashkernel and do reservation
  arm64: kdump: use generic interfaces to simplify crashkernel
    reservation code
  x86: kdump: use generic interfaces to simplify crashkernel reservation
    code

 arch/arm/kernel/setup.c              |   4 +-
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/kexec.h       |   8 ++
 arch/arm64/mm/init.c                 | 141 ++----------------------
 arch/ia64/kernel/setup.c             |   4 +-
 arch/loongarch/kernel/setup.c        |   3 +-
 arch/mips/cavium-octeon/setup.c      |   2 +-
 arch/mips/kernel/setup.c             |   4 +-
 arch/powerpc/kernel/fadump.c         |   5 +-
 arch/powerpc/kexec/core.c            |   4 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |   4 +-
 arch/riscv/mm/init.c                 |   5 +-
 arch/s390/kernel/setup.c             |   4 +-
 arch/sh/kernel/machine_kexec.c       |   5 +-
 arch/x86/Kconfig                     |   3 +
 arch/x86/include/asm/kexec.h         |  32 ++++++
 arch/x86/kernel/setup.c              | 141 +++---------------------
 include/linux/crash_core.h           |  33 +++++-
 kernel/crash_core.c                  | 158 +++++++++++++++++++++++++--
 19 files changed, 274 insertions(+), 289 deletions(-)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
