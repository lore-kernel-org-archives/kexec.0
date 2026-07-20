Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7868AC44529
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aiMphJN0hEb752W3IjRxFzmLe0gtZmSXKy+eltAZsyI=; b=H9nPmhcuGrppUu/+K2hTHjNUri
	KDqahx6LIzDolTqMtuvX/OJema0MdFphRWfjE935B6CdPAS/lk/Qyd1re6VoC3MCxTE83BZvOLGKW
	xJJof1Kk9Uj2pOiUuDdZSElfQzkVO8vSE+3pEuX+Qe+RrpS41qn7RQFda1TIKKWEu8y/M/p/OXWZs
	3ZFt8SJSos66pha1xrMLDN3pAVacpRop45HsAKl+sEFWkihelQFcGCVRi5pRj8L382LaHDu7b6rDg
	I5zcuDsFsRkTdU2N70CjJ6smQLDuX++7T+QCshqRHzrpQduelwZODmMCfphDMnBTX7BxhkcpBL54q
	HeAIomPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrTv-00000007Tle-3ukZ;
	Mon, 20 Jul 2026 17:08:43 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrTt-00000007Tkb-3MBl
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 17:08:43 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2cab97c86bdso411655ad.1
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784567320; x=1785172120; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiMphJN0hEb752W3IjRxFzmLe0gtZmSXKy+eltAZsyI=;
        b=L6stg4W04K/AG1Rh8C7LTOFUJGukzetCn2t8YM2xpW72H2Bgo0Apjtsjw7hJVlY3i1
         mNBfT5zuUaFP2Q0DDrFfZs63Ubek6M656/p3vFhqSTCmGccckjaNekau+7na1zSn2kdU
         8u+7X/XVAgvGkh/kqjcgAXWLzTP7yK1UjQc2E3S/mzudwVBHCj1ZMoahMon/SLNQSK/+
         auovhVO/lW6PC16NEh0V81R8vbG+GGr/UZdgq3vyvFClWSiAgmVLOuWEPlWjXaY2Xe6A
         b0Qz6d9yzmaFiFiI1b3TAZSAG6PIAs9+xhZwe3GpD9c2jXpMWW+7/i034CJtqBy+/wR0
         ORdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567320; x=1785172120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aiMphJN0hEb752W3IjRxFzmLe0gtZmSXKy+eltAZsyI=;
        b=bZjJZxG6Gu5d0BX4QAEZQggTWMb3oGj2J8VRIP0mESUihDj5tdLJy9c6z2NEmZpSL0
         HHuPguceR4BHMAQ2Hmryf+eQ9RTccViWN7yywr2XvazvgM2NwE7jNo9ghd3+SsgfKfl1
         mIBwP5AaezYi79Fzhj4vUlkYdIlsCq4tm2h7cZdTYAD1s7N/XqAAPXmnCaN0k21DwWk5
         W0DK+6RFU16Kdv4laLnjLgGpSEitJnhCfYsfqc6OZ7dW6Rq4d8j9ajdpsTNuSMp/W/SZ
         3gBVEIQrDA8E6IGYLENX/7UK7vgEhZgXOv+vs4bhgBehmEJUu2gtqRsoIlqHn8ZS+Ivr
         7IsA==
X-Gm-Message-State: AOJu0Yz2JPV1zKIznN/X/uhqBQLyk7riYe3jPqG4IJv1EvciChtXpuCL
	b4RRjpthmRWSMMeCVGtI9ZJ+LCcxqYnmwZgBBv+5UtzuwqXNhLbKXfUgFD8WUTf4Yw==
X-Gm-Gg: AR+sD13JSRSfanGuhjpaUxYLswPPBZXzIEEAEMbJ+frci49E55ckeb7cIHWUE1+XYWo
	KALCCifTM4AKvlgiLtUX0o4/2dwGVPtMhchwIJmEoDRbUnDV/OcbxLaHdoyYPTWTFeumlsF9zeo
	D43gJbHw7wTGGfbl85ViNEmraCUkNs2uob7pQKAGTTP0Yon/ROht9/vuujxJt/PtsXiU1lFZqKM
	pz0FcSY4FN1FP0oyyNlK0dkZnC+iIzWqrbcLSrOfJM1WDvT6ugNLAvSeEN/S2b6n0o9awZa7Zxx
	R1FxzFpNASTvIPeM0QZYBy9WMfPGX6hvnYlRLU/VE/1lwRs1SNsYFuYMI+qQ1Jta35NfwQsTru/
	ZmfKxAkrBuwiVYxbRAbEo0je6FRe1AbDiD2mJ017ft9hP0ZYOdgCBiv9fyRKyC7SMW5EhLLV//M
	YpfhJMA9MLVfP2zXbnjkTFn72wNyYHUKmto9tJ
X-Received: by 2002:a17:903:4084:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2cf7b35e690mr923005ad.0.1784567319236;
        Mon, 20 Jul 2026 10:08:39 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92091875sm91751a91.7.2026.07.20.10.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:08:38 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:08:33 -0700
From: Vipin Sharma <vipinsh@google.com>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, 
	parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
Message-ID: <20260720163452.GC1191959.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <2c03ac97-60a6-4352-a942-27dcebae8d22@linux.dev>
 <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_100841_841402_1CD1541A 
X-CRM114-Status: GOOD (  23.51  )
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

On Thu, Jul 16, 2026 at 06:22:07PM -0700, Yanjun.Zhu wrote:
> 
> On 7/16/26 4:24 PM, Yanjun.Zhu wrote:
> > 
> > 
> > On 7/14/26 8:14 AM, Vipin Sharma wrote:
> > > Testing
> > > -------
> > > 
> > > Tested using VFIO Live Update selftests in both QEMU and bare-metal
> > > environment (Intel DSA PCIe device).
> > 
> > I want to make tests VFIO Live Update selftests in QEMU. But how to
> > select a PCIe device?
> > 
> > what device do the PCI ID 0000:00:04.0 and 0000:6a:01.0 mean in the
> > following testcase?

Sorry, this was my copy-paste mistake when combining things from both
qemu and baremetal. You only need one device not two separate ones.

For testing using QEMU, you can use QEMU PCI test device.

  -device pci-testdev

In VM, use `lspci` command to find the BDF of the PCI device. It will show
output like:

  00:04.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device

Then prefix the domain (generally, 0000) to the BDF and use the testing
commands.

`0000:6a:01.0` was the BDF of the Intel DSA device on my host. I
incorrectly mixed two devices during my copy-paste.

Limitation of qemu pci-testdev is that it does not have the DMA
capability. I used physical host with Intel DSA to verify that the
device performing DMA during live update gets reset.

> > 
> In my qemu,
> 
> 00:04.0 System peripheral: InnoTek Systemberatung GmbH VirtualBox Guest
> Service
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 20
>     Region 0: I/O ports at d040 [size=32]
>     Region 1: Memory at f0400000 (32-bit, non-prefetchable) [size=4M]
>     Region 2: Memory at f0800000 (32-bit, prefetchable) [size=16K]
>     Kernel driver in use: vboxguest
>     Kernel modules: vboxguest
> 
> I am wondering if the above pci device can work well with this patch set or
> not.

I think you should be able to test Live Update with any PCI device which
can be attached vfio-pci driver. 

`vfio_pci_liveupdate_kexec_test` will initiate DMA if the VFIO selftest
framework has the driver for the passed device (Intel DSA) otherwise it
will just skip over the DMA flow and do the remaining things.

Let me know if you still face some issue in running Live Update, I will
be happy to provide more details.

Thanks
Vipin

