Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DB7CD8CA8
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8CB2k4eqEZ/J9Iam1QvalqCdyib5VuBIoGU6FvxH5X0=; b=M8BN7JhEkz5rMSRTfUgAEobuEo
	LWSUxEO5dgrrEENIX22hMkGywXTg9sCNH1+CSXSxUsNbj7/zOxv5wZP33NaqTQdv9BV6HElyCYETm
	TdCYG51sTrQW9HDCFCYOnWLWb65LCsQujUZ5igxl5W5NJNX3LpwnSmrwLnYhN4ZGZYwxem6Yh8VrH
	ff8ymawH+98nGUxeSijr4frFUpsWH7LI2CbU/lPJYdsyEubXtP3VVYUGk5InbpYSPEtSOV2sBTYYc
	VjKMboyZ+1YZK5ith2kFaRtrA7zA/hGiMNfpJzuRyKOENa68WDH8niHLOsfVv3ZKZ8EXl6+ICmnE+
	JHyi9Myw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYcm-00000003TQK-1BMs;
	Mon, 08 Jun 2026 11:58:36 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYch-00000003TPb-2FQ0
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 11:58:32 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2bf2911f93cso298175ad.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 04:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780919910; x=1781524710; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CB2k4eqEZ/J9Iam1QvalqCdyib5VuBIoGU6FvxH5X0=;
        b=KKvfL6c6VOd2kRHJ0QS6TsVWKMz+podESfq3t1FcTpcdDnNL1CWVW1mvuU7OECl9pc
         aHEs0vkWMk+dDtNEGl5FxoWHA7SROeM3m+l/ZDE3k7LMCOSNuxlz4C3yIgmAq98iZy/I
         oHBA5+eWxDuHIv4a28SmYb+9RxW1d3wwR5iAaKKMoKRkayfQvL0ndanosE4vLWteZIUD
         8pEsnNVeM6MDip28iT4EnaAQTLMY/w5KFavtyr+oYd+iqeRLLB+wWjf0DRWF0UlyG4yY
         H6S8VPpP6B0kDCeLzKDNjWC19tZD+pWYKDKvcxX+QwHENvMq0TLB/Hmj49MK2hhI7bah
         rIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919910; x=1781524710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CB2k4eqEZ/J9Iam1QvalqCdyib5VuBIoGU6FvxH5X0=;
        b=JWiE1g70y3w2oQrTkmH3GTR8ML5p3DG31EiqBpTCKpMZWRJy1rHY9+wah6PrpX1CzN
         ji5eKXskatPmQAaFIXkWV/hUUEiKMAgKDxg1wkdKBxbacvTFngs2wD2p+oAEAB4FsVzs
         T+GCG48v0Wt/xEbP5u9LWiG6iXIw18yzE0nAbmxMs7bycB2jw1oXTSJB+XJwXY999mnd
         HHFeTEHiMaAPSEGicTwQ66HRO/ivOSM8Syg+VfXNmtpnpF0FAM4dTJm8Zq55TVQnhNeW
         fpMiMeYiR+wuEpl2nvvO2RIOCy26KtAYbTnQ4BzxWM/kUive6CS0+VFe4cnUt3VuQprD
         Ottw==
X-Gm-Message-State: AOJu0Yx5lN1oAJYZovnQooBOmlODoBJnoz/QdYABuGz53S6Y+sv3hed6
	uGDg5XJKqhfn7tQlv76MwMj6c037U3nI41ysRE4+6Hz3yzScz0MeQeVL1uag/brauw==
X-Gm-Gg: Acq92OG9VGIRB3YkZXlc7Vk577TwsaPoWrPW6ibl+G306Ch2ocse4KvYquzr+PQVz8W
	/0RotkOvWa02UB2ArDbWP6rXCygB5nvBhdjdS43MvX/f7b1qISqdg5I/l1d2MwEX2N4YWfcHYGA
	egxBtbEOH9/ehNURICX22U1KJFLJH+Y0jgytavZ8kUWKktrFMuVwSkxXNS1Uzcv7azOS5oZ2Ti/
	mPPS0erqKBtVv+W4q65r6W5ldChha/CbtxTz/euTEATkFOvhuoNqijzLmkXAIrlxm8c9vEXtnvg
	rx50pXgDBWVrwHlh8luHeCmE52XKBqfsG/06GH2vKZpFMwzEOZUw7dOsxYR7+Fmr7bDhTWvH9fT
	yQzGC1tlVbLe1sJaUviAAGTJareTyPOLrIT/XGbYtK8jNMqsxN4ZBKTauxqxYKpRVQq2/+VQKog
	9nUrRdwJh36BCV+8+rKoJBj8DMYzx6fEfHWBArb++hqlp2RpcQ/priwp6jt9pJz2In0xC+jCU=
X-Received: by 2002:a17:902:f787:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2c1eafbd48cmr5222305ad.8.1780919910000;
        Mon, 08 Jun 2026 04:58:30 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b56c5sm15740485a12.27.2026.06.08.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:58:29 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:58:20 +0000
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
Subject: Re: [PATCH v6 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <aiauXATym3w2QX9N@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-12-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-12-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_045831_587628_C954E65D 
X-CRM114-Status: GOOD (  27.90  )
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

On Fri, May 22, 2026 at 08:24:09PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
> 
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 11 +++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci-driver.c |  7 +++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index d404e64a4e55..a6f2790bc1bf 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -132,6 +132,10 @@
>   *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
>   *    preserved devices to ensure that all preserved devices on the bridge's
>   *    secondary bus are addressable after the Live Update.
> + *
> + *  * The PCI core does not disable bus mastering on outgoing preserved devices
> + *    during kexec. This allows preserved devices to issue memory transactions
> + *    throughout the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -790,6 +794,13 @@ int pci_liveupdate_configure_ari(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
> +{
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
> +	return dev->liveupdate.outgoing;
> +}
> +

[...]

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f7a5e65a7c75..0b1f8d01d7a5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -546,11 +546,14 @@ static void pci_device_shutdown(struct device *dev)
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> -	 * devices in D3cold or unknown states.
> +	 * devices being preserved for Live Update or in D3cold or
> +	 * unknown states.
> +	 *
>  	 * If it is not a kexec reboot, firmware will hit the PCI
>  	 * devices with big hammer and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +	if (kexec_in_progress && !pci_liveupdate_is_outgoing(pci_dev) &&
> +	    pci_dev->current_state <= PCI_D3hot)
>  		pci_clear_master(pci_dev);
>  }

Looks good. 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

