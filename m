Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A005D25929
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 03:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01eHs4RmyXJ64AHEEiKrygNjatMh0W4AJS7s1dMMrPg=; b=hk3ykP+OarEuvJsCrDliBM9uCQ
	jeu/RA8LZ4plenlsXa92gf390ZDA2s6ldx2TxmBHHkthFaOTaX4mgjC/zyTN2OnYsfK6c8QiAJESp
	wG1rwxqdHlf4zjKS/Z5lQ3U3KRkSvdd4OWLZXSAdPkSLTbnOrBLitpnIdz/G6gG3djKQ+eyDHy5bs
	QCnYt7Phc53pYTvyxm2c3WN/N6mrS/+kCc3uy3zmBjlRDjw/rJCRK5SqHtW+AYealNCZq+kX0VWY0
	TK9H9dTOEcf4qOEOE8iGpGjPcSWvWQmz55IRlAU2j+8Cc1QcUnO7PdPyjQY2+l8S6DuNMafp99RkM
	V/Lur+Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkZf4-0000000DaNZ-15h0;
	Tue, 27 Jan 2026 03:22:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkZf1-0000000DaLe-0HQe
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 03:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769484152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01eHs4RmyXJ64AHEEiKrygNjatMh0W4AJS7s1dMMrPg=;
	b=FuvjjgNdwpFOhno4RQg0h8VYKCp2LeIbsiwo9HL1jbOk0/WvD2LIVzJxviOpKx9zSgoujq
	MFkXNfx/uRhM8jkJgvDAFQ13sZR36zNE2xdY6XiH2u5cZJVbaVtY7xstP0FLL98n9NFjKu
	KeNo//nbKD80qhG5LjKBiD9bCfN4Z/g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-gAcHXHEPP9uis1TCauAw2w-1; Mon, 26 Jan 2026 22:22:29 -0500
X-MC-Unique: gAcHXHEPP9uis1TCauAw2w-1
X-Mimecast-MFC-AGG-ID: gAcHXHEPP9uis1TCauAw2w_1769484149
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50147745917so237038841cf.3
        for <kexec@lists.infradead.org>; Mon, 26 Jan 2026 19:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484149; x=1770088949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01eHs4RmyXJ64AHEEiKrygNjatMh0W4AJS7s1dMMrPg=;
        b=HP/ihbwKcd/ffWb2X1g7hNPweFIC6fH5UgLVf1UADIMeS98pLNmlFSQB+trf6oCsUy
         CpeHoe2QKtdUHI0Ab3CwDqJjEa2u5hUVGReJOI6kuIQeEluN1luG4ciWgFSIhGbyQBkn
         iUUkVHNUfDcKKArbHzwLBPMjmW5GImu48IFK/kx2XjT6nJl7riR20VEGt6YQN4zlqeXq
         KdY5njoWD4HXNfHfx1Zth3sWLd9nVjSip+VX6Ttz27GIRyzugtC1Tx7oL3YvHVJznCDd
         huc9XZDqSimTbQkIGhJ2xXjzYwW9YVhyltCih5Z/GwSU3ZhTJPahKfeE4bchXLok0Aix
         85bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV35yMaTCuW9tyV0VWCGsTce7TbfM2H3PVIq1zH3mEkN37QhM58RPphhPdrhLGZSu5ss16QvQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyu7Ys7+6AoNh/cSwNCi4WjUoOwi2KyCwpspF6DlO0W81XviZNS
	JJfr+CncCZ4h/1NadL8YT+jRsrAWPvorWkhO6Jt9NtY32iIxd+d8BNVK7wflizeESWl7aUB+RpH
	PXU8B/kVzPBKKlIiLjYdB71n+JmyUQoLTs8ThbJ9xhxRCb+4XfDyo0ZBbyDW+GvJpla7PUabQZb
	+YrTZLGtnpWHNZN7fBbxs/7EJdB1fD8zNp+Hi+
X-Gm-Gg: AZuq6aImCuGXcVTx/tvJTUz0YJGw3sXqVG8QO9cZZ/Ng0MYCkGREGRqinf5Cx6ZTG50
	043cVTjf4Y5P4z2GpbIxUFx4laJG719WP+a6xSLWG84248fllaTjZi4zmQWSMAKHlGIM+/5Mhr2
	gHAXmvInpdI7EJwTOG0/RCFmbKQVpJ+1YdGjxgIcHQPzDl/3+TBUkqeKSLuBTQO84SaB0=
X-Received: by 2002:ac8:5910:0:b0:501:4b96:466d with SMTP id d75a77b69052e-5032fa03049mr3381211cf.50.1769484149126;
        Mon, 26 Jan 2026 19:22:29 -0800 (PST)
X-Received: by 2002:ac8:5910:0:b0:501:4b96:466d with SMTP id
 d75a77b69052e-5032fa03049mr3381021cf.50.1769484148652; Mon, 26 Jan 2026
 19:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <20260120025500.25095-7-ltao@redhat.com>
 <87fr7xup0i.fsf@oracle.com>
In-Reply-To: <87fr7xup0i.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 27 Jan 2026 16:21:52 +1300
X-Gm-Features: AZwV_QipSQ-Uo7nDCtv3f6Ykve-Ime0uUh0KwHgNh-2IJEloa1pVpVJCL9PfF-Y
Message-ID: <CAO7dBbX5ygr3J3wiNog3hYFFaqr2O49bSmtzYoV5CMHN+YnC7g@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] Add page filtering function
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eAEpRbWHTR6W1q8Z_nI9lwFM9IGey5rp-QKbg6CbKWo_1769484149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_192235_253485_DAD69452 
X-CRM114-Status: GOOD (  61.65  )
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

Hi Stephen,

On Fri, Jan 23, 2026 at 2:04=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
> > pfn and num is the data which extensions give to makedumpfile for mm pa=
ge
> > filtering. Since makedumpfile will iterate the pfn in an ascending orde=
r in
> > __exclude_unnecessary_pages(), pfn and num are stored within ft_page_in=
fo linked
> > lists and organized in an ascending order by pfn, so if one pfn
> > is hit by one list, the next pfn is most likely to be hit either by
> > this list again, or the one follows, so a cur variable is used for savi=
ng
> > the current list position to speedup the pfn checking process.
>
> I'm wondering about the trade-off for using a linked list versus an
> array. Using the linked list, we are forced to maintain the sorted
> order as we construct the list, which is an O(N^2) insertion sort.
>
> If instead we used an array, we could sort it with qsort() once, at the
> end. Then we could merge any overlapping ranges. Lookup could be
> implemented cheaply with bsearch(), and we could continue to use the
> optimization where we maintain a "cur" pointer.  I believe the overall
> runtime complexity of the array approach would be O(N*log(N)) without
> requiring hand-implementing anything too complex, compared to O(N^2).
>
> Depending on the number of pages (and how fragmented they are), this
> may or may not be an issue.
>
> In my testing for userspace tasks, the number of pages retained can be
> on the order of ~100k. However -- my use case can't really use a list of
> PFNs, which I'll explain below. So my use case doesn't really matter too
> much here -- maybe your use case has relatively few page ranges, so the
> cost of O(N^2) is not bad.
>
> So I guess I don't have a strong preference - but it's worth
> considering.
>
> > In addition, 2 ft_page_info linked list chains are used, one for mm pag=
e
> > discarding and the other for page keeping.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >  erase_info.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  erase_info.h   | 12 +++++++
> >  makedumpfile.c | 28 ++++++++++++---
> >  3 files changed, 134 insertions(+), 4 deletions(-)
> >
> > diff --git a/erase_info.c b/erase_info.c
> > index b67d1d0..8838bea 100644
> > --- a/erase_info.c
> > +++ b/erase_info.c
> > @@ -2466,3 +2466,101 @@ get_size_eraseinfo(void)
> >       return size_eraseinfo;
> >  }
> >
> > +/* Pages to be discarded */
> > +static struct ft_page_info *ft_head_discard =3D NULL;
> > +/* Pages to be keeped */
> > +static struct ft_page_info *ft_head_keep =3D NULL;
> > +
> > +/*
> > + * Insert the ft_page_info blocks into ft_head by ascending pfn.
> > + */
> > +bool
> > +update_filter_pages_info(unsigned long pfn, unsigned long num, bool to=
_discard)
> > +{
> > +     struct ft_page_info *p, **ft_head;
> > +     struct ft_page_info *new_p =3D malloc(sizeof(struct ft_page_info)=
);
> > +
> > +     ft_head =3D to_discard ? &ft_head_discard : &ft_head_keep;
> > +
> > +     if (!new_p) {
> > +             ERRMSG("Can't allocate memory for ft_page_info at %lx\n",=
 pfn);
> > +             return false;
> > +     }
> > +     new_p->pfn =3D pfn;
> > +     new_p->num =3D num;
> > +     new_p->next =3D NULL;
> > +
> > +     if (!(*ft_head) || (*ft_head)->pfn > new_p->pfn) {
> > +             new_p->next =3D (*ft_head);
> > +             (*ft_head) =3D new_p;
> > +             return true;
> > +     }
> > +
> > +     p =3D (*ft_head);
> > +     while (p->next !=3D NULL && p->next->pfn < new_p->pfn) {
> > +             p =3D p->next;
> > +     }
> > +
> > +     new_p->next =3D p->next;
> > +     p->next =3D new_p;
>
> It might be wise to defensively handle the case of overlapping
> PFN ranges by merging them.
>
> > +     return true;
> > +}
> > +
> > +/*
> > + * Check if the pfn hit ft_page_info block.
> > + *
> > + * pfn and ft_head are in ascending order, so save the current ft_page=
_info
> > + * block into **p because it is likely to hit again next time.
> > + */
> > +bool
> > +filter_page(unsigned long pfn, struct ft_page_info **p, bool handle_di=
scard)
> > +{
> > +     struct ft_page_info *ft_head;
> > +
> > +     ft_head =3D handle_discard ? ft_head_discard : ft_head_keep;
> > +
> > +     if (ft_head =3D=3D NULL)
> > +             return false;
> > +
> > +     if (*p =3D=3D NULL)
> > +             *p =3D ft_head;
> > +
> > +     /* The gap before 1st block */
> > +     if (pfn >=3D 0 && pfn < ft_head->pfn)
> > +             return false;
> > +
> > +     /* Handle 1~(n-1) blocks and following gaps */
> > +     while ((*p)->next) {
> > +             if (pfn >=3D (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
> > +                     return true; // hit the block
> > +             if (pfn >=3D (*p)->pfn + (*p)->num && pfn < (*p)->next->p=
fn)
> > +                     return false; // the gap after the block
> > +             *p =3D (*p)->next;
> > +     }
> > +
> > +     /* The last block and gap */
> > +     if (pfn >=3D (*p)->pfn + (*p)->num)
> > +             return false;
> > +     else
> > +             return true;
> > +}
> > +
> > +static void
> > +do_cleanup(struct ft_page_info **ft_head)
> > +{
> > +     struct ft_page_info *p, *p_tmp;
> > +
> > +     for (p =3D *ft_head; p;) {
> > +             p_tmp =3D p;
> > +             p =3D p->next;
> > +             free(p_tmp);
> > +     }
> > +     *ft_head =3D NULL;
> > +}
> > +
> > +void
> > +cleanup_filter_pages_info(void)
> > +{
> > +     do_cleanup(&ft_head_discard);
> > +     do_cleanup(&ft_head_keep);
> > +}
> > diff --git a/erase_info.h b/erase_info.h
> > index b363a40..6c60706 100644
> > --- a/erase_info.h
> > +++ b/erase_info.h
> > @@ -20,6 +20,7 @@
> >  #define _ERASE_INFO_H
> >
> >  #define MAX_SIZE_STR_LEN (26)
> > +#include <stdbool.h>
> >
> >  /*
> >   * Erase information, original symbol expressions.
> > @@ -65,5 +66,16 @@ void filter_data_buffer_parallel(unsigned char *buf,=
 unsigned long long paddr,
> >  unsigned long get_size_eraseinfo(void);
> >  int update_filter_info_raw(unsigned long long, int, int);
> >
> > +bool update_filter_pages_info(unsigned long, unsigned long, bool);
> > +
> > +struct ft_page_info {
> > +     unsigned long pfn;
> > +     unsigned long num;
> > +     struct ft_page_info *next;
> > +} __attribute__((packed));
> > +
> > +bool filter_page(unsigned long, struct ft_page_info **p, bool handle_d=
iscard);
> > +void cleanup_filter_pages_info(void);
> > +
> >  #endif /* _ERASE_INFO_H */
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index ca8ed8a..ebac8da 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -102,6 +102,7 @@ mdf_pfn_t pfn_free;
> >  mdf_pfn_t pfn_hwpoison;
> >  mdf_pfn_t pfn_offline;
> >  mdf_pfn_t pfn_elf_excluded;
> > +mdf_pfn_t pfn_extension;
> >
> >  mdf_pfn_t num_dumped;
> >
> > @@ -6459,6 +6460,8 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
> >       unsigned int order_offset, dtor_offset;
> >       unsigned long flags, mapping, private =3D 0;
> >       unsigned long compound_dtor, compound_head =3D 0;
> > +     struct ft_page_info *cur_discard =3D NULL;
> > +     struct ft_page_info *cur_keep =3D NULL;
> >
> >       /*
> >        * If a multi-page exclusion is pending, do it first
> > @@ -6495,6 +6498,13 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
> >               if (info->flag_cyclic && !is_cyclic_region(pfn, cycle))
> >                       continue;
> >
> > +             /*
> > +              * Keep pages that specified by user via
> > +              * makedumpfile extensions
> > +              */
> > +             if (filter_page(pfn, &cur_keep, false))
> > +                     continue;
> > +
>
> It makes sense to allow plugins to enumerate a list of PFNs to override
> and include. I like that - it's simple enough. But it's not flexible
> enough for my use case with userspace stacks :(
>
> The userspace stack region is an anon_vma. My plugin can enumerate the
> anon_vmas that it wants to save, but it's prohibitively expensive and
> complex to enumerate the list of pages associated with each anon_vma. We
> would need to do a page table walk for each process.
>
> There's a simpler way: from the struct page mapping and index fields,
> it's possible to determine which anon_vma the page is associated with,
> and what index it has within the VMA. And from this, we can make the
> determination of whether to include a page or not. This is what I had
> implemented in this patch:
>
> https://github.com/brenns10/makedumpfile/commit/1c0a828ef80962480f771915c=
2d494272721b659#diff-2593512d7ec329b34b1ca5686a7b6b073d0ca636df8ff20fea0468=
4da2c8e063R6692-R12150
>
> So, I wonder if it makes sense to allow a plugin to register a callback
> to be called here, so the plugin can make the more complex decision?
> This would keep the logic outside of the core makedumpfile code, but
> allow the necessary flexibility.
>
> Something like:
>
> if (plugin_keep_page_callback && plugin_keep_page_callback(pfn, pcache))
>     continue;
>
> And then the extension system could allow an extension to register that
> callback. It would need to keep the extension loaded for the duration of
> the execution of makedumpfile (rather than calling dlclose()
> immediately).
>
> What do you think about this? I'm happy to implement this part of it
> separate from your patch series -- you could simply drop the stuff
> related to page inclusion, and I can add the necessary pieces when I
> submit my extension patches.

Thanks a lot for your comments and suggestions! For my GPU mm
filtering case, the pages are often allocated as a large block set, so
one linked list like {discard: true, start_pfn: 100, pfn_nums: 100000}
could hit a large range of pages' pfn, thus linked lists aren't much
long and overlap/merge isn't a performance bottleneck to me. I agree
with your case that this can be a problem for scattered pages.

Here is my plan, in v4, I will re-design the extensions part, that
extensions will declare which kallsyms/btf symbol it is interested in,
and remove the hash tables for kallsyms as you suggested (Many thanks
for that, I think it is a brilliant idea to save the kallsyms
memory!). And I will leave this linked list / array page (ex)inclusion
function to you, so we can cooperate on this. Thanks again for your
support and help :)

Thanks,
Tao Liu

>
> Thanks,
> Stephen
>
> >               /*
> >                * Exclude the memory hole.
> >                */
> > @@ -6687,6 +6697,14 @@ check_order:
> >               else if (isOffline(flags, _mapcount)) {
> >                       pfn_counter =3D &pfn_offline;
> >               }
> > +             /*
> > +              * Exclude pages that specified by user via
> > +              * makedumpfile extensions
> > +              */
> > +             else if (filter_page(pfn, &cur_discard, true)) {
> > +                     nr_pages =3D 1;
> > +                     pfn_counter =3D &pfn_extension;
> > +             }
> >               /*
> >                * Unexcludable page
> >                */
> > @@ -6748,6 +6766,7 @@ exclude_unnecessary_pages(struct cycle *cycle)
> >               print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, inf=
o->num_mem_map, NULL);
> >               print_execution_time(PROGRESS_UNN_PAGES, &ts_start);
> >       }
> > +     cleanup_filter_pages_info();
> >
> >       return TRUE;
> >  }
> > @@ -8234,7 +8253,7 @@ write_elf_pages_cyclic(struct cache_data *cd_head=
er, struct cache_data *cd_page)
> >        */
> >       if (info->flag_cyclic) {
> >               pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
> > -             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D 0;
> > +             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
> >               pfn_memhole =3D info->max_mapnr;
> >       }
> >
> > @@ -9579,7 +9598,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_=
data *cd_header, struct cache_d
> >                * Reset counter for debug message.
> >                */
> >               pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
> > -             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D 0;
> > +             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
> >               pfn_memhole =3D info->max_mapnr;
> >
> >               /*
> > @@ -10528,7 +10547,7 @@ print_report(void)
> >       pfn_original =3D info->max_mapnr - pfn_memhole;
> >
> >       pfn_excluded =3D pfn_zero + pfn_cache + pfn_cache_private
> > -         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> > +         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_exte=
nsion;
> >
> >       REPORT_MSG("\n");
> >       REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
> > @@ -10544,6 +10563,7 @@ print_report(void)
> >       REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free)=
;
> >       REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoi=
son);
> >       REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offli=
ne);
> > +     REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_exten=
sion);
> >       REPORT_MSG("  Remaining pages  : 0x%016llx\n",
> >           pfn_original - pfn_excluded);
> >
> > @@ -10584,7 +10604,7 @@ print_mem_usage(void)
> >       pfn_original =3D info->max_mapnr - pfn_memhole;
> >
> >       pfn_excluded =3D pfn_zero + pfn_cache + pfn_cache_private
> > -         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> > +         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_exte=
nsion;
> >       shrinking =3D (pfn_original - pfn_excluded) * 100;
> >       shrinking =3D shrinking / pfn_original;
> >       total_size =3D info->page_size * pfn_original;
> > --
> > 2.47.0
>


