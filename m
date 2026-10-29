Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F80606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YkAGGopE;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XMpB9utn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=; b=YkAGGopEaNLAnp
	MYE0EAip4aCRmlsxnH4+jZFhRALOySSwbRHzQjwIqU7l6TBETP2nqjSXTyRB1dDfBBakWFmQmGHqU
	5R3mBY88ULoem6p1FxTz8HB8L84TGSLpVrLvSnohOpNgiWwneFPHAeHS+9v8BAdUHAeBd8hmO/9Io
	zM/mvhM3MoEGiRa+8W/uX78YqJtYLlOFqk/l8X6N7Kp/OgNBfdYKurThPcv0njuP5TZfg6AoGuTyX
	2BMiUIRmVltE+gX1Recbvk3HIWuuCW/bKO4buPKdNHTSRd0BpNVJzR8fwKGiPuk8OFVhnIQ3JXu1f
	ol4zhK9ItcAPFFQBoMDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUWW-0000000A3Ci-3H2x;
	Thu, 29 Oct 2026 18:06:48 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUWU-0000000A3Bq-1ASs
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 18:06:47 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c46822eefb6so319883366b.2
        for <kexec@lists.infradead.org>; Thu, 29 Oct 2026 11:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793297203; cv=none;
        d=google.com; s=arc-20260327;
        b=izMX7ZLmdLBPYL5Wbbq2gDKL96D3dCSiBY2dwrT+uEx30QftYyN7ftvWY50PmBGCgb
         VU4cETJxmszF0X5I4u/CT1SROwqz/Un7Y1FNxdjSMN0ZQqBnjlPOp5I7/Y/gyh4gZCzm
         AGqNYEFWjXWkh2McDbKgDRZiCNpaJbP6UPrYC/liEtoowM9XeNVxvhUL+AtwY+ohX4QV
         y8HJbqw+ASP+OSngFM6lUXMq5BhR6k0N0sloYC1aaeT3AF5rwl13Oee6cRDlic7eefB6
         dYa/BEX9Enpb27hzC7yQvXyb+X75Pu/dMmgUgsLFyDLqcU1HQQFDmrCoe4ax0G/REzSC
         hoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
        fh=BRcrV02BlpI2X2+kz+B2+WxDYVxFQVqkuGjPqmJK3T0=;
        b=GqlISu3SanaOr33s4giAttirqq9B6vyyX4/VYxOcz0FHtk2128ZeiV321mYyr6sPEo
         dQi81qyNF5ObFG/FRwA9xcFZq8vdVDPQp2tkJYbGzFPqHOIz9HXUt54NyWV0ktkqU35P
         2x7S60gNzhjNAR8iuBal2GN1qTUZzr4jgsP+b3N4Gl68/UrVFh0PUgV4MRYdQCvv22R6
         q8gI6VV1XQyLmqFx6ne4pZoV0lvx3bcE7mM6yjE4FG949GFbxK7Fdd/HRTX2YkMKVMei
         kWqldWJL6H/o9JOp17kN5WiqWcpdGmOsVrt68xQmQwdhuscFr6dvil6lmDdh6D3rp6td
         lC0Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793297203; x=1793902003; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
        b=XMpB9utnmz97bdMp1oPLybw76mv67kw4fTKUKPR39tOzNoHC7+XRY7O69eYgNOl9AZ
         orKzPZJQEWUhQdZK1aRejuvwnfttoRqQJjcZgkhQDEC9t4tt807rJoAorR4L0XAFRNyz
         HR9vSIehkbfcHYvLwSu9DMghJ62piqI8hjUJnHqzic45gOUjAshMaW3DQmpl7HJKnzmA
         iQABbmgLKhMVdggV+NLtuiJvF7pIh0o1yRctunrYXJt3MxpG5eRvWhVHvBQhH0q26Kle
         KnmE0OOBZjUUvcdnWfeRkhuhlwANXArtGJZ0KVwFbHkpWkOUqOBD79RJS3u+Uz27U/jg
         0dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297203; x=1793902003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
        b=QnfBHLfAHmuZ9yREkLf2/KMVxZPdBxyRJRA1dTGlHOXrG3euswz6/r1w8PAS4m/dJU
         ytWvM8jyUcg9XnsgwkRknros9cXwXzvjI5P8ZZbArELpYHRLyD3NJMKNSut2iP6cNJaI
         mqtc3cyv652FmHubvMlbp63hKuY4Df1oqBnIM/RmsiRvfF3eaZqY4Cm15/SDdO4cmy1H
         XeTfWY8Dnfenp8gx6Y0JhKM5RKGABC5NlfWkKc8gW72ZTvOjqV2fr5Mmud4MgfCfB/gk
         gIVeNJEC6ugL2cv0re0BytpfxfxRQVUHTbm6gheNOeMriymgAA6n0Kf3W/gEzqbyUs70
         QKTA==
X-Gm-Message-State: AFq9FYLRfy2CYtV3c6wrNUIZYqyjVTcU2Enx/PrSGtxt3guo+NZqCp5V
	xz/aCCXJQYO9RK1y0dkTiiqoP1sMyr2w7JmIWxKudT3MJgwCSwAfyE23OvB4DhtpIagPGAFPwBA
	cmrsn666Q8XmUJElh7Ta2lWSfv/oLdLXAOOolUTDnNWKFaMbhqsEDwXMGNka3+w==
X-Gm-Gg: AYBFou3dvPaoVFLLWHpTGatiJeag6JkQYZyC6czAf9yRNU1HGzsQ8MG3+oJBOfaEdpj
	Rq6k4BeryN5LbuJh51uzX4JuJCTnqXoAzQgGbUt0KMDsUhEK6nt7ISOw56odCaC1cH4G0Ywm0ax
	ctefdXC5w3llOrBNDImrNsyrWyhXJ4zXl3roj2WsgGgSLQxZLhqBPNWNt7Yra66ulBlR/fcTho/
	LzrNAnUPoOlyP6Qv4hY9BwY7QWkHIvooRuOV9bCmKUXMjU+0ck+gFoQ/blVqIawniYbPBID9WTP
	miZxNo7Zpi3GrWjM37Lk+a6ckXTtmD/m8/rTuRBwea3ndocP5B2gCc1cNgF7PMrDYSdjpAOMqY7
	zQWn/cUQZ67dH+O47IISwJHRVXkvhb46V0ejuKQ==
X-Received: by 2002:a17:906:7953:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c49bdf3e797mr571689566b.18.1793297202249; Thu, 29 Oct 2026
 11:06:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com> <20261019213054.3157159-11-dmatlack@google.com>
In-Reply-To: <20261019213054.3157159-11-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 29 Oct 2026 11:06:15 -0700
X-Gm-Features: AclHuK_cLRpus0bFwOM3qezLRphS7L77ne14GXebvql4AuxivCEsM-6MlWYX4p4
Message-ID: <CALzav=f8+pTJ3m+99=85ntwouUePzzQBA2RJQ5Ogg23J-5rfkQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] PCI: liveupdate: Avoid enabling INTx on incoming devices
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_110646_400398_8CC3D71E 
X-CRM114-Status: GOOD (  46.28  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 2:31=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Avoid clearing PCI_COMMAND_INTX_DISABLE on incoming preserved devices.
> Pass whether INTx masking is broken on each preserved device to the
> next kernel instead of probing it, and skip clearing
> PCI_COMMAND_INTX_DISABLE in do_pci_enable_device() for incoming
> devices.
>
> Clearing PCI_COMMAND_INTX_DISABLE enables INTx on the device, even if
> only temporarily. pci_intx_mask_broken() probes whether INTx masking
> works by toggling PCI_COMMAND_INTX_DISABLE during enumeration, and
> do_pci_enable_device() clears it when a device that is not using MSI or
> MSI-X is enabled. A preserved device may assert INTx at any point
> during the Live Update, before its driver in the next kernel has set up
> interrupt handling, so enabling INTx could result in interrupts that
> no handler claims, on a line that may be shared with other devices.
>
> Pass the result of probing as a new bit in the probed results in
> struct pci_dev_ser, PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING, which
> reflects struct pci_dev::broken_intx_masking. If the previous kernel
> did not pass it, fall back to probing INTx masking.
>
> Drivers bound to incoming devices are responsible for enabling INTx once
> they are ready to handle it. pci_alloc_irq_vectors() already does so
> with pci_intx() when it falls back to INTx, and vfio-pci clears
> PCI_COMMAND_INTX_DISABLE itself in vfio_pci_core_enable().

Thinking about this a little more, and based on internal experience
with Live Update within Google, the kernel should reject preserving a
device with broken_intx_masking=3D1. Otherwise, there is no way to
ensure that the device does not assert its interrupt while the kexec
is ongoing. The kernel would be forced to mask it in the interrupt
controller, which means adding even more Live Update support across
the kernel, and which gets complicated when the interrupt line is
shared by multiple devices.

I will reject devices with broken_intx_masking=3D1 in v2.

> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c    | 37 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/liveupdate.h    |  6 ++++++
>  drivers/pci/pci.c           |  8 ++++++++
>  drivers/pci/probe.c         | 10 ++++++++++
>  include/linux/kho/abi/pci.h |  3 +++
>  5 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index ac4525568818..8a74762c3f7d 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -216,6 +216,11 @@
>   *    bridge implements), since that would disrupt memory transactions
>   *    targeting the device or devices below it. Instead, the previous ke=
rnel
>   *    passes the results of probing in struct pci_dev_ser.
> + *
> + *  * The PCI core does not enable INTx (i.e. clear PCI_COMMAND_INTX_DIS=
ABLE)
> + *    on incoming preserved devices, neither while probing whether INTx =
masking
> + *    works nor when the device is enabled, since the device could then =
raise
> + *    interrupts before its driver is ready to handle them.
>   */
>
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -650,7 +655,11 @@ static void pci_liveupdate_save_bar_masks(struct pci=
_dev *dev,
>  static void pci_liveupdate_preserve_probed(struct pci_dev *dev,
>                                            struct pci_dev_ser *dev_ser)
>  {
> -       u64 supported =3D 0, probed =3D 0;
> +       u64 supported =3D PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
> +       u64 probed =3D 0;
> +
> +       if (dev->broken_intx_masking)
> +               probed |=3D PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
>
>         if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
>                 supported |=3D PCI_DEV_SER_PROBED_WINDOWS;
> @@ -1213,6 +1222,32 @@ int pci_liveupdate_read_bridge_windows(struct pci_=
dev *bridge)
>         return 0;
>  }
>
> +/**
> + * pci_liveupdate_intx_mask_broken() - Get whether INTx masking is broke=
n on an
> + *                                     incoming device
> + * @dev: The PCI device
> + *
> + * Get whether INTx masking is broken on @dev as determined by the previ=
ous
> + * kernel, so that INTx masking does not need to be probed.
> + *
> + * Return: 1 if INTx masking is broken, 0 if it is not, or -ENODATA if @=
dev is
> + * not incoming-preserved or the previous kernel did not pass whether IN=
Tx
> + * masking is broken on @dev.
> + */
> +int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
> +{
> +       u64 probed;
> +
> +       guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +       if (!pci_liveupdate_read_probed(dev,
> +                                       PCI_DEV_SER_PROBED_BROKEN_INTX_MA=
SKING,
> +                                       &probed))
> +               return -ENODATA;
> +
> +       return !!probed;
> +}
> +
>  /*
>   * Check if the windows of @bridge have been read from hardware. Outside=
 of x86
>   * that does not happen during scanning.
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index 98d23e217308..7f86cc85deee 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -22,6 +22,7 @@ bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
>  int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_b=
ars,
>                                   u32 *bar_masks, u32 *rom_mask);
>  int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge);
> +int pci_liveupdate_intx_mask_broken(struct pci_dev *dev);
>  void pci_liveupdate_claim_bus_resources(struct pci_bus *bus);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
> @@ -74,6 +75,11 @@ static inline int pci_liveupdate_read_bridge_windows(s=
truct pci_dev *bridge)
>         return -EINVAL;
>  }
>
> +static inline int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
> +{
> +       return -EINVAL;
> +}
> +
>  static inline void pci_liveupdate_claim_bus_resources(struct pci_bus *bu=
s)
>  {
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 853c84a2c782..43af72d1e5c9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2184,6 +2184,14 @@ static int do_pci_enable_device(struct pci_dev *de=
v, int bars)
>         if (dev->msi_enabled || dev->msix_enabled)
>                 return 0;
>
> +       /*
> +        * Leave INTx disabled on devices preserved across Live Update, s=
ince
> +        * the device could raise interrupts before its driver is ready. =
It is
> +        * up to the driver to enable INTx once it is ready.
> +        */
> +       if (pci_liveupdate_is_incoming(dev))
> +               return 0;
> +
>         pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>         if (pin) {
>                 pci_read_config_word(dev, PCI_COMMAND, &cmd);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a53d0077a08b..badce31b34f8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1976,6 +1976,16 @@ static u8 pci_hdr_type(struct pci_dev *dev)
>  static int pci_intx_mask_broken(struct pci_dev *dev)
>  {
>         u16 orig, toggle, new;
> +       int ret;
> +
> +       /*
> +        * Toggling PCI_COMMAND_INTX_DISABLE could let a device preserved=
 across
> +        * Live Update raise interrupts before its driver is ready, so us=
e the
> +        * result determined by the previous kernel for those devices.
> +        */
> +       ret =3D pci_liveupdate_intx_mask_broken(dev);
> +       if (ret >=3D 0)
> +               return ret;
>
>         pci_read_config_word(dev, PCI_COMMAND, &orig);
>         toggle =3D orig ^ PCI_COMMAND_INTX_DISABLE;
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index 84a1bf71eeca..badcf2f01be7 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -95,10 +95,13 @@ struct pci_dev_ser {
>   *    window.
>   *  * PCI_DEV_SER_PROBED_PREF_64_WINDOW: The bridge's prefetchable memor=
y
>   *    window is 64-bit.
> + *  * PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING: INTx masking cannot be use=
d on
> + *    the device, i.e. struct pci_dev::broken_intx_masking is set.
>   */
>  #define PCI_DEV_SER_PROBED_IO_WINDOW           BIT_ULL(0)
>  #define PCI_DEV_SER_PROBED_PREF_WINDOW         BIT_ULL(1)
>  #define PCI_DEV_SER_PROBED_PREF_64_WINDOW      BIT_ULL(2)
> +#define PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING BIT_ULL(3)
>
>  /*
>   * The size of struct pci_dev_ser when this ABI was introduced. Since fi=
elds
> --
> 2.56.0.212.g129ede20d9-goog
>

