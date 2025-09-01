Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A89CA100A
	for <kexec@archiver.kernel.org>; Mon,  1 Sep 2025 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WORofZeX3z76hZpMBN9yEa/RAp7XcwKQ/AeKOIO9YYI=; b=mzuWtEvlrMjk2FTc0FesAQvC9s
	nfEhD6+FLSa2jnH3zUGi9cx2hJs6NuhGDFvGaAx+pSyLs0jdCV9HH0bTsnzWHktyWKp9Bma+tc+ne
	J5WXVK75FZ6yv3/dB0pdkLJcLs/1YwVHIuWKRFxOyeznN1GWqEI9+DcaC8gS5vh/BqC66iiAsVqhw
	9eMUISC+vWz9UZsHvA5R/kAw9uutRjbsNylNMZOukJXjkF1VAUPOjJwWq/llJ0ByE7eTgJIfKwzn9
	lgvipr3HGFz+WM/Qc5kJoEzPDE0OeUbTOR48e1KJW8IhFU24eoBTiH3Ix6gfcIsTj0q99n+QjwwvY
	OU0cklpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut8gC-0000000DUym-0vDk;
	Mon, 01 Sep 2025 17:50:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5ZH-0000000CqWS-29UM
	for kexec@bombadil.infradead.org;
	Mon, 01 Sep 2025 14:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WORofZeX3z76hZpMBN9yEa/RAp7XcwKQ/AeKOIO9YYI=; b=fawOqEDL7Bv1gqWXcbmN/vINDK
	E/s4llCgeOKtH0UfytBRrGeW6SPm08MQa6Cw1qKBG6+x2is0oijPluQa67//cZPNAOXbbYupL3HKd
	jRCgTp+WNlhp+FnGicMIT+KBGqa6hWlnqw05zQZYk4dbSoRWx4o28dC89oaoIkBaJ7i3A5Nd3n0b+
	lQLDMAnPB5hjAXEQkyzWuK2vqGzimFlVWQ5RSBoBm2nBtmqaWcqrnyKgSDO9erZm/RpF8cYmBQhSa
	iQ+I8W7abeuc5z2rSGmZnTSS5K6WPIMCtkJeySgG2Q+thU6nSqxhD1UoCCG6ap0fRzm3imxYgwqUQ
	n0p1bGJw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5ZE-00000003lrs-2ldt
	for kexec@lists.infradead.org;
	Mon, 01 Sep 2025 14:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WORofZeX3z76hZpMBN9yEa/RAp7XcwKQ/AeKOIO9YYI=;
	b=dFEFXgveVidjp+XSvPG49YVESiUeK/9VpCh71P700wp1cDb+euVxoPUaEQ5/rVoL61u+pz
	PGytOELGvIp8EOTlHiJfoGhm6zjRaSImUPKSrrxF0NKl1T+1aJSfhouOkg6l4eGto3PP8u
	GWNk/qtWpVc2wIgI08QENcg0BRW0T4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WORofZeX3z76hZpMBN9yEa/RAp7XcwKQ/AeKOIO9YYI=;
	b=PAHrd9uBGMnAmvtK98ynrlNFeruQbPtz96WBPEV8DqxML+s6lTr4ecwsKSKY5LgyDuQzZt
	z7RoNe6rS1vd6Bg6mqkDZZeMwwlZJvhTt5Ku1/yg3SivQb4+Afrl+ePMLnpCwfVLAKjU/e
	CdT56/nsX5Kp8Lh7427FxPlP+k+/uVI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-5FrfhvZgOGqHXGRSWnj9Qw-1; Mon,
 01 Sep 2025 10:31:23 -0400
X-MC-Unique: 5FrfhvZgOGqHXGRSWnj9Qw-1
X-Mimecast-MFC-AGG-ID: 5FrfhvZgOGqHXGRSWnj9Qw_1756737080
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16CBE18002CC;
	Mon,  1 Sep 2025 14:31:20 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.224.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A469F1800291;
	Mon,  1 Sep 2025 14:31:11 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:31:07 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 08/12] kexec: Factor out routine to find a symbol in
 ELF
Message-ID: <20250901163107.5a0c17e6@rotkaeppchen>
In-Reply-To: <20250819012428.6217-9-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
	<20250819012428.6217-9-piliu@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_153132_959171_AFC71460 
X-CRM114-Status: GOOD (  26.19  )
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

On Tue, 19 Aug 2025 09:24:24 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> The routine to search a symbol in ELF can be shared, so split it out.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec@lists.infradead.org
> ---
>  include/linux/kexec.h |  8 ++++
>  kernel/kexec_file.c   | 86 +++++++++++++++++++++++--------------------
>  2 files changed, 54 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8f7322c932fb5..2998d8da09d86 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -23,6 +23,10 @@
>  #include <uapi/linux/kexec.h>
>  #include <linux/verification.h>
>  
> +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> +#include <linux/module.h>
> +#endif
> +

What is linux/module.h used for? Plus module.h already gets included a
little below, when CONFIG_KEXEC_CORE is set, which should always be the
case for those two configs.

Thanks
Philipp

>  extern note_buf_t __percpu *crash_notes;
>  
>  #ifdef CONFIG_CRASH_DUMP
> @@ -550,6 +554,10 @@ void set_kexec_sig_enforced(void);
>  static inline void set_kexec_sig_enforced(void) {}
>  #endif
>  
> +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> +const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
> +#endif
> +
>  #endif /* !defined(__ASSEBMLY__) */
>  
>  #endif /* LINUX_KEXEC_H */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 4780d8aae24e7..137049e7e2410 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -880,6 +880,51 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	return ret;
>  }
>  
> +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> +const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name)
> +{
> +	const Elf_Shdr *sechdrs;
> +	const Elf_Sym *syms;
> +	const char *strtab;
> +	int i, k;
> +
> +	sechdrs = (void *)ehdr + ehdr->e_shoff;
> +
> +	for (i = 0; i < ehdr->e_shnum; i++) {
> +		if (sechdrs[i].sh_type != SHT_SYMTAB)
> +			continue;
> +
> +		if (sechdrs[i].sh_link >= ehdr->e_shnum)
> +			/* Invalid strtab section number */
> +			continue;
> +		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
> +		syms = (void *)ehdr + sechdrs[i].sh_offset;
> +
> +		/* Go through symbols for a match */
> +		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> +			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> +				continue;
> +
> +			if (strcmp(strtab + syms[k].st_name, name) != 0)
> +				continue;
> +
> +			if (syms[k].st_shndx == SHN_UNDEF ||
> +			    syms[k].st_shndx >= ehdr->e_shnum) {
> +				pr_debug("Symbol: %s has bad section index %d.\n",
> +						name, syms[k].st_shndx);
> +				return NULL;
> +			}
> +
> +			/* Found the symbol we are looking for */
> +			return &syms[k];
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
>  /*
>   * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
> @@ -1137,49 +1182,10 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
>  static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
>  						  const char *name)
>  {
> -	const Elf_Shdr *sechdrs;
> -	const Elf_Ehdr *ehdr;
> -	const Elf_Sym *syms;
> -	const char *strtab;
> -	int i, k;
> -
>  	if (!pi->ehdr)
>  		return NULL;
>  
> -	ehdr = pi->ehdr;
> -	sechdrs = (void *)ehdr + ehdr->e_shoff;
> -
> -	for (i = 0; i < ehdr->e_shnum; i++) {
> -		if (sechdrs[i].sh_type != SHT_SYMTAB)
> -			continue;
> -
> -		if (sechdrs[i].sh_link >= ehdr->e_shnum)
> -			/* Invalid strtab section number */
> -			continue;
> -		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
> -		syms = (void *)ehdr + sechdrs[i].sh_offset;
> -
> -		/* Go through symbols for a match */
> -		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> -			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> -				continue;
> -
> -			if (strcmp(strtab + syms[k].st_name, name) != 0)
> -				continue;
> -
> -			if (syms[k].st_shndx == SHN_UNDEF ||
> -			    syms[k].st_shndx >= ehdr->e_shnum) {
> -				pr_debug("Symbol: %s has bad section index %d.\n",
> -						name, syms[k].st_shndx);
> -				return NULL;
> -			}
> -
> -			/* Found the symbol we are looking for */
> -			return &syms[k];
> -		}
> -	}
> -
> -	return NULL;
> +	return elf_find_symbol(pi->ehdr, name);
>  }
>  
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)


