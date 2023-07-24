Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314ACC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRxLwERwVnQpZnVad646lEm8NiAteX4TSocc8qo63J0=; b=q8ie76I6oubP++
	FXKTbrqERpGjQPmtrTbvH9OXYXvSWoAfvjlWgukzuy3qd8GccovAUdrAxopjjYQvZZY5LHEYEPCGq
	xNNEH/x5vFIu2y2CFuYCx3/GA02DJee81esW+Td6LenPamyDTjU7Mpce/jKPDltQtu4LN74BiZ0f5
	KvldxM8yrjwk8LNJWlBNS5CHzfwJoRQOmNnNaLzCWy+TvullaJ9C6XjAFcgmVb3WjPsgJTiwr9XA1
	EGOaMK5DxwRD6pK39tP00tB+z8HgsjbXh9H7/AJ/XKCJttxQGUwT/DjDF32vM+OZMTsefDao7UOlG
	drRJbNbNMax7Zfa3Y2AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNqhc-003CxG-1b;
	Mon, 24 Jul 2023 08:14:00 +0000
Received: from relay1-d.mail.gandi.net ([2001:4b98:dc4:8::221])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNqhR-003Cn2-2R;
	Mon, 24 Jul 2023 08:13:59 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71481240004;
	Mon, 24 Jul 2023 08:13:39 +0000 (UTC)
Message-ID: <db0ebf87-39ee-0b44-6b07-6adb7b976cb8@ghiti.fr>
Date: Mon, 24 Jul 2023 10:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
Content-Language: en-US
To: Song Shuai <suagrfillet@gmail.com>, xianting.tian@linux.alibaba.com,
 mick@ics.forth.gr, heinrich.schuchardt@canonical.com, guoren@kernel.org,
 k-hagio-ab@nec.com, yixun.lan@gmail.com, lijiang@redhat.com
Cc: linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
 crash-utility@redhat.com
References: <20230724040649.220279-1-suagrfillet@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230724040649.220279-1-suagrfillet@gmail.com>
X-GND-Sasl: alex@ghiti.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_011350_113141_7E63943B 
X-CRM114-Status: GOOD (  25.50  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Song,


On 24/07/2023 06:06, Song Shuai wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes the
> phys_ram_base from the kernel_map.phys_addr to the start of DRAM.


Maybe we could be more explicit here, kernel_map.phys_addr actually 
points to the physical start of the kernel so maybe something like that:

"changes phys_ram_base from the physical start of the kernel to the 
actual start of the DRAM."


>
> The Crash's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that made Crash boot failed with
> Linux v6.4 and later version.
>
> Let Linux export kernel_map.va_kernel_pa_offset in v6.5 and Crash can
> use "va_kernel_pa_offset" to translate the kernel virtual address in
> VTOP() correctly.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
> You can check/test the Linux changes from this link:
> https://github.com/sugarfillet/linux/commits/6.5-rc3-crash
>
> And I'll send the Linux changes to riscv/for-next If you're ok with this patch.
> ---
>   defs.h    |  4 ++--
>   riscv64.c | 22 ++++++++++++++++++++++
>   2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/defs.h b/defs.h
> index 358f365..46b9857 100644
> --- a/defs.h
> +++ b/defs.h
> @@ -3662,8 +3662,7 @@ typedef signed int s32;
>   	ulong _X = X;									\
>   	(THIS_KERNEL_VERSION >= LINUX(5,13,0) &&					\
>   		(_X) >= machdep->machspec->kernel_link_addr) ?				\
> -		(((unsigned long)(_X)-(machdep->machspec->kernel_link_addr)) +		\
> -		 machdep->machspec->phys_base):						\
> +		((unsigned long)(_X)-(machdep->machspec->va_kernel_pa_offset)): 	\
>   		(((unsigned long)(_X)-(machdep->kvbase)) +				\
>   		 machdep->machspec->phys_base);						\
>   	})
> @@ -7021,6 +7020,7 @@ struct machine_specific {
>   	ulong modules_vaddr;
>   	ulong modules_end;
>   	ulong kernel_link_addr;
> +	ulong va_kernel_pa_offset;
>   
>   	ulong _page_present;
>   	ulong _page_read;
> diff --git a/riscv64.c b/riscv64.c
> index 6b9a688..b9e50b4 100644
> --- a/riscv64.c
> +++ b/riscv64.c
> @@ -418,6 +418,27 @@ error:
>   	error(FATAL, "cannot get vm layout\n");
>   }
>   
> +static void
> +riscv64_get_va_kernel_pa_offset(struct machine_specific *ms)
> +{
> +	unsigned long kernel_version = riscv64_get_kernel_version();
> +
> +	/*
> +	 * va_kernel_pa_offset is defined in Linux kernel since 6.5.
> +	 */
> +	if (kernel_version >= LINUX(6,5,0)) {
> +		char *string;
> +		if ((string = pc->read_vmcoreinfo("NUMBER(va_kernel_pa_offset)"))) {
> +			ms->va_kernel_pa_offset = htol(string, QUIET, NULL);
> +			free(string);
> +		} else
> +			error(FATAL, "cannot read va_kernel_pa_offset\n");
> +	} else if (kernel_version >= LINUX(6,4,0))
> +		error(FATAL, "cannot determine va_kernel_pa_offset since Linux 6.4\n");
> +	else
> +		ms->va_kernel_pa_offset = ms->kernel_link_addr - ms->phys_base;
> +}
> +
>   static int
>   riscv64_is_kvaddr(ulong vaddr)
>   {
> @@ -1352,6 +1373,7 @@ riscv64_init(int when)
>   		riscv64_get_struct_page_size(machdep->machspec);
>   		riscv64_get_va_bits(machdep->machspec);
>   		riscv64_get_va_range(machdep->machspec);
> +		riscv64_get_va_kernel_pa_offset(machdep->machspec);
>   
>   		pt_level_alloc(&machdep->pgd, "cannot malloc pgd space.");
>   		pt_level_alloc(&machdep->machspec->p4d, "cannot malloc p4d space.");


Would you mind giving me the instructions on how to reproduce the issue 
please? So that I can add that to our internal CI and avoid this type of 
breakage in the future.

Thanks,

Alex


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
