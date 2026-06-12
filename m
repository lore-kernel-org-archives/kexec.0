Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA95CD98D2
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZYv7z2e99bq8/9rGB+2ASRTLJy8QTrrW3Fih3Q9SFnI=; b=XhfbJBXMBSExgS
	SKh5nbn+yYN+yjTyEhLPJ70xiyGb9wFmdbcHCrIjV5kc2TweJ7+7hb6lxA2Igfy6opIieu8Uu2Sc5
	7WgZwDwCe1VSdBqk6CxEMeCn9X0uyFHxM9ljYA+zvM+ZP5WNW/EFx2iVr/rW5BbeBEE27sUwel06E
	8WZWBede31lmtcgXw7/m5c3vlaP/HpmEP0Rka1q9+4pneHBWG6Bl3O1fXTWGJwJBqgVe7hgH1prte
	GYCOKKdvrPsfqRpX7UTPqJV/dTtdrRSj35t6s4bpvnMS6z/ZjEifs+Bp4pCwdmUZvSYa5W8sYOlUv
	ZYtUVRwA+XxvrW+JWIeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6wl-0000000BQ0w-0C8M;
	Fri, 12 Jun 2026 18:49:39 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6wi-0000000BQ0a-1orU
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 18:49:37 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1336742714fso1218c88.1
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 11:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781290175; cv=none;
        d=google.com; s=arc-20240605;
        b=fvpPyAefcPRU8HM6eYWdtIh6GLMqOEr6lQoZxyH/Xj2/Z0uLmwM7fge8CjqrAuL94J
         YNdxjRONiwGYltQivCszEQvX+vsSe8snTJ1OyBiROTgjeZWpoiVVQcA0gAWcMDuxjgu4
         XQ2x8k5kkStBbWMju5x0E9++7cXMVZl7HVOc/VesQM6KCiB4KIv7EOzTu/VE4QwiOjyV
         VmNJa9TgKx8j3mbjAlcSy5uZlWN79z78bUNofeBVQkiygkiSCnEzTVV0gu4mfEoA7L+k
         hdDXc042K0J3bNK0+CSL2Jt+nfb8f2ZcBYSO2FjtF2NENrQkdiuyYEtrfPYkytt5Csh3
         vOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZYv7z2e99bq8/9rGB+2ASRTLJy8QTrrW3Fih3Q9SFnI=;
        fh=8pCqZPqpKFj4FcAh/qVsnIkdrc3Y9wd0ZTQC1r5q9MU=;
        b=BAYN7VmEF2jC3PW8ENsywA7c6EPS82yOrKc4pjQJUPYRIl8HCbkTUTZMpFwK6FLJeh
         l5DpOHcVUZ6XqCwhIBExMKfWWAiddLagQZzoIZgGS3PH4BXEf/oGtkPxNQWLvVhG0hRu
         lZjiZu+yDj40WgUI+MJzaBhahM1ov7dUCfmBmA+GoRU2EB6CtrL+9rm0jHNdsL6EbeHZ
         VykX9Iy4tOc85fVckmzUgOG0T3ppB1x9n0HNw8K/BzymR7C9LW2q5tArSq/Tqbl6sn9P
         KaeR6h6HbC1JfVYMufwkThmogEHhJ9D5OPDPthdUc/Q0k4RSfwCVF1ZD0123t/S9NUt0
         yzxw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781290175; x=1781894975; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYv7z2e99bq8/9rGB+2ASRTLJy8QTrrW3Fih3Q9SFnI=;
        b=T/t6qxVnuoxpsfV2ZoV/pZrCYKpU1yUWNtZq0t/id1YfnXAo77bbqMN6bLlytMdM4n
         Aj1Ag8V2H1VCofxrgSgUoMNbIjI3cLBwQx6aSDO2CxCj3pjUeEJ4MvgCsAbT3I5sX3mf
         YcsWLgGXWuhLKcoGsxUs8gHbZzDYOtE5mfiUwi9E8yaA7Mpz24w+iqZefaR9wtF37lSZ
         Sp56tRmiW+OjPJHitbUqDKEdrCnk91JUpzHi53AFTL1FQarUZigcWusDJ0G4eF8hHD2k
         J/fa0ovBUk5dVcz36KY/5wB4CMuR9MJ9VxtTBc8kfFc1Kb354vBI0+W5k4Agrib2DCWm
         CD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290175; x=1781894975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYv7z2e99bq8/9rGB+2ASRTLJy8QTrrW3Fih3Q9SFnI=;
        b=I7tf6fGZkokdCpBINT0HZ6LiUwl1oImga6FoqrMOLwCDrQ0YGpvFoS7ToyqBGnq80N
         L9EnEnprIrJckTYaUn7k4RS0ftZBJMM2TwcMgyWsX8TZLimx/u7WgnMpoZJzQmIIa1Uj
         NmB6ftjuxPGxZbT62WaYiIQyb6MhU16zUokOcZZcmMGFlxJ/Njt3pCCVPEvOTAOj39Mk
         0S36BzM3TOcdKvlWHzy1Ug1qq28F4+W2j50lzvdn+7cqFQlYnnZ+ZQjpPwlyRX8oWuLj
         qMxEpvJBywoEXbdpWcitvqaYUTJzz/nvB8WSbv394yRe1Ldzx9lWvKnlQOnlD6aYQgcB
         XrGw==
X-Forwarded-Encrypted: i=1; AFNElJ++5X4bmF93x/cwfZYCzNSq8qEEV7oYVMYXZ5MnX0siJzib55TGfZm/sLbCJ9JAkr5BLL55wg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHjGAsS/adTVspC0/lj8kwVE7YAitnTXeg8x36oqsbpZ1qWgAO
	jqg2DYW3LVnR4G0LhiIoURfsgAtlzxG5kwazHc+XLk9UlX7YSrUjepheUPdnzpSTCRJy43vYlY4
	v7lOrycdCWKdMBL6oXLX+svIRLpGv6T95BwYy+AXw
X-Gm-Gg: Acq92OGGIMpDqL1HW7VIbBwFpV1dMw/eV3525+oswPhYyoShcCAieCmooANEbzYomeP
	AhtwnRRfVCbfhW0nvET719s3NNqW9z4zIhS82gtH4qzfmF/SK5yel+8AmT2kRFXnem+VP4TTL+b
	SaAf0Tu1VfMgQUn2A99kOkka4H1NvqAW3ra4WAee+UG3gZip3IRcjmzzoJn6a9PldGFKT7QzCDG
	wKYwoOG7G3oZuPqNVQg6fFWFIXMxwg+U2i0YuHw2RlLnYN5OJRTKs2XWeQhBa8VPU+GDe56EEOD
	55menA==
X-Received: by 2002:a05:7022:6087:b0:135:2683:7615 with SMTP id
 a92af1059eb24-138aca2421dmr26817c88.6.1781290174631; Fri, 12 Jun 2026
 11:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260605121040.1177072-1-mclapinski@google.com>
 <aiwa4jIWEMsvfnVg@kernel.org> <aiwbUfeaF9RdCGR-@plex> <CAAi7L5cnRt6enZnrrbbhsVwtxUDBXrxj16zsg8TtRFvP70ocoQ@mail.gmail.com>
 <aixSCR1P2zVHDo3e@plex>
In-Reply-To: <aixSCR1P2zVHDo3e@plex>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 12 Jun 2026 20:49:22 +0200
X-Gm-Features: AVVi8CeKk8At_xkeb87fYBvSAcL1TL6GNYPbLM8z4uoYHDRPZvbn8do-p0fpdTY
Message-ID: <CAAi7L5fZTvhb5np=xGWnDEmr4bNXqoAcMhR_ePZ4Qga4E-KucQ@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_114936_484136_F5A4B09B 
X-CRM114-Status: GOOD (  28.93  )
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
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jun 12, 2026 at 8:38=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 06-12 19:57, Micha=C5=82 C=C5=82api=C5=84ski wrote:
> > On Fri, Jun 12, 2026 at 7:21=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On 06-12 17:42, Mike Rapoport wrote:
> > > > Hi,
> > > >
> > > > On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> > > > > Up to this point to preserve late shutdown logs in memory, users =
had to
> > > > > predefine a memory region using ramoops. This commit changes this=
 by
> > > > > preserving a buffer using kexec-handover.
> > > > >
> > > > > pstore_kho supports preserving only 1 dmesg buffer.
> > > > > It gets replaced with the new buffer on every kexec, so the user =
has to
> > > > > copy the file out of pstore after every kexec.
> > > > > There is no erase() support.
> > > >
> > > > Sorry I didn't jump at v1.
> > > >
> > > > pstore does not really need a KHO backend. It can use ram backend w=
ith
> > > > reserve_mem and reserve_mem can be preserved with KHO already.
> > >
> > > I just tested it, and it works well, I think it would be fine for
> > > Google's requirements:
> > >
> > > CONFIG_PSTORE=3Dy
> > > CONFIG_PSTORE_RAM=3Dy
> > > CONFIG_PSTORE_CONSOLE=3Dy
> >
> > Is it common to write to this console? I think what I typically see in
> > the console are error logs that are also in dmesg, so if I preserve
> > console logs and dmesg I just have 2 files where one is a subset of
> > lines from the other.
>
> We need either your KHO backend, or the following patch:
> https://lore.kernel.org/all/20260612172623.1218280-1-pasha.tatashin@solee=
n.com/
>
> We need all dmesg messages.

We get all of the dmesg messages if you compile with

CONFIG_PSTORE=3Dy
CONFIG_PSTORE_RAM=3Dy

and the cmdline:
reserve_mem=3D2M:2M:dmesg_buffer ramoops.mem_name=3Ddmesg_buffer
ramoops.max_reason=3D5 ramoops.console_size=3D0
ramoops.record_size=3D2097152 ramoops.ftrace_size=3D0 ramoops.pmsg_size=3D0
(the diff between yours and mine is I set console_size to 0 and
record_size to 2M, you do it the other way round).

Dmesg is kept in "record_size". We don't need to preserve the console
at all (unless there is something in console that isn't in dmesg but
I've never seen that).

> >
> > > With the following parameters:
> > > 'reserve_mem=3D2M:2M:dmesg_buffer ramoops.mem_name=3Ddmesg_buffer ram=
oops.max_reason=3D5 ramoops.console_size=3D2097152 ramoops.record_size=3D0 =
ramoops.ftrace_size=3D0 ramoops.pmsg_size=3D0'
> > >
> > > KHO preserves pstore properly. However, we need one patch that would
> > > allow for ramoops console to capture the output even when quiet is
> > > provided.
> > >
> > > Pasha

