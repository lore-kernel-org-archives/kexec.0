Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B76EC98328
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ryWXjYMx77NDaQsPP9QlmEYj6eVxrasAG766hpzWjdA=; b=yv2HdJPPeX5uvYxkLuW6/9XxBo
	GUKyuOZ/oidTzRqkIguT7mqqLbfItkRMGFNmp64n1uuj8k6jUNlj2TLs7RNShbFKNh58uxIAZNoDd
	0foIzNNAzrYaN1sLAIR6BBC3oEUEXQHzLAmo/mB8OHEEnSXoEcU9NCESAkl0cu6TncYuzqDQAcTAR
	qZGkSt5vEBYPgOG5QsL3GS/Q8TGMst5r6XyxAdrMPzZhn1LNSzt3AhtqjhZ7aX2NhrkQN4hY0+Y4Y
	Aj4jLsg9E6NNQFDKktFg87VjKWLQenGLQ0feroHX9XWMy+Clf2QrNlnMRKCZ9Ihe34sV4YQmOfDB/
	OmHs8mUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAB8h-0000000ECmA-2AHA;
	Fri, 25 Sep 2026 18:59:19 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAB8f-0000000ECll-0ZlS
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 18:59:18 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d8facae850so9575ad.0
        for <kexec@lists.infradead.org>; Fri, 25 Sep 2026 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790362755; x=1790967555; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryWXjYMx77NDaQsPP9QlmEYj6eVxrasAG766hpzWjdA=;
        b=uyfcW/czNSyGNrHM+sG6avUegGwRYtxbGkuNYmWv+lboo9Mew2cIKqhsZELCxzxEpt
         AzUqXJXbxA+ck3qBOy4vz5ym4QDH31UCBXwNtrybolE51Pyd9G8qplAD+Cq8JDLrRBLl
         LHI7d5hR7kJVsLi6Np6Lg5PHmA5dZelStph1IyxVyMjxbI7+18IF3hLaq1s6gHiPCLHr
         UTGP8lsolZcCwhnreaovzpHZc7DwX9jdPotPFg1Z0Xy73qEVJHmWfi/Do2PdZGvOu2MC
         2/voqmXvoBJbjvDn9OQ1cc7oaQVN319jD6sBPZNpMKT4XeKaanCBPq+YPdc5Xsr5rT1J
         qD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362755; x=1790967555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ryWXjYMx77NDaQsPP9QlmEYj6eVxrasAG766hpzWjdA=;
        b=yR9n+G3v6g7LsQzOJwZRoWoZ3R12dJWGRJMeL/bV/7BTRGhlQFISl73GYoNLQEPefP
         fX1uJcyhQU8uIGa/V33DSCUNr7pGoeD+Doswc66IwFHOHx64ADX91BZpqtHXEkMF3j6l
         C5LSrFCGuAt+52v8qugtyY+zUX5aiWz51jPTbAT+pKH6nuenZrG+SDfu9W58zsjKZCdF
         hp3IiNkv8WgV4fzZlIZvceZOqzFX2LmtxNFKM0Jkf9a/4B7/81mOprTg8YivoI7xCgcy
         Bjd2PmNagDD49iFc8FwuwkI4l/l0McC1JUoj32EVtAv0T1ksRpoO114HptpH0ep5DrmP
         SeMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgGKhXCzKvj3wlrmPOGZgkLN4vCKvM7yucqdv1a5Wy4a9m4IZ6chnQPJn7hD9uAreqwJPEVA==@lists.infradead.org
X-Gm-Message-State: AFuF++mzOoHgH2O+kMRf/mTYWkZl3oP02kjw0NcHuaKkiIwTDsn8bxBT
	wR99GYOJBUU9oI1wwYdAfpC+044CN7XtGac/9K0dY3tOsjk8m2n8n1HTiwGs440Q9w==
X-Gm-Gg: AYBFou0BXXVrnBONaXH3nRrN/vM4RJO8FEAresmTk9dYsbZsPOmEtvw9vHDy1HpS3na
	M/p6f2zL6U0kfPKDZfsgq5gfOGcoGDeQL6pqbRa85RptoWKfDvpv/3QX/jRGr0/vNe2Ha7XAnME
	ugJOJgIbLyHl6z5rUdNFJIF77YahrHImNy2V/f4+0nALSDAugbO/dOuxmYjCu4D/fIpAMyBbUVY
	K68P1vvnlnxk6eBC58PI31i1YGkxX2hwh7xz7niW192chrYEAUHjqQmerPLsHOA/3cvPWr9uP2g
	ntK2W19+uKcTgNRjoIGKPvfVmTRMNCERaWCDswa2zg4NufpXO3BH3eA34qUQGBkyrL8EMirJpDe
	e/XacK4RJK3YWiEdh/FeZy6fY395LnwjgR98vBxwH1W970z/ocSS+sNfjL3R+TTHbdOnOdBJ856
	btLZMIA6tMyW+K/F8PzSQaZVQ2xwab3BaBSlsYz9diXjYNlJHV4fLgRzJ7yzvGgB8iU+xIkQx8f
	GQk9lxR4kU9YonE+1kAPooLbnkMI7KERDzwo306pVkoaUpTw8OVniABaqwApn2ZN78uWWtkt+k0
	ApdV
X-Received: by 2002:a17:902:868a:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2dfa649041dmr428155ad.5.1790362754409;
        Fri, 25 Sep 2026 11:59:14 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea18ebb7sm1635695b3a.18.2026.09.25.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:59:13 -0700 (PDT)
Date: Fri, 25 Sep 2026 18:59:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <aratPy2p33MObulT@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
 <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
 <b1a845c3-3720-4ef6-8c97-8a40ee7bd286@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1a845c3-3720-4ef6-8c97-8a40ee7bd286@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_115917_225223_C85C8D03 
X-CRM114-Status: GOOD (  20.97  )
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

On Thu, Sep 24, 2026 at 09:47:03PM -0700, Zhu Yanjun wrote:
>
>在 2026/9/22 11:53, David Matlack 写道:
>>On Tue, Sep 22, 2026 at 11:36 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>在 2026/9/18 13:06, David Matlack 写道:
>>>>Future Work
>>>>-----------
>>>>
>>>>Following this series, we expect to make further improvements to the PCI
>>>>core support for Live Update:
>>>>
>>>>    - Allow P2P across Live Update by avoiding resizing or moving
>>>>      preserved device BARs and preserving all upstream bridge windows.
>>>>
>>>>    - Support preserving Virtual Functions by preserving SR-IOV
>>>>      configuration on PFs and enumerating VFs after Live Update.
>>>Preserving the PCIe topology, bus numbers, ACS, and Bus Mastering across
>>>kexec is a foundational step for minimizing downtime.
>>>
>>>As we look toward complete end-to-end support for DMA preservation
>>>across Live Update—especially for VFIO device passthrough and dma-buf
>>>sharing scenarios—IOMMU table/domain preservation becomes crucial to
>>>prevent IOMMU page faults when devices continue performing DMA during kexec.
>>>
>>>I would like to ask about the current status and roadmap regarding IOMMU
>>>Live Update / KHO (Kexec Handover) support:
>>>
>>>Is there an ongoing effort or RFC series for IOMMU handover / page-table
>>>preservation currently in development or under discussion?
>>>
>>>How is the coordination between the PCI core Live Update mechanisms and
>>>the IOMMU subsystem being envisioned for preserving IOVA mappings (e.g.,
>>>restoring domains or handing over root tables)?
>>>
>>>Any pointers to active discussion threads, RFCs, or future plans
>>>regarding IOMMU participation in Live Update would be greatly appreciated.
>>The first IOMMU series to support Live update, can be found here:
>>
>>   https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/
>
>After cloning the source code from samikhawaja/linux, branch 
>iommu/phase1-v5, I tested the VFIO live update functionality in my 
>local KVM environment and encountered the following issue.
>
>When I run the following commands to verify that VFIO live update 
>works correctly, I get the output shown below.
>
>I am currently testing with VFIO v5 and PCI core v9, and I am not sure 
>whether this behavior is expected.
>
>Interestingly, when I revert the following commit:
>
>vfio/pci: Preserve the iommufd state of the vfio cdev
>
>the issue disappears.
>
>Could you please let me know whether this is expected behavior, or 
>whether it indicates a problem with the current VFIO live update 
>implementation?
>
>"
>
>echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
>
>echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
>Preserving device in session
>vfio_pci_liveupdate_kexec_test.c:122: Assertion Failure
>
>  Expression: ret == 0
>  Observed: 0xffffffffffffffea == 0
>  [errno: 22 - Invalid argument]
>"

Hi Yanjun,

Thanks for testing this.

This is expected. With "vfio/pci: Preserve the iommufd state of the vfio
cdev", preserving a vfio cdev depends on the preservation of its
associated iommufd. Since the vfio_pci_liveupdate_kexec_test does not
preserve the associated iommufd, it fails with -EINVAL.

Note that the IOMMU persistence series does not update the
vfio_pci_liveupdate_kexec_test, with those extra bits, as it would
regress after_kexec() part of the test because the retrieval of iommufd
is not supported in phase1.

Please use tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test
added in the last patch of the series, it sets up the iommufd and HWPT
preservation before preserving the vfio cdev.

The wip phase2 can be found here if you are interested.
https://github.com/samikhawaja/linux/tree/iommu/phase2-v1-wip

Thanks,
Sami

>
>Thanks a lot.
>
>Yanjun Zhu
>
>>
>>The IOMMU series builds on top of the PCI core support (this series)
>>and the VFIO series linked further up in the cover letter.
>
>-- 
>Best Regards,
>Yanjun.Zhu
>

