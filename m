Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B0C5B56A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmvyDkK0SEMV+6hHSi9U54dzAcSRibYyWNZkwQf61Gs=; b=4k3nwECOLx+hd9K2qt5erZ4bm0
	Qrfv2rom2u6Ap/cEz42UjNO8n3wNvZJvvPJtDkG18mUZDV3gRAoXNsRd4B8OOaSa0lkx4pL1uSQ2W
	6dBijtDxjFZrFzr0pHlCgbdki9ibiUXvSA1q79vbwcALGpsAvFG6e89eO6KATcDZb+bSv2B5CzNk/
	TbeOp6HYaS25vGNe7JgZcQfBakG1C7RBPQpi5rYcFxbVXTSYdIP9zmg7FwV8aZvlGk3eIbw0+zQBX
	iHVmVhw6nDH4wLHrL5roxuu0KUfZKb09DLBbcWwE231J1htbPYYFnlPJxKWiCUDuRskpTwXp5h4n2
	foenKY1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9Hl-0000000GJw9-1qw5;
	Wed, 12 Aug 2026 13:46:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9Hk-0000000GJvr-1KFX
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 13:46:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BE8FA60A85;
	Wed, 12 Aug 2026 13:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD321F000E9;
	Wed, 12 Aug 2026 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786542383;
	bh=jmvyDkK0SEMV+6hHSi9U54dzAcSRibYyWNZkwQf61Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TQWM28p48UmnPpZTJo7OBBfMPXCQoOnJggGChZDveP5NohAsVU4NOdN8vluuJI62P
	 C5VH3XAhyXK9qQxsUmIF1KBtPh6faVdjusm0tirQscBfl0s+Pt26UgSqeySQ2b8S+V
	 MHTHaCFcsmmq1ysujL71P+gSIK5GJ9R6JMyUhoC1b6dW6lOH7VebDXE4ROaHPxIfkL
	 tHAp4JrfgRzx/OvY9v3ExhWN4Z3OwqKh0H6EQ24OhO/8ippvHUPE2rqwwBxczUSMGt
	 f98RZBZVY5ei1fo1Usxgq5O3GjAxiHAIqyK1uvyHVa2kbxC2Wrwir0CjTCmTbZPzf0
	 eNvdIGAjTpDEQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Samiullah Khawaja <skhawaja@google.com>,  David
 Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kho: support preserving high-order non-compound
 pages
In-Reply-To: <anxrvA3z3NUkWvnE@google.com> (Pranjal Shrivastava's message of
	"Wed, 12 Aug 2026 12:49:00 +0000")
References: <20260803113944.3694290-1-praan@google.com>
	<anr4-F-e5_vHEar8@kernel.org> <2vxzv79f39za.fsf@kernel.org>
	<anxrvA3z3NUkWvnE@google.com>
Date: Wed, 12 Aug 2026 15:46:20 +0200
Message-ID: <2vxzecg33103.fsf@kernel.org>
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

On Wed, Aug 12 2026, Pranjal Shrivastava wrote:

> On Wed, Aug 12, 2026 at 12:32:25PM +0200, Pratyush Yadav wrote:
>> On Tue, Aug 11 2026, Mike Rapoport wrote:
>> 
>> > Hi Pranjal,
>> >
>> > On Mon, Aug 03, 2026 at 11:39:41AM +0000, Pranjal Shrivastava wrote:
>> >> Introduction
>> >> ============
>> >> This series is required for the ongoing effort to preserve DMA allocations
>> >> across KHO [1]. It addresses a fundamental mismatch between the current KHO
>> >> restoration logic and the physical reality of high-order buddy allocations.
>> >
>> > I skimmed through the patches, they look fine to me before the in-depth
>> > review :)
>> >
>> > But we are really close to the merge window, so we'll anyway need to
>> > reiterate after v7.3-rc1.
>> >  
>> >> The Problem
>> >> ===========
>> >> The current KHO restore implementation treats all multi-page blocks as
>> >> split pages during restoration. Specifically, kho_restore_pages()
>> >> initializes every 4KB sub-page with a refcount of 1.
>> >> 
>> >> However, many kernel subsystems, most notably the DMA allocator (via
>> >> dma_alloc_coherent), frequently return high-order non-compound pages.
>> >> In this state, only the head page carries a refcount of 1, while
>> >> all tail pages have a refcount of 0.
>> >
>> > This hints that these patches could be a part of the DMA preservation
>> > series, unless you expect other users of the new API.
>> >
>> > Generally, we don't merge new APIs without the users and if DMA
>> > preservation is the only user, it's better to fold these two patches there.
>> 
>> Makes sense I think. We can review the patches here, but then they can
>> go in with the DMA series.
>> 
>
> So.. IIUC, I'll post a v5 here as a standalone series till we get
> consensus, and finally the reviewed patches can be folded with the DMA
> series?

That sounds good to me at least.

-- 
Regards,
Pratyush Yadav

