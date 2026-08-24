Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BB9C5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0RIjz5iu884zqJfy1iBWck/h3gWNzem69636ygLdEIA=; b=TPfoLA3i5QKo/N1B/1Bwji5Od4
	w2zMySaY7/lNnFUeUdKCYo+XNAbWqdf7q2B3jbbaY0ruvZ6zKirMTj2r2bfQh37eo/LJyt0CoyGEZ
	wdjfVtenpZBCwydr1Dfdw66w1d8MMAq+tDYNvQJPBWYFSdoQHvWFbKTi2gaLnagosgBmm9HzhOKdz
	8zfQ7IF4rPmiEhX6Ix9jmQpcrYSNfIzp+maN4J3Bb0YDGAfbmY2GboiIG1scuqTAOT0BbqltzEgNK
	WVjw+Vw7mYV9u7wKqVKOHr5nQJ8Rw4u0oJyepPBXhvS8PXfSDp6XBh9h/4x2uC6jDq1SxX/Lf819f
	Cwvddy9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyb2t-0000000HLUU-3Bvp;
	Mon, 24 Aug 2026 20:13:27 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyb2p-0000000HLU0-3WIB
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 20:13:26 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2d3b440b97aso5045ad.1
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602403; x=1788207203; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RIjz5iu884zqJfy1iBWck/h3gWNzem69636ygLdEIA=;
        b=IvdYs0ph2oAMY+Q9Ya93DRylzz+mzOaylDHlf7k4D+x3dp5neJhFaj52+UPIaISZuO
         Fk0Rgz1tYPdy6n3ReFFqpIIBx3F972QqzcinDThYrVrIwF35C6FXcDrKRmVq8U/Cyhu+
         aS09+yTrl21ZK36fMIBMKS3Y0PjqStTd2+0/Rzoz264WQUmFegxZ80fNqiOvPXOypnOG
         DJiZl/IlsnSTgYbM2boSvN+wImrEo1a5Xu4AYqbYQck/m2jwcayvnvLkhu0GDjaCQTk8
         M49D3PQYHm/RLJnKI65PGT1USOAfTTkhKCh94ytYMqcsX+UItx4lwAHXH+oA/AMCCGYO
         0FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602403; x=1788207203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RIjz5iu884zqJfy1iBWck/h3gWNzem69636ygLdEIA=;
        b=JkKqgAf96xO84JovUFQ11tqz6f2w1QbKwiT3PsmiTlL4DSrGTvuyK+OOwuu9mIc8wT
         IkogA6be/D7vdwE4cqYtaA4iKxfvl6R4qG9cRIBlz3Mp2C/ZHjeL+6bLPgMSUeUSWtsU
         cLd0zBnXmEoBe/ta+PFjZ9Vi28YkmUeqyzuFdVuJEkPjDkimCF/oSogaKAt5uymT1JqU
         6tM3636SqwAR/y6IvFyF7GYLp3xTLuMlHapxqEM+GUGieJandSl17+tBZF7EHCOuWI+n
         Wu3oUExKBsdqXdFGGz/YULQ0NPGKkw1DqBHt1mt7ExmEymBZvGKtgTQydK1SMnbQqOBt
         Py/Q==
X-Gm-Message-State: AFuF++lSQPfhoCFIcuftnGzXv7FeIEr1qTx4IK96o+rZMQ/Um77Gardv
	I7zaqRKH4kzdULpyLWgM2yriHDfZR4VRuUPKIXkKWdhtdADP6UFm1CYCYNL47U8O1w==
X-Gm-Gg: AR+sD11JHTRMzJf3MtKx2SWqnx6AqbRBc0S+RPRS2RyF7vaFmWDToeEKIB0Jyil7p1x
	eIpr0E1OV1yi4tucqtZ/UB3dtOA+lKPxHXzVc53mSx7r5HpKNbTZ03mqxgkdPKd4LIAVp1KWAnQ
	7UKtz4sImtoLe1NTuXxljV5GO43Vtgnvt9XzjykqQo41kTI8XUG1VxYuVUSBCAJqyu2bsd33htX
	avU77tbTyAr2zvlowIt7KKQy+rlvN7/2eUm/D1bcaZZ+3asrCdPzJCflodpD5kJzqQT90mGqDKI
	ZE4bQGWDf8VoQrge8WsuYfPJ7U/HrMVD8/xS/gzlTNcvEz/jTyeF6XcUzARDyskHjEWZhIyh15W
	n0C31ad/2F/jg/bfS2prIrVyA0NL8PVKyQf+UyvcZ2QSstsGFbOBEUWS8m/mG76E2mDGlJrn07O
	a6/edBqsQ6D0Zb3UlJ2v7KEos0vkSG4K5Iyu7PzdfV+r+G6yZ0neqr4FG8ieeoagGCHDJEtXc/c
	GJ1EqhAKEx6YfvQO7Xux2NRUw0lOei6Ii7MWeegPNr7E9ZLZ3C68RjIPOM=
X-Received: by 2002:a17:903:985:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2d6e072a392mr1090655ad.10.1787602402239;
        Mon, 24 Aug 2026 13:13:22 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm795785a91.10.2026.08.24.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:13:21 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:13:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aoylj_gaj7jMSXvQ@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-4-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-4-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_131323_899595_EFCA1A3E 
X-CRM114-Status: GOOD (  16.07  )
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

On Tue, Jul 28, 2026 at 10:09:57PM +0000, David Matlack wrote:
>During PCI enumeration, the previous kernel might have passed state about
>devices that were preserved across kexec. The PCI core needs to fetch
>this state to identify which devices are "incoming" and require special
>handling.
>
>Add pci_liveupdate_setup_device() which is called during device setup
>to fetch the serialized state (struct pci_ser) from the Live Update
>Orchestrator. The first time this happens, pci_flb_retrieve() will run
>and convert the array of pci_dev_ser structs into an xarray so that it
>can be looked up efficiently.
>
>If a device is found in the xarray, the PCI core stores a pointer to its
>state in dev->liveupdate_incoming until pci_liveupdate_finish() is
>called by the driver. This pointer allows the PCI core and drivers to
>apply Live Update-specific logic to incoming devices in subsequent
>commits.
>
>Drivers can check if a device is an incoming preserved device (e.g.
>during probe) by calling pci_liveupdate_is_incoming().
>
>CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
>domain and bdf can be guaranteed to fit in an unsigned long and be used
>as the xarray key.
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> MAINTAINERS                    |   1 +
> drivers/pci/Kconfig            |   2 +-
> drivers/pci/liveupdate.c       | 256 ++++++++++++++++++++++++++++++++-
> drivers/pci/liveupdate.h       |   5 +
> drivers/pci/probe.c            |   3 +
> include/linux/pci_liveupdate.h |  13 ++
> 6 files changed, 277 insertions(+), 3 deletions(-)
>
>

[snip]

> static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> {
>+	struct pci_flb_incoming *incoming = args->obj;
>+
> 	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
>-	kho_restore_free(args->obj);
>+	pci_check_all_devices_finished(incoming);

This should handle FLB/FD lifecycle nicely. Thanks for adding this.
>+
>+	xa_destroy(&incoming->xa);
>+	kho_block_set_destroy(&incoming->block_set);
>+	kho_restore_free(incoming->ser);
>+	kfree(incoming);
> }
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

