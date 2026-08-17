Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410DBC5DF6D
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 03:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5k3UyodMvJ3n5zhzIyE39U7yNOWoT9OWFkPtYKD00Xs=; b=ORp9UTC0MkYZwvmNyxTedqmwkz
	aGkrBmp5GYMuhNi1XFY7Nga2q/fQ6jlHpiOCmBg53B/h/B8mbjxUMZn46qemqFMa8Cf1YnP1cyQp+
	BP2WeuWOaBIBoI52SJIEKKcLA3pF9DDJocwSzyoiY4P527V8JnJkWVCJV+YfEHpc+smXkQ0JX+8oi
	b5zPx+YbTOsC0fhb7uNKp9PGegVraHFTOPnYOJQefnTPFqb+qVp09N5jsNi0iQ+mNtgJ7YuzpmBX7
	18F+G2SOks2y0lNFOLMHKHYGKXATPXHt1xwpPVfEsnvW8vYKWXah+A+mHAKTdf1JAXOKS4BYL+by1
	8tkAAp4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvoHW-00000005Nje-14Dx;
	Mon, 17 Aug 2026 03:45:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvoHT-00000005Nii-2fV7
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 03:45:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786938296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5k3UyodMvJ3n5zhzIyE39U7yNOWoT9OWFkPtYKD00Xs=;
	b=RnPRy7Wtn5tThzLNmJOt3x2oKXboACXbfkXdgKc2Rn/Sn+T9Q/xkJyywaVi5uC/7qDzq4i
	2XMP7Bns/ABB1EgqGWTQ3VBbO3adCzBqzWHlrCiOWPH/YOT/w0wz8cNjrRbddFkaIGCa+L
	eq+ccoky7IFto08imebvqX/6/ogI0eI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-YEbr_xxGOQawi8Jv16zetA-1; Sun, 16 Aug 2026 23:44:54 -0400
X-MC-Unique: YEbr_xxGOQawi8Jv16zetA-1
X-Mimecast-MFC-AGG-ID: YEbr_xxGOQawi8Jv16zetA_1786938294
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfe3fa93bso29743831cf.2
        for <kexec@lists.infradead.org>; Sun, 16 Aug 2026 20:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786938294; x=1787543094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5k3UyodMvJ3n5zhzIyE39U7yNOWoT9OWFkPtYKD00Xs=;
        b=MLUNq+wT8w9n1YmMnt6aVvenqycwwoE/LWoRYv/4TmKZuAbxP4AA1x2oRIWlREhj2G
         KAmtWIqFistBzMg97xak86XXPZ9vSpSQScDSnmgTDr/y6M9ulLRDC/dnEUoxsyYQltzc
         FEyiKGjQTJBLm82DMk1NxGb76i3UcGH0TEzHmth1Z1LJAPVixJ92G1UEn0R2cxrd4TJ5
         8zv8zqPZYPaFafHqAz03p52aiF1TQmQk/1GUj/gWLeEQv1+fkWj+yrgQLZMTNqX4vE/M
         rS6lCjUbsfSJpoh74eDvY4e/noJ933VNmQWKTK1uroCPdC0kyt2Y3rlx9voregGjBfd2
         JkOA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8DHbW+ZXYwEfleUvREolAk/R4ZzSm8z7GEC5RY1JA24GP67PcpAR/JYQHa5bK5+kW/XbNsw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzZ2fKa4hl5ZRkPtnoqL6UFwAwSU+VRgtZX6GABvGnJk60gVCyF
	LaIZX+8lfbXKxzpSJlA917+R/KP/f6hO17xdvJAHY6ZFA2C7l8mPGeIQ0/tCWkJLD8gF4u5CEKk
	Lm4KADixJE6fTUia+4Dw11GIyVC6bF+XJ+d+ytIdM15e0vZe7cF3OVIFsj76NznPira6uFXbVOY
	iLs9PHWR6oKp18T/UU2tNWYd5owJJqIPYT/RUH
X-Gm-Gg: AR+sD10BGua5qUzOFBQipWwdepFxB4hyg9yfvPAOqdw7qa5dXgm8NFWhl7CTVIp+eu5
	fu+gdYjF4RY9UWyEnMAzsB2f4JNQwF9/yADXjbnbYFZEQ/j0XrGCwAALZSXpZGtUAMaV2kT1+8s
	u1gE5PS4xoi2zBLfFB2CjFzs0Jf5wXZcDoqOP+gaoQZPObMnDi3xI0axY=
X-Received: by 2002:a05:622a:988:b0:51b:fe30:b8da with SMTP id d75a77b69052e-52d85527482mr276081911cf.33.1786938294008;
        Sun, 16 Aug 2026 20:44:54 -0700 (PDT)
X-Received: by 2002:a05:622a:988:b0:51b:fe30:b8da with SMTP id
 d75a77b69052e-52d85527482mr276081701cf.33.1786938293504; Sun, 16 Aug 2026
 20:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-5-stephen.s.brennan@oracle.com> <an0opyG2YuUD-Gez@localhost.localdomain>
 <429278f7-c1ad-4192-a9e3-9d765aa1fddf@nec.com>
In-Reply-To: <429278f7-c1ad-4192-a9e3-9d765aa1fddf@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 17 Aug 2026 15:44:15 +1200
X-Gm-Features: AcwNN1U89IiJ8C_AxfUpA8i-I1LazCz7TFOHWHQTai1M1HtqFaYQRYlu31V6UUk
Message-ID: <CAO7dBbU1AmQS6nh8OLGnB=tDw62NNsOEwodYc1_RQhP7qjteYw@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by extension
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FoRdbxJ8-QxDREHhN2IHMHxxLVHtCNE-Vk_VfNQUMUE_1786938294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_204459_764115_1E5B0C96 
X-CRM114-Status: GOOD (  40.78  )
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

Hi Kazu,

On Thu, Aug 13, 2026 at 4:54=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2026/08/13 11:15, Tao Liu wrote:
> > Hi Stephen,
> >
> > On Mon, Jul 13, 2026 at 05:45:37PM -0700, Stephen Brennan wrote:
> >> Extensions can mark pages to be excluded, but those pages may already =
be
> >> excluded due to the dump level. We have a statistic to count pages
> >> excluded by extensions. It counts only pages which were excluded becau=
se
> >> no other criteria excluded them.
> >>
> >> Extensions can mark pages to be retained, but there is no statistic to
> >> count them. Adding a counter to the code as-is would not give us the
> >> value that we care about. Just as above, pages marked for inclusion ma=
y
> >> have been included anyway due to the dump-level configuration. The mos=
t
> >> useful statistic is the one that tells us how many pages were included
> >> by the extension, which would not have been included otherwise.
> >>
> >> Introduce a statistic that counts this amount.  To do so, we have to
> >> skip the short-circuit evaluation when PG_INCLUDE is returned. This
> >> seems like a worthwhile trade-off, since the dump-level checks are all
> >> reasonably efficient.
> >>
> >> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >> ---
> >>   makedumpfile.c | 13 +++++++++++--
> >>   1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index a4c9bbf..cf6a38f 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -106,6 +106,7 @@ mdf_pfn_t pfn_elf_excluded;
> >>   mdf_pfn_t pfn_extension;
> >>
> >>   mdf_pfn_t num_dumped;
> >> +mdf_pfn_t num_extension_retained;
> >>
> >>   int retcd =3D FAILED;        /* return code */
> >>
> >> @@ -6638,8 +6639,6 @@ check_order:
> >>               * makedumpfile extensions
> >>               */
> >>              filter_pg =3D run_extension_callback(pfn, pcache, &i);
> >> -            if (filter_pg =3D=3D PG_INCLUDE)
> >> -                    continue;
> >>
> >>              /*
> >>               * Exclude the free page managed by a buddy
> >> @@ -6722,6 +6721,13 @@ check_order:
> >>              else
> >>                      continue;
> >>
> >> +            if (filter_pg =3D=3D PG_INCLUDE) {
> >> +                    /* Account pages which would have been excluded, =
but were
> >> +                     * retained by an extension. */
> >> +                    num_extension_retained +=3D nr_pages;
> >> +                    continue;
> >
> > Maybe I'm wrong, from the code we are trying to retain nr_pages, don't
> > we need to do
> >                       pfn +=3D nr_pages
> > to update the pfn of the next for-loop?
>
> Thank you for your review, Tao.
>
> The current code below does not use nr_pages to skip tail pages to be
> retained, so I think this patch's code matches this.
>
>                  /*
>                   * Unexcludable page
>                   */
>                  else
>                          continue;
>
After rethinking, I guess both ways work:

1)
if (filter_pg =3D=3D PG_INCLUDE) {
  num_extension_retained +=3D nr_pages;
  continue;
}
Then in the next for-loop, all the tail pages(for-loop nr_pages times)
will hit continue:
if (i.compound_head & 1)
  continue;
so all pages are kept within vmcore.

2)
if (filter_pg =3D=3D PG_INCLUDE) {
  num_extension_retained +=3D nr_pages;
  pfn +=3D nr_pages
  continue;
}
Then in the next for-loop, all tail pages are skiped(only for-loop 1 time).

The effect is the same, all the nr_pages are hit by continue, so all kept.

> (Retained tail pages will be skipped at compound_head check.  If we
> change this behavior, a separate patch would be preferable.)
>
> But on the other hand, if we set nr_pages to 1 when PG_EXCLUDE,
> extensions cannot exclude tail pages?
>
>                  else if (filter_pg =3D=3D PG_EXCLUDE) {
>                          nr_pages =3D 1;
>                          pfn_counter =3D &pfn_extension;

In fact, I didn't consider the case of compond pages when implementing
makedumpfile extension. My original thought was, makedumpfile pass
information of page one-by-one to extensions, allowing the extension
to decide whether to keep or discard it. Thus the filtering logic for
makedumpfile would be much simpler.

Extension however, check page type(compound page or normal page) by
itself. E.g. if it want to exclude a compond page:

makedumpfile:

for (pfn;;pfn++) {
  run_extension_callback(pfn, pcache, &i);
  ...
}

extension_call_back:
if ((check_page_type(pfn, pcache, page_info)) =3D=3D compond_page) {
    record_compond_range(pfn, pfn + nr_pages);
}
if (pfn within compond_range) {
  return PG_EXCLUDE;
}

In this way, I guess we even don't need to introduce PG_INCLUDE_HEAD
to makedumpfile, because it will be the same as PG_INCLUDE.

Thanks,
Tao Liu

>
> Thanks,
> Kazu
>
> >
> >> +            }
> >> +
> >>              /*
> >>               * Execute exclusion
> >>               */
> >> @@ -8265,6 +8271,7 @@ write_elf_pages_cyclic(struct cache_data *cd_hea=
der, struct cache_data *cd_page)
> >>      if (info->flag_cyclic) {
> >>              pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
> >>              pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
> >> +            num_extension_retained =3D 0;
> >>              pfn_memhole =3D info->max_mapnr;
> >>      }
> >>
> >> @@ -9610,6 +9617,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache=
_data *cd_header, struct cache_d
> >>               */
> >>              pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
> >>              pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
> >> +            num_extension_retained =3D 0;
> >>              pfn_memhole =3D info->max_mapnr;
> >>
> >>              /*
> >> @@ -10575,6 +10583,7 @@ print_report(void)
> >>      REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoi=
son);
> >>      REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offli=
ne);
> >>      REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_exten=
sion);
> >> +    REPORT_MSG("  Retained by extension     : 0x%016llx\n", num_exten=
sion_retained);
> >>      REPORT_MSG("  Remaining pages  : 0x%016llx\n",
> >>          pfn_original - pfn_excluded);
> >>
> > I suggest to reorder the "print_report" as follows:
> >
> > Original pages  :
> >    Excluded pages   :
> >      Pages filled with zero  :
> >      Non-private cache pages :
> >      Private cache pages     :
> >      User process data pages :
> >      Free pages              :
> >      Hwpoison pages          :
> >      Offline pages           :
> >      Extension filter pages  :
> >    Remaining pages  :
> >      Extension retain pages  :
> >
> > IMHO, this is clearer to represent "Original pages" =3D=3D "Excluded pa=
ges" + "Remaining pages";
> > and "Extension retained pages" is a subset of "Remaining pages".
> >
> > Thanks,
> > Tao Liu
> >> --
> >> 2.47.3
> >>


