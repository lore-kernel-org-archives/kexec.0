Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3D7CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1X7rdmAsUUmk8fm1lXinqRbOJ2Rb1qcFGzfHrd7zSSw=; b=Sav3q/F2F0g6XtJ0d2yxa19OnV
	wFpoly6gXgJPTBq73yXf3h9rbawc8oBwkfY/4jBr2VGNK/xsj2p1P3sPIlgCzal6XykeNeTtXl3eW
	W+0wItCVMR0eFBv+4ay0Y8+x5PQcgVI+Kie4uhxT5tdw+7jDiAu/LHQYvWC7SxJK1JrBeEr+JxwkS
	/h7aTHwqEJUxyMZOpU771eKeT3Tt7Pl51K8kmUww52b6mkvpMOd1TjSThI7HA+paSELaqbkcmRUHw
	12SIKniKeMLWwNdD7RQDR6ITOgg/E6YDzQ2WUPZd25d10oDV2Uo3ai4n6CV16pCV/qcfoEW5Io8iJ
	J6kt6pow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUkLO-0000000F1ps-0B97;
	Wed, 03 Jun 2026 12:05:10 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUkLL-0000000F1p5-2m9t
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 12:05:08 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so59946706d6.1
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780488306; x=1781093106; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1X7rdmAsUUmk8fm1lXinqRbOJ2Rb1qcFGzfHrd7zSSw=;
        b=B9W49MikCoRiZ7rMzX3IDTTlG5VEHS21XMCQV08SBphJ/0o9Y5W/abBaaaxCCJZYom
         1n+qTIRwQ12D0qnu53D6+VxT65z39Z872kvXZ+aFfrFFwioM43DsOlkEd4Oksbs8TIIf
         4520DnMfUQLtNs3l0jiPACKDmIRK6BsDdy34BdyUY2uzO87WJGe19ZW/ZQKS0SeT1VV2
         Q5aYH9UpdQrcbmfwkp5uLfJsXBswWwxbcK50vEdswvx58OXLT4BZEQDzOBb3o/XFJFX0
         6rhiC8iW8AkeZaCWDrT3iJFtLY58q4V76q3VOVSy9c5GPP6VTtDpEvIUYcoUHddAfnHH
         Y1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780488306; x=1781093106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X7rdmAsUUmk8fm1lXinqRbOJ2Rb1qcFGzfHrd7zSSw=;
        b=CsgcF40W4uGpx3biBkCpI+JLzc5m1DdYSI7IlfDBjBXMYgZHCYtc9ps5DRZC1EmWxI
         OCTpjHVe3TLHlKon9vNwclzEggJvORzN2v39hbXkwZz9q+ufrGy69Z61Kg8M4qgaRWCE
         QJVDEU8CuLjMkJ2Q+4tNpk62zSZ7pRTvHjCt/tTZuZzw1+C64OvzHwXTkGoZVjey1Bm9
         y8fMx7R3YZuBV7vSIJcLaBEaXvdBsFLDWxCkVsgVB6sUGKi0WLx32GXYWcTqD61R6Fz1
         ATuTX61WzJa/ljzYFNOkhTbTRaX3mD9qK8OEJsqbXksYEqaikCPiVzDJFHR7vDU5a/cM
         bcRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yPLGvktm7wQGBbEkcc4tHdICbev9VW5gwZzQxR6o0Jk9wxHFsohjZnH3XlFFljYgPf4e96g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/VhQInC36BkzFz+gSsFo9O/tadEI2LwXFyGBt+Md++oLDz1he
	p4QcAvDTxeOL87/He0mGsRcCBsoi4PSOmlSo2V09d3/6LpHnnLBjJwuOTc+pFTh2nlU=
X-Gm-Gg: Acq92OHKqIarlfLoKm0UpPfL9xfNe8doWe6KosXA6Ui25yWzv/5IMtrBlqCiqUUkH2X
	kkOw+dtjC0TitbKPQe105v0XFt+tD5ODIzbcvbjGzsMgO2cxlBdfA4xY+9sIBmE9Egsz7kIRpJw
	lkedW/x0TGc518HHfnmKnBK17wcAoOeCx/NzE/qY5uMfEqF2x+p2JdhFDDGNigl7HDvNjMCMe/p
	xW6lwNW7B8cFF71BmxApofCEDqyIZsTTASFU4+L1pvnA7yJ//wfkp6s9pdjqcOZU+KI9tCgNFe9
	IkkK8tAeFrVhoGGuv9gQfZ17THQlTgba5Y30PQz3IExw2b/xdnT8sMJKtVVfI3M+0BD7V1VEszi
	A9kkbokbwHerb/ExxZzJ8eKvlBW11occYrAICyBUsFE8XF5zIB/8m2HRmAWzpVW0B5axgaGea8M
	WGl+hgInUK+r7KhILStlPvMakpH782Em2DU8pjHDIvwoybxQ1fdPPUrOZ88mWgKA==
X-Received: by 2002:ad4:5851:0:b0:8cc:f012:f42c with SMTP id 6a1803df08f44-8cecdc09461mr34569126d6.6.1780488306396;
        Wed, 03 Jun 2026 05:05:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2682f8sm18054716d6.43.2026.06.03.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:05:05 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:05:04 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block serialization
Message-ID: <aiANtYRRDr5iO5QR@plex>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
 <178046937151.468621.13398573538792303093.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178046937151.468621.13398573538792303093.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_050507_711752_BE6F5CA0 
X-CRM114-Status: GOOD (  29.82  )
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

On 06-03 09:49, Mike Rapoport wrote:
> On Wed, 03 Jun 2026 03:28:58 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> > new file mode 100644
> > index 000000000000..8641c20b379b
> > --- /dev/null
> > +++ b/include/linux/kho/abi/block.h
> > @@ -0,0 +1,56 @@
> > [ ... skip 25 lines ... ]
> > +#define _LINUX_KHO_ABI_BLOCK_H
> > +
> > +#include <asm/page.h>
> > +#include <linux/types.h>
> > +
> > +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
> 
> It's never used by block set and after looking at the following patches I
> found that it's appended to LUO compatible string.
> 
> While this works for LUO, I think it should be kho_block_set_restore()
> responsibility to verify the compatibility.

It should work for any component that relies on  kho_block. My proposal 
is to use this method for other common KHO data structures (e.g.,  kho 
vmalloc,  kho radix, future kho xarray). There is no need for them to 
carry the compatibility string in their metadata, as whoever uses them 
will include their compatibility string.

For now, reviewers will have to make sure that if the ABI header content 
is changed, the compatibility string is updated.

> > diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> > new file mode 100644
> > index 000000000000..4f147c308e6b
> > --- /dev/null
> > +++ b/kernel/liveupdate/kho_block.c
> > @@ -0,0 +1,411 @@
> > [ ... skip 121 lines ... ]
> > +/**
> > + * kho_block_set_grow - Expand the block set to accommodate the target count.
> > + * @bs:    The block set.
> > + * @count: The target number of valid entries to accommodate.
> > + *
> > + * Acts as a runtime notifier when new resources (such as files or sessions)
> 
> Not sure I understand what "runtime notifier" means in this context.

It came from discussion with Pratyush, but I think we are on the same 
page what they are, and I will just remove this.

> 
> > [ ... skip 11 lines ... ]
> > +
> > +	while (count > bs->nblocks * bs->count_per_block) {
> > +		int err = kho_block_set_grow_one(bs);
> > +
> > +		if (err)
> > +			return err;
> 
> This leaks memory if more than one block is added.
> 
> > [ ... skip 31 lines ... ]
> > + * unregistered, allowing the block set to release and unallocate redundant
> > + * preserved memory blocks. Checks if the last block in the set can be removed
> > + * because the remaining entry count is fully accommodated by the preceding blocks.
> > + *
> > + * Note: It is the caller's responsibility to ensure that entries are removed
> > + * in LIFO (last-in, first-out) order (the reverse order of their insertion).
> 
> I think "in LIFO order" is sufficient :)

Oh, I keep removing those :-)

> > [ ... skip 173 lines ... ]
> > +		it->i = 0;
> > +	}
> > +
> > +	entry = kho_block_entry(it, it->i++);
> > +	it->block->ser->count = it->i;
> > +	return entry;
> 
> This looks way better than the previous version :)
> Thanks!

Thank you. I will send a new version of this patch as a reply to this 
email to avoid cluttering the mailing list.

Pasha

> 
> -- 
> Sincerely yours,
> Mike.
> 

