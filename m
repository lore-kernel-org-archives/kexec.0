Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C17C55822
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYGJAHMfaG43a10+DAahsWI+BDlKwBdKnhIOAj6soTQ=; b=y26tGrNXL1QejaXtsI1JXBX+DE
	oRQ/LYfG3tA5h4ivabytrXJArWIh/83ASbOmN9fNPb8YdNJ1OGYf9GfTIu13IiwyFEB8MYPjDv5BC
	UTY4Lc/7vMzZs+o1MbGZd1PfIR69fVGGS5LWy4zgTZG8nBB1Gq2yGdJqLixDvxZS39PKuCUQvlwQg
	Ehi5XRzQozhXy9mz2iCA/1G5wPkoUBD2Zr39LgvzQpxfgqOxrFEQZOtsDZzDuIOEgUuHwnZdUVjyz
	YVwmad9dXSjx8eG3zi0gmK0Hwqd9a0BOpCclITDXJLYPIHsToyHFSClGC50vdYkSUvO06On/Lv0EE
	UZEzPqow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrUic-00000003HML-2D4t;
	Wed, 05 Aug 2026 06:03:10 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrUiW-00000003HLy-2XeN
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 06:03:05 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2cede6375caso70845ad.0
        for <kexec@lists.infradead.org>; Tue, 04 Aug 2026 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785909781; x=1786514581; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYGJAHMfaG43a10+DAahsWI+BDlKwBdKnhIOAj6soTQ=;
        b=JId49Q6SV2TaUIW7/R5TYmHwP632Wvq0QDpTmb2HVV9F02JEwSZZMvsgQCsE8dok8F
         l7mgsVGsUIqpVqLjTqU2BBq0DONHSkettlvuHFa+t8SW4UXhDddM+pg3oYRtlvsrdk3X
         ZHbb05VvWFaxE+T47qfNKM0UJa7DuwHqmvaxr9OQ9qEaIj3AddePd296gFHxTVXNMFbE
         Yvb13Zmde5GJY+o9QxHtdSzt/IuV6CXirSUDvE/ubAtdv0lnNZocm6lnRYGLmXJuXiJY
         UCAqSfakWQhZHIwpjLsehKDRNPy/vvZI+laqDyEHNI9qPvBtJVR+9O38TxZbL/R+hbzS
         36QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785909781; x=1786514581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kYGJAHMfaG43a10+DAahsWI+BDlKwBdKnhIOAj6soTQ=;
        b=aLi0d/QgeBuhrPqxmF7wJB/4Ikv98XaeQmpR6yvPdAWRIlHHD/p6d7RUC+xp31GS1r
         8Q+yWx5Y+qmK3CNuhB2Kb1MdZzLHo2JIDU4jsQr5KPT8+1HkK3yWnxLZbTe5wpCAsDWm
         kGbEh38ErEx4bQ6NJ32/JZufNeGMJ9JS2xFB5A6fG/hHfEKGiMoz+Wi1eKBv5ig44ujh
         3gGi97/c12GOolwRSMya8VCqMFy+LV15lZzmrzPM6BPPpmqrzxcLmeELBG5g9JSKIG+h
         tG3lWzyTYzBQtnM9xeWHjSl3OdU9rCLl3U5zsCJ5gy1+zoh85V5sawZGLWduGfpGzQeh
         5NNw==
X-Gm-Message-State: AOJu0YyEotrba0iOypKYJH5WhBqqr9TDGbwj7rSg/Dece1H53tG/OT/T
	RQF5xwb4JAyvlvRDFKIh41Y44rxP9Jo75y+VHa+DkfLrVBiFEjWNsQ824OZ3n1vSUA==
X-Gm-Gg: AR+sD13k89oNeFDoWehlkOg3nb5RXL6OfBt1HQRqSgprnVogTMHeouwbmRTFtnjznHw
	0KzJwR0sa1CiYQSCPJqTbmkzP9hIR6Ox6SQ9aAkcidovy0QnxLGHeDPor4jW6m4NCtj7ZJmxDSs
	jqB5NwtFuwFmGT7VlXMoqad6ztpeHDGLH3ksz099UjAw63P96Ymjz+FIV7WCUATeIkU1qZRDLNM
	a6aFbTaL67Mvbbdrdeuwib9Prt+c2+KST2TpGrfF2MdAAR6kd713ZpfzXO4MXt8tS3DOZ8EENkT
	vyoAtmVdHCJRUih4pwdHt+LZJULYpRRL5N1QKEs4mia9NdO3rxL6WHbEhXmJrZw2BK5WUrU+ssD
	/ysL2uowKzRgLYURRJI+/GMbEDWSCsZ44i/jD9Y/B6KWlLq22Fmun1dsSDuQA6wfCGRCqRVWvKL
	DBA5ATMqlpBMLPKPZ1Gpd0F+7ZB2qsKdQAd9W9EmrKdV4wYfPPcCMJLvr8d7IxVBQ3yXbBRR2EP
	toGyS15Ag205kv7MfHBaV8=
X-Received: by 2002:a17:902:ea0e:b0:2ce:b436:272a with SMTP id d9443c01a7336-2d0d0704d14mr5233675ad.3.1785909780734;
        Tue, 04 Aug 2026 23:03:00 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfdae85sm3462574a91.3.2026.08.04.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:02:59 -0700 (PDT)
Date: Tue, 4 Aug 2026 23:02:55 -0700
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
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
Message-ID: <20260805055042.GA806762.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
 <0556e2fc-3be5-4023-a9a4-8482fa8c88b2@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0556e2fc-3be5-4023-a9a4-8482fa8c88b2@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_230304_794535_2E917FDE 
X-CRM114-Status: GOOD (  23.95  )
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

On Tue, Aug 04, 2026 at 03:19:34PM -0700, Yanjun.Zhu wrote:
> 
> On 7/14/26 8:15 AM, Vipin Sharma wrote:
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
> > 
> >   $ kexec ...   # NOTE: Exact method will be distro-dependent
> > 
> >   $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
> >   $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0
> Hi, Vipin
> 
> Thanks a lot for your help. I followed your suggestion, vfio-pci setup can
> work.

I am glad your setup using virsh is working.

> 
> The followings are the test result. In the step 3, after kexec, there are
> some fails. I am not sure if these are known problem or not.
> 
> 1. Before kexec command
> 
> + modprobe -v vfio-pci
> + tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
> + echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
> + echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
> + tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1
> 0000:00:04.0
> Preserving device in session
> Preserving memfd of size 0x40100000 in session
> # [STAGE 1] Forking persistent child to hold sessions...
> # [STAGE 1] Child PID: 1236. Resources are pinned.
> # [STAGE 1] You may now perform kexec reboot.
> + set +x
> 
> 2. Run kexec command
> 
> 3. After kexec command
> 
> + echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
> + echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
> Checking open(/dev/vfio/devices/vfio0) fails  <--- I can confirm that the
> /dev/vfio/devices/vfio0 exists. But open this failed.

This is correct output. Test is verifying that open should fail. If it
didn't fail the ntest would have exited with an error. A preserved VFIO
FD can only be retrived using Live Update session ioctls and not through
usual VFIO dev path.

> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
> (vfio_type1_iommu)      <--- fails
> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
> (vfio_type1v2_iommu).  <--- fails
> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
> (iommufd_compat_type1)  <--- fails
> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
> (iommufd_compat_type1v2). <--- fails

These are all correct output. Test is verifying that userspace should
not be able to get VFIO device FD only through Live Update session
ioctls and nothing else.

> Retrieving memfd from LUO
> Finishing the session before retrieving the device (should fail)
> Retrieving the device FD from LUO
> Finishing the session before binding to iommufd (should fail)
> Binding the device to an iommufd and setting it up
> Finishing the session
> 

This is shows VFIO FD is successfully retrived by Live Update ioctl.

So, you saw expected output from successful test run. I will change
the message getting printed to avoid confusion. I think current way of
printing ".... fails" is confusing.

Thanks
Vipin

