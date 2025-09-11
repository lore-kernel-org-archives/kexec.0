Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEB4CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZHXjktAiNRSWCsp7mRo7oXVASySHuSrY3xtvxgr0Oo=; b=w3B1SMPDn8oEbyCbpZ8SwrmUpp
	xQqrVxwc9dMVaUsaQIz5xgga8yMVOdRMTDrMYCahbSmwWiHP7vwTptFY3MLFGGHkbuy00Ony/h+PG
	LsMRMO8kyoaUXi7p0rhpdhvCnG8pyxVnc/lPFFygVD+MMI2XrcPdnDsgQDMGET9nHqp2l3byC9dqh
	lHhQSfphH9AQGzWIUobyRpjM6Ev3v3q99+g1x6npKtUidk22JUaHJqV/OdJHyfWug2MyzVi2JppRA
	jayFi68Ruw0/mfRrv3adrUSyrP4aXhCcrmK8CsOwhsQV/7hhJ8bpM3IA/hgF8/arrU8n8yKrE0RUx
	ERP4Z41w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybxg-00000008vdX-0qIW;
	Tue, 16 Sep 2025 20:07:36 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwcmO-00000001rBL-1Zw6
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 08:35:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4BA43F8BF;
	Thu, 11 Sep 2025 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757579741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZHXjktAiNRSWCsp7mRo7oXVASySHuSrY3xtvxgr0Oo=;
	b=V/2pNPLXjZxOAXOZsGDYJjc2AyKj4F+z+UmxbO0U71QzrlxliA1spl1IIsigxVlhuUNypU
	V+MwrG1Yfq34WpkYW+gGb73AoQEZkis/St+xrG74pfZnVJhJQupE485J/8vHlzsMWXBU2i
	e8t2YbSo3Vc4NHMqR5+gg1L1eA9ZgiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757579741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZHXjktAiNRSWCsp7mRo7oXVASySHuSrY3xtvxgr0Oo=;
	b=8wJXEdI7KEwDUG4TdenbF0CZ7u9cEaytJTrnh2lXLZFebLh6NR+j81h2lyWMG5ZPD0huZZ
	exnc3+IjyrgjDqDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757579741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZHXjktAiNRSWCsp7mRo7oXVASySHuSrY3xtvxgr0Oo=;
	b=V/2pNPLXjZxOAXOZsGDYJjc2AyKj4F+z+UmxbO0U71QzrlxliA1spl1IIsigxVlhuUNypU
	V+MwrG1Yfq34WpkYW+gGb73AoQEZkis/St+xrG74pfZnVJhJQupE485J/8vHlzsMWXBU2i
	e8t2YbSo3Vc4NHMqR5+gg1L1eA9ZgiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757579741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZHXjktAiNRSWCsp7mRo7oXVASySHuSrY3xtvxgr0Oo=;
	b=8wJXEdI7KEwDUG4TdenbF0CZ7u9cEaytJTrnh2lXLZFebLh6NR+j81h2lyWMG5ZPD0huZZ
	exnc3+IjyrgjDqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F831372E;
	Thu, 11 Sep 2025 08:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1yYeJN2JwmhYcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 08:35:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 48964A0A2D; Thu, 11 Sep 2025 10:35:41 +0200 (CEST)
Date: Thu, 11 Sep 2025 10:35:41 +0200
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
Subject: Re: [PATCH v2 02/16] device/dax: update devdax to use mmap_prepare
Message-ID: <fpdlink5oiu7dbx35qayavv4lq2qjvruyplo2bomvu7lnsz62h@uwoawxkmywo7>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <12f96a872e9067fa678a37b8616d12b2c8d1cc10.1757534913.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f96a872e9067fa678a37b8616d12b2c8d1cc10.1757534913.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	R_RATELIMIT(0.00)[to_ip_from(RLizrtjkoytmmoj3iud1rzij51)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_013544_576354_01598AE1 
X-CRM114-Status: GOOD (  25.17  )
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

On Wed 10-09-25 21:21:57, Lorenzo Stoakes wrote:
> The devdax driver does nothing special in its f_op->mmap hook, so
> straightforwardly update it to use the mmap_prepare hook instead.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
>  /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
>  __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
>  		unsigned long size)
> @@ -285,8 +293,9 @@ static const struct vm_operations_struct dax_vm_ops = {
>  	.pagesize = dev_dax_pagesize,
>  };
>  
> -static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int dax_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *filp = desc->file;
>  	struct dev_dax *dev_dax = filp->private_data;
>  	int rc, id;
>  
> @@ -297,13 +306,14 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
>  	 * fault time.
>  	 */
>  	id = dax_read_lock();
> -	rc = check_vma(dev_dax, vma, __func__);
> +	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
> +			 __func__);
>  	dax_read_unlock(id);
>  	if (rc)
>  		return rc;
>  
> -	vma->vm_ops = &dax_vm_ops;
> -	vm_flags_set(vma, VM_HUGEPAGE);
> +	desc->vm_ops = &dax_vm_ops;
> +	desc->vm_flags |= VM_HUGEPAGE;
>  	return 0;
>  }
>  
> @@ -377,7 +387,7 @@ static const struct file_operations dax_fops = {
>  	.open = dax_open,
>  	.release = dax_release,
>  	.get_unmapped_area = dax_get_unmapped_area,
> -	.mmap = dax_mmap,
> +	.mmap_prepare = dax_mmap_prepare,
>  	.fop_flags = FOP_MMAP_SYNC,
>  };
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

