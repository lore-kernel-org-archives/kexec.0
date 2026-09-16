Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F14C982C9
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 19:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=; b=0mn4GZgm/DLf9/viBukOjUaj1Q
	Q/+XAPBy3MLSzESsybCLcxOBGk6vk/P+PVbUmfB0xlEiT+0WJMUE5JW0ePMoDj++xIF09L1Mjfvwt
	77RW+iRXH/XWfH0exWnUrKGSN3eNcIxZjrFScnZD2cW1yYLE0sqAI/TUku9oMAk6gRTl2BGNRQ78/
	QL1Hli1Ruz3chkxaEWbqgg9dPrxuwV0EC0IuuwriRfpZCRczJqWHdDXkzFdIvzWwq2RV9A0G3OrQa
	IPcSMt5LnRFRAWzV6yAdM9UXIU/TQsdEWe/w2ci1yHp2l2CaX69XilJIRCb2oejkS/DOYKthDq0S7
	ZjnybNUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6vEF-0000000A1Vo-3OrX;
	Wed, 16 Sep 2026 19:23:35 +0000
Received: from mail-ej2-x1b.google.com ([2a00:1450:4864:34::1b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6vED-0000000A1V7-16C8
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 19:23:34 +0000
Received: by mail-ej2-x1b.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so15349366b.3
        for <kexec@lists.infradead.org>; Wed, 16 Sep 2026 12:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789586611; cv=none;
        d=google.com; s=arc-20260327;
        b=f6X2Vc7dOl9qjaiYH0BQTcBR0cmfRhJg/0Axa2PmaMrNyRl9gwonwouca0/eV/y50A
         C6TsnAVzZgsatyRiZTgkYM8xPJv2+dbfKUul6EfOvnP59QQ1BN3ytrGP5A0fJcyToJIk
         kK/xUR06og8tZVaJWmfmEguRffgK4xwZ4Hz46biVVQZBPSt0Sf1TwPT1Dqy7Hcu36uQ0
         ort7g0WtE98DyIyg/i2DaB0tLkBw3j4RiyBjB9P5IZfJhtbZyBInviptUnYYeYQROWOD
         bp5p61NHKRayONDLvMtJVt2SOj8melKWRxKk7ZZB4wiFdSvmQFUALWfSPlNyU529sf5T
         lO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=;
        fh=wArPOZByP6xjG613zZvhTf4jFaIMASAbPWap5Du1SjM=;
        b=S52r35gDQvDwRg5qDsOyaBwCETNpF3iotnMN6PeTSDOpNvDPGQrdB6QUv593pVzoMJ
         +7xGxVeBHgyMVhMKqg/RSFQC80SamHrOobKW7x9DKwdJ0HcnL4JbFaLSleyHzqnorhpz
         dOiIwGkOQPfYBtv05eyG+WpCu9yMk9UGe6nkGP9z/YTfcVkSMtsuMprQbDtT9yosbkdK
         qox6v8B6Pjxczr2QJZNRZ7IPafNuVU6khWUfq2tDVv/6cCGQMyiZMcBQ3uDNedU2BRZ8
         rnHHx7IssDWyoqXQV+vTk0wGgz1iFn0iw2OjwPgcdqkMngRqLQwZigRsLUZNJ0pKEkey
         qKEw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789586611; x=1790191411; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=;
        b=nwV/3Jvu/hF1slQCY8ix2dhYy3EjI5avsfEqVpWo0oYlozFghrqfyEkbXHsw18uy8D
         l362Exziisvozqn5b2oT2Z/rbtpYf6lDKHzbTzBFyDcv4TZZ8FpB+tGLaUIyBc8EtwQv
         YvoxiKC9uq6P9Djhrb4H7xSVjNtc1ZraIpxPOlX+EsiMMjHUCudxlz37XxT3w/+TbDHe
         yd3iNsTkB2dRwI6eDYbxRabeTOm/qt2T/FC72jURyy1wq1MFXzi/6wpTghHwOfedWw7m
         xCHnYQvQU5AvdDSD14tlClZPlYDBpHR6fjysW5PnbKK5yFzzEFan63ceQYOfNHwflC7L
         0uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586611; x=1790191411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KLYZ+iH6BwF1ulRTppUoaxI/s8uMQmLIUDs0MP8toU=;
        b=rwCRRbCf+OxEAPEaEkAauYfleiL4qx4P89yx/KFpcix2VAMVQwTi5BGgovqbtF6nup
         g/ObfUpo36in1b/VljERBTE7KgFiT9p9+9ec+YOoYfqH4e0TBjp4Vl1zevIupRBV4vRJ
         fcJBKq6uVSdPf5wMAGcjKMg2wUj2yuk/W0HVT/2A+9FbTJ74+CSK94ExcaoXM0tozNkT
         G1y26c2GXXj9EgyMR6ZmOcTyx3XxAZnwB58CjlGchtke0myL0GlAZDX9U6eejbqJpORW
         YPIe1aSQyTawgSHQjDLS4V9jOIlvz/LW+EbaJ2/F94K5kmvmjqjPEZYCcED9pKB1kuIe
         UlVg==
X-Forwarded-Encrypted: i=1; AKwUvBwS/WU5FkcT6HiTzS9PZmsMgs5lh0zXhTBeNq9RrAwqz7daPH7/W0gBnLUUjkfaXbJlidCMOw==@lists.infradead.org
X-Gm-Message-State: AFuF++kAFn5HaHR55kyGNHhCceuoImJ5ZSR7DOXvZM45Jp1LyppJU1Qh
	kiNS34dkf7WAdiTKwLxYATeGINv1W8SgprlHZHVNahLNgz8nbjCR+8le+cLY98ARd0MRYONdoo6
	wam4RaR+E2WzLujDUREudKW180ZUe71GkxSIJVOR8
X-Gm-Gg: AYBFou32bRrWlWVtHHP8fjJR6kinmaWPIdVLrJB7F8+PAhWy/dIKDsP3vijcc1Es4vx
	uqMsyEzRA6hYurtft8Fe//XJNNf5lgr/ZXKxxLRpEXfHpoHfXpMdKUi928rF49EbJv5lQvHLuG8
	R+WOXWJvbq6j4XXK6QRDCtVIA9DYo0LPzR54ccv9aAvxK5oSmaLhU5fakxIdy351Lt9v655qJfc
	Tn4KUfypOJWkWX9yKbuUy9aze1QccIPcO0AGvh9mI4kpBCbVODQzxsa6+C9ayvrCb3/RW6aSkgU
	01lVDfdyXBSjq4r0mVG9r8YyrAdomfnBUSdh5ZhffwuQwFKRvhpJpxkoELYQA1sCBfVeNchtsUu
	8GmermmM4pps=
X-Received: by 2002:a17:907:3cd4:b0:c29:3711:626f with SMTP id
 a640c23a62f3a-c29e52c97cemr277311666b.24.1789586610730; Wed, 16 Sep 2026
 12:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev> <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
 <2vxzcxud6ol3.fsf@kernel.org> <CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
 <2vxz5x056n1b.fsf@kernel.org>
In-Reply-To: <2vxz5x056n1b.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 12:23:03 -0700
X-Gm-Features: AcwNN1XBA5tWfpFye7fMRURIMgABlK_FSM1i3xHnxeEQBrBN_oHQDGfs58Y6KSU
Message-ID: <CALzav=e3_m_53PHTpMbwj0kFwVQdjx=MU8iHKwGcSa13V0R5cg@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_122333_330302_9D2CB191 
X-CRM114-Status: GOOD (  41.29  )
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

On Wed, Sep 16, 2026 at 11:58=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Wed, Sep 16 2026, David Matlack wrote:
>
> > On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Pratyush Yadav <pratyush@kerne=
l.org> wrote:
> >>
> >> On Wed, Sep 16 2026, David Matlack wrote:
> >>
> >> > On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux=
.dev> wrote:
> >> >> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
> >> >
> >> >> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so t=
hat the
> >> >> > domain and bdf can be guaranteed to fit in an unsigned long and b=
e used
> >> >> > as the xarray key.
> >> >
> >> >> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> >> > index 3781e2b5f095..8af20f558086 100644
> >> >> > --- a/drivers/pci/Kconfig
> >> >> > +++ b/drivers/pci/Kconfig
> >> >> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
> >> >> >
> >> >> >   config PCI_LIVEUPDATE
> >> >> >       bool "PCI Live Update Support"
> >> >> > -     depends on PCI && LIVEUPDATE
> >> >> > +     depends on PCI && LIVEUPDATE && 64BIT
> >> >>
> >> >> One question about adding 64BIT to the dependency:
> >> >>
> >> >> As I understand it, enabling CONFIG_64BIT essentially means that we=
 are
> >> >> building a 64-bit kernel, and a 32-bit architecture cannot normally
> >> >> enable CONFIG_64BIT.
> >> >>
> >> >> If that is the case, would depends on 64BIT be necessary here? Or i=
s PCI
> >> >> Live Update already inherently restricted to 64-bit architectures b=
y the
> >> >> existing LIVEUPDATE/architecture configuration, so that this depend=
ency
> >> >> would be redundant?
> >> >>
> >> >> If this problem has already discussed, I am very sorry about this.
> >> >
> >> > The necessity is that the PCI core needs to store more than 32-bits =
in
> >> > the unsigned long xarray key (see the snippet above). The dependency
> >> > on CONFIG_64BIT ensures that unsigned long is big enough. We could
> >> > probably remove the dependency but I would rather wait until someone
> >> > with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
> >> > before putting any effort into it.
> >>
> >> KHO or live update themselves don't support 32-bit platforms and there
> >> are no plans to do so either. So I don't think you even need to have a
> >> dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures defin=
e
> >> ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
> >> inherit the dependency.
> >>
> >> If you'd like to be extra safe, then probably you should add a
> >> dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that ca=
n
> >> be a separate patch independent from this series.
> >
> > It should be in both places then. PCI_LIVEUPDATE explicitly requires
> > 64BIT for its own use of unsigned long, so it should have an explicit
> > dependency. If KEXEC_HANDOVER requires 64-bit for its own specific
> > purposes, then it should have an explicit Kconfig dependency as well.
> > That way if and when someone wants to add 32-bit support we know
> > exactly which configs need to add support.
>
> Well, I don't think we are ever adding 32-bit support. Most 32-bit
> support in the kernel is being deprecated or removed, so I really don't
> think it makes much sense to extend KHO/live update to 32-bit
> architectures.
>
> But anyway, if you'd like to explicitly mark PCI as needing 64-bit, that
> sounds fine too in the very very unlikely event we do add 32-bit
> support.

Agree we will probably never add support for 32-bit to KEXEC_HANDOVER
and PCI_LIVEUPDATE. But I do prefer explicitly documenting the
dependency. It costs nothing and makes the 64-bit requirement crystal
clear, just in case someone tries to do something crazy :)

