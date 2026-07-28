Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B75C54F4C
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NSd0Snni0h0/tE0vaFb4D1at9rHpTmqJbpcAV8DTvqQ=; b=fAobfr4cqWUK+H+ubvI9PBfq+E
	w/ahk65NQu6EEi5Bntod+Vz9ud1MBSkogdjhTiWWCbJQXUKZEYQ8WUm/TbeEq9PD0frsbt5nfEOvz
	v5LIWoYq7vThArkOLcvzQiS6Lm8K/SK113WsU1v6HU9/G+txl3yOS69qLDY8BtxZ8YMZ8wOI8TZLe
	QyhMdLTAmQe/fk/pTB5Er1od/OhBZP9dzxkRWYXdZkkGjhZ/CCCrRPGaIxnu5PoNX60V88fbx+T88
	FAv7WnZxTqSerLjuFCvL58HsxeArwO3eCe0N4b7fftE9ajrOmdi91xgePN4WEK/XqPU878rKY4gmj
	u3VJ6+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaT4-00000004Tjz-1Jux;
	Tue, 28 Jul 2026 05:35:06 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaT1-00000004TjP-2iVd
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 05:35:04 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cacef7d299so49525ad.1
        for <kexec@lists.infradead.org>; Mon, 27 Jul 2026 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785216902; x=1785821702; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSd0Snni0h0/tE0vaFb4D1at9rHpTmqJbpcAV8DTvqQ=;
        b=n5tkeYFFHXzUNz8sUIZPMuejpPO3GJwkzLxCbcXs1KGq/jrFyxTjISMNBEFA3iIHkZ
         hcWO+F3qM3IAeSdF/29KD25R2QLuylSKnF4hMaLtLKnJrTgMHQ1zVBaJJ26MGE7dI1/x
         UbvtMoJFXqpolpqbxH546I9DRnm97/ZzZ96Q7OPJDZMZvD9c0RowjIciMZUlP5vGt6un
         /F21y68FUK7adgWG9hHt3HxWXPpWQIrKa5jn3SiVTiJGKwYuQmVP7zBCcQ3Fd4npYWQG
         apMxXwpMjE0+bF32/KSwCC55L2bweQ9zYjyrULDVY/1ixka3z9EXA/vp1vJg8APxS3zc
         N3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785216902; x=1785821702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NSd0Snni0h0/tE0vaFb4D1at9rHpTmqJbpcAV8DTvqQ=;
        b=W5GUdDiK5oRfb0WIxncCWQZi42uMvgFvehoQW5WAWsAP4Jx+DHito6T4nr/k14WfeF
         YnQHiStri3eWjJVDjUS/Lmn3eWUJoOTvYyu7V9CjJ5l0qsVUYbxnewt3mmCZW4Q1fU2e
         +a8MIv9jy5XKFcPGuPUNZYe4pcDy/IXAtoL9HiRW+rEQJlVmZ5IpU5cuSvgPWwwaOJYG
         u8P444VGb5PaWoEB29xlnmOoJKEn3EHVvpJfZArkEGWKVLwCjpXgN9K3zK+1w/Wc/hJA
         B9GrF4N3G2H/hc14EzsH3/uJ9ojPHI0J1qz6zuyQdb5K89FiMLzQMPhf+rfLuyY0mbF8
         I+0w==
X-Gm-Message-State: AOJu0Yz/Uk/h5RGjfY7SFodTMR8jdGvd1IsW75x6cM4Ftkl3SgE3Aswe
	vTgGJ+YdNINRzXa3hAlDssQWjsAvZXxUNfEuQUeqI3Pf3WTDTEM+XQf3ajNXBufFgA==
X-Gm-Gg: AR+sD11hFIKradVypL54RBahcJrGINAeZV8z1q8vqzZV1IrHlFbYlk8RytkqgVWDt6m
	ae0SHAWAQbfpSTgHC3GqjD/qqj/hES736SpAr7Tq40D7o1FpTxlrnZpW2FnTKNOrK5a0escCEVX
	STmsrl0HSR5dP2ycVv46O/T+5n13Pm+zXODdFKwUNlbrRg7d9YpWytzi3L/IVepZdugt/oyYhZO
	ju9UoOUQQi7CfYLgVH++aqTo6ZF9OoVBUe4Az9XD/NP/5YRpTZ54n5S2Qe1rO+cD0dgTr1XsENg
	XKoU5taIRdT8bMVBUETdmjMiDyRSe0zcG1V6NluIpSxDsABBkPEoR5sRBmWCQqO6fGa6M1EAi82
	8u/k4Xj1LkmMCo4qlSgdndAR+ekYRyH9CwlDyumLknzjYTyf+c+qbuLpz6kewNRHPzeKKV8qAqf
	WjEfleJ/SXOibEvaWaIijPgrYd6+QJ7FrD0HLVNneXjbpMGFBnjg==
X-Received: by 2002:a17:902:f1d3:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2cfdb75acb4mr15516765ad.12.1785216900834;
        Mon, 27 Jul 2026 22:35:00 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08ae3079sm3822540a91.3.2026.07.27.22.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:34:59 -0700 (PDT)
Date: Mon, 27 Jul 2026 22:34:54 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
Message-ID: <20260728052011.GA736369.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
 <c3440ed3-0fc2-44e5-a05a-922344eb34d1@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3440ed3-0fc2-44e5-a05a-922344eb34d1@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_223503_700113_D82FBA0B 
X-CRM114-Status: GOOD (  21.32  )
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

On Sun, Jul 26, 2026 at 05:40:54PM -0700, Zhu Yanjun wrote:
> 
> 在 2026/7/14 8:15, Vipin Sharma 写道:
> > Add a selftest to exercise preserving a vfio-pci device across a Live
> > Update. For now the test is extremely simple and just verifies that the
> > device file can be preserved and retrieved. In the future this test will
> > be extended to verify more parts about device preservation as they are
> > implemented.
> > 
> > This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
> > manually along with a kexec.
> > 
> > To run this test manually:
> > 
> >   $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
> >   $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0
> # ls /dev
> autofs           disk       iommu         mem     rtc0      tty10 tty21 
> tty32  tty43  tty54  tty8    ttyS18  ttyS29   uinput  vcs6   vcsu4       
> virtio-ports
> block            dma_heap   kmsg          mqueue  sg0       tty11 tty22 
> tty33  tty44  tty55  tty9    ttyS19  ttyS3    urandom vcsa   vcsu5       
> vport2p1
> bsg              dri        kvm           net     shm       tty12 tty23 
> tty34  tty45  tty56  ttyS0   ttyS2   ttyS30   usbmon0 vcsa1  vcsu6       
> vsock
> btrfs-control    fd         liveupdate    null    snapshot  tty13 tty24 
> tty35  tty46  tty57  ttyS1   ttyS20  ttyS31   usbmon1 vcsa2  vda         
> watchdog
> bus              full       log           nvram   snd       tty14 tty25 
> tty36  tty47  tty58  ttyS10  ttyS21  ttyS4    usbmon2 vcsa3  vda1       
>  watchdog0
> cdrom            fuse       loop-control  port    sr0       tty15 tty26 
> tty37  tty48  tty59  ttyS11  ttyS22  ttyS5    userfaultfd vcsa4  vda2       
>  zero
> char             hidraw0    lp0           ppp     stderr    tty16 tty27 
> tty38  tty49  tty6   ttyS12  ttyS23  ttyS6    vcs vcsa5  vda3         zram0
> console          hpet       lp1           ptmx    stdin     tty17 tty28 
> tty39  tty5   tty60  ttyS13  ttyS24  ttyS7    vcs1  vcsa6  vfio
> core             hugepages  lp2           pts     stdout    tty18 tty29 
> tty4   tty50  tty61  ttyS14  ttyS25  ttyS8    vcs2  vcsu   vga_arbiter
> cpu              hwrng      lp3           random  tty       tty19 tty3 
>  tty40  tty51  tty62  ttyS15  ttyS26  ttyS9    vcs3  vcsu1  vhci
> cpu_dma_latency  i2c-0      mapper        rfkill  tty0      tty2  tty30 
> tty41  tty52  tty63  ttyS16  ttyS27  udmabuf  vcs4  vcsu2  vhost-net
> cuse             input      mcelog        rtc     tty1      tty20 tty31 
> tty42  tty53  tty7   ttyS17  ttyS28  uhid     vcs5  vcsu3  vhost-vsock
> 
> 
> # tools/testing/selftests/vfio/scripts/setup.sh 0000:00:08.0
> 
> + echo "vfio-pci" > /sys/bus/pci/devices/0000:00:08.0/driver_override
> + echo "0000:00:08.0" > /sys/bus/pci/drivers/vfio-pci/bind
> tools/testing/selftests/vfio/scripts/lib.sh: line 9: echo: write error:
> Invalid argument    <--- the error is here.
> 
> 
> # lspci -vvv -s 0000:00:08.0
> 
> 00:08.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
>         Subsystem: Red Hat, Inc. QEMU Virtual Machine
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Region 0: Memory at fea1f000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at c000 [size=256]
> 
> Hi, Vipin
> 
> I worked with QEMU PCI Test Device. But the following error occur.
> 
> "tools/testing/selftests/vfio/scripts/lib.sh: line 9: echo: write error:
> Invalid argument"
> 
> Is this a known problem?
> 

Can you please check if you have passed iommu device in your QEMU
command? This is what I pass to my QEMU command

 -device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on

Also, add the following to your guest kernel commandline

 intel_iommu=on

This should fix the issue you are seeing.

Alternatively, you can also enable noiommu mode in VFIO by executing:

  echo Y > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode 

This should allow device to be bound to VFIO.

If none of the above approach works can you please share your QEMU
command and your guest VM /proc/cmdline.

Thanks
Vipin

