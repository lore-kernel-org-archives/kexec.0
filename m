Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10422FD45F7
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uOyGcfhW1LI1T0+ImDiYL1uiY49EgY0HI4HEklJbETo=; b=njL2bLFlpv8DolUKm3Nwco88uu
	BbkMMe9IiVGZ50jWP/j97jYRSUUt7hDyw3t6DNksm1oVxktbYNc21BmgQ1IyajWWAlt/H3mioim2u
	mY6oX1Og18r8/lVxdB2/DvxvKGpHm3eNwi0GpyuXhnFrPPzwBLw3jx6AtFhgBNufPI7IJDnwGgeXY
	GeImoYy4f6dJD9fbJO16ahcXbpOTfelK3IXBcav9Rs0SLotpon4y6lR6wmZFa53sIOS2bG6/YosPx
	W3zPKDrJgpXkMw+TnDQT0ChTezBjSJ7GgJ3a9HuaH1a50VpnL8+oqHe0B7VMBK/50LmAArneDOI/a
	AH9XOHHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMVt-00000004vWy-1Hsd;
	Wed, 25 Feb 2026 21:33:45 +0000
Received: from flow-a2-smtp.messagingengine.com ([103.168.172.137])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMVm-00000004vWa-2sJ7
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 21:33:40 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id B25A31380AF9;
	Wed, 25 Feb 2026 16:33:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 25 Feb 2026 16:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772055214;
	 x=1772062414; bh=uOyGcfhW1LI1T0+ImDiYL1uiY49EgY0HI4HEklJbETo=; b=
	Fe/KFBw9AhdA4JIPEFA6oKZMPb3jkSYj07O1VtDSsj+hw5ueMPGI4TP6AlPnPNgU
	uZlkZcKu8F1V6CdaKQ5F8rawNot0JXhub7A7i8kZ2a6Irzgqdj7ZQAljrKUPo+WN
	ckUH2mfIMPrAO9ug3Y04JmgN0axE2/mLsE8on37v3AnY9UigCsYwl8fMzaZ92Kqq
	ZrMc2qH8gqaY/MnjtK/Xg04fIJ932Mkf7qP0Jlo8hmNEEll1xyQnNz1fVs3kNUB0
	Znrc1HsroIGXMMsicDgklPEh6/3RiMSEQcqGJ7mtvo8Q5V7ly3+egJRP/D/91qrN
	yhTgY2R+oZbaVMmtg7slSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772055214; x=
	1772062414; bh=uOyGcfhW1LI1T0+ImDiYL1uiY49EgY0HI4HEklJbETo=; b=t
	4JQiMybd8my/Q8yahj2kZiHYVHPzFYw0ah1C6Tkdx+JRzb9lwDbPteJ70dqqsSH6
	kadwUwL5Gk5PBfLYFgya2G4juOjsnxGCVT0+aoOKuK73XIt/Iq0+WpPFp5XsMxK+
	DZBp/DPLYUIoB6yitemqtAqz1guul+U7JWiurf6Vb0EjbLYJEalun1XNPphPOTLV
	VMvgLUWk+8R7ppxGFGoKLuKkEUXEo06Hji/3KL0bb92rRQw43cXEpsVQQctrKVIg
	dhMZgQyNNbsV9wf1seVJLxybZb5ljarp4SDjvTDq6G1ich04JP9tkvPNdadt8H8t
	D6yk0yc7cuZz9C+OPZyZg==
X-ME-Sender: <xms:rWqfabg6hBv-eIfPU45VVg_kTi1XiEwGHCOLtJKZTjFoS1vqERTeZw>
    <xme:rWqfaYPVV_7brDFcjHNXpI-JiFYTDmsC4vAhdZGQdFLO-xAQYewBtL7EIwbF0UqsN
    AC8flZI8dVseXF2purGoWJL7MkKi1NyUgatg72tdlNAJGpBX0RhIw>
X-ME-Received: <xmr:rWqfaUkEndAraLfwnPYcRWzYlSIKrjBMwBcae6DD4LZUkyH1CzTVOelnKSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheprghjrgihrggthhgrnhgurhgrsehnvhhiughirgdrtghomhdprhgtphht
    thhopehgrhgrfhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfh
    gsrdgtohhmpdhrtghpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhslheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:rWqfaXUe2FtA3DswIFB60ExhxZFyF4WTpDXQ_5K0uJb6A_pjD1-zHw>
    <xmx:rWqfaZbwjR4qhyLCBUtS6HbozOQLTb8Da7JXbzPAfHRRsnRclDkjxQ>
    <xmx:rWqfae0woTolOhs7n0PnNGy8Qymd6xqUPJqv3NBoAD2YEx6TloCDlQ>
    <xmx:rWqfaetNyIWQCnkMaOKDOZ3yWit9rXv9QiQwVJWAzIF4HXj2RH6MkQ>
    <xmx:rmqfaUCfyiFWNX-EYiIXFm3n4u8-Ftbqh0sezsK1WkYGRbGtK7SN5TSD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:33:30 -0500 (EST)
Date: Wed, 25 Feb 2026 14:33:28 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>,
 " =?UTF-8?B?TWljaGHFgg==?= Winiarski" <michal.winiarski@intel.com>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=" <thomas.hellstrom@linux.intel.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, alex@shazbot.org
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <20260225143328.35be89f6@shazbot.org>
In-Reply-To: <20260129212510.967611-5-dmatlack@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-5-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_133339_356909_00F744F5 
X-CRM114-Status: GOOD (  18.38  )
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

On Thu, 29 Jan 2026 21:24:51 +0000
David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b8..19e88322af2c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
>  	int ret;
>  	bool is_disable_vga = true;
>  
> +	ret = vfio_pci_liveupdate_init();
> +	if (ret)
> +		return ret;
> +
>  #ifdef CONFIG_VFIO_PCI_VGA
>  	is_disable_vga = disable_vga;
>  #endif
> @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
>  
>  	/* Register and scan for devices */
>  	ret = pci_register_driver(&vfio_pci_driver);
> -	if (ret)
> +	if (ret) {
> +		vfio_pci_liveupdate_cleanup();
>  		return ret;
> +	}
>  
>  	vfio_pci_fill_ids();
>  
> @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
>  static void __exit vfio_pci_cleanup(void)
>  {
>  	pci_unregister_driver(&vfio_pci_driver);
> +	vfio_pci_liveupdate_cleanup();
>  }
>  module_exit(vfio_pci_cleanup);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> new file mode 100644
> index 000000000000..b84e63c0357b
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -0,0 +1,69 @@
...
> +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> +	.can_preserve = vfio_pci_liveupdate_can_preserve,
> +	.preserve = vfio_pci_liveupdate_preserve,
> +	.unpreserve = vfio_pci_liveupdate_unpreserve,
> +	.retrieve = vfio_pci_liveupdate_retrieve,
> +	.finish = vfio_pci_liveupdate_finish,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
> +	.ops = &vfio_pci_liveupdate_file_ops,
> +	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
> +};
> +
> +int __init vfio_pci_liveupdate_init(void)
> +{
> +	if (!liveupdate_enabled())
> +		return 0;
> +
> +	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +}

liveupdate_register_file_handler() "pins" vfio-pci with a
try_module_get().  Since this is done in our module_init function and
unregister occurs in our module_exit function, rather than relative
to any actual device binding or usage, this means vfio-pci CANNOT be
unloaded.  That seems bad.  Thanks,

Alex

> +
> +void vfio_pci_liveupdate_cleanup(void)
> +{
> +	if (!liveupdate_enabled())
> +		return;
> +
> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +}

