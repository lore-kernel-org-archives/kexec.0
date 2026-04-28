Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C38FF885A
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=; b=Tb4dYDlvnnaeuErkLDLfywgQRd
	WGhSaGZTSssLJbxpOGQ/givgwZ9fhBpr/455gKYmhoqe1vlqpFMazyFtWmabMwJ5iRAC9Iv4uIHKx
	Y8+prKoW4bHdIxovmSKk2cP/VhPoZSQbEHX52iOlp7XQXwLJbblIGB3OwDzaZdy84VtGTO0A5PGCt
	2HOjxnjGwFyw7jC7Vx2mfkDkol/J9FhzVXU9W4gcZG9XwE//Q7boNLGkxzbR55DOSubDzgCyd6rBm
	ikn/vnfIX9+dN5smHlByEvPaqAOoI/ftbxko9j1Lsc5QfD3Vi2DNpTk/r6RJAdOHCLG0MDQYOKU7P
	RMxHRqgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHpjb-00000002VTh-3F0N;
	Tue, 28 Apr 2026 21:12:47 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHpjY-00000002VSq-3S7J
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 21:12:46 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-38dd575bca3so2573701fa.1
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 14:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777410761; cv=none;
        d=google.com; s=arc-20240605;
        b=c//HVmkPnPqCT+xDHmNX7fNw0WipV+J6LaA2pKnRHN4rSs9HEhLKbE3QJBakwUlZSA
         Or0iBzaswG8XinKklMlOLz0Bj/Rl5YDKppfMGae7VcHnHOnaQXtCUClH+Wly9wqMg8wH
         LufupmowgTvobYUfW+sOOu4gOTa/mFLSOWxcnieU/ciHePB4GhYu0+u4jV63j52CofN0
         qyIQrpoPwWUDnSdfhwGhpV+nAH/0wDj8xx/MK26nNO1GPUjcYswY61AugVhCjUhtCpdp
         VvNiTx9QNs4Ijjk8IystSqbxcJENeQRnOGYHuAdBAo51tKTpX5UPkkYuvy2rSSc//AN4
         ZDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        fh=pCBhO8c+SzVo/PVCqHtErP0AdMBc3xidHE7k6SqvLWk=;
        b=SIqrRN5kZphdj2fCjokyWky3gx7Oedax4D8ezSeFPBjGI+XIzSYKSSkdcexRVw7aSH
         bmB17Nv0VRWlR1kfiShIq89xH4d0DeDZC4lZVsqWw+cXVAaUnaueOCFv3+TvRo0l6O6a
         /rDBgxtKp2/NKSm9WCiJ+uxOyIgBkMY6MPI5Yx6kew8wqOPrCL3+W2/r1xPw1ZLdtnwu
         Rzzhg4aMueDjT1x1gjZx5irvK4UkiSC+xs2ZWlcac0pBaktKcsTjwQL67/0m17SIN9JW
         EVNW5YEAtfjlxD3Jhug1gwtx1sEVoozlRy+cj6p5Pe5YIuPmofWRYTGwWYlqKw7FuBqD
         wCmg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777410761; x=1778015561; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        b=dzKZrX6IVyPS3uGpAaFRHm7y7mGYTPEHM3Xoh7gdANXxsoTLJ3LUSLixMXVUst0qDB
         lS5U6ruNCAJtMYYpgB8rQKK1IeiyPEzZzP0ivIMzSF8XKji+fKmn2eqPlcZE8GslIrwb
         NzsnH1vyFd+q/BiExy6KIwfnHG5WATHNdKHByXzOQjMycmRb8viGQw9IWX2uGTXT1s8/
         sinr3DwfoovNvBltzBKxek0BrkvdjEj/gWhmUWIww9zxbcf3kN/wka9+3ZJQIz0498GU
         /thnZrf9HvM4wfhZykNbYWTVdaGipaoQSFvDUnK4p5e5QCJ/4dajNPQI+flZTVzA3ZfR
         AM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410761; x=1778015561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        b=jf75+qJTxapMYyddt9qZu8lfvZQMF7qKhJFWEz8M2BsY10PoB5/VR6y5Zrz9Rl/OKG
         G7E7UPnEeym/NIq5U9mP+C5vK/sQh53vSYztL5ZBjr8ON0nE+T7iW6FYKXp2VkApULJp
         yoMN3Ba69/7NuGd2l79YDywoq/344d1Kw+uG0olYztTeL27a9K8E8E5Q7GFd8BFgB7m9
         20HRs/SZS9T858E9oyWV/BFEorhNA0R19UF+v6r3vob4QIdtgexWX2dWeyUITnppIaYU
         2vDW2z10YUxma8z+njRG0iNWhU1ZuvMQmw7QnxrpqVd2ssbvdH+7XXjXxTZuUlFN6yu1
         hBbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yLOBZnjruNHDuBerWUq8YFnjRNfWlmv4uCvDxOVjJpkGYdpLaJuEkkp1Jnq5LCnUm0h8t3w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyG7mYXEY9CHZHM/OQSuQNEhWyItNN+J8VzKD5NcYplq355oaZ4
	qpYmGH1uIJs1vBJ7okHKVigHdL6FT69jlWMjhS5iVdDqdR0MMUM2zAcIHooQEOAG2rh0vU7OH8T
	ds3AV3wRBAnDL/wxRy6UZcs0P85goveQlAw9+mwY2
X-Gm-Gg: AeBDieuXTdBRSWyxMOVfHvn5h1MCIHS8nZrdP7bko0gEfCxmr3Buhh9lHirM/DeAZho
	xPNt1GOwxtWz5BpuFLjjD0D7Gi+ZotKDpEysb1F9QxWFiMnyV/scMylIh+ltvTVUTX3CEQGocPJ
	yurpmX+j+yOTu3sZ4LOhzyrBE7sh0xepIPwomR9+XATYvm5mo2VqUu2By65IsSiAWzWj/kBdZCd
	0j1C61g0A1LKGXNhg+tsEm8210P1BMhfXbxYmVfxUtOoChZ1MKKPjQxw3RDKZn1Bnt2sfhOUZlR
	SkdKoIMuwZWv9z5n+/hXSIodj+oiQA==
X-Received: by 2002:a05:6512:1390:b0:5a3:4692:61ce with SMTP id
 2adb3069b0e04-5a74a32f180mr148152e87.1.1777410760874; Tue, 28 Apr 2026
 14:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
In-Reply-To: <20260428201231.GA3885809.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Apr 2026 14:12:13 -0700
X-Gm-Features: AVHnY4K7jpha36hMRH-mQGhZech3LSC3uUxVbVP_4PPgBDawCFAtuaz99Nxadcw
Message-ID: <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_141244_956650_41FF1126 
X-CRM114-Status: GOOD (  25.79  )
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

On Tue, Apr 28, 2026 at 1:20=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!ser)
> > +             return -ENOENT;
> > +
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> > +
> > +     if (dev->liveupdate_outgoing)
> > +             return -EBUSY;
> > +
> > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > +             return -ENOSPC;
> > +
> > +     for (i =3D 0; i < ser->max_nr_devices; i++) {
> > +             /*
> > +              * Start searching at index ser->nr_devices. This should =
result
> > +              * in a constant time search under expected conditions (d=
evices
> > +              * are not getting unpreserved).
> > +              */
> > +             int index =3D (ser->nr_devices + i) % ser->max_nr_devices=
;
> > +             struct pci_dev_ser *dev_ser =3D &ser->devices[index];
> > +
> > +             if (dev_ser->refcount)
> > +                     continue;
> > +
> > +             pci_info(dev, "Device will be preserved across next Live =
Update\n");
> > +             ser->nr_devices++;
> > +
> > +             dev_ser->domain =3D pci_domain_nr(dev->bus);
> > +             dev_ser->bdf =3D pci_dev_id(dev);
> > +             dev_ser->refcount =3D 1;
> > +
> > +             dev->liveupdate_outgoing =3D dev_ser;
> > +             return 0;
> > +     }
> > +
> > +     return -ENOSPC;
>
> Since it is executing under a mutex, and we already failed
> 'if (ser->nr_devices =3D=3D ser->max_nr_devices) check above, will we eve=
r reach
> here and return -ENOSPC?

Yeah I wouldn't expect to ever reach here.

> > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > index 5c0e92588c00..5b4c8d9e462c 100644
> > --- a/include/linux/kho/abi/pci.h
> > +++ b/include/linux/kho/abi/pci.h
> > @@ -23,19 +23,20 @@
> >   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE strin=
g.
> >   */
> >
> > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>
> Just curious, why did we change the version here?

Because a field in struct pci_dev_ser changed.

> It's not like just
> previous patch is working enough to perform a live update. As the config
> is experimental, can't we just keep it PCI-v1 for the whole series?

What is the benefit of keeping "pci-v1"?

I think it makes sense to follow the rule we set which is to update
the compatibility string in any commit that changes the ABI.

