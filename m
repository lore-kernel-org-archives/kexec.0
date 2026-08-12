Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B7C5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 04:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHlHu1L1uq0AbU95kGBx2915Dz9LzbC3+YKEWdtzBVQ=; b=vxcn/AboRlTkwzOLAJm0nMD3yM
	8wNCwDOBiy8TvwctS08PpxCGhFvB3HbywFxak3FhEymrT8TiHlveCm6NZqY1G3r60cqrqEL5f0rOD
	7Ryes848BahmR5f8sdCtyQXiUHA8de/n4GCYGGlIKJvtUhPg4FY0qmLn8bKmdJTfMTzabvhOlIn0M
	8Mjh80IWPDHnYTW+IvbvPEB9ifKjViJDJz15MsJjZzwqz+GVvQk4t8Hksr0iovtOdYpEMzqhKtyTY
	BBvLgxlTXKrzHDa2nBRb1OL6tY+f1YyxPuT4Ex5od5SflXehEEFai19XX91holUxoTGm/y1up2nM/
	OfFm3QNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu0An-0000000FNmD-30OA;
	Wed, 12 Aug 2026 04:02:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu0Ak-0000000FNlq-07wo
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 04:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786507352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHlHu1L1uq0AbU95kGBx2915Dz9LzbC3+YKEWdtzBVQ=;
	b=ae2/nHfUf0W6wj7MS5pNiWdqV0MVLSgXfG+M/r7cVxdXHHYyEWZ7K9iHL3XeBE3b1JjCjK
	aHvoR+/ADoqwGiWlaCa7yvTdURByzGGOUmQ2vaxtCpjq/l7K3pjTiQFNUNtp1L7ZfFGv6P
	f8BUwOL5cEH6jB5VOFJUXbUxJtxpL4U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-_DJuboX8OguFe3SOvnEpjw-1; Wed, 12 Aug 2026 00:02:27 -0400
X-MC-Unique: _DJuboX8OguFe3SOvnEpjw-1
X-Mimecast-MFC-AGG-ID: _DJuboX8OguFe3SOvnEpjw_1786507347
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d33c89a29so3512631cf.1
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 21:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786507347; x=1787112147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHlHu1L1uq0AbU95kGBx2915Dz9LzbC3+YKEWdtzBVQ=;
        b=g/EjKYPrJId8+8fkTUNu1w0GFfF9C6g9RTCdG8T+phxfTYFkuS681bsGTIC2t2lcQI
         Z8N6q2MlPCWscpPah+QKmwfDEKpJ1jKJqVpLV1j9/Jt87pCFge9NdNRyK7ZhYCtoUpyp
         72weyENljiO0mNJHHn73Hd86xCnjnPf7ToyLXulxmrmf3LhICcxZaDI6/mw+peCCVGQE
         EHl5o3wV6XguotnaXY58Qf6vrO7d4E+a2rfq302Be/XoWG/reOI2arT0VZudqeC6r9jq
         yuMMcctHVKBFPRiqgcmsj79LofhDZv//8j0Be3T8expm66Kwh+Ds4mV5ZI3IS/9AvUoJ
         /3bw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/CyYNCx0AoK9tzEnh72LBlI76sexlkyy+JZWhloL4vfOOQiyuIYd5yvoRPboNC5V7+/p2oA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyyWAJ1xqmxS5e+1ZlnxzyK+OEHWd5CTsuva34HkfYVyMUJ54iO
	xEgZdGLKW8Qy1NTqhRBLBo5CRYPlSPLdXQVyE8xixr66sn4fNYzMCHHAYZ1A13pz/XuTroIbVTL
	SLOU5IGKw9+ZuDyITkr3uoh8n31S4JuMIYJ4bm4WgDdnnfV/4W50Vh7O9x9xt+WBZWS7A49Wnjt
	BbII9c09xzIYQIVXIVlwSd/65yc0lXQS0Y8TniCkHHUu/rUHY=
X-Gm-Gg: AR+sD13h1X18OXJSw8T2LKm9upJT3swPqg0TlR+Js2l1jYS1jy4b6pRKkUHNs0ocpjN
	EaLDN19JU/nVEeghkv1o8waTOTu77/f47sSOvJYFzedT1ei9XFfQSPAWwKOH8vAXAkYbX7OZltc
	dJWI4O9g3cpCcrUJjfhjKXPROInemHjEt5mayJ/VvVniBFO7mI0C5cVIA=
X-Received: by 2002:a05:622a:1791:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52d646fc340mr15896011cf.11.1786507347166;
        Tue, 11 Aug 2026 21:02:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1791:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-52d646fc340mr15895681cf.11.1786507346659; Tue, 11 Aug 2026
 21:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com> <20260714004550.3698175-4-stephen.s.brennan@oracle.com>
In-Reply-To: <20260714004550.3698175-4-stephen.s.brennan@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 12 Aug 2026 16:01:50 +1200
X-Gm-Features: AUfX_mzrfqgpjHmz_fx3n9gVVo3O2-e5TR6gTXtYPRHnFVMkt1O_NjfPr4Ta5M4
Message-ID: <CAO7dBbU6tfVHLO6LW5ZQXbApqychfo=hAtXd8pD+Z7MXFF7fgg@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 3/9] Share page information with extension callbacks
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5nzHPNHrY51N_rldN_F4Xw2LImG7_fWffkhksA3Q8Fw_1786507347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_210234_243176_C001E803 
X-CRM114-Status: GOOD (  35.67  )
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

On Tue, Jul 14, 2026 at 12:46=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> In __exclude_unnecessary_pages(), we extract several fields related
> to the page. Some of these, like compound_order and compound_dtor, have
> logic specific to the kernel version.
>
> Extensions can, of course, determine these values for themselves, but
> it's extra work, and duplicates logic that may need to be updated
> frequently with new kernel versions. What's more, if we put all the
> values together in a single structure, helpers like isSlab() and others
> can be implemented in terms of that structure and shared with the
> extensions in order to further simplify their implementation.
>
> With that in mind, group the per-page variables into a structure and
> share them with extension callbacks. This breaks the extension API,
> but since a release hasn't yet happened, it seems reasonable to do so.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  extension.c    |  8 ++---
>  extension.h    |  3 +-
>  makedumpfile.c | 83 +++++++++++++++++++++++++-------------------------
>  makedumpfile.h | 16 ++++++++++
>  4 files changed, 64 insertions(+), 46 deletions(-)
>
> diff --git a/extension.c b/extension.c
> index 5188c1f..9b29f0c 100644
> --- a/extension.c
> +++ b/extension.c
> @@ -10,7 +10,7 @@
>  #include "kallsyms.h"
>  #include "btf_info.h"
>
> -typedef int (*callback_fn)(unsigned long, const void *);
> +typedef int (*callback_fn)(unsigned long, const void *, const struct pgi=
nfo *);
>
The function signature of callbacks are changed, it will be better to
update them in extensions/sample.c as well:

int extension_callback(unsigned long pfn, const void *pcache)
{
return PG_UNDECID;
}

Since it will serve as a reference for future extension authors.

Thaks,
Tao Liu

>  struct extension_handle_cb {
>         void *handle;
> @@ -306,14 +306,14 @@ fail:
>   * 1) Include the page if anyone says PG_INCLUDE, and
>   * 2) Exclude the page if no one says PG_INCLUDE, but one or more say PG=
_EXCLUDE.
>   */
> -int run_extension_callback(unsigned long pfn, const void *pcache)
> +int run_extension_callback(unsigned long pfn, const void *pcache, const =
struct pginfo *inf)
>  {
>         int result;
>         int ret =3D PG_UNDECID;
>
>         for (int i =3D 0; i < handle_cbs_len; i++) {
>                 if (handle_cbs[i]->cb) {
> -                       result =3D handle_cbs[i]->cb(pfn, pcache);
> +                       result =3D handle_cbs[i]->cb(pfn, pcache, inf);
>                         if (result =3D=3D PG_INCLUDE) {
>                                 ret =3D result;
>                                 goto out;
> @@ -341,7 +341,7 @@ bool add_extension_opts(char *opt)
>         return false;
>  }
>
> -int run_extension_callback(unsigned long pfn, const void *pcache)
> +int run_extension_callback(unsigned long pfn, const void *pcache, const =
struct pginfo *i)
>  {
>         return PG_UNDECID;
>  }
> diff --git a/extension.h b/extension.h
> index ba8d32a..22af9a6 100644
> --- a/extension.h
> +++ b/extension.h
> @@ -2,12 +2,13 @@
>  #define _EXTENSION_H
>  #include <stdbool.h>
>
> +struct pginfo;
>  enum {
>         PG_INCLUDE,     // Exntesion will keep the page
>         PG_EXCLUDE,     // Exntesion will discard the page
>         PG_UNDECID,     // Exntesion makes no decision
>  };
> -int run_extension_callback(unsigned long pfn, const void *pcache);
> +int run_extension_callback(unsigned long pfn, const void *pcache, const =
struct pginfo *i);
>  void init_extensions(void);
>  void cleanup_extensions(void);
>  bool add_extension_opts(char *opt);
> diff --git a/makedumpfile.c b/makedumpfile.c
> index e882b84..a4c9bbf 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6466,12 +6466,13 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
>         mdf_pfn_t pfn_read_start, pfn_read_end;
>         unsigned char *page_cache;
>         unsigned char *pcache;
> -       unsigned int _count, _mapcount =3D 0, compound_order =3D 0;
> +       struct pginfo i;
>         unsigned int order_offset, dtor_offset;
> -       unsigned long flags, mapping, private =3D 0;
> -       unsigned long compound_dtor, compound_head =3D 0;
>         int filter_pg;
>
> +       i._mapcount =3D i.compound_order =3D 0;
> +       i.private =3D i.compound_dtor =3D i.compound_head =3D 0;
> +
>         /*
>          * If a multi-page exclusion is pending, do it first
>          */
> @@ -6543,21 +6544,21 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
>                         pfn_read_end   =3D pfn + pfn_mm - 1;
>                 }
>
> -               flags   =3D ULONG(pcache + OFFSET(page.flags));
> -               _count  =3D UINT(pcache + OFFSET(page._refcount));
> -               mapping =3D ULONG(pcache + OFFSET(page.mapping));
> +               i.flags   =3D ULONG(pcache + OFFSET(page.flags));
> +               i._count  =3D UINT(pcache + OFFSET(page._refcount));
> +               i.mapping =3D ULONG(pcache + OFFSET(page.mapping));
>
>                 if (OFFSET(page._mapcount) !=3D NOT_FOUND_STRUCTURE)
> -                       _mapcount =3D UINT(pcache + OFFSET(page._mapcount=
));
> +                       i._mapcount =3D UINT(pcache + OFFSET(page._mapcou=
nt));
>
> -               compound_order =3D 0;
> -               compound_dtor =3D 0;
> +               i.compound_order =3D 0;
> +               i.compound_dtor =3D 0;
>                 /*
>                  * The last pfn of the mem_map cache must not be compound=
 head
>                  * page since all compound pages are aligned to its page =
order
>                  * and PGMM_CACHED is a power of 2.
>                  */
> -               if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags)=
) {
> +               if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(i.flag=
s)) {
>                         unsigned char *addr =3D pcache + SIZE(page);
>
>                         /*
> @@ -6567,10 +6568,10 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
>                         if (NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE) !=3D NOT_=
FOUND_NUMBER) {
>                                 unsigned long _flags_1 =3D ULONG(addr + O=
FFSET(page.flags));
>
> -                               compound_order =3D _flags_1 & 0xff;
> +                               i.compound_order =3D _flags_1 & 0xff;
>
> -                               if (_mapcount =3D=3D (int)NUMBER(PAGE_HUG=
ETLB_MAPCOUNT_VALUE))
> -                                       compound_dtor =3D IS_HUGETLB;
> +                               if (i._mapcount =3D=3D (int)NUMBER(PAGE_H=
UGETLB_MAPCOUNT_VALUE))
> +                                       i.compound_dtor =3D IS_HUGETLB;
>
>                                 goto check_order;
>                         }
> @@ -6582,19 +6583,19 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
>                         if (NUMBER(PG_hugetlb) !=3D NOT_FOUND_NUMBER) {
>                                 unsigned long _flags_1 =3D ULONG(addr + O=
FFSET(page.flags));
>
> -                               compound_order =3D _flags_1 & 0xff;
> +                               i.compound_order =3D _flags_1 & 0xff;
>
>                                 if (_flags_1 & (1UL << NUMBER(PG_hugetlb)=
))
> -                                       compound_dtor =3D IS_HUGETLB;
> +                                       i.compound_dtor =3D IS_HUGETLB;
>
>                                 goto check_order;
>                         }
>
>                         if (order_offset) {
>                                 if (info->kernel_version >=3D KERNEL_VERS=
ION(4, 16, 0))
> -                                       compound_order =3D UCHAR(addr + o=
rder_offset);
> +                                       i.compound_order =3D UCHAR(addr +=
 order_offset);
>                                 else
> -                                       compound_order =3D USHORT(addr + =
order_offset);
> +                                       i.compound_order =3D USHORT(addr =
+ order_offset);
>                         }
>
>                         if (dtor_offset) {
> @@ -6603,40 +6604,40 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
>                                  * to the ID of it since linux-4.4.
>                                  */
>                                 if (info->kernel_version >=3D KERNEL_VERS=
ION(4, 16, 0))
> -                                       compound_dtor =3D UCHAR(addr + dt=
or_offset);
> +                                       i.compound_dtor =3D UCHAR(addr + =
dtor_offset);
>                                 else if (info->kernel_version >=3D KERNEL=
_VERSION(4, 4, 0))
> -                                       compound_dtor =3D USHORT(addr + d=
tor_offset);
> +                                       i.compound_dtor =3D USHORT(addr +=
 dtor_offset);
>                                 else
> -                                       compound_dtor =3D ULONG(addr + dt=
or_offset);
> +                                       i.compound_dtor =3D ULONG(addr + =
dtor_offset);
>                         }
>  check_order:
> -                       if ((compound_order >=3D sizeof(unsigned long) * =
8)
> -                           || ((pfn & ((1UL << compound_order) - 1)) !=
=3D 0)) {
> +                       if ((i.compound_order >=3D sizeof(unsigned long) =
* 8)
> +                           || ((pfn & ((1UL << i.compound_order) - 1)) !=
=3D 0)) {
>                                 /* Invalid order */
> -                               compound_order =3D 0;
> +                               i.compound_order =3D 0;
>                         }
>                 }
>                 if (OFFSET(page.compound_head) !=3D NOT_FOUND_STRUCTURE)
> -                       compound_head =3D ULONG(pcache + OFFSET(page.comp=
ound_head));
> +                       i.compound_head =3D ULONG(pcache + OFFSET(page.co=
mpound_head));
>
>                 if (OFFSET(page.private) !=3D NOT_FOUND_STRUCTURE)
> -                       private =3D ULONG(pcache + OFFSET(page.private));
> +                       i.private =3D ULONG(pcache + OFFSET(page.private)=
);
>
> -               nr_pages =3D 1 << compound_order;
> +               nr_pages =3D 1 << i.compound_order;
>                 pfn_counter =3D NULL;
>
>                 /*
>                  * Excludable compound tail pages must have already been =
excluded by
>                  * exclude_range(), don't need to check them here.
>                  */
> -               if (compound_head & 1)
> +               if (i.compound_head & 1)
>                         continue;
>
>                 /*
>                  * Include pages that specified by user via
>                  * makedumpfile extensions
>                  */
> -               filter_pg =3D run_extension_callback(pfn, pcache);
> +               filter_pg =3D run_extension_callback(pfn, pcache, &i);
>                 if (filter_pg =3D=3D PG_INCLUDE)
>                         continue;
>
> @@ -6646,14 +6647,14 @@ check_order:
>                  */
>                 if ((info->dump_level & DL_EXCLUDE_FREE)
>                     && info->page_is_buddy
> -                   && info->page_is_buddy(flags, _mapcount, private, _co=
unt)) {
> +                   && info->page_is_buddy(i.flags, i._mapcount, i.privat=
e, i._count)) {
>                         if ((ARRAY_LENGTH(zone.free_area) !=3D NOT_FOUND_=
STRUCTURE) &&
> -                           (private >=3D ARRAY_LENGTH(zone.free_area))) =
{
> +                           (i.private >=3D ARRAY_LENGTH(zone.free_area))=
) {
>                                 MSG("WARNING: Invalid free page order: pf=
n=3D%llx, order=3D%lu, max order=3D%lu\n",
> -                                   pfn, private, ARRAY_LENGTH(zone.free_=
area) - 1);
> +                                   pfn, i.private, ARRAY_LENGTH(zone.fre=
e_area) - 1);
>                                 continue;
>                         }
> -                       nr_pages =3D 1 << private;
> +                       nr_pages =3D 1 << i.private;
>                         pfn_counter =3D &pfn_free;
>                 }
>                 /*
> @@ -6663,7 +6664,7 @@ check_order:
>                  * accepted immediately without being on the list.
>                  */
>                 else if ((info->dump_level & DL_EXCLUDE_FREE)
> -                       && isUnaccepted(_mapcount)) {
> +                       && isUnaccepted(i._mapcount)) {
>                         nr_pages =3D 1 << (ARRAY_LENGTH(zone.free_area) -=
 1);
>                         pfn_counter =3D &pfn_free;
>                 }
> @@ -6671,17 +6672,17 @@ check_order:
>                  * Exclude the non-private cache page.
>                  */
>                 else if ((info->dump_level & DL_EXCLUDE_CACHE)
> -                   && is_cache_page(flags)
> -                   && !isPrivate(flags) && !isAnon(mapping, flags, _mapc=
ount)) {
> +                   && is_cache_page(i.flags)
> +                   && !isPrivate(i.flags) && !isAnon(i.mapping, i.flags,=
 i._mapcount)) {
>                         pfn_counter =3D &pfn_cache;
>                 }
>                 /*
>                  * Exclude the cache page whether private or non-private.
>                  */
>                 else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
> -                   && is_cache_page(flags)
> -                   && !isAnon(mapping, flags, _mapcount)) {
> -                       if (isPrivate(flags))
> +                   && is_cache_page(i.flags)
> +                   && !isAnon(i.mapping, i.flags, i._mapcount)) {
> +                       if (isPrivate(i.flags))
>                                 pfn_counter =3D &pfn_cache_private;
>                         else
>                                 pfn_counter =3D &pfn_cache;
> @@ -6692,19 +6693,19 @@ check_order:
>                  *  - hugetlbfs pages
>                  */
>                 else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
> -                        && (isAnon(mapping, flags, _mapcount) || isHuget=
lb(compound_dtor))) {
> +                        && (isAnon(i.mapping, i.flags, i._mapcount) || i=
sHugetlb(i.compound_dtor))) {
>                         pfn_counter =3D &pfn_user;
>                 }
>                 /*
>                  * Exclude the hwpoison page.
>                  */
> -               else if (isHWPOISON(flags)) {
> +               else if (isHWPOISON(i.flags)) {
>                         pfn_counter =3D &pfn_hwpoison;
>                 }
>                 /*
>                  * Exclude pages that are logically offline.
>                  */
> -               else if (isOffline(flags, _mapcount)) {
> +               else if (isOffline(i.flags, i._mapcount)) {
>                         pfn_counter =3D &pfn_offline;
>                 }
>                 /*
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 4f707c7..87f973d 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1507,6 +1507,22 @@ struct ppc64_vmemmap {
>         unsigned long           virt;
>  };
>
> +/* Per-page information determined during page filtering which may be us=
eful
> + * to extensions making their decisions */
> +struct pginfo {
> +       unsigned long flags;
> +       unsigned long mapping;
> +       /* Present whenever OFFSET(page.private) !=3D NOT_FOUND_STRUCTURE=
 */
> +       unsigned long private;
> +       unsigned long compound_dtor;
> +       /* Present whenever OFFSET(page.compound_head) !=3D NOT_FOUND_STR=
UCTURE */
> +       unsigned long compound_head;
> +       unsigned int _count;
> +       /* Present whenever OFFSET(page._mapcount) !=3D NOT_FOUND_STRUCTU=
RE */
> +       unsigned int _mapcount;
> +       unsigned int compound_order;
> +};
> +
>  struct DumpInfo {
>         int32_t         kernel_version;      /* version of first kernel*/
>         struct timeval  timestamp;
> --
> 2.47.3
>


