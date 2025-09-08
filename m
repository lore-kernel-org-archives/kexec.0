Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D5CA0FED
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=; b=t2060r2bjZxM6QyvviIMpBsrcx
	jAoASh2mEyIrs8RKto7lJ+sNmJIXHp9o36cAe7rBX5lhm/zol2ITKWkuTi7vbORBsEztaETzCOnqS
	llj/sUrk6PhUXK879SPweXkHVe9MiDfaj/gHfZVoac2TP7SwSttPonlchG0b97eSmFhrAt3DSBPxJ
	j6YenRNsyadlK08a8idJ6EZLHhckRjbzK1Hiq8b8/Y/YShyTnxxdZhIG3paWo3xptfvVc8YI8HDFw
	WJ19a+rDs0TiJdAuFhdr1sxRVZtuFjwaY71JEFHu9IHl8fjytlP6c5ueQYBrlOAksy1EqsKvMSO5I
	DDO6gQ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvswV-00000005FSX-0tk6;
	Tue, 09 Sep 2025 07:39:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvbuZ-0000000HNCu-1Zsv
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 13:28:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF2BC265F7;
	Mon,  8 Sep 2025 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757338076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=cYx/uSMK2A3DGDZ7TNOfQK3Uw4Cnr4tafssGbvydao6dVVTNSMNpNmXGpnpYXK0RKrGFGG
	tGKL9q9yMAhxYLYC/q0jqSX2kCTKg9JXcZ3K5d9mLvyXBUQ/hKQsjJT3JvCx+uZTTZHaj9
	L6LPPRpDwKVHOOE13MCt03I/wp2N8qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757338076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=t1Swnl+grxLeVumVUu6SGztBl3gE1HBPnEcUwN0LuhFPZDSZgJUJIIGAzbR4MQtFCXVwn0
	XufWqwk1yayrETCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757338076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=cYx/uSMK2A3DGDZ7TNOfQK3Uw4Cnr4tafssGbvydao6dVVTNSMNpNmXGpnpYXK0RKrGFGG
	tGKL9q9yMAhxYLYC/q0jqSX2kCTKg9JXcZ3K5d9mLvyXBUQ/hKQsjJT3JvCx+uZTTZHaj9
	L6LPPRpDwKVHOOE13MCt03I/wp2N8qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757338076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=t1Swnl+grxLeVumVUu6SGztBl3gE1HBPnEcUwN0LuhFPZDSZgJUJIIGAzbR4MQtFCXVwn0
	XufWqwk1yayrETCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB74013869;
	Mon,  8 Sep 2025 13:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xFqgKdzZvmjdNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 13:27:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4EBA2A0A2D; Mon,  8 Sep 2025 15:27:52 +0200 (CEST)
Date: Mon, 8 Sep 2025 15:27:52 +0200
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
Subject: Re: [PATCH 00/16] expand mmap_prepare functionality, port more users
Message-ID: <tyoifr2ym3pzx4nwqhdwap57us3msusbsmql7do4pim5ku7qtm@wjyvh5bs633s>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_062759_707201_F25AE33F 
X-CRM114-Status: GOOD (  40.31  )
X-Mailman-Approved-At: Mon, 08 Sep 2025 23:53:50 -0700
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

Hi Lorenzo!

On Mon 08-09-25 12:10:31, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), The f_op->mmap hook has been deprecated in favour of
> f_op->mmap_prepare.
> 
> This was introduced in order to make it possible for us to eventually
> eliminate the f_op->mmap hook which is highly problematic as it allows
> drivers and filesystems raw access to a VMA which is not yet correctly
> initialised.
> 
> This hook also introduces complexity for the memory mapping operation, as
> we must correctly unwind what we do should an error arises.
> 
> Overall this interface being so open has caused significant problems for
> us, including security issues, it is important for us to simply eliminate
> this as a source of problems.
> 
> Therefore this series continues what was established by extending the
> functionality further to permit more drivers and filesystems to use
> mmap_prepare.
> 
> After updating some areas that can simply use mmap_prepare as-is, and
> performing some housekeeping, we then introduce two new hooks:
> 
> f_op->mmap_complete - this is invoked at the point of the VMA having been
> correctly inserted, though with the VMA write lock still held. mmap_prepare
> must also be specified.
> 
> This expands the use of mmap_prepare to those callers which need to
> prepopulate mappings, as well as any which does genuinely require access to
> the VMA.
> 
> It's simple - we will let the caller access the VMA, but only once it's
> established. At this point unwinding issues is simple - we just unmap the
> VMA.
> 
> The VMA is also then correctly initialised at this stage so there can be no
> issues arising from a not-fully initialised VMA at this point.
> 
> The other newly added hook is:
> 
> f_op->mmap_abort - this is only valid in conjunction with mmap_prepare and
> mmap_complete. This is called should an error arise between mmap_prepare
> and mmap_complete (not as a result of mmap_prepare but rather some other
> part of the mapping logic).
> 
> This is required in case mmap_prepare wishes to establish state or locks
> which need to be cleaned up on completion. If we did not provide this, then
> this could not be permitted as this cleanup would otherwise not occur
> should the mapping fail between the two calls.

So seeing these new hooks makes me wonder: Shouldn't rather implement
mmap(2) in a way more similar to how other f_op hooks behave like ->read or
->write? I.e., a hook called at rather high level - something like from
vm_mmap_pgoff() or similar similar level - which would just call library
functions from MM for the stuff it needs to do. Filesystems would just do
their checks and call the generic mmap function with the vm_ops they want
to use, more complex users could then fill in the VMA before releasing
mmap_lock or do cleanup in case of failure... This would seem like a more
understandable API than several hooks with rules when what gets called.

								Honza

> 
> We then add split remap_pfn_range*() functions which allow for PFN remap (a
> typical mapping prepopulation operation) split between a prepare/complete
> step, as well as io_mremap_pfn_range_prepare, complete for a similar
> purpose.
> 
> From there we update various mm-adjacent logic to use this functionality as
> a first set of changes, as well as resctl and cramfs filesystems to round
> off the non-stacked filesystem instances.
> 
> 
> REVIEWER NOTE:
> ~~~~~~~~~~~~~~
> 
> I considered putting the complete, abort callbacks in vm_ops, however this
> won't work because then we would be unable to adjust helpers like
> generic_file_mmap_prepare() (which provides vm_ops) to provide the correct
> complete, abort callbacks.
> 
> Conceptually it also makes more sense to have these in f_op as they are
> one-off operations performed at mmap time to establish the VMA, rather than
> a property of the VMA itself.
> 
> Lorenzo Stoakes (16):
>   mm/shmem: update shmem to use mmap_prepare
>   device/dax: update devdax to use mmap_prepare
>   mm: add vma_desc_size(), vma_desc_pages() helpers
>   relay: update relay to use mmap_prepare
>   mm/vma: rename mmap internal functions to avoid confusion
>   mm: introduce the f_op->mmap_complete, mmap_abort hooks
>   doc: update porting, vfs documentation for mmap_[complete, abort]
>   mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
>   mm: introduce io_remap_pfn_range_prepare, complete
>   mm/hugetlb: update hugetlbfs to use mmap_prepare, mmap_complete
>   mm: update mem char driver to use mmap_prepare, mmap_complete
>   mm: update resctl to use mmap_prepare, mmap_complete, mmap_abort
>   mm: update cramfs to use mmap_prepare, mmap_complete
>   fs/proc: add proc_mmap_[prepare, complete] hooks for procfs
>   fs/proc: update vmcore to use .proc_mmap_[prepare, complete]
>   kcov: update kcov to use mmap_prepare, mmap_complete
> 
>  Documentation/filesystems/porting.rst |   9 ++
>  Documentation/filesystems/vfs.rst     |  35 +++++++
>  arch/csky/include/asm/pgtable.h       |   5 +
>  arch/mips/alchemy/common/setup.c      |  28 +++++-
>  arch/mips/include/asm/pgtable.h       |  10 ++
>  arch/s390/kernel/crash_dump.c         |   6 +-
>  arch/sparc/include/asm/pgtable_32.h   |  29 +++++-
>  arch/sparc/include/asm/pgtable_64.h   |  29 +++++-
>  drivers/char/mem.c                    |  80 ++++++++-------
>  drivers/dax/device.c                  |  32 +++---
>  fs/cramfs/inode.c                     | 134 ++++++++++++++++++--------
>  fs/hugetlbfs/inode.c                  |  86 +++++++++--------
>  fs/ntfs3/file.c                       |   2 +-
>  fs/proc/inode.c                       |  13 ++-
>  fs/proc/vmcore.c                      |  53 +++++++---
>  fs/resctrl/pseudo_lock.c              |  56 ++++++++---
>  include/linux/fs.h                    |   4 +
>  include/linux/mm.h                    |  53 +++++++++-
>  include/linux/mm_types.h              |   5 +
>  include/linux/proc_fs.h               |   5 +
>  include/linux/shmem_fs.h              |   3 +-
>  include/linux/vmalloc.h               |  10 +-
>  kernel/kcov.c                         |  40 +++++---
>  kernel/relay.c                        |  32 +++---
>  mm/memory.c                           | 128 +++++++++++++++---------
>  mm/secretmem.c                        |   2 +-
>  mm/shmem.c                            |  49 +++++++---
>  mm/util.c                             |  18 +++-
>  mm/vma.c                              |  96 +++++++++++++++---
>  mm/vmalloc.c                          |  16 ++-
>  tools/testing/vma/vma_internal.h      |  31 +++++-
>  31 files changed, 810 insertions(+), 289 deletions(-)
> 
> --
> 2.51.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

