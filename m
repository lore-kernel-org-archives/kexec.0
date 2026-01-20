Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5B5D2ECF7
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5HTjNG1Xvuo8jqOgb9lzEtQALllJNhz/Zohl7pFn+bU=; b=Ta3u/iK3RbUwYRJULIjpg43VJs
	f7NAclUe3JlUAaStxvkReso/7SVS0heHrh9a3GSVqLi7sSfitfrCNRMDY+PhaC+Dg8hmwLtPwko5l
	lE2NDTjfZKe2r2qTLF7JhRzT9bwZXiOnsS9Ce/E8nXmEi6g2+7lF6Zou6WnADRUHhBKEW8oKPaJUh
	rfPFvqfBvCGXEMTm+039MKrVlr9s36grOAKzIdriJoH7GvXW05kbJExDXMvM4ZkjmSEhMgAaAu96b
	+/7AXvTFTLlUQC72WEW1lQdnpkohn8J+gKKRXtVMgaBWQpZKaL1OWcMjPFezVtHyz+egIUemDHUFr
	61d7GQWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viBRN-00000003tB2-2f01;
	Tue, 20 Jan 2026 13:06:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viBRM-00000003tAv-1bwG
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 13:06:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 74FCF60018;
	Tue, 20 Jan 2026 13:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23520C16AAE;
	Tue, 20 Jan 2026 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914395;
	bh=rERhQa1jZykoq4PB899x/lK9oiqVu+OrztuGSTog//s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+19VGW689YQmfWzj3ws0xOaW1zvWCBaLeDwyOtrCW/QsH7JreF9icWorSeBkmMLm
	 wHoxMCxl8Dg3oIpmElK2vJr74pnxB2DA/ebUS0FIepbIVXKfAZTy0IyCznsd6sY7a9
	 4SO5+2Je1YUSglE89KLJdEGJUdp+SuFt5KDobPMjIxamW3ol4YyJCmzghmcmUWc0tp
	 HEW+Joe4fGhn0gfxKC6TkO/vdylolOqcDsta2xp8IZ3UqJlcA/4Q5B3573slxqg0Cv
	 TmXA0ah/tHDPUAfB090eZhZfGcZJ6fFNAw7BoxQNFsmVtENhB0quEZPwr8ghmHKVQV
	 Pm/SLNhnO0E3A==
Date: Tue, 20 Jan 2026 15:06:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 1/2] kho: use unsigned long for nr_pages
Message-ID: <aW991CRBJ3QlNG2i@kernel.org>
References: <20260116112217.915803-1-pratyush@kernel.org>
 <20260116112217.915803-2-pratyush@kernel.org>
 <20260116142635.b90464ed9772c146a9842370@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116142635.b90464ed9772c146a9842370@linux-foundation.org>
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

On Fri, Jan 16, 2026 at 02:26:35PM -0800, Andrew Morton wrote:
> On Fri, 16 Jan 2026 11:22:14 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:
> 
> > With 4k pages, a 32-bit nr_pages can span up to 16 TiB. While it is a
> > lot, there exist systems with terabytes of RAM. gup is also moving to
> > using long for nr_pages. Use unsigned long and make KHO future-proof.
> 
> We can expect people to be using LTS kernel five years from now,
> perhaps much longer.  Machines will be bigger then!
> 
> IOW, shouldn't we backport this?

The latest LTS is 6.12 that still does not have KHO, I don't think it makes
sense to backport this to 6.18.

-- 
Sincerely yours,
Mike.

