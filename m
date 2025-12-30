Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AFCEE4982
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6KKUSWFo7Iwo2TJWGYzI0ssRSkagMbg2+GN8e6KU050=; b=GESNUSCNQUkcgCR+tDNhhFyefl
	DDc4J+5zblHAb/w8OSUMpnYFnmaSVKta8veHwOMI68ogy7izKYJmoC+8cBIQ/YQuu9dSC9hTvqID2
	eoqITywpBsy4zHfvKC1jAj2TsZJOgkTxNbtaeDfSfI+mQJiamnZ9N37ykql1PCfMkO0TaGCR0rLrs
	eCTLnV5i5pTPwLxLYOXyuJoYHkc5gOHt4YrRAi6sJVNLIWOpftiE67kTvufKfoXJmV62RK7eC0POh
	7Tuzy7qhv33r91x6+FKfqQ0ZPCNux4TBSEW1MZTh2X8hmIyS+sz5Jc43nsbcUWeEYlzCtycupW35Y
	Wjhrp5CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacYO-000000053TB-3DXH;
	Tue, 30 Dec 2025 16:26:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacYN-000000053T2-3qJ1
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 16:26:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1FE4A6000A;
	Tue, 30 Dec 2025 16:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B83C4CEFB;
	Tue, 30 Dec 2025 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111994;
	bh=noWdpEVhxGi5t7Nr2JIuYUNiO+HkVoYB8qZqkKLGh80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwbfIitKUR2wkcqXy01+kxMaclJdqpjxOALjcpGS2TQK4eUvbWl4a4Yek/XeHrSbq
	 V+CU3h+womQ1ItZTcAiQayJhr6HDRDmcKjiORQaGbhBaiztT3sNkMcetEuqpnkVe0h
	 U1A+lI0ODDuBF06GqvB8d6MpkNEYFWlysJ9z5ZPp49meUdJG0evxGILRPYkNP/fHnd
	 h9eC3JtLXfBRkWEGCzoseFllk9Uy9w5KJ3rAioh3FPItq5Kqz/htqNwYVMf+IZsXlU
	 X20SLREp144bOoce4aWRAlbQXzBetQ1L3WrtOhO9ILQqoFiFXuSdh+ZwMhZgR4bPFG
	 7dioiwzG/qcNw==
Date: Tue, 30 Dec 2025 18:26:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liveupdate/kho: Warn when kho_scratch is insufficient
 for sparsemem
Message-ID: <aVP9NHDn0WFtkMNP@kernel.org>
References: <20251230055345.70035-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230055345.70035-1-me@linux.beauty>
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

Hi,

On Tue, Dec 30, 2025 at 01:53:45PM +0800, Li Chen wrote:
> With KHO enabled, the successor kernel can temporarily run memblock in
> scratch-only mode during early boot. In that mode, SPARSEMEM may allocate
> a per-node scratch buffer via sparse_buffer_init(map_count *
> section_map_size()), which requires a single contiguous, aligned memblock
> allocation.
> 
> If the maximum usable scratch range in a node is smaller than the
> estimated buffer size, kexec handover can hang very early in the
> successor kernel, and we may even have no chance to see the error on
> the console.
> 
> Estimate the worst-case per-node requirement from the running kernel's
> sparsemem layout and compare it against the reserved scratch list by
> splitting scratch ranges per nid, sorting and merging them, and applying
> the section_map_size() alignment constraint. Warn once when scratch
> appears too small.
> 
> This check is a heuristic based on the running kernel's sparsemem layout
> and cannot account for all differences in a successor kernel. Keep it as
> a warning instead of rejecting kexec loads to avoid false positives
> causing unexpected regressions. Users can adjust kho_scratch accordingly
> before attempting a handover.
> 
> To reduce boot-time overhead(particularly on large NUMA servers), run
> the check from a late initcall via system_long_wq instead of in
> kho_reserve_scratch().
> 
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
>  kernel/liveupdate/kexec_handover.c | 396 +++++++++++++++++++++++++++++
>  1 file changed, 396 insertions(+)

This is an overkill for something that a pr_err() or a panic() would be
sufficient.

-- 
Sincerely yours,
Mike.

