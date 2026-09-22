Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265FDC982FA
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWV8VPdptiBeMeQOpQB0KZQcSjJ+YKNTLPJopvTQN40=; b=YG8qF4cAMTmq7ydU3zUuVGrR15
	s4HyR3ggt4eQJ4zytRANm0VWYiubf/BUyGF4PE70hfGRjfgtNoUL3keHQMdXGM4XJ6Bcu8M58Vn4S
	QLGSvLd5iZbuxY/G/PbYIkoOlrWaE6rToutuEQAIwRjIskyPicu7nY8QhVCyEKaACftMVP1Cg7avh
	1DJkf7N/UrQp4oD1+2LNjPl4grsRoiKXyqyIp/b0YlrVBly2oxXJPOQrgBun3iTiJIaIAkwhTP8s+
	SSTIg/MGfZJjhQbVOOdXU1zAVPnZwoUYW7MwbESNscNezk9fD8cDMKowfbWvq0xk38RkLwBHYP5e1
	mugyIGkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8z9T-00000005FtA-2Vec;
	Tue, 22 Sep 2026 11:59:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8z9T-00000005Ft2-18Gp
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 11:59:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B5EF601F7;
	Tue, 22 Sep 2026 11:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113A61F000FF;
	Tue, 22 Sep 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078350;
	bh=HWV8VPdptiBeMeQOpQB0KZQcSjJ+YKNTLPJopvTQN40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XsS7whYVEozZ3YLFpFFcGaoNfReDX1brkr/7JIBgcT0QIQ8ij5zLiLdifdCqZWgx9
	 +fRa5XDq62q/SW15wAwOBYAjGhvbHfwQywREwed5Sx+kvac45jdB2kxHFIR7JxfzXT
	 tOa9/Y/Nw4WNsnLHtfUUyu4pWxuosDRINvT50+v+EqY6h4R1x5iSxvhJ0khYZYnzSU
	 fLrkjRkXjLQrWAhCjcgzP2Xmv/NGzCLbCPLwPACHv1zadE8qCjp6ZbkT6HUOGe25JX
	 b6PPS1W3jk3LcbB/DzpTTQCjW60A8LKchRQoqL0NaHEf92rwUVU+3ciJu8lwYibVn/
	 VxqFN7FHjwnfQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,  Dave
 Young <ruirui.yang@linux.dev>,  linux-mm@kvack.org,
  linux-s390@vger.kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
In-Reply-To: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu> (Tal
	Zussman's message of "Tue, 15 Sep 2026 19:42:15 -0400")
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
Date: Tue, 22 Sep 2026 13:59:06 +0200
Message-ID: <2vxzh5jh5wfp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Sep 15 2026, Tal Zussman wrote:

> Use a folio for the page cache page the s390 fault handler reads the
> old kernel's memory into. This removes four compound_head() calls and
> one of the last callers of find_or_create_page().
>
> The vmcore mapping only has order-0 folios, so the logic is unchanged.
>
> Compile tested for s390.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

