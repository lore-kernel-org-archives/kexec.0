Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6883DC7EE30
	for <kexec@archiver.kernel.org>; Tue,  1 Jul 2025 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ac0hHkRO8zRmZM5N7i082fUEVQa4Hdh0WDs/nhxdaDc=; b=KShFYo8aDRmP2ZSgtjele23/Fi
	WtJUPMifnfatQfTnWqvAlS5jxMpu9b/1H5SsHQ/wP1r3t9pJ/AwjuwEWy4jYTQKPPqjONN1VY40/J
	whNtrcOAdqM2rp5VG+1CdbabB1vUzXnTwqhKJyDR+HDd8xHTcaL6R2PDF3egdVOY9Oi5iqf+N0QGM
	+Q8dR0Q07T6E9vtK526n1fHfg+e0NdMQ/3BuiaAcDiLS2TmJ540KYEbClbpyZpOEs4Poymkmdn7SU
	lO44hdyAXKk1CTuEGnCyAV2ryYm0PFIKb+/bN6t1uJqdLqC8NLZ5g+ZyNkc/6RBaCGMrtzdt/8X2V
	eTFGw02A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVwf-00000004MGr-3rci;
	Tue, 01 Jul 2025 08:02:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVur-00000004M17-300h
	for kexec@lists.infradead.org;
	Tue, 01 Jul 2025 08:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ac0hHkRO8zRmZM5N7i082fUEVQa4Hdh0WDs/nhxdaDc=;
	b=LtmBM9zmkRKdu8r/KckIQn2tv3e+/5ocaW1ix7UoJj6mM012Qo+ipojMfw6hs06yh4vdva
	03jCdaGVOcpZDFA4M60azS6RZ1mqkwcurFDK4gH2drtlRxgZQoy9LUnHkSFCHCaPH05wVr
	2GiEwk+kGyKXMiOoNCcW/XZICtFNb14=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-gFmG0qA1MF2xB5PeRm2jKQ-1; Tue, 01 Jul 2025 04:00:30 -0400
X-MC-Unique: gFmG0qA1MF2xB5PeRm2jKQ-1
X-Mimecast-MFC-AGG-ID: gFmG0qA1MF2xB5PeRm2jKQ_1751356830
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a7f2ca9536so191587981cf.2
        for <kexec@lists.infradead.org>; Tue, 01 Jul 2025 01:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356830; x=1751961630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac0hHkRO8zRmZM5N7i082fUEVQa4Hdh0WDs/nhxdaDc=;
        b=WWCBeWAnW0CWwg0e1w2GKe/9keP5pFYoJ9lrcci3tFi8E5sdMl0BHWbJEoRXqLp4PM
         hPtgfApp9AT9Nnmv47Vi4VWLGBACmHCgZ2gcUSfp3VzHfNZB/U6OAg+a9BXPaVzUK8Ty
         D2V4tVuE5T0XXfHY5SamHX8P6t7keBEfAWoPoRcQdWMIpdmUmpEPKwGUJsbZuARCasu5
         L/fBSIrrqV0TV7Lx3X5ow1x9DOV0gCJfHCeAWSnRyjgB55UdcFZcxPgF0DKzD9iy8yaR
         X2Ug4mrkr65ymj4lH/d20HSZqN5tSA8U5ULKJtlMFxBXpWF5anCm0v3GJr/mVN+G6au4
         dZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVkVWmbXv1wBfxDoBrLYPjKM3bqA8igAw0udtlCj7BXeOaEHjN6TAm+7rQdnS3nNC4uy4aQNQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxMGjTS6UbN63JWOPnfsObUQV6aDdqJOmSKBPJJHAI6dhGCHn6W
	H/oHJD81E/a2xRlnc7w6lPWuwSqM8u5IK8Muo/0EPk+AWGAi+3eYS2VePjQvls4NRBPNrI4BJ3g
	iq0zXvAp0uH35Jn9cGj7a5EStHOO+XTO+Wu8EQHtoZ4YdocFsyPxfsfz8EkhcVZFMEZh8hEhk1n
	s72vhXJx6ayGxLAkYPCze6zDmutLpoOPLbyXC1
X-Gm-Gg: ASbGncu25uXKFsLtz721S/XtlrP10Ir+LjiFplR/WbzA7QTP7O8OeL9t2y/7U7mp/u3
	mPeJ/reNc1xuUtIEKqn0cbrg0B8zIkyPRgqUhC8kybzKDR1rk8DAcqgkeqCuAiFfVbyNCxdBsb3
	2yd7rz
X-Received: by 2002:a05:622a:e:b0:4a7:f6c8:b4a1 with SMTP id d75a77b69052e-4a7fca28557mr284194791cf.19.1751356829871;
        Tue, 01 Jul 2025 01:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtGo26+N7fM5GkBap2eDMAruFIjscc55bcnzXQ8iTqpOHV3LI95FXFro9oGj/lr7wj2Wl0KBOTEmr9MF+dKvk=
X-Received: by 2002:a05:622a:e:b0:4a7:f6c8:b4a1 with SMTP id
 d75a77b69052e-4a7fca28557mr284194061cf.19.1751356829252; Tue, 01 Jul 2025
 01:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
In-Reply-To: <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 1 Jul 2025 19:59:53 +1200
X-Gm-Features: Ac12FXx0hvIoZaxGpAQ8b9uBniXSdrzxIHfb0zAIBKsJLyFYNeYfHbNBxHUMjdU
Message-ID: <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qeDPOVmgVb9cqSEwte9KOjMqLERhh-EQqzcdgu4c60w_1751356830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_010033_905055_B9F34E62 
X-CRM114-Status: GOOD (  43.28  )
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

Thanks for your comments!

On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> thank you for the patch.
>
> On 2025/06/25 11:23, Tao Liu wrote:
> > A vmcore corrupt issue has been noticed in powerpc arch [1]. It can be
> > reproduced with upstream makedumpfile.
> >
> > When analyzing the corrupt vmcore using crash, the following error
> > message will output:
> >
> >      crash: compressed kdump: uncompress failed: 0
> >      crash: read error: kernel virtual address: c0001e2d2fe48000  type:
> >      "hardirq thread_union"
> >      crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> >      crash: compressed kdump: uncompress failed: 0
> >
> > If the vmcore is generated without num-threads option, then no such
> > errors are noticed.
> >
> > With --num-threads=3DN enabled, there will be N sub-threads created. Al=
l
> > sub-threads are producers which responsible for mm page processing, e.g=
.
> > compression. The main thread is the consumer which responsible for
> > writing the compressed data into file. page_flag_buf->ready is used to
> > sync main and sub-threads. When a sub-thread finishes page processing,
> > it will set ready flag to be FLAG_READY. In the meantime, main thread
> > looply check all threads of the ready flags, and break the loop when
> > find FLAG_READY.
>
> I've tried to reproduce the issue, but I couldn't on x86_64.

Yes, I cannot reproduce it on x86_64 either, but the issue is very
easily reproduced on ppc64 arch, which is where our QE reported.
Recently we have enabled --num-threads=3DN in rhel by default. N =3D=3D
nr_cpus in 2nd kernel, so QE noticed the issue.

>
> Do you have any possible scenario that breaks a vmcore?  I could not
> think of it only by looking at the code.

I guess the issue only been observed on ppc might be due to ppc's
memory model, multi-thread scheduling algorithm etc. I'm not an expert
on those. So I cannot give a clear explanation, sorry...

The page_flag_buf->ready is an integer that r/w by main and sub
threads simultaneously. And the assignment operation, like
page_flag_buf->ready =3D 1, might be composed of several assembly
instructions. Without atomic r/w (memory) protection, there might be
racing r/w just within the few instructions, which caused the data
inconsistency. Frankly the ppc assembly consists of more instructions
than x86_64 for the same c code, which enlarged the possibility of
data racing.

We can observe the issue without the help of crash, just compare the
binary output of vmcore generated from the same core file, and
compress it with or without --num-threads option. Then compare it with
"cmp vmcore1 vmcore2" cmdline, and cmp will output bytes differ for
the 2 vmcores, and this is unexpected.

>
> and this is just out of curiosity, is the issue reproduced with
> makedumpfile compiled with -O0 too?

Sorry, I haven't done the -O0 experiment, I can do it tomorrow and
share my findings...

Thanks,
Tao Liu

>
> Thanks,
> Kazu
>
> >
> > page_flag_buf->ready is read/write by main/sub-threads simultaneously,
> > but it is unprotected and unsafe. I have tested both mutex and atomic_r=
w
> > can fix this issue. This patch takes atomic_rw for its simplicity.
> >
> > [1]: https://github.com/makedumpfile/makedumpfile/issues/15
> >
> > Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >
> > v2 -> v1: Add error message of crash into commit log
> >
> > ---
> >   makedumpfile.c | 21 ++++++++++++++-------
> >   1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 2d3b08b..bac45c2 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -8621,7 +8621,8 @@ kdump_thread_function_cyclic(void *arg) {
> >
> >               while (buf_ready =3D=3D FALSE) {
> >                       pthread_testcancel();
> > -                     if (page_flag_buf->ready =3D=3D FLAG_READY)
> > +                     if (__atomic_load_n(&page_flag_buf->ready,
> > +                                     __ATOMIC_SEQ_CST) =3D=3D FLAG_REA=
DY)
> >                               continue;
> >
> >                       /* get next dumpable pfn */
> > @@ -8637,7 +8638,8 @@ kdump_thread_function_cyclic(void *arg) {
> >                       info->current_pfn =3D pfn + 1;
> >
> >                       page_flag_buf->pfn =3D pfn;
> > -                     page_flag_buf->ready =3D FLAG_FILLING;
> > +                     __atomic_store_n(&page_flag_buf->ready, FLAG_FILL=
ING,
> > +                                     __ATOMIC_SEQ_CST);
> >                       pthread_mutex_unlock(&info->current_pfn_mutex);
> >                       sem_post(&info->page_flag_buf_sem);
> >
> > @@ -8726,7 +8728,8 @@ kdump_thread_function_cyclic(void *arg) {
> >                       page_flag_buf->index =3D index;
> >                       buf_ready =3D TRUE;
> >   next:
> > -                     page_flag_buf->ready =3D FLAG_READY;
> > +                     __atomic_store_n(&page_flag_buf->ready, FLAG_READ=
Y,
> > +                                     __ATOMIC_SEQ_CST);
> >                       page_flag_buf =3D page_flag_buf->next;
> >
> >               }
> > @@ -8855,7 +8858,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                        * current_pfn is used for recording the value of=
 pfn when checking the pfn.
> >                        */
> >                       for (i =3D 0; i < info->num_threads; i++) {
> > -                             if (info->page_flag_buf[i]->ready =3D=3D =
FLAG_UNUSED)
> > +                             if (__atomic_load_n(&info->page_flag_buf[=
i]->ready,
> > +                                             __ATOMIC_SEQ_CST) =3D=3D =
FLAG_UNUSED)
> >                                       continue;
> >                               temp_pfn =3D info->page_flag_buf[i]->pfn;
> >
> > @@ -8863,7 +8867,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                                * count how many threads have reached th=
e end.
> >                                */
> >                               if (temp_pfn >=3D end_pfn) {
> > -                                     info->page_flag_buf[i]->ready =3D=
 FLAG_UNUSED;
> > +                                     __atomic_store_n(&info->page_flag=
_buf[i]->ready,
> > +                                             FLAG_UNUSED, __ATOMIC_SEQ=
_CST);
> >                                       end_count++;
> >                                       continue;
> >                               }
> > @@ -8885,7 +8890,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                        * If the page_flag_buf is not ready, the pfn rec=
orded may be changed.
> >                        * So we should recheck.
> >                        */
> > -                     if (info->page_flag_buf[consuming]->ready !=3D FL=
AG_READY) {
> > +                     if (__atomic_load_n(&info->page_flag_buf[consumin=
g]->ready,
> > +                                     __ATOMIC_SEQ_CST) !=3D FLAG_READY=
) {
> >                               clock_gettime(CLOCK_MONOTONIC, &new);
> >                               if (new.tv_sec - last.tv_sec > WAIT_TIME)=
 {
> >                                       ERRMSG("Can't get data of pfn.\n"=
);
> > @@ -8927,7 +8933,8 @@ write_kdump_pages_parallel_cyclic(struct cache_da=
ta *cd_header,
> >                               goto out;
> >                       page_data_buf[index].used =3D FALSE;
> >               }
> > -             info->page_flag_buf[consuming]->ready =3D FLAG_UNUSED;
> > +             __atomic_store_n(&info->page_flag_buf[consuming]->ready,
> > +                             FLAG_UNUSED, __ATOMIC_SEQ_CST);
> >               info->page_flag_buf[consuming] =3D info->page_flag_buf[co=
nsuming]->next;
> >       }
> >   finish:


