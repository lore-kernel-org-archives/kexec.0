Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97AACAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZoP7xI9bh5cuZAC2MMMkkaHSM2qArN4UzTRm8GitpU=; b=WApgFbwnIBzOxqbTPYgrqynD4b
	LCQdPMLjHwWoauhzu4r/Gqe/S9JyuUXLD9wD8KpURxyErE2iOm3gFvUK6o1yKXOr4xP09hanLrWAO
	gKdYWQROOrvjCMpEeL8YwQEgagzQnuJPQysqmc3CsnXcUBA8SwVAaTSrtvScNcAq62aSX5FwzBjv/
	AQNeCvFiqkVVYtG797fv1K5QtdfBjtBnEv1jy6oBCwSQsrldfgBKRZW1K7Z0gAuxlN7qx3+G4TkLK
	wcPpKwLfxWr2gGTMPcJoGvqG2W97+L2odIzMvoRfckxoP5BYYoEVhm8z/tR2K/Qs5CNfgF/zIZis9
	ai7ZjD+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyr6m-0000000BH04-3EiX;
	Wed, 17 Sep 2025 12:18:00 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uypXP-0000000B0VC-1NJF
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 10:37:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CAD71F7BC;
	Wed, 17 Sep 2025 10:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758105441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZoP7xI9bh5cuZAC2MMMkkaHSM2qArN4UzTRm8GitpU=;
	b=kNJ/uzXVRbTatfy05IVGNQLIzQ9yPArYK0Vuo18L+EvSl9LkJwvDxVTm6ipLRjopRYl37Q
	lmkvpfx9V6hiDWJ3AUH0fo1eVRtgsuz3WXVd+0UCwW7ZT7gSDrbreDLFTElddZkurFO0tw
	GBvYGseZhe+WcZcn66UCFBOvcVxQJvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758105441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZoP7xI9bh5cuZAC2MMMkkaHSM2qArN4UzTRm8GitpU=;
	b=lCKrd/3SMkAsu71vkV/44IEKXQSRO5fArYajtSwRNnnRLyN7UEpS4+bqwddhUAybMv2xHJ
	mWtV6X5XQFK+a+CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758105441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZoP7xI9bh5cuZAC2MMMkkaHSM2qArN4UzTRm8GitpU=;
	b=kNJ/uzXVRbTatfy05IVGNQLIzQ9yPArYK0Vuo18L+EvSl9LkJwvDxVTm6ipLRjopRYl37Q
	lmkvpfx9V6hiDWJ3AUH0fo1eVRtgsuz3WXVd+0UCwW7ZT7gSDrbreDLFTElddZkurFO0tw
	GBvYGseZhe+WcZcn66UCFBOvcVxQJvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758105441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZoP7xI9bh5cuZAC2MMMkkaHSM2qArN4UzTRm8GitpU=;
	b=lCKrd/3SMkAsu71vkV/44IEKXQSRO5fArYajtSwRNnnRLyN7UEpS4+bqwddhUAybMv2xHJ
	mWtV6X5XQFK+a+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE4BD1368D;
	Wed, 17 Sep 2025 10:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SZxDK12Pymj2OAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 17 Sep 2025 10:37:17 +0000
Date: Wed, 17 Sep 2025 11:37:07 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	kexec@lists.infradead.org, kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>, 
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 02/13] device/dax: update devdax to use mmap_prepare
Message-ID: <2jvm2x7krh7bkt43goiufksuxntncu2hxx67jos3i7zwj63jhh@rw47665pa25y>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <bfd55a49b89ebbdf2266d77c1f8df9339a99b97a.1758031792.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd55a49b89ebbdf2266d77c1f8df9339a99b97a.1758031792.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	R_RATELIMIT(0.00)[to_ip_from(RL4ro17i1dnf4zni6sx1qqmcne)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_033723_513875_5FE22DF3 
X-CRM114-Status: GOOD (  22.04  )
X-Mailman-Approved-At: Wed, 17 Sep 2025 05:17:58 -0700
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

On Tue, Sep 16, 2025 at 03:11:48PM +0100, Lorenzo Stoakes wrote:
> The devdax driver does nothing special in its f_op->mmap hook, so
> straightforwardly update it to use the mmap_prepare hook instead.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Pedro Falcato <pfalcato@suse.de>

> ---
>  drivers/dax/device.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 2bb40a6060af..c2181439f925 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -13,8 +13,9 @@
>  #include "dax-private.h"
>  #include "bus.h"
>  
> -static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> -		const char *func)
> +static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
> +		       unsigned long start, unsigned long end, struct file *file,
> +		       const char *func)
>  {
>  	struct device *dev = &dev_dax->dev;
>  	unsigned long mask;
> @@ -23,7 +24,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>  		return -ENXIO;
>  
>  	/* prevent private mappings from being established */
> -	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> +	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
>  		dev_info_ratelimited(dev,
>  				"%s: %s: fail, attempted private mapping\n",
>  				current->comm, func);
> @@ -31,15 +32,15 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>  	}
>  
>  	mask = dev_dax->align - 1;
> -	if (vma->vm_start & mask || vma->vm_end & mask) {
> +	if (start & mask || end & mask) {
>  		dev_info_ratelimited(dev,
>  				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
> -				current->comm, func, vma->vm_start, vma->vm_end,
> +				current->comm, func, start, end,
>  				mask);
>  		return -EINVAL;
>  	}
>  
> -	if (!vma_is_dax(vma)) {
> +	if (!file_is_dax(file)) {
>  		dev_info_ratelimited(dev,
>  				"%s: %s: fail, vma is not DAX capable\n",
>  				current->comm, func);
> @@ -49,6 +50,13 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> +static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> +		     const char *func)
> +{
> +	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
> +			   vma->vm_file, func);
> +}
> +

Side comment: I'm no DAX expert at all, but this check_vma() thing looks... smelly?
Besides the !dax_alive() check, I don't see the need to recheck vma limits at
every ->huge_fault() call. Even taking mremap() into account,
->get_unmapped_area() should Do The Right Thing, no?

-- 
Pedro

