Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DD8C55179
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZaCVwMXNLzr4rttTuYs+5Z/9LNgxH6VHMXVNEb+GRw=; b=4lDcVqipVpkdy6eWRYBsqtP4oO
	oPhjvWIhqYgTrcbuY72kUJ3em2pq+DFMLo3SK27m0gRO6d36bnUJBdzd7E80EDVzXc34N2LR5BR3y
	mV4dH2pVA94IJRmDPJARECMv2G691gOuj2/Kw4yj/0tVl+FP28X26SH71ZVvzayisHNig3TRk1ID6
	SzUy8W4I3UKIpdo06tQpwCcIuXHICqyxUUARvy3tnelJVf1eON5aZRxTYtcsy3uhcTAJVjQ52r2IX
	xMMQ6l7rSrIjx1/x6fv1pTYxh7RSGQURgw6j/L6QcodGLN9cmIqhQVrwh2ihurvNh5gQfgfnOuDv6
	S6z2YLcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqqqI-0000000GwTk-1HSG;
	Mon, 03 Aug 2026 11:28:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqqqH-0000000GwT9-0iK5
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 11:28:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9B3E360A82;
	Mon,  3 Aug 2026 11:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656011F000E9;
	Mon,  3 Aug 2026 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785756504;
	bh=kZaCVwMXNLzr4rttTuYs+5Z/9LNgxH6VHMXVNEb+GRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HOHKYs3abxK0pyHeRQpo/WcMDEbgeAxihfb06G2dsMdy5m7ntVCJmQ+hV2LXvuzBL
	 LHJ0YUsfQ33bTGBj6HyC6pYmMBtctoq97dzFUzY7Flq5LuE/NEO4KFe4dpC1C6GPuJ
	 n/WTWAHwDii0Er7bEQdzUFnlFIcU+tK2MOoqU9k0vCZ99QGAhuQ2m6SCYgVKhBOlkC
	 /bs/oKdm9w/d17kbOyLmwhK8p5TWRkG3DIIgSIu/Sgtsjp0W4s9KeRIy5C3T3a3ogZ
	 mei4p6nvJ8fl29Wn+X6gqswrOIZlEncOkD4AMPEDx55Hsqdfr1JB4A5TG9o7Crr2Zv
	 xgA478z3hkFVA==
Date: Mon, 3 Aug 2026 14:28:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-ID: <anB7UXU0DduiJ-Lw@kernel.org>
References: <20260717134028.2880508-1-mclapinski@google.com>
 <178453346331.1178000.18393988680596713513.b4-ty@b4>
 <CAAi7L5dE=oROWR0mTknPyjnL-XRXuCUsfHSiGh7yUqWCSzE5PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5dE=oROWR0mTknPyjnL-XRXuCUsfHSiGh7yUqWCSzE5PQ@mail.gmail.com>
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

On Mon, Aug 03, 2026 at 12:14:18PM +0200, Michał Cłapiński wrote:
> On Mon, Jul 20, 2026 at 9:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, 17 Jul 2026 15:40:28 +0200, Michal Clapinski wrote:
> > > kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
> >
> > Applied to fixes branch of liveupdate/linux.git tree, thanks!
> >
> > [1/1] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
> >       commit: c553c774c9715e1c92c48b342f30d60601693fb4
> >
> > tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
> > branch: fixes
> 
> Hey,
> I see that this change (merged 2 weeks ago) didn't make it into linux
> rc6.

I had a really busy week last week, sorry for the delay.
 
> Do we need to do something manually to get it into the nearest
> release?

I already did :)

https://lore.kernel.org/all/20260803112452.1793120-1-rppt@kernel.org/

> Thanks.

-- 
Sincerely yours,
Mike.

