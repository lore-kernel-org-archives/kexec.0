Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51AC433EF
	for <kexec@archiver.kernel.org>; Wed,  1 Jun 2022 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dfzmFIZItR8SO40M4EhDaBDpLDiGqRNRaFsbRys6j2s=; b=lWpP/dvO7m9Rw9
	BYHH6yaHdPUMtyzPq1V592Ktp6oRE9U9icnRPAi1CXfm+0pH7THBriMj9jfx7Y71kIs9gmik6fO48
	a+zoP1qHqCw4PypsGTRFzFXYtGS3hOGX2PSxIjcHXg4V9VvjxRband3s5eeoEt3TVTr7nd+hHM/Wo
	91Aj8b9NAbv7nkg4xx3tnxobZN/Yy5Tgxp/DdBPhOuBMOFHQO7NGANvUvjBuolzg9NduqifBWOmNp
	SKyXwoKiKTWi2acYaywmauhUTvWqlZsoJ6U15vIdneYdjitsi3wPYvCa4Cf2IQ7TCR+CCZkSpvKq5
	dabnAd06WLI8KpZzufvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwR9B-00H62N-RR; Wed, 01 Jun 2022 16:24:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwR7F-00H55W-Cd; Wed, 01 Jun 2022 16:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tTMeQSlVN/jki7gY30nXBiHUEabl86oFmR3MDB8WTos=; b=kyiJeT+HyMH3qWkHr4M/GNDhVQ
	he0vs1nHlDJumZTaCqAhyI7XGiLhP5COE+01Z7IJa+HwSy366FQWqStsxj1JqUM1nOswZsj7WWVeI
	4udEx97HSIXoUBnAgUA5MwNAseseUtVRx+w2cAKqZa+5neeh9UoFA37oFcXJs1Wo4h9wKKPB9KJo1
	t/Fdq7UooJyG1DN1qOm11lM0GpIH1WuWScjUsUQD6R24cKP2YYp0H/jsz0B1tliYLhv2pX0u2dcpG
	bB5mNALQC3eacnn7udZ6FPO5djIC58FGvpGACjmtP0Qe6JVqooWssI7hS0A8MX+pqK2iEoAbhqdoi
	VUq+pJaA==;
Received: from [2601:1c0:6280:3f0::aa0b]
	by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwQtS-003pQZ-7K; Wed, 01 Jun 2022 16:08:23 +0000
Message-ID: <b9c831a3-44ab-0374-34f8-8bd8bc311e5c@infradead.org>
Date: Wed, 1 Jun 2022 09:08:16 -0700
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

Hi--

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

BTW, does this mean that RISC-V kexec is only available on 64BIT
and not on 32BIT?

thanks.

> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
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
