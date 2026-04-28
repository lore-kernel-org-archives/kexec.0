Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9704FF8877
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncltMbqb0oRbMvugQb2r0egpAWKoVDCs8cMwwYz9oEg=; b=w7Y/WxDoJ0msfAh+TiN4a9J92A
	CtKztHcc26x/NG3tyQ9Y8rutpUL2hMyubCcJ03yy6lX4V2pEGER6f8SmLDKZ5+rgwduArZ3kAKzKt
	nFuILE50sILo9nNUAkaX/vy8cVRiu2NP0ZRFXNk2BSoRQfksnenUTvgRqek0DrOHuhvE5xCXQzQSZ
	eoN7MrT6XC/Lj6Q3sWvGE1G1D49R31jRIGV0Nd2hoCPmhoTkEJXgdzLuAQaTKw6GYX6owcKG3CXq8
	MvYk2yiG5lCVRWFU3E2vew/H9BOVN1MJtX1E7SYo9q8MEVhIQ+BjxKiiflXv40F9r13Ekf6pesHfg
	hLlFHzpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmLo-0000000227b-1PRH;
	Tue, 28 Apr 2026 17:36:00 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmLl-0000000227H-4A5R
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 17:35:59 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso24305ad.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777397757; x=1778002557; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncltMbqb0oRbMvugQb2r0egpAWKoVDCs8cMwwYz9oEg=;
        b=ry3RzSre4jBDhFEaiYI0obzDV/Mlu7pSH/YQFJOT6luknuJlLTDXzlR058bPn3up/1
         a+P5MGPszP/9UgGQR0GUUm7Ynx/6XBa6y862xQeF88sq/09YnL4anMfFZ40ITRpPOZde
         U/uXP0Sla/+7n0QVMgPtCvT5qeyfGCB8/1Vlt9hUzCsbA5iSV9Wk69/aO+FN/TjOogFN
         HNtWVHs6EoRm7s+vUDb7L4qa0mHFoMYGKzRSl7Q0m80JHEdcOAxEfG0JSVZ7qGOZWBC/
         JoUaW52ltL/WVnrtmNAo/AhBpR4GEgTmzrzhCvopwGVmZq+LBY1wVlFDyt3w+QeXUEK+
         anHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397757; x=1778002557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncltMbqb0oRbMvugQb2r0egpAWKoVDCs8cMwwYz9oEg=;
        b=k1ZYs28/AXxio1j0jyimUWjRnnkR/JoYQJqhVwnmgXyAtgZKDYQxS+4F4RAvJAyNGW
         /DiSqaXOKXzCXshuQE4kvY7dAxO/nOPMs4Vc/V1Aoh8q84fXAWrZOoPeUvg0mTfMwqta
         52o11SKWAShyz6RkoKLsuNejPHwg+FK8Y8+9A5F1QMc63iyc6uZPsgPvYaGnz+9V8JS/
         HHCa+LXvV1NwEn0v6Yd2BA+ew/UTyRYZ6t9c8eu7YA5Y74r5nUiHzEyhZDQYSauwTnFh
         fNSmnexIzfAEdVhMz/g3LC1nClMNxKDgklQSN9YH+IAt10ogPqVd+oJfVwnveaCWph2S
         04hA==
X-Forwarded-Encrypted: i=1; AFNElJ/O872WZ8bj7cGBWurlBOK29pYwfVnxS7bUGpght+5Y4qm6bxfLf6FJNJLTpQAx8/zymj9oeA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3HRS7BO0746JksTAKL4VcuK13XT/cKh4s1KYfT0aihUgmsWEM
	+2NIovmyTq3NbNh/q/gN2+qv4k8Jan2Bbay/nj9L8qjP0TZ8dDf0Y0otAT9b+hSFWg==
X-Gm-Gg: AeBDiesyCswj2MepXe0ZLmhqnLtIhvtS9zWZICRzdybPr3Pz4xJH1Zaym0suIRhCMIe
	W8mpZXACaYVZpmg1twY/dGD4z1RSpuqhRSA2RigVg0eG/wyP8wMBKLhFAjYHth3skhbQR+cLmVR
	QLiNd1xHkz8BIWTUzVJ9uTWUOKEipe+MsMG9XumU/2BKtvQiyUORq7X49B6xNUoSb++huKqO+a/
	8Qv4E2wa1oVGf93iLl5EAgnChyykY5Zegd3nyDTn5EPIsy/wdigUyZwZtKivd7QZO0g5+Rk68JE
	PVrUf9jjftvTQUZSpiiDMkKFZI2CG9oDILAjNTczqs11GeM8KXDyc9gHEYp+pV+EgA5CtllRkwr
	GaCuJEkmBDaI2Fd3BILDXgmC9BVvOBLrN3uZyRPOTYichT3wQlFs/hcpv7cD7sKchQq+xPju5Pl
	Qhx1SJL5pQI6Gst/3ciCok1lqMVGZsYru1KSf76dCw96373QD/71I21Ybp/loqYM3IGArpJ4W7G
	23rFF30CsE=
X-Received: by 2002:a17:902:cec2:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2b987ed382bmr144705ad.18.1777397756522;
        Tue, 28 Apr 2026 10:35:56 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf7f43bsm3432664b3a.58.2026.04.28.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:35:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:35:52 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afDvVhkp8tQpsVlt@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afDqs6oqWlhoVqMN@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_103558_033353_031BCF5E 
X-CRM114-Status: GOOD (  15.24  )
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

On Tue, Apr 28, 2026 at 05:24:53PM +0000, Samiullah Khawaja wrote:
>On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>>Add APIs to allow drivers to notify the PCI core of which devices are
>>being preserved across a Live Update for the next kernel, i.e.
>>"outgoing" devices.
>>
>>Drivers must notify the PCI core when devices are preserved so that the
>>PCI core can update its FLB data (struct pci_ser) and track the list of
>>outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
>>device must be preserved across Live Update. pci_liveupdate_unpreserve()
>>reverses this (cancels the preservation of the device).
>>
>>This tracking ensures the PCI core is fully aware of which devices may
>>need special handling during shutdown and kexec, and so that it can be
>>handed off to the next kernel.
>>
>>Signed-off-by: David Matlack <dmatlack@google.com>
>>---
>>drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
>>include/linux/kho/abi/pci.h |   7 +--
>>include/linux/pci.h         |  26 ++++++++++
>>3 files changed, 131 insertions(+), 3 deletions(-)
>>
>>diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
>>index 5c0e92588c00..5b4c8d9e462c 100644
>>--- a/include/linux/kho/abi/pci.h
>>+++ b/include/linux/kho/abi/pci.h
>>@@ -23,19 +23,20 @@
>> * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>> */
>>
>>-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
>>+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>>
>>/**
>> * struct pci_dev_ser - Serialized state about a single PCI device.
>> *
>> * @domain: The device's PCI domain number (segment).
>> * @bdf: The device's PCI bus, device, and function number.
>>- * @reserved: Reserved (to naturally align struct pci_dev_ser).
>>+ * @refcount: Reference count used by the PCI core to keep track of whether it
>>+ *            is done using a device's struct pci_dev_ser.

nit: I was wondering why is this named refcount and why it is needed. It
seems you are using it to track the preservation dependency between
parent devices and leaf. Maybe add a comment to clarify that.
>> */
>>struct pci_dev_ser {
>>	u32 domain;
>>	u16 bdf;
>>-	u16 reserved;
>>+	u16 refcount;
>>} __packed;
>>
>>/**

Sami

