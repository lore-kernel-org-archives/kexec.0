Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5211C5DF94
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXklq75Z4X2qA44rayjTFnITvL4DP/DDkWPkbOCUBY0=; b=UquO1kvc+PM2smH6UEW1GI/RSQ
	RLW11CWprtduh/P0kbf2EymblXKGVEVM4Ha0PXmcTX3ubA74HYv1IwPF0Kfeql9n/Pg20qYqQg/Cj
	tACKo4pR5GiF3PW772S187iO6RLu8g+pev8aNnEf0wjppzNdWD/NOCXJEbky+LfG5Yp1RtoLZP7I4
	1xwyjUK/GADCPl27QTkrYpnWK1hTfuiq9LJds51Y3FVzsR+THQ/bjQ8pA8u3VGtZDeYcOhQ9L7TlN
	OYuc0N3qEQo0tR6RE0UwiGzkL6iofjuYS9h+PJjl+VogZS2d092wuP9yefJNEClhDuUzH0nwKpIbd
	hqKZRYgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUwA-0000000Giai-13kn;
	Mon, 24 Aug 2026 13:42:06 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUw6-0000000GiZQ-3yid
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 13:42:04 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ccdf36f63dso158365ad.0
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787578920; x=1788183720; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MXklq75Z4X2qA44rayjTFnITvL4DP/DDkWPkbOCUBY0=;
        b=Vz3Z7KU0WNfIrwjJARiTgIJYChFU5fqpC4JVp+3Gu/mtUu5eRmgfWLQYlLSLAWFVLY
         8TUpHH7YE8fu3H4HfGcVGGSnnWx2E7WBvCKR4/70p0pDiirBGdJOdAnH7rR/nH7GO3gn
         WOCaM5yd0PGUSGXtqAEuEhgwJDOF500M66CAhaoot9yjdeVc4cxPVt/70/xze+911T2/
         +r5gLUJ/HI0+d3wdUGVmIAH30pLJkECetAy2X/8Z4CbeFbdYKEO/VcMBRpHwHK8uPqDe
         mzGMsDHFEe+Wcezy4wAunFHEmWQUObTGjUq8HCDyLv07vMgEpV4Kgf5QnbaCavQrcZpA
         rvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578920; x=1788183720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXklq75Z4X2qA44rayjTFnITvL4DP/DDkWPkbOCUBY0=;
        b=fO5wENCIcYvcu06IxDQVyuXVEOC0E766UbjpJOGJ3e4ixo7SD2/bnofQt4Ay5YYdh8
         A1hoWLYZueQQbzRTFyfpDyHgb5pnUPaXX0vAxZ3muwFZTpPxWJVbK588DKqRniYEV3Ty
         b4NGEYeEdmgSvFNT6gxzYy+CUr4a7qxtae/OQ24x81Cnh/v5CT8CbHoDWAZ9+DfYI59d
         2fTrn9lNuJjRAAOnsOhOU8JJD6zruNV1Of65hSlEJa2wk6EI5FMsRDIZBZHz7Sqj5ios
         nGT5Ae8dVNAU7d8ZIrTEgzM/XHdNHC8URUDOnBbT+f/hG0+tOH5XtQaZxct2nNc1RPyA
         0hnQ==
X-Gm-Message-State: AFuF++n77NScfC42mDn/QT/SRcr+Oh1aRdH2UG/rKpddcl0dqrzVW4ex
	at/1OWboD5IXX8KPVYTbvLY/zPQ0c3tfMtN8VejNgzKnp5LZb2DMldW7nMn3gqvtoA==
X-Gm-Gg: AR+sD11g1HP+GbKbLI2NHO4RV0ojv5OYPZhWOxp2Wkuqb7nnUHh5PJevamFNznkpQ20
	Xy5sH5nxLFdKw/PhJpX32fFNLo/ANeaJbaTl4UERfxTUZ/Ts9FADkEsbGy+1kHNryf+k4RbUa7H
	zYFUEVi7MALbUdQRefHlyhX6D2yQEnOaU9FZ0ZphkpJWSmNrjF4AFjdN/vHmaHUkabICzTMH6f1
	c/YATPokBtQr0zF1OphAb/SoEFrK0pLnHFRN/EX2uZvxvg+WVzAIFLT7vCEn6SYD+BJP9IaMEhL
	EdUfMlFiHmndktv4kJp8YcyQtTa8eml1SZfPYpYz8YxgA7Gy5YS447ogcXdW2S6sL8Zolja2gq+
	sxEfdbdM0c96rTb1gul56rpCWcWk1eVfEr8dZhOqUWOwJwdm6IOJE4y6hWlvWK8XfwiGjdHVuux
	6YgpChZjGZiWU2HzwcfZRur5cdHiMfblEkbqb81oKRDccX5r3sYWij+F+bqX/zwrnrtEu9nONqi
	2GcRwPh/f1D6/ta1T0avKc5Sw==
X-Received: by 2002:a17:903:1b4e:b0:2ca:cbe5:c3af with SMTP id d9443c01a7336-2d673b9e9ccmr8380625ad.7.1787578919029;
        Mon, 24 Aug 2026 06:41:59 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761c35sm18347475ad.15.2026.08.24.06.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:41:58 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:41:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aoxKHh_zLBb5vhzY@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-7-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-7-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_064202_993438_28AF460B 
X-CRM114-Status: GOOD (  13.01  )
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

On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

