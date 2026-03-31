Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B9C10F92F0
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0ubV1DBOF5A9kCIZQ9FzFvFee5p/FpkVBHygl0v4P8=; b=aM/+cv0rTYj8VSzNzbYbKavLXM
	yk8haV1OVOtCyYd7BNfkPQ/G47BF9qCwhrlE8pS1hOOgTD4kTYhSB9qImcwoxl+MFTN6TO2OGAGbM
	sCrV9iZrMVRP2nIQwzUgnJYIVJZZd9WwdSoDXqmr0R12HH7jZ2PUJ1YFcmBxgeDxi3TXn/eALQwCJ
	IWsp2fLo782cjgTAE/PuXt1vhJ1+ist7TwbwIrNS/xn5Ceb51rzN+euoEzKIc0qiMWczzkdGAzNHK
	v8l3p8uBBw3DsEtlLUjCnTytMZNiyCjxOkApKMQe+fDe04vQKpGcwb7vCYdphwgJJYPGgaUBwO2Yl
	R+PuRyFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7eQu-0000000DSBR-3VPu;
	Tue, 31 Mar 2026 19:07:24 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7eQt-0000000DSB5-05jp
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 19:07:24 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-6501d32b04bso5202151d50.2
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 12:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774984042; cv=none;
        d=google.com; s=arc-20240605;
        b=O5HKVnDTFsVBhJzAiR/pxAvIYojeRkU8fvNbpjfuM8bG+DgGAsd98BkKtbBMy0SZCD
         qAj+EvUK7h5+nEGsBfmzcyWS1GkjbBlR3/xMwnGRXrN7BklktS/rxgjtgfJ2Zzbo+h23
         MQiYt8wZZVGjI5v9P2bd0ATJ8HByZLoQhbL1fbtsTjMSkl3BMnFOBzqbYMouUlQaxEAT
         RXGg2KSHi2YfptxI+j9+3FWe2q+DUbGZUurgS83OPCwsz5l4mv2n14xd6Y959hrEDpCw
         hwt5/9PIi1bxgM8R+SBDGTq4SOKKcxVjDzuEI0tGkvrbKJhMvQ5+3ohWZ4nZA8o0NlkZ
         iL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z0ubV1DBOF5A9kCIZQ9FzFvFee5p/FpkVBHygl0v4P8=;
        fh=YVJ4hsELCKgDqXx2GU/NVlA92oEIniguYCDFSY+GV6A=;
        b=NhxDItE1VitVPIiF5WmHtk92kRYOrD0z+RDJZttNrStN4syrbsxBrYmojwjax81Q4w
         kbI4ZjsgcrNbXXrgGoDahp1r1hnP8hT6Yz1I7ccrXqG3l5/RHF2kYUBR7tpWVuzM/2Ec
         7u/ll1a645O6nkqqsj6knWbRVrt45ZrsAYLbGGrd3+S1GlHpiem29NdcQ2Yy/iR/+DwB
         4l5ViX7v/xHg28B/amVxa961YFSOPoqWh82UYePPVHhXZ6nNssUIR4a8mKT+Fg/eEGIc
         PXZAqLuwPGZVdO2FKPK5jZBCd4jF1SuOWQS3rmbaqRLM9a+8nzFmHIT3zKBvJwuwHsmu
         uXfA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774984042; x=1775588842; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0ubV1DBOF5A9kCIZQ9FzFvFee5p/FpkVBHygl0v4P8=;
        b=rveaTBGPIS/z3m8Wo2BS7KzpThNy3f8D3PCzI/JKinHqn91cxnG4YvVbWsmrXvI76G
         ZE7VTiQJso37WFZdncgqAW88Xa/dxkxh7sMnSQ/QZh3bfsx2Qy+j4mCQRY65KI0tS6/2
         TD/cyD0GGY69mih4UUdCDvqvdLLAwutgqJFz2BH4y5/v6oZZ3GNgi9cjSvfLdgdrQuVV
         lu8Mf4BuE2H9D3ZqKXFKUet+d1mAurMcx/wibpoQiRWOOxWnz5vQG8Jc4aAU9zQIls32
         jhjk2X+30EChFOo2VejY3LQfMsp/ZBHrUX75gx3/Si/AuD0Nkmj00tzKDNlqctE9B2js
         /rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984042; x=1775588842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0ubV1DBOF5A9kCIZQ9FzFvFee5p/FpkVBHygl0v4P8=;
        b=Q46825UflsFApXO8bm+FtDQ8oztwhVLH6U52DmsTLOsEIiuPoucnKUFYkXlFnIYPbS
         YUgfka2u+ysm/h3pOceqe9GOZ84jJH6caKPXFb+LAm7qVZiEL5xVIAqbif792JUVTHNR
         E2lpq2Ni7kjszuGVJBdPvS/kHfQW7HI7H68mL6e4JivKckieZ/LdMKvndkHFOaRR/Njg
         isY1a1lDo050qtrtlTX92sBZ5ttFbNctOD5R7EsEkosauXWEN0CDNX8KmagmQ3ZEilmP
         z8baru9AOLl8W1KhBqdWZAlBfL0AACyWuYW2E54143Y8WyFopAulkEtdhQdrv2XzTdVD
         11ww==
X-Gm-Message-State: AOJu0YxN4syRL3515e5qNVZk61mPmp7P3q4LI5XQkp2qVvt9cH/MriSi
	BNc0ho8+I0zCGqhgqVHdcJw/Y5Yf7tYXZC/jd4LfRPVG2jRDznAJvlUmVm/n3UHmOECZJXQNYi7
	j9vCthBDNH5iqaX4oNP1j0vVieuMRj4E=
X-Gm-Gg: ATEYQzw/vzaaWqRSfdbG45uyUq2qZbLP3A6kAiqfPog43/SE+ufSz9QcaX0nkxcDuPQ
	8Td2c3GbIBRKFlDw4/xwe4TAABIYsKLxUB8/eIPKwagDAjdYO5Iqb3cUmAUwnk+xloJZnU1/VpB
	0ktApSKwrMPwbjWqMQSMvKYqoDg2OmZ6XMmbyOf8hDyarM5E/UnI4oK+5y8/k+7phuuZGd8OY+U
	AM3HAh6fmenvc+eQgqgAB51UgrJePFvVF/VfT4G4ob48r2DVau38/T0cxFrogMhTJJLR1BL3u01
	8SAuXH7L5hP5IHqQ3cY2ILZ3VkxG955Ducjixsur5w==
X-Received: by 2002:a05:690e:d01:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-6502fd9a768mr511350d50.7.1774984041678; Tue, 31 Mar 2026
 12:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175639.4066033-1-luca.boccassi@gmail.com> <CA+CK2bCKJ8rkJ_onp9Za0KNuWujH4Gzue3a=HvwOJAK2tYhReA@mail.gmail.com>
In-Reply-To: <CA+CK2bCKJ8rkJ_onp9Za0KNuWujH4Gzue3a=HvwOJAK2tYhReA@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 31 Mar 2026 20:07:10 +0100
X-Gm-Features: AQROBzB6bbhjBgXc0VS9CDTkKwmwHBmIOReMXh39R-clsmpO0UQlaGcKmky4R7s
Message-ID: <CAMw=ZnQcAggXOXY2s77qtgTS_d4td-5PXeMXEkMEVwnMFUrGPw@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_120723_070571_38962DEB 
X-CRM114-Status: GOOD (  26.55  )
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

On Tue, 31 Mar 2026 at 19:34, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 1:56=E2=80=AFPM <luca.boccassi@gmail.com> wrote:
> >
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > Userspace when requesting a session specifies a name and gets a FD,
> > but then there is no way to go back the other way and get the name
> > given a LUO session FD. This is problematic especially when there
> > is a userspace orchestrator that wants to check what FDs it is
> > handling for clients.
> >
> > Resolving the /proc/self/fd/X is lossy as that has a hard limit
> > of characters, so names might be truncated. Also requiring going
> > through procfs and doing manual string mangling is not a nice
> > pattern.
>
> Hi Luca,
>
> Thank you for working on this.
>
> This needs more explanation. The way I see it, the user orchestrator
> can be the only one that has access to /dev/liveupdate (and this is
> actually enforced by kernel). It opens it and creates session_fds for
> any client out there. So, the orchestrator already has the FDs and
> sends them to clients(e.g. via SCM_RIGHTS). It then monitors the PIDs
> of the clients, and if they die, it closes the session_fds for them,
> as their data does not need to be preserved.
>
> Could you please explain why the user orchestrator would need to query
> the session_fds, since it is the one that creates them in the first
> place and has to keep them open in order to preserve them during a
> live update?

The orchestrator cannot and will not hold on to all this state, that
is not possible. It will simply hand out session FDs on-demand via an
IPC, enforcing a naming convention for the client, and immediately
forget about them. Clients will hold them and use them as they see
fit, and then store them in the FD store on shutdown if they want to
commit them, and that's where the orchestrator will get them back, and
they need to be verified that they come from the right cgroup, what
the client's portion of the name is to be able to hand them back after
reboot, and so on.

Aside from all this, given the session name is input to the FD, it is
also good design to have a way to get it out of the FD again on
demand, regardless of the use case. Right now this is not possible,
since resolving /proc/fd/ is lossy and fails completely once the
session name goes above 52 characters.

