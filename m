Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7423CCAC592
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9zR1ns6r4tli6kgpMkZXeVyHg9onE4yZmroH/q5x2E=; b=MWrMRugCtIXREusm/HraF/WUDP
	G5FTTzb345UjKOspx3vkkrwuWVjGRi9HAs0gVjPvWDnpoRvl/jamuCJlmwuzng4n1OjVXNLU58l5i
	QkzmhRh6IDaiTpx0RBGe15sisnFoEg2iaUQwnEKXisyGi4JwSitzfjDJX01VxS/VOzPrZ6ui9JqzA
	mY0qABH/mCXNVTOnYuRZpWyqGPVfHVocZOtUPgXtGrjTtwkvRAUaD4fidwJSi8iDTh7+KUDWIayG/
	a7CvYferb1wwl4sNCzEyYty9CNaFspDiUPi/eco24DGBquZy0oB+xU5ccuJIAqTOmapCOUbfv4OeK
	E7SE2u+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybye-00000008xVU-02nT;
	Tue, 16 Sep 2025 20:08:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1RY-00000008cG7-2owz
	for kexec@bombadil.infradead.org;
	Tue, 09 Sep 2025 16:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=X9zR1ns6r4tli6kgpMkZXeVyHg9onE4yZmroH/q5x2E=; b=DopfrGjAjNEkP9WpW8dFhIOPlZ
	BmkGE6CU/Pza/xSKQjU8t5sc3qFZDgAqVhulS2InvHBC/SDzKwR4YSTORLtgy8nzc94Ca+94fyRXi
	v78sHS+3rQtSscjc5f066EEtOPr3kCDZPFnSTDOvfyRzy9S85ocEkTkCWXqNMdDDnLBqk8K9aAmFr
	TqcCBHjUTJGHg6AkUafDIyxKYGlXgQlcUvfS6NcZGb4KgyO6DdrUH5snQuyEOce4Oq/Az9G3h8Mfk
	3Vf36VsmtQv9rKzQKQ9roEjA/CK2CdaRqhBxEpbTU48STC8AhStJ+/cmHrAUUjJpzBog6PnBQLGqe
	2r/9oRNg==;
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1RV-00000005RPH-2RBu
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 16:43:43 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so228a12.0
        for <kexec@lists.infradead.org>; Tue, 09 Sep 2025 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757436219; x=1758041019; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9zR1ns6r4tli6kgpMkZXeVyHg9onE4yZmroH/q5x2E=;
        b=HdefQSJ+qLExu8gnfoLNDjZ4TlEME7fcTur+E5+1fDh8cvNQGTGq3Y/JLO/pFc0GkF
         Sv6nIRRIm3LO7lz0XjwhEJqwvPtpodH0o9HPyvUhmDUqJbxNoPcC54WkXH38fpMtvxk1
         5iy9zWB7LwPyuK3EcBwbdj8YE767G/oOVeswKYMtwG7Pdz2XKbOZIWD+C+hyBaWlMu1L
         gu9vHkUe3GjuwQ2hypkn3rhxRNWDfrQUF5xNKXZJQPbemTVRqpyPl98vZwhA8jfc2ByE
         jIEC/sis80vnziEjBfLbD7WB6J4Sc2wnJ1dMa9LvsLW840rKceX+efIXvLRtFqPmb53h
         OgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436219; x=1758041019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9zR1ns6r4tli6kgpMkZXeVyHg9onE4yZmroH/q5x2E=;
        b=oq4HeqcNKeeOH1P+uXafOZwwZJMbEhJTAHdJd9JKLBdSLyG3k3opNIP4ckascgOUJ2
         F30JGEUXTR4ogbOozCo3G0FosaDAlegNTf6iE4JfIEfJs58xtZYwQyn6UI5AAM8j1KzX
         mBZfg0oBuPL1ZoLlVl4Ygh1xkoDapzgwuQa8+YAJMw8XRjxbvcqkOPznKfjdjW1oKPj8
         Q3IENQfPp10KlOgfm/CqVyjZys9E3otr0kO0I3DXyopLNspFPRvO5yXpevqcXwldRcvz
         66Bfj8knIK80oSI+IBF814JNKVfT+rV2fhqb2MDcxubQy50ByYBd7sDHtsjxfiVtWWzD
         GFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8uRG1e0JXjzXEJSHlbEBRQhKhT4qzyR5V5rG0ufr+JSp7Hwm0TAtWt3NvBynhs9chSdnldw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwIzJRw8Esvk/619i/TisPiahkWhlZUy71XRkKR+LJbPcKpPBWz
	3kV0H2yr0DFrZS8HOfT640Ssl0bUzWkGUtZJ5YQZAH31/oPo2k2tXG4GXy+yglY21up8pvNZLyX
	7pePL+93u8A7uIhC1CLPFjLDIISijRjY9zwJSZprI
X-Gm-Gg: ASbGncsQDq4vV3k7OAMy1yaQ19Al0ad8OYFsuCzwyCOdPKolcrEj703DSfgQ1Nq1TKf
	dpTQrqRfQ0X3H1V4oc4qAnTExRQmJRceBmQoalCCJxMJe/kGJXlWCkt3oG7AxiKhwtyo3qIwzTT
	ftcWgswyn+zHIL+E5G41uZM8c61St1WR3GxW3ahJcGoRP+fhJd3jFCU2Hf6X4v6YNmliKQXQ3UP
	oSxGcJaEASkFV90lSllRYmpAMVo9jRT1H58oPvDonU4y/WAh1Orqe4=
X-Google-Smtp-Source: AGHT+IELrtj08JXZeKFczydeIaWz+ZDdGREnJhxstnY5vYYsKxfzgQANvCdFJ1mjoGgstj0WHnOScZjfoo2Pzh65Zfk=
X-Received: by 2002:a05:6402:4024:b0:61c:c9e3:18f9 with SMTP id
 4fb4d7f45d1cf-623d2c4dda5mr356673a12.3.1757436218862; Tue, 09 Sep 2025
 09:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
 <ad69e837-b5c7-4e2d-a268-c63c9b4095cf@redhat.com> <c04357f9-795e-4a5d-b762-f140e3d413d8@lucifer.local>
 <e882bb41-f112-4ec3-a611-0b7fcf51d105@redhat.com> <8994a0f1-1217-49e6-a0db-54ddb5ab8830@lucifer.local>
In-Reply-To: <8994a0f1-1217-49e6-a0db-54ddb5ab8830@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:43:25 -0700
X-Gm-Features: AS18NWB56jIrhZDM4c-qSVZLOkH6X6dA_iJA_IjgEAuDFh14nG2Q8lK0Ov1ujjQ
Message-ID: <CAJuCfpEeUkta7UfN2qzSxHuohHnm7qXe=rEzVjfynhmn2WF0fA@mail.gmail.com>
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort hooks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org, ntfs3@lists.linux.dev, kexec@lists.infradead.org, 
	kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_174341_800605_D131CCA0 
X-CRM114-Status: GOOD (  33.17  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:58 -0700
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

On Tue, Sep 9, 2025 at 2:37=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Sep 09, 2025 at 11:26:21AM +0200, David Hildenbrand wrote:
> > > >
> > > > In particular, the mmap_complete() looks like another candidate for=
 letting
> > > > a driver just go crazy on the vma? :)
> > >
> > > Well there's only so much we can do. In an ideal world we'd treat VMA=
s as
> > > entirely internal data structures and pass some sort of opaque thing =
around, but
> > > we have to keep things real here :)
> >
> > Right, we'd pass something around that cannot be easily abused (like
> > modifying random vma flags in mmap_complete).
> >
> > So I was wondering if most operations that driver would perform during =
the
> > mmap_complete() could be be abstracted, and only those then be called w=
ith
> > whatever opaque thing we return here.
>
> Well there's 2 issues at play:
>
> 1. I might end up having to rewrite _large parts_ of kernel functionality=
 all of
>    which relies on there being a vma parameter (or might find that to be
>    intractable).
>
> 2. There's always the 'odd ones out' :) so there'll be some drivers that
>    absolutely do need to have access to this.
>
> But as I was writing this I thought of an idea - why don't we have someth=
ing
> opaque like this, perhaps with accessor functions, but then _give the abi=
lity to
> get the VMA if you REALLY have to_.
>
> That way we can handle both problems without too much trouble.
>
> Also Jason suggested generic functions that can just be assigned to
> .mmap_complete for instance, which would obviously eliminate the crazy
> factor a lot too.
>
> I'm going to refactor to try to put ONLY prepopulate logic in
> .mmap_complete where possible which fits with all of this.

Thinking along these lines, do you have a case when mmap_abort() needs
vm_private_data? I was thinking if VMA mapping failed, why would you
need vm_private_data to unwind prep work? You already have the context
pointer for that, no?

>
> >
> > But I have no feeling about what crazy things a driver might do. Just
> > calling remap_pfn_range() would be easy, for example, and we could abst=
ract
> > that.
>
> Yeah, I've obviously already added some wrappers for these.
>
> BTW I really really hate that STUPID ->vm_pgoff hack, if not for that, li=
fe
> would be much simpler.
>
> But instead now we need to specify PFN in the damn remap prepare wrapper =
in
> case of CoW. God.
>
> >
> > --
> > Cheers
> >
> > David / dhildenb
> >
>
> Cheers, Lorenzo

