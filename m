Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29159C5DF7D
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oma5+/tlfa1RRzhj7JpkkV8zgHZVnZM8SsuwDuMX0+U=; b=MRf2KP3RUbzuEzQ6B4DtzAYjdI
	Hq9AwrfCfZH71aRhouzGo0WAUlHzCPbS4ZZUG8Sk85Ph0mzY8Ci1UGe9tNChIHtXYfXXRQhkrR6Cm
	fr6cH/qFIJGJ3ClA7rA8m2v8JgZoTU2sHnRXJizg1xDzhPC1eZAo3ueouWkHgEog62FpnogqDqkS2
	al6V0/FGaxCeE8BCbd0k4VSliNV9Qk2qUEBBd14n+aSRVy+1ktpZwyK3as/aFdiP5nJU+RHMECLNa
	xZZ6H2uUs4pH1Sjw3bQHfAJkPm355e93vD6pj+muHbmwH5ZssV84HftixHV1rmNiGmu5RVWOZuaSa
	D8EEw5aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww4d4-00000006oaT-2dig;
	Mon, 17 Aug 2026 21:12:22 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww4d2-00000006oZm-27CW
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 21:12:21 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2d3b440b97aso15325ad.1
        for <kexec@lists.infradead.org>; Mon, 17 Aug 2026 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001138; x=1787605938; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oma5+/tlfa1RRzhj7JpkkV8zgHZVnZM8SsuwDuMX0+U=;
        b=A1DFs6l4g850pkF1a7pXbSY4pugRHpPxHkiaR0plFsMfDRpQ0+6IRZpvZ3rF7DvCHc
         3YFvKUzCBPVThfKa5J1P7xMukZ7nqqpclvYOU49Epm5yXt/KfqVEys/FOn7FJbdaJFkw
         h1gJMvrc5f0jY+bG79qc3QDB0CmYbFwLjK8QAZBEB7HC7bXMAMVVwCvLP3suPlWUwHxU
         5h1aUBHxY+I3CGXgOPTnmU1O4K/gDRcQZl5lx8TNlW4XOIffvl98QIKATFW+0WoLZdoo
         HNtN2aPPs+jfccrpTWPCbrpaVp7z/SoWMynqHBNvbVN/tvU23FHUAclMReAhm6ER+S7z
         prKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001138; x=1787605938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oma5+/tlfa1RRzhj7JpkkV8zgHZVnZM8SsuwDuMX0+U=;
        b=QAYVgcKmfctRi4W0BO8Jkc2uiy1CsJVJHEzVCYZ1/orM1gDzoZa5Vxczeip9N3ZcgS
         y6pj0rkYfbI9DUcGGlbblM6y+p99t34NuVo9Aq11zDUtKHh9X7aXZrg47bSlev5Zjwdh
         E0oo7jcPUC2l5HCY+k+Bz+LnRhmxYcugvfPR52Coq4L5jpJxUb76utz3fH5MoRlD5n9m
         iuDd/ci0QV3sQKW/VNV2S+Aornqq9vvLjaZxw0cFH96e/LytVmZe8VGU5AlGzirs5LgO
         UEkWaIqhDu8Kfu6TLKLIvF+DzZmKWh0UK+oVRSsveBNbgKdTJDJyaPP+Z5UtdN5nsZgb
         +Dyg==
X-Gm-Message-State: AOJu0YxcCl5KqQ1Dsqjhi+Vsu500X3nJGr5VnN8li4Y1tvYexWcuata1
	XvwKYgGcfTnqSa0cRuz1IbxvFwFdJUoxmNLLb7lLVLN8MeMqo+SOFOFkU7imG6QEmA==
X-Gm-Gg: AR+sD10px+Cm6R9y2c8Qaaxnz7nNYNtZ1J8EyyjtQxYwkXippUbE2ATMRiiQE9w+6/t
	SzM87X4jJfviHitYlHvMiBrxXEfHBpD8rpI+WSeQPBCJm35i2T67xUZVEo8h9G+F4P0GpsnnWCG
	2/idAQwy3xZJn1+gaz6yisxbQS2O4Ncr3CnfAwMCmozKM/4jJHYFRPjqDjBhNACuiKQ4N0V4G+r
	QvcKBtp4nQyuj1PQ/GqvgdlKJdxg4ZPe4qyWr0qqssWC4Jk/3FjolW91+zHil5iOnIcd4KYH/kk
	QHL+YksVvxj3rEcpfCxSpr6BbZApAaG9MOCQr3fZplF41neZ2sqkwd37r+qBUSAkg0XX6WnfLZZ
	wEMee7ZdcTiv5n4UPTLB2B2g138KZ3D4KXQLErK1tWepo5i+Dq6uyVg9bCd95TAhXhO1PEPyhqt
	7YVxN1fC5gD02x7203erV7MDBartG4IiDFZK88JsGoFXMsavPHhNn0rI9xV2rg8mkclhQxIEA79
	CzTNKVwkLH/wkiZGgfUo6iG30DQqnFs0z2f9Byahl+6tGAdgmLIkFcID9LqyEPd/HI3Pg==
X-Received: by 2002:a17:903:1b6c:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2d5ccb2615emr3070545ad.1.1787001137341;
        Mon, 17 Aug 2026 14:12:17 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e528b3sm7631765ad.46.2026.08.17.14.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:12:15 -0700 (PDT)
Date: Mon, 17 Aug 2026 21:12:12 +0000
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
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aoN4YxRo1TEcVuaP@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-2-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-2-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_141220_562525_B668BA0D 
X-CRM114-Status: GOOD (  16.35  )
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

On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
>Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
>it to participate in the preservation of PCI devices across Live Update.
>Essentially, this commit enables the PCI core to allocate a struct
>(struct pci_ser) and preserve it across a Live Update whenever at least
>one device is preserved.
>
>Preserving PCI devices across Live Update is built on top of the Live
>Update Orchestrator's (LUO) support for file preservation. Drivers are
>expected to expose a file to userspace to represent a single PCI device
>and support preservation of that file. This is intended primarily to
>support preservation of PCI devices bound to VFIO drivers.
>
>This commit enables drivers to register their liveupdate_file_handler
>with the PCI core so that the PCI core can do its own tracking and
>enforcement of which devices are preserved.
>
>  pci_liveupdate_register_flb(driver_file_handler);
>  pci_liveupdate_unregister_flb(driver_file_handler);
>
>When the first file (with a handler registered with the PCI core) is
>preserved, the PCI core will be notified to allocate its tracking struct
>(pci_ser). When the last file is unpreserved (i.e. preservation
>cancelled) the PCI core will be notified to free struct pci_ser.
>
>This struct is preserved across a Live Update using KHO and can be
>fetched by the PCI core during early boot (e.g. during device
>enumeration) so that it knows which devices were preserved.
>
>Note: This commit only allocates struct pci_ser and preserves it across
>Live Update. A subsequent commit will add an API for drivers to tell the
>PCI core exactly which devices are being preserved.
>
>Note: There is no reason to check for kho_is_enabled() since it can be
>assumed to return true. If KHO was not enabled then Live Update would
>not be enabled and these routines would never run.
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> Documentation/core-api/liveupdate.rst |   4 +
> MAINTAINERS                           |  13 +++
> drivers/pci/Kconfig                   |  15 +++
> drivers/pci/Makefile                  |   1 +
> drivers/pci/liveupdate.c              | 158 ++++++++++++++++++++++++++
> include/linux/kho/abi/pci.h           |  63 ++++++++++
> include/linux/pci.h                   |   1 +
> include/linux/pci_liveupdate.h        |  30 +++++
> 8 files changed, 285 insertions(+)
> create mode 100644 drivers/pci/liveupdate.c
> create mode 100644 include/linux/kho/abi/pci.h
> create mode 100644 include/linux/pci_liveupdate.h
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami

