Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D28CAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rl3PfUKjl2JoVNJ191B+kLBbdZ4ITYuMp+Nygsw33BQ=; b=KEPP9TSXT6KLTG0LrDx1bNav/9
	jUj/PVpFxoO57l/8z7teANIhNuKh4HPpFTsq2xZVhkSuPVZL7bmWRUgU1ZN+41OqjmqOm7qFPwHtH
	Nj40kbcZK2m49RhMsPAFs/sbR03nT+irfpRO+EGi/qOLKLB0cmXjYDckfWXicVL71azFNCTL9dJ/u
	529GQS33dLuxgyuaRtztFDr1rHlWDjMSXjmR7+u9abk68u/c0HOY/0Hxa//3mG5lvke1auvu+zUBG
	IZ6s0Rb4bMKq+0XE9C8J4DYEUz8cF55ZrbFRJQHNCZ3iZAVF16ePHfdl01SmHQ8YVnQI7pZphVzuY
	AqyCcMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWs2-00000008A6p-0UJy;
	Tue, 16 Sep 2025 14:41:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWs0-00000008A6T-2c85
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 14:41:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 416234375D;
	Tue, 16 Sep 2025 14:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B066C4CEEB;
	Tue, 16 Sep 2025 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033684;
	bh=pmJ6FNI376ycjtQaaN8sACRuV+7IyNdiBXbvSGwTn4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZu3ijssENglOnURSerpM3JLIbhS9/hpMCoVqQhWFCXpniBu2lgaawd2xNTfv4uK0
	 JnpYYuGXLpWk90+FMLagcSonqqfnaooTN9wEe9SRLGVNu26OLG9/JRjYxIHB70L4ab
	 YXcPZ5kYoapZGdwLZ4Trt5SFbW87F/uh+1nvgYFBk1X+pCOKe1FNROUDL0QkytGNTI
	 bidl46eVofmaBxLtcF0hKniskx0ZHbbsOSS/rk8TwLp3AvHc5bzZf50IGO5UI9iUFg
	 +P5V7b9EmaXQS7OfqIuJS3aQY0MnuaV+3wOzcKhCmp38KfTNapAH6JJpnioAoJuN/F
	 Sg7urIoXBE0Sw==
Date: Tue, 16 Sep 2025 17:41:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMl3C-jSa1_TBv0K@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
 <mafs0bjnaimvc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0bjnaimvc.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_074124_680515_9C646472 
X-CRM114-Status: GOOD (  19.86  )
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

On Tue, Sep 16, 2025 at 02:48:55PM +0200, Pratyush Yadav wrote:
> On Mon, Sep 15 2025, Mike Rapoport wrote:
> 
> > On Tue, Sep 09, 2025 at 04:33:27PM +0200, Pratyush Yadav wrote:
> >> Hi Mike,
> >> 
> >> Also, I am not a fan of using kho_restore_page() directly. I think the
> >> vmalloc preservation is a layer above core KHO, and it should use the
> >> public KHO APIs. It really doesn't need to poke into internal APIs. If
> >> any of the public APIs are insufficient, we should add new ones.
> >> 
> >> I don't suppose I'd insist on it, but something to consider since you
> >> are likely going to do another revision anyway.
> >
> > I think vmalloc is as basic as folio. At some point we probably converge to 
> > kho_preserve(void *) that will choose the right internal handler. like
> > folio, vmalloc, kmalloc etc.
> 
> Sure, but do you need to use the internal APIs? Because doing this way
> would miss some improvements for the public APIs. See my patch for
> adding more sanity checking to kho_restore_folio() for example:
> https://lore.kernel.org/linux-mm/20250910153443.95049-1-pratyush@kernel.org/
> 
> vmalloc preservation would miss this improvement since it uses the
> internal API, even though it will clearly benefit from it.

The core restore API is kho_restore_page() and the improvements should land
there, IMO.

Then whatever uses that core API will benefit from them.

-- 
Sincerely yours,
Mike.

