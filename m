Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98688F53D78
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=; b=pz7yGTLWscsUEoy48Jr04gT5IE
	25UtUCjSReXyKRUSgJ/qZakKvNXrQKJVwy8miLu7CVhJJWMPTBHJWBN0P2iODFzlW71MMq2wnexd9
	MGeoXRAJOHJZKFzcJCDabzrll+mve23u0vWd7ls/gBQyNzrQ7U/hIxvhVheVUloq12JQsguuczdae
	mfCUQbp9QQ9JAb4wo98XfZQb/VZZCXNpA4mANX8s6Y9Z6koDKjhNGUSRIpzLwokvqVgqrtbIlOb+M
	JThnmANMmGXSgfSMAZsFqKJENa0u07WvBu617ZfVuNM0PJnC3nWfUl2Uwfyp6shS2BEjaNRiODk83
	di+uhtCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BRl-00000004Vdy-112L;
	Mon, 16 Mar 2026 17:09:41 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BRi-00000004VdW-2laB
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 17:09:39 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so6849730e87.1
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 10:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773680976; cv=none;
        d=google.com; s=arc-20240605;
        b=jB8oOMKZPVO2L0njPy9EEW6JJtPKIhoCy+cOryLZoHcX5YmxowNBwSufBZ9swrefmC
         DQDEvsMbMca0EU/R8x8RFnodNnWbPBBIiSjMXJWFcX+8yQS0BU26wDKL/ktwD6prJI7F
         b5PUIuZ/XQ2J1QrkCM1QemRFr+0V4RipfZo/JuMFkf+13RFJIpk2iLDKLojsZ+E4EQoo
         mDTklZ/RLgot84TUSKFVoYo//EzlzZzYlARYcaqzNnoMfyc0OkeZhRmxQU8UJLjvk9VO
         GSWtpq5wRdNxDD1cY1m8lULfZAS2678OKyiu3A1gJY2MJTfLPF2rzqSa1uPjR4sdzRmj
         Wc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        fh=xOwGVvOYwOPU5/4Yf4omcqQjUSlieucQf8l/Z/bzOMI=;
        b=ay0RbHsudiEV4j7F6Ahfxjn3IXwPxc2d9KJfvm5zV7mn3DrY/Ko29cNO1KvUO87jX6
         RxCosn20yJSlhF2jsgwZ+DbkJuHsPUtvpyX74uShVUjmsoUBjRZ1vWpA5XI0YZIT5IKg
         5uQI90g0721ib2SWf50PGtte0dw+MTsTHxaoO3vWq9NbTr7Z5cBcYdkTyxzKFJVdB0WX
         jie37+nN7KV+u7xrhC6W1zHz96XzdUZJ8XqWVdvaQYVrop1vIdtO8KU7GCYHE7KTpHum
         qcQC29So2KHx8yHlA4qKtvegMHxSryfZNUDvpUU/mQ4VFDMpZ4E8yox9c4qpnXBtQgG6
         89Ew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773680976; x=1774285776; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        b=XCAYw7oL0l6Oap/CwUowmAQZ8hb9cLjMz/HKafG/q192YYtN4eoQ0lzlitMwK1ebIR
         j/6VwJ5Vy2Yxy01bUlIfWx67OSVBNu7aYBWANo0dhzj7jYBm4hDOXZ7H6mIYjJsMmlQw
         /lPm1nWHoJpLl3td8dA0nCwOqTjevJt16IJvnC+cqTgvXqJLXHXOatRYxQHebX5mwAPA
         03iHus9/pkC98Ig7urZitS7K4E6fiYX/Z+/Bx35WVvIvhGlJqmTPmFQi03szOTCJcCZw
         dneQBEjaNC/z/NsBKSpILKA468cdHDqNQOTxv77Byvb17lJEqaQ4C6qJOfXw41EgDhLA
         fI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680976; x=1774285776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        b=P9jls28MmZzcCiVkOL4P+kLGfpFE0Q3BIjTVvwQd0mbviSGlGBg5j7mVD2Mzpk+JER
         I6OllgMvmcFl/T4Vg8nv1q/1gpniEgH1wMmzH1WmPRriFMVxkIVRdyKQ/FZZTo44b2pi
         3niVpwGUIcfWAY7xVUZGTL87EtOuvS0MxJM+3+IyM9lgt1cwLs85QWu1G/z7Jtnif6+p
         gCL4QODgaYlTDaqipqmQGThr3+fXB1jTWnva8qiIuLxXdVr/YztDrq3v74s2wajvVsvJ
         zO4i8AhmN/3hDtNfVsxWzaYRgOD45Ek9BftYg/EiPAzyZzt2QpIsgK0iiAH198Z3mo97
         yloQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6WzYyt24hXGEl9oNbHPXQKvj9FZLyOR3O722QPuA6YHE2+Yyt0eOMd5VIsQo6gyIjKBe33A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxUAWvFhtojqHMUytGvzKQBR+ScG27nSS2z1HXNf+UaL/7wUSkV
	vY9VeZA3MtBo4eYVWlQCLkrtz9P8Ab2iHJU/BvERGdCy+WKSszsbPdcuOxNh6Avv6Yl+5kJxGhv
	ctgyaaRNYs7mAp1J6BupxA4Tr66xTDiMiX3JfVCiO
X-Gm-Gg: ATEYQzyvo4ikaHZLK3eokUDJOZX9pG9nSG9Fpy2B6GL5ZUpRWyFbxkxnVa1ie5LUVWQ
	M1DiHvwNkapVTYmspNozNP/7OYPt+qXiIMJY+RFvsITuwqfuOW/JDeBj4QYDsVO0C8RumI2tQhm
	9M8XBLSA9E+zKtkL4IacfBXuWfPeIf6VFlvfGhELsGv6biFc7bmXV85W8OtA0ljPHc0Qwl+XB1X
	L/rz/lL9WBVYShGE0DobM/SuAurc8o1on5rhKnczMU9Wmn3+u9KfcXWNX/rNjlf1RP4zueyvMcz
	4/Q47MCg
X-Received: by 2002:a05:6512:64e2:b0:59f:6a2e:49e4 with SMTP id
 2adb3069b0e04-5a1626fb8abmr3594350e87.7.1773680975067; Mon, 16 Mar 2026
 10:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260314061747.GD4177610.vipinsh@google.com>
In-Reply-To: <20260314061747.GD4177610.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:09:07 -0700
X-Gm-Features: AaiRm52NY6sLPHJr9Fl_13O_4mOB8Cua734qhyhURDdG8FlJ-PNRJ5f7ttW8G5g
Message-ID: <CALzav=cQQny8AXzewtSe2pM-Z20+K9UbTcNBiy6SC4PUzR3sng@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
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
X-CRM114-CacheID: sfid-20260316_100938_719528_EFEEA046 
X-CRM114-Status: GOOD (  15.99  )
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

On Mon, Mar 16, 2026 at 9:03=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/=
vfio_pci_liveupdate.c
> > @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_li=
veupdate_fh =3D {
> >
> >  int __init vfio_pci_liveupdate_init(void)
> >  {
> > +     int ret;
> > +
> >       if (!liveupdate_enabled())
> >               return 0;
> >
> > -     return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +     ret =3D liveupdate_register_file_handler(&vfio_pci_liveupdate_fh)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
>
> May be we should rename pci_liveupdate_register_fh() to something like
> pci_register_to_liveupdate_flb(). In the current way, it is confusing to
> why same handler is getting registered at two places.
>
> Above name will also make it similar to IOMMU series as well
>   https://lore.kernel.org/kvm/20260203220948.2176157-2-skhawaja@google.co=
m/

Will do.

