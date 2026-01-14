Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7372D3CC83
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l3fL2jCAfWZLF1Vci6ZRE/CAoSZmZ+NVGFQtLj2FMso=; b=wiKZE5C2ZQ4bMirq7xG8AHj8UB
	Oubic1freSGE88Y/R/aHZx6nOyWV9pWhLbR0xOPP9fcwzz8NxOTWVTmD1pnoMOi5EITTEIRtZzHup
	LwqI3MZtmrr8+sUisr2wl1EH35tqF1UgzZFfAZJQ9XEvOnJJfrvtjntBXUTg0Ue5Z4Z4iwgEf+3e/
	3unhDMGWJHo5QeZm1YscDuP6guACP/v049sasOwTqfxVK8tdRLd9rEs5aaxRp5R1cEyyxQIocOHrt
	d63qTMPrefFG7F0oFomCJaUYp3jD147WWw/VSzEipFWA/IwS8oy2jpwzEdwXEBaIa6M/9ryH6UYPA
	u5uzJ0VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg8xv-0000000ArTt-0PvG;
	Wed, 14 Jan 2026 22:03:47 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg8xr-0000000ArSI-1euS
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 22:03:45 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4ee243b98caso52431cf.1
        for <kexec@lists.infradead.org>; Wed, 14 Jan 2026 14:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768428222; cv=none;
        d=google.com; s=arc-20240605;
        b=CJY6jDY6QlKCSN9ebCaGd20Iy76JQwmP0YnqjDmuWZWmdKpYsjcIjZ5vF3LMVDRzZL
         JKMDQYlv+vIOgxQjHDMUMZK5PM+001WST3mgLgcv/d7ir53B8n/yKREmqduZnGutwwF3
         I8XV98OkbRgYbmLriEjmHM7PkperyAFPjtCSXoCUuBGgA6kRO09k+V8kcHqpn+lNRGW9
         yC0ymYZVoOzE2S5svDvtg9gOMODZ7XwMhmtaDYgVSCD/+ScDI6whENxEGq5i7ET+CMnA
         MlMtEsomvD/5OWEx4xhWMKssW1O6j6Oo4G6JT77wWZeFkRtdqcLRgeHcZkAByWTtlqxK
         vHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3fL2jCAfWZLF1Vci6ZRE/CAoSZmZ+NVGFQtLj2FMso=;
        fh=8cwcH/bhJF261wWheR9mZAenWUsG1vSRNmLl666yuWY=;
        b=gW9u7yaIfpodINSrpHUH/5yGt78Uc3wYldSOxcYAFso0x8bfPsyl0R5eHIuANQeKaf
         5ejd4FZfLNnTYpj5eqenO2Sf6yfWe4mzvpvf2ecGXGZurwP9T4mFbPu90htOzYMOzHrr
         x5P7vLp8XlCaeVAqKoIIk3HuoFTbOT5IVz0wrZxr2n7bvpCRhyXEKa/OEPk8cwzBgP69
         ndDXuZL6pQVfUA2tXmu/EVP7oHFuCQBCj5D+suUqyEFSbAQmg+EsW+0OdNjJzXCC7FXq
         wHV7T8+6METmfPnQUuJ+VkRjjM002doiPdTBUL0cUc10t5NjFZTdScUH54sRwhzJMHMn
         G4QA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768428222; x=1769033022; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3fL2jCAfWZLF1Vci6ZRE/CAoSZmZ+NVGFQtLj2FMso=;
        b=2VOr8QN6M2hsdRk+PyANffJ9zGzC4q6axzpBvYJ9pJZqgEYOZBTtj2KsG/Ho5yj148
         KxPJK76fl6HJFDzAj70MkKW6KMflnBrdFpFnrfOQke2hDgTVddC14h788lHP+W9JS6i9
         MbAEgsuSPxKOw069w2hhgwbYLZHaOBkyTSMDRibIcx09Iwt7WQ2hLoVUJ1JcPMP1MCgl
         8JBqk81qWzHyX74f0mMkqHq05n7rMg8qQrM+d4JyNkCVoKBL9RwXTP33gg79h/k+dvK6
         8kYirhC/jdjBNOI6u5zFEdqakjblG9QUWT6ipsYgb0clImuwxD5wtcNpm/DAqykMEi5S
         Kx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428222; x=1769033022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3fL2jCAfWZLF1Vci6ZRE/CAoSZmZ+NVGFQtLj2FMso=;
        b=dR3J95daguPzL1N7hHLdGAI1ZIQvNDc8HxmQqEqfsBGDEVhq92Db8DqxIJNyJVfcX6
         a7OLtT/6lU2Wbbqhgx2w3qsRQoYFYzTCflkngVq/bye2/Y2y1UzXWgGK8bkb+U2Uu/mf
         WSjgBH1/WUD/ybsN16wb4V5uu5Hg6UYkgouutzqsY5cmtdxsAXE4Pe35nBNQCUll7Z4S
         vjj2wdSiR1njTPjARgT9pSWVBb5a1cQnlCodBAwNT32RwOuvDWc/uuD7fNz11n6eiL7D
         PwS4hW+KUnBXPEwqeUogP16DcjN4qwiOJqFgV4UOIVmDChn4sIppBiQY0COHFzNXmTlB
         t/OA==
X-Forwarded-Encrypted: i=1; AJvYcCUXBNAu2p4V2FDTM4Kj3BdvogAwb++kBZ/Q+QAchG/wpSxKbtqiX7hyxOafYdEz2xZmUuoPbg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLVa4S3/aLc0X6d++1W9XdwMY1WqXhbNtAVP6gwIEMIFlwI3GC
	31cj89pOJbXpYZtWyfBybZ9kNL4LNtFJu1soQFHnpF9+OLAGT+G9YFSv8PdnRyjisWLhtE02Q8R
	zfgm47SfYqziA8Nd5ZJjjeGm/Q5ilhyGzGGjRc2Ha
X-Gm-Gg: AY/fxX5Qx+nvQ3k+cC6FYKXh+FYiYIFlyzgo2FUTm3nQK8e0662kEWnIK/eOrdkNE4Q
	u9oWISNIbPnfRJmk7OuYYly1a4iBeP6oZIct5Kn0Jgjj6TSsLxaGc8zzleSG6DtOFOxbVwsksix
	6aoyzYfooEMphRbfEgJ4VZP+wnRiJw6j1pCmszaRXi2J5t47u1+bavGmzGXqDeRIN+ylXcZDblP
	hqAfAV4xjS81Tz0JJ7znruXorK1cDpBsDbslJP4UDe+GZlH8zTsjM/FL4cGPtaWvywJKpM31SxD
	6Ycc49uU+uXPtFXl68Vm8b/cTA==
X-Received: by 2002:a05:622a:1886:b0:4f4:bb86:504f with SMTP id
 d75a77b69052e-501eaba6816mr2892901cf.16.1768428221476; Wed, 14 Jan 2026
 14:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20260113033403.161869-1-ranxiaokai627@163.com>
 <2vxztswoi16k.fsf@kernel.org> <CAJuCfpEwa=_fubhf5wBnFKrKpOgjyXRy94f2BDx38x_NALE_OQ@mail.gmail.com>
 <2vxzpl7chw8d.fsf@kernel.org>
In-Reply-To: <2vxzpl7chw8d.fsf@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Jan 2026 14:03:30 -0800
X-Gm-Features: AZwV_Qg5vTKHUbo3UIWgMBqfS48OHF8JA7wML31Ex5lRim3U9cb7GEUBvsiGrdk
Message-ID: <CAJuCfpE3ffje9qXdwB3QZsyE+rD-unChSNXPfrijSkk5Nrt5CQ@mail.gmail.com>
Subject: Re: [PATCH v2] kho: init alloc tags when restoring pages from
 reserved memory
To: Pratyush Yadav <pratyush@kernel.org>
Cc: ranxiaokai627@163.com, graf@amazon.com, rppt@kernel.org, 
	pasha.tatashin@soleen.com, akpm@linux-foundation.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_140343_452520_22F49833 
X-CRM114-Status: GOOD (  40.58  )
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

On Wed, Jan 14, 2026 at 10:42=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Wed, Jan 14 2026, Suren Baghdasaryan wrote:
>
> > On Wed, Jan 14, 2026 at 8:55=E2=80=AFAM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> >>
> >> Hi Ran,
> >>
> >> On Tue, Jan 13 2026, ranxiaokai627@163.com wrote:
> >>
> >> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> >
> >> > Memblock pages (including reserved memory) should have their allocat=
ion
> >> > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before be=
ing
> >> > released to the page allocator. When kho restores pages through
> >> > kho_restore_page(), missing this call causes mismatched
> >> > allocation/deallocation tracking and below warning message:
> >> > alloc_tag was not set
> >> > WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, =
CPU#1: swapper/0/1
> >> > RIP: 0010:___free_pages+0xb8/0x260
> >> >  kho_restore_vmalloc+0x187/0x2e0
> >> >  kho_test_init+0x3c4/0xa30
> >> >  do_one_initcall+0x62/0x2b0
> >> >  kernel_init_freeable+0x25b/0x480
> >> >  kernel_init+0x1a/0x1c0
> >> >  ret_from_fork+0x2d1/0x360
> >> >
> >> > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> >> > fix this.
> >> >
> >> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservat=
ion")
> >> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >> > ---
> >> >  kernel/liveupdate/kexec_handover.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/=
kexec_handover.c
> >> > index cd6b3fb9dcae..2d47f2c50bd8 100644
> >> > --- a/kernel/liveupdate/kexec_handover.c
> >> > +++ b/kernel/liveupdate/kexec_handover.c
> >> > @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t=
 phys, bool is_folio)
> >> >       else
> >> >               kho_init_pages(page, nr_pages);
> >> >
> >> > +     clear_page_tag_ref(page);
> >>
> >> You are only clearing the tag for the head page. The tail pages are
> >> still un-initialized. Is that intentional?
> >
> > In the case of a compound page we set the tag only on the head page,
> > so this is correct.
> >
> >>
> >> What about non-compound pages (the ones you get from
> >> kho_restore_pages(), aka when is_folio is false)? Do we need to clear
> >> the tag on all pages in that case?
> >
> > In the case of kho_restore_pages() we call split_page() which calls
>
> Not since 7b71205ae112 ("kho: fix restoring of contiguous ranges of
> order-0 pages"). That commit removed the split_pages() call and
> open-coded the page initialization logic tailored for KHO.

Ah, I see. I missed that change.

>
> So I think you do need to initialize the tags for kho_restore_pages().
>
> I sent a patch [0] simplifying the page init logic a bit. I need to do a
> v2 but it is a very simple change so I can get that done tomorrow. I
> think it would be good to base your series on that since that would make
> it easier for you to modify only the kho_restore_pages() path and the
> end result would be cleaner.
>
> [0] https://lore.kernel.org/linux-mm/20251223104448.195589-1-pratyush@ker=
nel.org/

Ok, let's wait for your patch to see the final result. Please CC us
when you send it.

>
> > pgalloc_tag_split() and that propagates the tag from the head page to
> > all the tail pages being split from it. However now that I'm looking
> > at it, I'm not sure pgalloc_tag_split() works correctly if the tag
> > reference of the head page is CODETAG_EMPTY. In summary, this patch is
> > fine but there might be a bug inside pgalloc_tag_split() if the tag
> > reference is CODETAG_EMPTY.
> >
> > I'll analyze and reproduce that case. If it indeed has the issue I
> > think it's easy to fix it by creating a specialized alloc_tag object
> > with alloc_tag->ct=3DCODETAG_EMPTY and  make __pgalloc_tag_get() return
> > it if the page's tag reference is CODETAG_EMPTY.
> >
> >>
> >> >       adjust_managed_page_count(page, nr_pages);
> >> >       return page;
> >> >  }

