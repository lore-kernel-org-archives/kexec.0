Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A8C982C9
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=; b=hU8zagqi/OBnB5HJFZibAXjEJR
	Phq60ok2e22R0Yir0wff1+lipcx4uuQWtSeY6Dj+qvw8HRk8BZgPAJCLEbQQ92FPNMIn0n7Mmo0Dm
	8DkFNWg+/il0QGJMBEKNft6VfRfTWmD4yn93z4Z2uA+VnKF8fvHtvAveKWVtlYMEVtwhkfG79u9r0
	hzYyfvj5XACnJvHDCFYGvMRdFzFg2pe9xr56ciM6qoqWGs7gMNb263i95W+H/YvnPCBiryB0tYURn
	Rv30IlYDp6J3o72V35lH9t++rNvdHPfEMQ39rfXicUCATPq4v3SZwS4BufjGt0MdCHxUhMQ/+dS31
	0lJIAreQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6uQ9-00000009xYo-3jZS;
	Wed, 16 Sep 2026 18:31:49 +0000
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6uQ7-00000009xYN-1iuJ
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 18:31:48 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254f6c7a56so7547666b.1
        for <kexec@lists.infradead.org>; Wed, 16 Sep 2026 11:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583505; cv=none;
        d=google.com; s=arc-20260327;
        b=OoQfOoi7om75dGuOnECxySpZMWIOmQkLOiE0kBmQJgXwuqb02qDf50iuIbLmbiJDUg
         1kDDkKEwW4ECJQpV6yjuQ6y6rTJKBUEYkL4flr4CvWmLdS8ZUqIEZdPP11FEXZ+dfuCX
         prpnioLprk6ptvVyDrbUsZHNYoDPuh6Wszz4ygBhcm2fUY5J23w3rOhy1s/sqQyuJ0xC
         pzq8TFnPSN8qT5hPMcN3F/vUba9VqmKiM1ViFsCV7n0silbmkQOV4bS/9CaeIlCL25Wo
         koOdctqKnaOqlGIGmo1HWp+Wr64mlki+gz/j6OmyoI+XhKf51z+65Ti7EhH7Wy4bfudh
         oJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=;
        fh=YyRpcdz7fMtyekemKGEOZNJYmZvxrPNwWjaBBAcHrWU=;
        b=BikniVkBrMqbxaa5/YGCOsD8Ec9KZr28cS4ya5e5fP3StsaRSJO37vXQ6zg+hC0bvs
         UGiZnLxyRViumBlbgwV5VKwXqHSb+cVLb87cFgU7fERmfckbXVuit/G/gY0NlYuSw+Ct
         URU69jU5XdZOnBev7dILSRYjjSfo9N7AFWvtwdsyz8Etr6kuQes5g9iNNdHoYXWkMK26
         Ihrvd7HT8rgj8UgRcNaqR1+0J3XNnCisxjOJHgCSjmHLFb1rUXeEzH/9psX9hplW0F6r
         /50cDTVAXAQaWRGIBE40H+JZKz+Jl6vS7ap/RaaFhjl/IXOIjgwfs9rmVyqRNxcOoFw5
         5sMA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789583505; x=1790188305; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=;
        b=rO0sVRpe+QLTeHbQuoaDTYeHa8Hiy7nPuQiaT9N/sJjiISXirXhYs6hx86c5L1fy8Z
         JutQPrrbESetNih3C0SIInSOJ99A29np6N1bJ13HCzjDVbLM2TYcLKLiZVfVf2bjzpLa
         Vo+JfDELDX7ytG3NaJfo1i+QYN0irlJkZEhaboL83lq6iJ6GAduN6Ov/ybMukAHVGlE+
         9JWdOGlXQRy7UKGvWINK4VMilMPGnPdM2vVY3U6NVkDLeLxf3TRDOkYkZvqokw5jgqJc
         nVBd785jSKPOpJYMuROY1z9mmqXGHKc1ymKuqns6P/bpDo/B57mJAkCCZdEL3nnWNBj0
         XABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583505; x=1790188305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=;
        b=Svqmpn9ow5NGIBESRv3cEVngTtQ5ObdIhb8gHzEwMm+If3QVIcTdiMdAtaTqSbFdft
         vdL4fnMPMUyigKzbIWTgcGAABJ/r+9WnzZdlDfp6PQW7bUzSMo1deCaF4WMyNOK/meU5
         7ae6QVGMtsHjL134zX1K8tmsvpZuzFVgLgLseAa6C8g1NqQPGgTgwELv2sgbyNX3WWas
         8oIOPliEjsl25y9ictsF5ZM2PTowCEJ3dcmaPkDxw9ujzLKDCKXOPFewHEnn5q+afQkO
         ncm96jZJ9kIhEaOV3aWTlC/0d9aF9T1q4gPHv9P7LpFPe8KvwTgfhxsB+/Rbsj5TIWVN
         mPVA==
X-Forwarded-Encrypted: i=1; AKwUvBwnMQssh7VBKu/mY+wsYZjJnGnHgWoFW3nfgLTXzP+zNrVKUcHoFNQ84EX/4YWfnzreHbx87Q==@lists.infradead.org
X-Gm-Message-State: AFuF++n7DzAmJrN6kTe3zRJX8dZj1kfvukuax615WDSskWK1/tBi1+Ts
	fIocRpMCwycmOvBb452Ghty81UY6040+KyO6UviH9WcIOfkDW9/UP2zELBWmTCDvjwIiKQyJRSc
	5BkpYJhGrAsh79D7Vhe3sEVIXvhfpLmg3JL2+23v3NdsEtLLnst8lv+ZhVo4=
X-Gm-Gg: AYBFou1BTO9RozI/7sz6ZdYFZ5cYJ+3SnweyS0XDql+sgyLMBjrUG2PmBdosB6mdfsA
	xoBrPilbPKvxKzXlBpeLkH76auxV3VXqIgxgX2SypiRrCmUTG5Cf1B79edjj5Jz3kkSUn9YbBOF
	GNBVpuvhrf0tzahLV9wPoFBQC6F8QGR5ppC+YzUB2Dz71/IgDr6u7YOtpjsiUHKplWLomC4njul
	VExhH76nucSdOMbDOcVaX1x9JzOBuoGkzDpVfoG5Hm0nlFaKqdwFeYs6wZDxd4KFtwxjzuJkuU5
	7TdcuvQCAgjUPBmfQvancThIjLconsZ5kUEHkc3luTYYpX9bNpyTbZm+HfPcHmc4pc7K+mMyOLq
	gaLKEaZkZMdg=
X-Received: by 2002:a17:907:7287:b0:c26:1649:47af with SMTP id
 a640c23a62f3a-c29e5308ae2mr282051266b.37.1789583504840; Wed, 16 Sep 2026
 11:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev> <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
 <2vxzcxud6ol3.fsf@kernel.org>
In-Reply-To: <2vxzcxud6ol3.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 11:31:17 -0700
X-Gm-Features: AcwNN1Xd8nWTyJ5g1jf7rTHS0mmvfUGKUHwbATk6Q8e84nhTP92-8_DCKmvtasY
Message-ID: <CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260916_113147_498465_50BD1A10 
X-CRM114-Status: GOOD (  32.28  )
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

On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Wed, Sep 16 2026, David Matlack wrote:
>
> > On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.de=
v> wrote:
> >> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
> >
> >> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that=
 the
> >> > domain and bdf can be guaranteed to fit in an unsigned long and be u=
sed
> >> > as the xarray key.
> >
> >> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> > index 3781e2b5f095..8af20f558086 100644
> >> > --- a/drivers/pci/Kconfig
> >> > +++ b/drivers/pci/Kconfig
> >> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
> >> >
> >> >   config PCI_LIVEUPDATE
> >> >       bool "PCI Live Update Support"
> >> > -     depends on PCI && LIVEUPDATE
> >> > +     depends on PCI && LIVEUPDATE && 64BIT
> >>
> >> One question about adding 64BIT to the dependency:
> >>
> >> As I understand it, enabling CONFIG_64BIT essentially means that we ar=
e
> >> building a 64-bit kernel, and a 32-bit architecture cannot normally
> >> enable CONFIG_64BIT.
> >>
> >> If that is the case, would depends on 64BIT be necessary here? Or is P=
CI
> >> Live Update already inherently restricted to 64-bit architectures by t=
he
> >> existing LIVEUPDATE/architecture configuration, so that this dependenc=
y
> >> would be redundant?
> >>
> >> If this problem has already discussed, I am very sorry about this.
> >
> > The necessity is that the PCI core needs to store more than 32-bits in
> > the unsigned long xarray key (see the snippet above). The dependency
> > on CONFIG_64BIT ensures that unsigned long is big enough. We could
> > probably remove the dependency but I would rather wait until someone
> > with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
> > before putting any effort into it.
>
> KHO or live update themselves don't support 32-bit platforms and there
> are no plans to do so either. So I don't think you even need to have a
> dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures define
> ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
> inherit the dependency.
>
> If you'd like to be extra safe, then probably you should add a
> dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that can
> be a separate patch independent from this series.

It should be in both places then. PCI_LIVEUPDATE explicitly requires
64BIT for its own use of unsigned long, so it should have an explicit
dependency. If KEXEC_HANDOVER requires 64-bit for its own specific
purposes, then it should have an explicit Kconfig dependency as well.
That way if and when someone wants to add 32-bit support we know
exactly which configs need to add support.

