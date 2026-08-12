Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB3DC5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 05:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUzFaE5fpKhF087fjDfGwoqJGbt36ufyWWHRoVPGzYs=; b=U2Q2PFE4lTc9S+A/O6jlnxJi+n
	gYvWxYAvQ8Z+V7GVcrHo/V1T6N0j0XKKM/lNEFqfT6JYrli5HDVuL8QGUFjt32v9HChZ5Y0whPd1d
	HJz4WrzNbyLAyWVVFnH+tCIhhVaEPQ2t6cPmxjmV5XGgoOOjkbXR/9vskDNHbJGJwNZgF2B54QGne
	Y9ivN3fhxPCnwSHneh0/CNbVTqKIGG9QisF9xyXvQ2RZPSkFGHusbse3vGfrGmmrjzcZghBfsfKOu
	yv5O6CY3B+PZC19v8PN2KyjznTN7D5h60ZT1uXDupY90ucbjYeZDg09CB1E1ncq6BW0fpZz85itl0
	7V/VpB8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu1Bx-0000000FQ92-3QPz;
	Wed, 12 Aug 2026 05:07:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu1Bu-0000000FQ8g-3GSm
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 05:07:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786511269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUzFaE5fpKhF087fjDfGwoqJGbt36ufyWWHRoVPGzYs=;
	b=HD+1sutzXx2VQivKxe/+HaCBHeWHFBdJ68C40mQJYGDFJKOn44Qwcbjb/Xe2PRDnl8VcJB
	+WrONiWyByKBd2krcHiXjLKBsJEOwnrgD8lcuEyt1vPxf/UG6QHw/5y8wdTIgCn95dSahd
	z5J7ouhJ3VvJF2EOmfm+9BY79zfeBKk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-mbvpsX2KPcmVyOL309-vfA-1; Wed, 12 Aug 2026 01:07:42 -0400
X-MC-Unique: mbvpsX2KPcmVyOL309-vfA-1
X-Mimecast-MFC-AGG-ID: mbvpsX2KPcmVyOL309-vfA_1786511262
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so124147485a.0
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 22:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786511262; x=1787116062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUzFaE5fpKhF087fjDfGwoqJGbt36ufyWWHRoVPGzYs=;
        b=CcWN9oPmA7JznXa4mR1TIUB9nxEsW3dDNZ9n2+eVZ7w0/Usd8mEfmtbwSNrhGJH+Yr
         sjy7kBstTe4JFVv8/AoaMiUScZysLusUt7Bj2JQk9UHEFd2eJ5WZuvdVxRQ0jPJRZaZx
         voAygY5vKndAR0b1F30IfgQd9iDOvhZBYMmR+I2icBv16zTJou8NdohAFQrMrKkby6I7
         sdVkclFpH6a2b11IMFbRKB7bmomOo5FVmsgq70rHRmAbwcLMU5H9jid3cszrExf8KZFt
         BgyLDsYKZZHd7f+EgKXzR/rKCGwpfuCbI/xCinubdHi9K1fnh5tufjUo4ALXWjBx6JM8
         3jZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqH4h+ppABREFJ9Spe309qz5Yqo08NTGjU/QXRcR+CrtmVIg4ap6cou2vqZNb1eBCGZUpv3FA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5TrciJCWJRyYqnhwr6nzR+YT6UmRIXhzfHQDC1vt8tsaVmYqt
	cFWw1cv+Y7GKCxvOMBDqQyEJY4Al9DpSmwMJNo33PFMQ0wQsK7l2ucWNC9OB9nJMr1zFgFFzqtP
	dpIN043JLdkj5DMHqiXMBRJZI881x6OMptKbXSetbEknxnQ3o8p4JLWDANB49o8Z/ftaZtDEh7m
	QPtJrO/GP5R05QasBY1zyAHnVrdp84YC5rU0nB
X-Gm-Gg: AR+sD12zCYGv2e9Jk5aL61eAfRxTDfrDRqo4iC67zXuTfGekxVj5yPRNHtKhV+f1pFC
	6OCgYJOO0XLagbv310xZ6Y+BlqCHoBIuxuUo9PxnDXj//UmIZDIYCV/iJgK+SKugKrWU+XCgd1c
	j9XwgXo5mvdeC37xhsWqQHdjJqvFoLqp315pSMgFiHVFXWlFlc1jUp40o=
X-Received: by 2002:a05:620a:a202:b0:936:af32:fd7c with SMTP id af79cd13be357-936b3a3216fmr184793285a.9.1786511261871;
        Tue, 11 Aug 2026 22:07:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a202:b0:936:af32:fd7c with SMTP id
 af79cd13be357-936b3a3216fmr184790885a.9.1786511261453; Tue, 11 Aug 2026
 22:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com> <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com> <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
 <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com> <404ed232-6c8e-4112-b13c-6338156476d3@nec.com>
In-Reply-To: <404ed232-6c8e-4112-b13c-6338156476d3@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 12 Aug 2026 17:07:05 +1200
X-Gm-Features: AUfX_mz6AkQM-f7RMOdJPWClgiMJiy55wrs4Vhov3Ba5KZ3RXwU6-ru8ocpdpDo
Message-ID: <CAO7dBbUGwSfq3VGJjYJVFSmJYAem90J3-FgVyoMWYBY9eHvx8g@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i1Bvqlep_LBE3O6_M0U-nmjiACIPumOoPaIAc9MzIS8_1786511262
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_220750_901774_C3887A83 
X-CRM114-Status: GOOD (  33.81  )
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

On Wed, Aug 12, 2026 at 1:32=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> On 2026/08/11 15:11, Tao Liu wrote:
>
> >>>>> and Tao, please check if your extension can be rebased on this
> >>>>> patchset.  and also if you agree the extension list, please provide
> >>>>> the information.
> >
> > I have checked my extension to rebase on this patchset. The result is:
> >
> > 1) Rebase fails, but only due to conflicts within extensions/Makefile.
> > These are small issues which would be very easy to fix.
> > 2) Once 1 is fixed, after compile, my extension can work as expected.
> > However this is a coincidence.  Because my extension takes callback
> > as:
> >
> > int extension_callback(unsigned long pfn, const void *pcache)
> > {
> >          struct ft_page_info *cur =3D NULL;
> >          return filter_page(pfn, &cur);
> > }
> >
> > But this patchset changed the callback into:
> > run_extension_callback(unsigned long pfn, const void *pcache, const
> > struct pginfo *i)
> >
> > My extension works because it only takes pfn as parameter, and the
> > handle_cbs[i]->cb() doesn't check function parameters. However, I
> > don't think it is a major issue, once the modification on extension.c
> > merged upstream, I can adjust the function signature of mine
> > accordingly.
>
> Thank you for checking.  My main concern was the change in behavior,
> particularly with compound pages.  If your extension works well after
> some adjustments, that's good to hear.  I will merge the patch set later.
>
OK, sounds good!

> >
> >>>>
> >>>> Sure, I will check for the rebase. In the meantime, will the
> >>>> extensions to be maintained in one repo (e.g. makedumpfile extension=
s
> >>>> repo, so everyone can PR to it), or they are maintained in each of
> >>>> individual repos, and link them under
> >>>> https://github.com/makedumpfile/makedumpfile/wiki#extensions?
> >>>
> >>> I am open to either. I would be willing to co-maintain an extensions
> >>> repository with Tao, for example at github.com/makedumpfile/extension=
s,
> >>> so that there is a common place to contribute. That is, if this
> >>> arrangement would work for all?
> >>>
> >>> If we did create a common repository, I think we'd want to set up som=
e
> >>> expectations on the quality & maintenance. EG, some may be marked as
> >>> "maintained" with a maintainer and a scope of maintenance (supported
> >>> kernel versions, supported architectures, etc), and others as
> >>> "unmaintained", where we just make sure that they build & run with
> >>> makedumpfile, but don't validate their behavior on specific kernels o=
r
> >>> architectures.
> >>>
> >>> On the other hand, if it's preferable to stay separate, then I'm happ=
y
> >>> to find another place to maintain the userstack & elfheader extension=
s.
> >>
> >> I was thinking of separate repositories.  A single repository would be
> >> fine, but for now I have no plans to create one within the makedumpfil=
e
> >> organization.
> >>
> >> (Looking back at crash extensions, some become obsolete quickly or
> >> have very specific functionality, making it difficult for anyone
> >> other than the original author to maintain.  For this reason, I think
> >> it is best for the authors themselves to manage them.)
> >
> > Understood, extensions are designed to address one specific issue, and
> > is easy to get outdated when makedumpfile/crash utility keeping
> > following up the latest kernel, but extensions are often left behind
> > due to low usage. Let's go with maintainling the extensions by each
> > authors seperately and link them into
> > https://github.com/makedumpfile/makedumpfile/wiki#extensions
>
> Thank you for your understanding.  for now, please let me know the
> information of your extension once it's ready.

Please check my extension link:
https://github.com/liutgnu/mkdf-extension-amdgpu-mm-filtering

Thanks,
Tao Liu
>
> Thanks,
> Kazu


