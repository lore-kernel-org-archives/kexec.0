Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19574FEC0EC
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oR1oDysYc7m3zFicPQmc7IfOCoKYgQXwHXDPwXVzCPk=; b=BftXP53Yw3eJkiKLe7uZF8ddfB
	9yuxVmaA6S9et5P6CNmNgnVCSAHeWSf6ufkBTy7IJEiWoDLwb2ZPZmhzM8BEBTwhH/rU4zDJVMZbs
	M4opapKlC5ezpJeR2+nZSj22vgJ/hSCUHt6x45XiaP+8G3jyDM1vBgzuhQI+XzPuxg+AKxMDIhyUk
	06J1RUfBXmtqeY4c7+huNb4MjGxqqTzFcR81MQuCTuQjDTHv8GIDmuoeMLaV1uwozKknSXUHhg8S1
	V9hZFu8WkyEZgPiaYWOf5Mr3/26YUnXVg0zMA/srYWHso1b6HS0p2UFubwj1sVvAmgK0+eRhUMJ7E
	NJLZzhIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5630-00000002291-06Ll;
	Tue, 24 Mar 2026 18:00:10 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w562x-0000000228e-1HKp
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 18:00:08 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-829a9d08644so2404175b3a.1
        for <kexec@lists.infradead.org>; Tue, 24 Mar 2026 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774375206; x=1774980006; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oR1oDysYc7m3zFicPQmc7IfOCoKYgQXwHXDPwXVzCPk=;
        b=GLbnkKv4T3i3mPpkTLMeRaO1w3xOXMAFy7wqBzkRg4CdnO+51yd85k0Bq2t1/YGUq9
         6L+bFhvQZybgW6bsDjAJph/EtltyMiw/nEJba+nGkiLPExu09Tguwgd/EIECrGtLw3Gc
         raYlPz2O0sSnH6vpsMlJuPNrTigJhWXnAiHqxEGYQ18e6T2+YRSJhJrlI1y0lbSYROwy
         zbMlXm7uUgXJz5QfR3ZUaXJwCGZl8iLvnM1b/sFr04KiL/2Ym6rRdhetxPLKJYZVAzGt
         qPa3klRmKnoaqINBbqpz8I/Vmi08sflAboMBFtp21arsVbbUPCWRUVb8xFzedmTXcPmk
         92wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375206; x=1774980006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR1oDysYc7m3zFicPQmc7IfOCoKYgQXwHXDPwXVzCPk=;
        b=bPfxHRPzKfRqsZ0KZjS+5GHAae8T2qB3XhvirAu0Dcne5JKft/vuZB3grc4gspwHjM
         1zAk/9s4MNKNSr5NDVcDMnMxGbXQ/aOPjOkR84mHnxo1/EcA3Pp5aDcp0gZ3wBG0GKSi
         L25c9ofalMXCCJx0HozZPCuPH4lujWc9IRHdhkKHQuFji+KphIW0aEuckDSoHNB1xskL
         bRP72XVRc7N9sfgbMtow4kbUCocrutnwxaV0doapTTK1lxpvZq+TPWR3aHNNRWA7J9vg
         zikUC9OPds1OfhLBu827JXaERPccP7u4ZQbiAz1OuT62SA4+YqaOs3hMeQ1xOJ9oStPd
         9dUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ62IEAaWAK1zJbJK11iSGMxXGt9foc1uXUVsF0LFJDDmgmbzWxbeaL15ULHUKjAjs7Se22A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxAKXNtJVb5W+6CUy6P2EdCqw7QbVLZj7tU+jCQZw/hiKn62geT
	+u5L9WJ+8UQ9b1b9hiSr682aHTHnp/ttah7hS+Ss9l0445GT7IXaSFCuSW8HKS3F5Q==
X-Gm-Gg: ATEYQzxMFSsKXTZ0UNIVz1jeLhi22b6amrXWir/LOzR1NPurl/kBjb15HEG+mNTXJvl
	uNz0S1b4u94XF6ZUyvtXoew8bvhr2KE8IliqmGkUagXdLGxYhmwXksTrjJpYtpkdx4M9xZhMaJ7
	0qR/V5okQOuTtv4ItwbZXoj0qyxJ6hjUCoFJTWpPq3qq1VQr/aD/AvwmU1oDvwgPETddtzqBaRz
	5Ww6r1Rcx5o5VXP0qLK7APP3VJ+aD+Jl6KjHOwdGxUHB6AU/QclAD2gwP2tJXM+5UjZz9hBmnKI
	X4u89geeH7Q4g7mrlctDM5GRQXuexb49t4erPaVIwDwRxi7NlamEwXoNeggyaz3yDIikMkTP5VQ
	AiGlFsdfvMBGMInsGPy3hPJvJLvqzXz+TSKbMjarOjH2/sf497JLwJ7wuI/ksQw4MwhCrLFtnBO
	REBfwrAKv0hzcGfrIrTOfJhjU0swWdD8d15o2/+w+mR54vrzM6M5qeIvssDBrK7g==
X-Received: by 2002:a05:6a00:2da7:b0:827:3e19:574b with SMTP id d2e1a72fcca58-82c6e0bf7bamr488776b3a.43.1774375205765;
        Tue, 24 Mar 2026 11:00:05 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0421df0esm15901970b3a.58.2026.03.24.11.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:00:04 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:00:00 +0000
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
Message-ID: <acLRICLAP5Ccqt9I@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-4-dmatlack@google.com>
 <376910fa-4232-4e58-bf87-0504202866a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376910fa-4232-4e58-bf87-0504202866a5@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_110007_350456_C66292D4 
X-CRM114-Status: GOOD (  31.07  )
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

On 2026-03-24 09:07 PM, Yi Liu wrote:
> On 3/24/26 07:57, David Matlack wrote:
> > Require that Live Update preserved devices are in singleton iommu_groups
> > during preservation (outgoing kernel) and retrieval (incoming kernel).
> > 
> > PCI devices preserved across Live Update will be allowed to perform
> > memory transactions throughout the Live Update. Thus IOMMU groups for
> > preserved devices must remain fixed. Since all current use cases for
> > Live Update are for PCI devices in singleton iommu_groups, require that
> > as a starting point. This avoids the complexity of needing to enforce
> > arbitrary iommu_group topologies while still allowing all current use
> > cases.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >   drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
> >   1 file changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index bec7b3500057..a3dbe06650ff 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -75,6 +75,8 @@
> >    *
> >    *  * The device must not be a Physical Function (PF).
> >    *
> > + *  * The device must be the only device in its IOMMU group.
> > + *
> >    * Preservation Behavior
> >    * =====================
> >    *
> > @@ -105,6 +107,7 @@
> >   #include <linux/bsearch.h>
> >   #include <linux/io.h>
> > +#include <linux/iommu.h>
> >   #include <linux/kexec_handover.h>
> >   #include <linux/kho/abi/pci.h>
> >   #include <linux/liveupdate.h>
> > @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
> >   	ser->nr_devices--;
> >   }
> > +static int count_devices(struct device *dev, void *__nr_devices)
> > +{
> > +	(*(int *)__nr_devices)++;
> > +	return 0;
> > +}
> > +
> 
> there was a related discussion on the singleton group check. have you
> considered the device_group_immutable_singleton() in below link?
> 
> https://lore.kernel.org/linux-iommu/20220421052121.3464100-4-baolu.lu@linux.intel.com/

Thanks for the link.

Based on the discussion in the follow-up threads, I think the only check
in that function that is needed on top of what is in this patch to
ensure group immutability is this one:

	/*
	 * The device could be considered to be fully isolated if
	 * all devices on the path from the device to the host-PCI
	 * bridge are protected from peer-to-peer DMA by ACS.
	 */
	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
		return false;

However, this would restrict Live Update support to only device
topologies that have these flags enabled. I am not yet sure if this
would be overly restrictive for the scenarios we care about supporting.

An alternative way to ensure immutability would be to block adding
devices at probe time. i.e. Fail pci_device_group() if the device being
added has liveupdate_incoming=True, or if the group already contains a
device with liveupdate_{incoming,outgoing}=True. We would still need the
check in pci_liveupdate_preserve() to pretect against setting
liveupdate_outgoing=True on a device in a multi-device group.

