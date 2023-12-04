Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4121FC10DC1
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qaTcVtkyfWA0vy2rP1DGbTPrOErd/LqoCsk4jIVy3IU=; b=izt/6WmPjLBhQ9
	LCHXZY+N/og6noNDZyCrk/X+G06o1AFMqq4GND9ykjxvZWDi07od9sMUPytIB3H1BR4QsYfJW50X3
	rAewweYneG+d5U2j+ogRP7jvdw395/QTtbe6kJJUHT6og+p0WnNm4i3X+gG/IwwFjH7xYVQi6OEmi
	MU3Opet7TUYdN0nFDApGtRthU14pMadzWf9Jj3353Rp8ib09lpD14O01HfldeUPVHjMFzCUzlnDN5
	Z/KCkk24ts1YSLMN4lBhnLfcpb4M0B/HLg5q0fSFFbSucE5KEhmqFrkRrFKwv5a5iHnahKxl5/bAB
	xekuvLEmTnwQ9nq6InxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEOM-005QOn-1Q;
	Mon, 04 Dec 2023 19:14:06 +0000
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEOJ-005QO4-3B;
	Mon, 04 Dec 2023 19:14:04 +0000
Message-ID: <694baf13-65d0-4877-b6c7-56e3006f83be@infradead.org>
Date: Mon, 4 Dec 2023 11:14:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv, crash: don't export some symbols when
 CONFIG_MMU=n
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
 ignat@cloudflare.com, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, eric_devolder@yahoo.com
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
 <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
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



On 12/3/23 18:19, Baoquan He wrote:
> When dropping select of KEXEC and dependency on ARCH_SUPPORTS_KEXEC
> from CRASH_DUMP, compiling error is reported when below config items are
> set:
> -----------------------
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ......
> -----------------------
> 

[]

> 
> Currently, riscv's ARCH_SUPPORTS_KEXEC has dependency on MMU. Before
> dropping ARCH_SUPPORTS_KEXEC, disabling CONFIG_MMU will unset
> CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE, CONFIG_CRASH_CORE. Hence
> crash_core related codes won't be compiled.
> 
> ---------------------
> arch/riscv/Kconfig:
> config ARCH_SUPPORTS_KEXEC
>         def_bool MMU
> ---------------------
> 
> After dropping ARCH_SUPPORTS_KEXEC, CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE,
> CONFIG_CRASH_CORE can be set independently of CONFIG_MMU. However, there
> are several macro definitions, such as VA_BITS, VMEMMAP_START, VMEMMAP_END,
> MODULES_VADDR, MODULES_END are only available when CONFIG_MMU=y. Then
> compiling errors are triggered.
> 
> Here, add CONFIG_MMU ifdeffery in arch_crash_save_vmcoreinfo() to export
> those symbols when CONFIG_MMU is enabled.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/riscv/kernel/crash_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> index 55f1d7856b54..8706736fd4e2 100644
> --- a/arch/riscv/kernel/crash_core.c
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -5,17 +5,19 @@
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> -	VMCOREINFO_NUMBER(VA_BITS);
>  	VMCOREINFO_NUMBER(phys_ram_base);
>  
>  	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
>  	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>  	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> +#ifdef CONFIG_MMU
> +	VMCOREINFO_NUMBER(VA_BITS);
>  	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>  	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>  #ifdef CONFIG_64BIT
>  	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>  	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> +#endif
>  #endif
>  	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
>  	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",

Both riscv 32-bit and 64-bit complain:

../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
../arch/riscv/kernel/crash_core.c:11:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
   11 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
      |                                                        ~~^
      |                                                          |
      |                                                          long unsigned int
      |                                                        %x


Otherwise this builds without failure.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
