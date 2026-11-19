Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B094606A33F
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b5zExaNf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahkG59L9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yfuI/yQuKLje7JCp8sAUMNEURSvgN1RcCGOMjucNHBQ=; b=b5zExaNfZrLWDHuyESUxaxXGqm
	GQjhTI4lWgrrKkuXA8O6qgfZSx9TCWUUPHS54/u9IhIhXf00UnOXtkfVipciXA8pq/gJsDZq0NEVQ
	qZIgVnDZyw8VeAry4RC8PtR0xd6inK+b8ZNw6Z421NbwfKU3X+QWXw/HRyC8/3/HREVcUx71pF4/4
	qU04Db24l47+ob+Cx7L6uH8DA8PeuMSvRqXnkE9x6p33xapnCYdWAeBHnhTGDQO1amd5SCk5I6U7/
	KTUEQv/1o9wUsIwMmLYDQjHszFy+ekhh5e2SQiGguSYZbpdTUSL3RXjmTmh54LGPHMTFn0oyVZNk4
	qjyfVdTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzjL-0000000BbUg-0o25;
	Thu, 19 Nov 2026 10:51:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzjJ-0000000BbUN-2XFO
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 10:51:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DDB14571D;
	Thu, 19 Nov 2026 10:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC8C1F000C5;
	Thu, 19 Nov 2026 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085461;
	bh=yfuI/yQuKLje7JCp8sAUMNEURSvgN1RcCGOMjucNHBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ahkG59L9dcE4oY2xp+HrfLQSf7g8rFpsotvFwG75x/1ZyP/Bh85uerHgyhAly93Om
	 cKdmDBP75o98gpk588HUBuXcp79fJM/peujxMHMVas40lukKb+jfeDn4xit2/bJBSE
	 uzBOtyeEAoXAqZRcgzD75C5z0JpcYs3MbGDNWuu8eLHD14e0+UxgvckXHejIe8RxXW
	 EhEL3GYn9D8TATyT9Fo2j0vR8+sUjJmbkBcpee7DvX8IjR5cli7tXojZbj35AvEuDe
	 6jhNPmjO3eDcDe53iTyFvAyMFjMlMhDMb8G3FVZmjzeJ8Lz7dC5g0blte6gHdrE5LM
	 2kWOkOWV62mRw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Long Wei <longwei27@huawei.com>
Cc: <rppt@kernel.org>,  <pasha.tatashin@soleen.com>,  <pratyush@kernel.org>,
  <akpm@linux-foundation.org>,  <graf@amazon.com>,  <leitao@debian.org>,
  <corbet@lwn.net>,  <rdunlap@infradead.org>,  <linux-mm@kvack.org>,
  <kexec@lists.infradead.org>,  <linux-doc@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <hewenliang4@huawei.com>
Subject: Re: [PATCH v3] kho: do not expose incoming sub-blob contents in
 debugfs
In-Reply-To: <20261119095937.826980-1-longwei27@huawei.com> (Long Wei's
	message of "Thu, 19 Nov 2026 17:59:37 +0800")
References: <20261119095937.826980-1-longwei27@huawei.com>
Date: Thu, 19 Nov 2026 10:50:56 +0000
Message-ID: <2vxzik1t3xin.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19 2026, Long Wei wrote:

> Incoming sub-blob pages are owned by their consumers and have independent
> lifetimes.  Some consumers, such as LUO, restore and free their state in
> early_initcall, i.e. before kho_init() (fs_initcall) builds the debugfs
> view:
>
>   early_initcall: luo_early_startup()
>                     -> kho_retrieve_subtree("LUO")
>                     -> kho_restore_free(luo_ser)   /* page is freed */
>
>   fs_initcall:    kho_init()
>                     -> kho_in_debugfs_init()
>                          -> phys_to_virt(luo_ser_phys)
>                          -> debugfs_create_blob("LUO", ...)
>
> debugfs therefore ends up pointing at a page that was already handed back
> to the page allocator, and reading the file triggers a use-after-free:
>
>   # cat /sys/kernel/debug/kho/in/sub_fdts/LUO
>   ==================================================================
>   BUG: KASAN: use-after-free in _copy_to_user+0x37/0x60
>   Read of size 32 at addr ffff88810309c000 by task cat/27436
>
>   Call Trace:
>    <TASK>
>    kasan_report+0xb9/0xf0
>    kasan_check_range+0x100/0x1b0
>    _copy_to_user+0x37/0x60
>    simple_read_from_buffer+0x77/0xd0
>    read_file_blob+0x75/0xa0
>    vfs_read+0x12d/0x520
>    ksys_read+0xc3/0x160
>    do_syscall_64+0x97/0x4b0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
>
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1fd
>   pfn:0x10309c
>   flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>   page_type: f0(buddy)
>   ==================================================================
>
> The page is already in the buddy allocator (page_type: f0(buddy),
> refcount 0), which confirms it was freed before the debugfs view was
> created.
>
> KHO does not own these pages, so it cannot safely expose their contents at
> all.  Drop the in/sub_fdts directory.  The incoming FDT is reserved by KHO
> and remains exposed as in/fdt, where the same metadata is available.
>
> The incoming sub-blob debugfs directory is gone, so remove its description
> from the KHO admin guide as well.
>
> Note that in/sub_fdts has exposed memory KHO does not own since
> commit c609c144b0e8 ("kexec: add KHO parsing support"), but the
> use-after-free only became reachable after commit d376e4b55c9a0
> ("liveupdate: centralize state management into struct luo_ser") which
> added kho_restore_free()
>
> Fixes: d376e4b55c9a0 ("liveupdate: centralize state management into struct luo_ser")
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Long Wei <longwei27@huawei.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

