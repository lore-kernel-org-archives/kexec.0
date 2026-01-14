Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C418D39008
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBnCNREOMaRTs8GPX9o6jn1T+H9j4SOjRgO9CydcfTQ=; b=KC4Ta5kztO/qtnOd37TFavsbUg
	3s8XrlYCBg0ZUbCtB59t7JDQbnAy0vJxfnjuV20wgpKpafnS7yZ+a4Jjtl1IIpc4J5WkopCHaxXdz
	t9E576NNBPOBLKBdr6v4apoPp2WwMhF0XeJRWi4PCeBQbMSTmBX+aRBKEzJuoKMCXrAu8A+YaV3m+
	Rp/oZGyCZ3S48vLiUL6bSy30djpiVnMtkuTd4gnBQh+I8LovZEX0E72cdJIHCeCTCHstW6+K0h1YS
	QMtmPrEiYKBOVeesfNXpwMFVdiHQMIvOoog3cLueUFP2n6jwKR/HbHaRCOKbvEv4ixRpy9GyqLoCd
	3B8jyihQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg5pE-0000000AMMm-101i;
	Wed, 14 Jan 2026 18:42:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg5p9-0000000AMMQ-0UAP
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 18:42:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6769D442D7;
	Wed, 14 Jan 2026 18:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B409C4CEF7;
	Wed, 14 Jan 2026 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768416150;
	bh=ycsyR+UpdbT5i32Mze2qlwVxIhWj61Ue122fNAYGHY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ixSrRuMj11g7YibcuR9ajWVVm3hwT2dwBpFnZ4aM4ryqzWSCkw9oXmRW6zfsIgTCP
	 jahC1f4rIshZtEZluXbRp/sCICEQOAPBcF9OadgwyNs/jEupj5lVVWX5O1epJEj0TM
	 D681YQbymK9TlZhbbH5aGzvWA7pWz9Ak9RG70/bM6V3TuJ12TnE+4/XwAL3Q21xneu
	 NFij89IbSZ5Lq6779M9VT/TZCQUM7ppogVxMlx4xqQ6BRugL8KReK5fGXg+WsN+FLC
	 AdH9yQFF2eMHSm5lewA1h/3LAqm5B17N0KoqzBS1UfcUBCPpKzh6I8bgvYe3uMUZTJ
	 48N8FVxcJKwAQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  ranxiaokai627@163.com,
  graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  akpm@linux-foundation.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v2] kho: init alloc tags when restoring pages from
 reserved memory
In-Reply-To: <CAJuCfpEwa=_fubhf5wBnFKrKpOgjyXRy94f2BDx38x_NALE_OQ@mail.gmail.com>
	(Suren Baghdasaryan's message of "Wed, 14 Jan 2026 09:59:10 -0800")
References: <20260113033403.161869-1-ranxiaokai627@163.com>
	<2vxztswoi16k.fsf@kernel.org>
	<CAJuCfpEwa=_fubhf5wBnFKrKpOgjyXRy94f2BDx38x_NALE_OQ@mail.gmail.com>
Date: Wed, 14 Jan 2026 18:42:26 +0000
Message-ID: <2vxzpl7chw8d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_104231_197300_A75DD9A8 
X-CRM114-Status: GOOD (  33.01  )
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

On Wed, Jan 14 2026, Suren Baghdasaryan wrote:

> On Wed, Jan 14, 2026 at 8:55=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> Hi Ran,
>>
>> On Tue, Jan 13 2026, ranxiaokai627@163.com wrote:
>>
>> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> >
>> > Memblock pages (including reserved memory) should have their allocation
>> > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
>> > released to the page allocator. When kho restores pages through
>> > kho_restore_page(), missing this call causes mismatched
>> > allocation/deallocation tracking and below warning message:
>> > alloc_tag was not set
>> > WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CP=
U#1: swapper/0/1
>> > RIP: 0010:___free_pages+0xb8/0x260
>> >  kho_restore_vmalloc+0x187/0x2e0
>> >  kho_test_init+0x3c4/0xa30
>> >  do_one_initcall+0x62/0x2b0
>> >  kernel_init_freeable+0x25b/0x480
>> >  kernel_init+0x1a/0x1c0
>> >  ret_from_fork+0x2d1/0x360
>> >
>> > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
>> > fix this.
>> >
>> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservatio=
n")
>> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> > ---
>> >  kernel/liveupdate/kexec_handover.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/ke=
xec_handover.c
>> > index cd6b3fb9dcae..2d47f2c50bd8 100644
>> > --- a/kernel/liveupdate/kexec_handover.c
>> > +++ b/kernel/liveupdate/kexec_handover.c
>> > @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t p=
hys, bool is_folio)
>> >       else
>> >               kho_init_pages(page, nr_pages);
>> >
>> > +     clear_page_tag_ref(page);
>>
>> You are only clearing the tag for the head page. The tail pages are
>> still un-initialized. Is that intentional?
>
> In the case of a compound page we set the tag only on the head page,
> so this is correct.
>
>>
>> What about non-compound pages (the ones you get from
>> kho_restore_pages(), aka when is_folio is false)? Do we need to clear
>> the tag on all pages in that case?
>
> In the case of kho_restore_pages() we call split_page() which calls

Not since 7b71205ae112 ("kho: fix restoring of contiguous ranges of
order-0 pages"). That commit removed the split_pages() call and
open-coded the page initialization logic tailored for KHO.

So I think you do need to initialize the tags for kho_restore_pages().

I sent a patch [0] simplifying the page init logic a bit. I need to do a
v2 but it is a very simple change so I can get that done tomorrow. I
think it would be good to base your series on that since that would make
it easier for you to modify only the kho_restore_pages() path and the
end result would be cleaner.

[0] https://lore.kernel.org/linux-mm/20251223104448.195589-1-pratyush@kerne=
l.org/

> pgalloc_tag_split() and that propagates the tag from the head page to
> all the tail pages being split from it. However now that I'm looking
> at it, I'm not sure pgalloc_tag_split() works correctly if the tag
> reference of the head page is CODETAG_EMPTY. In summary, this patch is
> fine but there might be a bug inside pgalloc_tag_split() if the tag
> reference is CODETAG_EMPTY.
>
> I'll analyze and reproduce that case. If it indeed has the issue I
> think it's easy to fix it by creating a specialized alloc_tag object
> with alloc_tag->ct=3DCODETAG_EMPTY and  make __pgalloc_tag_get() return
> it if the page's tag reference is CODETAG_EMPTY.
>
>>
>> >       adjust_managed_page_count(page, nr_pages);
>> >       return page;
>> >  }

