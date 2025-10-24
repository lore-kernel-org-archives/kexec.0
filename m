Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEF3CCD1A5
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 07:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJpu9jNeG/9AHqtuVmrf1mdpbO23IJsdx1yWPp+AZv8=; b=Z62C/pGPdo4ep/X/WlANUz8p7A
	lCKTdRwe2UkK/Ur9LkZbnW33wDD6Rrd/50yfpASvY7rmGM+d+M9Qf5G885NrhgT57Sf92l4VRG9Gs
	6WRx9XrnJDBuTp4FCd1AEj5MhtTL1gKI6Btqlug0voEmmrC9tyW1ZKuljpv087NI5kC3hu5kZ1LdE
	v6yERcgp0IgZdDbaWJF+39xTYY17QtV0fun0fOQzYmAZBWq4pf55d5/AmJx3E8EyT0WjB7izAGMbv
	TPVeDMVr+SW19FWNpIyPN1GH7fnZ02/3w7qtOQwxkpDj8eTaXWbRdYskZwfDN9NQPM3p8Ucgdr6gV
	t1KWcPfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCBu2-00000008QC3-1Qfc;
	Fri, 24 Oct 2025 07:07:58 +0000
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCBty-00000008Q8A-2P6V
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 07:07:56 +0000
Message-ID: <d327af2b-8089-4d1b-8f7f-9f18c0d9faba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761289671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJpu9jNeG/9AHqtuVmrf1mdpbO23IJsdx1yWPp+AZv8=;
	b=cIRh5nFOYHb6pF8W1pDgnMpBx3yfZ+vT+k8OKL4renNzvsbG3YwZjaVL2tEjNRluaJMKZt
	noGOXGtoSBhgmWSOrdo3DdHFZjsXW4A2dU1CwLkyZkVCCTn9c68E5sIzJoZS7HJD0eHa5W
	pL693ktqobj4sgZBoAIMN7pEIyeAmsY=
Date: Fri, 24 Oct 2025 15:06:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] LoongArch: kexec: Initialize kexec_buf struct
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>,
 Youling Tang <tangyouling@kylinos.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251024063653.35492-1-youling.tang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20251024063653.35492-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_000754_894848_4F5A9047 
X-CRM114-Status: GOOD (  16.16  )
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

cc to loongarch@lists.linux.dev and linux-kernel@vger.kernel.org


On 10/24/25 14:36, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
>
> The kexec_buf structure was previously declared without initialization.
> commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> added a field that is always read but not consistently populated by all
> architectures. This un-initialized field will contain garbage.
>
> This is also triggering a UBSAN warning when the uninitialized data was
> accessed:
>
>          ------------[ cut here ]------------
>          UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>          load of value 252 is not a valid value for type '_Bool'
>
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
>
> Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> Link: https://lore.kernel.org/r/20250827-kbuf_all-v1-2-1df9882bb01a@debian.org
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   arch/loongarch/kernel/kexec_efi.c          | 2 +-
>   arch/loongarch/kernel/kexec_elf.c          | 2 +-
>   arch/loongarch/kernel/machine_kexec_file.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> index 45121b914f8f..5ee78ebb1546 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -42,7 +42,7 @@ static void *efi_kexec_load(struct kimage *image,
>   {
>   	int ret;
>   	unsigned long text_offset, kernel_segment_number;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>   	struct kexec_segment *kernel_segment;
>   	struct loongarch_image_header *h;
>   
> diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/kexec_elf.c
> index 97b2f049801a..1b6b64744c7f 100644
> --- a/arch/loongarch/kernel/kexec_elf.c
> +++ b/arch/loongarch/kernel/kexec_elf.c
> @@ -59,7 +59,7 @@ static void *elf_kexec_load(struct kimage *image,
>   	int ret;
>   	unsigned long text_offset, kernel_segment_number;
>   	struct elfhdr ehdr;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>   	struct kexec_elf_info elf_info;
>   	struct kexec_segment *kernel_segment;
>   
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index dda236b51a88..fb57026f5f25 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -143,7 +143,7 @@ int load_other_segments(struct kimage *image,
>   	unsigned long initrd_load_addr = 0;
>   	unsigned long orig_segments = image->nr_segments;
>   	char *modified_cmdline = NULL;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>   
>   	kbuf.image = image;
>   	/* Don't allocate anything below the kernel */

