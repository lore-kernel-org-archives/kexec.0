Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91F5CD37B9
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qrrUhpmrrpezbRav6XF88sv+CB2IUPx+VmpRhmh/K3U=; b=2D3R+tijgL5SfeqrH/9XBjdRlq
	5i7QNWH3uD4F3ySdiscUsoE3f2iJOdj3w4tAM5xVVK4zV53BrpGfSatv3Mc4Wrhz6NIwGyVF4sE/U
	i+jLvXPlNf7JGlIYXKtu9CEUMvDthbf88MvGAUjOjrLHIJFKXy3etzIaBHevi6dTJeDotU0fDb/Im
	5upqqVa2fSD9JZbgeOFR2PB4pIy+ndqaxdhhIsESBzAAlu8txjpFqJ8wn5xm6paeV8KEivE/DBj0R
	in2v7C8owtP1Owf7oYXh/qDbdjx9siMnS7PDNVdBBZFFgXSCsg7yevMLiXO4SPnXhKZdL1nLi5XYv
	gqYHoKEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPVX-0000000DUMk-0SmL;
	Mon, 11 May 2026 12:13:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPVU-0000000DUMF-1v75
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 12:13:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ECB5E44201;
	Mon, 11 May 2026 12:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6569DC2BCB0;
	Mon, 11 May 2026 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501587;
	bh=ACia1fo3j4FYA6Cxli5LduVzIboVeoDpclxkAUCwXgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSlkMx09q7PpYOs8E1U0TOgx4LzltEiqjV0To4T92oDu6bM3pMnDy7qV1y11OPQNj
	 WBrZXGKH4R1OfzCvpv8STq9HmW8TdDm+ycGJZeybCFSMRGaVWjw2zuPMgSiz+5Uczs
	 lF1DfYyMJ3vldk4MKHM4lFVoVabV7gKcu48dw7TXdUyQVMiNzQINMeT4L6GgRM0bhw
	 BCElMcg9/z/7Zr2CkhA+3Y46ZINUNc9FmrP/wVR4vG2Bp461LGMryTgKVMeb1k1pGO
	 6OGrTzJrZ5xym27A1ZB/cNmHEeowzT/vWIU8ticpTbGmRmzJQY2G3YymBtZPqxUR2n
	 MK9MJGbLjs+AQ==
Date: Mon, 11 May 2026 15:13:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] kho: return virtual address of mem_map
Message-ID: <agHHzJS7bLPHk1GJ@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-12-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-12-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_051308_614026_5EF4B1DC 
X-CRM114-Status: GOOD (  10.74  )
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

On Wed, Apr 29, 2026 at 03:39:13PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> There are currently 3 callers of kho_get_mem_map_phys(). Two of them,
> kho_mem_retrieve() and kho_extend_scratch() need the virtual address.
> The third, kho_populate() doesn't care. Make things simpler by
> directly returning the virtual address. Rename kho_get_mem_map_phys() to
> kho_get_mem_map() to accurately reflect what it returns.

This should be moved earlier, before replacing open-coded get_mem_map()
with a call to kho_get_mem_map_phys().
 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

-- 
Sincerely yours,
Mike.

