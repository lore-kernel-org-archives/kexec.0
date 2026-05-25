Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A5CD5BC9
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+TFxqIXPU3VCPLnw7RW5OtUkFdNMFAF+NsqUfzupL4=; b=CYyL12FLvI4ayPz02bt8iiMV62
	HbrViyG8N3MA+aI6QA/ZDI6XWSdsf6LjUtIXhNSxqnmdSW0ql+3r6IotIM/08DvoXVHFzbg/95cTS
	md21uy9ht4o4hRJlJ0nK/LEKl0t05njY0iLw2W4l5d0xAlvQofNh/RyrLX7IADoblmIsIaXBzi4fU
	b3KTTQhd63Q32cjXFzUYj4vuIWw8rqo/qRKK5LCTDEisihMmqk7aNUzXZ5NuT8XRmKMf+YVSUihzE
	p/epKq+2Bdr9OV0jreX2E/UNsZsUonRHXqjGdRDtHUSQ+ls37Y6wgc2Mt6iExvuE/iho6fTKbFNrU
	DRXEnZBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRZBz-00000000920-0sCE;
	Mon, 25 May 2026 17:34:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRZBy-0000000091s-0Ppo
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 17:34:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 333DE60008;
	Mon, 25 May 2026 17:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793A91F000E9;
	Mon, 25 May 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779730456;
	bh=C+TFxqIXPU3VCPLnw7RW5OtUkFdNMFAF+NsqUfzupL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BLRQc51xnmjpgz7uLm3xMNEwcc1GYJVNNP7dDwDxorp/cxpwTcS5L9pSBA/55VMS2
	 n7FFwqL0UekJmAS3JpvGt7HRhu0m1d/50P0JAx5ozgQx5rgfmmsAuQPHAlr20cQEee
	 umscdxKjF/t31OQDGxK+wHqCFnZwvRueEx2gU01rnZo2wIgo+KqiVA7Vm4ywE+6yOy
	 QhpULFvc7mtx7R/IOyoYCej9/9eZRaJVrRPB1KOZ/XBbpwuOCbbToRWNWR7DWhqaWc
	 TGv6trHHWpX3PrJHUhdg+ObhA8ZLpHkZbwzc0quM8Mbb41lRlRhXX+iGNAGDathkVt
	 Dww60ge05YMjw==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  kernel@xen0n.name,  graf@amazon.com,
  shuah@kernel.org,  loongarch@lists.linux.dev,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  George Guo <guodongtai@kylinos.cn>,  Kexin
 Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH 1/7] LoongArch: Add KHO basic support
In-Reply-To: <20260525062810.103367-2-dongtai.guo@linux.dev> (George Guo's
	message of "Mon, 25 May 2026 14:28:04 +0800")
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
	<20260525062810.103367-2-dongtai.guo@linux.dev>
Date: Mon, 25 May 2026 19:34:13 +0200
Message-ID: <2vxztsrv5r6y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, May 25 2026, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
>
> Enable Kexec Handover on LoongArch64:
>
> - Kconfig: select ARCH_SUPPORTS_KEXEC_HANDOVER for 64BIT
> - machine_kexec_file: add cmdline_add_kho() to pass the KHO FDT and
>   scratch buffer addresses to the next kernel via the "kho_handover="
>   command-line parameter
> - setup: parse "kho_handover=" early and call kho_populate() to hand
>   memory regions to the KHO core
>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |  3 +++
>  arch/loongarch/kernel/machine_kexec_file.c | 22 ++++++++++++++++++
>  arch/loongarch/kernel/setup.c              | 27 ++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>
[...]
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index 5584b798ba46..ddf4d0e0e7fd 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -55,6 +55,24 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
>  	*cmdline_tmplen += initrd_strlen;
>  }
>  
> +#ifdef CONFIG_KEXEC_HANDOVER
> +/* Add "kho_handover=<fdt_size>@<fdt_addr>,<scratch_size>@<scratch_addr>" to cmdline. */
> +static void cmdline_add_kho(struct kimage *image, unsigned long *cmdline_tmplen,
> +			    char *modified_cmdline)
> +{
> +	int n;
> +
> +	if (!image->kho.fdt || !image->kho.scratch)
> +		return;
> +
> +	n = sprintf(modified_cmdline + *cmdline_tmplen,
> +	    "kho_handover=0x%llx@0x%llx,0x%lx@0x%llx ",
> +	    (u64)PAGE_SIZE,               image->kho.fdt,
> +	    image->kho.scratch->bufsz,    (u64)image->kho.scratch->mem);
> +	*cmdline_tmplen += n;

Do you have nothing else for a bootloader to pass data to the kernel?
Passing this via the command line seems crazy... All these addresses are
now available directly to unprivileged userspace. Can't you use the
device tree like we do on ARM64?

Also, this commandline parameter isn't documented anywhere.

> +}
> +#endif
> +
>  #ifdef CONFIG_CRASH_DUMP
>  
>  static int prepare_elf_headers(void **addr, unsigned long *sz)
> @@ -220,6 +238,10 @@ int load_other_segments(struct kimage *image,
>  		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
>  	}
>  
> +#ifdef CONFIG_KEXEC_HANDOVER
> +	cmdline_add_kho(image, &cmdline_tmplen, modified_cmdline);
> +#endif
> +
>  	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
>  		pr_err("Appending command line exceeds COMMAND_LINE_SIZE\n");
>  		ret = -EINVAL;
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 839b23edee87..5934ba6f13e3 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -48,6 +48,7 @@
>  #include <asm/setup.h>
>  #include <asm/time.h>
>  #include <asm/unwind.h>
> +#include <linux/kexec_handover.h>
>  
>  #define SMBIOS_BIOSSIZE_OFFSET		0x09
>  #define SMBIOS_BIOSEXTERN_OFFSET	0x13
> @@ -227,6 +228,32 @@ static int __init early_parse_mem(char *p)
>  }
>  early_param("mem", early_parse_mem);
>  
> +#ifdef CONFIG_KEXEC_HANDOVER
> +static int __init early_parse_kho(char *p)
> +{
> +	phys_addr_t fdt_addr, scratch_addr;
> +	u64 fdt_size, scratch_size;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	fdt_size = memparse(p, &p);
> +	if (*p++ != '@')

Can you please wrap these in parenthesis? I am too dumb to remember all
the precedence rules and this immediately makes me question whether we
are doing (*p)++ or *(p++).

> +		return -EINVAL;
> +	fdt_addr = memparse(p, &p);
> +	if (*p++ != ',')
> +		return -EINVAL;
> +	scratch_size = memparse(p, &p);
> +	if (*p++ != '@')
> +		return -EINVAL;
> +	scratch_addr = memparse(p, &p);
> +
> +	kho_populate(fdt_addr, fdt_size, scratch_addr, scratch_size);
> +	return 0;
> +}
> +early_param("kho_handover", early_parse_kho);
> +#endif
> +
>  static void __init arch_reserve_vmcore(void)
>  {
>  #ifdef CONFIG_PROC_VMCORE

-- 
Regards,
Pratyush Yadav

