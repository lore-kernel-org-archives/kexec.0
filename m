Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E5B107BCD7
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ec3TnsxrQwvNWMYSCA+TVrh4TnAyLnsbcwvWaQQyqRA=; b=b7bKZXBsbkGeOE/CcLWtAJvhU2
	mZag1dKd/dJjX+8TpVRJTTTS2yysNUbRcGuiK/0YBRg9/RLa1rrkacha2jL3eUBCFBZYHbn3SqNbw
	eK1Vq/R0FiOHNnulzxpoITmbpNiq2HPw3NjkpO7+4bLWJgm2ewZiOZp/dkKJSP0zLLxTESycD8++f
	aPG/hhNCcet0f9XR7UG3cys72qvdALr4T1lKku1hy/Fg+/jDNu567ijZMbDThTpZnXPJ9ea4BeZcq
	urB1N5o7U+mrL+2YHdGTWyxaiYhUB0FwCKnpg+d0UwiuBOG985/cPqMilbkSULiPGxDcBOenjfGqV
	C0wLi+lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w17Ru-00000000wUl-1bSi;
	Fri, 13 Mar 2026 18:41:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w17Rt-00000000wUb-3nmt
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 18:41:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6FE16183E;
	Fri, 13 Mar 2026 18:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECB7C2BC86;
	Fri, 13 Mar 2026 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427284;
	bh=50cycpp4ATFd7gtddJcbklbgmFyHqoxs3fVcSu1G/XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTk6A1vUmlpvT1mOSDswCtWk+iRf2GWxhSIkKEiPuayrILlZX7Wcm7L6bYquGKq6r
	 7BEyinSpm7S9ypvwf2B2tqzNB81XFz5AMmsngxrtEFdfWA3PY4y/c0H1lwR7R7SDIT
	 9HiwNeU7lmMoy2AhFqImDZ5MR30JpjE7p8j1HTxv+xqvFBRerby2sx0RPlAOuIMk2m
	 T4k/GElJMF0rFiAqjGNcEh8uHVy55fi5D9WI4D+zeJA+CEYLe2Ih6URw0VJyoRYIbm
	 0x+wNLyu1mEN9IngdqACYLrNYuQfiwzgXXcjGND034eEfx3DbBWHLl3dRTPJhH8bzA
	 xyaIQ3XiW2IBQ==
Date: Fri, 13 Mar 2026 14:41:23 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <20260313-futuristic-steadfast-caribou-2b628a@lemur>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <abPdItJ152oMzGd6@ashevche-desk.local>
 <abRN59ST3uRDS5-e@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abRN59ST3uRDS5-e@yury>
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

On Fri, Mar 13, 2026 at 01:48:23PM -0400, Yury Norov wrote:
> (Thanks for b4!)

\o/

> Interesting thread.
> 
> So, my workflow is:
> 
>  1. git format-patch --cover-letter
>  2. # Edit cover letter, add To and CC section
>  3. git send-email 000* --to-cover --cc-cover
>  4. b4 am 
>  5. # Address nits/typos in the mbox
>  6. git am 
>  7. # Address substantial comments in git
>  8. git format-patch -v2 --cover-letter
>  9. # Edit cover letter again to restore body, To and CC sections
> 10. git send-email v2-000* --to-cover --cc-cover

This is doing it the classic way.

> So, yes I loose recipients on every iteration, together with the whole
> cover letter. But to me it's not a big deal because I can just pull
> them from my mailbox.
> 
> In the better world, I'd like to have:
> git send-email -v2 000* --to-the-same-people-as-in-v1
> 
> In the perfect world, I'd prefer to keep the cover letter under the
> git control, once it created, together with the recipients, once they
> are added, and be able to edit them just like regular commits.
> 
> There's a 'git am -k', which is seemingly related to the matter, and
> it keeps the [PATCH] prefix. But it's not what can preserve recipients
> for me.
> 
> I'll try b4 prep and trailers as suggested.

Yes, it was created to simplify this process significantly. It's still mostly
git and email, but at least you won't have to do quite so many manual steps.

Regards,
-- 
KR

