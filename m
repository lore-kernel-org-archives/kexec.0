Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF12E77188
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkGxFueoVINi5fyFIRpdOxzuvoQHxYoJE4cR1nHWUKA=; b=kqqzyLFjcbfbyr2QS5i2v5lnme
	7PJ34YlUL34PbpS3Uv9KSEnb7tf55LqI7UHUgY2VXNuAaLzE95MLpckv86OMrI7mDDG2+NtXJHGwG
	RNarY6Ddr/pjJAiSBvkK66tQiM/y6LBtgIN01kwqE6//D4JisqwtkWDX4kWzsTJchF5iu+bZ7Lxh6
	9VJbRMuwv2AMjL9fLGgNNvzpAKUN474G83POEWNLHF66OIW1LRqTsxs+I1Zxv8kJTyTYPF7eV+IQG
	LcAlErxUSKkB8jmAs0fxXOzBUxiDSRaI95n+Rtv2bz6S9TPNSejuDqT0ssYBk4hxEC1a9JoYyRSJY
	T2PERtdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoaB-00000001h6g-0ZtT;
	Mon, 06 Jan 2025 14:59:55 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoSR-00000001eeX-125A
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 14:51:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B98143D;
	Mon,  6 Jan 2025 06:52:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24D7D3F59E;
	Mon,  6 Jan 2025 06:51:52 -0800 (PST)
Date: Mon, 6 Jan 2025 14:51:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 5/5] crash: Remove KEXEC_CORE_NOTE_NAME
Message-ID: <Z3vuBTiQvnRvv9DQ@e133380.arm.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-5-77dc2e06db4e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-5-77dc2e06db4e@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_065155_377634_FB9AB373 
X-CRM114-Status: GOOD (  19.54  )
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

On Sat, Jan 04, 2025 at 11:38:38PM +0900, Akihiko Odaki wrote:
> Now KEXEC_CORE_NOTE_NAME is only used at one place and it does not seem
> to provide any value anymore. Replace the remaining usage with the
> literal and remove the macro.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/s390/kernel/crash_dump.c | 2 +-
>  include/linux/kexec.h         | 2 --
>  include/linux/vmcore_info.h   | 1 -
>  3 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index cd0c93a8fb8b..4a9817489e35 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -253,7 +253,7 @@ static const char *nt_name(Elf64_Word type)
>  	const char *name = "LINUX";
>  
>  	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
> -		name = KEXEC_CORE_NOTE_NAME;
> +		name = "CORE";

If I've understood the code here correctly, the note type is supplied
at all the nt_init() and nt_size() call sites, so instead of this hack
can we wrap those in macros that get the formal name from elf.h rather
than guessing it here?  e.g.:

#define nt_size(..., note, ...) \
	__nt_size(..., NT ## _ ## note, NN ## _ ## note, ...)

etc.

The compiler is quite likely to fold away most of the implied
duplication of code (it would be interesting to look at the compiler
output) -- but anyway, this is super-slow-path: nobody expects realtime
response when the kernel has crashed.

[...]

Cheers
---Dave

