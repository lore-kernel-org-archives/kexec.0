Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F5CCAC5BB
	for <kexec@archiver.kernel.org>; Fri, 26 Sep 2025 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFMklrUX2OtsQS0HtibqEUTC+Y0e2RuZAfATbI60MGI=; b=4lOHo+TNToSbYdsINB/m2GHyvN
	JrQa/R2AEDTaUvda3OuC6P7n+D4eMzt9gjwROiIwMDk58GQuDjJeTHccAb5cxhYwCmRJ7pjtnVW0/
	qtvbb5/ZtKjdlYS8e7Gq83Ktd3PD0U69E70RwYkQfRyNBlEZ3LyT/tj+WyQsFoxPuCgqsqGMuIR0a
	brltzMhC0Llr1ip3yGug1bN0LgE7OCVpCcWTJfnP/kqj7FsLJ0v4qtpQph13RZu8tuMZp+ZkjEpho
	/ycJor8J1WeMrXdfawqSMMGH3Jv7XBest1yVc9lRnd4iSj5HFGazFtXFFLeHQBw1kObESBtqyfGWv
	6YVtIREg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2Fgz-00000004Y90-1MA9;
	Fri, 26 Sep 2025 21:09:25 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2Fgv-00000004Y5n-20la
	for kexec@lists.infradead.org;
	Fri, 26 Sep 2025 21:09:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 154D4168F;
	Fri, 26 Sep 2025 14:09:10 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AF393F694;
	Fri, 26 Sep 2025 14:09:18 -0700 (PDT)
Message-ID: <a28436ba-e040-42cf-82e5-52ff5cb144ce@arm.com>
Date: Fri, 26 Sep 2025 16:09:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
To: Askar Safin <safinaskar@zohomail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
References: <20250819213014.908757-1-safinaskar@zohomail.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250926_140921_646507_FB1DCACD 
X-CRM114-Status: GOOD (  25.47  )
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


First, thanks for fixing this!

So, I've been trying to find a failure beyond the printouts being wrong 
for the past couple days, and largely failed to duplicate a functional 
issue.

That said, this does fix a couple printouts I checked on 32-bit 686 
debian 12. Generally I think the code is ok as well and have reviewed it 
but i'm going to withhold the review by tag because I still think the 
commit messages could use some cleanup.


Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks again.




On 8/19/25 4:30 PM, Askar Safin wrote:
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
> The bug reproduces on kexec-tools aecc554e7ba , but
> doesn't reproduce on kexec-tools 6aecc32c6db .
> 
> I. e. it is regression, introduced by aecc554e7ba .
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
> PRIx64 is ugly, but this is the only option left. So this is what I used in this version.
> 
> Also this patchset fixes other misc things. See commit messages for details.
> 
> I tested on my laptop that this patchset actually fixes the bug.
> 
> v1: https://lore.kernel.org/kexec/20250805124722.11193-1-safinaskar@zohomail.com/
> v2: https://lore.kernel.org/kexec/20250807032510.4211-1-safinaskar@zohomail.com/
> v3: https://lore.kernel.org/kexec/20250819090505.647690-1-safinaskar@zohomail.com/
> 
> Changes since v1:
> * Addressed Andy's comments
> * I reproduced the bug (and tested the fix) on slightly different versions of Linux
>    and linux-firmware (see first commit message)
> 
> Changes since v2:
> * Commit messages only
> 
> Changes since v3:
> * Commit messages only
> 
> Askar Safin (6):
>    Fix printf string specifiers, otherwise kexec doesn't work on my
>      laptop
>    kexec/kexec-elf-exec.c: Replace %lux with %lx
>    kexec/arch/i386/x86-linux-setup.c: replace %d with %u
>    util_lib/elf_info.c: fix typo: prink -> printk
>    kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
>    kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace
> 
>   kexec/arch/arm64/crashdump-arm64.c | 2 +-
>   kexec/arch/i386/crashdump-x86.c    | 3 ++-
>   kexec/arch/i386/kexec-x86-common.c | 4 ++--
>   kexec/arch/i386/x86-linux-setup.c  | 3 ++-
>   kexec/kexec-elf-exec.c             | 2 +-
>   util_lib/elf_info.c                | 9 +++++----
>   6 files changed, 13 insertions(+), 10 deletions(-)
> 


