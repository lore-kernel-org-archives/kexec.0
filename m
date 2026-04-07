Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0890EFF5126
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 16:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D08YF3C7gaIOrt/KDm0mueNU5cX5u2VSKpuLteAqV1k=; b=GdYFslcWK46bq6mnmwbh5fEqZR
	B5QZYGOWcKhr7NRGCtXx919nNECj5BAM69Teo+ZNv8wociNYIM0SRATzWAPRqfW8+wTeLbqIqJkPb
	Qryox/MFTPeBqO55c9BT7Fq5y6cP2bvT+P3k0OiEjnAhyEXNMerV4BdJlY49b6AMBXm0ZgnfPjA50
	Q7OE+Nyry1MhZvUx2B9b7nx3PvdTwwd1H7nmh0xJ8VQWLVGPsg5kynBSoH99QFuJNoCKf18MBZBw+
	AVrOpGDUYh58eGVgxcrkyw0iFttqKNUctxTbhM1t004vNvA3WKiKBP0smE2wY38qzkyNqzdzRw/gC
	kQMEiZEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9MJ-00000006nuS-0ePr;
	Tue, 07 Apr 2026 16:32:59 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9MG-00000006ntq-1yF1
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 16:32:57 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-66f916529d5so148718a12.3
        for <kexec@lists.infradead.org>; Tue, 07 Apr 2026 09:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775579574; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2nTeDIpBhovmz3wGC+092GfsaMXB1gERAvLIjlPAUoHihLutb6eSA0aV/53NNDz64
         xxGPs9zzbZS95Z5haymwiilnQwYpZzpin7lEz/kXef4HIlyqaxWHQnO3WHyA0cNrgOa/
         +9/0mD4KhpR2UZAnNYLLY8huW4hjjgPRFoDh5dt8JkeQLi45VwbaXIw5v/4WE8szznxV
         KrRTrQPxqEIyOESND22OY5xvked35/zvnfAK46lC0iWGFfO+TD/AbazwKavbGu0xacla
         MOtPqGMS/xLAX5HxpDiuX9SXfd+zy7NqmXVaPC0an1TsYbpI+fJn0UILDuZOv1UKUSXZ
         cpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D08YF3C7gaIOrt/KDm0mueNU5cX5u2VSKpuLteAqV1k=;
        fh=sZ1b5pveaYAmvDsgXA1n1NqhWN1MEs/XMXA9SmqUTYw=;
        b=PncxpA6RpJ56TbN+98GArFYLw85SoJqGnQCg91rQERFJcbTwbm/XSAw58V4E2o44iX
         VHM6dwEdcL+m5kRsYuXzKR2KXJShnOdk0Q/O3kc8rBowOS9E/NYTRhm4Uth19cz1XX6C
         eDNWVjYlHUdftveEBx/SShN4MWOmlAZZ4Mz4tjP3mMvjZeutbS/75ew6TCivOJ7hZRVM
         qBz83VM15j96N+7J1LRXX9x+pihdDNKjhQN495xmSClm/2qrxrEQ4KZA5iwqGWQkrjyK
         9MIudBAwtj7t5cZURO1CyFkfxeq6K0E3jUyMm/GlEb8JL7d+Pi+bG/lTRYiqQM+DjSFs
         QATA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1775579574; x=1776184374; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D08YF3C7gaIOrt/KDm0mueNU5cX5u2VSKpuLteAqV1k=;
        b=STqdAXlhdYLxGEBeUVbZz3ScX/TuUKj/MQDsgnvG5CZaF9HQEUd6Oo7tiOi5cEL6DB
         JQXcSDs2FA4SegongVU9PHTImmk0zgdUW9g78Okya/cbfctCwnTQAyERbaH0EHtGlmKC
         SmTKg2dSUyG6wSLA+bY3h7XRQyUkIwBzzBOq4x4cQOcBxD71dzMqqj7VItJluL02d+3m
         f4UTt9dY6Gjw3GZGcsoorZ+2+/cPyPKKaA9cTNGdhXplXvdoLWPikLTHtWsspT/eC+x6
         Oc+s32R9zqZPlGLJtTOjzl73KE9XCvystylADG0l3KbyknVjlt5MsPYhKDJFesmL4bU3
         J5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579574; x=1776184374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D08YF3C7gaIOrt/KDm0mueNU5cX5u2VSKpuLteAqV1k=;
        b=lzodn8wFtBHFQrFbqYneIEik3hf4QMbfQMLef125F59OcW9AmkUW6lTRAdIZ3hLOh7
         GyJ9dMxjoX3/X/hvpuidwugJNOjfePpbBOHAT6MW26u6XNHFjmK+V78869Tfzasxn3t3
         8HuGL+UTEqYxkr1KHilXZ28FtI2Enehllie2YfooxsQNg88g3XOFyErGhahYCU6dyPab
         FWqkG7LWLAzEiq+isZ3dxudXQdeR2TRI0vVc4zeuNLU8fuIycQVBUeSuJwpf+XyDA3aW
         MtVafi2GnVqZSnHe/gxIB0vC8rZfq3GBJ/3V6wNJmApGuvJlVLfa6zfNFC+B+qyXlfr/
         Nulw==
X-Forwarded-Encrypted: i=1; AJvYcCVXBG0vuKHrrLX+LrxgMjACujke25LSnp8y+gcEV+fpz2rWqQLdvuzbGdhuj7yR8eHc6jBquw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJVDA91dInX5kiykVKoX3BjID232BxqezGgYMIZvLwhZmx8Pn4
	xF2IsicnM/ROadRS3ckdUs8irsUoHdGM+xLna8iZADw+BkkjOJYnv8mU/jr03cv50Y7DQu2ce/O
	rsWrrilaIK5Lbzxw8iYsxTFQrK2hQZyvpeQOa0jsDww==
X-Gm-Gg: AeBDieuTDrumVr+ogP1lAHMF+l94ya6SKHXdum96kMQVV7mMXh///Vsu1jFMzVmZpPA
	TrqpVDd1vHd16uZu9e/qssoyLvCtTuDtnKFAIMBeVntML9ZgXVZpFWAP5sbNxXRsFtfFm2jbtWZ
	UOaopFH+kbFwEiGz7Vtew2SCzmunqc0dIRbSFtNSsjuovSAURYoT8DK3AQvnzCuJt6gWFQfYrRV
	TnUZWvBZWAYv7IIDmTyD7NGGaGS30BgQJNmxbff8PLAB68KaXzEqfo4jYdPanAqDyULzPyl8z4V
	MqsdIs786PH37EvhtUrF4bI8b5r+5hRl5inDurA1pwM9ChsT
X-Received: by 2002:a05:6402:460e:10b0:66e:5664:1e2f with SMTP id
 4fb4d7f45d1cf-66e56642201mr5605470a12.1.1775579573998; Tue, 07 Apr 2026
 09:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-2-mclapinski@google.com> <abptg2AObfxkkxKf@kernel.org>
 <2vxz1pgravke.fsf@kernel.org> <CA+CK2bCSoKGxfV+0QL46p_GqC=rj0YhcvP__bLrM2rVTgTNr=A@mail.gmail.com>
 <2vxzse96ah20.fsf@kernel.org>
In-Reply-To: <2vxzse96ah20.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 7 Apr 2026 12:32:17 -0400
X-Gm-Features: AQROBzDr_wa6PG8u3aIP6J0dUOY2EAUmN-EmDNqiTUddHsGQiNSzAqI7mC7Gp0o
Message-ID: <CA+CK2bDVKdyT8aFPhn01r3wL+2Z27iCH5ErJY1rk4qxFmajfyA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] kho: make kho_scratch_overlap usable outside debugging
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Michal Clapinski <mclapinski@google.com>, 
	Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_093256_545148_F0CE923E 
X-CRM114-Status: GOOD (  34.38  )
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

On Tue, Apr 7, 2026 at 12:09=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Apr 07 2026, Pasha Tatashin wrote:
>
> > On Tue, Apr 7, 2026 at 6:55=E2=80=AFAM Pratyush Yadav <pratyush@kernel.=
org> wrote:
> >>
> >> On Wed, Mar 18 2026, Mike Rapoport wrote:
> >>
> >> > Hi Michal,
> >> >
> >> > On Tue, Mar 17, 2026 at 03:15:32PM +0100, Michal Clapinski wrote:
> >> >> Also return false if kho_scratch is NULL.
> >> >>
> >> [...]
> >> >> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefil=
e
> >> >> index d2f779cbe279..dc352839ccf0 100644
> >> >> --- a/kernel/liveupdate/Makefile
> >> >> +++ b/kernel/liveupdate/Makefile
> >> >> @@ -7,7 +7,6 @@ luo-y :=3D                                         =
                    \
> >> >>              luo_session.o
> >> >>
> >> >>  obj-$(CONFIG_KEXEC_HANDOVER)                +=3D kexec_handover.o
> >> >> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)  +=3D kexec_handover_debug.o
> >> >>  obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)        +=3D kexec_handover_de=
bugfs.o
> >> >>
> >> >>  obj-$(CONFIG_LIVEUPDATE)            +=3D luo.o
> >> >> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate=
/kexec_handover.c
> >> >> index 532f455c5d4f..c9b982372d6e 100644
> >> >> --- a/kernel/liveupdate/kexec_handover.c
> >> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> >> @@ -820,7 +820,8 @@ int kho_preserve_folio(struct folio *folio)
> >> >>      const unsigned long pfn =3D folio_pfn(folio);
> >> >>      const unsigned int order =3D folio_order(folio);
> >> >>
> >> >> -    if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE <=
< order)))
> >> >> +    if (WARN_ON(kho_scratch_overlap_debug(pfn << PAGE_SHIFT,
> >> >> +                                          PAGE_SIZE << order)))
> >> >
> >> > Can't say I'm fond of kho_scratch_overlap_debug(). How about we make=
 it
> >> >
> >> >       if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
> >> >           WARN_ON(kho_scratch_overlap(...))
> >>
> >> +1. And we can get rid of kexec_handover_debug.c, for now at least. We
> >> can add it back when we have something else to put in there.
> >
> > Are you proposing moving kho_scratch_overlap() into kexec_handover.c?
> > That would make it uglier to have #ifdefs in the C file. If you mean
> > removing this function entirely, I think that is too dangerous because
> > we have already had a memory corruption issue [1] that was challenging
> > to root cause, and having this simple check prevents this from
> > occurring going forward. The problem is that changes to defences such
> > as kfence, kasan, and asi are happening outside of the core KHO code,
> > and it is very easy to miss when something unexpectedly causes a
> > preservation from the scratch area, as we have seen this with kfence.
> > Worst of all, some of those mitigations use randomized or sampling
> > approaches and might not be reproducible on every try, so having a
> > CONFIG that tests it every time in a debug build is the only solid
> > defense against that.
>
> I think you miss the context here. This patchset uses
> kho_scratch_overlap() during MM init to set the migrate type of
> pageblocks. So it will no longer be gated by
> CONFIG_KEXEC_HANDOVER_DEBUG, but by CONFIG_KEXEC_HANDOVER instead. So
> there is no need for any #ifdefs. All we need to change is to have the
> debug checks gated with a IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG).

Ah, this makes sense, IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) Mike
proposed was just for optimization for debug checks while making the
patch is  making the function generic.

Thank you for the clarifications. Need to review this series.

Pasha

> So the function stays around, and so do the debug checks. Since core KHO
> now uses this function, we just move it out to the main file. And since
> kexec_handover_debug.c has nothing else, we can delete it for now.
>
> Anyway, based on the discussion it looks like people want to ask
> memblock directly and not use kho_scratch_overlap(), so the next version
> might not have this patch at all.



>
> >
> > Pasha
> >
> > [1] https://lore.kernel.org/all/20251021000852.2924827-1-pasha.tatashin=
@soleen.com
> >
> >>
> >> >
> >> >>              return -EINVAL;
> >> >>
> >> >>      return kho_radix_add_page(tree, pfn, order);
> >> [...]
> >>
> >> --
> >> Regards,
> >> Pratyush Yadav
>
> --
> Regards,
> Pratyush Yadav

