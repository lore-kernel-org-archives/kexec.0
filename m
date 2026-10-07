Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEE7CA6007
	for <kexec@archiver.kernel.org>; Wed,  7 Oct 2026 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=; b=V+pZWj1Nm229Yy56PwXY3PCZXR
	IanjyikfT1nwRuTFa4CZPESaF6Sj8m3MCCVd9vO+451Hx7vk18NTaSsuYeMmzIlgLpdZnjiMqvb+x
	9riXI9BpDKWbHbctKBdfs2Gp3x7oK7rlparZpuGdBuVkVg6LJeuMCn/Cp401c/JgPK3kTIgFiCHIe
	9kMx2S5+Baol+95SjPInEcztdhb9X/WhDDDIFoPnUeBJ5FlD1dx8O03tLXpSWPc5aY2oLr+7n3/Pg
	EcgcoO7j3lyyq4JXYG1DtdDP9oaeIt6OdBxlcGiXo4l5sVhFv3HmZfgE3JhHLquTgZcCod5bX3DBG
	QBu55IIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xENpZ-000000022kS-3qjw;
	Wed, 07 Oct 2026 09:20:57 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xENpX-000000022jc-0U5l
	for kexec@lists.infradead.org;
	Wed, 07 Oct 2026 09:20:56 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c2e26719a0fso144356066b.3
        for <kexec@lists.infradead.org>; Wed, 07 Oct 2026 02:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791364849; cv=none;
        d=google.com; s=arc-20260327;
        b=kMYTiP9yY3y2stNYuAyLgIpT4AurZT0WOZRTSmhuJswJZtggCk5tioerK2J+JaYWo2
         50q+Oc392olK/7zioBgCrrto9HsMgllxRaO10kd/3mjNkQ14N4/GIZk/e7TMpyih1/fU
         0H97u5gZharsKy76K1HImRnvqZ+IhghTk1szM4AUwNOpIJcEqLTyCQ33b/FJbwSEwfAL
         lR82o8iulemhKtCIN9xwGu3cxCrOdZSbTCur1yu8HQAAdKKNSF3tu3S7X26+jlmtjhOQ
         6MTpi+4YUrAwEUUkwVcReTzjUS9DNg3npG9aEcKTs+lzI+miUHgj/7Qoh4AfW8Kglo5m
         F8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=;
        fh=tZH+ZPKqtrYKhbBC++z//ftJb3+4tR9MBchIHKgcz6A=;
        b=GQ6PoXO0TflBPBW9pSRhRqVvYbk/z1wADlXOqtpoa/8DwBTESs7l1520npg2P80sd/
         TA95lwT+GTR+/IBKnqYE/RpjYaaSTgJBEJAv2zAdEZUf4Ggut98ImRrvThCHt1Kh7PMs
         /ENa8Fvtc9xLHdHCLTDjI3b72/bPntHJOmf8X6/oLYgJN8Y5r5gTyCb/VxJxY1BTtBq+
         e4UEp13Ttn6zYiCcqzdpv/JBU5pVt1ex9J1+ih9OaK1nXE4qroDd6l9cL07a2eczBghM
         CqzOxhT1kYpxdFEIU71agXwkLgYmNNN2J+Aku3MA4Xi+cBKb7eYdQVlR5ASzg9xNHtoK
         TY0g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791364849; x=1791969649; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=;
        b=fxiS0E6tflrykIJy1RwaMqbdvqP5sUMdVhojoBeUeJQDD9tmp6JcNgHKNrjxtqPzY2
         ouXTkCwXi74/JLm7LtGKsX//0iV74hyo7OBwMro+7a5aLXy2JfixdR7Z4xfZn40/RVXa
         CsijJzcYAL8KcrS5th54oW0xO+YHix9D934/Fi9vUwOWU3R0qIeTTCTJcNpPgUtOStJl
         l/O/wIU1sUqo8Qw/dBdTMwfJI8mE2KpZ6oD1o3DPTQs42k/3UmPMeMHHURbBp1E+/BO2
         gCQUaPzUWZQcjKWtDmmpOOgAuDN4evDcMphzs6kZOZNKq4zUDMVX9usrx6k0SFfUlDY/
         jv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791364849; x=1791969649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=;
        b=HDVMbRUFn3bKLIwxydjLsnmgC4GGMYcKFHdem5Jc/SgeWtoVELNH6ImVAtXYIYmVnA
         VpYSkZSHWvMk05U27IQg+FVMpYY8cCC92eAgouGN4rCPt9O3+3rLp6ssmyHDTjEy6u94
         oIjL/QKKGrrMUjEOOE2mEBKACc/+RMXDrD0lyL0rJVibPZShoLmzgPHccav/nhLYfB7g
         w0/C8sPVCqdgVo6AlCuUxe4+8tDW1EegPxeSltaUcoS+3tonxTqcUp/Gje1fJ8T+xnIU
         HYqJohiuDUlxqVe+3woP8M08d5X2ZgpJyP0RTyW8iRFKEXDhpdKVTbUh1PEXWC65nWxD
         exgA==
X-Gm-Message-State: AFq9FYJvvACvx7QOsfOvjj2WC6WnrIU+0kxzNho7kvQkDD7KF5OuAqQT
	wEkJq8/5uxJhtwQel7dyn0on9fyiXM+MQNxxmhcC2HaqbxD/v13LjH8xuKTD892jgYbJzaIF7ys
	OThNt4fi2OcZmwfohcnJso6ombBsGibiMwvuA4i8sbAxKp4NhwP2gHYIdvMw=
X-Gm-Gg: AYBFou1fu+cZLkLhVZitq1lOlimw2//X91crfFmdofXdCflEgn6FDYhB213CsUd7LZn
	qH+SJp/iEf3q+PJSbJD5tsEXeiSVyat48lS0wC/mY9A2Q8wtktrNS1WkaEZsU7t0G3Led4gVdQm
	iP0adtIW2y4qnyjWB4ABNgVYKDefxzC5KTJwsIu3ZYZPhQ6k6zffL+B74VPIgFxfgU9IhVz2epH
	nbHKF4vEzBOkDmUh4fckmLaxWVHdp0Ls1hrp0yNDsOXr5rziMFjnUFmhevn79Vzs8wr+x6SgNoq
	Ad4xOngXSlCzEhhwF6M7ximRymuQ6GRFPpOY3s7sXlD8Mez8azFJDvg=
X-Received: by 2002:a17:907:1c84:b0:c2e:4705:467c with SMTP id
 a640c23a62f3a-c317bd450f0mr150496666b.10.1791364848404; Wed, 07 Oct 2026
 02:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com> <20260918200640.887030-9-dmatlack@google.com>
 <20260918191846.2f68b23b@shazbot.org> <arGVMaxfwEw_PkXy@google.com>
In-Reply-To: <arGVMaxfwEw_PkXy@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 7 Oct 2026 02:20:16 -0700
X-Gm-Features: AclHuK_PI8zGCsZyvrqP1bU2CJDBBfSkmQGW03sa119GkyMLIb-ErHKkHiE7tWM
Message-ID: <CALzav=eTrH4WNPYNWAwmYSEw_imOXwRqf9y7zPDmC27dVE0zBw@mail.gmail.com>
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_022055_337405_BAB5E688 
X-CRM114-Status: GOOD (  57.18  )
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

On Mon, Sep 21, 2026 at 1:36=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-09-18 07:18 PM, Alex Williamson wrote:
> > On Fri, 18 Sep 2026 20:06:34 +0000
> > David Matlack <dmatlack@google.com> wrote:
> >
> > > Save the ACS Control register in pci_save_state() and write it back
> > > in pci_restore_state(), instead of recomputing the ACS controls from
> > > scratch with pci_enable_acs().
> > >
> > > This makes ACS symmetric with the rest of a device's saved state. Tod=
ay
> > > pci_save_state() ignores ACS entirely and pci_restore_state() re-enab=
les
> > > the ACS controls from the kernel's current ACS policy. As a result, a
> > > device can come out of a reset with different ACS controls than it we=
nt
> > > in with, e.g. any controls programmed outside of pci_enable_acs() are
> > > silently dropped.
> >
> > Controls, yes, but if we're restoring controls that might have EC set
> > now, should the Egress Control Vector also be part of the save state?
> >
> > Currently EC always gets cleared on reset and won't be restored by
> > pci_enable_acs(), so we can lose both EC and the EC vector.  With this,
> > I think we restore EC but still lose the EC vector.  Thanks,
>
> The kernel does not enable Egress Control today or program the vector.
> Would this be to cover the case where firmware or userspace enabled it?
>
> Here is an updated patch to save/restore the vector, but I don't have
> any devices that support Egress Control on my normal testing system so I
> haven't been able to really test it yet.

Hey Alex, gentle ping on this.

This series is merged into the liveupdate tree to get linux-next
exposure ahead of 7.4 merge window. If this patch needs a respin or a
fixup I'd like to get the ball rolling on that.

I think the 3 options are:

1. Keep the patch as is based on the understanding that the kernel
does not enable EC today or program the vector.
2. Save/restore the EC vector (the below patch).
3. Clear EC on restore to preserve the current behavior.

And if we decide to do (2) or (3) then that could be done with a
respin of the patch ahead of the merge window, or a fixup patch on top
to send in a later rc.

Thanks!


>
> From: David Matlack <dmatlack@google.com>
> Date: Fri, 11 Sep 2026 20:05:04 +0000
> Subject: [PATCH] PCI: Save and restore the ACS Control register and Egres=
s
>  Control Vector
>
> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
>
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>
> Notably, this prepares the kernel to be able to adopt the ACS controls
> established by a previous kernel across a Live Update rather than
> assigning new ones through pci_enable_acs().
>
> Save and restore the Egress Control Vector as well to keep it in sync
> with the now-properly-restored Egress Control Enable bit in the ACS
> control register. The kernel never enables Egress Controls or programs
> the vector, but the firmware could have and they need to be kept in sync
> to avoid changing how P2P traffic is rounted.
>
> The size of the Egress Control Vector is not known when
> pci_allocate_cap_save_buffers() runs, as the ACS Capability register is
> only read later, in pci_acs_init(). Rather than move the allocation,
> size the save buffer for the largest vector a device can implement,
> which costs at most 32 bytes per ACS-capable device.
>
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS state there as well, otherwise
> a subsequent reset would revert ACS back to the configuration left
> behind by firmware.
>
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/pci.c             | 117 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h             |   5 ++
>  drivers/pci/quirks.c          |   7 ++
>  include/uapi/linux/pci_regs.h |   1 +
>  4 files changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..e1c05866e2ee 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1021,6 +1021,106 @@ static void pci_std_enable_acs(struct pci_dev *de=
v, struct pci_acs *caps)
>                 caps->ctrl |=3D (dev->acs_capabilities & PCI_ACS_TB);
>  }
>
> +/*
> + * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vect=
or and
> + * is sized for the largest vector a device can implement.
> + */
> +struct pci_acs_saved_state {
> +       u16 ctrl;
> +       u32 ecv[8];
> +};
> +
> +/*
> + * Return the size in bytes of the ACS Egress Control Vector, or 0 if th=
e
> + * device does not implement P2P Egress Control.
> + */
> +static unsigned int pci_acs_ecv_size(struct pci_dev *dev)
> +{
> +       unsigned int bits;
> +
> +       if (!dev->acs_cap || !(dev->acs_capabilities & PCI_ACS_EC))
> +               return 0;
> +
> +       /* An Egress Control Vector Size of 0 means 256 bits */
> +       bits =3D FIELD_GET(PCI_ACS_EGRESS_BITS_MASK, dev->acs_capabilitie=
s);
> +       if (!bits)
> +               bits =3D 256;
> +
> +       /* The vector is implemented as a series of DWORD registers */
> +       return round_up(bits, 32) / 8;
> +}
> +
> +/**
> + * pci_save_acs_state - save the ACS Control register and Egress Control=
 Vector
> + * @dev: the PCI device
> + *
> + * Record the ACS configuration currently programmed in hardware so that
> + * pci_restore_acs_state() can reapply it after a reset.
> + */
> +static void pci_save_acs_state(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state;
> +       struct pci_acs_saved_state *acs;
> +       unsigned int i, dwords;
> +
> +       if (!dev->acs_cap)
> +               return;
> +
> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
> +       if (!save_state)
> +               return;
> +
> +       acs =3D (struct pci_acs_saved_state *)save_state->cap.data;
> +
> +       pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl=
);
> +
> +       dwords =3D pci_acs_ecv_size(dev) / sizeof(u32);
> +       for (i =3D 0; i < dwords; i++)
> +               pci_read_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS_=
CTL_V +
> +                                     i * sizeof(u32), &acs->ecv[i]);
> +}
> +
> +/**
> + * pci_restore_acs_state - restore the ACS Control register and Egress C=
ontrol
> + *                        Vector
> + * @dev: the PCI device
> + */
> +static void pci_restore_acs_state(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state =3D NULL;
> +       struct pci_acs_saved_state *acs;
> +       unsigned int i, dwords;
> +
> +       if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
> +               save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID=
_ACS);
> +
> +       /*
> +        * Devices that rely on device-specific quirks to enable an ACS
> +        * equivalent keep that configuration outside of the ACS Control
> +        * register, so there is nothing useful to restore for them. Conf=
igure
> +        * ACS from scratch instead, which also covers devices that have =
no
> +        * saved ACS state at all.
> +        */
> +       if (!save_state) {
> +               pci_enable_acs(dev);
> +               return;
> +       }
> +
> +       acs =3D (struct pci_acs_saved_state *)save_state->cap.data;
> +
> +       /*
> +        * Restore the Egress Control Vector before the ACS Control regis=
ter.
> +        * The vector resets to zero, so enabling P2P Egress Control firs=
t
> +        * would briefly apply the reset vector instead of the saved one.
> +        */
> +       dwords =3D pci_acs_ecv_size(dev) / sizeof(u32);
> +       for (i =3D 0; i < dwords; i++)
> +               pci_write_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS=
_CTL_V +
> +                                      i * sizeof(u32), acs->ecv[i]);
> +
> +       pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl=
);
> +}
> +
>  /**
>   * pci_enable_acs - enable ACS if hardware support it
>   * @dev: the PCI device
> @@ -1057,6 +1157,15 @@ void pci_enable_acs(struct pci_dev *dev)
>         __pci_config_acs(dev, &caps, config_acs_param, 0, 0);
>
>         pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
> +
> +       /*
> +        * pci_enable_acs() runs when a driver binds to the device, i.e. =
after
> +        * pci_bus_add_device() has already saved the device's state. Ref=
resh
> +        * the saved ACS state so that a subsequent reset restores the
> +        * configuration programmed here rather than the one left behind =
by
> +        * firmware.
> +        */
> +       pci_save_acs_state(dev);
>  }
>
>  /**
> @@ -1800,6 +1909,7 @@ int pci_save_state(struct pci_dev *dev)
>         pci_save_aer_state(dev);
>         pci_save_ptm_state(dev);
>         pci_save_tph_state(dev);
> +       pci_save_acs_state(dev);
>         return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1877,7 +1987,7 @@ void pci_restore_state(struct pci_dev *dev)
>         pci_restore_msi_state(dev);
>
>         /* Restore ACS and IOV configuration state */
> -       pci_enable_acs(dev);
> +       pci_restore_acs_state(dev);
>         pci_restore_iov_state(dev);
>
>         dev->state_saved =3D false;
> @@ -3532,6 +3642,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev =
*dev)
>         if (error)
>                 pci_err(dev, "unable to allocate suspend buffer for LTR\n=
");
>
> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
> +                                           sizeof(struct pci_acs_saved_s=
tate));
> +       if (error)
> +               pci_err(dev, "unable to allocate suspend buffer for ACS\n=
");
> +
>         pci_allocate_vc_save_buffers(dev);
>  }
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..037c1674f164 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
>  void pci_enable_acs(struct pci_dev *dev);
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
>  void pci_disable_broken_acs_cap(struct pci_dev *pdev);
> @@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(str=
uct pci_dev *dev,
>  {
>         return -ENOTTY;
>  }
> +static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +       return false;
> +}
>  static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>         return -ENOTTY;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7aee30734303..e500c202d2ec 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_o=
ps_get(struct pci_dev *dev)
>         return NULL;
>  }
>
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +       const struct pci_dev_acs_ops *p =3D pci_dev_acs_ops_get(dev);
> +
> +       return p && p->enable_acs;
> +}
> +
>  int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>         const struct pci_dev_acs_ops *p =3D pci_dev_acs_ops_get(dev);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index facaa324bd86..66359cb94f0d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1023,6 +1023,7 @@
>  #define  PCI_ACS_UF            0x0010  /* Upstream Forwarding */
>  #define  PCI_ACS_EC            0x0020  /* P2P Egress Control */
>  #define  PCI_ACS_DT            0x0040  /* Direct Translated P2P */
> +#define  PCI_ACS_EGRESS_BITS_MASK 0xff00 /* Egress Control Vector Size *=
/
>  #define PCI_ACS_EGRESS_BITS    0x05    /* ACS Egress Control Vector Size=
 */
>  #define PCI_ACS_CTRL           0x06    /* ACS Control Register */
>  #define PCI_ACS_EGRESS_CTL_V   0x08    /* ACS Egress Control Vector */

