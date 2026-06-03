Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C33CD6E60
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYzLxXCyFp78st9iZvxHkpqPKyf62haaChBN9xQvBYM=; b=3JKjQDGswXPrmaN3meuR33KPEq
	tQU1lxmwIxcufer2c2mUoyI4Ysuy/wyx1wVP2T8V30PMDxmZ1aGuHR+7m4NXm9ah6RUWD63UNw81c
	rwpCKdSJ+oL5+P9degN38DjcoLqxsrBJqNG3dlAiy6fsToTREo/O63clIPduBWG4tlWgLEiHDt1Oh
	Ss7MbnoAz0QSl17LpUs9UbRP4tVsrPNkDnqutt4rcC85eNZJqm2cPbNAygjfsbenXr117kXBnD7ef
	65WQ4WOIbY2ClZfXxHtJCJGxCvyBIcdvE755xHccjlLiKxZOzkU5L3z58r62bkmTvD4K1V5cEzIZz
	TZMZ7kmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUlXG-0000000FAYJ-0dc3;
	Wed, 03 Jun 2026 13:21:30 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUlXE-0000000FAWj-0AaH
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 13:21:29 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-914bfa75911so77487885a.1
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780492887; x=1781097687; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYzLxXCyFp78st9iZvxHkpqPKyf62haaChBN9xQvBYM=;
        b=QqMp/yoUkqSh43iAOSb1TZ7x0RulN3udgB4i+DH/lOQnTUTcz7PZbPXVsAJY8eY/rR
         7SePKgBrvUrjmPLpJSYdrtrN/71obXgbL7AbWgr9H/rGNDjF8KnlD22+k0l7OB5T4V0w
         kPTCBGj8SzDJA6qHc1FvMrwcUFC/HcIFUj4647asndkkbpujbuC1ElTlkeNb4jYrOpe2
         h0mmrtRtuxplg0I3G/g7UzNnNlCVFDAN39/wfhTNj2YxPMOpR4J+15CPhlUPumk5HA9x
         hV5sW8QqUn52dxYyG2uG3SBSHR+0XlUklmGFhkBQWqY7yG3zLDeg8M/uHcmloy6xqG6o
         cLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492887; x=1781097687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYzLxXCyFp78st9iZvxHkpqPKyf62haaChBN9xQvBYM=;
        b=TsIXfWFJOIQ4cQ3bFq7O7KNCnl3uDfLdv6ioCzn5D/nr1nik7BJvFUBepylGskvUkI
         bog7WKfG1L/OXmh5q+9uyheY+gn8bVUjOe56N5WrDgDO5X/oaFGHetbKN8tjVL0vFmTS
         Yj2cxPGOvLkXmEM0M7nnA1+uquZ1AliAIyzitjKZeMARTVnWZBa9cMEdLkS6ZaCJQPz8
         aL3Gy649J94zL3M7URgtBj/MDyYzkriMFQiTFFUTzcIVsSmG2eH7qTg7HoQ7t5gwGe9v
         Gs8qpim1HkIJgrf9sd8KAHSMbsxZcIAini4XZ762OzRAdnVTl2eRLBRe7tRT3ECQRnr1
         ZB+A==
X-Forwarded-Encrypted: i=1; AFNElJ8SrTG4txOmIEkZx/+4Pd6bZ18oCXzOA5O3LWxDm2vb3WhSU8tGaKSUZ3WhsyrxiGihBhzH7Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyAHqAXIG+/M5L9tIhCPGLiKv1605FmmNnw4TximQgxaqxqr18A
	zh1AYqpgqaPTiaJ1j9LTP0t+AMDSVHHkRWO0ddE8nWxsBxrGRpLxlf22l2yNZWIfO2E=
X-Gm-Gg: Acq92OEpfy6VV1RxY1pWqTjSfOB7xytRYPi6nhPEhS0HaH/5ufJT/x/ex/0jy0b7CJZ
	mJz8slVICjvPGVrF1uPRr38hMJClOyt+2tn280RccSWh1Dj50KOtGdA3/lFoh7aQCwkwoappYu7
	mCx2JPzzgn9wITUJM4xYc566ZYlcJTFMcwRYb0hWJqZFUvpL45HcJNB1Hk+soqw6LcdP1Gi04DV
	+SNNFhz3Dsxv3J98Fyw0LXCdT9hwWH458bYafPYPzHJ8as0JIY1SUghkB4D5LuJ/vX/nkJnbwlf
	ZzRn/MT95XNTHbHdJ7+m6vXI4rK5hY1lPPKFShRSFjlocfCWjIaJ/sm8by7Yrr4DAjihRiiTFsh
	2UOef2zv6RdDwAYVWw8PZPtywZuQnW62cJvunDwQo3pqd3uTcsfpIt7TYhI5DjVezYQVxkAdIIA
	6NdD1iwbp3yWAbdWlu9K1fqOP6jAoB0MbPEY0tUwkO0E94iqOmRpcGM2RM64n1VA==
X-Received: by 2002:a05:620a:414a:b0:8ef:6b87:5c52 with SMTP id af79cd13be357-9158b76c157mr410625285a.38.1780492886503;
        Wed, 03 Jun 2026 06:21:26 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cae4sm240219185a.29.2026.06.03.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:21:26 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:21:24 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block serialization
Message-ID: <aiAqOaA_J4PrIoow@plex>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
 <178046937151.468621.13398573538792303093.b4-review@b4>
 <aiANtYRRDr5iO5QR@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiANtYRRDr5iO5QR@plex>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_062128_092239_912FE32C 
X-CRM114-Status: GOOD (  35.51  )
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

On 06-03 12:05, Pasha Tatashin wrote:
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
> 
> For now, reviewers will have to make sure that if the ABI header content 
> is changed, the compatibility string is updated.
> 
> > > diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> > > new file mode 100644
> > > index 000000000000..4f147c308e6b
> > > --- /dev/null
> > > +++ b/kernel/liveupdate/kho_block.c
> > > @@ -0,0 +1,411 @@
> > > [ ... skip 121 lines ... ]
> > > +/**
> > > + * kho_block_set_grow - Expand the block set to accommodate the target count.
> > > + * @bs:    The block set.
> > > + * @count: The target number of valid entries to accommodate.
> > > + *
> > > + * Acts as a runtime notifier when new resources (such as files or sessions)
> > 
> > Not sure I understand what "runtime notifier" means in this context.
> 
> It came from discussion with Pratyush, but I think we are on the same 
> page what they are, and I will just remove this.
> 
> > 
> > > [ ... skip 11 lines ... ]
> > > +
> > > +	while (count > bs->nblocks * bs->count_per_block) {
> > > +		int err = kho_block_set_grow_one(bs);
> > > +
> > > +		if (err)
> > > +			return err;
> > 
> > This leaks memory if more than one block is added.
> > 
> > > [ ... skip 31 lines ... ]
> > > + * unregistered, allowing the block set to release and unallocate redundant
> > > + * preserved memory blocks. Checks if the last block in the set can be removed
> > > + * because the remaining entry count is fully accommodated by the preceding blocks.
> > > + *
> > > + * Note: It is the caller's responsibility to ensure that entries are removed
> > > + * in LIFO (last-in, first-out) order (the reverse order of their insertion).
> > 
> > I think "in LIFO order" is sufficient :)
> 
> Oh, I keep removing those :-)
> 
> > > [ ... skip 173 lines ... ]
> > > +		it->i = 0;
> > > +	}
> > > +
> > > +	entry = kho_block_entry(it, it->i++);
> > > +	it->block->ser->count = it->i;
> > > +	return entry;
> > 
> > This looks way better than the previous version :)
> > Thanks!
> 
> Thank you. I will send a new version of this patch as a reply to this 
> email to avoid cluttering the mailing list.

The patch is here:
https://lore.kernel.org/all/20260603130612.397948-1-pasha.tatashin@soleen.com/

I messed up in-reply-to field with wrong message-id.

Pasha

> 
> Pasha
> 
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 

