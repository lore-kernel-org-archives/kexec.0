Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C277C87FCF
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mSygjng1TOk1yZB0KUnQdgok3wmV1NBIapOYBWbC1Wk=; b=HpZmuhnvXTmP8Bu7xynEvy+aO5
	uQeTCacB6XrsPAPVLpGF6KmBmRBDjOHHTOFTQtlmKxAdp/s2hpE02xAXv6tBm+UGPUeuGX9Hwf0uJ
	XwVGAFOTkiublsvnU07363SA+pu9E9DXOz46nvUjtuUgiqEDOZkNZ4QCJCZnoin9SLypcS9GCVcEN
	HYLGKn1/bjJqtTbZ+m08lBVE+1OKyzGsBdVZN40xJW+Sqx62Zyt8yKlw8IvcSwU4z8FJ32BpQSNVw
	7/ZA3UMxpRUHeb/aN8omkaw6pwzDe86xm6wio4UXRiEMMpIRqQtKW6B2eBLYonNgl3fJeeQ41eZO2
	xkCZzZNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrJr-0000000HClj-3AYx;
	Thu, 07 Aug 2025 03:29:31 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrJo-0000000HClJ-30GH
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537363; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ESuWNlBNJG5B6MH9HgRE6phnL7aOgdvjV9UZoeS62nXRlhZKxyEPtvTQR9SqOBDiH2A7G/SyZK0ByTZeBTrMepzuSFfXOqWzxOtC++CCe3U6R0WZltIx+khO8T+lfT9YCjaAQbntq9fh67FE1jaU5p4rcYmLDQ+iUHAF/0s1TLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537363; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mSygjng1TOk1yZB0KUnQdgok3wmV1NBIapOYBWbC1Wk=; 
	b=YBa23vS7h6WQFm14/0IiQSpa0OCP3oMad9E1G4WgBfQZKzjTT8chabL+uwApmGjJvLYF3WMKfDRLffzMLoWo7+drB3HrvwDTe8l7mrIvJ1o5MFOITEZbuOLtd6Rco7ZphULT6ywj0thPH0xFQudMlEY0P5aIddlLtudRUBvwipI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537363;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=mSygjng1TOk1yZB0KUnQdgok3wmV1NBIapOYBWbC1Wk=;
	b=faTelusY2/Kti28QdazgABC1B9nTToEXafKIFxl+9EBrhjSvtYmUjGflDUtPAN58
	5nM5c8fsv6DsxvjtU58bhJUAZYm+BeHpBtpKE1sC5PUp3+/bMLc1vaDx8SIoWmRkTLe
	ITeatvYi2Qe8IDDtOtYP8MH18SexXhDJO1ZlJqBk=
Received: by mx.zohomail.com with SMTPS id 1754537361581314.19430554469363;
	Wed, 6 Aug 2025 20:29:21 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 0/6] Fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Thu,  7 Aug 2025 03:25:04 +0000
Message-ID: <20250807032510.4211-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227956cae979ebd14366abe5d210000d0fb0b8bbcadf4de825b7bf728bf82859b4f7ce8ea1b89e161:zu08011227669d6bc099000bd4757c84930000fde5ee265bb53d9a78a1b5ce11d1ff33e10eb9df12297ef7f7:rf0801122c1de3c0ca3e44379e79538d82000075672f7bc7c75f0f8ee9772864803d66319862872b9f57b34d19ee039f77:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_202929_162991_0ECF2C5C 
X-CRM114-Status: GOOD (  11.78  )
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

The bug reproduces on kexec-tools aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 , but
doesn't reproduce on kexec-tools 6aecc32c6db895b1c0b1f522d82c8810ece65542 .

(This is cover letter, so I think using scary SHA1 sums is okay here.)

I. e. it is regression, introduced by aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 .

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

PRIx64 is ugly, but this is the only option left. So this is what I used in this (v2) version.

Also this patchset fixes other misc things. See commit messages for details.

I tested on my laptop that this patchset actually fixes the bug.

v1: https://lore.kernel.org/kexec/20250805124722.11193-1-safinaskar@zohomail.com/

Changes since v1:
* Addressed Andy's comments
* I reproduced the bug (and tested the fix) on slightly different versions of Linux
  and linux-firmware (see first commit message)

Askar Safin (6):
  Fix printf string specifiers, otherwise kexec doesn't work on my
    laptop
  kexec/kexec-elf-exec.c: Replace %lux with %lx, this is what the author
    meant
  kexec/arch/i386/x86-linux-setup.c: replace %d with %u, because
    e820[i].type is unsigned
  util_lib/elf_info.c: fix typo: prink -> printk
  kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
  kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace,
    ocasionally introduced in aecc554e7ba8

 kexec/arch/arm64/crashdump-arm64.c | 2 +-
 kexec/arch/i386/crashdump-x86.c    | 3 ++-
 kexec/arch/i386/kexec-x86-common.c | 4 ++--
 kexec/arch/i386/x86-linux-setup.c  | 3 ++-
 kexec/kexec-elf-exec.c             | 2 +-
 util_lib/elf_info.c                | 9 +++++----
 6 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.47.2


