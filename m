Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663D4C3ABC5
	for <kexec@archiver.kernel.org>; Thu,  8 May 2025 06:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MGauZ8yYhGi7K8cEJ4FmnYleuvH8pQ/T2QdX+mN+TBc=; b=YetCOmwAe06phuJ2q1ykNwSFDL
	YtY8nMmG3+4zu3YIBFm8Dv1UTewkrkP2nRh0MDDXLguxb3dXxP4Tf85OIr8GphVC2Ass9HaDfOqFn
	iGNo5gigNE0TFk7X6JtSGKX1Q9DHFNSGFSoJM06ZllIVXK6Fk2b1rReKRZ9fPr4pLzNyP6VeVrmug
	mcZQwb42+u9V/KKMyNnqFqyObbLDfej9rjG+LgcqIOXP+LIOzvtSetew6wnnB5cdl7ejS4F5RTYrV
	j2yHlV39IO/eZlc/G3W9me2fLL0NDA1k6pXBvOOQsOqKoUfN7pOYkwCPt8sEZ39upq+Pz7aIJeIXA
	lrXguOaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuTg-0000000HRF0-1ylj;
	Thu, 08 May 2025 06:11:28 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuSL-0000000HR5p-1NJU
	for kexec@lists.infradead.org;
	Thu, 08 May 2025 06:10:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 91526A4D8D0;
	Thu,  8 May 2025 06:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E76FC4CEEB;
	Thu,  8 May 2025 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746684604;
	bh=LCn61LKFn2NcODa4bEjBVzTx3BUMcbOJY2k9EXdfpS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xJC5jZSxJpc84c6uTHTuPGCtjLz+A3eh6kFi2fL63mJkYJZ/xyHhbqrVYrQF5No1s
	 4RJNYRIvBsyLMpfcSWSQjf6BVWfzYf3mFxkkqDqSSscDb2qsY2eLEAUzQ9KXuHocue
	 Nh+bdoine9g3TkKVOIDVDDLLDKfs4g8YrOY0+QWI=
Date: Wed, 7 May 2025 23:10:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-Id: <20250507231003.c11c4b90d6a2b1f6ddce792e@linux-foundation.org>
In-Reply-To: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_231005_440402_1F73AC8C 
X-CRM114-Status: GOOD (  15.26  )
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

On Mon,  8 Jan 2024 21:06:47 +0800 fuqiang wang <fuqiang.wang@easystack.cn> wrote:

> In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
> In the current x86 architecture code, the elfheader is always allocated
> at crashk_res.start. It seems that there won't be a new split range.
> But it depends on the allocation position of elfheader in crashk_res. To
> avoid potential out of bounds in future, add a extra slot.
> 
> The similar issue also exists in fill_up_crash_elf_data(). The range to
> be excluded is [0, 1M], start (0) is special and will not appear in the
> middle of existing cmem->ranges[]. But in cast the low 1M could be
> changed in the future, add a extra slot too.
> 
> Previously discussed link:
> [1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
> [2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
> [3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/

So.

When I merge this ancient fix against mainline, it goes OK.

When I merge Coiby's "x86/crash: pass dm crypt keys to kdump kernel"
on top of this fix,  things do not go OK.

Here is what I did:

int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
{
	unsigned int nr_ranges = 0;
	int i, ret = 0;
	unsigned long flags;
	struct e820_entry ei;
	struct crash_memmap_data cmd;
	struct crash_mem *cmem;

	/*
	 * Using random kexec_buf for passing dm crypt keys may cause a range
	 * split. So use two slots here.
	 */
	nr_ranges = 2;

	/*
	 * In the current x86 architecture code, the elfheader is always
	 * allocated at crashk_res.start. But it depends on the allocation
	 * position of elfheader in crashk_res. To avoid potential out of
	 * bounds in future, add a extra slot.
	 */
	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
	if (!cmem)
		return -ENOMEM;

	cmem->max_nr_ranges = nr_ranges;
	cmem->nr_ranges = 0;

	memset(&cmd, 0, sizeof(struct crash_memmap_data));

Please triple check this, I changed a few things.

