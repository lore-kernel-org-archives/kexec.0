Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F7D35698
	for <kexec@archiver.kernel.org>; Wed, 28 Jan 2026 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BoOT159IPfGKxXMv8K83cK9v0RmGRCR8+x1pE/tXciE=; b=Ysxe6/mXf2gRzLSVRJ4/RQN6BN
	jQ4lW7iE2+MlXiYUk8e6WD3k1blnNG8YJ4eUR7pV5xGtx7ID0qQEbY1r/SpsOGDPfMANGkFuYEcp0
	HWN+hF00kgLz0eo4LK86i3xuNpzFDErtHhSQ2ewNg8VyIhl+UrdbHSzrTEkUsLY1g/OwIgz4keiPc
	6+eLqtV8DLylrDTxBJLJeKxzNPniKhe4O2J0a8BYbOIYHToJ+Lc/1bRm8+nEoY+P2mkKqZO33PS+h
	3GGf8miAn46OoVyOUAZqLZsQX9tvc1O2HLfC9Ylv8biR0eYtFVAHbUci/9bGNYefh+nW2T7arDQtS
	KG6I3sXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1on-0000000FkaF-47OO;
	Wed, 28 Jan 2026 09:26:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1oj-0000000FkZP-2ajk
	for kexec@lists.infradead.org;
	Wed, 28 Jan 2026 09:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769592386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoOT159IPfGKxXMv8K83cK9v0RmGRCR8+x1pE/tXciE=;
	b=gUEcQgnra2ny9I/27xeoJYXYQcowZTomLD5xwCn0gkABVPkaxmoGLErZkksu/BDgeE0hfA
	V+p//g/Cs8AibF+5UpaI0fpMGBP/HYX/cN6RHgf3JHzP8pe7QXx4P9MfuZSYNZBMKbyrjN
	bi1uE6G/bsVkHB7yk01y7xLZSMNTKTs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-yCSzNKM3M2OibcDVUkGhaQ-1; Wed,
 28 Jan 2026 04:26:20 -0500
X-MC-Unique: yCSzNKM3M2OibcDVUkGhaQ-1
X-Mimecast-MFC-AGG-ID: yCSzNKM3M2OibcDVUkGhaQ_1769592378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EDCC18005B0;
	Wed, 28 Jan 2026 09:26:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C835A195419A;
	Wed, 28 Jan 2026 09:26:15 +0000 (UTC)
Date: Wed, 28 Jan 2026 17:26:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Tushar Sugandhi <tusharsu@linux.microsoft.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Coiby Xu <coxu@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Ross Zwisler <zwisler@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kexec: derive purgatory entry from symbol
Message-ID: <aXnWMmyUMdbrqAiu@MiWiFi-R3L-srv>
References: <20260128043511.316860-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128043511.316860-1-me@linux.beauty>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_012629_736087_C9A15B1C 
X-CRM114-Status: GOOD (  32.12  )
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

On 01/28/26 at 12:35pm, Li Chen wrote:
> kexec_load_purgatory() derives image->start by locating e_entry inside an
> SHF_EXECINSTR section. If the purgatory object contains multiple executable
> sections with overlapping sh_addr, the entrypoint check can match more than
> once and trigger a WARN.
> 
> Derive the entry section from the purgatory_start symbol when present and
> compute image->start from its final placement. Keep the existing e_entry
> fallback for purgatories that do not expose the symbol.
> 
> WARNING: kernel/kexec_file.c:1009 at kexec_load_purgatory+0x395/0x3c0, CPU#10: kexec/1784
> Call Trace:
>  <TASK>
>  bzImage64_load+0x133/0xa00
>  __do_sys_kexec_file_load+0x2b3/0x5c0
>  do_syscall_64+0x81/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
> Signed-off-by: Li Chen <me@linux.beauty>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

By the way, a warning need be 'Fixes' tag and back ported to stable
kernel?

Thanks
Baoquan

> ---
> clangelog:
> v2: move the helper body above kexec_purgatory_setup_sechdrs() in v2 to avoid
> the forward declaration, as suggested by Baoquan.
> 
>  kernel/kexec_file.c | 131 +++++++++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3f1d6c4e8ff2..e9550bfbd02e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -880,6 +880,60 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
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
> +	const Elf_Shdr *sechdrs;
> +	const Elf_Ehdr *ehdr;
> +	const Elf_Sym *syms;
> +	const char *strtab;
> +	int i, k;
> +
> +	if (!pi->ehdr)
> +		return NULL;
> +
> +	ehdr = pi->ehdr;
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
> +					name, syms[k].st_shndx);
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
>  /*
>   * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
>   * @pi:		Purgatory to be loaded.
> @@ -958,6 +1012,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  	unsigned long offset;
>  	size_t sechdrs_size;
>  	Elf_Shdr *sechdrs;
> +	const Elf_Sym *entry_sym;
> +	u16 entry_shndx = 0;
> +	unsigned long entry_off = 0;
> +	bool start_fixed = false;
>  	int i;
>  
>  	/*
> @@ -975,6 +1033,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  	bss_addr = kbuf->mem + kbuf->bufsz;
>  	kbuf->image->start = pi->ehdr->e_entry;
>  
> +	entry_sym = kexec_purgatory_find_symbol(pi, "purgatory_start");
> +	if (entry_sym) {
> +		entry_shndx = entry_sym->st_shndx;
> +		entry_off = entry_sym->st_value;
> +	}
> +
>  	for (i = 0; i < pi->ehdr->e_shnum; i++) {
>  		unsigned long align;
>  		void *src, *dst;
> @@ -992,6 +1056,13 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  
>  		offset = ALIGN(offset, align);
>  
> +		if (!start_fixed && entry_sym && i == entry_shndx &&
> +		    (sechdrs[i].sh_flags & SHF_EXECINSTR) &&
> +		    entry_off < sechdrs[i].sh_size) {
> +			kbuf->image->start = kbuf->mem + offset + entry_off;
> +			start_fixed = true;
> +		}
> +
>  		/*
>  		 * Check if the segment contains the entry point, if so,
>  		 * calculate the value of image->start based on it.
> @@ -1002,13 +1073,14 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		 * is not set to the initial value, and warn the user so they
>  		 * have a chance to fix their purgatory's linker script.
>  		 */
> -		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> +		if (!start_fixed && sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
>  					 + sechdrs[i].sh_size) &&
> -		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
> +		    kbuf->image->start == pi->ehdr->e_entry) {
>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
> +			start_fixed = true;
>  		}
>  
>  		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
> @@ -1126,61 +1198,6 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
>  	return ret;
>  }
>  
> -/*
> - * kexec_purgatory_find_symbol - find a symbol in the purgatory
> - * @pi:		Purgatory to search in.
> - * @name:	Name of the symbol.
> - *
> - * Return: pointer to symbol in read-only symtab on success, NULL on error.
> - */
> -static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
> -						  const char *name)
> -{
> -	const Elf_Shdr *sechdrs;
> -	const Elf_Ehdr *ehdr;
> -	const Elf_Sym *syms;
> -	const char *strtab;
> -	int i, k;
> -
> -	if (!pi->ehdr)
> -		return NULL;
> -
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
> -}
> -
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
>  {
>  	struct purgatory_info *pi = &image->purgatory_info;
> -- 
> 2.52.0
> 


