Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B2CA0EF5
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UABgZ4MQSa+obNmBUXbYMpj9nQO44HNEUut+0W0Px28=; b=SzFI68lR4xRgZSbFx+7cayK/7e
	uZgBT4E2/tZ5lnTKyMG+HxYMFz78U4PTuuV1wKBAK9Zgjbdb9BIR2jgpsDOPT9lyIonQFCOehNzxQ
	OhSkrQGqDZRIt0oJHsI4/eUXYvU34MUkDBtGlwZ5jIx9vjsLyWc8En2kV//JIuRH1df/uZdtT/TLt
	z0sYFyl73lBRsNn5Zlrjxk+juLzr9xEsJNjqMjyc/CQv5uiqVVa53cbslrOwMg/izZDHEgShKTap7
	CXqih8kFuXOvTu0Nafp+/wKjvsk9QMQDw/jj001kC6s3tyRVX9UKaCh3ZLN6VvDnEjVPo+jzRVIHX
	ZrPGRzDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqu-0000000A0D2-13wq;
	Tue, 19 Aug 2025 09:42:00 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIHw-00000009tPP-1iwy
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:05:54 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bHI68lPh8KaKqrk4qA17peB9YlQtkgvuqFaqzKddo+TSVUf2igM+MX29y3dgSVsTReN7lEghQP0hxe70nr3BvyiQ+67+Q42fCEz+b9r1VbNXt8syHP5eO5eg1r2J93DSSAvxIQ00AjKFQMqzDg6vjvyVrU93olPpC5N/m9G14qY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594349; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UABgZ4MQSa+obNmBUXbYMpj9nQO44HNEUut+0W0Px28=; 
	b=aDtap6bnm3MmqrBtdRINdFbvvF+tYXbNOlS/Frq89kl/0wTxmeYM1Jwx5IehtrqqByk9m5G1KieBg4u/m24+jI+EUNVRztngn3/QBnCoSaYKCxRqonnZ/7ltrLegjP0xuRvl+ryYgOsVmPrTrvja4Gzc1cS46lNMYGr9ysrUhdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594349;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UABgZ4MQSa+obNmBUXbYMpj9nQO44HNEUut+0W0Px28=;
	b=Vt2tHBu2PnyPkg+mThy2SnGmKf8JNyjowniMo4j5KRpUVxneoTnL3Zf9Gx9JSwsj
	1gL0wlS+OJVeZCMBO2dkDk3tzkVkuR/uqJVRZmxs/Y0ZniS2/sq99jY69Tas4rVgvAf
	qO1+91SBzt4nWVLxaIu9H5X2HoZlJf5NF3/yc5DM=
Received: by mx.zohomail.com with SMTPS id 1755594345863126.94412674464468;
	Tue, 19 Aug 2025 02:05:45 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 0/6] Fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Tue, 19 Aug 2025 09:04:59 +0000
Message-ID: <20250819090505.647690-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227d45f928994808f8d8506efac00002b6bccd870632a5a4de80b6f3eb018d49953e0bac63d0d69b9:zu080112270eeef97263e5dac6d6c4fda80000f0e59dd1f2438c093a0c0d3053e7a61f98f6b04c7eac324eaa:rf0801122c4214202273592fcdf7d815de00005fc76e4d6cf02e770bf16dc1cd73d36dc3486bdf2a8b52e8109baf62a2e1:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020552_867067_A409B017 
X-CRM114-Status: GOOD (  11.84  )
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

Changes since v1:
* Addressed Andy's comments
* I reproduced the bug (and tested the fix) on slightly different versions of Linux
  and linux-firmware (see first commit message)

Changes since v2:
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

