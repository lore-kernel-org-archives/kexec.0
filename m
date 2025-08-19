Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362ACCA0EED
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YZk3MHN7Y5ux2w7u0IVnW+loHW+YbzG/PCGJareQVOc=; b=B5/hZZOVUB2Z1+VyX95W7jsjZI
	4RnMFEz+tC0419vGRQhTZMIrSorvVRUemjjO6aeHwShvK8wGIe7b5xfPrcKOVEEwsAguImTe6GZIc
	FN108I1ey6pIE8gxfxDxKlDXzj8kq5dab9oYguN7lK368xojTVsZciAuwRMTi+bykjix7MZdjzWqr
	gzFhp4UqkGjiBd9cx/GkWS3SCxOhafHtD0//BSJO7ntxLdDuaGcSBEJpxb97GAXyfREkScpLf1oHN
	22O20FSgEX3LH82UIm+M0bLSJ7xQgwcuhEOL7uUodMomaDN9FkjI8FWXzG2XSK5mrxQmUY11f5wu1
	i6y+/NXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK6-0000000Bo7O-1MJd;
	Tue, 19 Aug 2025 23:00:58 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTub-0000000BdmL-1ZmV
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639030; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T6LepJm5PYyvU5RHN2eKnFPtCNgCn0JLiy1XSafAPipwxBj9Ay9X+CPMUBLHbHSqQidhqQijxV0Cejb/8yyoGCjQxZwjM67xFmQaHAa8QMTYSBWUZIoYnETKrFpWOpKJf81m5YwC/BMfxsSgsRxoBaTWojvy/gHf77/yRwccosM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639030; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YZk3MHN7Y5ux2w7u0IVnW+loHW+YbzG/PCGJareQVOc=; 
	b=QyWKO9ZUjJzMcsZVhjfbSoNdmYALQGJry7/zK+ZsKVwLL9XpmK0i95nOfEaEetpR+jk6bxdBoYA1cVGbp0cax3AyLmhcQNRiwftSNlWD1Cf8RpBkMDGiayPdsoMoUHGlG4PSyi3GOMHnsvof5ZQ3kKvyMUQPyql8WEk+V1OlXSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639030;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=YZk3MHN7Y5ux2w7u0IVnW+loHW+YbzG/PCGJareQVOc=;
	b=a8IUBvP7Ol2eE80h3Tst8F9LnSSiACgbKQhXVQmrvYbxEBT0VxLgfr73jj77v6BV
	x/Jm8dge0qYHA/vb2s+ABFglVV2vyp2WM279VioIc2WNjQEJYPEPvyZXUAECFGbol9M
	zprcpu28kzFgeJxocrr2DrhglnXqv8nnFOPVyJLk=
Received: by mx.zohomail.com with SMTPS id 17556390274441001.6454028072117;
	Tue, 19 Aug 2025 14:30:27 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v4 0/6] Fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Tue, 19 Aug 2025 21:30:08 +0000
Message-ID: <20250819213014.908757-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227be39bdc3d4ab3caef4fd4b000000cb3686c173d12cd61db18c858a95569a83551a98adb8762b10:zu08011227eba27c4de07a8cfdee6452150000bab52d29c9076d4e225a5e3a47cff86cf0a9373ef6847e676d:rf0801122c564b56d872fa9c4e88fea19900004eeb3f7e94c172099deb256073bf7d24f2131ec90b8a4079ee0873558f32:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143033_819629_997622EE 
X-CRM114-Status: GOOD (  11.72  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

TL;DR: this patchset fixes regression, introduced in aecc554e7b.
This patchset should be backported to all distributions, which packaged v2.0.31, otherwise
kexec doesn't work at all at my laptop with pretty common setup with v2.0.31.
v2.0.31 is broken without this patchset.

See details of this bug on my laptop in first commit message.

Okay, why the bug happens? I suspect this is because of "%lux"
string specifiers, which are totally wrong. The author meant "print (and scan) in hexademical"
here, but this specifier prints (and scans) number in decimal, followed by literal "x". Oops.
And this seems to break kexec.

The bug reproduces on kexec-tools aecc554e7ba , but
doesn't reproduce on kexec-tools 6aecc32c6db .

I. e. it is regression, introduced by aecc554e7ba .

Okay, how to fix this? Well, this is not easy. In 07821da7cf and d2f4297166 Andy Shevchenko
observed compilation warnings, when %lx is used with uint64_t, so he replaced %lx with %llx.

Then in aecc554e7b Jeremy Linton observed warnings with %llx and replaced it with %lux.
(Yes, C is nightmare.)

So, uint64_t is sometimes defined as long unsigned, and thus needs %lx, and sometimes as
long long unsigned and thus needs %llx.

How to fix this once and for all?

I see three ways.

1. uint64_t a; printf ("%llx", (unsigned long long)a);
2. uint64_t a; printf ("%" PRIx64, a);
3. uint64_t a; printf ("%w64x", a);

I think that %w64x is beautiful, but it causes compilation warnings on clang. (Facepalm.)
Also it was introduced in C23, which is too young.

"(unsigned long long)a" is the best in my opinion. This is what I used in v1.
But Andy said to me that POD conversions are evil.

PRIx64 is ugly, but this is the only option left. So this is what I used in this version.

Also this patchset fixes other misc things. See commit messages for details.

I tested on my laptop that this patchset actually fixes the bug.

v1: https://lore.kernel.org/kexec/20250805124722.11193-1-safinaskar@zohomail.com/
v2: https://lore.kernel.org/kexec/20250807032510.4211-1-safinaskar@zohomail.com/
v3: https://lore.kernel.org/kexec/20250819090505.647690-1-safinaskar@zohomail.com/

Changes since v1:
* Addressed Andy's comments
* I reproduced the bug (and tested the fix) on slightly different versions of Linux
  and linux-firmware (see first commit message)

Changes since v2:
* Commit messages only

Changes since v3:
* Commit messages only

Askar Safin (6):
  Fix printf string specifiers, otherwise kexec doesn't work on my
    laptop
  kexec/kexec-elf-exec.c: Replace %lux with %lx
  kexec/arch/i386/x86-linux-setup.c: replace %d with %u
  util_lib/elf_info.c: fix typo: prink -> printk
  kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
  kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace

 kexec/arch/arm64/crashdump-arm64.c | 2 +-
 kexec/arch/i386/crashdump-x86.c    | 3 ++-
 kexec/arch/i386/kexec-x86-common.c | 4 ++--
 kexec/arch/i386/x86-linux-setup.c  | 3 ++-
 kexec/kexec-elf-exec.c             | 2 +-
 util_lib/elf_info.c                | 9 +++++----
 6 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.47.2


