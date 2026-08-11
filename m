Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7E8C5AC67
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 06:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q48eJ169FspfzUFSN+NCqz7w7WdSG/0Z1VaGMhXQN/k=; b=GUneh/r8s1t5p2fcCm/T8FXKrR
	L0B1jAlIzDGnDWepi/WmzWS5kPo5cE6dAOUGP9siRLNY1pq2v0s3+WfZupRLsIowOa2To9Q2ydGsH
	FNgz9JJM4ZVeA1TxKe6YA6MIri97bfSrllEbbGSf+CdjKmK8R4pphtkSQqZ5ojxa96Uao9CqYbAIu
	PQiBClaprNoW2TpRvToE11DdJBfdyZBFQY2Gl19RhOa2DRgG8O+F5xqVZZgdyXwKl6iwsjyQZGUga
	yx8RvvQNSGnrB2f78L8ajnjlLvG4XZ7i5ELGD2XHFueBTqXKu0DmGPKyNmzkRugKIfd3zIkRuD0NQ
	2u2pBAzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtfiI-0000000DOWm-2PzS;
	Tue, 11 Aug 2026 06:11:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtfiF-0000000DOUT-0bvF
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 06:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786428705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q48eJ169FspfzUFSN+NCqz7w7WdSG/0Z1VaGMhXQN/k=;
	b=h6rdBNhFDO1C+e74djXijo6A8CtZKlD4X1jzsdgNm0zKowoUoGIkvUNrKmx/X0+czhVR0w
	QGnU7K8dzp4iGWdZvOx8pvCfYeT+KXa8Zym9zdNP/DzFJb0ddi6nez4PUFsOQ4UZW/XqM3
	IFH4GR4mHU3HGZAHzR6gX9+cL3h2P0I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-_wwLJjXCOU69wf2qpdv4Rw-1; Tue, 11 Aug 2026 02:11:43 -0400
X-MC-Unique: _wwLJjXCOU69wf2qpdv4Rw-1
X-Mimecast-MFC-AGG-ID: _wwLJjXCOU69wf2qpdv4Rw_1786428703
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930edb4362dso206795285a.3
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 23:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428703; x=1787033503;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q48eJ169FspfzUFSN+NCqz7w7WdSG/0Z1VaGMhXQN/k=;
        b=fyWgPfAkNU5o0EceOqBdCvpKtcWevwXezIc9X4aadaXcXz1HksaUNnwSf9inCEw5hb
         6ploXY8DAZjz5R39a3T5PPn4tCRZAtFQUwboD+0GV/tsZqdLTNDIIGXfm4vmSF0s/IbU
         g2rMlnP9DqxeCRwFA6G9ubysP57qXMpAFJjLyecT3z9Blqk8+FGy4jD4Y8LBY/Q2YjG3
         pj4Z0MpObvEGuhfvHTjbQYmw8h4wQGeVm/tdJGZKHR4gZy5emMpFN9lnyk38NWXSz9jl
         Bg1wkILFMVFDPRj4Lv7GYcYar8PeXsNaB0QgfML3t162mhWwhTGFCO9nZQ6snrNc/Olu
         oLMA==
X-Forwarded-Encrypted: i=1; AHgh+Rqb6JR674fM4DA9iwNnjIW9LmNwfrYCRCZ3xFOUap2liLfFxx3pmK9j6dJ7DAZ1kWgx4LpIcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxwQqGafAa/OqPZwoUPfYKrY1djrY/hQW6lXHmxI6ZNMImPHKzM
	o83gIRHKf9cXjkTHEP30DsohL+PMBP3EbNbftdsnwXqSmCam82M/UEXnVQSL0Ez7Z94X83AFsuo
	QMClR5ai0m9HVFMX9fsFBeASBX8+HPyEkX1r/FN1UTV2wpSOOO8lE9c2zr3Uls9JWN3QI/tBsN3
	luos8hx8O0EqzLv6Or7TuZ3uxsC8R9yOvigN5e
X-Gm-Gg: AR+sD13vUb78kp/ABRmv4K+c3CnbbDk6+fE0ahNSEDWkPNYE4RWuZxqONUcHvOaVA9a
	Yy1yJjNsGbxah+zgrpH80Pins9Qg9g3VPsECEMMPGFhmRYRYwA6HvqONHvaP6F4n84btLm/DzF+
	LiutBamxyPxQ5Bi75g+ndPf+sBnUEh740BlCYMzT4enBmrccRT38mAmiE=
X-Received: by 2002:a05:620a:2607:b0:92e:9c65:da7b with SMTP id af79cd13be357-936a8f7a3ebmr62570385a.45.1786428702675;
        Mon, 10 Aug 2026 23:11:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2607:b0:92e:9c65:da7b with SMTP id
 af79cd13be357-936a8f7a3ebmr62568185a.45.1786428702186; Mon, 10 Aug 2026
 23:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com> <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com> <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
In-Reply-To: <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 11 Aug 2026 18:11:05 +1200
X-Gm-Features: AUfX_mzB0x9GH98CEw_zrpeHVs_XftBdwsh9ssxj6stjahXYAow8E6C8P2dFsVI
Message-ID: <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9AfwdjL2TA2bzSAXKfk2fKQk4qqQIiJ1AtTY14_9Jy0_1786428703
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_231147_257777_71E8524A 
X-CRM114-Status: GOOD (  38.61  )
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

On Sat, Aug 8, 2026 at 4:45=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> Hi Stephen, Tao,
>
> On 2026/08/08 6:24, Stephen Brennan wrote:
>
> >>> For user access, I'm thinking about adding makedumpfile extension lis=
t
> >>> to its wiki page [1].  If you agree on this, please provide their
> >>> information (extension name, author, link, description).
> >
> > Here are mine:
> >
> > - Extension Name: elfheader
> >    Author: Stephen Brennan (my email)
> >    Link: TBD - see below
> >    Description: Includes the first page of any ELF file in the page cac=
he
> >    which is mapped to userspace. This inspired by bit 4 of
> >    coredump_filter (see core(5)) for userspace core dumps. By including
> >    the header of an ELF file, it's likely that a debugger can identify
> >    its build ID and use that to find debugging information for it. This
> >    helps when used in combination with the userstack extension.
> > - Extension Name: userstack
> >    Author: Stephen Brennan (my email)
> >    Link: TBD - see below
> >    Description: Attempts to include the memory pages for each userspace
> >    thread's stack. This can make it possible to unwind userspace proces=
s
> >    stacks using a vmcore, for example with drgn's contrib/pstack.py
> >    script.
>
> Thanks, I copied this to see how it looks.
> https://github.com/makedumpfile/makedumpfile/wiki#extensions
>
> Please let me know if there are any points of concern.
>
> >>> * Could you add a description why PG_INCLUDE_HEAD is needed to the
> >>> patch 7, as we cannot add the cover letter and the patch 9.
> >>> (Text alone is ok, or you can use v2 just for the patch 7.)
> >
> > Done as a text reply to patch 7.
>
> Thanks, will use that.
>
> >>> and Tao, please check if your extension can be rebased on this
> >>> patchset.  and also if you agree the extension list, please provide
> >>> the information.

I have checked my extension to rebase on this patchset. The result is:

1) Rebase fails, but only due to conflicts within extensions/Makefile.
These are small issues which would be very easy to fix.
2) Once 1 is fixed, after compile, my extension can work as expected.
However this is a coincidence.  Because my extension takes callback
as:

int extension_callback(unsigned long pfn, const void *pcache)
{
        struct ft_page_info *cur =3D NULL;
        return filter_page(pfn, &cur);
}

But this patchset changed the callback into:
run_extension_callback(unsigned long pfn, const void *pcache, const
struct pginfo *i)

My extension works because it only takes pfn as parameter, and the
handle_cbs[i]->cb() doesn't check function parameters. However, I
don't think it is a major issue, once the modification on extension.c
merged upstream, I can adjust the function signature of mine
accordingly.

> >>
> >> Sure, I will check for the rebase. In the meantime, will the
> >> extensions to be maintained in one repo (e.g. makedumpfile extensions
> >> repo, so everyone can PR to it), or they are maintained in each of
> >> individual repos, and link them under
> >> https://github.com/makedumpfile/makedumpfile/wiki#extensions?
> >
> > I am open to either. I would be willing to co-maintain an extensions
> > repository with Tao, for example at github.com/makedumpfile/extensions,
> > so that there is a common place to contribute. That is, if this
> > arrangement would work for all?
> >
> > If we did create a common repository, I think we'd want to set up some
> > expectations on the quality & maintenance. EG, some may be marked as
> > "maintained" with a maintainer and a scope of maintenance (supported
> > kernel versions, supported architectures, etc), and others as
> > "unmaintained", where we just make sure that they build & run with
> > makedumpfile, but don't validate their behavior on specific kernels or
> > architectures.
> >
> > On the other hand, if it's preferable to stay separate, then I'm happy
> > to find another place to maintain the userstack & elfheader extensions.
>
> I was thinking of separate repositories.  A single repository would be
> fine, but for now I have no plans to create one within the makedumpfile
> organization.
>
> (Looking back at crash extensions, some become obsolete quickly or
> have very specific functionality, making it difficult for anyone
> other than the original author to maintain.  For this reason, I think
> it is best for the authors themselves to manage them.)

Understood, extensions are designed to address one specific issue, and
is easy to get outdated when makedumpfile/crash utility keeping
following up the latest kernel, but extensions are often left behind
due to low usage. Let's go with maintainling the extensions by each
authors seperately and link them into
https://github.com/makedumpfile/makedumpfile/wiki#extensions

Thanks,
Tao Liu
>
> Thanks,
> Kazu


