Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B24CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhF+jUpU1E0204EIQ63W4XnUB7T83kejus0i2mjqkkQ=; b=VRvbjuEcNQBs2CWJ/7n8hrMawn
	nLFOXGPb2/Fz5qwLuyG80YAszJRUE6S3s7KY+kG896B3Wk3hQUQqzdpfjuEpDkObf1kb4PD5v9RyB
	XfkoZZkWLEV4QzL04MiUHL/m7uJkKxHpAlXdZpQp1dHgq4Y4/cCJYWiPwzdkXG5FyyAO8b9uNbL0s
	Txa6nTgJ+vxGMFA5WQTjSL8qMexy9vvHngsBdVAq0w29C7z4o9CFUN/T604mc6wDWp/iYe1STyOZm
	1IQPhrDU/ac/56gWcnsR7L60t/EJIwVHkfEtoH8XJcd4Xrw0+O9hyoVQ3DFiKdPYEWIpg+j4mSGlt
	v65t209A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUm8O-0000000FDEM-2u4S;
	Wed, 03 Jun 2026 13:59:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUm8N-0000000FDE8-2yzO
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 13:59:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 131F56021A;
	Wed,  3 Jun 2026 13:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948C71F00893;
	Wed,  3 Jun 2026 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780495190;
	bh=AhF+jUpU1E0204EIQ63W4XnUB7T83kejus0i2mjqkkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=etVZk3/aXRNhvGcH3Bm6kbdy06t+JcMXHeruO2GnT/u6CtGXxBz8gfWLcADNEMK+W
	 TrgH1b1J0MvahPjHWsUzff9yQnoRg1zcYs4RD762G651aDk+OSt8A1CowDDE8at8R2
	 ytUnXImjFNGI1IoeZMrkD39QqUJHdMTAMWeoIJCpyABH9UHsJirRprFUWWOroEHiuM
	 lEzJwr5Hpirzmly1jAEX5EDKKn3TwLd/iP3y/wuvPqUJISIi/JVf0XiiG3di9Mmawm
	 NOlnD0DFIRpnMHBYzHIZq2SbVwtglNMvID+T04ePOW5h3np1YwRp0rEHVNzWVWoutH
	 Y2cnIDgib1x5w==
Date: Wed, 3 Jun 2026 16:59:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block serialization
Message-ID: <aiAzT9TvGYjITiB8@kernel.org>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
 <178046937151.468621.13398573538792303093.b4-review@b4>
 <aiANtYRRDr5iO5QR@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiANtYRRDr5iO5QR@plex>
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

On Wed, Jun 03, 2026 at 12:05:04PM +0000, Pasha Tatashin wrote:
> On 06-03 09:49, Mike Rapoport wrote:
> > On Wed, 03 Jun 2026 03:28:58 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> > > new file mode 100644
> > > index 000000000000..8641c20b379b
> > > --- /dev/null
> > > +++ b/include/linux/kho/abi/block.h
> > > @@ -0,0 +1,56 @@
> > > [ ... skip 25 lines ... ]
> > > +#define _LINUX_KHO_ABI_BLOCK_H
> > > +
> > > +#include <asm/page.h>
> > > +#include <linux/types.h>
> > > +
> > > +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
> > 
> > It's never used by block set and after looking at the following patches I
> > found that it's appended to LUO compatible string.
> > 
> > While this works for LUO, I think it should be kho_block_set_restore()
> > responsibility to verify the compatibility.
> 
> It should work for any component that relies on  kho_block. My proposal 
> is to use this method for other common KHO data structures (e.g.,  kho 
> vmalloc,  kho radix, future kho xarray). There is no need for them to 
> carry the compatibility string in their metadata, as whoever uses them 
> will include their compatibility string.

So if, say, memfd_luo uses kho vmalloc, xarray and blocks it'll have five
compatibility strings glued together?
 
> For now, reviewers will have to make sure that if the ABI header content 
> is changed, the compatibility string is updated.

-- 
Sincerely yours,
Mike.

