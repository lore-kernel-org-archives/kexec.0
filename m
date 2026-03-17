Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF44FD707B
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=feNhlZakbRYDJtWwge52jbrFTlGD2WIO1+iPdyuWmss=; b=iXu5jVvfBU0IkNZJbJ2746lqbU
	uOB96AUQZbAwDB4rZdQOjorpn5wtP6t0weLTMYAUh+tgvvz8pkENV/sFKSia7IdqiyjGLvazBGw6Y
	AKMxOmbBjdx+5JVvpvwBdO/vr+D9PYYeVGakt20golnI9SMlpWd47H+Y/Th3Q88+DVmmdzlax57Ig
	k9uM3u+8nEpD1tXxaYAdLL8twO+TyFsJ5JUdct/eR0cxE0rKy0ha2yswTUEYViBhBpXpgBn9zVet7
	mdmYvv57DFGuuWIDwDXjM0lvDLqXVKorK8c6BBX3L7Vs5VRwprZtnhjJg7+Jkn6XFyDdhfsXwU8Q6
	Ym83xxDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2SDp-000000065MY-2joI;
	Tue, 17 Mar 2026 11:04:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2SDm-000000065MA-26Ym
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 11:04:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CCD64170C;
	Tue, 17 Mar 2026 11:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C76C4CEF7;
	Tue, 17 Mar 2026 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745461;
	bh=FzN+JR6wTdlWoYca/iDWtBJ00teqmkhdZDjQECTdE30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzqjY0GpYRBoRH5wfJ7qOPgfofiRN3ukCODjKqJ9Otaoj5ox0eR5hogOK9BhTiIdC
	 HaiICmEpGcxK5rPTcirhIp7HnQ0Vowjb+FmsAJGJRZzQwuDqULh31j3ENf5VTj4xmv
	 dqT1UOqBkgSWTAWbgKE2VvrXBGE7d1H8LIWeIHhcynIPPNFlpON3BdTstI3U+abwlb
	 NOeju95h6yOj8SnR4ot4yLZC9vii4975H7Wk9sjdr75PeqEiG25fp732DOlR5TQduu
	 4W+yiV9Mhq5WWjCn/dZCJWutSSeMyV814jn5Dms4tAT3nVD8MKm6DNUMw9s0FOdaiJ
	 DfCY9fH/rgJfQ==
Date: Tue, 17 Mar 2026 13:04:15 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: drop restriction on maximum page order
Message-ID: <abk1L_gpK7Ys4TK5@kernel.org>
References: <20260309123410.382308-1-pratyush@kernel.org>
 <20260309123410.382308-2-pratyush@kernel.org>
 <aa_zglmh3AU2_RA0@kernel.org>
 <2vxzo6kmddl8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzo6kmddl8.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_040422_561418_4A7FDC55 
X-CRM114-Status: GOOD (  18.76  )
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

On Tue, Mar 17, 2026 at 09:12:19AM +0000, Pratyush Yadav wrote:
> On Tue, Mar 10 2026, Mike Rapoport wrote:
> 
> > On Mon, Mar 09, 2026 at 12:34:07PM +0000, Pratyush Yadav wrote:
> >> KHO currently restricts the maximum order of a restored page to the
> >> maximum order supported by the buddy allocator. While this works fine
> >> for much of the data passed across kexec, it is possible to have pages
> >> larger than MAX_PAGE_ORDER.
> >> 
> >> For one, it is possible to get a larger order when using
> >> kho_preserve_pages() if the number of pages is large enough, since it
> >> tries to combine multiple aligned 0-order preservations into one higher
> >> order preservation.
> >> 
> >> For another, upcoming support for hugepages can have gigantic hugepages
> >> being preserved over KHO.
> >> 
> >> There is no real reason for this limit. The KHO preservation machinery
> >> can handle any page order. Remove this artificial restriction on max
> >> page order.
> >> 
> >> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >
> > One SOB should be enough ;-)
> 
> Hmm, I figured the unemployed me (who originally wrote the patch) and
> the employed-by-google me (who is doing this new version) would count as
> two separate entities and there should be a S-o-b for both.

Maybe than something like:

Signed-off-by: Pratyush Yadav (Hobbyist) <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
 
;-)

> Anyway, I am fine with dropping either one of the two.
> 
> >
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks!
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

