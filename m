Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBE7CD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=; b=HrDRGA87EDVjV04pJO++TUDbm0
	TGWN9/XtTY8ekwgxCvPHUMQaiDCIu7ytUBnIdssI4Hh2Gdck9O+jdCgagX1M1ibwvwa/v1XbJlx6O
	laS4+I8gYYC6GsKUW1boB1QdN1cqJZZQraNDCZPmc5E72qDhzxVm5jqB4IxUSv4ttkdHH/V7iF+M7
	wmgq+1SIOlEWa9STucqEHnyhWGM6JXtW1UklkqcDdr328HpJg8nKujJtzBoWBP6MAJA3hTXJekf3g
	p4q6rH99CmX95wgVVcPSjs7TMoQWj/QOSKeHSMH8YPnJi0Vzn0XE6AXvJpYCdBxNsbS2UyfNe4UQ9
	go3mYhoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIrBc-00000007TvU-20r2;
	Fri, 01 May 2026 16:57:56 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIrBa-00000007Tux-2lQz
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 16:57:55 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-12c726f46baso3325579c88.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 09:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777654673; cv=none;
        d=google.com; s=arc-20240605;
        b=g5E+ATDke/j66xxlXZuZxXhZxfEp3CPYIUzSlVs96+pdnzhXzi0kNbuj3bi81ScQsT
         LkDFDA9DBuFv/hLZmvorPg+2l3T7t7s8GRkpdZeZ3Wy00T+I8cS/ousqBSueh0jMQXTj
         XJaD04dAlxX84KLktkAcp3wcxHmymbhwveTkQjNuousfLW4XFsCe6SFeueP8anF2p01m
         ENcso3ALxgzORfY3jkUjaaxEvIcZ5NcNriPeRxt7E83I3MpSK29OBrKOFq66Lh/HQvXv
         Bye2s5k1pmunUI3wOGDW7rZSbGIzTN6r7uMqCYXDD4lQBU8uRLQE0QN7SYZvkDGBjv7X
         87FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        fh=n06Cr8dMuTb9rEV4pT8vjlxN8GnGcayWhDDpDY6Kdu0=;
        b=cJZ/gWiGLEcuA31OHQHIO723IQqYO8nBhVXrqBAcNNkqPS+FWpzAMbDEPjjuX/xHZF
         rOnhQTE7r7T5icYajvQAraVLIo/ruE+ErMrJd/uSbGsCTjGKq0ITAHGZTIDaSFLywazV
         V7glyXcGQIQKQ9GGdlMa2CaOWliTsqx5HrMFDB0V4nYgkqpXGLZmZW06ys/ZOUAZhb+e
         JWSsbnJj96L1hUHRvkn/cDpZKUU2EG0J2rYRcQzOQibhmxHanY0MGQe6vcCYJ9p+Kea5
         HMCH3nS13s6R0vc+Egf4zvMe8XoWFfyW6XTEE+GUZ3tVbEXVWc7NRn/Oln0GXeOtf0K4
         Gmqw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777654673; x=1778259473; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        b=mRKDbg8cbmluqWQ5yTi6+RNro370rrMJs6NxqDXIBgYkXggcPoACUmy1/3ZblU2gJ1
         oI1L9eLHCXpEb+lM7n2EtH6F16Fgv5wcVSs601Z0tYiWIi8KDpqHrKNnLHKv7iiypMib
         NLsoPtauEcbDqhaIfrbtyNzPdDoW6/Z/gJxQj81oLqECMhc+ntJQaYQ8zTRFcO97K1cS
         Zd7ItFlkkLkmJ/r7A/Dy0Z0Y4Sce4tMrCM1Ugc7n5WIWD+1Eal1g+mVDYbkxVnQWnhaT
         nwpNQcgL6N903GjPVcAkhJYa0s0vu8NGaad0Es1KBeBB+KtB+hMCj/nCrh4M1hb9wRhq
         NYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654673; x=1778259473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        b=fN9BUupuVfjPCXQXS7fnrueytzEVxukFOlR6QM9C//E4ys3MuRXrqllx7TImoXzQxD
         G/upDkpvee1DBkrPETDgKQb2AbGnsbOCnhs1r3i4gajGzDGbl5QANNLNvznlAnIkXKZq
         HqOzZ/NhbyZYiXcb6Wzn8rMts29XUPsEFt7WOoIH2ZIRnvNKW4cT7M4+Hjk/mlUChEuk
         eNWZVhSaZ9JHqZxeTMJU3Qx+TN9KFvHZo8FtZ0gfmPIyPc/fzNFQNMo9IKHFNxwp/d5F
         ygQRwVd17sASKRSe0DVxbPXUQG97dtBuLH8lCdJZsKIfIkzp8xZq5Jlc+b+rj//hhsas
         nKGw==
X-Forwarded-Encrypted: i=1; AFNElJ8zDVuPn0TQrRm690VxXzJo0Pxh91s25pf1c/wqnNy8SBNeAMMH6pTxdbac/YgwOX0kLQDNFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhXzi3BmyLtZXlhpwWvkbR/n3yMdpQ5RSrH8Sfy+4SujfDFQcW
	hN2c4xAXVPxOZDFKhQSarOwGb8pHwJfan+JBjWvcfLtw5TocfATG1l+LBcuGpGDK9fQwQuqTdAz
	ufWNJpxKqPpp5g8/OQdYvEnsHs3Fo/b+OCplQSIKe
X-Gm-Gg: AeBDieuGoU8vTa5/aVe96MnmQZmt0EAtZmlplhkaSPWpJPQle5VRXu5WjMLcoEy6rY+
	ZS3Jzs/gHdKzZ839ak9vuzMe5DhSqyv8osjs7PViKcD2t8+Ckx0dFuzg9Ym+ho+nSQvswjw4epK
	TKPS/uUnvK+P7NIIUG8trJWIpBVTAqRvvkVgoaYwlBpW0c4avTGum3Nku1Sqej4gv9MXEKyUn5n
	EtnmEOtlPBzshUJAZu5ePfcnVOCkmtOlLaz9u+g8N4fGSGvD9JEpklpzyodFI8rbdyL/rLhNJm1
	USUN+WCZlskIHc9CLaOX+x2C8u2AEg==
X-Received: by 2002:a05:7022:6187:b0:12d:b2e9:b20f with SMTP id
 a92af1059eb24-12dfd821474mr32517c88.21.1777654672480; Fri, 01 May 2026
 09:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <afFHC6C1Qbwio4pH@google.com> <20260430210642.GA439800@bhelgaas>
In-Reply-To: <20260430210642.GA439800@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 09:57:25 -0700
X-Gm-Features: AVHnY4KFLnH4p2pRBeiWD3uz1DZ5zLD14tslYZKT6G5Ma2DKmFI_8zfdZMWusuU
Message-ID: <CALzav=exRqf3XZWDwUx-OXp8TgzpmQ-iUTixpT4SVRk8nxctrQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	iommu@lists.linux.dev, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_095754_725534_7EBD9910 
X-CRM114-Status: GOOD (  22.47  )
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

On Thu, Apr 30, 2026 at 2:06=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> On Tue, Apr 28, 2026 at 11:47:23PM +0000, David Matlack wrote:
> > On 2026-04-28 05:50 PM, Pasha Tatashin wrote:

> > > This is the way we agreed to handle kexec changes: Baoquan He is the
> > > maintainer, and without his Reviewed-by tag, we won't take changes to
> > > kexec. This is the approach we follow with MM for KHO changes to
> > > memblock and memfd preservation, as well as the upcoming
> > > hugetlb/guestmemfd preservation.
> > >
> > > This is also the approach we should continue using when adding LUO
> > > support to other components like PCI, VFIO, IOMMU, and KVM. It keeps
> > > life easier for the core component maintainers and ensures we do not
> > > regress LU by staging everything in the same tree and sending LU merg=
e
> > > requests from a single tree.
> >
> > Ok it sounds like we are aligned on keeping drivers/pci/liveupdate.c,
> > include/linux/kho/abi/pci.h, and Documentation/PCI/liveupdate.rst in th=
e
> > PCI LIVE UPDATE entry and not duplicating them in the LIVE UPDATE entry=
.
> >
> > I think the only open question is what tree to use for the PCI LIVE
> > UPDATE entry, PCI tree or Live Update tree. You are proposing the Live
> > Update tree.
> >
> > Bjorn are you ok with that approach?
>
> Yes, I think that makes sense, at least to start.  In early days, it
> would probably be a headache to coordinate LU things across multiple
> trees.

Sounds good. I will swap the trees in v5. Thanks all.

