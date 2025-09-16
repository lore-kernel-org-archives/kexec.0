Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB2CAC597
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqymUK0o/gtjDA+DSxafe5/sd/gWVsVOQwBD6bvjgNg=; b=fF/Qn0ydRSP478K0I1vZ2XBTwo
	qbUmgbYhQXaBl7saRG2Qe/ffQDhjOc7MX2xn+N5WmooWvp/21Gitx37nVR2xL9Wen/lgmexaSZm+F
	ZEI/BRv5ilDl/XMyPQgcFHEEgmxItP5cIEw5Nndg0Z4E1jofedlp4epXsw76hcARr5MVRUuipoDVX
	7A8QJwMjuEBCu38H6nZ0Uc+xa4Xa8o9MZbgUD9saCzyWf4bgTf9HTm+x8y9Tcvw47kwfsWO6dp/9T
	ywjJik3P6WQMXi46YV98y9Ig7y7SUe2v/6aQbt5GlC3/5ZZiSzkriWtBavZgii0ZlPhzhvv4OEVdg
	4OnfqZ0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKUV-000000069Xb-3iUT;
	Tue, 16 Sep 2025 01:28:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKUR-000000069WO-1ZWb
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757986092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqymUK0o/gtjDA+DSxafe5/sd/gWVsVOQwBD6bvjgNg=;
	b=bLHmP9IEXUoYrqo713J0AUvBX4yKZy1j0vP8ZoZLMrz59MMmjSu1Dj7NDFVpabfwpsiPt7
	4LW35Ln6HAxC+qP8dp2Rxf9SlatK8ZzJooW0Fn6M54wIl9dyr13DeUUsn4TInJlKLmJIYp
	+c1KPsA9kHiIwtBMNH8bZ5YDFZMT81U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-29APtI7xObGeh3pus7KrmQ-1; Mon,
 15 Sep 2025 21:28:08 -0400
X-MC-Unique: 29APtI7xObGeh3pus7KrmQ-1
X-Mimecast-MFC-AGG-ID: 29APtI7xObGeh3pus7KrmQ_1757986086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B430E180057A;
	Tue, 16 Sep 2025 01:28:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 510B419560A2;
	Tue, 16 Sep 2025 01:28:01 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:27:59 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 08/12] kexec: Factor out routine to find a symbol in ELF
Message-ID: <aMi9H7Jeuiq8mbyE@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250819012428.6217-9-piliu@redhat.com>
 <20250901163107.5a0c17e6@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901163107.5a0c17e6@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_182815_487563_D3AFF4E1 
X-CRM114-Status: GOOD (  28.74  )
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

On Mon, Sep 01, 2025 at 04:31:07PM +0200, Philipp Rudo wrote:
> On Tue, 19 Aug 2025 09:24:24 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
> 
> > The routine to search a symbol in ELF can be shared, so split it out.
> > 
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> > ---
> >  include/linux/kexec.h |  8 ++++
> >  kernel/kexec_file.c   | 86 +++++++++++++++++++++++--------------------
> >  2 files changed, 54 insertions(+), 40 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 8f7322c932fb5..2998d8da09d86 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -23,6 +23,10 @@
> >  #include <uapi/linux/kexec.h>
> >  #include <linux/verification.h>
> >  
> > +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> > +#include <linux/module.h>
> > +#endif
> > +
> 
> What is linux/module.h used for? Plus module.h already gets included a
> little below, when CONFIG_KEXEC_CORE is set, which should always be the
> case for those two configs.
> 

Yes, it should be dropped. Once I placed the declaration of
elf_find_symbol() here, and later moved it behind.


Thanks,

Pingfan

> Thanks
> Philipp
> 
> >  extern note_buf_t __percpu *crash_notes;
> >  
> >  #ifdef CONFIG_CRASH_DUMP
> > @@ -550,6 +554,10 @@ void set_kexec_sig_enforced(void);
> >  static inline void set_kexec_sig_enforced(void) {}
> >  #endif
> >  
> > +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> > +const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
> > +#endif
> > +
> >  #endif /* !defined(__ASSEBMLY__) */
> >  
> >  #endif /* LINUX_KEXEC_H */
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 4780d8aae24e7..137049e7e2410 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -880,6 +880,51 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  	return ret;
> >  }
> >  
> > +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> > +const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name)
> > +{
> > +	const Elf_Shdr *sechdrs;
> > +	const Elf_Sym *syms;
> > +	const char *strtab;
> > +	int i, k;
> > +
> > +	sechdrs = (void *)ehdr + ehdr->e_shoff;
> > +
> > +	for (i = 0; i < ehdr->e_shnum; i++) {
> > +		if (sechdrs[i].sh_type != SHT_SYMTAB)
> > +			continue;
> > +
> > +		if (sechdrs[i].sh_link >= ehdr->e_shnum)
> > +			/* Invalid strtab section number */
> > +			continue;
> > +		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
> > +		syms = (void *)ehdr + sechdrs[i].sh_offset;
> > +
> > +		/* Go through symbols for a match */
> > +		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> > +			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> > +				continue;
> > +
> > +			if (strcmp(strtab + syms[k].st_name, name) != 0)
> > +				continue;
> > +
> > +			if (syms[k].st_shndx == SHN_UNDEF ||
> > +			    syms[k].st_shndx >= ehdr->e_shnum) {
> > +				pr_debug("Symbol: %s has bad section index %d.\n",
> > +						name, syms[k].st_shndx);
> > +				return NULL;
> > +			}
> > +
> > +			/* Found the symbol we are looking for */
> > +			return &syms[k];
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +#endif
> > +
> >  #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
> >  /*
> >   * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
> > @@ -1137,49 +1182,10 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
> >  static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
> >  						  const char *name)
> >  {
> > -	const Elf_Shdr *sechdrs;
> > -	const Elf_Ehdr *ehdr;
> > -	const Elf_Sym *syms;
> > -	const char *strtab;
> > -	int i, k;
> > -
> >  	if (!pi->ehdr)
> >  		return NULL;
> >  
> > -	ehdr = pi->ehdr;
> > -	sechdrs = (void *)ehdr + ehdr->e_shoff;
> > -
> > -	for (i = 0; i < ehdr->e_shnum; i++) {
> > -		if (sechdrs[i].sh_type != SHT_SYMTAB)
> > -			continue;
> > -
> > -		if (sechdrs[i].sh_link >= ehdr->e_shnum)
> > -			/* Invalid strtab section number */
> > -			continue;
> > -		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
> > -		syms = (void *)ehdr + sechdrs[i].sh_offset;
> > -
> > -		/* Go through symbols for a match */
> > -		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> > -			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> > -				continue;
> > -
> > -			if (strcmp(strtab + syms[k].st_name, name) != 0)
> > -				continue;
> > -
> > -			if (syms[k].st_shndx == SHN_UNDEF ||
> > -			    syms[k].st_shndx >= ehdr->e_shnum) {
> > -				pr_debug("Symbol: %s has bad section index %d.\n",
> > -						name, syms[k].st_shndx);
> > -				return NULL;
> > -			}
> > -
> > -			/* Found the symbol we are looking for */
> > -			return &syms[k];
> > -		}
> > -	}
> > -
> > -	return NULL;
> > +	return elf_find_symbol(pi->ehdr, name);
> >  }
> >  
> >  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
> 


