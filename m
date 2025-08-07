Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16A5C87FCA
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lhPM9AXFzsjvkZwFew4kedEf0JNauNVQsN6w2Yc8SPM=; b=P2s9h00/8otFu1CikKIXMRQ2+n
	W5iTasurKzDN7bdmnikOu/56ofoOz8BBFPyUqjBUpadzc+GpBWMNcNr1KstSwMJ9nhQoTzUoO3eZq
	r/1LDPlktBRVhRbngRt8g5e5mmDpZXsYWGaicD0stBMcSRm7rtQknzsOkNmQfcntowVdo7zyGk08B
	HU3c8lsAifjsbUjqgZcZ4ZCD4T+2O7eQ3seCo69Iqp+0e+zkAPaYg2n8R/pqWrKmnHzlhEq+d2YQR
	wfRrrzhOTqRRvqPx6WgnMDXV2z+jK+khYBY/dVCttWhBNKUgm6UnOwE6cTWvEj6i1t6wejiEUGr9B
	b60mwPFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk7Ka-00000001VRg-3Zz4;
	Thu, 07 Aug 2025 20:35:20 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk7KX-00000001VRG-3pi1
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 20:35:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB8F1756;
	Thu,  7 Aug 2025 13:35:05 -0700 (PDT)
Received: from [172.27.42.168] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB5E3F5A1;
	Thu,  7 Aug 2025 13:35:13 -0700 (PDT)
Message-ID: <c8b1a8db-ab84-417f-8815-5ebc9dde46c6@arm.com>
Date: Thu, 7 Aug 2025 15:35:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
To: Askar Safin <safinaskar@zohomail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
References: <20250807032510.4211-1-safinaskar@zohomail.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_133518_045328_CD23827D 
X-CRM114-Status: GOOD (  27.80  )
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

Hi,


On 8/6/25 10:25 PM, Askar Safin wrote:
> TL;DR: this patchset fixes regression, introduced in aecc554e7b.
> This patchset should be backported to all distributions, which packaged v2.0.31, otherwise
> kexec doesn't work at all at my laptop with pretty common setup with v2.0.31.
> v2.0.31 is broken without this patchset.
> 
> See details of this bug on my laptop in first commit message.
> 
> Okay, why the bug happens? I suspect this is because of "%lux"
> string specifiers, which are totally wrong. The author meant "print (and scan) in hexademical"
> here, but this specifier prints (and scans) number in decimal, followed by literal "x". Oops.
> And this seems to break kexec.
> 
> The bug reproduces on kexec-tools aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 , but
> doesn't reproduce on kexec-tools 6aecc32c6db895b1c0b1f522d82c8810ece65542 .
> 
> (This is cover letter, so I think using scary SHA1 sums is okay here.)
> 
> I. e. it is regression, introduced by aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 .
> 
> Okay, how to fix this? Well, this is not easy. In 07821da7cf and d2f4297166 Andy Shevchenko
> observed compilation warnings, when %lx is used with uint64_t, so he replaced %lx with %llx.
> 
> Then in aecc554e7b Jeremy Linton observed warnings with %llx and replaced it with %lux.
> (Yes, C is nightmare.)
> 
> So, uint64_t is sometimes defined as long unsigned, and thus needs %lx, and sometimes as
> long long unsigned and thus needs %llx.
> 
> How to fix this once and for all?
> 
> I see three ways.
> 
> 1. uint64_t a; printf ("%llx", (unsigned long long)a);
> 2. uint64_t a; printf ("%" PRIx64, a);
> 3. uint64_t a; printf ("%w64x", a);
> 
> I think that %w64x is beautiful, but it causes compilation warnings on clang. (Facepalm.)
> Also it was introduced in C23, which is too young.
> 
> "(unsigned long long)a" is the best in my opinion. This is what I used in v1.
> But Andy said to me that POD conversions are evil.
> 
> PRIx64 is ugly, but this is the only option left. So this is what I used in this (v2) version.
> 
> Also this patchset fixes other misc things. See commit messages for details.
> 
> I tested on my laptop that this patchset actually fixes the bug.
> 
> v1: https://lore.kernel.org/kexec/20250805124722.11193-1-safinaskar@zohomail.com/


Thanks for fixing this, that patch was a last minute addition and I 
guess it shows.

The patch content looks fine to me, but I would suggest that the commit 
messages are added/cleaned up a bit. Also you need the fixes tags for 
all the cases I broke since they are now in separate files. It might be 
easier to keep some of the related ones together and the additional 
fixes you made which aren't corrections together.

Thanks again,


> 
> Changes since v1:
> * Addressed Andy's comments
> * I reproduced the bug (and tested the fix) on slightly different versions of Linux
>    and linux-firmware (see first commit message)
> 
> Askar Safin (6):
>    Fix printf string specifiers, otherwise kexec doesn't work on my
>      laptop
>    kexec/kexec-elf-exec.c: Replace %lux with %lx, this is what the author
>      meant
>    kexec/arch/i386/x86-linux-setup.c: replace %d with %u, because
>      e820[i].type is unsigned
>    util_lib/elf_info.c: fix typo: prink -> printk
>    kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
>    kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace,
>      ocasionally introduced in aecc554e7ba8
> 
>   kexec/arch/arm64/crashdump-arm64.c | 2 +-
>   kexec/arch/i386/crashdump-x86.c    | 3 ++-
>   kexec/arch/i386/kexec-x86-common.c | 4 ++--
>   kexec/arch/i386/x86-linux-setup.c  | 3 ++-
>   kexec/kexec-elf-exec.c             | 2 +-
>   util_lib/elf_info.c                | 9 +++++----
>   6 files changed, 13 insertions(+), 10 deletions(-)
> 


