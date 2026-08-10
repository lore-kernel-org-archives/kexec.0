Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC27C5AD55
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/Pw86YCt5PogCXqzDBsAcUpdrMFyTr7McP0WMQnfGo=; b=FD7WVohdvHfQiYtGXtTOzyyXFY
	aWlEnDhWrquzGdTa5q5CTSPMZvQ6biNwMu9Aa4Q6WCp2zigBoF5rfAq61r+Prh9wCYw3Rhq//hGdn
	Huh1wmf4bskQEeKijKtCqRk3b4SLgjDiqU57BHXLDMxDQbqIlFq9dVBXs3znXyonOtraGOACzznUh
	LFQZ3wW6IseG/BTVfghUfT5fkLr2Yzobq1yeXY1phwwowZDnnOTd1ndY95A1NP8vwbCDwmR6LmBCQ
	FBLECDeyAHDW8e8AtoNf02y3+wJxoTqMA9qOZnnqoR+AFy3XdjIR5fqlr0kkjXyaRknxorEsrx8Ce
	E3Ih/Wmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtOyr-0000000BlRX-3mML;
	Mon, 10 Aug 2026 12:19:49 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtOyp-0000000BlQn-2Hnq
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 12:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c/Pw86YCt5PogCXqzDBsAcUpdrMFyTr7McP0WMQnfGo=; b=fx3B4nGmwKDfd8ozZL004I0DB0
	jwjXO1/RrOicNejnDx1r+5Lfsw1fLjHdYtoNoy+S/wRxlp9iYSUyxC7HNbhtlk6XtgYs7vq5qs8WU
	sjR9pCpm9XM2QHYiwSgWqcZhSJI07FmFM+yx5diV3JgI/FsXwz/bsXj9B+yudBiIu2RGEaSUZ6KsP
	l9OiT9aHpxVQEriHfzTeuxIK+ThrtP9iqszMrOaXddkwXz72S4kWYySAygIsM4x8wcMG9BIX/VeRz
	mJIa69TczJNUUIGjHQg5SFYr2OZ94jXuyHj9t3cp7S37UjsspYwm19n5ACbUHvG3h/C0RsyokPe3W
	FdPoEUWg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtOyO-002kE1-0b;
	Mon, 10 Aug 2026 12:19:20 +0000
Date: Mon, 10 Aug 2026 05:19:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v4] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <annBaxudb5hcpSuU@gmail.com>
References: <20260807-kexec_posioned-v4-1-70d57f14625d@debian.org>
 <anmb9FHMEMygENiO@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anmb9FHMEMygENiO@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_051947_583836_0C8F6AA4 
X-CRM114-Status: GOOD (  20.30  )
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

On Mon, Aug 10, 2026 at 10:49:16AM +0100, Kiryl Shutsemau wrote:
> On Fri, Aug 07, 2026 at 07:05:09AM -0700, Breno Leitao wrote:
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index dc770b9a6d053..e097e980b1439 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -212,6 +212,16 @@ int sanity_check_segment_list(struct kimage *image)
> >  	}
> >  #endif
> >  
> > +	/*
> > +	 * Reject destinations that land on hardware-poisoned memory: the
> > +	 * relocation copy would machine-check on the bad frame.
> > +	 */
> > +	for (i = 0; i < nr_segments; i++) {
> > +		if (range_first_hwpoison(image->segment[i].mem,
> > +					 image->segment[i].memsz) != PHYS_ADDR_MAX)
> > +			return -EADDRNOTAVAIL;
> 
> Other -EADDRNOTAVAIL usage indicate error on user side. But this is not
> a user fault. Maybe -EHWPOISON instead.

Ack!

> > +		if (!PageHWPoison(page))
> > +			/* page is good, let's go to the next one */
> > +			continue;
> 
> If you don't care about re-using clean part of poisoned hugetlb folio,
> use is_page_hwpoison(page).
> 
> This would do:
> 
> 		if (!page || !is_page_hwpoison(page))
> 			continue;
> 
> You would spin a bit on the same folio, but shouldn't be a big deal.

right, it will spin a bit more when there is a poisoned page in the
hugetlbfs folio, but it keep the code simpler, which might be a good
trade-off.

Let me update it and respin,
--breno

