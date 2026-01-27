Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BF7D2593F
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQViPQ8jqp6BXqY59Q4PpPvPb9kmHYBuT9rtqSSpXIY=; b=4YbpdMFM3ZQ5rBK/vDWuc9CovG
	zUUiDuN9ul5tMWsncSy34cuMuTrHx54mtFCNXMnBDb/1kEOh/z798TDjDzLR71t3sWmaJPR8DYspY
	J64BmBCBaoooZ6CBMGlBWoyTPsmOV7fukdzya91QGl9frql2ZXhnlDs9o2eZsExFBEP3a7APcYUHK
	uGMcfTVCdOJgLzJ0IL1P+HXGIPv/KWx03E96dl57IZAJ/p/KA7muQtME1AFLBdeqtAASUO2Gd3pKe
	SDMpOGU5TqnQyMkEGm80YiCq0O3fMVtqNrUWlXEiMxqBEwL4sIXC8VsLYpblzuRhNmK/K6gVyMyQ9
	LXQJbTSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkbxL-0000000DhGq-12Aq;
	Tue, 27 Jan 2026 05:49:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkbxH-0000000DhG5-3dHy
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 05:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769492973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQViPQ8jqp6BXqY59Q4PpPvPb9kmHYBuT9rtqSSpXIY=;
	b=cYAOaqcVxLPWqu850lmtrG93esSc5p4CNUE5vGSFGp6c4HmJAyDduPMw/BgBMtigXc42Sl
	+fxJPV7FHaJpVwTM2KfdIsCtF2uhIjs8yyO1qWyr1fBzwQ+1B7FtJEEc1RjLpHND9icF40
	Wbn/NZmwsNPAQCj8RUYXvOcgq1yEpUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-1nXIXkb9MrapWWMYmwp28Q-1; Tue,
 27 Jan 2026 00:49:29 -0500
X-MC-Unique: 1nXIXkb9MrapWWMYmwp28Q-1
X-Mimecast-MFC-AGG-ID: 1nXIXkb9MrapWWMYmwp28Q_1769492967
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6357019775A7;
	Tue, 27 Jan 2026 05:49:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.123])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9614018004D8;
	Tue, 27 Jan 2026 05:49:25 +0000 (UTC)
Date: Tue, 27 Jan 2026 13:49:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Steven Chen <chenste@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Ross Zwisler <zwisler@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: derive purgatory entry from symbol
Message-ID: <aXhRqvzeX2tUGvia@MiWiFi-R3L-srv>
References: <20260120124005.148381-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120124005.148381-1-me@linux.beauty>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_214935_983361_F086EDDF 
X-CRM114-Status: GOOD (  28.92  )
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

Hi Li Chen,

On 01/20/26 at 08:40pm, Li Chen wrote:
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

Thanks for fixing the issue. Could you tell how we can trigger this
issue so that I can reproduce it?

> ---
>  kernel/kexec_file.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3f1d6c4e8ff2..d3c68c6b4bbc 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -880,6 +880,8 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
> +static const Elf_Sym * kexec_purgatory_find_symbol(struct purgatory_info *pi,
> +			      const char *name);

Here, is it better to move the whole function body of
kexec_purgatory_find_symbol() here so that kexec_purgatory_setup_sechdrs()
can see it too?

Other than the concerns about how to reproducing and above one, this
patch looks good to me.

Thanks
Baoquan

>  /*
>   * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
>   * @pi:		Purgatory to be loaded.
> @@ -958,6 +960,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
> @@ -975,6 +981,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
> @@ -992,6 +1004,13 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
> @@ -1002,13 +1021,14 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
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
> -- 
> 2.52.0
> 
> 


