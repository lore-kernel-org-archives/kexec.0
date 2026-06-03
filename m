Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD76FCD6E6E
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Row1/ZMLh6mM+sigh4dqTjgwYgOfCp9sUzuCj7aY0Fw=; b=wfz2wYisi8kD3N2/TR80F4qof0
	6x0T8v5IQFBGU+rQEmjIvvzUn7fytN3VqzR9S/3aLCHRBfBYO++mQ5a/GMNw/DraOhGF2CyhtHSTA
	HIa1OXA4HHuCMcFZICWMt0n4KK20/0HrCXJjlf7VanhkwooZDNazCPzyk8mE3KAd5KCfoAgaklye4
	Y4yhdYFvbz5Q2kDtSYzBBYYdMijNH+SwqXxxu4wm31pseeVw217LOkteL417iXvlVRk/IXEV3hXh9
	KTFC6HQPtc4/3YPPsdOGjx+IuEod1NfrTublwUgDWtfxZ/dJAUzD2psD3t0oabZNzhhun+JiIi82p
	8z+ArrCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnMl-0000000FMWr-4Afs;
	Wed, 03 Jun 2026 15:18:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnMk-0000000FMW7-43Io
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:18:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5FE2C601DD;
	Wed,  3 Jun 2026 15:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17521F00898;
	Wed,  3 Jun 2026 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499926;
	bh=Row1/ZMLh6mM+sigh4dqTjgwYgOfCp9sUzuCj7aY0Fw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=gqiDx2XIJ6TAOhH6COyc85O7nZTepQiHDoIwbNNC292yB9TuNTxpGhJ/VrhM5MgSG
	 hCV+5zMk9sWy8BJLb6mJEiXT/PFhFr/ysO1atbo7egQSNjeeYYqVvW3/maP6WuQDLl
	 4ksBKHdCFbbC0xk3Wc6+1V91XA5ji5JyMED+9Rqs+mbNNtuzP4kry6+rq0iFxpuMv9
	 QzEbzzSDWUgCIhTx4qU+EXMSm3EoPiuHSgHqN00eIC2jOYah12EaiVGODawZwWRz12
	 01NbzKgqcrqvjs5B7e9buR3+Wf9D07ezTSb5wyK22sUjVLWU7hMtWJvkm2AbPEunzS
	 0JKuLIzwWry2w==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block
 serialization
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kselftest@vger.kernel.org, 
 shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com, 
 kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com, 
 graf@amazon.com
In-Reply-To: <aiA_j7udFaO9TRBP@plex>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
 <178046937151.468621.13398573538792303093.b4-review@b4>
 <aiANtYRRDr5iO5QR@plex> <aiAzT9TvGYjITiB8@kernel.org>
 <aiA1slnqPnC4_8XY@plex>
 <178049725439.475072.11560134126837430744.b4-reply@b4>
 <aiA_j7udFaO9TRBP@plex>
Date: Wed, 03 Jun 2026 18:18:38 +0300
Message-Id: <178049991886.481270.8804649242857550471.b4-reply@b4>
X-Mailer: b4 0.15.2
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

On 2026-06-03 15:03 +0000, Pasha Tatashin wrote:
> On 06-03 17:34, Mike Rapoport wrote:
> > On 2026-06-03 14:11 +0000, Pasha Tatashin wrote:
> > > On 06-03 16:59, Mike Rapoport wrote:
> > > > On Wed, Jun 03, 2026 at 12:05:04PM +0000, Pasha Tatashin wrote:
> > > > > On 06-03 09:49, Mike Rapoport wrote:
> > > > > > On Wed, 03 Jun 2026 03:28:58 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > > > > > diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..8641c20b379b
> > > > > > > --- /dev/null
> > > > > > > +++ b/include/linux/kho/abi/block.h
> > > > > > > @@ -0,0 +1,56 @@
> > > > > > > [ ... skip 25 lines ... ]
> > > > > > > +#define _LINUX_KHO_ABI_BLOCK_H
> > > > > > > +
> > > > > > > +#include <asm/page.h>
> > > > > > > +#include <linux/types.h>
> > > > > > > +
> > > > > > > +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
> > > > > > 
> > > > > > It's never used by block set and after looking at the following patches I
> > > > > > found that it's appended to LUO compatible string.
> > > > > > 
> > > > > > While this works for LUO, I think it should be kho_block_set_restore()
> > > > > > responsibility to verify the compatibility.
> > > > > 
> > > > > It should work for any component that relies on  kho_block. My proposal 
> > > > > is to use this method for other common KHO data structures (e.g.,  kho 
> > > > > vmalloc,  kho radix, future kho xarray). There is no need for them to 
> > > > > carry the compatibility string in their metadata, as whoever uses them 
> > > > > will include their compatibility string.
> > > > 
> > > > So if, say, memfd_luo uses kho vmalloc, xarray and blocks it'll have five
> > > > compatibility strings glued together?
> > > 
> > > That is correct, but it will be in only one place: the header of the 
> > > client's KHO subtree. Since it is dynamically sized and 8-byte aligned, 
> > > it should be safe to include in any struct.
> > 
> > This is safe, you are right.
> > But I have more usability concerns from one side and the duplication it
> > causes from the other.
> > 
> > I can see the downside of putting the version information in the data
> > structure itself as it either requires a different header for the first
> > element or needlessly increases all the headers.
> > 
> > But 
> > 
> > #define LUO_ABI_COMPATIBLE     LUO_COMPAT_BASE "-" KHO_BLOCK_ABI_COMPATIBLE "-" KHO_VMALLOC_ABI_COMPATIBLE "-" KHO_RADIX_COMPATIBLE
> > 
> > is not really digestible too. And it forces KHO users to potentially
> > track KHO internal changes.
> 
> These are compatibilities; I think they are quite digestible, both to 
> write and also when the  LUO_ABI_COMPATIBLE  string is printed out for 
> debugging/info purposes.

I agree to disagree :)

It's KHO property, not it's users.

> > We still don't promise any compatibility between different kernel
> > versions so to avoid blocking this series on the decision what is the
> > best way to convey KHO data structures compatibility I suggest to bump
> > kho ABI version in v6.2* of the patch that adds KHO blocks and postpone
> > this discussion to after rc1 when we'll have plenty of time.
> 
> Let's keep this patch as is for now. We will have a broader discussion 
> when we convert other participants to this new scheme. If we decide not 
> to pursue this approach, we will change this code to use an independent 
> compatibility string. However, having this in place as a template will 
> help us convert other components correctly, ensuring proper alignment 
> and that correct string helpers like  strncmp / strscpy are used—which I 
> have already ensured is the case in LUO.

Pasha, this sounds like salami approach :)

We didn't agree yet to convert other components and even to use this
scheme globally. Changing this during -rc does not seem a good practice.
So whatever new versioning scheme we'll come up with, it'll have to wait
until v7.3.

Let's bump kho and LUO ABI versions and drop the concatenation for now.
It's a small change to the patches, so I don't see it as a blocker for
merging them in v7.2.

> > * sending a new version of a single file does same email traffic, but it
> > confuses b4 and quite possibly other tools, so I think v7 is better.
> 
> Agreed, I also prefer re-sending the whole series...
> 
> Pasha
> 
> > > Pasha
> > > 
> > > >  
> > > > > For now, reviewers will have to make sure that if the ABI header content 
> > > > > is changed, the compatibility string is updated.
> > > > 
> > > -- 
> > > > Sincerely yours,
> > > > Mike.
> > > 
> > 
> > 
> 



