Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96CDC433EF
	for <kexec@archiver.kernel.org>; Wed,  1 Jun 2022 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=26snXz2g82AG98P9ngksSLBNjWZ/pJKx7M7ANThHlZ4=; b=2qizZsL9+foMD6
	CqOQb7YtP8oIUs1MecXaicd8CktzRDagIMWydVOCTBzGNKUchIVFdUusJziLViOXA2De8k2HTCRHv
	t5AQOHHOTTOQc63cErDr7/Ov7LlA+zzzvrcFG4vfjcPHaCcX5lKu3BUDyWNboRlqVaXxPgyUmYn0b
	mOGAUD11+vMJb78dZwsmyF8cUCJV/lwXN8Vva5urgoRq1mULWaHxcC7Gb/v+TJfvXaK5iIZeGcn57
	7z6jb7RBup2eMUrB0sOtRImbAXbZTT/BoZ6HRblr9pV87ZwrkMD8LpSgEsGM92vkne8laBFLdh+aJ
	/HBqexzPUwkRIfVx9GHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwR9l-00H6LD-K6; Wed, 01 Jun 2022 16:25:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwR7I-00H55W-DF; Wed, 01 Jun 2022 16:22:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Y4MMjPUMJE17uRA1W8JeqNIa3gV1RDtW27U/YpItROE=; b=PNPjea3Bdl437M1+0zPKZ4cwLN
	hFYNzny9457JNo5FUnAC5pAYinngm5Tzi532WmplRYl6mclmGlkBTPQV3EWbzjL1lJsdCgFHoFuKE
	xkLOTIBC7a3cNimiGIlT1XQgleDQ8LF8XeG1gAtwaqa4Iib1MdVEEyvODkxXbwqgTlo6BYnm50u2f
	T4VZjAUy88+ZiooYd85oj0NRQS8ZrJWdoH3QHSQWCpMEohMg0rVlF13Rh0cfgNc+F58qRHyEGWpcy
	jNiQZA2jP0hH7K9WKcTKhXLA7jvLD8Jvrqc783shML119GeiVR3I97cMu2AHW7pekIpxw5XCaxa82
	yN+8YoxA==;
Received: from [2601:1c0:6280:3f0::aa0b]
	by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwQlH-003pGW-Rj; Wed, 01 Jun 2022 15:59:57 +0000
Message-ID: <86c1aaa4-df2e-d541-e24e-2d1cc9537500@infradead.org>
Date: Wed, 1 Jun 2022 08:59:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] RISCV: kexec: Fix build error without CONFIG_MODULES
Content-Language: en-US
To: Li Zhengyu <lizhengyu3@huawei.com>, palmer@rivosinc.com
Cc: paul.walmsley@sifive.com, aou@eecs.berkeley.edu, liaochang1@huawei.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, kexec@lists.infradead.org, linux-next@vger.kernel.org
References: <20220601063924.13037-1-lizhengyu3@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220601063924.13037-1-lizhengyu3@huawei.com>
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



On 5/31/22 23:39, Li Zhengyu wrote:
> When CONFIG_MODULES is not set/enabled:
> 
> ../arch/riscv/kernel/elf_kexec.c:353:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
>   353 |         Elf_Rela *relas;
>       |         ^~~~~~~~
>       |         Elf64_Rela
> 
> Replace Elf_Rela by Elf64_Rela to avoid relying on CONFIG_MODULES.
> 
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  arch/riscv/kernel/elf_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 9cb85095fd45..0cb94992c15b 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -349,7 +349,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  {
>  	const char *strtab, *name, *shstrtab;
>  	const Elf_Shdr *sechdrs;
> -	Elf_Rela *relas;
> +	Elf64_Rela *relas;
>  	int i, r_type;
>  
>  	/* String & section header string table */

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
