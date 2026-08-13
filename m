Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26743C5CFCF
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9l+MW8QU0On2bCP1GkWUYS0HMWrosqtDjKfMfwTLJWA=; b=uzNg+1G8cfK2qa+4mq5KvUBoUZ
	5AvREiM9GbgUY1P/grLQ2psDMafrO1rUKpK8fcADLUApI/tcRPr3vQGgCUSgTkJRE9DdvTEKU2K+3
	p4MMgQJRakinWPBEy4fOqZp5YznYIpdkLb3DduKeLViO/3DsyOiwvnSkAO+XhAR/H5xSP8FcMeYRS
	OHlsASzZVHNlcTgFw0Lun6SKFBsDB5U0XxJQivFDffhrBBVv2CUqjw4gNGAnCxEXLjdR9lW8nXWEZ
	mFlveEzyaVQPigzvrDjrpaG3mu2ieXB+RgkacB/NPS9l6u9n58sMpOig6NChC7kCS/NM274qQ3kz1
	XgKoHYDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuLXp-0000000HINb-1V1R;
	Thu, 13 Aug 2026 02:51:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuLXl-0000000HIN9-2Qkr
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 02:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786589504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9l+MW8QU0On2bCP1GkWUYS0HMWrosqtDjKfMfwTLJWA=;
	b=DQUtL7DgYd4FwX21/zbl1fO4WqGZKmYAFPXhEskKAVLjT7aQDf/CVrSU6xEfo+qimGRAM9
	269V8xYJmQF3hKYWfMlkN0DXGSmgmV681j57+Q0Z0VkVAtpcKf0TiIRtldjN2k33j1JH6u
	ggyJirn8/vAokUFZUnT4bdG1csIjOsk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-iAYyuDYvPsu81I74BgYxMQ-1; Wed, 12 Aug 2026 22:51:43 -0400
X-MC-Unique: iAYyuDYvPsu81I74BgYxMQ-1
X-Mimecast-MFC-AGG-ID: iAYyuDYvPsu81I74BgYxMQ_1786589503
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so15873961cf.1
        for <kexec@lists.infradead.org>; Wed, 12 Aug 2026 19:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786589503; x=1787194303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9l+MW8QU0On2bCP1GkWUYS0HMWrosqtDjKfMfwTLJWA=;
        b=F8OKAYzyCZgmXHsOkYt1Wn5xE6kt7zMliKuBaAAt+RDr1LneVMJHXKpYOqVawoi3Is
         NumqBAELypz+7RNxOA65JUVK0I36j5cQQYUm8DCU2rjwjYQ9rmIj6eivYGilTMPuxR7Z
         3UZLXYHWmFBrKYRRnejkHMgTlmv9Yg43hm0yJiNFlsFEZD3X+QbYwrPZKW3M4OX9G3k8
         g9keJVtUz1chu0MTLnRph64eNH2/keGuXF+OkMmRXxcyylvnMvimmn1R0jBzoOzf93qj
         ZgwSEYwOvgMCXXzXnoVQ0fvMx2YuT09paUXPfUlnqufSbNuXQMecJDOyZcw0Vq/86HYQ
         s+CQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ8eSOe0R861c3QiMMY9+yu1pft+AGKMOsLZQmNFcein5dwijPnd1DQDUvDvCBGcDge/3JZA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxpIMvzJRsQMkZH7hLG2QWdNAaNxBdF044j5tA73CYtKu4kuZyC
	e0J82v2NHGF1F/oAhbE6gZlCeg9Ruh/bwh/z4OgFtH/UupIlmLDYELjTQfuQkKeKHJOXGvKe1i6
	wmhfETjfhgPcYQw3oQ3kOEpVDtQueFnhz/F2k4VuxjrVyY9oMjuf3B+41gaVQ+j2I7nO9GjsXs4
	h8LJD5aJWtziHmjwXGWItKlGI+MXQpWZDGFqHl
X-Gm-Gg: AR+sD13y9vkiCUWqlKKQushU1F+GNaUIRfYpavHsql7k2QNSSaPLtfLNpm20B5M5EC8
	TE921gSFeA9rRVx3QnvwauUJQUyI+AqO1beJ7V2fGJ2svISWi//W/wX7BHDi82fOCeWAOl8Bxyp
	u1ZanJIOZRL5jEJ1/G2QNZRG0w7RFppOAgg+/WLT9bbf0RJmKFNL+IKbg=
X-Received: by 2002:ac8:7f89:0:b0:517:307:4f1f with SMTP id d75a77b69052e-52d73dec5e9mr22666181cf.44.1786589502765;
        Wed, 12 Aug 2026 19:51:42 -0700 (PDT)
X-Received: by 2002:ac8:7f89:0:b0:517:307:4f1f with SMTP id
 d75a77b69052e-52d73dec5e9mr22665981cf.44.1786589502225; Wed, 12 Aug 2026
 19:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com> <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com> <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
 <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com>
 <404ed232-6c8e-4112-b13c-6338156476d3@nec.com> <CAO7dBbUGwSfq3VGJjYJVFSmJYAem90J3-FgVyoMWYBY9eHvx8g@mail.gmail.com>
In-Reply-To: <CAO7dBbUGwSfq3VGJjYJVFSmJYAem90J3-FgVyoMWYBY9eHvx8g@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 13 Aug 2026 14:51:04 +1200
X-Gm-Features: AUfX_mzVqVlB9Fdx_wHIcAF09apvKDJoUpZBiuX6nSP9qGCweRPNBQU2dAKiO5A
Message-ID: <CAO7dBbWSkjn+po1S9MOoyLdVGWoiiJWc2jcsYNtgrM+nzRV93g@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r4V3bfFPcIX2GDoJ2pEx-Ms_AV7KOJMMJyhYS__vse8_1786589503
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_195145_695045_31E2F7EE 
X-CRM114-Status: GOOD (  37.44  )
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

Hi Kazu & Stephen,

Please check my comments on the patchset. For the reset of the patchset, LG=
TM.

Reviewed-by: Tao Liu <ltao@redhat.com>

On Wed, Aug 12, 2026 at 5:07=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> Hi Kazu,
>
> On Wed, Aug 12, 2026 at 1:32=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
> <k-hagio-ab@nec.com> wrote:
> >
> > Hi Tao,
> >
> > On 2026/08/11 15:11, Tao Liu wrote:
> >
> > >>>>> and Tao, please check if your extension can be rebased on this
> > >>>>> patchset.  and also if you agree the extension list, please provi=
de
> > >>>>> the information.
> > >
> > > I have checked my extension to rebase on this patchset. The result is=
:
> > >
> > > 1) Rebase fails, but only due to conflicts within extensions/Makefile=
.
> > > These are small issues which would be very easy to fix.
> > > 2) Once 1 is fixed, after compile, my extension can work as expected.
> > > However this is a coincidence.  Because my extension takes callback
> > > as:
> > >
> > > int extension_callback(unsigned long pfn, const void *pcache)
> > > {
> > >          struct ft_page_info *cur =3D NULL;
> > >          return filter_page(pfn, &cur);
> > > }
> > >
> > > But this patchset changed the callback into:
> > > run_extension_callback(unsigned long pfn, const void *pcache, const
> > > struct pginfo *i)
> > >
> > > My extension works because it only takes pfn as parameter, and the
> > > handle_cbs[i]->cb() doesn't check function parameters. However, I
> > > don't think it is a major issue, once the modification on extension.c
> > > merged upstream, I can adjust the function signature of mine
> > > accordingly.
> >
> > Thank you for checking.  My main concern was the change in behavior,
> > particularly with compound pages.  If your extension works well after
> > some adjustments, that's good to hear.  I will merge the patch set late=
r.
> >
> OK, sounds good!
>
> > >
> > >>>>
> > >>>> Sure, I will check for the rebase. In the meantime, will the
> > >>>> extensions to be maintained in one repo (e.g. makedumpfile extensi=
ons
> > >>>> repo, so everyone can PR to it), or they are maintained in each of
> > >>>> individual repos, and link them under
> > >>>> https://github.com/makedumpfile/makedumpfile/wiki#extensions?
> > >>>
> > >>> I am open to either. I would be willing to co-maintain an extension=
s
> > >>> repository with Tao, for example at github.com/makedumpfile/extensi=
ons,
> > >>> so that there is a common place to contribute. That is, if this
> > >>> arrangement would work for all?
> > >>>
> > >>> If we did create a common repository, I think we'd want to set up s=
ome
> > >>> expectations on the quality & maintenance. EG, some may be marked a=
s
> > >>> "maintained" with a maintainer and a scope of maintenance (supporte=
d
> > >>> kernel versions, supported architectures, etc), and others as
> > >>> "unmaintained", where we just make sure that they build & run with
> > >>> makedumpfile, but don't validate their behavior on specific kernels=
 or
> > >>> architectures.
> > >>>
> > >>> On the other hand, if it's preferable to stay separate, then I'm ha=
ppy
> > >>> to find another place to maintain the userstack & elfheader extensi=
ons.
> > >>
> > >> I was thinking of separate repositories.  A single repository would =
be
> > >> fine, but for now I have no plans to create one within the makedumpf=
ile
> > >> organization.
> > >>
> > >> (Looking back at crash extensions, some become obsolete quickly or
> > >> have very specific functionality, making it difficult for anyone
> > >> other than the original author to maintain.  For this reason, I thin=
k
> > >> it is best for the authors themselves to manage them.)
> > >
> > > Understood, extensions are designed to address one specific issue, an=
d
> > > is easy to get outdated when makedumpfile/crash utility keeping
> > > following up the latest kernel, but extensions are often left behind
> > > due to low usage. Let's go with maintainling the extensions by each
> > > authors seperately and link them into
> > > https://github.com/makedumpfile/makedumpfile/wiki#extensions
> >
> > Thank you for your understanding.  for now, please let me know the
> > information of your extension once it's ready.
>
> Please check my extension link:
> https://github.com/liutgnu/mkdf-extension-amdgpu-mm-filtering
>
> Thanks,
> Tao Liu
> >
> > Thanks,
> > Kazu


