Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F2DFB5E81
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 22:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=; b=JXCpQI70jxeHNHqwzrDac2HsVe
	1jnogO3oK45m6QabWTTZL+EH13Q4ZC9tzvQfvAfXcxiIkP8R+LcUkNZZ5pPAzbNBjgKqv0RU5G68X
	lB5a5uCY+EZ1J5zsEHym5bxxWYr0pHu9mT3wQ0c8tPTqWkvg6p7jk0jqprC/G3hv5Zeamv9HQsvCC
	0U3fK5UxPcYZX03UnlFmX6AvnP3TqQHTRxROlTKQ57ExqkuWufda7ZxEhkDvMPor5PdduWBAAe11D
	UcizmjnCKQH9SRLmJOI5wB897uwuL89cO6iBNndhWauyUqmnptHQt8e7R3z7ZuRPXV2uMTu62uKi1
	yph6ngVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GSK-0000000511S-3q70;
	Mon, 16 Mar 2026 22:30:36 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GSI-000000050zp-3o8Z
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 22:30:36 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso5298151e87.3
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 15:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773700233; cv=none;
        d=google.com; s=arc-20240605;
        b=e/Apl5CUCYfm0RRYEdUAXGW5ksw9XMwmNNbtgf+b0u3xULN5cnQ9cIJhLF0D/VuUrf
         olHHiCBI5FSDUkm8OUQHlU12paAppBKZ/zqgQyIW1E6jyMAqxpmP21XlUyDfgu7KNFj2
         DEcuLRe2u0qN71flPNp0YVHKKgHPcl4TYvtcMJ7aw0Iw2MqKFPn30xEvp/gx/SihGriA
         oCnKwTzvCMl2FnyyZ7AQThrFrAND/hd1wWLXqWsU/WruzNq9l0dpiZwJ+Q16EW7zmUpd
         LyjmjOuKdpf8l/cjjeIeTN1+ta7QVeTOnXZyVjU5jJg6Qsd9nXYPJHuyxGrMpwSIahMm
         GHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        fh=3/juCaS11yXaRK2sKTU/6Qr7HZoE3o7x97Eu1sfEDAM=;
        b=Xigr0L5V5fXrao06ALTBE1zwHY2rZVKfYl21pP79FkwCjkLokZubcN8dOO3Om4bbUI
         m+tn7CgsPikJtHu56pILaBYSx/mJMzw5QFLSV3rWJjcwyfts6w+7Jo8Nm27BMA1mGU6A
         aSlKs/ZBE9XbyGk7bW+f5dSUgAvl4gnoB3zXxit1AQJxypuvuGSclgr/JKOMgPZBd6DN
         f43CMcLL9yH/VMOFbNVA7qRdHwvS0AD4d4CStvDfh1JKTA9LrR+ax9R8ljW1VsJcKQIj
         /WMfz2LJPQDk1ympH+Hs6GvbfvJRXFwZhGPIlEiASOnktmYsWdvEN/qnLdj0wgvF/Gg9
         0MVw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773700233; x=1774305033; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        b=ic68Q+0pXV42IU7ZdS7UdeM1hXseV8PuU1lAvZ/ekspYJYIziVK/iRyqjB5ZLApxM0
         Fg2AbkUEz7O85LvGq5Py1SXzUGUYioAn8VjrwB5eV7vzHMMyZ0GR1f1fKW6XBFCDzREL
         /FxB0t+AGjDgpvmvQXU8Xamm2sVSBZweWfHLhncklAv5RkSnhl9/hrFlE7q/f0u0kEon
         vohidMxHBVfnUZDauu5NoB40IbtQ5DRnWTFR07kHNOjN3gMvthSlHNqE1LJa7aA2pDgq
         tGZk1VtoWvnTuTVZj5tdr3o/AFKH0usoRFO7/dZpOPHMgFHU9cgT4PKG/r15IpwUalVb
         HnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700233; x=1774305033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        b=HaiROzLVKLrxXOCOHyA39GymF5rw7hS6GMOHXh05ikuoGZL4+aH2jp0BFXvCcGY3L1
         rR9dJT0IEZw+MqD0mdnNId2IG0q9uF7zrRu06Cpk3QhOLRtIm2CCxTiL231n1S3PM+cr
         lBs/EDHvr5XybgmRfJmKs5/lRARGhzJo+8Elwkcg7LVTumDZIuitq38+5ltZp5pV6Yrb
         6Md3Z1nel7Fhuimbu07DFBLb0v4ofSC3Oe9RAJAT0KoOM2e2V/Tf8fgTeGHc0cIvjRCz
         EokDprzsGaZlgAGY7elktSn2JrhfdoeFx/XdbNdsMS1oWRI+eF3aKdp06DFBPl2luyxN
         zU2g==
X-Forwarded-Encrypted: i=1; AJvYcCVYJvxQP42mawZbqclf1mQ7vuxIIW0KimT5Uu5nGS0TIC4WJPRcLQIM09CCgAQPPYcf4EHULw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsWnX588ZX1oi6sI2AMZ3Fd8a7JrY4jPuLjaksDE6l7hCgX8xt
	mvnXgKF8KbmgBvFdIXkTEDzkQMvV/zaM2rhZCAHlHe0v8Nxt/ey47qURP+3nfb9yfgM4J7E0CaO
	ndqivTOzao2wmtnBhCJfSgRPVTiskZ2ptUlaOziiY
X-Gm-Gg: ATEYQzwD9bcnbm+2lDc0RJVx4IJM7bTZnfPuVe6wlNYNSLgZ4NOegCrQy4Bn8T85rvt
	jLCumDLr4fE30Vi8DUKTCHWsi99HlIuEwDyxUJ6eXpO2/okigzvV0Ipw8qLV9z34xvVC0qaIZJD
	Gc3eb6EqlhAVidMObAYRccw//7wh9/3sMH2gQIAZJuaHV/yO9qO5fN1BzG22gWiZgIQgr4IsWN6
	TKX2abt8yjqZXj/5FwDQF7dcqEj6XOCxvvMuteoWk+TjeT7aLBHs9TNkN4U8yfDP0kWnN0NBSuE
	S3RG7AluSzxyfQ120XI=
X-Received: by 2002:a05:6512:38a4:b0:5a1:2a64:202a with SMTP id
 2adb3069b0e04-5a162706bf5mr4418611e87.18.1773700231818; Mon, 16 Mar 2026
 15:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-12-dmatlack@google.com>
 <20260316215056.GC1846904.vipinsh@google.com>
In-Reply-To: <20260316215056.GC1846904.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 15:30:04 -0700
X-Gm-Features: AaiRm51TsPFqmaxXeg5vtHycDWCNAMtrDhfsa1Ts3dgQ-gFDNbzitmE0jWYnMy4
Message-ID: <CALzav=eKbTiJYz4mCWTmVghnwFLHZOY096Pf=1GYpO_UBixozA@mail.gmail.com>
Subject: Re: [PATCH v2 11/22] docs: liveupdate: Document VFIO device file preservation
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_153034_992449_4EED206A 
X-CRM114-Status: GOOD (  18.48  )
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

On Mon, Mar 16, 2026 at 2:55=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:24:58PM +0000, David Matlack wrote:
> > Add documentation for preserving VFIO device files across a Live Update=
,
> > as well as some generic file preservation documentation. This
> > documentation will be extended in the future as new types of files are
> > supported and new dependency/ordering requirements are added.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  Documentation/userspace-api/liveupdate.rst | 144 +++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation=
/userspace-api/liveupdate.rst
> > index 41c0473e4f16..dbf1e4aeddd7 100644
> > --- a/Documentation/userspace-api/liveupdate.rst
> > +++ b/Documentation/userspace-api/liveupdate.rst
> > @@ -14,6 +14,150 @@ ioctl uAPI
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  .. kernel-doc:: include/uapi/linux/liveupdate.h
> >
> > +File Preservation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Should we use the existing way where documentation is written in code
> files and referenced here? Maybe luo_file.c for this?

Good idea. I will look into that. It would be nice to also have this
documentation in the code.

