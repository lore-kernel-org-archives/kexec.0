Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02059CC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GqaPQWFTpGy6Tato4Cnm3u7MBWIxvKK7hZ5Hxsyu9Wg=; b=HCE38IVfeYK1jGolAdYBhoVSAW
	2iXazAyv5xuoPZ7kQxMvb7VQBInbz8r1C4CZtwgBtycw3xXujqikwofl3YI78kRiVm5PxghOhlqB1
	LbpvBoPFrRsNBTAdtR9dKl1h97VR92pYZS276bviqrEC04ehSfrPcDKbNrseLJewT/MbGrONOXm9g
	bP9X5St7Ov3bGq5eBUJnR7+Ti7rhYtIFyXC+8oLx0uMxywDQ/FXHQutHW27kV4VpaC+VIu4oSnDU5
	zSuAsL/c1Bhl6LbbR2LppC9nOhMKHzA7N37tCwlKFZxtoypyst2UR/Y4gis6qUni2CznffOz/QStg
	CeaaRm6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfhd-0000000DahC-41G9;
	Tue, 13 Oct 2026 16:50:13 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfhb-0000000Dag2-0CCA
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:50:12 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2505371a12.0
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791910209; x=1792515009; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqaPQWFTpGy6Tato4Cnm3u7MBWIxvKK7hZ5Hxsyu9Wg=;
        b=DBVPdBmQGUpwpvvvkKZLPlUUEun9+1MdddkxYXKvGCFj0aLdBqlCPEIco0GcqpC5CC
         RKs6uZhTXtFXR/mNPOvGjfcgJAffdQ+6VghNlhYanxfyf5jVmX35F2wjZowEsB1OxzBF
         rF4G8zc5a31QYj25Z7gYeS8Iklks3VDhJZPwEfttFShPMyLcUAWDNHtnK1HprbMIFmKZ
         0yM2h8t2GxnjwIZ4Te7KCdI2DDxAUmHrRNkW8FQfT4CUDAQiTeUsiWdBbT4tiL3sjQJ0
         7hFWxEcqL4GxRDmyaxTweLPrsFNXsaRuYk0eFkogS4aE/vA6KDyFzzAc+6bMWBdLThOs
         N+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910209; x=1792515009;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqaPQWFTpGy6Tato4Cnm3u7MBWIxvKK7hZ5Hxsyu9Wg=;
        b=mO+Tdc98Cgp1+ZTw833td2HPscn/84bZYKEzTvWIECSq5nnDLdc5g3+jqqQwBvGRtx
         51EOBK1fya6l5dX8vRFxVVVjTwHwjLlXUSY6zyQHC5GN8IdOwuMEuwPfXZ0IZxxRHJJq
         6PEUItqrzRBJmX64+kDyqfm6EWRLnlUmBcNYEJ7omEztNPlouzwF24wFSX9Wivg3Qptw
         myxaKX2AC3f58IejWgKKrDLWAhlCvAdQZGh42DLB+r+T/FE3fQFAu4hvUf1LQTK3Av6A
         z1HayABHBBXK44PJ1MKs07nI1dI16GezYO/z5tVknSLk8c8zkkqL7lyYjhS9uyZc9Va5
         J2iw==
X-Gm-Message-State: AFq9FYImXaL1CpnR4F3SPkpxfyeR0PQkywADMzZMBSSY/L2xS8KeR87K
	1vDRumNEVZEdhbdY6BjXMmwm5+BmDiu9mQooHkioy699zp904iDX2iIze7Su4V5FwLd3AmjM2OI
	6qRO4jYaq
X-Gm-Gg: AYBFou1pRcTCkw59rYFM+gXJfnE3nTo4Igae5X3F5QX+v4+tZ8hsAsiXNRBXLHwPq1u
	j6KPMJFpPdVZomYPfrdibXOB7FRXXY61QwhI5VMqFYyDW0pPgsaP7eWUNtT75j0xBFdF79dCLHB
	G/DTZ30mkB2V3oaLjUvwC4WDgwZEPLrFnb6mJHoJRKkQZgo5tBh23AuO8nkUZekgaLpDEFJ+QMi
	wsG9NSkcpr49VZ5bxE/UlE1oSgoejp4mBKUIiIn0bJFoeOiYvf9KKdeTZoHlQbV0PGY0lIZtqGp
	Zi+Hv9yCunLEdhjt9gGXYJIeXEwNSWKNqquI+9k+8Wi2ORVXBi5VMb/nh4moWGnZQ9Hi2VcvuBV
	WZyk5lPWMPHfScadI+9ogvqPVmao1186GFf05hKmFF65iWCdGUiLyq/Tk1NLxArgdofiVtLIjtV
	/UAZmmmdsWcfLVHNnzT0jde9tr+PDbQI+pZCH7Q4kfI5BAKroW5uTtSurb1aBnXjJh59eKnWQdk
	rB2q9zZiWO/W9f7FW0kYl0JpTrAamQBKDE=
X-Received: by 2002:a17:90b:1dd1:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3ab3aceba09mr7658162a91.41.1791910208352;
        Tue, 13 Oct 2026 09:50:08 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f3db2f5sm410850a91.1.2026.10.13.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:50:07 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:50:03 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kexec@lists.infradead.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <as5hO15vdv3fnMeh@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-12-dmatlack@google.com>
 <sashiko-outbox-170132@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170132@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_095011_089564_B1EE7DBF 
X-CRM114-Status: GOOD (  15.22  )
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

On 2026-10-13 04:39 PM, sashiko-bot@kernel.org wrote:
> [Severity: High]
> If a user task exits or closes the Live Update session fd during system shutdown,
> the LU core tears down the preservation session.
> 
> When dev->liveupdate.frozen is true, pci_liveupdate_unpreserve_device()
> returns -EINVAL and leaves dev->liveupdate.outgoing pointing to the FLB memory.
> 
> However, the LU core ignores this failure and unconditionally drops the FLB
> reference:
[...]
> Will this leave a dangling pointer in dev->liveupdate.outgoing?
> 
> Since pci_device_shutdown() relies on this pointer to skip disabling Bus Master,
> could this result in the old kernel leaving DMA enabled while the next kernel
> treats the device as unpreserved, creating a risk of memory corruption?

This can't happen during a Live Update kexec.

kernel_kexec() calls liveupdate_reboot() before device_shutdown().
liveupdate_reboot() calls luo_session_serialize(), which takes
luo_session_serialize_rwsem for write and, on success, never releases
it. luo_session_release() and the session ioctls all take that rwsem
for read, so once sessions are serialized, nothing can unpreserve a file
until the kexec. If serialization fails, kernel_kexec() bails out before
device_shutdown(), so no device is ever frozen.

So during a Live Update kexec, unpreserve cannot race with devices
being frozen, and the outgoing FLB cannot be freed out from under
pci_device_shutdown().

On a non-kexec reboot or poweroff, LUO is not serialized, so the
unpreserve can fail as described and leave a stale pointer in
dev->liveupdate.outgoing. But nothing dereferences it at that point.
The only visible effect is the "Cannot unpreserve device after it is
frozen!" warning, which seems appropriate for a session being torn down
in the middle of shutdown.

So I don't think any change is needed here.

