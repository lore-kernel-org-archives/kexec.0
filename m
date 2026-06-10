Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF40CD8CB9
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hztkJLAOrt3y4FASh5Bx2C0OqdOIndw7eniIOKrpzws=; b=tRTg8MPfvtjLEhXfbm7jubZYz1
	OKTnRoVbLKrSuh/r/M4YtBGXGMsbFW9Cu9f7JPNjnXrKtM88//rK2aBdvrHd/6J3Q7RvXotve32Dr
	N94irrn9by0YvTCbS0WI90NNqctIQznTIt6MpCLdeSQtlvMId8plLXsj9HD2qLI6lfJDZUxbt9H/e
	GOOS4Ms2MZw/ABYJ/MIl8nOv81avLZLDNxVGA4++OYlB9fhR9MixdNeWo++mcrrMtU2VuxtYihbY1
	cnGkrASvtyVmBcvAIHw2bwLXoYzjcNduqExg6xkQtXziZQ/bolSZsqVOC5+NSuFNGZYHqOSLV0Q4Q
	OhMNFOqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXK3U-00000007w0w-021F;
	Wed, 10 Jun 2026 14:37:20 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXK3P-00000007w0X-3bIO
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 14:37:17 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2bf2d865383so76495ad.1
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781102235; x=1781707035; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hztkJLAOrt3y4FASh5Bx2C0OqdOIndw7eniIOKrpzws=;
        b=B2+DXC43QcvsjBD0Jyunfp8wolchFuwaDIYQWHlgCDo58eShIrfZhozHbjar85vLx+
         nYFCCRhFadYHxOrHEYGGVHBa+KiBJndW71Gn+bcSyEzf3ZajCwJsV5/hkGAq0FvJK5PX
         +tmP2XB7lZ1gb1cIBjgMleHKc4Ucb/jVZZVz9CRP9lSFxXYeBK7YT9p2crEA8fVdPlIw
         QFMXUsKa/O3yrqNAZbFoFBj0HuVw/z0p6THm5ZsZGJBT1Vvl5GRFTgaBOwYQBIz5KVA6
         KztWsBmOfO55OnSvJsUUC0l3ryNbgNrgZALsQy2X7hzc/2l1pi3qJX5SCeIUKNQeOvOf
         nCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102235; x=1781707035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hztkJLAOrt3y4FASh5Bx2C0OqdOIndw7eniIOKrpzws=;
        b=MTXdS0VNf/v9Z/21YjLoetDyrWDtC3JcU2brz/S5ymklZ1rGlfHoRwiugRrLlyCMP8
         P2NK7DYYbUvzOVpYQ5+Pdqp0U/OSts5qhafAAH8fbKOhLshI54B+M4BbjEEqJtfD8hoJ
         wqLetfhadFSgS9ZKzgtva6xa/wQgKUOu0oh7Qs6kQ2xqToMVNXB657WAMbJ60mmjrisy
         mpLAT1eylaOAOrUMH6AoZicrlz1d2dYpNZhgpNAQkCAOEtjoaP82+A2aWTSBgwuCDgpY
         9N8zXPm0eXL7SiTfwMQJjEp5nzW2S3pb2hPf5+l4k/EXmfg2x/yAAlnxfPekL0Ct1izW
         qREQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uQxa5iZcGCXSO0WAcSElJpk9z2MzUA7BfuOs9v8kGtwKzPyT2uPFKHX2RNR58Uu74QSHJnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKyqppwB8/Znil6piZsJDm3QP/CMfby7gAvBQrGBlBT+HNkQ/D
	m5rK1DU143HkmnH9Mf+eAF/QaPxm36LhrSSJy2GQM3/I8Cn3DcTTxzPnHTHaHflVOw==
X-Gm-Gg: Acq92OFrjSua5cwyXoZBJEsrJm0evpM5/oLD9z6P/ugPgetXBheK2RsvGM6nQayc0Hw
	1ZGL/VfF51MB/qJzTjcHjJ954xXGLF7lsOeFPlzzMOSZNpwWeIzX1myEHbRrBOz6Gz3Fur0SOSv
	JXuBODK1bHTDdVszOy+CFJQlg7coICgBcPLL7/7osoDYPDIhSBRIjPwkjpYJ/DXFpr11d6g2cRd
	h5seSaOuXBQUfHqIjhXI3dVFBuMwmvhi6CVKMqhevlxzXEixnorkyhs+e5HJ1VZ7DcBO/PY5vKc
	aUKI0tdvGAO+p1A8VE243u0PMPFit/N2BF4H2odV9XYkpIZQtqczzwi8X2XhvsVclo9lyLMqqQy
	HY8XbkMWcLDjCDhfHgSWK1TXY15hrkXPX0FaTTXPIw76HFHO7qn0GJgJgAWr25iCMZGeNpJJzys
	66I2BC40YQazZ36KbPQUriCkm9JkaEFpv+T5Czh/odWsqoDLu8ZPhF+MLFsxVHyinIn+1N0JI=
X-Received: by 2002:a17:902:d4ce:b0:2c0:b1b0:376e with SMTP id d9443c01a7336-2c2d936f08cmr13905ad.8.1781102234239;
        Wed, 10 Jun 2026 07:37:14 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821c5sm23191040b3a.32.2026.06.10.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:37:13 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:37:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <ail2kLnW43fF_Sqa@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aic6mdiZ0qUJpFca@google.com>
 <aihLTgs1Y49OXQaV@google.com>
 <20260610000704.GR1962447@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610000704.GR1962447@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_073715_898179_94BD7F48 
X-CRM114-Status: GOOD (  10.46  )
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

On Tue, Jun 09, 2026 at 09:07:04PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 09, 2026 at 05:20:14PM +0000, Pranjal Shrivastava wrote:
> 
> > Now, the attacker has an opportunity with Liveupdate, since the devices
> > are already assigned, if *somehow* it flips a bit like ACS_RR, the
> 
> If this is possible then your environment is already security broken,
> no need to involve live update.

Ack. Alright.

Thanks,
Praan

