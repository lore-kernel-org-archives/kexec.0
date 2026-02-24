Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7BAF4BB66
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=; b=ORpq1Yok7//mc8jcHMyN4hOtxv
	WDqr49vVt9om7vzbb/zQQ2cOPD5pixh2Y8FMG4avbxBXLmmd/FlUQKr7bFYVHh0/MjiLYSPM+IkfC
	iNp6f08Km8iRbY3Q54zCe6NWYouFpotgIg3NCZln4DDRaDaFapXo83NOYDc0IUESwQnENDgBx5JFO
	aDVvMKlgr14DEW9EsYkXd39Gfemxny2uKGmnuHczIVvOb/xU4lP6sAOuS+UNBR6YvvIInzaKqsxSP
	LGsn6lr4koPrKETX7FcE09d40VcXOnNEYt8D9TkUOWYiSO8DL+svE3eJJlhpC3KgcpdPDHqe/H7ff
	SXlU6kJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuwIM-00000002Uuh-3GuZ;
	Tue, 24 Feb 2026 17:34:02 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuwIK-00000002UuM-0IPf
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 17:34:01 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-94dd05a4b44so18461241.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 09:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954438; cv=none;
        d=google.com; s=arc-20240605;
        b=adDwmy+MxdLSYMijEmQ1hpbcIseQn0xZCUe3/yfp0HirWKMvTioRN4yop0BkUahu2A
         5jk+DjEwZKnJ8N1CQ4YeHBlMINcBj+V7HD/r3Nxut1N+JW+3+dr83VtzoRZW5uSpSt3K
         5taj6dPzGsLNc8eRlUvfKUgAfF2ZkhmTHbeEhqDxYZv0EVZAD7GkyD6aymmRdTyLWTsi
         2L1xy1xhiD1nPvfSUtUKsrBJ4qrSgI456vsqlBq0lgaB7ZebtQH3jbO4LPvdMP9d5Yhy
         5QaIIp6ZT+me0viygcW4EPoEoKFnjIguQZ3sfTgFXj8xVOyJacQarHEnJq6yPjQgzvbl
         ENMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=;
        fh=1s8neGbA4Mk+VWLRez2TsofdVrrAr7Be/ROfi67CkIw=;
        b=OPrA5GZAuK3Lo/zcwfux3sxs/r2q5I43oAniAlklDQxPhs7F2ieDUcavH5Kcogq/Uo
         NAI8bDYvvHHtklA1sXfOO7ROEblczcCy+my08PO5D3FPscx94wSHmzJjGFhC8kkwS2EZ
         koYM6M/m7Xuj2TVTbgspCTy91tJfSu2SXizwgQD7A+5JHEQXvXJ3q8QPa1VzrdpHAqfc
         iQAmBvBSPsEhzIA5nKHvnVhMI30WTHYGkYVrGSjdeVPwY/cTMJTtaB8xY1dMXnWWVhTt
         GTzSz0cKoX9FGJq1J+OnNvVH9h4k3b7XO1UWYroxe2/tFdvUwcvtVm3yRyMb/MQgcSHG
         o2ig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771954438; x=1772559238; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=;
        b=kcPXPywY10pEIGmHLph9LbXKzUKG8LF4Qbtlyy80LBzOujnycQpSd+USwBpLDMxZFb
         Gj/L/VDRqTubaa5CeZSRK0jnvlgQb/4NeqZT9u56ANap6bMWsX0Re9R7/6WeTuYzIyUU
         ys7LpKaD0HPg8GHvRHFiz5bRLZNj2sAqtN4ogy8Fd908cV85WUNkUSAuRhtkBIv3hX5K
         UBI8RdE2i0uIYeOrAU3732QdSRdw0xLKKJRXQ3Wqzc51S+12ugWfkOOKwZRu60E35uzo
         IxrEfowbfypyBh+Bq0RNNvylV2MABe4cjiU1/gAva4727mghz0hOCJznoqNOysW1EK3u
         xwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954438; x=1772559238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=;
        b=G8zFBASAo46wADV6T8uLlrOIuuJDDTvoDVHXYDsm/1qJ1vDoTFinm3TSJCdPZrArsS
         45/v6OYiL+RaVZqWJRv1hLw/WkFSka2g4ypN53l7soXQV++/xUGfHuEQKWFqkRL7+3tw
         32zg94k9Xq8B90NZn/zvQStbMLG3pjeM9DgoAi93Lgd5jteFOtAFEtYM6uZf16ujDrLY
         izQkmRX/CPE6FDa1WFI07U5bHRWKrgY2X/LSVC8ZBjXjr1xSxo6N5zRJFT8Jii1UyhLK
         5Twxim1+hwzcP+/uvr9zhnUuK3hIznPEnn7gtb4J/iw7MpbPPlxheOENQCUKa3dSYmSo
         EBWw==
X-Forwarded-Encrypted: i=1; AJvYcCW/YvsdMANCvjSZ5RSEkpQrQfkyok1ridxXdcvFbJDqr2Igo/6PYwgZwM0IrxsxUVb6knNsoA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywae77ITzLq3oJ9fuS4N5UbB7w0KVVFC3XDmF2/3YTe3FYM1xAW
	w1vbq0zb6htwiyT1/XdCJ0eUO7TaH5I9Iv0uszCCm8IR7Apx2zbNTCrBACv6Un8AfFqMFKp+R9v
	C2KM6T4+5Ght2Bc3uDj+HbVFiHk0qtLZQrCYsmEcQ
X-Gm-Gg: ATEYQzxr/XHJq+vHq7xggFESuCBuhUQn3PLeJrdECR/8InUxOOKQrVgtX+lH1EoVwE+
	ojR2jyMqYGINSwW2BXKLVHO26Jf1ksz4YjbhAvxg7Ns3VraFgPvqy6Zh5mWkYVDxKKtH7Jp45EQ
	T3IiQR5G8LyGa9yl4H97mFoq0JzbYC4Zt81V7sDqo5YKCOTJbqYr5oU6muEghrWGU5CiH6KWyqB
	xxBe4nmeze5TuRLLQUvkGHGyd5XalNqT794FGdTub+q0uQuQnuDTGeUnrxujT3bXQqBoEesjoQh
	QuUrH7s=
X-Received: by 2002:a05:6102:e0a:b0:5ef:b32c:dff8 with SMTP id
 ada2fe7eead31-5feffd8e046mr571923137.5.1771954437826; Tue, 24 Feb 2026
 09:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <aZ1svGur9IxQ7Td2@google.com>
In-Reply-To: <aZ1svGur9IxQ7Td2@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 09:33:28 -0800
X-Gm-Features: AaiRm50ftzuk34ivxDcB4SNiM7gs91UDwPlTbTMB1CMe8djixeonPg3t_5VqAYg
Message-ID: <CALzav=fSpd6H5pQNtJoFHdNtWVO11vffhWQFsMFkM+osGuE0wQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
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
X-CRM114-CacheID: sfid-20260224_093400_154263_EB1B44FA 
X-CRM114-Status: GOOD (  37.60  )
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

On Tue, Feb 24, 2026 at 1:18=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
> > + * Copyright (c) 2025, Google LLC.
>
> Nit: Should these be 2026 now?

Yes! Thanks for catching that.

> > +int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_dev_ser new =3D INIT_PCI_DEV_SER(dev);
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     /* Preserving VFs is not supported yet. */
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     if (dev->liveupdate_outgoing)
> > +             return -EBUSY;
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > +             return -E2BIG;
>
> I'm wondering how (or if) this handles hot-plugged devices?
> max_nr_devices is calculated based on for_each_pci_dev at the time of
> the first preservation.. what happens if a device is hotplugged after
> the first device is preserved but before the second one is, does
> max_nr_devices become stale? Since ser->max_nr_devices will not reflect
> the actual possible device count, potentially leading to an unnecessary
> -E2BIG failure?

Yes, it's possible to run out space to preserve devices if devices are
hot-plugged and then preserved. But I think it's better to defer
handling such a use-case exists (unless you see an obvious simple
solution). So far I am not seeing preserving hot-plugged devices
across Live Update as a high priority use-case to support.

> > +u32 pci_liveupdate_incoming_nr_devices(void)
> > +{
> > +     struct pci_ser *ser;
> > +     int ret;
> > +
> > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return 0;
>
> Masking this error looks troubled, in the following patch, I see that
> the retval 0 is treated as a fresh boot, but the IOMMU mappings for that
> BDF might still be preserved? Which could lead to DMA aliasing issues,
> without a hint of what happened since we don't even log anything.

All fo the non-0 errors indicate there are 0 incoming devices at the
time of the call, so I think returning 0 is appropriate.

 - EOPNOTSUPP: Live Update is not enabled.
 - ENODATA: Live Update is finished (all incoming devices have been restore=
d).
 - ENOTENT: No PCI data was preserved across the Live Update.

None of these cover the case where an IOMMU mapping for BDF X is
preserved, but device X is not preserved. This is a case we should
handle in some way... but here is not that place.

>
> Maybe we could have something like the following:
>
> int pci_liveupdate_incoming_nr_devices(void)
> {
>         struct pci_ser *ser;
>         int ret;
>
>         ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&ser);
>         if (ret) {
>                 if (ret !=3D -ENOENT)
>                         pr_warn("PCI: Failed to retrieve preservation lis=
t: %d\n", ret);

This would cause this warning to get printed if Live Update was
disabled, or if no PCI devices were preserved. But both of those are
not error scenarios.

> > +void pci_liveupdate_setup_device(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int ret;
> > +
> > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return;
>
> We should log something here either at info / debug level since the
> error isn't bubbled up and the luo_core doesn't scream about it either.

Any error from liveupdate_flb_get_incoming() simply means there are no
incoming devices. So I don't think there's any error to report in
dmesg.

> > +     dev->liveupdate_incoming =3D !!pci_ser_find(ser, dev);
>
> This feels a little hacky, shall we go for something like:
>
> dev->liveupdate_incoming =3D (pci_ser_find(ser, dev) !=3D NULL); ?

In my experience in the kernel (mostly from KVM), explicity comparison
to NULL is less preferred to treating a pointer as a boolean. But I'm
ok with following whatever is the locally preferred style for this
kind of check.

> > @@ -582,6 +583,10 @@ struct pci_dev {
> >       u8              tph_mode;       /* TPH mode */
> >       u8              tph_req_type;   /* TPH requester type */
> >  #endif
> > +#ifdef CONFIG_LIVEUPDATE
> > +     unsigned int    liveupdate_incoming:1;  /* Preserved by previous =
kernel */
> > +     unsigned int    liveupdate_outgoing:1;  /* Preserved for next ker=
nel */
> > +#endif
> >  };
>
> This would start another anon bitfield container, should we move this
> above within the existing bitfield? If we've run pahole and found this
> to be better, then this should be fine.

Yeah I simply appended these new fields to the very end of the struct.
If we care about optimizing the packing of struct pci_dev I can find a
better place to put it.

