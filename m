Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F47BF8924B
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1UwrSYvYD9ILrCcSxLJXG2HqJQ3UPcUaYWwodyo07Yk=; b=IMDPn+VQhCmUJdAHwFgl1OIScK
	MXEVFDoy02Cy3n0ANiEHdojzgj48eJf70avbFnIPjWQjBxVnybG+PHn9Y1n4z76MU7sdtfvx4eyDw
	GZHdzLqnlfV7LhOsBhxk8kdwsBAJ5I7BSvdRBn2Y+/LfkR/GNvSUsgXz9cuxRIBWKYZuVWhvWlaLo
	USgfVomGKfQFpPo353L5PHOX3Hd4pPRuFffLMGUlWWNePUE5GKi/BsV8IljPMQ9WW5dQcPEVBkerZ
	QnvYuRusF1UfzpqVcue+xBRgU2/Ymx/JKEgWrhaSzDdsCLpHosFYMdIFQtC4yNSfwCzPr3t8pIBki
	Dl2LPpyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Dj-00000008PfO-3eIJ;
	Tue, 21 Apr 2026 10:20:43 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Di-00000008Pf3-0HDB
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 10:20:43 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1270fc2bdf2so26355c88.0
        for <kexec@lists.infradead.org>; Tue, 21 Apr 2026 03:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776766841; cv=none;
        d=google.com; s=arc-20240605;
        b=k009VC+PgKDNDn8BYUDaXijtct9h5QnXmJighjjLURt5BD02GHRQQ7Wswx6mpUadWv
         wFw7BUeYmGftdfy4WF2gxpAty/mZXpgJsjmimCJQmAnUx0q65pW+iamaaZkrdwlg+1y0
         O9+J/SZbTgGI1YAIqEVS8N4VSF/XjU4jcYnc2pVyx8elLySTC6nOw/dBmlUHkwvi58Gs
         sNYxnaWkIOEt+QrgMzdsUVzfVSJLpa7Q5tvgNVkxwTVyN8/TKeQ+wU91Wh4B2awtbCrX
         6AmIEfWFvkDnYkW7Sf8JVmOenyS37mbTP+H89DJcdctl27fKjUKhLx0ZX6lxPvmdm0c8
         gBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1UwrSYvYD9ILrCcSxLJXG2HqJQ3UPcUaYWwodyo07Yk=;
        fh=RP4W0O5j3LhcdJeDzD8dSI8DLB8dzqKLNrXHN0Vywgk=;
        b=HBSKut8jLSAQ4ocT8Azxl5NyKyudkXf50jPrX1J4cjfaaT17MjHybiykFztVcaIihW
         9oHTQOpg2SY5O9iVYvjKMRFPXE5GJYYfSzkakHqOQAi4JieYkZvZcdQUjJBmlQMYSYPR
         wtB01Bk0dwu4GDn3cNxRSPlDoHFVxloMyfKFLkFrC5n7tIZpD+JZN92nA6C3CN+0ZFlu
         ElzIue9W5cydwR4QLs+3LNSI7qAEeUBLvgBKlWow7W2P0ooX63w5lGblwnB/8SUBk4eX
         453lvrYn7A+QsK8k99GeLF4jnplPxB1G7cyGr8daTtVanIRLIX+3N/NYhEKEr2hSPN3w
         rpyg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776766841; x=1777371641; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UwrSYvYD9ILrCcSxLJXG2HqJQ3UPcUaYWwodyo07Yk=;
        b=Dk6pGEBKn+QjUfxzSKJ93vl9f3h4BzWRi0dzcsDsnPMMzrT7QmubFg22zTOGUQ2b9D
         3cPAUpYc5OUK7+43ugTLAO7kdXTO/9p2V4bqEQNJY1xO+NYwfgRol7J2iq2/V2iq/P19
         L6FLMWadPGmWQuGPrwYDa6pk2zOHi3ZeulJ1MUMrqfbNNcU607R2JvEQ2J7/k7QJPLAw
         vQ/6i4taWulthyrIBdH+XgLL+rmCAnqYSF1Mxzx2MjLJ8T+kkK7PUK7aqjs6NpQ4jWne
         QclMxUz01oUWZ1e7cob0OEAVYuzpPfhDvI9MZCJ904A/chIB6t3nKgvpiNW/idX4vG/t
         R+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766841; x=1777371641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UwrSYvYD9ILrCcSxLJXG2HqJQ3UPcUaYWwodyo07Yk=;
        b=OUWjXdwLbk3OCNBOEoisRh4cq9VPmPquMIaO1pyvgPEXRbNYTBiVxwQWgaUfxAFMs0
         LUginzwlgLY8GDVTjpIw3H4YAeIgApoPFi+l/fvh5y907XwD50QvM4UVxr7c3HHjTZ5R
         ng2ZG+1JrVGVlGZWFVzTD4c0LNGOqzrmCR4iPvEl6R6qaE/S0wZgbLZBOoVc0hS/JQ1g
         hM+2cHyFupTLFfyDOMozeCekxG7f6rjHX6aPf+dZtPQ1ownqrbSKEyPgDqrHErhKdPzx
         8k05qopWoWIHj/f8QAQHSWa5mb3EdUNW6UrR1YP2VZJ90NdoQKpsmcKS+3qi6uU0UkOa
         jd5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Pm2zemgww2QQDbQ3zxD7/awK/39iqQ8xRU38BlH1UV2/e8aD4Cfr9hlOEHXuC/ZY/EA3OYQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwUqyHu1LRL+06DQykG0xyOkio0ZZkbieD7NTP51f7QjYWMca4p
	a3dNCv1UTPWYRti3HsypNAj8na46ctz0nXwC9uWZzIOeOekiMxBsNiriySzhX6uVXXNOv9Gx2WJ
	4k+RrrjG/FuKZr9Fwk/JdN66YLgvt2MKlRTzziRg/
X-Gm-Gg: AeBDievfnS2UXj5AaxwxfjKuZQtXZxSUTa1Y0wC+z9WVQPRdobobU44aswEsUi9G6p1
	UaIOGhCD7O0MtSNiW3EIi4Xy5J0Rr7DUpeKMUy0Bi0oxUI3PPnjaULe7vxJ7Vk9N8tRoi2u8vvk
	YWOrem9fEJwMFmdb1mjqBANv35NYI3Er3XwcFDzNHmhYaSRk2GAL1UNgZGo0eXpP8lfwZ7i+DG4
	53UILZ7yFqv0l+FkJW5Wabpme++aXN1NceNPS4WtINDiCeaYbGbhmwiUSMMXmilj5HLL9kJsMNx
	zz7J7q9JSjVBE3xfDqmqomdz9aI=
X-Received: by 2002:a05:7022:e1a:b0:12c:8f55:cd0d with SMTP id
 a92af1059eb24-12c8f55d347mr302206c88.8.1776766840115; Tue, 21 Apr 2026
 03:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260416110654.247398-1-mclapinski@google.com>
 <20260416110654.247398-2-mclapinski@google.com> <aeD2Fzr6yr4pu9-X@kernel.org>
 <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
 <aeEKksfLxQ0A7Jun@kernel.org> <CAAi7L5cp3B0DFEQex5EqFdLDkqVWwRw228-pgp0PnhfgLP=e6Q@mail.gmail.com>
 <aecUW-Xgm5MPMyVr@kernel.org>
In-Reply-To: <aecUW-Xgm5MPMyVr@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Tue, 21 Apr 2026 12:20:27 +0200
X-Gm-Features: AQROBzDs3jAHPn3oOPv3D-suXf1b7CCQl5aO-frumb4b7YD1JXID7aO_RKQeeO4
Message-ID: <CAAi7L5d8x1MB1f6A_h2acj1CYU1wf7DijS1TENC+Lurx5wLhKw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kho: fix deferred initialization of scratch areas
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_032042_152414_93A16E25 
X-CRM114-Status: GOOD (  22.21  )
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

On Tue, Apr 21, 2026 at 8:08=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Apr 20, 2026 at 03:11:03PM +0200, Micha=C5=82 C=C5=82api=C5=84ski=
 wrote:
> > On Thu, Apr 16, 2026 at 6:13=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Thu, Apr 16, 2026 at 05:06:10PM +0200, Micha=C5=82 C=C5=82api=C5=
=84ski wrote:
> > > > On Thu, Apr 16, 2026 at 4:45=E2=80=AFPM Mike Rapoport <rppt@kernel.=
org> wrote:
> > > > >
> > > > > Hi Michal,
> > > > >
> > > > > On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wrote:
> > > > > > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_=
range(phys_addr_t start,
> > > > > >                * access it yet.
> > > > > >                */
> > > > > >               __SetPageReserved(page);
> > > > > > +
> > > > > > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> > > > >
> > > > > No need for #ifdef here, there's a stub returning false for
> > > > > CONFIG_MEMBLOCK_KHO_SCRATCH=3Dn case.
> > > >
> > > > In all 3 places the #ifdef is there because MIGRATE_CMA might be
> > > > undefined. I already broke mm-new branch in the past because of tha=
t.
> > >
> > > Hmm, that hurts :/
> > >
> > > The best I can think of is to add a static inline in memblock.h and i=
fdefs
> > > around it.
> >
> > Sorry, I don't understand what you mean. What would that static inline =
contain?
>
> Something like this:
>
> #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
>                                                        enum migratetype m=
t)
> {
>         if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
>                 return MIGRATE_CMA
>         return mt;
> }
> #else
> static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
>                                                        enum migratetype m=
t)
> {
>         return mt;
> }
> #endif

How would I use it for this code?

+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
+                 pageblock_aligned(pfn))
+                     init_pageblock_migratetype(page, MIGRATE_CMA, false);
+#endif

It doesn't invoke init_pageblock_migratetype unless pfn is kho scratch.

> Can't say I'm happy about the name, but could not think of something
> better.
>
> > > > > > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn))=
 &&
> > > > > > +                 pageblock_aligned(pfn))
> > > > > > +                     init_pageblock_migratetype(page, MIGRATE_=
CMA, false);
> > > > > > +#endif
> > > > > >       }
> > > > > >  }
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.

