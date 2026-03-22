Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A0109449D
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9xwbhvzIjT5bVCJDoLowew73QfoAtjWr+M5UnXdhfA=; b=TPiot3969h8if7O4J6PMqcDWxQ
	uqDfY1P8dQoiaMCfRYQT8qyIHcebCTuajtvPBDwIdcYfu+toNPSPgUC5TOcscB5qyxcKhvjK0CaR6
	Ydyt/PWjAH0Jspjm1EbvqRi67HEbyDjBHIYd8WB3FDM9SfbM2jRLcqdw+Zz4ROY78ClxxLqBYEG3f
	VKvClZcM27kfHJIVzKQiCQgvr7rXNm+OruhsdrF8uodRgkjGClYHVj6rpTlYGExm6epoSQYJN7Oh6
	imDlE/cZUIlODY3O1v43Q2/Ofa+A3RlabbRUCD2Jvh9JgWMA0grTDxULTu8ZwuEIUi0B8tByLjf8a
	jWEJLOZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kh-0000000EyWh-3txS;
	Sun, 22 Mar 2026 02:14:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kf-0000000EyVn-2PgN
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:14:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4CC7C4057F;
	Sun, 22 Mar 2026 02:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95245C19421;
	Sun, 22 Mar 2026 02:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145663;
	bh=ibkg0hUDaHSquvJiw9fLUlUJMQPpW5WvFb8EW0OtB8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=T6GUD+ltgyRc5sZDn5A2J+iT7/tlrFelT47++ebMHB4mUSM8ZMI4R496cS1gVux5u
	 7nH06kAReNECcCV0FVZeqY4a11yhroZyhMmofgwqWYdSQ9cGNHcHDIG8JaXJ/A28hD
	 49ro6hm7eLZ8+PfiPM6HHhulEdotTzuOBjnkUDWpc1LPUgHuQeATyarER1lfUb65Oy
	 iA2LAhMDGHyAWMO+Vx8HAwIO+0khNyL98EoBD775zDzlqZMZiWf483UN0usEunoInK
	 WgZDG+9DsPOCaStCPo8cKxku/XhgqH4XFrAKaJ3GQx3LhNiIp7v0tA1PXkFvg7wMjI
	 KiMvUdl0eLKUA==
Content-Type: multipart/mixed; boundary="===============1586895263872930562=="
MIME-Version: 1.0
Message-Id: <63bd4ac4ee54ffef11b068d524e9b59c768ed2b4f7de313b509d8568c48da66e@mail.kernel.org>
In-Reply-To: <20260322014402.8815-9-piliu@redhat.com>
References: <20260322014402.8815-9-piliu@redhat.com>
Subject: Re: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol in ELF
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:22 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_191425_656048_50EBF876 
X-CRM114-Status: GOOD (  15.23  )
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

--===============1586895263872930562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c

[ ... ]

> @@ -1221,6 +1266,22 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
> 	return ret;
>  }
>
> +/*
> + * kexec_purgatory_find_symbol - find a symbol in the purgatory
> + * @pi:		Purgatory to search in.
> + * @name:	Name of the symbol.
> + *
> + * Return: pointer to symbol in read-only symtab on success, NULL on error.
> + */
> +static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
> +						  const char *name)
> +{
> +	if (!pi->ehdr)
> +		return NULL;
> +
> +	return elf_find_symbol(pi->ehdr, name);
> +}

This adds a new wrapper kexec_purgatory_find_symbol() here, but the
original full implementation of kexec_purgatory_find_symbol() earlier
in the file was not removed:

kernel/kexec_file.c:kexec_purgatory_find_symbol() {
    ...
    ehdr = pi->ehdr;
    sechdrs = (void *)ehdr + ehdr->e_shoff;

    for (i = 0; i < ehdr->e_shnum; i++) {
        ...
    }

    return NULL;
}

Both definitions are static and live inside the same
#ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY block, so this will fail
to compile on any architecture that selects that config (x86, s390,
powerpc, riscv).

It looks like the old function body should have been replaced with
the new elf_find_symbol() wrapper, as was done in v5 of this series.
Was the deletion of the old body lost during a rebase?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============1586895263872930562==--

