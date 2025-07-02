Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC92EC83013
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 04:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N6sezW4FeNZzVClpoe9UqNTSyIVbrwfWdpG6HwyLqpY=; b=GrDF6R6gBxUJUKqQ6TgT2QqUYB
	+q1z3kOjWqsTc/GwMhesyZdXiWXWY2ABOm+2+j9+fV7Mgu4l7WnZNgPImD9Vg6jgGAP3He1da7LTX
	5a6HAVo+QiSn+bJ2/HnBGh5oF/3b/Yh/MzCeiYLL4N4o7j9VGSfcWgDMDKCVzAU9117OKkC4aT2GZ
	PVqlPvYuZinagJxGI/MLdfBO3M/SglYoYCDIn4aq9PJ3V+vkxKMIppCdTXD7D/enMH5syb/ycBPcI
	mEBj4bsWg97vwtCF9rZ8MmoP/MyC5XnOLKv1AaQ8cqJG32OxBQHHhcAV96esUX5EOJfNbLDkyTKJd
	Kzj7vXGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpDi-00000007BvW-2c3m;
	Wed, 02 Jul 2025 04:37:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpDf-00000007Bv6-2py4
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 04:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751431034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6sezW4FeNZzVClpoe9UqNTSyIVbrwfWdpG6HwyLqpY=;
	b=N6z5ecxHyU3ss9JV3cVI5nRl+aOMOsF3AB592PAPzROZ9iMZjzX98tBl5Z2wHrcZUZCStm
	IvyLMALtDdcpMUKCMt5KHIEaTgCda6gHblEpohjFK3jOmvE8UfcmSh5BC3y8180UrrKJp8
	OeUQjc9hlaDWbWNEH0h76eFcV+p4D+w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-kTzGrd4RPeOXqtdqwiTc_Q-1; Wed, 02 Jul 2025 00:37:12 -0400
X-MC-Unique: kTzGrd4RPeOXqtdqwiTc_Q-1
X-Mimecast-MFC-AGG-ID: kTzGrd4RPeOXqtdqwiTc_Q_1751431032
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d38c5c3130so673429485a.1
        for <kexec@lists.infradead.org>; Tue, 01 Jul 2025 21:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751431032; x=1752035832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6sezW4FeNZzVClpoe9UqNTSyIVbrwfWdpG6HwyLqpY=;
        b=a6AnKshpgN3jxutqL3f8QFZ9uRhLn1no0f+SXTMKFLiOX2FI4Si2GC2PH5fle2u1sv
         U1Y1ex7Y3q2T4QvLDL2f2ACBiC/0TcFx9zxsdYDHAeZL0+N79WKUukaysM4tryFY63P3
         jRNt+Y/+xEo0OzD2JwTViNt89WH7fwx0M8B25m7h8tous8YFWe3v6fmoFgs9Ft7cX55o
         4cplaqZBQ0P/fUX9rHs3bcPR7jVX3lfioKyRevwYDBxiHlF+Z8VzYuF1pmR5HNP0EcSz
         1I+ZQ3FaTEogoHG6CfOgfeW+me8mQ1Ib3e5hSfNH2u6Gi4UGH2RSgMFiXOCfaWyXyn6O
         9CZg==
X-Forwarded-Encrypted: i=1; AJvYcCV7d4mj59U5+qW/B3v8ufjaHbNCfx1z6cWLsGfOklE5PoWDIWMx9D/hMBpoqOpaL1z+KrCogQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzC4kc8nKR3OVsraiXKhIBdlK+AVlk2zSjyiSU+rorN6ovvVBk
	VsBluyTD9n1HTp652Ip7IlnpeyV1jZk7wTO1X7T0ZrCIEr/gXgbgQav/nQQgfbqidCSAyAjo1xj
	ue9eEitbEktK4Z4CFJRLY49GZ7rVGd1+IZSsdjKQGzPnkIC9Ug/2qF97ymrJw9HC+FEtAgku3ud
	QZp+FPeSNHXkbEucq8BDjia2RDIGU7X0Kbm17D
X-Gm-Gg: ASbGncuW5WgaufCmygB/NxCdZM+50wS1iFcOTp38d3N68KGAOYOllMho3k8CeE0Mv0w
	K2qXFu7nEbpvWdnhNvCet3ibPSpzlNCXg7NI0eNpBU+lrowhMCfFsVDwwrAiltq1JcVQLz/ixEP
	IF8Lg=
X-Received: by 2002:a05:620a:1a23:b0:7d4:512e:7c0 with SMTP id af79cd13be357-7d5c47c5ba0mr215185085a.58.1751431032079;
        Tue, 01 Jul 2025 21:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHuL8eDfXO0cOUL/g0AsXEvVLUTN9D6Q17OOkPU8rAV3FIZkAMXbmnxpYBg/0mj33CkZCSOD1LuytDvyNbsAM=
X-Received: by 2002:a05:620a:1a23:b0:7d4:512e:7c0 with SMTP id
 af79cd13be357-7d5c47c5ba0mr215183085a.58.1751431031641; Tue, 01 Jul 2025
 21:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com> <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com>
In-Reply-To: <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 2 Jul 2025 16:36:35 +1200
X-Gm-Features: Ac12FXx4pVt152N4o3NoGWnkdQLqqqNoIW0257dSM4oK9vT7D5wylVbiVJqYsLc
Message-ID: <CAO7dBbXweDPUpsEDYhFZqf-eAALGrFOBJh-=bQAYMUsj2ioNpw@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3LWwRwBqGzvVDrIQVTGVusve8oCvkLoJlNvU1eHxX0Y_1751431032
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_213715_964982_710DDB35 
X-CRM114-Status: GOOD (  39.53  )
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

On Wed, Jul 2, 2025 at 12:13=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2025/07/01 16:59, Tao Liu wrote:
> > Hi Kazu,
> >
> > Thanks for your comments!
> >
> > On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> >>
> >> Hi Tao,
> >>
> >> thank you for the patch.
> >>
> >> On 2025/06/25 11:23, Tao Liu wrote:
> >>> A vmcore corrupt issue has been noticed in powerpc arch [1]. It can b=
e
> >>> reproduced with upstream makedumpfile.
> >>>
> >>> When analyzing the corrupt vmcore using crash, the following error
> >>> message will output:
> >>>
> >>>       crash: compressed kdump: uncompress failed: 0
> >>>       crash: read error: kernel virtual address: c0001e2d2fe48000  ty=
pe:
> >>>       "hardirq thread_union"
> >>>       crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> >>>       crash: compressed kdump: uncompress failed: 0
> >>>
> >>> If the vmcore is generated without num-threads option, then no such
> >>> errors are noticed.
> >>>
> >>> With --num-threads=3DN enabled, there will be N sub-threads created. =
All
> >>> sub-threads are producers which responsible for mm page processing, e=
.g.
> >>> compression. The main thread is the consumer which responsible for
> >>> writing the compressed data into file. page_flag_buf->ready is used t=
o
> >>> sync main and sub-threads. When a sub-thread finishes page processing=
,
> >>> it will set ready flag to be FLAG_READY. In the meantime, main thread
> >>> looply check all threads of the ready flags, and break the loop when
> >>> find FLAG_READY.
> >>
> >> I've tried to reproduce the issue, but I couldn't on x86_64.
> >
> > Yes, I cannot reproduce it on x86_64 either, but the issue is very
> > easily reproduced on ppc64 arch, which is where our QE reported.
> > Recently we have enabled --num-threads=3DN in rhel by default. N =3D=3D
> > nr_cpus in 2nd kernel, so QE noticed the issue.
>
> I see, thank you for the information.
>
> >
> >>
> >> Do you have any possible scenario that breaks a vmcore?  I could not
> >> think of it only by looking at the code.
> >
> > I guess the issue only been observed on ppc might be due to ppc's
> > memory model, multi-thread scheduling algorithm etc. I'm not an expert
> > on those. So I cannot give a clear explanation, sorry...
>
> ok, I also don't think of how to debug this well..
>
> >
> > The page_flag_buf->ready is an integer that r/w by main and sub
> > threads simultaneously. And the assignment operation, like
> > page_flag_buf->ready =3D 1, might be composed of several assembly
> > instructions. Without atomic r/w (memory) protection, there might be
> > racing r/w just within the few instructions, which caused the data
> > inconsistency. Frankly the ppc assembly consists of more instructions
> > than x86_64 for the same c code, which enlarged the possibility of
> > data racing.
> >
> > We can observe the issue without the help of crash, just compare the
> > binary output of vmcore generated from the same core file, and
> > compress it with or without --num-threads option. Then compare it with
> > "cmp vmcore1 vmcore2" cmdline, and cmp will output bytes differ for
> > the 2 vmcores, and this is unexpected.
> >
> >>
> >> and this is just out of curiosity, is the issue reproduced with
> >> makedumpfile compiled with -O0 too?
> >
> > Sorry, I haven't done the -O0 experiment, I can do it tomorrow and
> > share my findings...
>
> Thanks, we have to fix this anyway, I want a clue to think about a
> possible scenario..

1) Compiled with -O2 flag:

[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/=
out1
Copying data                                      : [100.0 %] /
   eta: 0s

The dumpfile is saved to /tmp/out1.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D2 -d
31 -l ~/vmcore /tmp/out2
Copying data                                      : [100.0 %] |
   eta: 0s
Copying data                                      : [100.0 %] \
   eta: 0s

The dumpfile is saved to /tmp/out2.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# cd /tmp
[root@ibm-p10-01-lp45 tmp]# cmp out1 out2
out1 out2 differ: byte 20786414, line 108064

2) Compiled with -O0 flag:

[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/=
out3
Copying data                                      : [100.0 %] /
   eta: 0s

The dumpfile is saved to /tmp/out3.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D2 -d
31 -l ~/vmcore /tmp/out4
Copying data                                      : [100.0 %] |
   eta: 0s
Copying data                                      : [100.0 %] \
   eta: 0s

The dumpfile is saved to /tmp/out4.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# cd /tmp
[root@ibm-p10-01-lp45 tmp]# cmp out3 out4
out3 out4 differ: byte 23948282, line 151739

Looks to me the O0/O2 have no difference for this case. If no problem,
the /tmp/outX generated from both single/multi thread should be
exactly the same, however the cmp reports there are differences. With
the v2 patch applied, there is no such difference:

[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/=
out5
Copying data                                      : [100.0 %] /
   eta: 0s

The dumpfile is saved to /tmp/out5.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D2 -d
31 -l ~/vmcore /tmp/out6
Copying data                                      : [100.0 %] |
   eta: 0s
Copying data                                      : [100.0 %] \
   eta: 0s

The dumpfile is saved to /tmp/out6.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# cmp /tmp/out5 /tmp/out6
[root@ibm-p10-01-lp45 makedumpfile]#

Thanks,
Tao Liu
>
> Thanks,
> Kazu


