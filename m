Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4988C0015E
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gbI0n2lWiqF87f3WLO45LidRdO5jrECxtsa7TkYYu+8=; b=hw4+kn6Jo5pfP6
	RmGn4LvxkM1Vl7DVGvGsKCZipaRges4Te/O5KMrjbcfb5CDGM1oIwWaejIydsA5W2Ks3kCPWlMs06
	3m6rPFWtQkUrPGH3LpCk6ZJXF4vjeHEOxkmpldntNlFLGDjP+O8AF0KCyuM/pivD/dDuLdcFe7YNW
	bPebnynAtukBaKsnmbc7tjqN80GODhEl0vvILvNuVEsfc0OMD1xqcIguRr7zgLiEeB2n+tQ5pN0M/
	sPbehqXpzwd+d0Hi//qM0of/UAPx1xbCfL/tOzpSkGJKdQ3X7M7e6ZtiYAwZ0c3hkqbqTY9ccMNqG
	FKFOsI780t8NDU622fnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOCki-006eYf-2T;
	Tue, 25 Jul 2023 07:46:40 +0000
Received: from relay8-d.mail.gandi.net ([2001:4b98:dc4:8::228])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOCkd-006eXH-38;
	Tue, 25 Jul 2023 07:46:38 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7306D1BF20C;
	Tue, 25 Jul 2023 07:46:22 +0000 (UTC)
Message-ID: <aee383e3-0e62-716e-4b07-f7557d63cc74@ghiti.fr>
Date: Tue, 25 Jul 2023 09:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
Content-Language: en-US
To: Song Shuai <suagrfillet@gmail.com>, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
 anup@brainfault.org, robh@kernel.org, ajones@ventanamicro.com,
 alexghiti@rivosinc.com, conor.dooley@microchip.com
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230724100917.309061-1-suagrfillet@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
X-GND-Sasl: alex@ghiti.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_004636_150073_3F0A8BB4 
X-CRM114-Status: GOOD (  14.37  )
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


On 24/07/2023 12:09, Song Shuai wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
> from the physical start of the kernel to the actual start of the DRAM.
>
> The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].
>
> Export kernel_map.va_kernel_pa_offset in vmcoreinfo to help Crash translate
> the kernel virtual address correctly.
>
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/ [1]
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>   arch/riscv/kernel/crash_core.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> index b351a3c01355..55f1d7856b54 100644
> --- a/arch/riscv/kernel/crash_core.c
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -18,4 +18,6 @@ void arch_crash_save_vmcoreinfo(void)
>   	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>   #endif
>   	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> +	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
> +						kernel_map.va_kernel_pa_offset);
>   }


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for that and for the instructions on how to reproduce the problem 
BTW!

Alex



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
