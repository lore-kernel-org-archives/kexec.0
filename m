Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D09F4BB78
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=; b=yJWVqq5TWkYZSbBxjRyCtMpvLu
	92oa3bmJN8nLhDNeIW9t/e3iYjVT+d+VrPST8qcbzWmG5PgHaxtWMk87qt1D3psb5/VZoKdKdSaOd
	8abMd5ZzIZbSWNrkRdjyMRN3Af9PV/AdHrOJatgON3aEVK4lvxVG4jNFvHPLOoOPtHCGOIppWKvk+
	7YUCPF5LLgoctJpPF7uocfRgkoCLeNU8QeyDanMkdzfGc2EDdLXDXIVP0INXJjvOVfKq1mYQZUV9W
	sAPksyaMNPjGhb6PmtWp221gOUwqh9LBtS6rCuvEVygwv4ZjIX63WsyrbCTi1qTl676/LPjOfEJxd
	qe5XOCsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxuT-00000002fyK-2MTd;
	Tue, 24 Feb 2026 19:17:29 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxuQ-00000002fxz-3la4
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 19:17:28 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-38700168abaso47829161fa.3
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 11:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960645; cv=none;
        d=google.com; s=arc-20240605;
        b=MMsV6g2HK4qZWzBocsum5Idr95R3i60Y0waliYId4/xoQi+7TNa2fquMlxLNmipkk9
         MA/O4vN+yz3ladIPDfzg3ph4b3P9jlEuyXgnKZ9AcuIgUnDV+prJUmbWVOHoZOGpinJw
         nHpDIZ86v7YPzZfHrBOGA3e7F1h3c7y1lAkJrXsP+W/ygK+j9If6/ObHj5kMpxumTLMx
         NC1BoCI90vOijFHbyXnYYJ9Rx00LiPXOGFaWgn9Ivo6hHEvZf1UWuVliPlac2iL1RG9C
         3WkuwI3PeP42yr3wKX3+1nQSActQ4lieR+CiG95IM6aqUu15KNTOrfg0nVTcZ8J7o1//
         ziTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=;
        fh=my/X2w3M7EZaO+zVR48yNg6SpYgTOOjV9YyM8JBE0bo=;
        b=jEQVHj47559g6UBl3AqFes6tuK+z9CJc1j1R+al6kNZb14IPQVoU76qBeLw45HRm3Z
         ilyTvXCcNtZuZLIzdmhzLFRCqFFZl+ThoJZNtK11xIYIPAO2JzM2p0+wOyAynZ2esrOZ
         T3/+cnFSjz/H3o1fTQ50R6cHPsExbID3IAaOld19oX8ix7CtkYmNXBwnFfN5rFr7Oiiy
         MaEmRLCJStMdm7A6goPNtGbwtAanOkW5dM+uMD1pvXefdUT/6fGYT1paqHLyghNs4H2f
         D05PqgnTroUbzxUVXK2mRRrSG4TbnGOUlpyOGJb/DvUS1Q9Xjf0FwjEN8w9myh1golrT
         fMPQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771960645; x=1772565445; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=;
        b=mriviNmXojESNbXuciLsoHtOKuwjQWOJjG4IT8er3kqUsciaHfnGdXeNSxbW7XBoye
         pHtTf5T0WjO4K3pcv9cJdjyDUSbDqj9fogvIvT/iuWc626doAkT0VpliIemlEhWyDlzf
         8ibsb/d370dQDeJm2lEWDJBCJ8oFos+8bWqtc8sFMwtOzb/rFEdepV8NeGEEMcFa22X8
         ZXI2sDGausaGp2k70m4tiNgei94Vl6g776lxiCr+REXb3zHU6JyXVfgKY4SY+KHfUa1T
         n40Bqe/DWaZaoThoQS6h1tRf+YfyREPGs5eRM7ARaHTXfJfJDQIVZOehy8MnxCWqa1+6
         aMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960645; x=1772565445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=;
        b=B451ZkJ0LpEn3ARapmRcKYB/Qh3C312bn/fG4+0TaFs9a8VEUuhf8/HNRGv2HPVTi9
         uKNTSOwO+kjmlcUX+v5hHAuiLUXWEWXcUeHQK96ZuF4lgiUgEMCakpAkH03pDPMlbA2V
         3/N7r5RVfKNmsMUrOZ8CZd/vabDvTgVH/yK0zEEvHRW7nua1egojAunBTEMUXldiNDGl
         4ZBTWRtCQZTvGewbcqFBTKKMLTWe76pf8l0avp46Bp1vu6WrysHaOw9sD3TxwbpZRgxW
         PFagx/7pCItC8Pu3eQEISTdRZcZ4iCRtdnrnghHV+VouQQ09mENaEWZsmogbj6ndaZyR
         V85g==
X-Forwarded-Encrypted: i=1; AJvYcCW9pw4sPzt1mZkcVoEIPAjbtfy/ApXDFO5ZscD48hqwINvTscpwJ3wZM8P312BxA6Kphk8rhA==@lists.infradead.org
X-Gm-Message-State: AOJu0YywO88VKOzUSGBLwPgKhzuWBMuHTS0Oin/dNDeIqS4wBrN1Tbpa
	8AcrnUS8cSYPaG0Ka1j+pwHfavaV+7KkRGiZvfAwGQmFuE6Ceaqay32KkSrJZvU6hbyIssmiPpt
	yH4TgDs/nKtnCc3K8Zx8TlivdLODWDYdxoH9Zlom7
X-Gm-Gg: ATEYQzz8PYMX+CsDP8gbnKK4qXYhSAV3vWCh/zRNYyF0MSPXsMQwhM+8xaE/eI0ehNB
	LQdibGivhQfDMKKzFF7ttoKIvk0MoNxgJ5GSYvrwyJa9Uria5i26lhSoW5DfQPJLmO7xYntj1f+
	BMlmJTfBgcwVCbYUUhEzrSLEaf1TF1qrtNU3A8HAsfdnGNGs2qMaTIagnhiq3ru+2HvcgntZWjq
	5E/y1kQPVEIrx/DeTzAAcwyaJDDhtoERVvh0J4KBLS34IeV2HOtd+jWX2Kz1EI09s585L6AEcnD
	O9nifEE=
X-Received: by 2002:a2e:be8b:0:b0:386:e7a5:e26d with SMTP id
 38308e7fff4ca-389a5d5146bmr47895731fa.2.1771960644178; Tue, 24 Feb 2026
 11:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-6-dmatlack@google.com>
 <aZ3wBpYSF7mQv_GZ@google.com>
In-Reply-To: <aZ3wBpYSF7mQv_GZ@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 11:16:55 -0800
X-Gm-Features: AaiRm51YtBXd00PzQGhlvFr4r1F_UzQj5UbNk9Nur9O6pTAPmY6O7yFJgVZNGgc
Message-ID: <CALzav=cabKYFs3yhBEWOS9qseOY7rSh7F_Q40fu4spnYpmZMtQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across
 Live Update
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
X-CRM114-CacheID: sfid-20260224_111726_998880_DB6D7A59 
X-CRM114-Status: GOOD (  32.95  )
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

On Tue, Feb 24, 2026 at 10:38=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:52PM +0000, David Matlack wrote:

> > +     /*
> > +      * Reset the device and restore it back to its original state bef=
ore
> > +      * handing it to the next kernel.
> > +      *
> > +      * Eventually both of these should be dropped and the device shou=
ld be
> > +      * kept running with its current state across the Live Update.
> > +      */
> > +     if (vdev->reset_works)
> > +             ret =3D __pci_reset_function_locked(pdev);
>
> I see the 'Eventually both of these should be dropped' comment,
> which acknowledges that a reset is a v1 crutch. However, I wanted to
> clarify the fallback strategy here.
>
> If vdev->reset_works is false, we skip the reset but still jump into the
> new kernel. For devices that don't support FLR, are we comfortable jumpin=
g
> with the device potentially still hot?

That situation is already possible today. Simply use a VFIO device
that does not support reset, close it, and then kexec into a new
kernel. vfio_pci_core_disable() (which runs when the last reference to
the VFIO device file is dropped) also skips the reset, and kexec does
not reset devices.

Note that we still restore the state, which at least will reset the
device's configuration back to a sane default, including disabling bus
mastering.

> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index e90859956514..9aa1587fea19 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -81,6 +81,34 @@ struct vfio_device {
> >  #endif
> >  };
> >
> > +struct vfio_device_file {
> > +     struct vfio_device *device;
> > +     struct vfio_group *group;
> > +
> > +     u8 access_granted;
> > +     u32 devid; /* only valid when iommufd is valid */
> > +     spinlock_t kvm_ref_lock; /* protect kvm field */
> > +     struct kvm *kvm;
> > +     struct iommufd_ctx *iommufd; /* protected by struct vfio_device_s=
et::lock */
> > +};
> > +
> > +extern const struct file_operations vfio_device_fops;
> > +
>
> There seem to be two extern declarations for vfio_device_fops in both
> vfio_pci_priv.h and include/linux/vfio.h. Could we consolidate these?

Sure I can clean those up.

> > +static inline struct vfio_device_file *to_vfio_device_file(struct file=
 *file)
> > +{
> > +     if (file->f_op !=3D &vfio_device_fops)
> > +             return NULL;
> > +
> > +     return file->private_data;
> > +}
> > +
> > +static inline struct vfio_device *vfio_device_from_file(struct file *f=
ile)
> > +{
> > +     struct vfio_device_file *df =3D to_vfio_device_file(file);
> > +
> > +     return df ? df->device : NULL;
> > +}
> > +
>
> I'm a little uncomfortable with this part. Why is it necessary to expose
> the internal vfio_device_file structure to drivers? If this is only to
> support vfio_device_from_file(), could we not keep the structure private
> and just export the helper function instead?

Yeah, no problem.

> Exposing internal state into the public API introduces some maintenance
> constraints for e.g. if vfio_main.c ever changes how it tracks
> file-to-device mappings or its internal security state (like
> access_granted), it now has to worry about breaking external drivers.
>
> I believe we expose the struct just to power these static inline helper
> (mainly vfio_device_from_file) ? Instead, could we treat
> `vfio_device_file` as an opaque type in the public header (like struct
> iommu_group) and move the implementation of vfio_device_from_file() into
> vfio_main.c as an exported symbol? This gives drivers the vfio_device
> pointer they need without leaking the core's private internals.

Good points.

