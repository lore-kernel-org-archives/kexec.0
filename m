Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852FEC61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=520V5YZKa4W4p+rS1XuM5gpyArdQHv9WMOMWdi+ZzB4=; b=k0u5eVdxahimPPWI45n3K5Shew
	rD1s7lrzmGxw8XaFDUiSWnUHO4hiuE7KhCkrYIRFluOEoRPDMGmhYxtbosZR02BwqFmtVu5KsuPGD
	xHZAh4zZ4kLlDoFIo9ZILH3cJXExXlHvJ9Ksh0OfJPSbDOErl2h3qWtNcCMXGIqiP6QkZHGi7VVZX
	8m9zsaQZZhEuaAD+GcAck8JbEzGLHPwBjiqlIj5jP6oPcK9uviRKq6cT1Q2FyKtUXd1NTakQEf/L7
	LTnq1y4tngi3wEkz4LM1hHK4d2L5d84gnjipebV2/gfsfCruhuU/XvAz+yMPK6V7R2KGcJPE8/Tmo
	cygniA1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oTA-0000000FOvR-10XD;
	Wed, 02 Sep 2026 17:09:52 +0000
Received: from out-101.mta0.migadu.com ([2001:41d0:1004:224b::65] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oT7-0000000FOt6-2BhQ
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 17:09:51 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=ZFXv+XpeuJG4l4p41D/Mf1mufjNw3LILnzU9t7FD6bk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788368986; v=1; x=1788973786;
 b=lvdNJSLxizyPOscQKhuEV0o2IXL0LtI3PgSRKN7bH1FIVYACdM6AIXni5Y0Rkn5xLbEEFqv/
 btuCCVtYBeh39J5IKk+b+fm1xuG8iniz9pamIiPeC3kj+0SPFQTmuPVz7h+VnRFkDtf8Rfz4Eo3
 CdkQYrtBrbFRMeDDIdM8s8dQ=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id c8ccc08d494f655b;
	Wed, 02 Sep 2026 17:09:35 +0000
X-Mizu-Trace-ID: c8ccc08d494f655b
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Date: Wed,  2 Sep 2026 10:09:27 -0700
Message-ID: <20260902170928.2227054-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_100949_840663_2F065CE8 
X-CRM114-Status: GOOD (  31.68  )
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

On Mon, 31 Aug 2026 15:25:37 -0400 Zi Yan <ziy@nvidia.com> wrote:

> folio->private != NULL indicates a folio carries private data, replacing
> PG_private. All PG_private users are converted. Remove PG_private and
> reserve the space as __PG_folio for future use.
> 
> Also update files in Documentation. hugetlbfs_reserv.rst is outdated and
> left unchanged. It should be rewritten.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Baoquan He <baoquan.he@linux.dev>
> To: Mike Rapoport <rppt@kernel.org>
> To: Pasha Tatashin <pasha.tatashin@soleen.com>
> To: Pratyush Yadav <pratyush@kernel.org>
> To: Jonathan Corbet <corbet@lwn.net>
> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> To: Jan Kara <jack@suse.cz>
> To: David Hildenbrand <david@kernel.org>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst |  2 +-
>  Documentation/filesystems/vfs.rst              |  6 +++---
>  include/linux/page-flags.h                     | 19 ++-----------------
>  include/trace/events/mmflags.h                 |  2 +-
>  kernel/vmcore_info.c                           |  1 -
>  5 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 7663c610fe901..5f1df6d080508 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -325,7 +325,7 @@ NR_FREE_PAGES
>  On linux-2.6.21 or later, the number of free pages is in
>  vm_stat[NR_FREE_PAGES]. Used to get the number of free pages.
>  
> -PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_hwpoison|PG_head_mask
> +PG_lru|PG_swapcache|PG_swapbacked|PG_hwpoison|PG_head_mask
>  --------------------------------------------------------------------------
>  
>  Page attributes. These flags are used to filter various unnecessary for
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index d3a93eec3945f..dec7816303c6a 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -649,8 +649,8 @@ Writeback.
>  
>  The first can be used independently to the others.  The VM can try to
>  release clean pages in order to reuse them.  To do this it can call
> -->release_folio on clean folios with the private
> -flag set.  Clean pages without PagePrivate and with no external references
> +->release_folio on clean folios with folio->private set. Clean pages
> +without folio->private set and with no external references
>  will be released without notice being given to the address_space.
>  
>  To achieve this functionality, pages need to be placed on an LRU with
> @@ -674,7 +674,7 @@ filemap_fdatawait_range, to wait for all writeback to complete.
>  
>  An address_space handler may attach extra information to a page,
>  typically using the 'private' field in the 'struct page'.  If such
> -information is attached, the PG_Private flag should be set.  This will
> +information is attached, non-NULL 'private' field will
>  cause various VM routines to make extra calls into the address_space
>  handler to deal with that data.
>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 9b585e68127a2..eb2961ed61018 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -44,10 +44,6 @@
>   * Consequently, PG_reserved for a page mapped into user space can indicate
>   * the zero page, the vDSO, MMIO pages or device memory.
>   *
> - * The PG_private bitflag is set on pagecache pages if they contain filesystem
> - * specific data (which is normally at page->private). It can be used by
> - * private allocations for its own usage.
> - *
>   * During initiation of disk I/O, PG_locked is set. This bit is set before I/O
>   * and cleared when writeback _starts_ or when read _completes_. PG_writeback
>   * is set before writeback starts and cleared when it finishes.
> @@ -105,7 +101,7 @@ enum pageflags {
>  	PG_owner_2,		/* Owner use. If pagecache, fs may use */
>  	PG_arch_1,
>  	PG_reserved,
> -	PG_private,		/* If pagecache, has fs-private data */
> +	__PG_folio,		/* Do not use: reserved for folio identification */
>  	PG_private_2,		/* If pagecache, has fs aux data */
>  	PG_reclaim,		/* To be reclaimed asap */
>  	PG_swapbacked,		/* Page is backed by RAM/swap */
> @@ -576,7 +572,7 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
>  /*
>   * Private page markings that may be used by the filesystem that owns the page
>   * for its own purposes.
> - * - PG_private and PG_private_2 cause release_folio() and co to be invoked
> + * - folio->private and PG_private_2 cause release_folio() and co to be invoked
>   */
>  
>  static __always_inline bool folio_test_private(const struct folio *folio)
> @@ -584,17 +580,6 @@ static __always_inline bool folio_test_private(const struct folio *folio)
>  	return folio->private;
>  }
>  
> -static __always_inline int PagePrivate(const struct page *page)
> -{
> -	return !!page->private;
> -}
> -
> -/* no-ops during transition */
> -static __always_inline void folio_set_private(struct folio *folio) { }
> -static __always_inline void folio_clear_private(struct folio *folio) { }
> -static __always_inline void SetPagePrivate(struct page *page) { }
> -static __always_inline void ClearPagePrivate(struct page *page) { }
> -
>  FOLIO_FLAG(private_2, FOLIO_HEAD_PAGE)
>  
>  /* owner_2 can be set on tail pages for anon memory */
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 935893e5ea53b..caf090cd6f85e 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -144,7 +144,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>  	DEF_PAGEFLAG_NAME(owner_2),					\
>  	DEF_PAGEFLAG_NAME(arch_1),					\
>  	DEF_PAGEFLAG_NAME(reserved),					\
> -	DEF_PAGEFLAG_NAME(private),					\
> +	{ 1UL << __PG_folio, "folio" },					\
>  	DEF_PAGEFLAG_NAME(private_2),					\
>  	DEF_PAGEFLAG_NAME(writeback),					\
>  	DEF_PAGEFLAG_NAME(head),					\
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index 8614430ca212a..5a417f8a922ab 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -216,7 +216,6 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
>  	VMCOREINFO_NUMBER(NR_FREE_PAGES);
>  	VMCOREINFO_NUMBER(PG_lru);
> -	VMCOREINFO_NUMBER(PG_private);
>  	VMCOREINFO_NUMBER(PG_swapcache);
>  	VMCOREINFO_NUMBER(PG_swapbacked);
>  #define PAGE_SLAB_MAPCOUNT_VALUE	(PGTY_slab << 24)

+ kdump maintainers and reviewers.

I believe makedumpfile reads VMCOREINFO. Removing it here, might cause issues
for older makedumpfile versions at crashdump?

Hopefully kdump folks will be able to comment better.

> 
> -- 
> 2.53.0
> 
> 

