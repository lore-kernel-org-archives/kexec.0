Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A276C83038
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 05:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=twpWLPiC2RJ/mwJvChG6dWlstCwD8R26Q1HM724Lve8=; b=uN4G4kbk5LqPD3jbT9RLsxyXZl
	uiXZ+srBv7IoVSAhPMoqmfAD95IFdHeYMyB36Uk7uaZkxzwm+xw/P8kUfIIpRvdXCxXjBFAjBQ5h4
	9ByakzxlBEZK2rlP63aqpQPQXWFuiOVZ4ECbHav7I2tt4KxfqkTkS2g0ag/hKIouWh8nd+ntKYjDv
	FK7q0XhE9Xh5VIdKqR2wKWIW3FM28kREclpdtNy3ksac1KVqpASqyR6kW/CBa6+hcYHlewB/mbymj
	l+Xv3/SA6jVcoSVigY+lDwihVevmJ+wxw7i70KZB1TtWQVrv7G6xrBKoq838QtoHQ0uDDP9HJlEum
	weYebnBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpdO-00000007EJL-21Mp;
	Wed, 02 Jul 2025 05:03:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpdF-00000007EHJ-2n6q
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 05:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751432620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twpWLPiC2RJ/mwJvChG6dWlstCwD8R26Q1HM724Lve8=;
	b=G1Kj0TVY8UANrB+3OR09EXS3xnGN+yT7aswFHYTlSRM81B7K6KKQBHEJkPfB0JcRr+G1hC
	EljacesOSCVulERy5X4Cie+4Zhjod3wOq4Vda9NDHqs9ixrF8+eW8WVRYQnbX1514bRTAs
	4GqehHpm0AhXa1m1RLZFxxh0bffMFlg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-qqRuQzX4NfKbWn8cLLymgA-1; Wed, 02 Jul 2025 01:03:38 -0400
X-MC-Unique: qqRuQzX4NfKbWn8cLLymgA-1
X-Mimecast-MFC-AGG-ID: qqRuQzX4NfKbWn8cLLymgA_1751432618
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d399070cecso834275285a.3
        for <kexec@lists.infradead.org>; Tue, 01 Jul 2025 22:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432618; x=1752037418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twpWLPiC2RJ/mwJvChG6dWlstCwD8R26Q1HM724Lve8=;
        b=B/cv0HLeOP9qnVRUNdESnKFU+wfbF2diB5j4NCGnDABaTvD8FcQj+k3C6I97iJe+Lo
         BOXkdh5cuB/zT52/HpPekM9WH5wgEs7tbbnnGtCqRoAViyoTpY4bcf68XD0zXzBg8kFL
         RUVDmgUdjL34rJKyYswbS7Gh69f2FneME5wQBhpfXkFkdCavP9WcpToxQrhm6+Qt+k7q
         r1vIkkZMoK9D3hhqe6Gv2YaNhsqAnJrKsyySxZz7Bmcz1caYNeqenRragE4vQRuCwyNT
         HwL7TXLUbwns7ouE79WxnNw4bRtMFu5bm68MwLmWUNixrB10lUPjZzMYLUr2PyP+ERU5
         Gvfw==
X-Forwarded-Encrypted: i=1; AJvYcCWHwzX5k88qve4sKpJ2c1ecOi8koJm0s9jUTKAYwWc/CSMxbXCOe56LA7N6yuqaukBNos9Mbg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0t8tJkaX+x6iNehVgw/smwB23b9WoPzGIqk0Ue+7VlRVIolp4
	bAOsLxKkdUniShCN6PqEVDXn/ssKdxfgmo9lZi0s9XVucbBvlN+YFImvn3o/pj/G+6jUCnLHSIk
	FUp67EQ5nNpOyEsPK19UDRQplcJA1MYYKOH4lI8nlohuxxD9flFtMsZYCNVipIOGg1fjOXMsL44
	/KwPfbDvYhFveiEkTZ6rFvs0MksElSyKx8/WyK
X-Gm-Gg: ASbGncvEB0Ra7NXmR+4Ug6ocpoPFDK8081qXz3QuAneCVoKEBsnq+63RZDypnXneTeT
	r/dSNdO5zZTaERQsRuQonQ72DYb6mjuV5uRjzSpRPnKI1OJocU0yWrFODEhAE5XSxEB8IqKRbCp
	YRCzQ=
X-Received: by 2002:a05:622a:d2:b0:4a4:3d43:6e55 with SMTP id d75a77b69052e-4a9768a17a0mr28342401cf.2.1751432617685;
        Tue, 01 Jul 2025 22:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQnvbC0aUpnil9DzrfONYpsMaQHX5cgCrOLR3VcsMVlHpr+4+y8/6KX+ybfTJpx5ovsIEqplxxhxgtE4bEAnU=
X-Received: by 2002:a05:622a:d2:b0:4a4:3d43:6e55 with SMTP id
 d75a77b69052e-4a9768a17a0mr28342051cf.2.1751432617161; Tue, 01 Jul 2025
 22:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com> <CAO7dBbXweDPUpsEDYhFZqf-eAALGrFOBJh-=bQAYMUsj2ioNpw@mail.gmail.com>
 <e78c8c33-5718-4218-89a3-ea4d7e3a6c64@nec.com>
In-Reply-To: <e78c8c33-5718-4218-89a3-ea4d7e3a6c64@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 2 Jul 2025 17:03:01 +1200
X-Gm-Features: Ac12FXzC89T1FfMMPV3_uy_OAXcvsgP76yQnS-rinDDohqnH_ZoAN8rs7lU3ss4
Message-ID: <CAO7dBbW=zX15-LDE71qYMJKmm=EF-VANJ3YtK+8n92yrSOS3pA@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2sPo7DJ5C2hloM-fej8ju1CiqQjDajjpptYxorOQUVI_1751432618
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_220341_783742_FC48A556 
X-CRM114-Status: GOOD (  37.20  )
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

On Wed, Jul 2, 2025 at 4:52=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> On 2025/07/02 13:36, Tao Liu wrote:
> > Hi Kazu,
> >
> > On Wed, Jul 2, 2025 at 12:13=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81)
> > <k-hagio-ab@nec.com> wrote:
> >>
> >> On 2025/07/01 16:59, Tao Liu wrote:
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
> >>>>>        crash: compressed kdump: uncompress failed: 0
> >>>>>        crash: read error: kernel virtual address: c0001e2d2fe48000 =
 type:
> >>>>>        "hardirq thread_union"
> >>>>>        crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> >>>>>        crash: compressed kdump: uncompress failed: 0
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
> >>> Recently we have enabled --num-threads=3DN in rhel by default. N =3D=
=3D
> >>> nr_cpus in 2nd kernel, so QE noticed the issue.
> >>
> >> I see, thank you for the information.
> >>
> >>>
> >>>>
> >>>> Do you have any possible scenario that breaks a vmcore?  I could not
> >>>> think of it only by looking at the code.
> >>>
> >>> I guess the issue only been observed on ppc might be due to ppc's
> >>> memory model, multi-thread scheduling algorithm etc. I'm not an exper=
t
> >>> on those. So I cannot give a clear explanation, sorry...
> >>
> >> ok, I also don't think of how to debug this well..
> >>
> >>>
> >>> The page_flag_buf->ready is an integer that r/w by main and sub
> >>> threads simultaneously. And the assignment operation, like
> >>> page_flag_buf->ready =3D 1, might be composed of several assembly
> >>> instructions. Without atomic r/w (memory) protection, there might be
> >>> racing r/w just within the few instructions, which caused the data
> >>> inconsistency. Frankly the ppc assembly consists of more instructions
> >>> than x86_64 for the same c code, which enlarged the possibility of
> >>> data racing.
> >>>
> >>> We can observe the issue without the help of crash, just compare the
> >>> binary output of vmcore generated from the same core file, and
> >>> compress it with or without --num-threads option. Then compare it wit=
h
> >>> "cmp vmcore1 vmcore2" cmdline, and cmp will output bytes differ for
> >>> the 2 vmcores, and this is unexpected.
> >>>
> >>>>
> >>>> and this is just out of curiosity, is the issue reproduced with
> >>>> makedumpfile compiled with -O0 too?
> >>>
> >>> Sorry, I haven't done the -O0 experiment, I can do it tomorrow and
> >>> share my findings...
> >>
> >> Thanks, we have to fix this anyway, I want a clue to think about a
> >> possible scenario..
> >
> > 1) Compiled with -O2 flag:
> >
> > [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /=
tmp/out1
> > Copying data                                      : [100.0 %] /
> >     eta: 0s
> >
> > The dumpfile is saved to /tmp/out1.
> >
> > makedumpfile Completed.
> > [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D2 -=
d
> > 31 -l ~/vmcore /tmp/out2
> > Copying data                                      : [100.0 %] |
> >     eta: 0s
> > Copying data                                      : [100.0 %] \
> >     eta: 0s
> >
> > The dumpfile is saved to /tmp/out2.
> >
> > makedumpfile Completed.
> > [root@ibm-p10-01-lp45 makedumpfile]# cd /tmp
> > [root@ibm-p10-01-lp45 tmp]# cmp out1 out2
> > out1 out2 differ: byte 20786414, line 108064
> >
> > 2) Compiled with -O0 flag:
> >
> > [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /=
tmp/out3
> > Copying data                                      : [100.0 %] /
> >     eta: 0s
> >
> > The dumpfile is saved to /tmp/out3.
> >
> > makedumpfile Completed.
> > [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D2 -=
d
> > 31 -l ~/vmcore /tmp/out4
> > Copying data                                      : [100.0 %] |
> >     eta: 0s
> > Copying data                                      : [100.0 %] \
> >     eta: 0s
> >
> > The dumpfile is saved to /tmp/out4.
> >
> > makedumpfile Completed.
> > [root@ibm-p10-01-lp45 makedumpfile]# cd /tmp
> > [root@ibm-p10-01-lp45 tmp]# cmp out3 out4
> > out3 out4 differ: byte 23948282, line 151739
> >
> > Looks to me the O0/O2 have no difference for this case. If no problem,
> > the /tmp/outX generated from both single/multi thread should be
> > exactly the same, however the cmp reports there are differences. With
> > the v2 patch applied, there is no such difference:
> >
> > [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /=
tmp/out5
> > Copying data                                      : [100.0 %] /
> >     eta: 0s
> >
> > The dumpfile is saved to /tmp/out5.
> >
> > makedumpfile Completed.
> > [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D2 -=
d
> > 31 -l ~/vmcore /tmp/out6
> > Copying data                                      : [100.0 %] |
> >     eta: 0s
> > Copying data                                      : [100.0 %] \
> >     eta: 0s
> >
> > The dumpfile is saved to /tmp/out6.
> >
> > makedumpfile Completed.
> > [root@ibm-p10-01-lp45 makedumpfile]# cmp /tmp/out5 /tmp/out6
> > [root@ibm-p10-01-lp45 makedumpfile]#
>
> thank you for testing!  sorry one more thing,
> does --num-threads=3D1 break the vmcore?

Yes:

[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/=
out7
Copying data                                      : [100.0 %] /
   eta: 0s

The dumpfile is saved to /tmp/out7.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=3D1 -d
31 -l ~/vmcore /tmp/out8
Copying data                                      : [100.0 %] -
   eta: 0s
Copying data                                      : [100.0 %] /
   eta: 0s

The dumpfile is saved to /tmp/out8.

makedumpfile Completed.
[root@ibm-p10-01-lp45 makedumpfile]# cmp /tmp/out7 /tmp/out8
/tmp/out7 /tmp/out8 differ: byte 11119019, line 49418

>
> Thanks,
> Kazu


