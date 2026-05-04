Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42884FF885A
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/4fc2Deq5QyH656aaxlrF0fZqSx/rStDBdQnkNdfqM=; b=b8PKSOeJNnKKTYbfD2axLamfjH
	SE67PlS+IfU0qIvBbaEjPBGzFyQq8GqnEBrcWdIABhIjYgYIaYKAfQJENH7OPeZL/bAI7LbnSW5s0
	QVSrYvSa4Sx53E5msaj7WrqVLANVPbyWeA6ApdFXHOU05z6YGxCbh1fxy5XXWKikh82uOy5sz9sxd
	1ocZ05INmNZxbIkGqvqnOnzwhwdajhUlIDNhr2ursutUjJtWzorxiK/8zbY6IoWU75vkmt1OKE5QK
	dmf6ikriAsPgsXZ7Ct7hb4xYWRpERdeC862WwAeKL5HclbLMwXLJMJly4ajzsNfJzJXLAS3gthlSG
	aF/jlnsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJo76-0000000Celb-3Pfk;
	Mon, 04 May 2026 07:53:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJo71-0000000Cekv-1HQG
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 07:53:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFCBE4098F;
	Mon,  4 May 2026 07:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE0CC2BCB8;
	Mon,  4 May 2026 07:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777881185;
	bh=rMBgP1n8ks/9dio5wMGxcP8k8Hcb6wMZ4/wkWPj+EAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B6uV02bn3+cHnWm12AzSZ5AphoQssv2s4BtmhoXwBe4XXVu5/u6aajXvu38/wLj/m
	 aQy7pGqB87aEheFeHSI2lUTMUxTXM7+yzRkpkCIA4+d8df0uLHWCxkpi4C4fSVEiQ9
	 EW4cFmc3zTQHNhYyzUpSfz6Kzci8cQwH0zY718qX2/6/3cekilK1kinwnf8MbEQZ6H
	 H+Aw6g6HT3X283NkSufNiaHBgM0b+znNyPF8DsLkX30IT0YFkrCoFhJdiq6WigYTwX
	 9/bSd44bnVp26sZ4lI/UTZ5lVCI8Z9coyhMF+omyN3KWRuPgx6Cp01s45Fc82HTXx9
	 qLr3dHdHCdIag==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Michal Clapinski <mclapinski@google.com>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Samiullah Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Vlastimil Babka <vbabka@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <jackmanb@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 0/3] kho: add support for deferred struct page init
In-Reply-To: <afcdDm4aAJvNaQqH@kernel.org> (Mike Rapoport's message of "Sun, 3
	May 2026 12:01:50 +0200")
References: <20260423122538.140993-1-mclapinski@google.com>
	<afcdDm4aAJvNaQqH@kernel.org>
Date: Mon, 04 May 2026 09:53:01 +0200
Message-ID: <2vxzse87392a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_005307_504827_9B95B974 
X-CRM114-Status: GOOD (  12.44  )
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

On Sun, May 03 2026, Mike Rapoport wrote:

> Hi Michal,
>
> On Thu, Apr 23, 2026 at 02:25:35PM +0200, Michal Clapinski wrote:
>> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
>> initialization is deferred to parallel kthreads that run later in
>> the boot process.
>
> This patchset breaks memblock tests:
> https://github.com/linux-mm/linux-mm/actions/runs/25259346624/job/74063911769
>
> Can you please send a fix?

Would something like this do the trick? It fixes the build for me and
the tests pass.

I can send this as a proper patch if this looks good.

--- 8< ---
diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
index bb682659a12d..8d934ff5b080 100644
--- a/tools/testing/memblock/linux/mmzone.h
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -35,4 +35,8 @@ typedef struct pglist_data {
 
 } pg_data_t;
 
+enum migratetype {
+	MIGRATE_CMA,
+};
+
 #endif
-- 
Regards,
Pratyush Yadav

