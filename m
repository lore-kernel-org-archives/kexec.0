Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F18CFD9E21
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMLSS/6smhC2Fkh6khLdkEUEvv92EQDMAOVxu9hbY5o=; b=u+waGMNiuZjHrgH0nSwCOFLnLG
	K6DIeDim6ETG7san/XX2a80pzhMcmMBFY+QEwbwLupF//AHqfTjPeM8aPV25kVgsemulXCbW2/sd4
	L2VRv8L3C5Y1ulFBMBA0REhpTSTB3+ZvJ+809d8mInE/+o75rXyOKobpQbCVkR97C3IR4fDQD1MHW
	Mt1fn3DJRoJRLOc3UZPu3s5jY/xD2PJFueLgNG+ozDap53CWvREqoBPJL2xkqOcBuHt1Zh7vcMy2W
	D6VSJz9b1xiGmYzwpc/d7d6/pls/vzpJU1VII4Y/LMxtbm0l17nRI7SKsiFGNtv5rd5EMqOM9cCS8
	fOdjFwqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkOo-00000007KsR-2rL8;
	Thu, 26 Feb 2026 23:04:02 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkOm-00000007Ks6-0Haj
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 23:04:01 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 9F6221300BFE;
	Thu, 26 Feb 2026 18:03:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 18:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772147037;
	 x=1772154237; bh=nMLSS/6smhC2Fkh6khLdkEUEvv92EQDMAOVxu9hbY5o=; b=
	pSKbpMBhjVCNUqBlCA9hD+PAOyjdKGsoXuEXpVYWW0tdWld7U/1w1NX2PmYBh/xn
	qo2DILVymgJ+aXiYyMFfT3jnhkE9B7opsAdiff9avzGjM/MXsGpc00dpMnvZH+v2
	+al57pngO7lZrPYnVu079A4SlbDzeFovpGchCvHqGWatoVsPVl6RrPEzl+P3nCb5
	oE0L2NS15px3cyVh5Qcf604sfEfRvQgZRC6Jb9ntHnIE5TaafEm1E6XlmLPIfc83
	f9ouaIu0hZGqkHCY8GCC1ZowDxp7Rgznbn690TZ/wsGjPCQ8o5VjZM/l+DRp9vbt
	dcjetnr74b8Jjy16XngAZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772147037; x=
	1772154237; bh=nMLSS/6smhC2Fkh6khLdkEUEvv92EQDMAOVxu9hbY5o=; b=i
	tMG0KrXlyEFXwalLMq9Sx0bQwBEAgP9bIZErOhRLK+YxLMjHGj/4pEB6yiISM9UB
	OiJQx272k4YcRkiIf1NT+lmiNDK1XLYNwsVvM+cKn2+iC29TRgWkNReqW7tf5oMC
	SO9UoppGBcBgwMXK9MJRMFWoE7UPMlhQAiitzOOkVRs2uOExtBYRRJe0ulaf1QZw
	HGVc3Isw7DmR0QVlIbuJdBI5a8GCLAEpiuM+klWIY5GnIXYK/PnDrGbdkB1LcKu5
	BYHX4zisQXoxrjyYzlkZ98AXUnJCkN7jYh1ZuTlqW76KnekpoRCowo/omVLticQX
	5gVCKqqyfQe8xrHK7Xt5w==
X-ME-Sender: <xms:XdGgacBk-a_O4YaEInjmWWDxabzQN4mLXC5qHVW4JFh-0mNlnVlFNQ>
    <xme:XdGgaULPU4sQfbMFfCtO-7kCODOOZLuyTwssclrsRpekwQfpSyKdg5TY_yhpHBy9o
    cLrLikyCCVk-iqtscnlq9KPMwGMdAm4lTFEkPGDHCSrMkkUucJ3Rg>
X-ME-Received: <xmr:XdGgaXpAlCE-PpaBMLNfI1-m1wWQpOlnWQ7LafEdb8Cgw61NBCBPYZGtKIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejfeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XdGgabfq1Ai_EQPCKW27A1XJdpuSwGGpo_5-E1KoICM5d5hpf1B16g>
    <xmx:XdGgafpW__MOZjkcCeKPdqOzUegJkJbht_U9IShOJQZUvxnpHkhVuA>
    <xmx:XdGgaXQvCmNlF2J2dHS6vEVqYIZVfwQHxNyXMPN92lqXkjvDtj24dg>
    <xmx:XdGgaRwyXwCgwUD3I0SCQkXj7VyHRfPVqLTstyfDRwOu0X1MFBGsrQ>
    <xmx:XdGgaWSCrdHJXw1ROVKIfwjhuia4A0XZjl5nsXo6JfOBqvYYxsBNCQoN>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 18:03:54 -0500 (EST)
Date: Thu, 26 Feb 2026 16:03:53 -0700
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
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <20260226160353.6f3371bc@shazbot.org>
In-Reply-To: <20260129212510.967611-8-dmatlack@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-8-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_150400_201847_13A0A36E 
X-CRM114-Status: GOOD (  25.45  )
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

On Thu, 29 Jan 2026 21:24:54 +0000
David Matlack <dmatlack@google.com> wrote:

> Notify the PCI subsystem about devices vfio-pci is preserving across
> Live Update by registering the vfio-pci liveupdate file handler with the
> PCI subsystem's FLB handler.
> 
> Notably this will ensure that devices preserved through vfio-pci will
> have their PCI bus numbers preserved across Live Update, allowing VFIO
> to use BDF as a key to identify the device across the Live Update and
> (in the future) allow the device to continue DMA operations across
> the Live Update.
> 
> This also enables VFIO to detect that a device was preserved before
> userspace first retrieves the file from it, which will be used in
> subsequent commits.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index 7f4117181fd0..ad915352303f 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	if (IS_ERR(ser))
>  		return PTR_ERR(ser);
>  
> +	pci_liveupdate_outgoing_preserve(pdev);

Why do we get to ignore the return value here?

> +
>  	ser->bdf = pci_dev_id(pdev);
>  	ser->domain = pci_domain_nr(pdev->bus);
>  
> @@ -62,6 +64,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  
>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>  {
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +
> +	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>  }
>  
> @@ -171,6 +176,9 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
>  
>  static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
>  {
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +
> +	pci_liveupdate_incoming_finish(to_pci_dev(device->dev));
>  	kho_restore_free(phys_to_virt(args->serialized_data));
>  }
>  
> @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
>  
>  int __init vfio_pci_liveupdate_init(void)
>  {
> +	int ret;
> +
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +	return ret;
>  }
>  
>  void vfio_pci_liveupdate_cleanup(void)
> @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
>  	if (!liveupdate_enabled())
>  		return;
>  
> +	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));

This is propagation of a poor API choice in liveupdate, the unregister
should return void, it shouldn't be allowed to fail, IMO.  Thanks,

Alex

>  	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
>  }


