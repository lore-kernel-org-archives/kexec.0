Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6B1FF885A
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=; b=iw8m7ZXXu4qlTZrvQMuE5LxZhS
	9cKw17iWs2k+02H8GKaTv9r8GOaeCuHcjSLlB3RKgKmk/VDpzoN0WwwbJKv0w8Qt7GkLASNS6qfLs
	yQw4SZmhrEbTHPQ0OJtP/E3zV/GtBAS2WzQ07zpr2VUZQGXIylq2jKA6Sba5HdLRmDs+fU3KceK77
	dPf2aep5x7a2SaW1o0ecW6lf8s5DG5BD8BG2TEDTh7t7rlaqEj5YjGqnV9FtYM4YfSBQI8jDcPNUO
	v3/STNTJdY8xDlvW/k1NxUU1NcL0Df5i6Rt8PklEj09wNyHNMXIF2QH3m5TTn2YJr2aIZI2NGid6W
	ZHfC8Ijw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJx1p-0000000Dq9p-3K2U;
	Mon, 04 May 2026 17:24:21 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJx1l-0000000Dq6n-23Y6
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 17:24:19 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-12c88e5f4aeso2499336c88.0
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 10:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777915455; cv=none;
        d=google.com; s=arc-20240605;
        b=Wsp/pdm9SGlRTRVpIYhEq8+V27JqSbh1jdmf6npwg0NKx8/MYNL0arj5DJ5oxwEbNH
         IL8y7woICf287Z+bgsQMfHcxID8rvZYJn7820m2GNZLLMZy5wJPDvEsgLsPT3X4VaDVT
         PzNJzB0496+vQWz0Fro2bQjLyB8CuMD2c8A9wceAH+WXsxzW42Fn8UIcn7a8HrCgu2ZZ
         J/QDNyzbZ659Fzp+o+HICE6IyxpRfvlAlBt9c4jXM7oQ5mlY+ArXnDsFv4xcCMOM6ziU
         xLFi/XyTbNFdTsDFeavEVSXsQHAN0/TDCOmZDESP+vjm9jI6F4PazNEYeVADaOVg4enT
         HbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        fh=+EpyDx8cW8cXpEPmkdh2DT2CbZr5GIaWrvpmtiSKF/g=;
        b=Zc0kPOGxBmHEUnR83EQ45pQxsLOsoOAwL1VAZcwQgvDF18M/594ZIccCQbbMBhQBnH
         Z+mnwKagViPjq/3/wWwOab98ZhWfQoFyGCnvGlsBxH1mUMuOkGePQisDeBHqt9XXXkTR
         4FCXIn7omzRitOgd57tZO5RmG/T5OW88GtEDRkdyqQRkIxajtrVz9XzuS4PMji7UoBs7
         uqemS9gQyP02C9UFwZ86wHlVAs/n/GmU2jjFcrp5wLkOK7coexg5NhxrK68p68JmTsd8
         GRhhjIGUBLIIIkznvfA3n6Mz2OaO/M6y1ZEJ2gJeD9jr3r/jpxT5wXvjXT0hVB91om0M
         8D/g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777915455; x=1778520255; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        b=WJGmPRtIfMxpvSEPJYHU3FRjQ/BGYbkBh9cjqoS3TjUfmsYA0sFO6JC/puZge6/VAB
         KaodZ9hltblezr7pXKsrknJJuiibyyY0cZgpvu0e6lCdibUgTPpgxHSfemZicOiL2MZw
         lutwrW7+2i5+EOtfCvrUapwyLSYBu2vSJoUDut+aVf7zpEfaeOCOL/oqNc54c7fo3szj
         3xE+oCIKpbNkauo1woaEfPFvj3fy+jcHXWds29ppb9/cjaiKMww5l7OjUIDCTkWWoML5
         5nPq1l1Rm+y+hHLJ4Ufs/65JR8ahbS5yV9oZJHeq/heoxaMY4kL/+0yhJ0BuusPJqjhp
         0b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915455; x=1778520255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        b=CAN2/g8ufaj7IsB2IMBYdCQu6PuK25jE5z88cAbApJbsyxqBZoAOZE/38gjZcWGY/A
         jxuVxr9AHn6N21rfk67e9qEEfmo/VVh0/rZREUACtX4sUbmfGKjBorYKzUpetKFB9Gdt
         ESa7P/UjbYo2kfpdJa4OatP+c4mVVpKwUaOQBzt564ByQ8xM7huCj0nWmQK881V5hHzV
         Yepx31hZFcDJsJ4lQJcf1fAYjnrKRiBtiR86D5V6RMPns577rJ3Q84otYEa8CBUfq+2P
         k/a5WWPjDU/Gtc/a7vwBxzskN8bP21xLFzr6/DV/1nlHZA4t1g5JiqWhAvthSfk/B8F4
         AsUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CGL1qHWOsH4weoFa7Y7iwQyJK+tyCHUoSgNNSM6+1eIUqaIiDgMZhHqR2P9wEUEFemjQoGA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywn2lBR6gWaiwVwu8Md8f2UCLJ1l/E9rxnRMtYic7RquR/TUo0H
	jWhJQrO9RmX/fFaaLVYhhjBorP9utudO0GB19s8vyqm/SjD0mL45IkIq54A6x5udFheMWkEUoce
	o5WrkNRqglzHS8cmWpbXWDd2GBzJs4xUpJ0SQH2zO
X-Gm-Gg: AeBDievpKLNiDDu5bzbDHUQ/kQ7BchYDfMi8WITStebMvH+bp/VgX6FQ+kOP1rKXfxG
	xCofU+X7cCFTu7CkUqTtKigF51xAh7L8M/BFgUTQ89rtermjgaxWJuwhuXZpwL3x2d+Vgkg5Qi6
	qypDz8sMnlXZFgQDxrIZrNZRXtBU9+x2AV6jFHAZb7mXVS6yDxhnPh1jSgnJxTNGS8vHq7Ov2zU
	bcWQGmfgRE6CX3/yPAWghOxKL6+J+wjqX8C+Ohhfdm4aA33DAZwB327YTxSb6l1p1WMXgZ4pPC5
	t3q/VbjIIuTrViE2HWcb1Xbzcdy7EQ==
X-Received: by 2002:a05:7022:497:b0:12d:de3e:86af with SMTP id
 a92af1059eb24-130a9fec67emr177647c88.18.1777915454575; Mon, 04 May 2026
 10:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-8-dmatlack@google.com>
In-Reply-To: <20260423212316.3431746-8-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 4 May 2026 10:23:48 -0700
X-Gm-Features: AVHnY4KOWy2Xw7Jao5yCErgbS2iXWpg2-ZhNYfKSnvLQBaJlNVGZseag5k_UOKw
Message-ID: <CALzav=cmZzNetCqWjQaG=VO+Fs=TTL3izU01vDUFd-=mRnDAuw@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_102417_712545_B926614E 
X-CRM114-Status: GOOD (  15.57  )
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

On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

> @@ -1017,6 +1017,15 @@ void pci_enable_acs(struct pci_dev *dev)
>         bool enable_acs =3D false;
>         int pos;
>
> +       /*
> +        * ACS flags must be inherited from the previous kernel during a =
Live
> +        * Update for preserved devices (which includes endpoints and any
> +        * upstream bridges) to avoid changing routing while memory trans=
actions
> +        * are in flight.
> +        */
> +       if (pci_liveupdate_incoming(dev))
> +               return;

Sashiko caught that pci_enable_acs() is also called from
pci_restore_state() so this patch needs a fix to ensure that ACS flags
do not change or get lost after a save+reset+restore.

