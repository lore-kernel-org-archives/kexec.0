Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AD3CAC59F
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9OZHv6l97MqIsXfPxgJwmp3fJXxpsxaT+6E3H63F4A=; b=SMD1CIMQjzsDefJrzK+Kxhz0sL
	MGyanNg/URCU546y0TC6jfumtJTdhdNeP7KGywxU9ZpfM1u8xRp8OfMIfaQmHIHTHxoFkB8ifn9BI
	FR9jELoeNLQabqPJjFq2+wIIA6OxuNKcm8jFny2sx4Pa0MoLQOhVIN25Ln4YkpPbeDyJGFPMC23pj
	nJk9doYDXw7CzqniFAD+28DEabRsn+A+Qk2W98C4P+1K15wrJMe8PzJULAbjuGpdM6GwTKirObrc+
	rvf7i44kodmhc12sOfrRfbkEwXy2DZHl6uxG9SY/sf3p/qWspsah2fYvrGc3ElMzXr3KlgX0BR9yc
	JSQzv3/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybxj-00000008vhz-0UDm;
	Tue, 16 Sep 2025 20:07:39 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwcpI-00000001sDD-3Rx6
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 08:38:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E8A93F958;
	Thu, 11 Sep 2025 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757579922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9OZHv6l97MqIsXfPxgJwmp3fJXxpsxaT+6E3H63F4A=;
	b=xB4gv7V39AjvzZqhbFvpMeDM5nwbiNwlcCmMOJwTz+PdsznaXJuTdLn3SoDQMoeUWdkeii
	1r2pEaTWog+deAhwvgwTELQPnF8oZ0yYguW4upel7rfdVE+3wrH3qFra+HpwdHuYteaBSS
	arDvuQko9RTMU9ux7Cb1QQtSWsvsur4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757579922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9OZHv6l97MqIsXfPxgJwmp3fJXxpsxaT+6E3H63F4A=;
	b=PrOFG9bhllLqFULElo/ImR0TtrXr4AVrHSKP1NkH/s/biYgBBErxRpzuzCM3a8Sfmolf0X
	olWF0zUGczMgn/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757579922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9OZHv6l97MqIsXfPxgJwmp3fJXxpsxaT+6E3H63F4A=;
	b=xB4gv7V39AjvzZqhbFvpMeDM5nwbiNwlcCmMOJwTz+PdsznaXJuTdLn3SoDQMoeUWdkeii
	1r2pEaTWog+deAhwvgwTELQPnF8oZ0yYguW4upel7rfdVE+3wrH3qFra+HpwdHuYteaBSS
	arDvuQko9RTMU9ux7Cb1QQtSWsvsur4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757579922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9OZHv6l97MqIsXfPxgJwmp3fJXxpsxaT+6E3H63F4A=;
	b=PrOFG9bhllLqFULElo/ImR0TtrXr4AVrHSKP1NkH/s/biYgBBErxRpzuzCM3a8Sfmolf0X
	olWF0zUGczMgn/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EE661372E;
	Thu, 11 Sep 2025 08:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RzXXIpKKwmiAcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 08:38:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D7CAA0A2D; Thu, 11 Sep 2025 10:38:42 +0200 (CEST)
Date: Thu, 11 Sep 2025 10:38:42 +0200
From: Jan Kara <jack@suse.cz>
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
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
	ntfs3@lists.linux.dev, kexec@lists.infradead.org, kasan-dev@googlegroups.com, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 04/16] relay: update relay to use mmap_prepare
Message-ID: <q5kr5klayp7wcdv5535etvhfcmsftf2h5pi2nhxjpxsyu4h6qt@e6fidg7kolk2>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <3e34bb15a386d64e308c897ea1125e5e24fc6fa4.1757534913.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e34bb15a386d64e308c897ea1125e5e24fc6fa4.1757534913.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	R_RATELIMIT(0.00)[to_ip_from(RLizrtjkoytmmoj3iud1rzij51)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_013845_157101_B1C9FC89 
X-CRM114-Status: GOOD (  25.11  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:20 -0700
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

On Wed 10-09-25 21:21:59, Lorenzo Stoakes wrote:
> It is relatively trivial to update this code to use the f_op->mmap_prepare
> hook in favour of the deprecated f_op->mmap hook, so do so.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/relay.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 8d915fe98198..e36f6b926f7f 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -72,17 +72,18 @@ static void relay_free_page_array(struct page **array)
>  }
>  
>  /**
> - *	relay_mmap_buf: - mmap channel buffer to process address space
> - *	@buf: relay channel buffer
> - *	@vma: vm_area_struct describing memory to be mapped
> + *	relay_mmap_prepare_buf: - mmap channel buffer to process address space
> + *	@buf: the relay channel buffer
> + *	@desc: describing what to map
>   *
>   *	Returns 0 if ok, negative on error
>   *
>   *	Caller should already have grabbed mmap_lock.
>   */
> -static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
> +static int relay_mmap_prepare_buf(struct rchan_buf *buf,
> +				  struct vm_area_desc *desc)
>  {
> -	unsigned long length = vma->vm_end - vma->vm_start;
> +	unsigned long length = vma_desc_size(desc);
>  
>  	if (!buf)
>  		return -EBADF;
> @@ -90,9 +91,9 @@ static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
>  	if (length != (unsigned long)buf->chan->alloc_size)
>  		return -EINVAL;
>  
> -	vma->vm_ops = &relay_file_mmap_ops;
> -	vm_flags_set(vma, VM_DONTEXPAND);
> -	vma->vm_private_data = buf;
> +	desc->vm_ops = &relay_file_mmap_ops;
> +	desc->vm_flags |= VM_DONTEXPAND;
> +	desc->private_data = buf;
>  
>  	return 0;
>  }
> @@ -749,16 +750,16 @@ static int relay_file_open(struct inode *inode, struct file *filp)
>  }
>  
>  /**
> - *	relay_file_mmap - mmap file op for relay files
> - *	@filp: the file
> - *	@vma: the vma describing what to map
> + *	relay_file_mmap_prepare - mmap file op for relay files
> + *	@desc: describing what to map
>   *
> - *	Calls upon relay_mmap_buf() to map the file into user space.
> + *	Calls upon relay_mmap_prepare_buf() to map the file into user space.
>   */
> -static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int relay_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct rchan_buf *buf = filp->private_data;
> -	return relay_mmap_buf(buf, vma);
> +	struct rchan_buf *buf = desc->file->private_data;
> +
> +	return relay_mmap_prepare_buf(buf, desc);
>  }
>  
>  /**
> @@ -1006,7 +1007,7 @@ static ssize_t relay_file_read(struct file *filp,
>  const struct file_operations relay_file_operations = {
>  	.open		= relay_file_open,
>  	.poll		= relay_file_poll,
> -	.mmap		= relay_file_mmap,
> +	.mmap_prepare	= relay_file_mmap_prepare,
>  	.read		= relay_file_read,
>  	.release	= relay_file_release,
>  };
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

