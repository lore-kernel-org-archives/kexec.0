Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BA60A2638
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Vf0q+2L;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCSM5FDH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ckLOMz2fV3kY9YEywvc/HmidWwaCPHWXqmOxBtkfgk0=; b=0Vf0q+2Lb0rgNG
	nVQP4TqnzUzMZfnwe7NiTA9m7Ic1nE7pGUu7Rghg+YgcVht11DQpdjxiTaDFEzAT9wh6UU624wceX
	VpnqdWSNF1xsYjy8jmDNQVXyzBFIpLIU5cQJNOqhEuITQAxIcMX46Jf4aks+gB3A1Measool94/c5
	f222lSOcKfG8zOW9K+F9AVJSvHB2r6qhxRvip22fygNM9pNoKvizZyOANvyRW+rrAFI33Uxq1jm+8
	O3Gq3PXChHw9whZ2BxJdB5bsAfWmJ+8eQuYblB0oZB4dPl/fbG4oqgUyHq0+ACvIsxDrw+LN40C4w
	gyeqfQ0x+tllLZ/sFAnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUU14-0000000G1eh-0RS1;
	Fri, 20 Nov 2026 19:11:22 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUU0p-0000000G1ck-1kh0
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 19:11:10 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2f0458cc9easo8323915ad.3
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201866; x=1795806666; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ckLOMz2fV3kY9YEywvc/HmidWwaCPHWXqmOxBtkfgk0=;
        b=UCSM5FDH3udRNWfrK+S+4EQgq92OFYkpwTG5ZnqKvXpUnonUlKpBnlLEgFNOarSTdq
         /BlD1Tt1nCeDMh9o5p4srHCCKJAz6XcZ30QrQNJbSlKE/C/Moq0l1P+0oBilhBPaP2YM
         R8xVAWLI0etBKSAyKVPfL/YthBMw8whEq27Kmzmsz2wkUW62VBty3GcC2JzYsbEj0v74
         0/9f+5wx/NwXEK6eTAgXm9Sk8gn5WCvJwdBDou4ZAqVxHso3YWypUYi7+1skokPm5Nw7
         ZQ2tYdDBQLUrcv/98IZTLMQTANMzu6yZQNwnWB4mKhyYnGGAOKsx7VaTT4PEenzZf7vW
         PtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201866; x=1795806666;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckLOMz2fV3kY9YEywvc/HmidWwaCPHWXqmOxBtkfgk0=;
        b=IGQB4pJCcDPMx/giBrfASAmAaC165YOYXTSlThK1zayQ65EkSDZD1D2yAHGXe19t4n
         UuxUJVbCubjUwKOfjDBq0rqDlUDS3GNNzm3E9omNX5JlBTMo737qJzdWey8Xuf8rWpR9
         NAI/aHpcyA8ki4EEq2fPz0lPns8i6aTUCgAAW5vEkmhbgontxOO8G0VH3nbN34Q9RJiQ
         O0vmUUu5WXNQxT3CE576EwfTM+/7nunIixjgZV3jIZvNqYN5fN/aXZvSco0IrSO8Z57i
         iQol1OTuSUy1wsiAg2zY2/Bq4LYtXiLBhSK3l+Q307txe9TenYn6lUz3u95oIOor52AN
         v+bw==
X-Forwarded-Encrypted: i=1; AL+hErENLm92xTxOpxDWaAhy0GdEpQp2sQiJ0jSu4Q5fFzo5VwIgksFZ8dw8e05QuGd0gDwTWTr6pQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8onmh5KdbBazSXcNIv3uwb18bm16D9vw95RuBHOIHHm13YeOIt
	DMpV5k7p4IGq/Fwuqw7SKQRxsL9O/5uBXkAOR04rF0yCbclHAmP6ye1VExGXWaLJ5g==
X-Gm-Gg: AZFdTZet/NWxaWyd0yiWMqSbSs1dpwRmXDNFpfKdh7CqMvG9BSstOt0a3MLjxPTLTRc
	WQuJoAGtfMCfPvST3CVCis07UaVDDoVqnRAPkEAcsdvD04hNFqc6na4+uRw2Nv7fGm/1T0zvso6
	BX2aFw2dPzq5z9z7Wqi+Eli4nxxMp9KaziPPwvbScLBibEgdDQw6L46sRZRH1iUoWFH2+caKypy
	3XgjDDaRWWWuH7k8KRervaI1pOV+6rZvmWEDCwlari+gHO9e6FPt7o+q91KGwrLW8wraFIUBWVO
	BFciAfPUq0gpNViRbPFJoavpdRV33ABSwBQ1eQDN16OB3vngcsVWsF/uFUuZYb16tItfxAAgi1M
	BT8Fj/EsSDmb7YF6i+xJ4nIa4wix5r23RofDxlAeA8qI8fMHBzpQYbXzW9I5trLZ/8+lEe7hC8N
	+dWIFzo+bRJU0BiXyQIHlbY/0fCVfl1l97YHh3mdsaxDQO3w1GBAWpc4IeBzmQwd44Jvh/jOfeN
	bdXZRLehn7j2t8nC85iNMRxp6GoZAYvGVuntHHDjqPNoSRbTZdDpSh5eVQiZk8Otx7F9PG8uORD
	znJki7M+R9MMye8witUsOx8vOHuZzUuJvcEUUxcf7stkFN2iVMc9FA5jLA+C0oVu
X-Received: by 2002:a17:903:3b8d:b0:2e9:5714:6079 with SMTP id d9443c01a7336-2f03f1a4a0dmr40668915ad.31.1795201865671;
        Fri, 20 Nov 2026 11:11:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1413f3sm17535745ad.68.2026.11.20.11.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:11:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:11:04 -0800
Message-Id: <DN09Y7673R13.3GB4PTE9ZPXAE@google.com>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf"
 <graf@amazon.com>, "Alex Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
From: "David Matlack" <dmatlack@google.com>
To: <sashiko-reviews@lists.linux.dev>, "David Matlack"
 <dmatlack@google.com>, <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-12-dmatlack@google.com>
 <sashiko-outbox-224146@kernel.org>
In-Reply-To: <sashiko-outbox-224146@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_111108_542384_DEA6B139 
X-CRM114-Status: GOOD (  20.00  )
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 2:38 PM PST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] pci: liveupdate: panic on session teardown after
>   pci_liveupdate_freeze()
> --
>
> commit a3120ec70b92ea26f3e1d92d3bd0d1531b5a73b6
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Freeze preservation status during shutdown
>
> This commit freezes a PCI device's outgoing live update preservation
> status in pci_device_shutdown() so that devices cannot be preserved or
> unpreserved once shutdown begins.
>
>> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>> index a45ad86370d5d..e26d2f5c2338c 100644
>> --- a/drivers/pci/liveupdate.c
>> +++ b/drivers/pci/liveupdate.c
>
> [ ... ]
>
>> @@ -520,6 +523,11 @@ static int pci_liveupdate_unpreserve_device(struct =
pci_flb_outgoing *outgoing,
>>  {
>>  	struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;
>> =20
>> +	if (dev->liveupdate.frozen) {
>> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
>> +		return -EINVAL;
>> +	}
>
> [Severity: High]
> Can rejecting pci_liveupdate_unpreserve_device() on a frozen device trigg=
er a
> panic in pci_check_all_devices_released() when a Live Update session is
> closed during a non-kexec shutdown?
>
> Unlike kernel_kexec(), which calls liveupdate_reboot() to serialize sessi=
ons
> before device_shutdown(), non-kexec shutdown paths (kernel_restart(),
> kernel_halt(), and kernel_power_off()) call device_shutdown() ->
> pci_device_shutdown() -> pci_liveupdate_freeze() without serializing Live
> Update sessions.
>
> If a task closes an open session FD with a preserved PCI device during or
> after pci_device_shutdown(), luo_file_unpreserve_files() invokes the file
> handler's .unpreserve() callback and then unconditionally drops the outgo=
ing
> FLB reference:
>
> kernel/liveupdate/luo_file.c:luo_file_unpreserve_files() {
>     ...
> 		luo_file->fh->ops->unpreserve(&args);
> 		luo_flb_file_unpreserve(luo_file->fh);
>     ...
> }
>
> Because dev->liveupdate.frozen is set, pci_liveupdate_unpreserve_device()
> returns -EINVAL without decrementing dev_ser->refcount or
> outgoing->ser->nr_devices.  When luo_flb_file_unpreserve() drops the fina=
l
> FLB reference, pci_flb_unpreserve() calls pci_check_all_devices_released(=
),
> which panics because outgoing->ser->nr_devices is still non-zero.

Yes, this can happen, although only in a narrow window.
kernel_restart(), kernel_halt(), and kernel_power_off() do not freeze
userspace or serialize Live Update sessions, so a task that still holds
a session FD when reboot(2) is called (e.g. reboot -f, which skips
killing userspace first) can close it after its devices have been
frozen. In v10 this only resulted in a warning, but the panic added to
pci_flb_unpreserve() in v11 turns it into a panic during reboot.

The freeze only matters during kexec. pci_device_shutdown() only checks
pci_liveupdate_is_outgoing() when kexec_in_progress is set, and
kernel_kexec() serializes all sessions via liveupdate_reboot() before
device_shutdown(), so nothing can be unpreserved after devices are
frozen.

I will fix this in v12 by only freezing devices during kexec, so that a
non-kexec shutdown no longer refuses to unpreserve devices:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 08b768b9e905..2748ca22e9cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -560,7 +560,8 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev =3D to_pci_dev(dev);
 	struct pci_driver *drv =3D pci_dev->driver;
=20
-	pci_liveupdate_freeze(pci_dev);
+	if (kexec_in_progress)
+		pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
=20
 	if (drv && drv->shutdown)

