Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3494FCD6E4A
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OoiGlH/r+jJ1Fp71foigp+gKSr0VX5V5p1UlBTjIHRI=; b=yWmST8Yb/zbLqnMMUsk8Fy1RLC
	Eo9Pr/R6Tq2+uYYY/mem9ZDv7FgY/GJygYFSI/rmfbU+lhmvTVq+PmWRyYRD0FhrNg9jqBGKFXMhT
	wLUAYvmZAsawLY9CZrAzptl43mMwTy42Bj+JqzJbN91hPWKGBaAw16P0cm1yqZcZSF1zp30I6vK1+
	wtwWi+Y+aU27ExdGm+pconKAcfjAWdHW+I8JOmRQwzoKcwUqbwrl5IET3g32naw9LESrNMHq67WnZ
	N/yhXTYe+Gxyma8r6jbuO7kPCS+kZHSr4UEbuDqed7Ou4z8fzEIgusqnb8sHw5oDGNAdoxFsDVrik
	H8+/L0mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUP2S-0000000D5O2-47By;
	Tue, 02 Jun 2026 13:20:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUP2Q-0000000D5Nd-3uop
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 13:20:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 039B360123;
	Tue,  2 Jun 2026 13:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0DE1F00893;
	Tue,  2 Jun 2026 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406409;
	bh=OoiGlH/r+jJ1Fp71foigp+gKSr0VX5V5p1UlBTjIHRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TiCwRUGputNHPiFoK4yKcQ6oN01jRdmAcp3CdX792iHHCMwJMptrcP5VHqm7cYS3F
	 rQKQ703VtMw0lHjkdsmzompchUysfmmfXFPZP93HLLW2cYalI0PE2rTV97sHBOhWG9
	 EZRJ8IY44C/+b5lgu5GyO0ytqz3RvjyKaccf9hWfSpqJe5Nf2521fs3JmSGWFJScYa
	 MQzBMNAfHzf90cXhrkzpcjY6q2ZRuoadMGdFVXQozYiVc+LNfXzmur+b6tqyJ2ZAPo
	 IRMN1VeB5o5jKqBrM3pA5di0CEUPWQdeCHANQnmamGu54mg88ldiLcpfmsw/0iy2Rb
	 fmkwDmzqrIkfg==
Date: Tue, 2 Jun 2026 16:20:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Message-ID: <ah7YgntNsAoFT4v_@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-10-pratyush@kernel.org>
 <agHGOxSnP_VraH1M@kernel.org>
 <2vxzecjhc2s8.fsf@kernel.org>
 <ag-a4ru9bMkDMthO@plex>
 <2vxzse7j7ai9.fsf@kernel.org>
 <ahyDHVSH5eLsnp3C@kernel.org>
 <2vxztsrlds0d.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxztsrlds0d.fsf@kernel.org>
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

On Tue, Jun 02, 2026 at 02:52:02PM +0200, Pratyush Yadav wrote:
> On Sun, May 31 2026, Mike Rapoport wrote:
> >> >
> >> > If we want to keep the naming aligned with the existing codebase for now:
> >> > MEMBLOCK_KHO_SCRATCH      -> original scratch
> >> > MEMBLOCK_KHO_UNPRESERVED  -> for the new memory (instead of SCRATCH_EXT)
> >> 
> >> UNPRESERVED sounds good to me. I will use that for the next revision
> >> unless Mike objects.
> >  
> > Can we make it shorter? ;-)
> >
> > UNPRESERVED makes sense, although I'd love to completely remove KHO_ notion
> > and make the name reflect how it's used by memblock. I was toying with
> > PREFERRED instead of SCRATCH, but it didn't feel right enough.
> > With two of them that surely won't work :)
> 
> I don't think you really can remove KHO_ notion. These memory regions
> only make sense on a KHO boot, and won't exist otherwise. And PREFERRED
> sounds like a suggestion/priority hint, not a hard limit. "With KHO
> boot, you can _only_ use PREFERRED memory", doesn't sound right...
> 
> I think MEMBLOCK_KHO_BOOTMEM for scratch and MEMBLOCK_KHO_NOPRESERVE
> (which I think is a tiny bit better than UNPRESERVED) for scratch_ext
> are my top picks. To make it shorter, perhaps MEMBLOCK_KHO_NOPRSRV, in
> similar fashion to RSRV_KERN?

There are a couple of unrelated 'bootmem' things in the kernel, adding
another one shouldn't hurt :)

I like MEMBLOCK_KHO_BOOTMEM and MEMBLOCK_KHO_NOPRSRV the most.
 
> >> would like this series to not get muddled in the naming discussion. I
> >> will use UNPRESERVED for the new concept in v2 though.
> >
> > That might warrant v3 even if everything else is perfect :)
> 
> I can live with that. As long as we can agree on the easy part (the
> code), I don't mind doing another version for the hard part (the naming)
> ;-)

It makes sense to keep KHO_SCRATCH for now and use MEMBLOCK_KHO_NOPRSRV for
the new one to begin with. And then we can ask an LLM do the renaming.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

