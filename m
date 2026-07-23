Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC5C531D1
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FoDnuIQXevfuc8nCvkdqJumo9L7Gv87izvbO8ewc4c=; b=JmZwVq/rX2MoG+U12jeW1H9ogQ
	Qh5yIQXU4mVK2EIwfctlv1xKL8g6ds7Psm9A0Lu3qTy7TctcSCmuQgUrX/9gN7H6o73HWPOkB9qHE
	yki2YrP1ud6FVTro5zLqbYQUwXUlvLDMrXbHSf81g0Ky83syMsH1xntSsE1phaL44QfUs2Ak76HDK
	zfINLZ9c2suXk+YJ9RmkM3mbmbe7wDt/hfIwvqrAWh0ui4jAeonIsJwECxfxOCkpx/XhHzA2aheSQ
	jOvECMZ89lPSetYhiFol6RZlvYcoeK77ROHUD14AGWAMLVTr+CqREf1o3FX9EuSrRMEC4i78VTMyz
	N94Fa7vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn2Q9-0000000FEqi-2A7x;
	Thu, 23 Jul 2026 23:01:41 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn2Q6-0000000FEq0-46Nz
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 23:01:40 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ccdf36f63dso5495ad.0
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784847698; x=1785452498; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FoDnuIQXevfuc8nCvkdqJumo9L7Gv87izvbO8ewc4c=;
        b=WJ8/tzu4KLT1iVH+EUvhnzUdzDptG0tj0R3O8fTQPccmyRAz8GDTfQey9A/czYprBm
         PsvL/cKSRS8K/uVLvmK3GnR2Vh79/kaaUeJ6/z+PXuc5G60MB3m2BW8EvYq2QSOoA3s2
         8xJF3T/hR8VnNVCmmubrzXispvDD85qyS55M+AYuhno6hH71GSHbZ8Ww/aIIl8sKJV1k
         SwvUBTFn9cKmsA3rqhRX5mTEEROmengOUDsTsEC3DZNAc5TSHRCK2OlHV2tN7mEjbmEW
         NXrvpY6JlkWbsD1o1QrXg6z6ZtiFm9Lq8kABZKekuKmlsmb0bxld4yWVQCNXZ4i3yGZb
         8ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847698; x=1785452498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6FoDnuIQXevfuc8nCvkdqJumo9L7Gv87izvbO8ewc4c=;
        b=n1Whn1tudcbXDBofvtKxf52XbnNK/nm/vGWDRQoI09c0ry4dNC+XcLEFsPEdFz9KPr
         5CO/ln3tFUGtS4gRA+XEZs1o66IWEXNU+KSUNN3OzUQMplzjJs19JLfG01QCIZi2JDRx
         +97N8nSjFM2AhBp5d69jq5y4Cy5HkUjnusyNUf1Mn5ZyF1U9hUO0QU+kReWsb2pCDNQS
         0x1xIW0v8avQgM2ELdPI2gg6oQDCfnN/zYQGF5LxOgeFyOEFxV9vwSKWtKkpJHY6TjT9
         N5Vowvnlk7cskEH0JzWq92OAWROEHY3rN52yjsRRz4d8nN9W1SWylWmpChAEPhJM7kae
         EfBw==
X-Gm-Message-State: AOJu0YzFSifHPC6AIDxZi4o5L62pSYbxwWmav6s54pigsdOrhMUyobth
	Tzt6+rrV+LXidczCB9KCGetvfsplKN2V2bjrQCmiiAFYX+6TlLciLeYY19jZlicsTw==
X-Gm-Gg: AR+sD11x5LuTh5dO9U/alYemA9WWIFsCA+IJHb8IPxcFJ3ddHofdGF4hoJuADacW/zM
	/WRsp8KNlSwfOY2/g7yU1VqYe5EzyMF//ZzFYzAQ5jzov0PljbZIeFkzLKEiJPwSVGz84ScScwx
	20NbZkl9XHV1NVtY3/SJInb7vPtQGn6nUGNMTiJFr42iPW3GeqV4XOdTjeMDImj89HPibyWIiB/
	FWIeJ0O/je0D5dgYIQxdEUBRLRUcbYk7qhXHE2xy9rWkIMGSxa3T9Dqgheshe2eUfbq3e1UlBkP
	wbKBPphujxg9PpTrhSVvWYS/YvNDkP48Hgn9aQglWQLTrgA+d5OlcKrtRCRORJElFcFLr70thQj
	2kQ6DdFE+KqLoRCjuAc/mUa9bD2TqP53nAz0DsxjTJ4l6JNCz8g5qOhaV2kcbZLlSmmpQlt0tsG
	FVoaNLBb7oXxbDjMxlOy++uqujjMWiT7/MVvsA
X-Received: by 2002:a17:902:f687:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2cfc01915f2mr1772685ad.4.1784847697393;
        Thu, 23 Jul 2026 16:01:37 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f310644sm40753485ad.55.2026.07.23.16.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:01:35 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:01:31 -0700
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
Message-ID: <20260723225943.GE260824.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <2c03ac97-60a6-4352-a942-27dcebae8d22@linux.dev>
 <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>
 <20260720163452.GC1191959.vipinsh@google.com>
 <cebd1045-5dd7-4f35-8750-9c39790ceae9@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cebd1045-5dd7-4f35-8750-9c39790ceae9@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_160139_027293_A6E6E7F0 
X-CRM114-Status: GOOD (  32.49  )
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

On Thu, Jul 23, 2026 at 03:18:55PM -0700, Yanjun.Zhu wrote:
> 
> On 7/20/26 10:08 AM, Vipin Sharma wrote:
> > On Thu, Jul 16, 2026 at 06:22:07PM -0700, Yanjun.Zhu wrote:
> > > On 7/16/26 4:24 PM, Yanjun.Zhu wrote:
> > > > 
> > > > On 7/14/26 8:14 AM, Vipin Sharma wrote:
> > > > > Testing
> > > > > -------
> > > > > 
> > > > > Tested using VFIO Live Update selftests in both QEMU and bare-metal
> > > > > environment (Intel DSA PCIe device).
> > > > I want to make tests VFIO Live Update selftests in QEMU. But how to
> > > > select a PCIe device?
> > > > 
> > > > what device do the PCI ID 0000:00:04.0 and 0000:6a:01.0 mean in the
> > > > following testcase?
> > Sorry, this was my copy-paste mistake when combining things from both
> > qemu and baremetal. You only need one device not two separate ones.
> > 
> > For testing using QEMU, you can use QEMU PCI test device.
> > 
> >    -device pci-testdev
> > 
> > In VM, use `lspci` command to find the BDF of the PCI device. It will show
> > output like:
> > 
> >    00:04.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
> > 
> > Then prefix the domain (generally, 0000) to the BDF and use the testing
> > commands.
> > 
> > `0000:6a:01.0` was the BDF of the Intel DSA device on my host. I
> > incorrectly mixed two devices during my copy-paste.
> > 
> > Limitation of qemu pci-testdev is that it does not have the DMA
> > capability. I used physical host with Intel DSA to verify that the
> > device performing DMA during live update gets reset.
> > 
> > > In my qemu,
> > > 
> > > 00:04.0 System peripheral: InnoTek Systemberatung GmbH VirtualBox Guest
> > > Service
> > >      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> > > Stepping- SERR- FastB2B- DisINTx-
> > >      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> > > <MAbort- >SERR- <PERR- INTx-
> > >      Interrupt: pin A routed to IRQ 20
> > >      Region 0: I/O ports at d040 [size=32]
> > >      Region 1: Memory at f0400000 (32-bit, non-prefetchable) [size=4M]
> > >      Region 2: Memory at f0800000 (32-bit, prefetchable) [size=16K]
> > >      Kernel driver in use: vboxguest
> > >      Kernel modules: vboxguest
> > > 
> > > I am wondering if the above pci device can work well with this patch set or
> > > not.
> > I think you should be able to test Live Update with any PCI device which
> > can be attached vfio-pci driver.
> > 
> > `vfio_pci_liveupdate_kexec_test` will initiate DMA if the VFIO selftest
> > framework has the driver for the passed device (Intel DSA) otherwise it
> > will just skip over the DMA flow and do the remaining things.
> 
> Thanks a lot. I'll run some tests with QEMU's `pci-testdev`.
> 
> If I understand correctly, when using `pci-testdev`, only the DMA test case
> is expected not to work, while all the other test cases should work
> correctly.
> 

Yes, other test cases should work.


