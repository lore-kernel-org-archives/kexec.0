Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090A8CDB470
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tu79wS1tW2o86htP+jh+vF6ThoZY7vyXOnOxpMqA3sM=; b=JGaKALAiKIptoniDGMBWerhHl3
	Qd/lMLsq+TEm8cZ3adESqncQRgZLsjAcPVwCTyjehpg6Jau2xQF+3VMP/5p6hhQ7RSFKQK295x/dP
	39gYHLXQVQ4cNNdQQnNc2NEVLESqqC3OW2mLbxK/Dwa3Zx9oDC1tkC5E2xOX1tTt8beUKaB4xqUAY
	7XUP+u75IrORTKWMZr7KwXQbDYgGFbo1ynfd9ew1pHmustE9xR2XFW7cJxkLedB95hX06YaIgB8Bl
	X3Mdpx8k+7KVRSNITrqLZbe30/ZU0Joi4ni7EgLyxquRxnDhTt2/5F8U+or+rfu5ZIBH5F5q2dZKI
	QR194qCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc4Zi-00000006g9B-2gFM;
	Tue, 23 Jun 2026 17:06:14 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc4Zg-00000006g8m-1JiL
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 17:06:13 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2c6a4eccab1so695ad.1
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782234371; x=1782839171; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tu79wS1tW2o86htP+jh+vF6ThoZY7vyXOnOxpMqA3sM=;
        b=Bx7vyiWxkgG2gCnGJWGHQLgIKsMG5SKHMmRIDwNGkeSdRgpZ2k52kIEVqZt2NH1qNs
         2vRkI9H016x9M+8dmIJZM5WYh3wl7QfSJGdvWx2xUCz2UfnFqKdkj4oCb9H7IQldPk9F
         uL4EWb9eIaw0HsEsIBkxMlwNBO1KPmobU6GOSHy5MPljP2sAME8ZPlZvTy9W7MtR8nZl
         ijsztoCzITJGQd0BvLAWpE4l98lmt8t46wLl9Twz37FUp2Chy1Uyb6N9Qa+BLeFnoKma
         UCSXe4E1O31v6VtxadUeNZ+csCTxYOgyf43cuJOfpT6rC9Wuj/rTzfRjhzbB/MOZEHmT
         7Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234371; x=1782839171;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tu79wS1tW2o86htP+jh+vF6ThoZY7vyXOnOxpMqA3sM=;
        b=B8S2urr0HnvGp4HJgUbX3+JSBoUl30MVQv609moU4kWWf9O2At/STVlR+qOb0AcDJP
         ue2otvMxZ4YkA4Qjkway9Xugn5cb90AOItBHKaPjGqx2dd9Vpd/7lOziaseDqV3blv63
         r5WUmu2pwS729umMs6LlEZDsx+L+MoXrP7po3yjl+9EwMINuTkV/3qfuPndISp7GRMDm
         SBoVQnr9+q7l85rmFIxYFoy08a2trRLpAWLPlJH9sjvCOzkYb9/Swy8hR/h/SLhERvqu
         PH4CljYYoC/1MHi0k9FgFKZcmE5iR4rOuL/dEleWdV2IzD5ADgpnByT0l8jgsi5wTmEn
         Qafg==
X-Gm-Message-State: AOJu0Yy81ZcXqxt/FUPdpW26s2Y2R0swK3uULgbCXACzjK3rjrzEXBwA
	b9fVggAx9HaF3Jcmy2hJuNWJRNFE2XBCamKHb/u4ZfIzJafv9Pywy5M7ozjmPrqT8A==
X-Gm-Gg: AfdE7ckiuNl1qaC9gsNDae3wJ5xKVujuFSegCDoo2W/RAF/EkUAcOXaYw3AgqTp4S0d
	xKJHa2Ijh8D+lDGZyxM9L0aCAb3u7i6rijoPMTAM+7WF+jJbVjcBvhWiLObBEfwPgr5a3KBf50h
	Ci+Vi30WgmSGTeBRFcehVtkHs8eXX3RkD/Q85QIq7KE6jZEVGhoBN9fS837M/3a+i/Jvr6CM2rZ
	GAwnBKuS3S1LgHy0Cw1KBrLrQ24QqTdkexBe9zu44g2wrVt4vuGLX/u884pY3usWU8Iq0UArtzi
	RGxXYvRXcNDJAJDGyzKQOW2om1VeoOyIzQMPRycWgW2Yhg4qZ10u2dusTfJxz3/A/r3g3k8NN/s
	jfWU495QajKTKt0vESondqKfYV9N5QAaCJFiAvBnBzwlIezEzVXKGydYagTPClikiP44Oqh7pHM
	M3jEMA95DW6ljH7rf4FPl3FJLrxnRiIeExjA+JgvG29kd8IpsArBXeGl0WYxEMSSU9enLF3DAjq
	DRGhq4/
X-Received: by 2002:a17:902:c404:b0:2bf:749:55c with SMTP id d9443c01a7336-2c7c711c2f1mr2378745ad.21.1782234370647;
        Tue, 23 Jun 2026 10:06:10 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af54dsm113990285ad.11.2026.06.23.10.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:06:10 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:06:07 +0000
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
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <ajq852qLegjfkP4d@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_100612_353752_9A3E1C66 
X-CRM114-Status: GOOD (  14.51  )
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

On Fri, May 22, 2026 at 08:24:03PM +0000, David Matlack wrote:
>During a Live Update, preserved devices must be allowed to continue
>performing memory transactions so the kernel cannot change the fabric
>topology, including bus numbers, since that would require disabling
>and flushing any memory transactions first.
>
>To keep bus numbers constant, always inherit the secondary and
>subordinate bus numbers assigned to bridges during scanning, instead of
>assigning new ones, if any PCI devices are being preserved. Note that
>the kernel inherits bus numbers even on bridges without any downstream
>endpoints that were preserved. This avoids accidentally assigning a
>bridge a new window that overlaps with a preserved device that is
>downstream of a different bridge.
>
>If a bridge is scanned with a broken topology or has no bus numbers
>set during a Live Update, refuse to assign it new bus numbers and refuse
>to enumerate devices below it until the Live Update is finished. This is
>a safety measure to prevent topology conflicts.
>
>Require that CONFIG_CARDBUS is not enabled to enable
>CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
>bridges requires additional work but is not a priority at the moment.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> .../admin-guide/kernel-parameters.txt         |  6 +-
> drivers/pci/Kconfig                           |  2 +-
> drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
> drivers/pci/liveupdate.h                      | 14 ++++
> drivers/pci/probe.c                           | 17 +++-
> include/linux/pci_liveupdate.h                |  4 +
> 6 files changed, 119 insertions(+), 7 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

