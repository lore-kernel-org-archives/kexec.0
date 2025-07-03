Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4377C83030
	for <kexec@archiver.kernel.org>; Thu,  3 Jul 2025 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rWHYxLyrdExhTVfwgxsHb92e10ja3yGj6UeqAJGabEc=; b=CQTD4AggY/gUQmh4XKon5xhenD
	5yNPdjMF8s2nD96NpZznt7ilU8pvCitD5Tu/Uq9oqclK5JwzCEzaB+vYDqaogjE7C61cz1pfEwo7M
	rhbOQuJUJcuPm84sAuFBbPXGQyas9gI+dwkbXQfsWC8ieJUap76CtAtgeH60kxjtNwKL2PQq8Q6i+
	BLtzWQJ3JtrjarsdMJ+Cm0ByMf+mF/S3oDhN56ycBGjHK36hyxelcUnKQDfMprzg1YOgIyTm3kXtB
	3WDL6TGJ7V48Nzs5BDDagm5ZD4rsJEeGw9PP0gJKW161Ohhoqq3A9+pScVXuqzH03ALk1MIerNaXK
	R4UlA9OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXTXo-0000000Cqk4-0SiR;
	Thu, 03 Jul 2025 23:40:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXSXF-0000000Ck07-3T2O
	for kexec@lists.infradead.org;
	Thu, 03 Jul 2025 22:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751582163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWHYxLyrdExhTVfwgxsHb92e10ja3yGj6UeqAJGabEc=;
	b=AF21DQqemwOusrWRVPSk+vJJmZwWGaDXGy/pkmEiQuTz/qL9Vqqkvljo7Z+0Unh+9PIK9Y
	NUAH9ACrXmDdE5aeofV0CN9Q+nh0uwdQovpbHWVv4hRp9WqgVwrbxYUOUkXCHVuEaRGVT7
	FIaU4ylJRVIKhzXjahWwQantbz0jzmk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-YYL7sLvnM_m_gjgVFRGvXQ-1; Thu, 03 Jul 2025 18:35:57 -0400
X-MC-Unique: YYL7sLvnM_m_gjgVFRGvXQ-1
X-Mimecast-MFC-AGG-ID: YYL7sLvnM_m_gjgVFRGvXQ_1751582157
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a585dc5f6aso5751981cf.3
        for <kexec@lists.infradead.org>; Thu, 03 Jul 2025 15:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751582157; x=1752186957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWHYxLyrdExhTVfwgxsHb92e10ja3yGj6UeqAJGabEc=;
        b=SQqnEPilD7ANsmjs+zbHYUCP0p3ytpQzpeVT34xMT+1nhZ0twqNzSHLONIM6rNmVja
         gkw99NzRYgb7AebzskQtD407yZYAjxI3d1v/DNKneyrjaQTi++VP364mSQOalZAC8CNg
         iGaXTd82F5c0VnVgkrvl7eM+2OfekVMzvA73Amsju3zWo5hpbX6aHZ0HKP+pBP9/XXQt
         AcUYkOCOpfGLwyQ1u8N0NOvvFIfkbgm8PpQxteToxf+W8ogtR2b2AXd1JSIEAL6LI34C
         B5NjGNMTrzlaBy3n2kB6AcljNk2H4OLhX2GocB83iGkZnhTmZ8U8DExyOsfGATquHk1B
         nwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxJVrb3PkqGGlwWVkNM1Tx5XOfKDjCpIhn6FZ3vilgNN0ggVtxPKtQrAZjDmkvpXGfhnnc8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvPGjd9S+8+34NBK21DBCtn+JujSfeBcePWlgg1kUBZqLkF/sD
	EalPQ0/FrR4kB7cGQyZD7RIxzGp2hQHkrHdML+2PsBPoUWE4N6eophq8s3kd6SwyGl2EXMNkwM9
	NTC13bL+YHi6ZZC4HZlYe6KO36bYFmlEbLP9AK4cir2/6NwbVLJV2Et8OmmtR6xk6uOmhw38Vow
	QdZ2JL6BORcCuNdufXyt9zMGP2fNK0eN+EDtWk
X-Gm-Gg: ASbGncsBLheFJsWTqiIiLidLdXs/X8QnIfSbuM4xtmsds5LNa2Y21Zl6DOgr14N7gLd
	e+IZSC+59EDJWy1kHEjstTItCMiIm/7ayv6qM4RgtPSMgeMvJ7dU2ThJXpei0fAv9C+RRqEdQMA
	vbUcc=
X-Received: by 2002:a05:622a:130c:b0:4a3:d015:38be with SMTP id d75a77b69052e-4a996507eaemr5854651cf.25.1751582156833;
        Thu, 03 Jul 2025 15:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKgy0tvh7I95cuEFBinOF/fpzpcdcb7H+HEFPLGn6h16vFcHWkZP5bTcMCS1lphCOO0exd7fGanJIG7TjJmQk=
X-Received: by 2002:a05:622a:130c:b0:4a3:d015:38be with SMTP id
 d75a77b69052e-4a996507eaemr5854371cf.25.1751582156458; Thu, 03 Jul 2025
 15:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com> <20250703163100.603f59f4@mordecai.tesarici.cz>
In-Reply-To: <20250703163100.603f59f4@mordecai.tesarici.cz>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 4 Jul 2025 10:35:20 +1200
X-Gm-Features: Ac12FXwT-mIGHB2S-RwxGJFgBua6xs3xyryYyuqSHakim348Fv-U_eDL_W2cL2I
Message-ID: <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: Petr Tesarik <ptesarik@suse.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J-PJyQ_SdTL1u3bv5WqXCKeHVHJC_bDiEjEfs4oVTl0_1751582157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_153605_936633_4A76A30E 
X-CRM114-Status: GOOD (  31.18  )
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

Hi Petr,

On Fri, Jul 4, 2025 at 2:31=E2=80=AFAM Petr Tesarik <ptesarik@suse.com> wro=
te:
>
> On Tue, 1 Jul 2025 19:59:53 +1200
> Tao Liu <ltao@redhat.com> wrote:
>
> > Hi Kazu,
> >
> > Thanks for your comments!
> >
> > On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> > >
> > > Hi Tao,
> > >
> > > thank you for the patch.
> > >
> > > On 2025/06/25 11:23, Tao Liu wrote:
> > > > A vmcore corrupt issue has been noticed in powerpc arch [1]. It can=
 be
> > > > reproduced with upstream makedumpfile.
> > > >
> > > > When analyzing the corrupt vmcore using crash, the following error
> > > > message will output:
> > > >
> > > >      crash: compressed kdump: uncompress failed: 0
> > > >      crash: read error: kernel virtual address: c0001e2d2fe48000  t=
ype:
> > > >      "hardirq thread_union"
> > > >      crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> > > >      crash: compressed kdump: uncompress failed: 0
> > > >
> > > > If the vmcore is generated without num-threads option, then no such
> > > > errors are noticed.
> > > >
> > > > With --num-threads=3DN enabled, there will be N sub-threads created=
. All
> > > > sub-threads are producers which responsible for mm page processing,=
 e.g.
> > > > compression. The main thread is the consumer which responsible for
> > > > writing the compressed data into file. page_flag_buf->ready is used=
 to
> > > > sync main and sub-threads. When a sub-thread finishes page processi=
ng,
> > > > it will set ready flag to be FLAG_READY. In the meantime, main thre=
ad
> > > > looply check all threads of the ready flags, and break the loop whe=
n
> > > > find FLAG_READY.
> > >
> > > I've tried to reproduce the issue, but I couldn't on x86_64.
> >
> > Yes, I cannot reproduce it on x86_64 either, but the issue is very
> > easily reproduced on ppc64 arch, which is where our QE reported.
>
> Yes, this is expected. X86 implements a strongly ordered memory model,
> so a "store-to-memory" instruction ensures that the new value is
> immediately observed by other CPUs.
>
> FWIW the current code is wrong even on X86, because it does nothing to
> prevent compiler optimizations. The compiler is then allowed to reorder
> instructions so that the write to page_flag_buf->ready happens after
> other writes; with a bit of bad scheduling luck, the consumer thread
> may see an inconsistent state (e.g. read a stale page_flag_buf->pfn).
> Note that thanks to how compilers are designed (today), this issue is
> more or less hypothetical. Nevertheless, the use of atomics fixes it,
> because they also serve as memory barriers.

Thanks a lot for your detailed explanation, it's very helpful! I
haven't thought of the possibility of instruction reordering and
atomic_rw prevents the reorder.

Thanks,
Tao Liu

>
> Petr T
>


