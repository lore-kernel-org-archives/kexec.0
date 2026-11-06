Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE15606A326
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SMavR6HZ;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XuS/2hii
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=; b=SMavR6HZtI5A3x
	cXsid38VOKKEWTUmOunGBgpM8/gpy+kuxkKSWvNWog+MYB2CifAby3IZetKA7mfd0pqD+05qDS8tx
	1YsmS1nvQ1LtsJgcQaFkJ7OOQ3Yuupa4iHvh8hICYx0al0hX1iDb4Sx6D5fb9kevuGOaykt5D4A+O
	YLVk37moMvRVzt/BCbG+DPpoGKXxB/NdTfQ/eCBfzo6CmC+ylWwdIXiwIGJ7mo0dfpPtEuNR8k82C
	iU9GWUJWNhoSj2Yvh2UscYNBBnQPP3I5o4CYWAtHlZonCywytqbc7m9z2zEeUXcZ/Dain6+HcBKHS
	69ZuyylCb6UhWqFtEN2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPSIE-0000000Dm4v-0N9l;
	Fri, 06 Nov 2026 22:20:18 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPSIB-0000000Dm4W-0yQt
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 22:20:16 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso756796a91.0
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794003613; x=1794608413; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
        b=XuS/2hiiQVD41HazFPPMuCtdVT3HuPSsbO6Yw1Sd1GJHCouZQdT/e7eEc759DZhavn
         Izw1VoDB+9Ul6tgSJC5EcROcb/EGq131c7+TWcKE9ZxPTNpDsZvWC9YKrvZ/bikKExUF
         wARfrtQdCVnPJRjDU2Vnuzg57yxJHGXf3HPU1zW/m0oM61rhDOqxs9xR9xkRPJijbHC6
         Vd0vmAZ96SGg7ZG7KGqG8rWaPuoD40h+k64Z1ZjohF5Gt+tKjBroTGheo6SLOE+mpUiG
         Z031HSLV/y2HekJ6SVsIY5gtIJOupPjKPfN3L58uCphIyus2UXAFBEQSVlgXD6w9s4F6
         Ljdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003613; x=1794608413;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
        b=S/HXOFNXCMiglYsuVz3rfirfvfYon6ryZ5z0ZzHidcOxz6zYGP0Ykt03+5fnhdUxSy
         BcBZvYWgn8+TesJvGc3incjAi7nxrycEtmkQ2PrGQR1qfey4Y0iAccGAfi8LVKbR4Z3A
         9Y67A0FSK+vfeAQ+j8EQoD1OeQsOa34CrHMXyxDcGRU0wlEX8XqvILPDb1x8/CYyNmMv
         KuTgrBg12iylDVJIgmCkfy6OOg3CHktSFC+PWh4z9aIYp02wtAqa8RCygKgdrDuxxVR8
         iSu4ofKuDpE25n0L+AS/pbEFL9+pg/48iCxehAVikX3J0NLFUb7q9GGQ21+tUbBbg6HQ
         Wq6A==
X-Forwarded-Encrypted: i=1; AL+hErF5N8IUTkGaVMbEsmupBoFf7P+O2BdYwoArK95s9qzMrN22E2oVPh6MZzjMkF8LFBKMSZwUiA==@lists.infradead.org
X-Gm-Message-State: APuU4Z985AipIxkF5h9SFbL06Fq7UbSVoPXyEr5dDDelAhs+MRcPchQO
	uZ9RU7/TF9ViFNLDc5jhuak6T2chHO/6x8VLvXs6XXP7DPjNrv/JMZh/ahGEzNtaDMyPiH+hHYB
	FXtzHf+Fk
X-Gm-Gg: AYBFou28NPUGTxuVoNKOrPjVubvA25tjMZHllRnwk0sjc36KbB/NYVlZPo5+tN2Iezr
	M+1c9fMzsQK7DxX5IiB2N9Y8T/EmWJj7LR61KQGxc96HaR99v77vmeZTFYGUl7lix21Q+IRLBiO
	NJaWsQEeFyRNl4jHYFSECoa9EVfZHkaPCCPVqafiHTqsYQovU0QL/BOQQNFBBrSxSAFxQa76ykG
	ZHoTxnLbs2iEJ0y3PjxCQqC8ndinPJ2e9wOeizbtXoabTvi3QQuktanPdSr2jvAfQ9vRHLzrnrQ
	RsEf+QKzzj18Ins16QBY58LfgWvexsAHvlXybfGkFv1bmR9rNetnPo/1g2b0EilRgUC4pZeHScU
	xfgYYuZOHz2Bjto85dyEY9rrS8QPjM0r4Vytn8/zIPntttOjm0MA+9XNAAFcXP0r03cQrfOctRb
	iLrXt/lmvlP2hcrW1ASVz3L8nvxRfv5ZkAqsN8hML32elt9tHvJipSQFvmipb65wWe32S+EilKf
	oV6O95LsqT6hwUrccCq+7LChxBKty21KuMeZPJPgfnBbRltXtcS2nZPQARRQqSoZiuL5iLyRK0c
	JQTt1zPIleltnrz0Zf07snsUAzRii1VEORrtXvQEWq7LVFUStrwE99ED5B1kqRCKQSpybQ==
X-Received: by 2002:a17:90b:3ec8:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b0db726100mr3762406a91.64.1794003612758;
        Fri, 06 Nov 2026 14:20:12 -0800 (PST)
Received: from localhost (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b1fa8sm528979a91.2.2026.11.06.14.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 14:20:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 22:20:10 +0000
Message-Id: <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 00/27] VFIO PCI Live Update (noiommu mode)
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_142015_332506_EDD904AA 
X-CRM114-Status: GOOD (  10.72  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:

> David Matlack (4):
>   vfio: Enforce preserved devices are retrieved via
>     LIVEUPDATE_SESSION_RETRIEVE_FD
>   docs: liveupdate: Add documentation for VFIO PCI
>   vfio: selftests: Add vfio_pci_liveupdate_uapi_test
>   vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
>
> Vipin Sharma (23):
>   vfio/pci: Factor out the reset logic in VFIO PCI device close path
>   vfio: Export various helpers from VFIO
>   liveupdate: Export symbols needed by modules
>   vfio/pci: Register a file handler with Live Update Orchestrator
>   PCI: liveupdate: Add helpers to preserve struct pci_saved_state
>   vfio: Add helpers to identify device files that can be preserved
>   vfio/pci: Preserve vfio-pci device files across Live Update
>   vfio: Introduce vfio_find_device() helper
>   vfio: Refactor vfio_device_fops_cdev_open()
>   vfio: Add API to open cdev device for Live Update restore
>   vfio/pci: Retrieve preserved device files after Live Update
>   vfio/pci: Protect incoming preserved devices until they finish Live
>     Update
>   vfio/pci: Take over preserved devices without resetting them
>   vfio: selftests: Build liveupdate library in VFIO selftests
>   vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
>   vfio: selftests: Add iommufd noiommu mode
>   vfio: selftests: Add helpers to map DMA memory at IOVA =3D=3D PA in
>     noiommu mode
>   vfio: selftests: Add helpers for Live Update DMA memory and sysfs
>     state
>   vfio: selftests: Add an attach() driver op
>   vfio: selftests: Test preserving noiommu devices in
>     vfio_pci_liveupdate_uapi_test
>   vfio: selftests: Add vfio_pci_liveupdate_kexec_test
>   vfio: selftests: Verify that opening VFIO device fails during Live
>     Update
>   vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

This series is getting quite long. I would consider splitting out the
selftests into its own series and we can iterate on each separately.

