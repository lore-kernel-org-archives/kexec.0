Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FD3109C04B
	for <kexec@archiver.kernel.org>; Wed, 25 Mar 2026 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tqtdz49F1thS+8gpmqv2HF5sNOiFchZq7BXU6+8jf4U=; b=K0MH61X6LC34NeoYQWX1h1TlUu
	CeNOLeC6vLK7xJgoZkqMsK62WM9X5qz5N9KWSVHFOZgRYO36X8TTOWEGNUpHxvbaC84expAlhfyLe
	somalnWUsktMoUlzYe27hNeNSIZvcOYKHvZJPlfjeHoKdXDcKZPV2Wxach99R700o6eA81bMJ7tgY
	+yaH1x6I51RirR6A+Yo3nCnwYGKGJl43ZkUixlW8tbzsFGcsf/oqZ2RcNp+ASezzAEpcXpzaf/EUi
	THoAMRrtH6pHg6340Xw7ZcGhpLPVw+h8tPET4i7THuFm6+pki28cphwLJ5UiQBGrNEkL0Y4nLybL7
	w1YZMcfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5S3L-00000003zcK-3AI4;
	Wed, 25 Mar 2026 17:29:59 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5S3I-00000003zbf-43Ll
	for kexec@lists.infradead.org;
	Wed, 25 Mar 2026 17:29:58 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82c68339cf0so860915b3a.0
        for <kexec@lists.infradead.org>; Wed, 25 Mar 2026 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774459795; x=1775064595; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqtdz49F1thS+8gpmqv2HF5sNOiFchZq7BXU6+8jf4U=;
        b=pEUmYybFOT9CTt3JRB0SkjOMKiyvPxzF1tRUCTjc4lekt/bgE2rJigNM8fEoc4PmeN
         0Kz6PL2HKFszQqKqn5JSmfdu7OUMrR4zkSo5KMnw24ITCYXPHvm/4HXDMgIsAm3fOUAF
         4kQNpN143BOBq6cge9k3NSccfPsvu/BTXl6NSUrOeywTTq2j7xzURvNDJNgd/y1QG1CZ
         BtTGNL9wTFEBuMk/QCw9EFcRbE+cwHaCExokVNP8ISt671F+P5A/kumQCmx0bd9scSma
         pTslKD4uYxDlf2Kven7hTieP011vywGWkNfmXJwP2AthWEf+U3PKrB8qSw+1uXcyKlj7
         jC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459795; x=1775064595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tqtdz49F1thS+8gpmqv2HF5sNOiFchZq7BXU6+8jf4U=;
        b=Q+L7nODh/IvTIEKFIepdUm13mEknNoBkXuxmOquby0wbqAgx6lE86V09a7Eex1Z9a7
         wwel3jIUEOfmHHNdZb7CjY7/L5A36apC0DK4lhh0zZh42jqlt7nEozzGqmEnNaHTBZuU
         hxfyrgmz9QjNXQaxF0FWhmhzGECqA0hxmLM1G4IZ/boxVawRaprfiXS2kjxSDzFMsHGS
         dIKayPoxPVYBnvyAJ1NqY3eKskGpnDqI2dqB9VcRpF1E359IzV3Df3RmeGCyEggSOCJu
         sZsuIqoHY2fWOsEXVIGdpvDiTX6R9b7i6B87EvDqzgiDVCvYCBomOYg57JC53W1ZouSM
         /nsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvY4lMZrFeD2JBGDgYKqPUd/YvN2oEXppokUK4aduOM9Gfmvgu4rTqD92oVVKFfU+nqXxyPQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzu82pS0NFXBZhpyfC6XBSCHZeOk9U7bX7w6Phl6al4wYACtJsw
	p7F6dCTBgBnuzk/wS8CVbue58VqfZpzzkBHMtEYQRZ+CJ1oP5eyTZFgWvCjQz5V2JA==
X-Gm-Gg: ATEYQzy2SAg/aDPZ+nllkcvNfJ3MeyutR212yUuLVgQgFUZoGe8yTglbaxTRXgl2uC+
	Eix2Qx1QUHCIq/jOAtFq4WLPzXUw2ITR21Jeut9LPLd+TDtC9lhfLspFOXSpp+iRP9RTAZ38DuY
	9mzNcdlXe0WK46sxTjK0mmrls9Gv4jMAgTBr8kleqnI7QhpNEXqzCwVrQ7ZeNbem/P85eXGzpdi
	TQevSI+afMwk4Iifef2twHlhK1h8Dmq6XTf292+dcpu/4zJCyPrsY13JDDa6j9KMWcztRwypw0v
	4ZqYzJ5d4mY+aftOXBLN4WLNF3pECDmHDRzXgjoraq/Chx3EJmWaNxjvyHcwqwlQ4AQT9J2fI32
	VduTYzVkW00mrMsXDkTW6sz+1g2NAh9bnK1SgFCRJoBn4YdgF/1/Sot/5rr/5JLdEP2Oh7eaEAS
	8Rqw4P1unBkw/jJ3x47UdhLuwfPloJGTpw+DAGdsIGgKRfFjYrgtrhIzikvVwl/A==
X-Received: by 2002:a05:6a00:1826:b0:827:2dff:7116 with SMTP id d2e1a72fcca58-82c6d99ac23mr4021492b3a.13.1774459794263;
        Wed, 25 Mar 2026 10:29:54 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d216a0esm312308b3a.17.2026.03.25.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:29:52 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:29:48 +0000
From: David Matlack <dmatlack@google.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
Message-ID: <acQbjF53aIzv7Ieq@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-4-dmatlack@google.com>
 <376910fa-4232-4e58-bf87-0504202866a5@intel.com>
 <acLRICLAP5Ccqt9I@google.com>
 <b16f93af-1ec6-43f5-b4d0-b1d390e3c23c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16f93af-1ec6-43f5-b4d0-b1d390e3c23c@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_102957_014711_B023CD98 
X-CRM114-Status: GOOD (  47.10  )
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

On 2026-03-25 07:12 PM, Yi Liu wrote:
> 
> 
> On 3/25/26 02:00, David Matlack wrote:
> > On 2026-03-24 09:07 PM, Yi Liu wrote:
> > > On 3/24/26 07:57, David Matlack wrote:
> > > > Require that Live Update preserved devices are in singleton iommu_groups
> > > > during preservation (outgoing kernel) and retrieval (incoming kernel).
> > > > 
> > > > PCI devices preserved across Live Update will be allowed to perform
> > > > memory transactions throughout the Live Update. Thus IOMMU groups for
> > > > preserved devices must remain fixed. Since all current use cases for
> > > > Live Update are for PCI devices in singleton iommu_groups, require that
> > > > as a starting point. This avoids the complexity of needing to enforce
> > > > arbitrary iommu_group topologies while still allowing all current use
> > > > cases.
> > > > 
> > > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > > ---
> > > >    drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
> > > >    1 file changed, 33 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > > index bec7b3500057..a3dbe06650ff 100644
> > > > --- a/drivers/pci/liveupdate.c
> > > > +++ b/drivers/pci/liveupdate.c
> > > > @@ -75,6 +75,8 @@
> > > >     *
> > > >     *  * The device must not be a Physical Function (PF).
> > > >     *
> > > > + *  * The device must be the only device in its IOMMU group.
> > > > + *
> > > >     * Preservation Behavior
> > > >     * =====================
> > > >     *
> > > > @@ -105,6 +107,7 @@
> > > >    #include <linux/bsearch.h>
> > > >    #include <linux/io.h>
> > > > +#include <linux/iommu.h>
> > > >    #include <linux/kexec_handover.h>
> > > >    #include <linux/kho/abi/pci.h>
> > > >    #include <linux/liveupdate.h>
> > > > @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
> > > >    	ser->nr_devices--;
> > > >    }
> > > > +static int count_devices(struct device *dev, void *__nr_devices)
> > > > +{
> > > > +	(*(int *)__nr_devices)++;
> > > > +	return 0;
> > > > +}
> > > > +
> > > 
> > > there was a related discussion on the singleton group check. have you
> > > considered the device_group_immutable_singleton() in below link?
> > > 
> > > https://lore.kernel.org/linux-iommu/20220421052121.3464100-4-baolu.lu@linux.intel.com/
> > 
> > Thanks for the link.
> > 
> > Based on the discussion in the follow-up threads, I think the only check
> > in that function that is needed on top of what is in this patch to
> > ensure group immutability is this one:
> > 
> > 	/*
> > 	 * The device could be considered to be fully isolated if
> > 	 * all devices on the path from the device to the host-PCI
> > 	 * bridge are protected from peer-to-peer DMA by ACS.
> > 	 */
> > 	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
> > 		return false;
> > 
> > However, this would restrict Live Update support to only device
> > topologies that have these flags enabled. I am not yet sure if this
> > would be overly restrictive for the scenarios we care about supporting.
> 
> yes. It's a bit different from that thread in which not only require
> singleton group but also need to be immutable.
> 
> > An alternative way to ensure immutability would be to block adding
> > devices at probe time. i.e. Fail pci_device_group() if the device being
> > added has liveupdate_incoming=True, or if the group already contains a
> > device with liveupdate_{incoming,outgoing}=True. We would still need the
> > check in pci_liveupdate_preserve() to pretect against setting
> > liveupdate_outgoing=True on a device in a multi-device group.
> 
> this looks good to me. But you'll disallow hotplug-in during liveupdate.
> not sure about if any decision w.r.t. hotplug. is it acceptable?

Anyone doing hotplug during the middle of a Live Update is asking for
trouble IMO. And it would only prevent a hot-plugged device from coming
up if it were to be added to the iommu_group as an existing preserved
device. I think that is reasonable.

> BTW. A question not specific to this patch. If failure happens after
> executing kexec, is there any chance to fallback to the prior kernel?

There are many failure paths during the reboot() syscall that can return
back to userspace, and then userspace can figure out how to bring the
system (e.g. VMs) back online on the current kernel.

But otherwise, kexec is currently a one way door. Once you kexec, into
the new kernel, you would have to do another Live Update to get back
into the previous kernel.

