Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2164C83F1A
	for <kexec@archiver.kernel.org>; Sun, 13 Jul 2025 23:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEVWqTJBkRJnePZ1DL43RzJQ0Ue6vxplt76lEBSQTec=; b=fbkq9m5VdBh38B1fMPOLC/Z7ua
	DFAgaZ1huyrZN42zFSC6enOFzZ9LiUFUwDOEhWTohr1kZJvEheqA4yOO/BlFVOIMNWbchhO4E9HtU
	rvtVaLCfn1mqPYYtMcGTsoaTgd2GtligfpXJq6B5ESpjBqyWiRGtO7hXgiPKfup0MoysQK8CT7xwl
	EtbgFCvabdbhFj/JGJX0sivNDx8aT0m1iztxSRE1OcyheysPzttC0/MZxAJT8vUrgns8/9nqPQ+Vx
	mvu/snleEMbfT7B7i5TTuMaxrVCiiVaKfYcmGWwIluxCkqLaOPRFW5FUAVg0JKQsDT+1G0LHcNL5C
	Pc2cSH5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub6Gt-00000000lj6-0HhT;
	Sun, 13 Jul 2025 23:38:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub6Gk-00000000li1-3uig
	for kexec@lists.infradead.org;
	Sun, 13 Jul 2025 23:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752449884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEVWqTJBkRJnePZ1DL43RzJQ0Ue6vxplt76lEBSQTec=;
	b=M3twrmYVlYGgWhmK3vq4wJYKgZTIaxiMPUeSGu5MwvxXcwuIWyiK0Yc81eMmMsutKwFtzf
	xCmwklPCB0LDfbqxnXUFJi8QF/fdJ4HBbR6igRdEc66ed+q0y0++CTS7bVvNC9dBIbhXSf
	hfvrtzkfA8yHVQqLw6wdYkLFZsofsXo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-IepAjUjjMjmAgeq6gE1Gzw-1; Sun, 13 Jul 2025 19:38:02 -0400
X-MC-Unique: IepAjUjjMjmAgeq6gE1Gzw-1
X-Mimecast-MFC-AGG-ID: IepAjUjjMjmAgeq6gE1Gzw_1752449882
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a6f6d07bb0so71609151cf.1
        for <kexec@lists.infradead.org>; Sun, 13 Jul 2025 16:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752449882; x=1753054682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEVWqTJBkRJnePZ1DL43RzJQ0Ue6vxplt76lEBSQTec=;
        b=mZ6joRZvgrhS2V4xjLnalk8pbHSKkBYxpP4BSuzeu/jegBXees208II/EfQpGHOqGD
         J5SRLDvc5AAeYsWNHNZUW/9LboNJYHFYNXluS4Shns52prYMf5QhrRMXYjlquO78F9E6
         3FlJpaa0qP4IloJlcTe05CIYkoZPXH5FLiX85W+xOAtftzWXRBDzBBMgfqjQ5s3Ej1yY
         MJdFFVxbkKJLXxJlNOkg+MY7wfdOzcq6LkWxWclOZeBWU9K8JuS2TPsPa4RuxigmyvBs
         rvuUlna0mVCrbEqWaq5nV9WHlmAQxbBMk4TxEUHZ4fUDPoUfsMXTkDkJGDnNT135BT8z
         S+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVzXltiUvV5NtHyp3QbWk/WIp3d7JB/CiO8gxThDf5UAkO23fiR2/NTc+6sQdV0R76SruZhNA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxmg0wsGsLZhdxq67l50jrIRDa3Xhq8KQiyciFmBQv9ah+/K3tC
	QAG3N235w88RS+vF7H//ZrHPjohBOdWlQ7vBBloxe+6SlwK5WPKVD/DO6nayYtUNnOaVBAeBALY
	NEvB7OisnQ/FuvB+/7a/u/HThoWfZVDrsfmA6zSepeZjAM+nz/mDIA1ueInsHvQDgQSZNu+oiaN
	JtU5xPKW8pg5XDQgJ1DzyYM/gJJN8r7IdMhxZQ
X-Gm-Gg: ASbGnct9dzi2H6z97BZ2Qb6q+oUpU0GjwGq+gWyXcW78/0LCXeVzz6t9kmWJx3nwJyA
	dOg3iXcc+ebAchOdq1ViZWWci6ZwX655EORuy6wpugHBCsosEqPlBWbuy23j68lAE9+xyBD5Lkb
	GqWkR83wfh0+KA96tw/doyeA==
X-Received: by 2002:a05:622a:102:b0:4a9:e276:2fcc with SMTP id d75a77b69052e-4aa35eac44dmr159597261cf.25.1752449882004;
        Sun, 13 Jul 2025 16:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6lV/4KlgsBwqO0Oo5DstW2GXvM1e01ZYwJCPEn7nhskDp9QTC0TWbg8QdxaiaKbHbCUao5LgA0A+WIfl5v+M=
X-Received: by 2002:a05:622a:102:b0:4a9:e276:2fcc with SMTP id
 d75a77b69052e-4aa35eac44dmr159597061cf.25.1752449881584; Sun, 13 Jul 2025
 16:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <20250703163100.603f59f4@mordecai.tesarici.cz> <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
 <8485b4f1-1277-45ab-b533-efc20120b26e@nec.com> <CAO7dBbWyCJzW14yh25V5xQbdd=Jv2kSzqogXcKCPzE+cp1wv2A@mail.gmail.com>
 <CAO7dBbVanh9oJT_PaMWZ7+3V5Bx2iz7CRNxyGSxfSsfZ5wFv2g@mail.gmail.com> <004de18c-263a-405d-9d5a-e83d4c391df7@nec.com>
In-Reply-To: <004de18c-263a-405d-9d5a-e83d4c391df7@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 14 Jul 2025 11:37:25 +1200
X-Gm-Features: Ac12FXxZ7tdvUljJ3CFQa5bIoCDS7cWroKCQ95vEqMbCtfzXEm90htFBHONOXoY
Message-ID: <CAO7dBbV40bRtn8XOFSR05FKFpMWwZ0T5fK=D9b7eVTEQV-WNmA@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	Petr Tesarik <ptesarik@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b7xQi42tI-TEbCv9KqtrXghoTi4fl0ZCj6kRUVA-xfQ_1752449882
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250713_163807_042777_D296BEEE 
X-CRM114-Status: GOOD (  36.57  )
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

Hi YAMAZAKI,

On Sat, Jul 12, 2025 at 12:08=E2=80=AFAM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> Sorry, I'm so rate.

No worries :)
>
> I looked into the fix and I think it will work safely on other
> architectures as well. I think it will also solve the problem
> with ppc64. I accept and merge this patch.
>
> Thank you for reporting this problem and providing the very
> difficult fix.

Thanks for your response and merging!

Thanks,
Tao Liu

>
> Thanks,
>
> Masa
>
> On 2025/07/10 14:34, Tao Liu wrote:
> > Kindly ping...
> >
> > Sorry to interrupt, could you please merge the patch since there are
> > few bugs which depend on the backporting of this patch?
> >
> > Thanks,
> > Tao Liu
> >
> >
> > On Fri, Jul 4, 2025 at 7:51=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
> >> On Fri, Jul 4, 2025 at 6:49=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> >>> On 2025/07/04 7:35, Tao Liu wrote:
> >>>> Hi Petr,
> >>>>
> >>>> On Fri, Jul 4, 2025 at 2:31=E2=80=AFAM Petr Tesarik <ptesarik@suse.c=
om> wrote:
> >>>>> On Tue, 1 Jul 2025 19:59:53 +1200
> >>>>> Tao Liu <ltao@redhat.com> wrote:
> >>>>>
> >>>>>> Hi Kazu,
> >>>>>>
> >>>>>> Thanks for your comments!
> >>>>>>
> >>>>>> On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=
=B0=BE=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> >>>>>>> Hi Tao,
> >>>>>>>
> >>>>>>> thank you for the patch.
> >>>>>>>
> >>>>>>> On 2025/06/25 11:23, Tao Liu wrote:
> >>>>>>>> A vmcore corrupt issue has been noticed in powerpc arch [1]. It =
can be
> >>>>>>>> reproduced with upstream makedumpfile.
> >>>>>>>>
> >>>>>>>> When analyzing the corrupt vmcore using crash, the following err=
or
> >>>>>>>> message will output:
> >>>>>>>>
> >>>>>>>>        crash: compressed kdump: uncompress failed: 0
> >>>>>>>>        crash: read error: kernel virtual address: c0001e2d2fe480=
00  type:
> >>>>>>>>        "hardirq thread_union"
> >>>>>>>>        crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> >>>>>>>>        crash: compressed kdump: uncompress failed: 0
> >>>>>>>>
> >>>>>>>> If the vmcore is generated without num-threads option, then no s=
uch
> >>>>>>>> errors are noticed.
> >>>>>>>>
> >>>>>>>> With --num-threads=3DN enabled, there will be N sub-threads crea=
ted. All
> >>>>>>>> sub-threads are producers which responsible for mm page processi=
ng, e.g.
> >>>>>>>> compression. The main thread is the consumer which responsible f=
or
> >>>>>>>> writing the compressed data into file. page_flag_buf->ready is u=
sed to
> >>>>>>>> sync main and sub-threads. When a sub-thread finishes page proce=
ssing,
> >>>>>>>> it will set ready flag to be FLAG_READY. In the meantime, main t=
hread
> >>>>>>>> looply check all threads of the ready flags, and break the loop =
when
> >>>>>>>> find FLAG_READY.
> >>>>>>> I've tried to reproduce the issue, but I couldn't on x86_64.
> >>>>>> Yes, I cannot reproduce it on x86_64 either, but the issue is very
> >>>>>> easily reproduced on ppc64 arch, which is where our QE reported.
> >>>>> Yes, this is expected. X86 implements a strongly ordered memory mod=
el,
> >>>>> so a "store-to-memory" instruction ensures that the new value is
> >>>>> immediately observed by other CPUs.
> >>>>>
> >>>>> FWIW the current code is wrong even on X86, because it does nothing=
 to
> >>>>> prevent compiler optimizations. The compiler is then allowed to reo=
rder
> >>>>> instructions so that the write to page_flag_buf->ready happens afte=
r
> >>>>> other writes; with a bit of bad scheduling luck, the consumer threa=
d
> >>>>> may see an inconsistent state (e.g. read a stale page_flag_buf->pfn=
).
> >>>>> Note that thanks to how compilers are designed (today), this issue =
is
> >>>>> more or less hypothetical. Nevertheless, the use of atomics fixes i=
t,
> >>>>> because they also serve as memory barriers.
> >>> Thank you Petr, for the information.  I was wondering whether atomic
> >>> operations might be necessary for the other members of page_flag_buf,
> >>> but it looks like they won't be necessary in this case.
> >>>
> >>> Then I was convinced that the issue would be fixed by removing the
> >>> inconsistency of page_flag_buf->ready.  And the patch tested ok, so a=
ck.
> >>>
> >> Thank you all for the patch review, patch testing and comments, these
> >> have been so helpful!
> >>
> >> Thanks,
> >> Tao Liu
> >>
> >>> Thanks,
> >>> Kazu
> >>>
> >>>> Thanks a lot for your detailed explanation, it's very helpful! I
> >>>> haven't thought of the possibility of instruction reordering and
> >>>> atomic_rw prevents the reorder.
> >>>>
> >>>> Thanks,
> >>>> Tao Liu
> >>>>
> >>>>> Petr T
> >>>>>


