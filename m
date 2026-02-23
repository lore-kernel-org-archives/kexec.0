Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE3BEEC2AC
	for <kexec@archiver.kernel.org>; Mon, 23 Feb 2026 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=; b=gZe1IdI16LK0WLDMwpWh2zRmu+
	cwZWvD8/wxdC66DKYnkDaIcv230TINtGTrqGzV8s9t9XNXuy37xZxcQWC2dq9i3bNYG+/uEsn2tF6
	OX4Pm+b4a78UugTehSrIf2YmVNQ8Q3B9qBexLwnTX62jXScSCfr+3QiPq3+52nRwobBb1IGMy10Na
	1ZDs4wZD9EwFPoz2MBI9HItH+AsU/FiT3W8Q5lU5wq4M/3/ewGkqyxnrVxqn53BgWhfwzfGYBnWE+
	V/Vr0Lqe1ZoA3xepIKrnrv4VvpQEa/0ynqiXVmRw5vUiqkkNmG7rsXq3NCe24lLxl7f3FXQut3QCn
	5UPQKk2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuf2r-000000019pT-16sF;
	Mon, 23 Feb 2026 23:08:53 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuf2o-000000019oZ-3H8A
	for kexec@lists.infradead.org;
	Mon, 23 Feb 2026 23:08:51 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-59e62834439so5521678e87.1
        for <kexec@lists.infradead.org>; Mon, 23 Feb 2026 15:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771888128; cv=none;
        d=google.com; s=arc-20240605;
        b=bxnFCP48mAafirs7tG0OntdXP7JnYZ9QPLbFFGe9jrXaRoiyQEXHzLeSojjKRPbzqF
         zlDoIBVD/p2jGYfeDXsbx0Kc/oLelAiaerXY5ZZ+rBE8vhRx8NUl1NCFK2trPDiXJhN9
         l739RD3TbhTbm0UbyjBqRNxwQPqYozXoGOUlmiJVoZTfMc8+pWemHaoktRcg0ECY8d0Y
         40iRuF4oguueknImLEwUAmss0BtTo6kEq7s3leGdnP9OwPMl+piI+IK2fDph7SglftgN
         nh5weyVj1C66tX0M4TujIJmKuLitstHzcRiqi7vuRjpXa0X98DSsASnAtuPzNh/Ba3y6
         mqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=;
        fh=wVqe+tw9j5Arafi9fYMweYTuMq6SBLdgKhHmMnOW+5k=;
        b=fX/DSXzDwe6hNlFH1Oadm+p69lLg6T/SjjlnkNqnPsYXF8Gz4T2y2HI79gHR9/wvBM
         aXW3mKqjqHQLAV2AiovMHJOGZImTqLCeFbU17AFwenLwtEvQ9wXhC6FPDZKUyxFIppbA
         1w5UzUaiRyQnYXb7a/rnbFz24UfzokYmFuZd13NPQZ9lzIXiyFIO7UmYZKU66ArBPj4j
         NOyCP+tmpAhZZBiy+7RHHEUgo1bVFhbhNKduuyrn0AlKn3arKcLW22zdy1l+KKSU8YTc
         gfqCJ3Al2zhf6Ksa5AOW76aqCGMz+EJW/f9QI9FVqpvpoW6wgX+4W6i9/4Q//uBGUf2g
         /MYg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771888128; x=1772492928; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=;
        b=QApVxvvMqQHIbD2mDWgWKqKNjBPUT383CScG7kSaOC86WgDmzgWBH7kRosdEwe89mm
         mCba6FpxKwObmWIrGiiWZS8WGd34uWMkGBID3IpPlWQDMgCsq3ohBZR+oIESY2sUTPMM
         ku830fuY2TQpujb7QOGXQeZUj5ROSK/C8tyGdTHeQIgjOWlQH79A3hR7npbtPjlYpzSs
         Qy0Bs499q8lsPnnqFlHIExJ5BCMAFcmfu9GOhTNAef4un1xc3S43yNGjKBQSNr9EnUbO
         rWEitQpziV6eMQHotJviY/4SHmNsoQlL71hh3FzQsrLeric0Yp+vqg+QPrB/Ef9aFLI1
         hzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771888128; x=1772492928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=;
        b=dR+8KEBc1jXYUdTCpAe8TxJNYbd2cUiOAaf1p8vb5WRCLHz6maErqhgY8ZbgYb2aZ7
         0Bl1opXmwZ8lfvgvaF+sgXH51cojvWfjkiFV9KgEVOM5W/RteVuSqlZHfd/DrVvY0uQq
         0bTNJnPkGhfmTvNqcXTbjkh+zx5+ttxrlBVlzLhnxZLcvzZJ+muEI7bt22VvFKyd+dSd
         ixOCjWO/n71+Ewyy0cB2flHwRd5yIpsfbPtMoyTSdY7NCIA+se+tNZb3Owv6pNSda1is
         9d0YVJl6x3kT3129JemJ/KEUKFdWjr0NJkTGBI0KY+WbdMDF3917Y0IRzLdZe6Zby7sp
         kPCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6GpAGd4kaFbjeCAkMqdvAWLAys2lKqYYGJHJklMdca/3GqPck8ASLvw13bs0WvR+EAYoOBA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwU3wdPCPFcpiGjz1KbE1iWiX0tv/eqMpfyTVwARIuc9KZ46YIr
	ef+La7BNGawJLsRqnYrPOOk9/j8T3zgRt/eEYxNzBgzH2VPP0ZQNfjKD9fQuZZOLFWRX9cEd20p
	kkc5gl7yCDtkFL5ZMsmeLDQHjm+HFl6y6SlJirlIc
X-Gm-Gg: ATEYQzzYyV6aITjD8fEXjYsy+xoMZ6KERJfB2kIgeMz3qAUlHxf5bd8Vo9e4TucPMFC
	itGZaNtCyPIv+LletWz5BgSvTOnJTmsF/KQz4BsN5XL2vLsoZ1OmZw/+W8XkZMi8/PC2jhxP2cl
	ypGUotrQSDVXsN4/syzOr5q5Ks1cdcaJZTg8Hd9qGqX7xOBa0ZUWA8GENG/8cyjx/zkJ4GSTRk2
	+pulYHqPIXDfQG3JUIy02YxDs+tbvpWKD8gVWnVGPfORMgvCaYFtB5JYYbtMk8SG916QhN1QWQP
	KgfnDHw=
X-Received: by 2002:a05:6512:3b9c:b0:59f:8546:1899 with SMTP id
 2adb3069b0e04-5a0ed87de41mr2986457e87.11.1771888127316; Mon, 23 Feb 2026
 15:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
In-Reply-To: <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
From: David Matlack <dmatlack@google.com>
Date: Mon, 23 Feb 2026 15:08:19 -0800
X-Gm-Features: AaiRm50_OD8BarR0N1ju3iFQZFALazFmYS4w16LFHF58C19D7VPNrgpsKvMORCE
Message-ID: <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Samiullah Khawaja <skhawaja@google.com>
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
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_150850_882650_7A6D7CE8 
X-CRM114-Status: GOOD (  17.45  )
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

On Mon, Feb 23, 2026 at 2:04=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:

> >Drivers can notify the PCI subsystem whenever a device is preserved and
> >unpreserved with the following APIs:
> >
> >  pci_liveupdate_outgoing_preserve(pci_dev)
> >  pci_liveupdate_outgoing_unpreserve(pci_dev)
>
> nit: Preserve and Unpreserve can only be done from outgoing kernel, maybe
> remove the "outgoing" from the function name.

That's reasonable, I can make that change in v3.

> >+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> >+{
> >+      struct pci_dev *dev =3D NULL;
> >+      int max_nr_devices =3D 0;
> >+      struct pci_ser *ser;
> >+      unsigned long size;
> >+
> >+      for_each_pci_dev(dev)
> >+              max_nr_devices++;
>
> This will not work for SRIOV as new devices will be registered when
> sriov is enabled and the max will increase. As we are not handling VFs
> with this patch series, this can be fine?

That's right. Since this series does not support VFs
(pci_liveupdate_outgoing_preserve(VF) will return -EINVAL), I dropped
the logic from v1 that included the maximum possible number of VFs in
max_nr_devices.

Once we add support for preserving VFs, we can update this logic.

Another way that pci_liveupdate_outgoing_preserve() could fail due to
running out of room is if hot-plugged devices are preserved. But I
don't think that's an important problem to solve right now.

