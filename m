Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C48F54AD7
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=; b=vjCUwlfpXLtb4Rm21Q+kK0XY01
	0iqg+jVebG0ow/pTXnFB19fU3DHAwnrPUffgF74CV3pOLgXABOkryFEL9YK22akukNi5Rl+B+EOib
	VUGh2mK9H7nrpVjbCuBnaKLSHMGNhwYEFaCBY1GER2PGqKLWjpM3mgjM9EJvT3quOY3zHLnSS7DTR
	rKYdcgrTmX/Q7DMy9OQFBVrio75ZiWoClvjxOVLyPCEBqLvPOPxeR+FaDKGhGXehX4lbhqE3Y0scc
	6rktSywyzPmAsTHotGe31ugy8MiGk4kCK3jVOtjqLIIYHGTZC5WDBQ6hODMhJOC3/+jtEVfplVvnw
	/bNedLow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w54hO-00000001tT5-1m1O;
	Tue, 24 Mar 2026 16:33:46 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w54hM-00000001tSD-0awL
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 16:33:45 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso4294783e87.3
        for <kexec@lists.infradead.org>; Tue, 24 Mar 2026 09:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370021; cv=none;
        d=google.com; s=arc-20240605;
        b=WBe7VR8KkPK2gYoQAPkNb3MzmcxEIw7Xd74LV2xykrtw5fUwilWV5x+wHARhhMngH/
         v5mCJO2rMasBeVImDLJ2cMp1Sq/u3t3/RdarDbah9V32PBhWyV5DBvDx2ckxS5wu1Npy
         fWu2kIU7O8ziDPy1tQio+bdYukYi4gN5uCTJ17G/8AnsEMm5VT3GMXLtlUs+QcB2zqBd
         CxkJO3o9Y9PKUvEN13KvweCXx6gPKrv8m8R9irEco52X1ySo8m+Ty0YZOzRG6x+9dpdM
         w8VN1WXcgT/7tipfk9B3HCGGtlYgfUasIfAIA5SaCGSm9ue1kfcDPxKav0LcV6s1Hpnr
         BXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        fh=YZMsngfq/EtIqmOKQrTmbE1kAzHf/KyQw+ctolk3hTA=;
        b=Dk/MGFKkHGrWhsZZkzvIFPuc082VqggqkxBY3Gn1h5yxjA3xe7FaqA94g5SNCKlvt2
         Y22lYPlDV7uv7U4z2U0C7A4NetpMHz6lH2lAAqywwhJZFxELofUNaZU3RVI5TTQQK8/h
         rdCatdltvNZqnIUse/isUJr+Ei38JByNXz+EFs4q8S6dQDOx1e4AKluQStpaIVFLDzOV
         syA+7rVizgbrZ82HoB4v9xQc+3XsajM4DOy93IRXuIGexp9wFqdYP72oO0wFygsbWF9v
         uI6GYqYBpr8ddQy0qal15PJEbj/TECDy8rTdXA3VAYlsyc18kEnwYZgeuNsQFpWDFR+b
         018w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370021; x=1774974821; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        b=dXflXcOiIR+knOBWCoAUVeQ935a1YEoyOCueAxPaNue5GJYueA2LS9TY/SCrPnPU9x
         9kEwCEi0rrN3GvY6ZRw8NtWtue3uU8LDP0Kbe6cs4vGvHzzLTGChtYYVxTd71YCdYSwY
         IFwteZblppFYeYMxCr52WcIkKOZxrJgMF4AQftZUetVKv0I4VEcty6kkRkNJ6ZTqhFCC
         67KNiSiu25wi3s9mwWEbKhasTQO6E19k4O+CLIGMmTu+QJHhpFwHs9rjQdp8rqqUctkn
         NvpPmhlPrOKXl3pLRjgVVQtfMQYmYuv97ghPI5Dty6P+AAXJx+jh5VMIUQQE6X3gygIr
         DCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370021; x=1774974821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        b=eHbFQmU4JquEGr7+2MHoA9+xmDdiuRqdYETlqMWFZS4iGGWUujIAOIQ9PF93kgqmxu
         XBT7Q6OZa/Cv7oPRWmnTF8tQjbqeCdiqYl8aWu2/nvqnsoEcw4wEX1FjcE18e7LUf/gB
         OAq9pOo6A3xXIroeq3p5nPcH08dKZPCXZboQ291XW/6Lw5zLnV6pmqnsgmdZt3wJoGSK
         MSZWqP/eAVkml1fRFujM2MgG4R7GZaxuCq49uHd6S/RiQeV8QaPKgOInU7b67xsg7oI+
         hhtjrGopciTEnQLfzyYPgOJeM2VfhwYKImsug2WIu5Kt2f7bTV0PjNQPUJa2u/twrjWz
         ixLA==
X-Forwarded-Encrypted: i=1; AJvYcCUAiuUxhLGTc2R6cEtzreuwzkOwD4aed7oqQAS+hTgU2hTd09WPL2vERugy5XEJJJrEMUUPRA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzZVP6FgoT+awg61+DX2hjxvEQPtcOLlscEdGblcJlI1DHBSWck
	cnv7h83/q9h+rU9uDZIqGT6q6Eb0stAgKsBh6uxOebUzlQ+Tzg+v6AJZbcxLeO25RN+ZiwWNHP0
	DZs8be1EBFSUgU0WKiFgHq3aqW7VpeaREBz0uxbCN
X-Gm-Gg: ATEYQzxEDgkPm/zNUd73gJGUUVDGqEVAEOuJbiZL2dwKkmhcDjFAACyKnaHFv2cnaP4
	zJsABSyPZTkO+Vj1WGsuCogiM3HVnC3r+K/m27he2hrEkcVlV8/9BZakIf7QYYFDscHloZWCPrS
	4SfBibuzeLhPozpsZa3FeEa+1biBeBYNaGPgFCZ+0FZyxf+0EdD/3aaKU9uLjH96cjY/zFxzefs
	0rxEwwC849xYq9Jlh4/yKMOj+N63qbCEYsuHsQ1Sb2TkVYP1+CWEPZOfoqTkYTqlILx8JtoCMyr
	gX6Gw/4e
X-Received: by 2002:a05:6512:3044:b0:5a1:1899:a0cb with SMTP id
 2adb3069b0e04-5a29b9a1efbmr55664e87.34.1774370018671; Tue, 24 Mar 2026
 09:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-7-dmatlack@google.com>
 <0d2eedec-01c1-41c9-bc74-0133ae6ebb04@intel.com>
In-Reply-To: <0d2eedec-01c1-41c9-bc74-0133ae6ebb04@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Mar 2026 09:33:10 -0700
X-Gm-Features: AaiRm530aoKtDDdSXYb9CaNnVHDZa0HeKfsko4zWVykFU0w66CUzojlEOk9szPI
Message-ID: <CALzav=d65Z1Va14rmoRcx5WrK1GfRvuHmrqK16wJJeTiq28eCA@mail.gmail.com>
Subject: Re: [PATCH v3 06/24] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_093344_223341_980F537E 
X-CRM114-Status: GOOD (  14.20  )
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

On Tue, Mar 24, 2026 at 6:00=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
> On 3/24/26 07:57, David Matlack wrote:

> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -170,6 +170,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
> >       ret =3D vfio_pci_core_register_device(vdev);
> >       if (ret)
> >               goto out_put_vdev;
> > +
>
> a meaningless line here.

Will fix in v4, thanks.

> > --- /dev/null
> > +++ b/include/linux/kho/abi/vfio_pci.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
>
> would be nice to update 2025 to 2026 now. :)

Oops, missed this one, thanks. Will fix in v4.

