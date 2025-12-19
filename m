Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106E9D711D5
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOpFX73lOcA2xaIOC+spZOCBK4vYcGfoiXQtRzVcKYU=; b=Sy89ao+fsgDOAToqh84zJsaQIK
	bx9/mttgArIYPYFt3WgOU9UBIWELzZ3zmq7e8wW9oJfVylujyn5X7RLfBCoD57FyHRCBjBl2dZ8lb
	TrbcHmIhK9bov4kYLYCuz8qYbK1JqVbCRVegVP+gJOig1Qlh/ZcvjIqIEriUxYjb9kPnAu4Hxe2mk
	cLUUJF1p/zSa6kyBptNqbF1wuTz9ovOJsZFBGE4rK6bOch/e1GC+813XvOemZcWZph+R2doYVU3Y4
	aTMZNG7YnkM/+F5DWTZ9+wNrHmanAzHXueysHaFdNjBnXhVM/4KdlnF8S4PHvqy9HnLNxLqJDaI2G
	ZVH0uYsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQui-00000009Wyt-3cwh;
	Fri, 19 Dec 2025 03:12:20 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQud-00000009WyS-3aOi
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 03:12:17 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso1631336a12.1
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 19:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766113934; x=1766718734; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOpFX73lOcA2xaIOC+spZOCBK4vYcGfoiXQtRzVcKYU=;
        b=bIze8lAP4juB4cw73uMuVzOsOHzNjMwkShkTaezVVtcYHR6IOIU5g/fKd1N4exiq/a
         V40SnoSPcj+yAjkoEr3MRFdQhyFw+JexLMl8HkBpZdnwr0PDwkrFqZeEzldZO02+A0lz
         mgQQ6oB2ITWVlky3qsOwIe9lC6gwc2RLUPayPCZY0aw2Igk52hGcJyQuWosUKaoIMbum
         lWbwyRaEYqQmx7iYLyr8e3y0rH8Lb5nmAppM9QRjfVz1c/G5hTPx/un+H42XX6UnN8sy
         e+wpmgFsaabRSQH4HnnoROZcx9rmtvbCwZFwPJjul0RCIMW6hCDaQH/KE1RBYGzZ7MBc
         7W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766113934; x=1766718734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOpFX73lOcA2xaIOC+spZOCBK4vYcGfoiXQtRzVcKYU=;
        b=CLjgDui5R8roFM6TM1JC/IcInCk2CkqM9vYssaBR6yYrZpoF1Jf8cYGqkSWGf4gl4o
         KrgMtnbM5I7eyHdiSUzWXpF3cO2mNeE22sYBXvoNUawCMQ60D8FxptRsJe+6yYvSosCs
         8b6lfAB1ozZP6r3tiQJslyrUF1AxngQHo1zJy9ylk0PyuUEoiD5GkYD8ZZbycL2sLQp5
         lW8QrkCLyqUVLGwl3zvdL8iSNz6XI33dNBs1edKICJdbE7w3VesqkYDMPJ8yVue8Wqab
         o8oO5QEi2UHNN2IqYI9LS/C1x/vnQSJVtC02LpGa7Lrhrchav+90hTZTOAbWmiNvu8F5
         HRXg==
X-Forwarded-Encrypted: i=1; AJvYcCWIT/dfHkCnYGXPGL4dRKdw9nSY6yCLX7v2YzUGxPz/eVwMV+Sou199OzLjKVzaexarMUdwnw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJXr3k9nitWyau+ZOTCHOIqyejSPzB0ofRuFj+33sPgWiP7Z0c
	M1wydaUtq+Boiu5MJ29/dCIkp2hWpiXSCrdxTyMRljVm6d1v110vUL/3KGfrU5GcQA8O9BLBx4a
	E8pu5GQxLxWUDtu4SAiCeBtbxTwxBkbdy47PxtY051A==
X-Gm-Gg: AY/fxX7tJa0kNUjSQKzyMw/eBRJBiuRu6ivyBXUeNY9m9XAQU5MCdE9f+d1QmwEFXjs
	C1biDHBHyUd1ZwqqwIX17LpHoJm7aUoPE0Yl+PhTIrwUaA/Pww8DzZ72JUivwbPGN6ONIlAea0w
	oRUdnoIblLa39w7o/VM1VnhPSC3LQHOAR4THdBs7ar3cyoBZWsCuKlJyWkztGXm+jyUPNHiZYlJ
	+Wiafl6QUWCA7XySg4WCWY2mQyxl2M1lbwgrwY92r/aVwO6JIZQ4IJd0KPd404KORbgcHxFNYZs
	VT/Ko5S3d1qgFiE90Gy0LsAv
X-Google-Smtp-Source: AGHT+IFyooNIycCBqCq+5Jx2fOAIn6oqy4Jno8KDmH6oL5s3lOpN0tocGVfnZ64XVTzHRE4tjkXy4qtN942OJlkN/zw=
X-Received: by 2002:a05:6402:2345:b0:64b:42e8:4e38 with SMTP id
 4fb4d7f45d1cf-64b8eeeafd7mr1422809a12.34.1766113933641; Thu, 18 Dec 2025
 19:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114190002.3311679-12-pasha.tatashin@soleen.com> <20251218215613.GA17304@ranerica-svr.sc.intel.com>
 <CA+CK2bDucySNG7QqE87bZndgjKH-QCw61romZVExD63S2iM6og@mail.gmail.com> <20251219024341.GC17600@ranerica-svr.sc.intel.com>
In-Reply-To: <20251219024341.GC17600@ranerica-svr.sc.intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 18 Dec 2025 22:11:37 -0500
X-Gm-Features: AQt7F2omSeqxNLm45MnOPfOBzp5TCJGywWDkGT9aUu_9wUiHPCem8lSZwdriBwc
Message-ID: <CA+CK2bBg9xpkNyeWVR5+YQhpZYxSvWzB=nXV_d4D+DmzLdSB1A@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] kho: Allow kexec load before KHO finalization
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	ricardo.neri@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_191215_937765_26952404 
X-CRM114-Status: GOOD (  30.09  )
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

On Thu, Dec 18, 2025 at 9:37=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Thu, Dec 18, 2025 at 07:26:19PM -0500, Pasha Tatashin wrote:
> > On Thu, Dec 18, 2025 at 4:49=E2=80=AFPM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 02:00:00PM -0500, Pasha Tatashin wrote:
> > > > Currently, kho_fill_kimage() checks kho_out.finalized and returns
> > > > early if KHO is not yet finalized. This enforces a strict ordering =
where
> > > > userspace must finalize KHO *before* loading the kexec image.
> > > >
> > > > This is restrictive, as standard workflows often involve loading th=
e
> > > > target kernel early in the lifecycle and finalizing the state (FDT)
> > > > only immediately before the reboot.
> > > >
> > > > Since the KHO FDT resides at a physical address allocated during bo=
ot
> > > > (kho_init), its location is stable. We can attach this stable addre=
ss
> > > > to the kimage regardless of whether the content has been finalized =
yet.
> > > >
> > > > Relax the check to only require kho_enable, allowing kexec_file_loa=
d
> > > > to proceed at any time.
> > > >
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > > > ---
> > > >  kernel/liveupdate/kexec_handover.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate=
/kexec_handover.c
> > > > index 461d96084c12..4596e67de832 100644
> > > > --- a/kernel/liveupdate/kexec_handover.c
> > > > +++ b/kernel/liveupdate/kexec_handover.c
> > > > @@ -1550,7 +1550,7 @@ int kho_fill_kimage(struct kimage *image)
> > > >       int err =3D 0;
> > > >       struct kexec_buf scratch;
> > > >
> > > > -     if (!kho_out.finalized)
> > > > +     if (!kho_enable)
> > > >               return 0;
> > >
> > > Hi Pasha,
> > >
> > > Using v6.19-rc1 (which has this changeset) and with:
> > >
> > > CONFIG_KEXEC_HANDOVER=3Dy
> > > CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=3Dy
> > > CONFIG_LIVEUPDATE=3Dn (i.e., nobody calling kho_finalize())
> > > no reserve_mem=3D entries in the kernel command line
> > >
> > > I omit doing
> > >
> > > echo 1 > /sys/kernel/debug/kho/out/finalize
> > >
> > > before doing
> > >
> > > kexec -l <kernel> --initrd=3D<initrd> --commandline=3D"$(cat /proc/cm=
dline)"
> > > kexec -e
> >
> > Hi Ricardo,
> >
> > Thank you for reporting this bug. I created a fix here:
> > https://lore.kernel.org/lkml/20251219002355.3323896-1-pasha.tatashin@so=
leen.com
> >
> > Please let me know if it works.
>
> Thanks for the quick reply, Pasha. Your patch does work for me (I saw you
> will post a v2).

I have sent v2:
https://lore.kernel.org/lkml/20251219030854.3527871-1-pasha.tatashin@soleen=
.com

>
> From this patchset, I gather that kho_finalize() can be called multiple
> times and in-kernel users of KHO should call it when done preparing their
> subrees. Is that correct?

This is correct, we now allow it to finalize multiple times. In kernel
users can choose to do that during reboot, we also removed abort.

Pasha

