Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF16CAC59A
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8ChdVFL3VbJv1RwXe37ElFR0o5xJ4LIb9+Ne1LI908=; b=ZaD17qDKZDziRxismFJRh7LoXC
	f8uXW3kBDi36HJzpXNHXXqWB3y08YmT78X1m/0VxguU2ZrShMlSWFSOxZMfax5PznKtqBlQtD3z3W
	NiYj5CjlGFOCIvIiQ76FxDIur0qpOs5pQMRb/UkNexUyntApriy/84FkFfojcmcz9uyVLCSLOstT+
	z89z0oXfxuCHpmsnQL7MUZ7ZjnTy5WYWkCzCSj2/x60sgjUbN03YiWZaLS9hO2A86TgfVLv+hIrk4
	tq6yGMdArhxWo6h1JY4Wju+2FXK4/AQqYbTHOYjASxLyGq0pLHeFkeONAaaImxSyLWw1k/Cq8dWjC
	DYHB5wKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzUvr-00000001y0W-1rsM;
	Fri, 19 Sep 2025 06:49:23 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzUvo-00000001xzO-3FsE
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 06:49:21 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-544ad727e87so1351500e0c.2
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758264559; x=1758869359; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8ChdVFL3VbJv1RwXe37ElFR0o5xJ4LIb9+Ne1LI908=;
        b=Ovhn8TMYRenn8AsnrZJi8ilxuJ9ovnxg5hfpKzJiOvkjLZklS7TXJWwEiJDwUFSlQ8
         l5wjDBQ57kSXzMoCNRWam9pbTVjgljHDXa/aGtk9o7lcnfOkmNhCowIzNxZXced0ssmD
         /j29tcZkNlcWpLn/LGfmKDCcZMQ0KHlln5r0nSaEcDlDFvKMzRvUGMtHjfaxuIMoKnct
         aqqymv5oKX1DGjgO9c2iC4S2Nqck8/JlsYI9lHLfngNHn39x7mUs8jO3o/aNExZ3uFds
         CiObTwT4L4Zod5uH8H3El1Hva2KR98URMiqxex+WBVbLWHlCYjLs9a17SPPYsSZhV4/9
         Ew9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264559; x=1758869359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8ChdVFL3VbJv1RwXe37ElFR0o5xJ4LIb9+Ne1LI908=;
        b=MTSM6rD+61O4MVNz46eyFRS546akQ89jHZ7DiLvUrhr2encjm8KT5aLwErRhPIaAlb
         0HSYo4QBUG2c1/iljcEIaHv0QZTAZrUK1wqeK5IXNnLOOTfYfmQQT4aTYWLt55OUJQE3
         R0d+4QLeEQh8/ihbdZFtbtO7g03w5mZTw346s4HlwZEtYthaOfwGLLOFRrH/2OR4t1PA
         b9KRZMygVqKsUjo4M5DszVK7nUH3js31I4WeSRJbeVOEGnNBLEmppXVnPwVxabeP705X
         0QMDYP8i90SzeLwustEJ4upx1wAN8rQ4rY9x6TzAJihk1cDNsrV58AB8J+5HpV8BwCq4
         ycQw==
X-Forwarded-Encrypted: i=1; AJvYcCWleyMwPJ0nC1pZ14/NMovptzZf2uRnAbMW4wPW8GuncGUTnfzfLAfUdpbrZvJeWT6jSkbIZw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/x22/bCxjY/+lRQcFpmyz837/Xtf52NrtQ/4SsbpHfJ6RbsP4
	G72OWULjH38iSWYFG/HYdN8Daz5BNLUY0hXMN1FrBt0toF3sO2LGRLbLtzEvKnaXHbxyc4xL2y6
	Yoqd9dJ+3li7R84AueWpfRP6ZPPlN/uZonsej1iId
X-Gm-Gg: ASbGncvxQtDRX76Vkgqpn9iwbXHuf4aO9Lvv/Nul0HEv/1eYg9qjJydF4VZElsou2Yd
	HZiPSjh53JJmzppRI7F80upY9aNbdNsvAjJge0CY/muvwe3vYkK354hCIe4e5xadBvrNVsA0Hv1
	GcbColmaqFpE69e+8KvjqtiXAd8QOHjqIDGO1U2+7jxs4lp1RpWPpidHkLaz0uyhW2QKbK8SOfH
	dQweHnEQScLcqbIZhnqi7VlazEQyFtZ5EosU7iTuUzoMkGF
X-Google-Smtp-Source: AGHT+IFVsk862c6jBLBQHlKlwevYkZVfUWmmFw+NQU42kXUhgZ2xtmh0tS9iCTXHJ7q0fDyvegsZslZdHcK2rLPpIvA=
X-Received: by 2002:a05:6122:2a05:b0:530:5308:42ec with SMTP id
 71dfb90a1353d-54a837e6887mr813853e0c.8.1758264558514; Thu, 18 Sep 2025
 23:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917025019.1585041-2-jasonmiu@google.com>
 <20250917122158.GC1086830@nvidia.com> <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
 <20250917163200.GC1391379@nvidia.com>
In-Reply-To: <20250917163200.GC1391379@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Thu, 18 Sep 2025 23:49:06 -0700
X-Gm-Features: AS18NWCRC_XaURHfJJfME-M0Ey0ObAUOEvcdAIB2Bzvin5AUuRN7ltMM3UG48RQ
Message-ID: <CAHN2nPK+Z5cvQ_waTWyPZiEoeSc9o7e3YnQLLjRzNzrb7VhAqQ@mail.gmail.com>
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_234920_845138_8A9BE176 
X-CRM114-Status: GOOD (  25.05  )
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

Hi Jason,

On Wed, Sep 17, 2025 at 9:32=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Sep 17, 2025 at 12:18:39PM -0400, Pasha Tatashin wrote:
> > On Wed, Sep 17, 2025 at 8:22=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 07:50:16PM -0700, Jason Miu wrote:
> > > > + * kho_order_table
> > > > + * +-------------------------------+--------------------+
> > > > + * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
> > > > + * ++------------------------------+--------------------+
> > > > + *  |
> > > > + *  |
> > > > + *  v
> > > > + * ++------+
> > > > + * |  Lv6  | kho_page_table
> > > > + * ++------+
> > >
> > > I seem to remember suggesting this could be simplified without the
> > > special case 7h level table table for order.
> > >
> > > Encode the phys address as:
> > >
> > > (order << 51) | (phys >> (PAGE_SHIFT + order))
> >
> > Why 51 and not 52, this limits to 63bit address space, is it not?
>
> Yeah, might have got the math off
>
> > I like the idea, but I'm trying to find the benefits compared to the
> > current per-order tree approach.
>
> It is probably about half the code compared to what I see here because
> everything is agressively simplified.

Thank you very much for providing feedback to me, and I think this is
a very smart idea.

> > 3. It slightly complicates the logic in the new kernel. Instead of
> > simply iterating a known tree for a specific order, the boot-time
> > walker would need to reconstruct the per-order subtrees, and walk
> > them.
>
> The core walker just runs over a range, it is easy to compute the
> range.

I believe the "range" here refers to the specific portion of the tree
relevant to the `target_order` being restored, while the
`target_order` is the variable from 0 to MAX_PAGE_ORDER to be used in
the tree walk in the new kernel.

My current understanding of the walker for a given `target_order`:

  1. Find the `start_level` from the `target_order`. (for example,
target_order =3D 10, start_level =3D 4)
  2. The path from the root down to the level above `start_level` is
fixed (index 0 at each of these levels).
  3. At `start_level`, the index is also fixed, by (1 << (63 -
PAGE_SHIFT - order)) in a 9 bit slice.
  4. Then, for all levels *below* `order_level`, the walker iterates
through all 512 table entries, until the bitmap level.

so the "range" is the subtrees under the start_level, is my
understanding correct?

--
Jason Miu

