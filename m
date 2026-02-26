Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F6FFD45FE
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 00:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=; b=feW6Qoa0REpdC4avCWtslK31yK
	8ZEPh3UjFUUlBHoZWTThjEfvlsLTg4NbFN8ZXuBlWTDZziCO2JorTj18bvwzPpU/nfYtwjCA0p8PD
	+moLhu1laoxT7rRGErlWq0h/ekcpe4QMVxisKgwbZjze0/03Acf9YTdHfO5aYjAWyc9pAJWOgnDVI
	SMqtcMIfdD4862pgzfy5PqRk5xpCAXThLOP1K6t3eBvHh8W2lWFFWC5lCZjqqloegPAFMmQwZuucO
	z2gpxkH46VU9reCAz7cfc1k5UZsaYTCIu8hpySgEeJZ8Shs8HEeI5MemmzPhvoUMk1UEOSEylA2e+
	2Gzex1cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvPc5-000000059tq-0xev;
	Thu, 26 Feb 2026 00:52:21 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvPc2-000000059tU-20S0
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 00:52:19 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5637886c92aso236821e0c.0
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 16:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772067137; cv=none;
        d=google.com; s=arc-20240605;
        b=WuPoHFQqND0H/YtHFzRlYypw8Rwl9hn9Ab0DiRs4iN+emZ2IGxRCK7qz5F32RYFmO7
         icsjUuWEjLKXoWf/LCfzdmvedi90Z7euvXDhs/30tmKmutBVuStl9wc9gq043ogYhPvP
         1vmHcxQ8LmEtkMbck4jpGpp3/9fTdyi/aqbkKvyTZ8L2wo7yiLSXtzwsF1i8n2KuRuTJ
         t8d58XbWP/VaTOYh4WA/+e8ZITBiNdc/rjPEQP+vhps85F0H3QnurJlUNxdqf/Q4/ywS
         OMrWbFS9zQ2LhHwOVmpCOvCYd3OPxUwxLprPyL7V6Bfj1zBPKaauUY1X2G8mD2uuxqHE
         Wwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=;
        fh=wswMYfMbjSyXX2dGPEtx4lbeYlhF0blQWH8vOtI2Sug=;
        b=Zz7dpdSLnUGg8bQuKOJy9ugCVuLfoNuANHo+0k9sE2222FKeU1TExQOS9vjryVm7PK
         X7ZlV04ZXclJ+VPtaVIdWVmHQrbz62Q6kA9ZhIzfEtLp1NDwof0W5tdTlRRVtpQJnRso
         ReV1DiP8nipo8SldpH0/UI4t4xGo+ZGLMjp1VMAVeZ0Ua5D+lVGy+/bowYoIC2TiOrg0
         SnmnYNnbCU14yhhS5iKdm1u+PKZa3cvqqO419MZRbGZlHbh0goPNhIZ9fKx5uEn44Ya1
         86yCTgcI/8zLESb1dltdJM9xIAe783Mx9hsLUu0TYqnZsPbwu/1r3XrdF3Rs55YiHV6F
         6Vpg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772067137; x=1772671937; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=;
        b=qTd6fUBGRXNp6J1kIfZpgytchaIaUAeN9gi/CMoQqWjQZkp/MuWraUwOkWFV+dzIJw
         cBjG4FgsC1lSr/j12yvCO4PjWguB3dcvesvkDoxjZZiL88tzjeUL8M0jmfP7qt1ID8kL
         uZn3uRlsg7njnOcNWxmSdABzKjN6qVkFGErQbkAfSnR+If9IIctWOI8zwDYpWbLEMhQz
         LIArO1DpPtx3qMzX2xU1eNsbbSCdQqgbXUwCBozu2sHO2p3qouTs14jsyxJGywnj1RX+
         k3V+b3tTBGGfzRVOrpae3a/JEBt14vZ8+cD0CZXzJ61DLTBDw5oJTDARSNnZaREOSEpH
         sJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772067137; x=1772671937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=;
        b=gT5ZTeriLWqq6mxA4wVsv9l0QhyDF2NqGJTrMdFHCz+eRfSODJ0lyGd8Aw5p/oCIPS
         m5FsxbjZLwVU5LirwZHHmOQvmC8MHPR6lHA+zFC3gYyFnrGz2rk5CmEdjTonEtQNIpZA
         XLSxwI7UxuucgN910ss4EDwLo4Q5L0IcpYG3Y4tV6tqX51fc2dHhVMyy0lrJLngFAFtc
         orWxkI/B6YaDHp29Ih39PLp33/ADa0I9/JIrqXbc2Nnpsd1pj3VnF3YwCT3TOmxScbFa
         9GqbSadGWXgw7q97prF22QOlUeWD5oHPYxWSJKFQoEVhqG6efmVZ+FkDkgoOploxDnuE
         T2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFj95yGHY/SmTsrIva4yY39wqn1P3Vn1NBvdP+XDZ5Kk+3HdhFJKCIKHXcS19YAXnzm/vvuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUVt4uTFrpjCqni+OZupZrSsSt4kochc12h+K0EoaGbhW1eA93
	ddksFVzrEzKtYFTjDYsSVDJo2hmlcwvzfcRL1V5Nm8L+7ZFel/MvoL4bJFKwZ2Jyh58eANRnw7g
	HWv/IZV8k7veJzhsHWjvPBFyfKXCbF1dzj5Efk+uW
X-Gm-Gg: ATEYQzwUfOQvtIwmZhsFCpY/dBGU6ci+IAHJqtpSZmjC3i00OxXhmDcucpTAt8R1GrU
	oIr8RL2oekKUbfYhJwIhXodaPdZJjEn6spY0OQVB/UV4Z+hyRE+f4gmKuCSKK+3Hkde4EQiG5d6
	Nx9dps/zYPnVTEo4u4ngpmnMX8EHOrfdOrF90vhS5mkSOfoGQgr69H3XaJ75a4UGDMJHDLc8jhm
	yI4dYx0IaxkanOcuMDIYbO4xopQ+IxESc8qWv5Zh/teAsOE8UUDAoWbs2jf9jOMYyErAjQzLtml
	hfb5t0A=
X-Received: by 2002:a05:6102:3f0d:b0:5ed:f13:e58a with SMTP id
 ada2fe7eead31-5ff1419f7b6mr1037473137.37.1772067136513; Wed, 25 Feb 2026
 16:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-10-dmatlack@google.com>
 <aZ606sDJxtfNF6qW@google.com>
In-Reply-To: <aZ606sDJxtfNF6qW@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 25 Feb 2026 16:51:47 -0800
X-Gm-Features: AaiRm51I1tTdJRO5CbbBFYwdOmR4S6VSPvkujC59eyupuwvOv4iLZLnGYRmW3DQ
Message-ID: <CALzav=cH0-qqQJTOjDD7pHzsFeZOir5DoC3f1hhDg=jqK7vdgw@mail.gmail.com>
Subject: Re: [PATCH v2 09/22] vfio/pci: Store incoming Live Update state in
 struct vfio_pci_core_device
To: Pranjal Shrivastava <praan@google.com>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_165218_555119_0DB33CED 
X-CRM114-Status: GOOD (  18.31  )
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

On Wed, Feb 25, 2026 at 12:38=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:56PM +0000, David Matlack wrote:

> >  static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_a=
rgs *args)
> >  {
> > -     return args->retrieved;
> > +     struct vfio_pci_core_device *vdev;
> > +     struct vfio_device *device;
> > +
> > +     if (!args->retrieved)
> > +             return false;
> > +
> > +     device =3D vfio_device_from_file(args->file);
> > +     vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> > +
> > +     /* Check that vdev->liveupdate_incoming_state is no longer in use=
. */
> > +     guard(mutex)(&device->dev_set->lock);
> > +     return !vdev->liveupdate_incoming_state;
>
> Since we set this to NULL in the success path of vfio_pci_core_enable()
> I'm wondering if a failure in vfio_pci_core_enable could cause a
> resource leak? Because vfio_pci_liveupdate_can_finish() returns false
> as long as that pointer is valid, a single device failure will
> perpetually block the LIVEUPDATE_SESSION_FINISH IOCTL for the entire
> session preventing the LUO from reclaiming KHO memory.
>
> Shall we also set vdev->liveupdate_incoming_state =3D NULL on the error
> paths of vfio_pci_core_enable() ?

LIVEUPDATE_SESSION_FINISH will also perpetually fail if userspace
never calls ioctl(VFIO_DEVICE_BIND_IOMMUFD) (which is what triggers
vfio_pci_core_enable()). Or if that ioctl fails before it gets to
vfio_pci_core_enable().

It's not a great situation to be in, but this is why can_finish()
exists as a callback. Userspace must properly and correctly restore
all of the state in the session before the session can be cleaned up.
And the kernel is not going to handle every possible edge case (some
files in a session are restored but some are not), at least not
initially. If userspace gets stuck and cannot recover a resource then
userspace will have to reboot the host to get back to a healthy state.

