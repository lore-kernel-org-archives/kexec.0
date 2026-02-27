Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC65EFEFB6E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=; b=yvU6NXFIfQwZx0kmVRS/OyyqWB
	4WGX7Iou7UaK0M02Qi6+dktgGrmSaDkctlvZRHJtmBBqZ7oyrJX93dOfXRZXm4jHe7H47spQMhuy7
	W7lk+HLzAFmizzv5O/eMU9PtKi0YdBA9QlMguPpjyMamnDYiTcFYIQigXmK36G7BD27zO2+4zFVfy
	MHWQbJRjb4BgggNg8YEe7xS7pyf/pAFMshH7+9j62W5BjAGhRSCv2z38BNTUd5nGF567InOilkgwA
	MU07zr59cA3OGrXz+XwEx5M1t5ZUVZbGc2E4mowEY4/lnNNME25iX+JnvADBDhzTYbaUd33trusHa
	YzCR7qFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw1VT-00000008nC2-0xta;
	Fri, 27 Feb 2026 17:20:03 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw1VQ-00000008nBC-2o6C
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 17:20:02 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-38a01c80c34so1352031fa.0
        for <kexec@lists.infradead.org>; Fri, 27 Feb 2026 09:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212798; cv=none;
        d=google.com; s=arc-20240605;
        b=bjBZ0h1Avbym/oPueVJbmBO/5VB9D47Fi6Z9oo9GgYestQBWArivZOYOKqpd95VaG+
         C+uBlt/mlcKG2XZjJVkUFnOs4sW8CTbu+bavby5e3jS3ETfcVI6ya4e6nnopSPyFvimo
         WIIptWW8NC1WoOq54AmC7/iysejDI3weInR9JpfHIfVqolQuoN88mityMOtktRomZIQH
         /+BZqvKvaHvdStnHna4pX2P2d0yHnDiwLjwwkPChNVkqOTX7zEFY8ljK3W42bpJJxnl5
         hp7qtMQKEj6zvIm8JDpeA8Q6y78Ap6ybqnCpZ7kjoiN8gEi0DPASXoKMuYGsTWqLPVpO
         RuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=;
        fh=GnjaueS6cEkhTaV/G0iRZGjAt9hTYTckY9I/Tzwv3pM=;
        b=RpTokSVc5epLJMN0hBSXegpt19fdd1HiDfk9Eq6ComK6HcZWTp9+G5knCtflKlew21
         TMh/di45V0fbA09A8C8eXpGihScT1M73eKPSHa15cj/XMCUmk+zq20Xghd65HqVLlISz
         +ke5BpKqBZ312uJdDDG5Uh6tLrYa5QPz4RgqtDYmVQW+XjhUAddTpLDGSIFaiCDzDNGZ
         yOlYgt7RYL5oCSf59Yo2IMvc+3SE2JCHwMWnl1ukK0t57R9zSlvCjmCsYGGCNJluhazY
         2mEWmN9ORKdc8RujtGr7Kq+UY4bh2QrhAwBJpkCq2c+Gao6z/8V31ttjm4cnAAwM3EhA
         abWA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772212798; x=1772817598; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=;
        b=WAIYS6MdLK/jHvvCqHAeN/0L5qXbcybkU9fzBtYiI0vNqXwyPi9Z20WcepW2+hMHEW
         ptpO669OrzhB6ItU2ix7Th4pCl8lkHhXXg2KVtbvRDjBQqQ7Bw7hAzMYRpbcqrcMABiL
         CZ4voS7bKEaSnOppzd7gfDLexgLOIiqrCjPWrAVhoHlBLFDa5DdtSNpkoU7GIXNoJjGg
         jhZ/ReXrBW/xeTl5PESWKMKnnea8NCsA9NOPFlKVPlzkng9dSlJ/ZMeJhtGJjfAm7DNL
         6ZCCcz2ZBNQHy91ZIU6ZJX512zo4iUHsvRfLKCZOI9UM25UEO/RH1/Faqhfd929ogamU
         nxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212798; x=1772817598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=;
        b=lfpD6qV9VvxWmbjWmccwuSbXOS1kzmC+GIeVnffL1kv7GX90hFPRPgJsioDFAz9Vru
         yJDtHM6UK1iPffqoDGaFDYPs8FXkFN9tHnW8HgoXP/nZ70IowixttRUH0vUcfJ1xEoyn
         3njTUPhHtaMriw90w47i4+DWh/dlQfo/ar/Yx7eP182eSNAGARBkqG+y5nk7myoQBN09
         8o+gUBX8KHlFOZqRbqzZMErUrHIz/bxu39YWO7XdMDq2MrGVzjpGXMF9wdIECauA/4M9
         i29oLmpMEM2zB/H/l71sZYsHo1jkrvNzsjICkqzeKonREPspghl+FPF4GKnn8o/DbCO8
         XtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCfODUvzz4CSPt2nlXeZS19wr5kpJ9NA5M+VqRp4TTfYQHmNoDgHwWs2j+5xFxvCvtygLziQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzKixIRqMcCTnk59yOCfCzXdtFwNrOcg2OMXrDS8t/+2ax29gF
	cCY2bziD0sY/WGU0TRKwOv/k/axcXzo74JAAKDKvUISdrkHmSsKlGoGA+W+RqLzChcQFBdxXRfH
	HT3a3cP285Uh57LMISbr+OIt0aYWtDKCpZcf0yhLl
X-Gm-Gg: ATEYQzzL0FKkJAvD923mFpygH+lUxwd6i+0M2+/79lVawvUFBX6MXmlFHKgX9iKKkIE
	eTzGOeGOAwDBV64T5+MBCNXIM0pbif6I6/ZZHXeh9bUFi84oF3FMr99RQkNaaRCevt9tH/A10PU
	LrorydSENf81AXTcBlfMXGtYnJqHfwuXUrEdEPZFc7xAOIsXtqu1i0ZDy/A36+o/lnwiYfkkejF
	SlFRXEYW7RPIjqNe7JYV7EZS2IxmT8aYk5FqaeT/rS7Gzl+DhJP2UHT1jSMJlvAMffSWIoeSwN2
	/cpTDBg=
X-Received: by 2002:a05:651c:f17:b0:385:d0b6:6c44 with SMTP id
 38308e7fff4ca-389ff14567amr23252321fa.18.1772212798094; Fri, 27 Feb 2026
 09:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
In-Reply-To: <20260227093233.45891424@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 09:19:28 -0800
X-Gm-Features: AaiRm514TJvedInAnynD285P6RuOXX1FfRIbxiQr5Hc2znqJUuMLjDSPlZjM6yI
Message-ID: <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
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
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_092000_742865_06936E09 
X-CRM114-Status: GOOD (  24.28  )
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

On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Thu, 26 Feb 2026 00:28:28 +0000
> David Matlack <dmatlack@google.com> wrote:
> > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > > > +{
> > > > + struct pci_dev *dev =3D NULL;
> > > > + int max_nr_devices =3D 0;
> > > > + struct pci_ser *ser;
> > > > + unsigned long size;
> > > > +
> > > > + for_each_pci_dev(dev)
> > > > +         max_nr_devices++;
> > >
> > > How is this protected against hotplug?
> >
> > Pranjal raised this as well. Here was my reply:
> >
> > .  Yes, it's possible to run out space to preserve devices if devices a=
re
> > .  hot-plugged and then preserved. But I think it's better to defer
> > .  handling such a use-case exists (unless you see an obvious simple
> > .  solution). So far I am not seeing preserving hot-plugged devices
> > .  across Live Update as a high priority use-case to support.
> >
> > I am going to add a comment here in the next revision to clarify that.
> > I will also add a comment clarifying why this code doesn't bother to
> > account for VFs created after this call (preserving VFs are explicitly
> > disallowed to be preserved in this patch since they require additional
> > support).
>
> TBH, without SR-IOV support and some examples of in-kernel PF
> preservation in support of vfio-pci VFs, it seems like this only
> supports a very niche use case.

The intent is to start by supporting a simple use-case and expand to
more complex scenarios over time, including preserving VFs. Full GPU
passthrough is common at cloud providers so even non-VF preservation
support is valuable.

> I expect the majority of vfio-pci
> devices are VFs and I don't think we want to present a solution where
> the requirement is to move the PF driver to userspace.

JasonG recommended the upstream support for VF preservation be limited
to cases where the PF is also bound to VFIO:

  https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/

Within Google we have a way to support in-kernel PF drivers but we are
trying to focus on simpler use-cases first upstream.

> It's not clear,
> for example, how we can have vfio-pci variant drivers relying on
> in-kernel channels to PF drivers to support migration in this model.

Agree this still needs to be fleshed out and designed. I think the
roadmap will be something like:

 1. Get non-VF preservation working end-to-end (device fully preserved
and doing DMA continuously during Live Update).
 2. Extend to support VF preservation where the PF is also bound to vfio-pc=
i.
 3. (Maybe) Extend to support in-kernel PF drivers.

This series is the first step of #1. I have line of sight to how #2
could work since it's all VFIO.

