Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F2C98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=; b=TCXYqzQvWumt/A6YkJn9Ojt97B
	JyZIt7CRi3L0Lynm21iauF7LcdwGbJ3ck1wuIhPnDH/nq5G5p6pD0De7tbXV8+CV0EY7qL5Pksw87
	148N9m+58KN+bRw2XicqRdhmAIdSSf6Jt36S9GfzyvtQnPGLL/wwppltif8SsJe39XjjRhqAYeHNO
	M0C4rPzw+qcZf243AURXPIWZ+iowopeR5mwUJ+ATohvATOC/0xHd1JXxcTvwBHkUak20vqayzCHxO
	7G/cH0jXIzzEzdIRvkmJTUb4JyImirxTegZQoPmHe2TNX+yhjl+magtWP8Xu1afTSUpA8crsQ0ro+
	ny5amh7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x95ct-00000006Lsa-3LjZ;
	Tue, 22 Sep 2026 18:53:59 +0000
Received: from mail-ej2-x0f.google.com ([2a00:1450:4864:34::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x95cq-00000006Lri-3KR2
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 18:53:58 +0000
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c254f56039dso17591066b.3
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 11:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790103235; cv=none;
        d=google.com; s=arc-20260327;
        b=LE/CStgX+rN3LBBbECxCTbNuQ9gW2wLpme27964GLKODVYtn5W5E9nh4zhPIBck/ld
         zxU0Z5X0e6Vl0cWcbq7jjEXhnJgXaLg+MXQypCh0xP7BKRH5pVGS9FPO+9iKwb+OrJNr
         xAmzx8eukwLwNDWEZ8lkCEgyi+B23JwpitjatUg6AyLC0PgdQ6XwispInLR/OSp2yEvz
         Y0aYTZGmeOUMYNkuNoxb6tf0BwdsMTrlQBFK+z0OU+EybfDEofrYv3QbnXj8PyFU9m6I
         FtfOf2UPgvxz2NQpp3f1xsN7pdAkWWtlVd9D5ytjpqzZKKy0CYyegDMqiQEotpPaWVix
         gcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=;
        fh=T295YbWmmHPPSH9QKiuEtQn8I6vWGtlNwUaJ2BIuA58=;
        b=MHIzj6uBjLpSFMTmk70LCORNwnCje9+L68OLE2yiahgDrzb4TWFvQMA8LHQW27hY8l
         NYUsAh5xHDyDx27xc/DcQP+2goC4MyzxP90IxCRlaV5rNQLB3n/oCW3yWKVDLU0HBXze
         HB8KVkDGjp5X0VFORTzGHAWrB+JFkmzWBlr7USIMZH1PxbAP7SilMBR3067CnFsNEz4f
         16ufREbE3oNjN5rkJNYmTtYfZRywMz+IsQL6fLy6DWkm74jcFJGTVl0FoZwR0AUu/54k
         M6Pg0YExsQyZqeTJ2RPkfVdLP617eCnnU8sC0lol64qR4LIr4Cm1Z+IVy/ZJ+Vi5prIc
         uHrw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790103235; x=1790708035; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=;
        b=ugqTBTxIK1Q6hts+q5EQ5PiakhpqhBMlIRtI1/IUEmsBN0YMZWB88MFx4HPMKH6s/E
         JHt/F42eeegTwgZXZhN+v6aMIFnW0OM5VEkix06BZ9TasagQPAa0WyM+kd9JfJcWg7xb
         VmeXXdyktTNVXA+Q3bu36O/BpFKLkMnORb9jLm75VbezuyXi8NFkX1hx0HagfCsLzP+f
         coUhi6/121nKjZRdpxpuKV+HUA+RA8kYa1zgArNRwYNyr/7nUPW5wAGC1Tic5nNvEVh7
         73GDR+eV6iUR0E7Cv/s/DyTE1IfdqBK5h5P9F6KOLBkn/+GPpd2jvgLS8jJze4ArRkRt
         +LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790103235; x=1790708035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=;
        b=Ama3bA63PZ5Ew6mRzkslZrd+pQ4nxpCmmNaVqYd1uHpe0kJJjPjdXoPo4XJD8HSG55
         49NNinww+Oz1DTT0aIC+JdpIVlUHOIoEzuL66VJb8Avgcr+UNhUeo9x4VxRyeqovHXdu
         ZZQCyyPH4olET21o0+uacRsg1tFYzAcCA1SviAt00lWhIsADYbP215iux2ePx1fLE7OS
         WagUTDs8wee5FaYicI1CfI3r2EKgowZ8aI7RIad79i9XAnJV3x0bZVfXDvPwP2Ac9KpD
         NbYIWReNwXVi1wsFHtjkXHOMtWnY3aBcTm48s8VnpEKTvA4f8mrhiQ9eD0LhP7hPxXzE
         quMw==
X-Gm-Message-State: AFuF++kgp/m0USJfU+vT5GwSbE0Q5RclOdUfJJjAoovA9YobvCEoiixj
	TTie6n3rOTXjL2ILxOUmAQHppnTTQuTN2BsKLJq/pELJiO7fYAGSrR1I/SA6rtq7O96dAXfdTa8
	yvG8i0xIK5oUy0c4cx9fEkSZk6Zvf0pdFvpoVjYut
X-Gm-Gg: AYBFou3Y7L50o9azkosjmflfYMS8CuQdf8YkpqepNeWX76ZQXn13Frx3Ky2x8hSrGp7
	e7q19BQyK+yciDeeqgRIAQGznGxtQf+n+Hwa3oACWZmXxUsUEN9fEI9R4+s0g7cSSwcrqsq4hmP
	GfgzAy9woYQj0Kh5vHqfPU7LUuDvwwQwlIk2RmiDty65duaXa0mmtdCLGA88/7u9B4gmFIGfaVQ
	3ix7Qv9G5ad7bS8lw2b6LA8r7E1GAMVSuhdOi+yR4byWe2wJRD3Ee5Qo3Oo0MR7PTlkT6Ffe/+D
	GM7He9FrKE5/wLfK1yEdUmmRZe6W+myFWnAk6+F1XXL/B3LbqZnLSIRRFA==
X-Received: by 2002:a17:906:f58c:b0:c29:448b:f5d4 with SMTP id
 a640c23a62f3a-c2aae2b0595mr11895766b.35.1790103234240; Tue, 22 Sep 2026
 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com> <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
In-Reply-To: <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Tue, 22 Sep 2026 11:53:26 -0700
X-Gm-Features: AclHuK_mAcmGN2d4gu0q1ERBsbnyv84fOIFniqxdriBGbAgM5X1zIuozEi_ewvI
Message-ID: <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20260922_115356_879852_7DF7BDE7 
X-CRM114-Status: GOOD (  18.23  )
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

On Tue, Sep 22, 2026 at 11:36=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
> =E5=9C=A8 2026/9/18 13:06, David Matlack =E5=86=99=E9=81=93:
> > Future Work
> > -----------
> >
> > Following this series, we expect to make further improvements to the PC=
I
> > core support for Live Update:
> >
> >    - Allow P2P across Live Update by avoiding resizing or moving
> >      preserved device BARs and preserving all upstream bridge windows.
> >
> >    - Support preserving Virtual Functions by preserving SR-IOV
> >      configuration on PFs and enumerating VFs after Live Update.
>
> Preserving the PCIe topology, bus numbers, ACS, and Bus Mastering across
> kexec is a foundational step for minimizing downtime.
>
> As we look toward complete end-to-end support for DMA preservation
> across Live Update=E2=80=94especially for VFIO device passthrough and dma=
-buf
> sharing scenarios=E2=80=94IOMMU table/domain preservation becomes crucial=
 to
> prevent IOMMU page faults when devices continue performing DMA during kex=
ec.
>
> I would like to ask about the current status and roadmap regarding IOMMU
> Live Update / KHO (Kexec Handover) support:
>
> Is there an ongoing effort or RFC series for IOMMU handover / page-table
> preservation currently in development or under discussion?
>
> How is the coordination between the PCI core Live Update mechanisms and
> the IOMMU subsystem being envisioned for preserving IOVA mappings (e.g.,
> restoring domains or handing over root tables)?
>
> Any pointers to active discussion threads, RFCs, or future plans
> regarding IOMMU participation in Live Update would be greatly appreciated=
.

The first IOMMU series to support Live update, can be found here:

  https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@goo=
gle.com/

The IOMMU series builds on top of the PCI core support (this series)
and the VFIO series linked further up in the cover letter.

