Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CC3FB44C8
	for <kexec@archiver.kernel.org>; Fri, 24 Apr 2026 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fGjC2L6hANufoA3RSnGeIAyu8hxPE17bPaM1lac2RNo=; b=yKPBS6ZI8pqh/Ikhh4C+rTANYf
	zsg0DDrH7AMvPR4O0v0FAkitztaxOlJ2b61CNDSeVsp2Kk5m7dEl9bFtW9S2BNZQfGd4NY6X/3KjI
	f6yHdGRIv+08HAZYu2HfWMLBcR9tkE76mMdj+TUH6Xgous2g0+eB/dVzAGnyYgKe3W98cyBXWdAx5
	z1fhUS/DR+QL/q8p4dwAjD7sHCtUaJj0nRnntpW8JK6QwUKVDME0cGlPwpBG5X9tPyJEF8LKvk2dn
	ScHUGmDdi+9SjGjaPv2PdLHls5MwTJzeZyI70cXiGVwqQb+n9iK/VoEQnfo/WXwBjnfe5Ado6rNw5
	UPI/LCOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGBfJ-0000000Cqj4-2EsC;
	Fri, 24 Apr 2026 08:13:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGBfH-0000000Cqiv-3l8I
	for kexec@lists.infradead.org;
	Fri, 24 Apr 2026 08:13:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 752B86001A;
	Fri, 24 Apr 2026 08:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42021C19425;
	Fri, 24 Apr 2026 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777018410;
	bh=gPaqGDKTxV+aOLEHrXvFf3KAASbZw1FfH458ke1TYik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duXroG99KOm/SFGEgJkDqLihKyrlSFgoyX8XwRKfhCTu0IPvAz3cStUxz/OraOAnF
	 TdPpuDRGmx1AMkTFaQOKz/DwKoxFuXaV6LBBd98Dmp9J8i0Ydyp5SO6FmN+6AoxwgA
	 A8J8mKZE/8T3pHRliaJs5NJAjrWX/BkxQfMgMtTkdUxqEOjAtg4jiJDjGxB70whsu8
	 WHIj03wqUin0NFYDpulAzyehTHsjgpYAwgXFPvFAp4gJzjtVmOMijA8+9uG1H7jyvs
	 1MyWSSxvzc1wi2YIN96ANCCy9SpzX3FVoFp7HjBJwFHKDKGo85Bd/KBS1glqfZlulB
	 bFE7JFEzJEJvA==
Date: Fri, 24 Apr 2026 11:13:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 3/3] selftests: kho: test with deferred struct page
 init
Message-ID: <aesmIbOizNLMLvVK@kernel.org>
References: <20260423122538.140993-1-mclapinski@google.com>
 <20260423122538.140993-4-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122538.140993-4-mclapinski@google.com>
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

On Thu, Apr 23, 2026 at 02:25:38PM +0200, Michal Clapinski wrote:
> Enable DEFERRED_STRUCT_PAGE_INIT which depends on SMP.
> Also enable additional debugging options.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/kho/vmtest.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
> index 49fdac8e8b15..0014bd76e88d 100755
> --- a/tools/testing/selftests/kho/vmtest.sh
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -59,10 +59,14 @@ function build_kernel() {
>  	tee "$kconfig" > "$kho_config" <<EOF
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KEXEC_HANDOVER=y
> +CONFIG_KEXEC_HANDOVER_DEBUG=y
>  CONFIG_KEXEC_HANDOVER_DEBUGFS=y
>  CONFIG_TEST_KEXEC_HANDOVER=y
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_VM_PGFLAGS=y
> +CONFIG_SMP=y
> +CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>  $arch_kconfig
>  EOF
>  
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 

-- 
Sincerely yours,
Mike.

