Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A64C83030
	for <kexec@archiver.kernel.org>; Fri,  4 Jul 2025 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+b/+1Awjr3uarNIXswQKEMlbU41Esj72OU3CgDHfLc=; b=UW+2mROIigAsAZ+wGcUXboZadn
	dPMIePFmS19K5v1/cOvzF19th23rXIn+qZCqwLwgmPwbiE+tCvEHSZj8UbDlstZHfY186leuEpg2Y
	9Nbofz67CaGoIsocRFrJHhmyNiXtRcGnjJKuLjTBn1peLkNtB0n3AfnK/Pl1OpHJau7+gkunixbGI
	XW2MXHDxRHYgC/JdPvOcqLHNVZF4Z0DT3fgNW0OqvZY+4mz25LXFgnahWpXM8hygsX3BGprmZi5/z
	yMPDX84ZHIVoHyVr3f5NmdMXboTVw0YolxhQZ0P18AQ1478sud7n8eB/3uu2Nigx++X1yWn9/J4Yl
	GqPwRqTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXbD1-0000000Dcei-0ArX;
	Fri, 04 Jul 2025 07:51:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXbCx-0000000Dcdp-1nb1
	for kexec@lists.infradead.org;
	Fri, 04 Jul 2025 07:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751615502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+b/+1Awjr3uarNIXswQKEMlbU41Esj72OU3CgDHfLc=;
	b=WDJkyXaMPcNH2aTDAOAg4ziQK/ArOmUaZMF6RhOvgDH2/QfjIhbjZOOV9Cd5qmk5V6RqdF
	9039SBuHv/NN3puEzwV87iC4OtoUnx0Vui4xE4ik/V9P2HSVUo0Xf3ku8FHB6icT45mI3B
	fwYHFlLyKS6gww/PNPkwGrDApxCuvZk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544--5Rl3X38NceZ0FxFpJTXlg-1; Fri, 04 Jul 2025 03:51:38 -0400
X-MC-Unique: -5Rl3X38NceZ0FxFpJTXlg-1
X-Mimecast-MFC-AGG-ID: -5Rl3X38NceZ0FxFpJTXlg_1751615498
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a58813b591so12135281cf.1
        for <kexec@lists.infradead.org>; Fri, 04 Jul 2025 00:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751615498; x=1752220298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+b/+1Awjr3uarNIXswQKEMlbU41Esj72OU3CgDHfLc=;
        b=oEtHOn0Qt+megMRu1oRfVWfMb5v8PYGEXRmH2mZxNM9kkOKLktWsr56Gbu9I5S1/0q
         lrEonddi8VKyRLBs5NHmFw5zdRZgE2nZp9ycXFWQRLGz7xBYhr8CQzS9uEH0BgIgBUye
         mvHHvjj16Yr2jjnqgdOEtt8hVDNNOiYoJgECL68AUHja8lmzUWSodRKnjq4J1sZITUKo
         xpv/hlZdqhb/Z44jiJm4zJnnlRtMB2GikNZTryBMeY5+PXpqVhCiDlqLanDYgi6Gp34N
         vZPaXMQA9q4X6ARTVz3L/VnqxAfcRH9z0KhgRzsc/Ben8jpHwn/dRD3BAS444lZ6spN7
         01uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmLIBF9C7ld2/N88eqJdmGuZgKa7MPoQ7voQL/k98AhYzHoO6yFdQ4LfkkP4/tgGM0DM85g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQ+H2fui7/oYbXgwOjex3IYi2JEISQ9tlXfBoITiWMJp0gOab6
	UembbQ3lB+1+LTg/40VZjwbEAqkaeOltCcD6fbDWGbmRVSL5ozJo0XkJhaTnQamPXZlhcNaeZza
	IaVaa6gfoQaoc6Si30SApgfcPQvOWimA8OxZOdNbX5Mz+y8IPLt3Q6XSybTRZz/74MFg3DnNVLY
	LTWPS0Khkn1gLciAKQgcFNWBb2B+fZuc6Y9+Ug
X-Gm-Gg: ASbGncvkpO/Nz9omxFe2RoF8n9mQ/ojWKn8NXkaUK18gWnkBFx34d2N0K1GNtFeqEgJ
	UdSjB7Et4ov40Ubbmex2aukzvWMbVo6WMj67Evt6gC7LdR+UomM+kqRMvBUFgRrAwRaRHcDTQ5i
	XkoJ8=
X-Received: by 2002:a05:622a:2b05:b0:494:731c:8746 with SMTP id d75a77b69052e-4a994f86af1mr35473271cf.23.1751615498104;
        Fri, 04 Jul 2025 00:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDJPUXI0OZEk4vv+0IFqOW0S4CyLP8KQbG2jeQSFzxg8OiTWXdouQHBTXvoVi1rHLyqDak0UKqHTqJFRZwHjg=
X-Received: by 2002:a05:622a:2b05:b0:494:731c:8746 with SMTP id
 d75a77b69052e-4a994f86af1mr35473031cf.23.1751615497645; Fri, 04 Jul 2025
 00:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <20250703163100.603f59f4@mordecai.tesarici.cz> <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
 <8485b4f1-1277-45ab-b533-efc20120b26e@nec.com>
In-Reply-To: <8485b4f1-1277-45ab-b533-efc20120b26e@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 4 Jul 2025 19:51:01 +1200
X-Gm-Features: Ac12FXyjXZp8NQ_NX-T32W4D31LZCDA3qt0dYf9Lr96wVhUdtNYyRet62br9bSo
Message-ID: <CAO7dBbWyCJzW14yh25V5xQbdd=Jv2kSzqogXcKCPzE+cp1wv2A@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Petr Tesarik <ptesarik@suse.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 05TZBB6iK7XSIbmBl-35F0yEOPbju1RvbkEJx7WLd90_1751615498
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_005143_544824_EA640948 
X-CRM114-Status: GOOD (  32.44  )
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

On Fri, Jul 4, 2025 at 6:49=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> On 2025/07/04 7:35, Tao Liu wrote:
> > Hi Petr,
> >
> > On Fri, Jul 4, 2025 at 2:31=E2=80=AFAM Petr Tesarik <ptesarik@suse.com>=
 wrote:
> >>
> >> On Tue, 1 Jul 2025 19:59:53 +1200
> >> Tao Liu <ltao@redhat.com> wrote:
> >>
> >>> Hi Kazu,
> >>>
> >>> Thanks for your comments!
> >>>
> >>> On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> >>>>
> >>>> Hi Tao,
> >>>>
> >>>> thank you for the patch.
> >>>>
> >>>> On 2025/06/25 11:23, Tao Liu wrote:
> >>>>> A vmcore corrupt issue has been noticed in powerpc arch [1]. It can=
 be
> >>>>> reproduced with upstream makedumpfile.
> >>>>>
> >>>>> When analyzing the corrupt vmcore using crash, the following error
> >>>>> message will output:
> >>>>>
> >>>>>       crash: compressed kdump: uncompress failed: 0
> >>>>>       crash: read error: kernel virtual address: c0001e2d2fe48000  =
type:
> >>>>>       "hardirq thread_union"
> >>>>>       crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> >>>>>       crash: compressed kdump: uncompress failed: 0
> >>>>>
> >>>>> If the vmcore is generated without num-threads option, then no such
> >>>>> errors are noticed.
> >>>>>
> >>>>> With --num-threads=3DN enabled, there will be N sub-threads created=
. All
> >>>>> sub-threads are producers which responsible for mm page processing,=
 e.g.
> >>>>> compression. The main thread is the consumer which responsible for
> >>>>> writing the compressed data into file. page_flag_buf->ready is used=
 to
> >>>>> sync main and sub-threads. When a sub-thread finishes page processi=
ng,
> >>>>> it will set ready flag to be FLAG_READY. In the meantime, main thre=
ad
> >>>>> looply check all threads of the ready flags, and break the loop whe=
n
> >>>>> find FLAG_READY.
> >>>>
> >>>> I've tried to reproduce the issue, but I couldn't on x86_64.
> >>>
> >>> Yes, I cannot reproduce it on x86_64 either, but the issue is very
> >>> easily reproduced on ppc64 arch, which is where our QE reported.
> >>
> >> Yes, this is expected. X86 implements a strongly ordered memory model,
> >> so a "store-to-memory" instruction ensures that the new value is
> >> immediately observed by other CPUs.
> >>
> >> FWIW the current code is wrong even on X86, because it does nothing to
> >> prevent compiler optimizations. The compiler is then allowed to reorde=
r
> >> instructions so that the write to page_flag_buf->ready happens after
> >> other writes; with a bit of bad scheduling luck, the consumer thread
> >> may see an inconsistent state (e.g. read a stale page_flag_buf->pfn).
> >> Note that thanks to how compilers are designed (today), this issue is
> >> more or less hypothetical. Nevertheless, the use of atomics fixes it,
> >> because they also serve as memory barriers.
>
> Thank you Petr, for the information.  I was wondering whether atomic
> operations might be necessary for the other members of page_flag_buf,
> but it looks like they won't be necessary in this case.
>
> Then I was convinced that the issue would be fixed by removing the
> inconsistency of page_flag_buf->ready.  And the patch tested ok, so ack.
>

Thank you all for the patch review, patch testing and comments, these
have been so helpful!

Thanks,
Tao Liu

> Thanks,
> Kazu
>
> >
> > Thanks a lot for your detailed explanation, it's very helpful! I
> > haven't thought of the possibility of instruction reordering and
> > atomic_rw prevents the reorder.
> >
> > Thanks,
> > Tao Liu
> >
> >>
> >> Petr T
> >>


