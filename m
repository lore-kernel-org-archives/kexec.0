Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30193EE498E
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/by8ms9ik3qDquUn4NMwAfjs3tVG1+YCThyUOlc3f0=; b=EtKTuKLCuoTrUz523TE4PvXTMF
	v8X3ApN7FGUubzkxfrIZGGSKkZK+AVoTYO3Z8m2OoI/X/6TQbe3IgiyI68C5fOt2N1+nZwBCUu6Yt
	eh3XeLPi+euUpPZmXvqk1jJanfbH3oK+BWpxWYQfhjU2zbXTwU1E07n8oOnNPs/3bGCL5sw5HI4vZ
	OWvPmKz76aqGeuGxe0uF//sqIVZvdss7B+8NNBIcjD0VTVqXQqd6l9HegpdX/5NOnpZDnHqe38PSk
	UstS66CpkTOoy9Owho1o3erzAzRJGNe2viGoxEigdX8jSuAdKSU++GV6HX80SEd3RZ28rZ66qAU+A
	gn71sL5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vadMS-000000056es-1YL4;
	Tue, 30 Dec 2025 17:18:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vadMO-000000056eQ-3CI3
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 17:18:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BB95B6000A;
	Tue, 30 Dec 2025 17:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8ABC4CEFB;
	Tue, 30 Dec 2025 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115095;
	bh=L0yfA8iQeAPZwmgn/JwVdXX5YqxPFm2orAje+7+04ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYM3oo3UppMQ0vCZ2e+dnJ9iWV/Fm/7le8GBKEsJYssAPtlRd3gl6TSDH0kOHsuuE
	 2CK/6r3yvigVKD8DqO17s1dpTjoa45N0j+MoZi52GF6iRNyxhBCbhU/4E6UVLi5u/I
	 Cvrlc9erJL8EflwAmBYCX0WQ9F9j5xzUYvyeFrtu8kKozKh5agFWOGCdd763muMTV2
	 3KR3v/cweWyWwdc2n1IOj15lQzg/bjmdeRVsqwbJ4Y6/NqVvLS/BX22wy0FiBxjMWG
	 9VSE4JR3Zdbke7u2irGUc6nFZPxXCUbv2Xl7dLVca4/9SsPvSKDJ4S/5CIcz3HkhoN
	 es6ZQlUcsmseA==
Date: Tue, 30 Dec 2025 19:18:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aVQJUPOn85WlJaM9@kernel.org>
References: <861pkpkffh.fsf@kernel.org>
 <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org>
 <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org>
 <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org>
 <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
 <aVP6wBYoHJQsplIl@kernel.org>
 <CA+CK2bDZPwYpUhksDLSbfVdVm5TYbh0XrOKRV=q4YjGpqH+Fwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDZPwYpUhksDLSbfVdVm5TYbh0XrOKRV=q4YjGpqH+Fwg@mail.gmail.com>
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

On Tue, Dec 30, 2025 at 11:18:12AM -0500, Pasha Tatashin wrote:
> On Tue, Dec 30, 2025 at 11:16 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Dec 30, 2025 at 11:05:05AM -0500, Pasha Tatashin wrote:
> > > On Mon, Dec 29, 2025 at 4:03 PM Pratyush Yadav <pratyush@kernel.org> wrote:
> > > >
> > > > The magic is purely sanity checking. It is not used to decide anything
> > > > other than to make sure this is actually a KHO page. I don't intend to
> > > > change that. My point is, if we make sure the KHO pages are properly
> > > > initialized during MM init, then restoring can actually be a very cheap
> > > > operation, where you only do the sanity checking. You can even put the
> > > > magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
> > > > it is useful enough to keep in production systems too.
> > >
> > > It is part of a critical hotpath during blackout, should really be
> > > behind CONFIG_KEXEC_HANDOVER_DEBUG
> >
> > Do you have the numbers? ;-)
> 
> The fastest reboot we can achieve is ~0.4s on ARM

I meant the difference between assigning info.magic and skipping it.

> (shutdown+purgatory+boot), let's not add anything to regress, as every
> microsecond counts during blackout.

Any added functionality adds cycles, this is inevitable. And neither KHO
nor LUO are near the completion, so we'll have to add functionality to both
of them. And the added functionality should be correct first and foremost.
And magic sanity check seems pretty useful and presumably cheap enough to
always keep it unless you see a real slowdown because of it.
 
> Pasha

-- 
Sincerely yours,
Mike.

