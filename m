Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B18ACD98E1
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=; b=GMw8awpPCxhmmTDFv8oVErFQ3m
	tlaAWu+u3g9noRmCDPJLiCJG7PBjbNoQ14oCAgqkF/DsnQloPdKVd3k/DAOD/FXUgp1b26BCmHuoE
	bFZQsTXbXyGq5HJ9d0Qio4oOHJcexQHCO3e8i1HTP3r6x73Kg7b8o5AGMMUzUxss6k6ydqQ5QGNIt
	7+/eF8zR56vBrTsg6iOiVBCkzGrpZ8yFGidtyCxEUnbSpPlszphlFb1HMmFayEfdWGGgkoOAubifu
	/Fl0PupyNR/FhiIDATxyAf8Kou5yahFMM8Bp/JbP7rxNPrT3zYC9CvMukeALm3YDbAAVbswAPapzk
	hoOi5XXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZc9a-0000000GNXg-0fDx;
	Tue, 16 Jun 2026 22:21:06 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZc9X-0000000GNXJ-02Mz
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 22:21:04 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1384ebe7a10so207570c88.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 15:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781648461; cv=none;
        d=google.com; s=arc-20240605;
        b=aIZVaqAaxlZufxBSKY+iPVLiojkk78+4iHULNzvcfA22Ovv4EOVBAK8vWAIArWpoGm
         9/RkA+6A4/RmbAWZDbYm6D1QrqPL2CJjVGgph7YkcJ2n5tBvm71g82Qlj8dQbHd7NK7l
         JKv3WPYNIT0t0Mzt59C0xXdx4vDa0mZwhNVRQDhJEhtfvqXi/4W37p/1ebbdQYiyV6Bd
         vMDLY5xM42WM2SatQiY/5Kpk4eghlL4GSbitkn500Lw7wHIsazTI9HL7S9Snef5+DgbI
         WkVShs8qZv8pc19kHTuilrbnKEIOSE+Gy3s7Dgk0zJXbpmpbx1b1O6NY0H86eeTfK3iu
         aiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=;
        fh=z0UYNzvAPrV9W9ZVbVCB421wEVDM0g/iQzNLZPDoIks=;
        b=VFzKjm7DnkAVoK1u4uuMWAHZD3Q3C6TNcw7asyWS7BiH02p9uzmowvgimdb/28F2W1
         jdB5dPOE6HT2b9nDzRJEONrMtpxBEcAuDc+R2VG5xxbT8TpRIQrwE6WMM+l0jBBERoiV
         W1fPRDhGE0mU7W5MG7IRgSXsPkmirDNFcec/cIlyWyWQQriNzfkseWTm7+YFj5+PdPCQ
         HHcohao4ZTaLQ8t8ikswJDsjwm9Kfl4gRHkLdAS6RGPR9Y6xWAZw3yWX1WYXXB88zALy
         z3cqpzPaXcyK7JYmxM1S4t6qGytpgBW9DUkr2Y9yJUjQVsdxnUIput3SQa/VR7xT+ceq
         RGaQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781648461; x=1782253261; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=;
        b=Xto5bUruwW4VbGckEX4TeFCrOffUB21BY5qN9Kk6EbGe9pBFlTp9jiemGlJ7clxkCB
         XTTqAJ6JU+nwj1bCtixq8dr+YWg+X3UZD16B9bLdL/jafQQz91gxVqI7LyjrE9+AJrHU
         dnFqi/0qvmslW9uslrANc2BAfytDXfvwA0QDxhjQW6HKGPJTT3pP+4cZiiyCDBlWv+BC
         YCmkRW593X4oz7+oLglUJbz9mRtjt7MVoZurGfxC/BimagHVOWEskjtR+9t9X2DVlDxi
         4knYo4S1MW62bzyaGfY6SZzjJQNFeBWqs1/cFAdPJyh73UwNGiXkwLgSwTd8dibF9KAs
         Lffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781648461; x=1782253261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=;
        b=eQHYWZCAPYCBVAfUjiDe9HxCDmnSRYDRtP4FGm1CRi6fCajnlUkCUiXJ5b6NMy7/4X
         u3LGGb1+JiIcSVP9b2L9o52DAhu/WxQ6WDezMjxDUE/EnxNqDHjtlIjyroc5fyjImISY
         efiOUlj1Nxioney2KC+YgwIpeUebAtE2YaZ1XnX7CRIeTh0ggr2HZsYYee/5Y60GWPME
         0NMCRFKI9t0GbvhMf9ykjMfbUq4rjNliN/7lOs/WJkLUKdry6ptf+R7lktVlIYoOUWPA
         tRzCu8+JW3PyoUUwwKYNcWRzODTV/ROnWWNaiAzWt21UwcPAuD//uqU56bQowOqOVdgD
         CnuQ==
X-Gm-Message-State: AOJu0YxN0M033pON1OEEKO7IXYCmUuoQ5ZnR4Qp/mXlA6SYESfVpDE9n
	B/5VxuBCNB6PcXZHzTjaKdmcJpMZC9KNAS9+7rpdMcXVy9SE/QRRWTu5iay3dC23wdfyvOOse1d
	aPtEoscuxKOhl3aJDp/wlt7g6D3ex58JIR6cuoilQ2CKTMG1zyzYeyEv0
X-Gm-Gg: Acq92OGHUaVkenQ0RsHOcl1/gJGbTFjkMJw52IJ4udNfi29hl5Zq6I+I1cNGTVM5bWp
	cQmaZpQUI58VGJ1u/6ij8V8bv5vfV6OoOBJajsutLA8YwExVdRr+CLyNyqvoIHpvKHj5bnTEjea
	7GFKGBR/Et9xJojRfF1H90YllJ/CtN+GqZz+QTBvFP4B4/iNjpD2FrgTrm01/zQdeUmjuiIC5Kg
	RA0J40hwAJXXJYuNX2gI4kn9Gcmnd9151hYSoBOtZcfgVFmBVgwH2iY+C0X1wcxIcJ31kKggrQp
	5XAhpwk=
X-Received: by 2002:a05:7022:6ba8:b0:136:ac69:b0f7 with SMTP id
 a92af1059eb24-1398f680985mr453889c88.16.1781648460211; Tue, 16 Jun 2026
 15:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-4-dmatlack@google.com>
 <ajGpxMXk9iyXLzC4@google.com>
In-Reply-To: <ajGpxMXk9iyXLzC4@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 16 Jun 2026 15:20:33 -0700
X-Gm-Features: AVVi8CfxK4mMKiv0sputj5dz4geA42BjbfG1FN5Obs96hOQRjIUk8-dblh_dgDE
Message-ID: <CALzav=eo=UwoTNTYM8Z7uKoihxfB7NtVP701qidVgoqyBKhUig@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_152103_090828_9664CED0 
X-CRM114-Status: GOOD (  44.92  )
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

On Tue, Jun 16, 2026 at 1:09=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> >During PCI enumeration, the previous kernel might have passed state abou=
t
> >devices that were preserved across kexec. The PCI core needs to fetch
> >this state to identify which devices are "incoming" and require special
> >handling.
> >
> >Add pci_liveupdate_setup_device() which is called during device setup
> >to fetch the serialized state (struct pci_ser) from the Live Update
> >Orchestrator. The first time this happens, pci_flb_retrieve() will run
> >and convert the array of pci_dev_ser structs into an xarray so that it
> >can be looked up efficiently.
> >
> >If a device is found in the xarray, the PCI core stores a pointer to its
> >state in dev->liveupdate_incoming and holds a reference to the incoming
> >FLB until pci_liveupdate_finish() is called by the driver.
> >
> >This ensures proper lifecycle management for incoming preserved devices
> >and allows the PCI core and drivers to apply specific Live Update
> >logic to them in subsequent commits.
> >
> >Drivers can check if a device is an incoming preserved device (e.g.
> >during probe) by calling pci_liveupdate_is_incoming().
> >
> >CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> >domain and bdf can be guaranteed to fit in an unsigned long and be used
> >as the xarray key.
> >
> >Signed-off-by: David Matlack <dmatlack@google.com>
> >---
> > MAINTAINERS                    |   1 +
> > drivers/pci/Kconfig            |   2 +-
> > drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> > drivers/pci/liveupdate.h       |   5 +
> > drivers/pci/probe.c            |   3 +
> > include/linux/pci_liveupdate.h |  13 ++
> > 6 files changed, 251 insertions(+), 3 deletions(-)
> >
>
> [snip]
> >
> > static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> > {
> >-      args->obj =3D phys_to_virt(args->data);
> >+      struct pci_ser *ser =3D phys_to_virt(args->data);
> >+      struct pci_flb_incoming *incoming;
> >+      int ret =3D -ENOMEM;
> >+      u32 i;
> >+
> >+      incoming =3D kmalloc_obj(*incoming);
> >+      if (!incoming)
> >+              goto err_restore_free;
> >+
> >+      incoming->ser =3D ser;
> >+      xa_init(&incoming->xa);
> >+
> >+      for (i =3D 0; i < incoming->ser->max_nr_devices; i++) {
> >+              struct pci_dev_ser *dev_ser =3D &incoming->ser->devices[i=
];
> >+              unsigned long key;
> >+
> >+              if (!dev_ser->refcount)
> >+                      continue;
> >+
> >+              key =3D pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> >+              ret =3D xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL=
);
> >+              if (ret)
> >+                      goto err_xa_destroy;
> >+      }
> >+
> >+      args->obj =3D incoming;
> >       return 0;
> >+
> >+err_xa_destroy:
> >+      xa_destroy(&incoming->xa);
> >+      kfree(incoming);
> >+err_restore_free:
> >+      kho_restore_free(ser);
> >+      return ret;
>
> Hmm.. This is interesting, so the KHO state is freed and it cannot be
> reused. I see you already pointed out that we are putting an LUO policy
> to say that the retry is not allowed.
>
> But what should be the behaviour of liveupdate in this regard? Let the
> system boot in a normal way? This might break other subsystems as they
> might depend on PCIe restoring state properly. Also I think some of the
> PCIe state, like device-id, BAR addresses, ACLs etc, might be used as
> source of truth by other components.
>
> For example, lets say FLB retrieve() of PCIe fails, but succeeds for
> VFIO/IOMMU, now VFIO/IOMMU are restoring state of a device that is not
> restored/preserved?
>
> Should this be considered fatal?

If PCI FLB retrieve fails then there are certain things that cannot be
guaranteed, such as BDF (B specifically) remaining constant. This
could lead to memory corruption as the IOMMU may have live
translations in place for those specific RequesterIDs. And, in the
future, preserved devices may be doing P2P which depends on BARs not
moving. If the PCI core cannot retrieve the FLB saved by the previous
kernel, it cannot make these guarantees.

So yeah I think you're right that PCI core should treat FLB retrieve
as fatal and just panic.

> > }
> >
> > static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> > {
> >-      kho_restore_free(args->obj);
> >+      struct pci_flb_incoming *incoming =3D args->obj;
> >+
> >+      xa_destroy(&incoming->xa);
> >+      kho_restore_free(incoming->ser);
> >+      kfree(incoming);
> > }
> >
> > static struct liveupdate_flb_ops pci_liveupdate_flb_ops =3D {
> >@@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> > }
> > EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >
> >+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> >+{
> >+      struct pci_flb_incoming *incoming =3D NULL;
> >+      int ret;
> >+
> >+      ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&incoming);
> >+
> >+      /* Live Update is not enabled. */
> >+      if (ret =3D=3D -EOPNOTSUPP)
> >+              return NULL;
> >+
> >+      /* Live Update is enabled, but there is no incoming FLB data. */
> >+      if (ret =3D=3D -ENODATA)
> >+              return NULL;
> >+
> >+      /*
> >+       * Live Update is enabled and there is incoming FLB data, but non=
e of it
> >+       * matches pci_liveupdate_flb.compatible.
> >+       *
> >+       * This could mean that no PCI FLB data was passed by the previou=
s
> >+       * kernel, but it could also mean the previous kernel used a diff=
erent
> >+       * compatibility string (i.e. a different ABI).
> >+       */
> >+      if (ret =3D=3D -ENOENT) {
> >+              pr_info_once("No incoming FLB matched %s\n", pci_liveupda=
te_flb.compatible);
> >+              return NULL;
> >+      }
> >+
> >+      /*
> >+       * There is incoming FLB data that matches pci_liveupdate_flb.com=
patible
> >+       * but it cannot be retrieved.
> >+       */
> >+      if (ret) {
> >+              WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
>
> I think this should probably be considered fatal as mentioned above or
> the caller of this function should get an error so it can fail. I think
> retrievel of preserved state should generally not fail unless there is
> memory corruption or ABI is incompatible.

Yeah. I think I will just call panic() here to cover all cases.

> >+              return NULL;
> >+      }
> >+
> >+      return incoming;
> >+}
> >+
>
> [snip]
> >+
> >+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> >+{
> >+      return false;
> >+}
> > #endif
> >
> > #endif /* LINUX_PCI_LIVEUPDATE_H */
> >--
> >2.54.0.746.g67dd491aae-goog
> >
>
> Sami

