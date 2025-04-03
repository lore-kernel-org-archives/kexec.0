Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E566C36014
	for <kexec@archiver.kernel.org>; Thu,  3 Apr 2025 02:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IB+ISU4Wjgqen/35fHtciQhc4tnSvmILc9sQEZbFbPw=; b=FRYfLDbc5sI0oG6t+vDksjZGae
	mjygk7zmUTvmILuoDJKqX38cTG3xptXrppQX9hFxk1wi2KM55wOLua2cgVR3gv4gBoM93ABDTAIuz
	D2suiwZBAsjd4SLKEShdTGvYaYez9PYXtNA3U1/bxOopqgb4WECSM729zNaR0A31xo+71o2odKwt4
	VNiYjGR361YVkOk0U+sym4a3sF3YvQ/L4yjSQdV54HpZ1R88PA0eREaGDfCWzy7GyQmF5EkXxvC70
	kjmlWYJZG03Y/JGCcmNDtadcYSfLtSchBu/qnea06CPM6G8TcuJcWJmunfz87zEUNpNSdCYuzcDdO
	hc/J8zKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Al8-00000007dhq-3mPF;
	Thu, 03 Apr 2025 02:56:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Al6-00000007dh7-03ta
	for kexec@lists.infradead.org;
	Thu, 03 Apr 2025 02:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743649006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IB+ISU4Wjgqen/35fHtciQhc4tnSvmILc9sQEZbFbPw=;
	b=AP90ihRT70B0Q3I6BTCU/xn5Zm0cLaANh+YmHPA577Ty+DH6muEOQIZ5nMOd9pPqszYGjD
	8PN16/BoAG1pTKmrZaYnw2/UVXH/agZzYDkPI2WLjU4tl+GBBM4sayZNOT8rSh7NJAyD40
	c4mWUgem1xSsY68Dyn++2cOzDFi0T0s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-hKNG8ImCMBGdb8O0EFN_-w-1; Wed,
 02 Apr 2025 22:56:41 -0400
X-MC-Unique: hKNG8ImCMBGdb8O0EFN_-w-1
X-Mimecast-MFC-AGG-ID: hKNG8ImCMBGdb8O0EFN_-w_1743649000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2C4A19560B8;
	Thu,  3 Apr 2025 02:56:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2DC21809B68;
	Thu,  3 Apr 2025 02:56:37 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:56:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhiquan Li <zhiquan1.li@intel.com>, k-hagio-ab@nec.com,
	yamazaki-msmt@nec.com, lijiang@redhat.com, ltao@redhat.com
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	kirill.shutemov@linux.intel.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE
 to vmcoreinfo
Message-ID: <Z+344FNhxiMonoZb@MiWiFi-R3L-srv>
References: <20250403030801.758687-1-zhiquan1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403030801.758687-1-zhiquan1.li@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_195648_173392_AB4E49B9 
X-CRM114-Status: GOOD (  24.12  )
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

Add makedumpfile/Crash utilities maintainers to let them know.

On 04/03/25 at 11:08am, Zhiquan Li wrote:
> On Intel TDX guest, unaccepted memory is unusable free memory which is
> not managed by buddy, until it's accepted by guest.  Before that, it
> cannot be accessed by the first kernel as well as the kexec'ed kernel.
> The kexec'ed kernel will skip these pages and fill in zero data for the
> reader of vmcore.
> 
> The dump tool like makedumpfile creates a page descriptor (size 24
> bytes) for each non-free page, including zero data page, but it will not
> create descriptor for free pages.  If it is not able to distinguish
> these unaccepted pages with zero data pages, a certain amount of space
> will be wasted in proportion (~1/170).  In fact, as a special kind of
> free page the unaccepted pages should be excluded, like the real free
> pages.
> 
> Export the page type PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo, so
> that dump tool can identify whether a page is unaccepted.
> 
> Link: https://lore.kernel.org/all/20240809114854.3745464-5-kirill.shutemov@linux.intel.com/
> 
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> ---
> Vmcore size statistic of a freshly booted TD VM with different memory
> sizes:
> 
>   VM.mem | Before  After
>   -------+----------------
>   512G   | ~4.9G   ~2.0G
>   256G   | ~2.0G   ~1.1G
> 
> Most of changes are done by makedumpfile, but the prerequisite is kernel
> needs to export an indicator to identify unaccepted pages in vmcoreinfo.
> 
> V2 RESEND note:
> - No changes on this, just rebasd to v6.14.
> 
> V1: https://lore.kernel.org/all/20250103074941.3651765-1-zhiquan1.li@intel.com/
> 
> Changes since V1:
> - Rebase to v6.14-rc5.
> - Added document into admin-guide/kdump/vmcoreinfo.rst per Dave's
>   suggestion.
> - Add Kirill's Reviewed-by tag.
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 2 +-
>  kernel/vmcore_info.c                           | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 0f714fc945ac..3b47916f1856 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -331,7 +331,7 @@ PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision|PG_head_mask|P
>  Page attributes. These flags are used to filter various unnecessary for
>  dumping pages.
>  
> -PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
> +PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_unaccepted)
>  -----------------------------------------------------------------------------
>  
>  More page attributes. These flags are used to filter various unnecessary for
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index 1fec61603ef3..e066d31d08f8 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -210,6 +210,10 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
>  #define PAGE_OFFLINE_MAPCOUNT_VALUE	(PGTY_offline << 24)
>  	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +#define PAGE_UNACCEPTED_MAPCOUNT_VALUE	(PGTY_unaccepted << 24)
> +	VMCOREINFO_NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE);
> +#endif
>  
>  #ifdef CONFIG_KALLSYMS
>  	VMCOREINFO_SYMBOL(kallsyms_names);
> 
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> -- 
> 2.25.1
> 
> 


