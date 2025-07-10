Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A641C83F1A
	for <kexec@archiver.kernel.org>; Thu, 10 Jul 2025 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35mYSSDQTZCjXO5BpbKAdW4AFk8ffTBJb0VjaMU/GbQ=; b=qypZNXKdRJCliZupkIcc1Adh1R
	Q2zBSepPVsMINxYyxPZhpDGNVpPGoFf0Ae8sKACLvIy4MmZSYgFHBjv1QvRwSzOiQZ6XtZvT6vamq
	c6a1s66ZRl8JlfAyBBXDaOIgnBDafRN3PgJOuM3NEY7HgnzuNUID/c/L8RdZjtUHFoMD+nvV5SVTz
	Nfj8thUq+yUVTH1HN6kTPBxjsoXjTrGM2m2+T9HAgBSI90LavB9tnekJlIC3V/G/S7skX30hWmYot
	+bwNRgxnfI29wWH3Nh5sDxmR6sjUvBSKHhLwHtA9919cB4/LzxJ/y/fb9K0onUJlsuDHwrRbmF9Og
	t2sP/avA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZk5T-0000000AkKJ-3bu8;
	Thu, 10 Jul 2025 05:44:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZjwB-0000000Ajcf-2Q4C
	for kexec@lists.infradead.org;
	Thu, 10 Jul 2025 05:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752125713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35mYSSDQTZCjXO5BpbKAdW4AFk8ffTBJb0VjaMU/GbQ=;
	b=F2lSio34iCNdoFEkYRcW9+ZdBH/Z8hUJg8GTiMSQ+0N7Uf0lk7vXcF8xkpHqli4Eecy+7U
	jV7L4UH/uYiGdoqKubwZIyH5HWnruaW2RJMNaUyu3/il1w2KADimj9BZsmVKCsAy1188qS
	FOXDBFMKrNPcA6jx0wShLd+wuFD10jA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-HnbnQnPrMhe2sPeNJAhNHA-1; Thu, 10 Jul 2025 01:35:12 -0400
X-MC-Unique: HnbnQnPrMhe2sPeNJAhNHA-1
X-Mimecast-MFC-AGG-ID: HnbnQnPrMhe2sPeNJAhNHA_1752125711
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a584d0669fso12946571cf.2
        for <kexec@lists.infradead.org>; Wed, 09 Jul 2025 22:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752125711; x=1752730511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35mYSSDQTZCjXO5BpbKAdW4AFk8ffTBJb0VjaMU/GbQ=;
        b=MtcP2F2QVO50WCtHe21YnITijVxfM0qKhcGgyBJck3E1XMATGI10L44nBfrEn3JedO
         YM0+6HApdFxoLR0L39KmrvSkPge75Ydh90r9vo4k1yAyIqY0+N71AtnJ3zr9JlnN/I4u
         4nbtwM+2GqrWDyU79bE32RpsucLHdvXPfNnDOoX77u3W68RFKvL/uNPrJPLqyIL0KEKT
         71lF0yQPhkwqLg2M5hwZpBiy6WRYZQMZFXKfuyogGh4Nv4d5GuPCCqZ6pStJPWRwbk9i
         b5wGG/pfOEczOGe1nltIATZccPds7HbPY6uQieZcapQTz8BWM++9wa6bihZrZQNBHADG
         SLxw==
X-Forwarded-Encrypted: i=1; AJvYcCVKaXS78eCPhaGdrll6ZoY5nG8vWapBrIzIZhw02HBagsmM4zBXm0FnRht5JqRNGFjB1g/52g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2zbTvZy0EsAAhfzAUvLYa2Es0Gg4jZcySS2R59NnQQ4T5IgUa
	lCJ1PxxEhzsCDq6A8UP2FmLceX6ZJBjdunrXrESspZk//WNz9jL02vryDjhIn2nd/piOGhuwkMI
	soxLFsYmltRhRntnccqAm+b0e+Vw7cBeqr6TNOlcCyTKsL5A6hMi8ICCdY83j4V44S/K/hbNooS
	k32tfZroLRlcUSfNp4VAN7XKvFcbf8vg6E7ftM
X-Gm-Gg: ASbGncthUeZbCQuykt2+iFb1O72jkVxwXYccMGxmEZFaZ+088QMM61PBTbHHKfKpMB+
	MhSM7lHIqkIFrTH+NgCgw9wgJ5ZkizRicWZA7HGRjqPaUcwePxpJdMUPX0SGWO8P/IW7R/3UdA1
	xDsZ/B
X-Received: by 2002:ac8:7f08:0:b0:4a7:707b:5dec with SMTP id d75a77b69052e-4a9ded1b70dmr58384331cf.24.1752125711323;
        Wed, 09 Jul 2025 22:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaV7s6qndCTGW8ZkVgh9vInN/DNjLaTL/xgQXMX3BORNRTWvFxyTeXceiX/uhsIOnMmqKBz4it53V5gXaA0EI=
X-Received: by 2002:ac8:7f08:0:b0:4a7:707b:5dec with SMTP id
 d75a77b69052e-4a9ded1b70dmr58384161cf.24.1752125710817; Wed, 09 Jul 2025
 22:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250625022343.57529-2-ltao@redhat.com> <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <20250703163100.603f59f4@mordecai.tesarici.cz> <CAO7dBbXh86tTUyGVKn3S6Gb+qP1QYgwJt6TUPcnP5Yr6w5DYMQ@mail.gmail.com>
 <8485b4f1-1277-45ab-b533-efc20120b26e@nec.com> <CAO7dBbWyCJzW14yh25V5xQbdd=Jv2kSzqogXcKCPzE+cp1wv2A@mail.gmail.com>
In-Reply-To: <CAO7dBbWyCJzW14yh25V5xQbdd=Jv2kSzqogXcKCPzE+cp1wv2A@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 10 Jul 2025 17:34:34 +1200
X-Gm-Features: Ac12FXyhA01Am2mEExsH2pFLZ8U9b74xMTS_HcFFjVKA7Xhs2kAp1vjW5PXBjZI
Message-ID: <CAO7dBbVanh9oJT_PaMWZ7+3V5Bx2iz7CRNxyGSxfSsfZ5wFv2g@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Petr Tesarik <ptesarik@suse.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bGejVxFUfEhUjGpFOwXwhsXDhJug7DgWVGdpPdA2TjA_1752125711
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_223515_692254_00B96B4B 
X-CRM114-Status: GOOD (  38.31  )
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

Kindly ping...

Sorry to interrupt, could you please merge the patch since there are
few bugs which depend on the backporting of this patch?

Thanks,
Tao Liu


On Fri, Jul 4, 2025 at 7:51=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> On Fri, Jul 4, 2025 at 6:49=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> >
> > On 2025/07/04 7:35, Tao Liu wrote:
> > > Hi Petr,
> > >
> > > On Fri, Jul 4, 2025 at 2:31=E2=80=AFAM Petr Tesarik <ptesarik@suse.co=
m> wrote:
> > >>
> > >> On Tue, 1 Jul 2025 19:59:53 +1200
> > >> Tao Liu <ltao@redhat.com> wrote:
> > >>
> > >>> Hi Kazu,
> > >>>
> > >>> Thanks for your comments!
> > >>>
> > >>> On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=
=B0=BE=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> > >>>>
> > >>>> Hi Tao,
> > >>>>
> > >>>> thank you for the patch.
> > >>>>
> > >>>> On 2025/06/25 11:23, Tao Liu wrote:
> > >>>>> A vmcore corrupt issue has been noticed in powerpc arch [1]. It c=
an be
> > >>>>> reproduced with upstream makedumpfile.
> > >>>>>
> > >>>>> When analyzing the corrupt vmcore using crash, the following erro=
r
> > >>>>> message will output:
> > >>>>>
> > >>>>>       crash: compressed kdump: uncompress failed: 0
> > >>>>>       crash: read error: kernel virtual address: c0001e2d2fe48000=
  type:
> > >>>>>       "hardirq thread_union"
> > >>>>>       crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> > >>>>>       crash: compressed kdump: uncompress failed: 0
> > >>>>>
> > >>>>> If the vmcore is generated without num-threads option, then no su=
ch
> > >>>>> errors are noticed.
> > >>>>>
> > >>>>> With --num-threads=3DN enabled, there will be N sub-threads creat=
ed. All
> > >>>>> sub-threads are producers which responsible for mm page processin=
g, e.g.
> > >>>>> compression. The main thread is the consumer which responsible fo=
r
> > >>>>> writing the compressed data into file. page_flag_buf->ready is us=
ed to
> > >>>>> sync main and sub-threads. When a sub-thread finishes page proces=
sing,
> > >>>>> it will set ready flag to be FLAG_READY. In the meantime, main th=
read
> > >>>>> looply check all threads of the ready flags, and break the loop w=
hen
> > >>>>> find FLAG_READY.
> > >>>>
> > >>>> I've tried to reproduce the issue, but I couldn't on x86_64.
> > >>>
> > >>> Yes, I cannot reproduce it on x86_64 either, but the issue is very
> > >>> easily reproduced on ppc64 arch, which is where our QE reported.
> > >>
> > >> Yes, this is expected. X86 implements a strongly ordered memory mode=
l,
> > >> so a "store-to-memory" instruction ensures that the new value is
> > >> immediately observed by other CPUs.
> > >>
> > >> FWIW the current code is wrong even on X86, because it does nothing =
to
> > >> prevent compiler optimizations. The compiler is then allowed to reor=
der
> > >> instructions so that the write to page_flag_buf->ready happens after
> > >> other writes; with a bit of bad scheduling luck, the consumer thread
> > >> may see an inconsistent state (e.g. read a stale page_flag_buf->pfn)=
.
> > >> Note that thanks to how compilers are designed (today), this issue i=
s
> > >> more or less hypothetical. Nevertheless, the use of atomics fixes it=
,
> > >> because they also serve as memory barriers.
> >
> > Thank you Petr, for the information.  I was wondering whether atomic
> > operations might be necessary for the other members of page_flag_buf,
> > but it looks like they won't be necessary in this case.
> >
> > Then I was convinced that the issue would be fixed by removing the
> > inconsistency of page_flag_buf->ready.  And the patch tested ok, so ack=
.
> >
>
> Thank you all for the patch review, patch testing and comments, these
> have been so helpful!
>
> Thanks,
> Tao Liu
>
> > Thanks,
> > Kazu
> >
> > >
> > > Thanks a lot for your detailed explanation, it's very helpful! I
> > > haven't thought of the possibility of instruction reordering and
> > > atomic_rw prevents the reorder.
> > >
> > > Thanks,
> > > Tao Liu
> > >
> > >>
> > >> Petr T
> > >>


