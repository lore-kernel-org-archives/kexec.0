Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33C4D73E9B
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBZ3PFz9KqTT7KdM5e4cMtXwD446xZIZixlzxugjwak=; b=w+J8zUanzxcN1dL0jPTJ6A/7Tl
	DKnCNYg31UHc+yuAM8RFRsHxEXpuvJTMWmzocVw7r0BL0GMwIjWMqOQ68517XMJAQMD8o8vT2yvoi
	VYcEoEGWnWQCB6yfvoH8YCtz2fUakRBxGuM52Dv/kzErRj/P/waQyP6wDfs3W9TCaAyCrG0AQyeVB
	nK+QEg+AjOoZKbBtUvHZzPYKACvi+xNZ0+1MqhT9/hnnYxY6oJnU3KBXqGr7kNR4iIpGmvhzuvksg
	OPhXsMdEAtPIKr+iYRR6PXA8pKLQxzuopQ/SEMm65IqLhMVCcLjY5U4SZLPVZ4RSQxLByKhbNZIvT
	O0u66yvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlaZo-00000000jyQ-1qR0;
	Thu, 29 Jan 2026 22:33:24 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlaZl-00000000jy2-4Bf0
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 22:33:23 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-81f47610542so876050b3a.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769726000; x=1770330800; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dBZ3PFz9KqTT7KdM5e4cMtXwD446xZIZixlzxugjwak=;
        b=y1tmMKK13VSNSQKThfv7/6ofPpMmHc8UEqQTwcOm3JEXrj3WBn4e05KnO2EHv5NXG2
         nGVej1aKxZ4fKq0sl6QtWLW8fWoGIZKt1CbXwrHQxyGA05InKqWiMREH3FiwezzyXpRE
         N9O89yOYMShiwfdN2gefWKLUFDUMOByTcHOvKKdPy/5nRRJoK+ZxYX7MhtmdasyKNUSi
         h+zX96B4l0BcSPG4h6fhDHjX3SOZXHzRR36Oiw4cMljUvNIhZXiJQzbcBOAms2yxHwq6
         hmJarxJcYolIQSIkx/rs2ORWigGQKYNKjdahHJB+7QFFMHO3bExgxC83GNeGY/mdomZC
         tzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726000; x=1770330800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBZ3PFz9KqTT7KdM5e4cMtXwD446xZIZixlzxugjwak=;
        b=xDkZwhwWJ8Ygu18NYP0ufCk+rzQ58obUanzfIsOnSDyuOAzSuuEvdMl708R/3CwgIt
         Bvf7jQjuijwEQ4EWCx7hCjfOPmR86/WzMUUm6mJxGLgyrKPLKZtqs0iVY0epl4a/X3l3
         Yi7oZJ7P8C1G23h/hp+EIdn1M9puBxnXpK7Ri58b76OPGxH6Eo1+DN9SeHoHs1/0nW5I
         6j6JcB1ekzxSsXUX/WJ2+aHhfnSptkR3lDbh30cSI4nnyUr5zAZcYdXHiAGv2tl6VERm
         cn7ydGtFd2QsC6H0gM0XDZSMuFJQVf0ueSQ7YXnzk82Ss0/nWLaOIxX4vQP1IQ0rmKtc
         zdWw==
X-Forwarded-Encrypted: i=1; AJvYcCWWFfoMHiNG8iTaGW/5jzOXb97u9XxGeKg6G070Y5EILrUb0nQIAzqNpj4hbvs567zDOHX9og==@lists.infradead.org
X-Gm-Message-State: AOJu0YysHLm4H1HXLQtkcLcU840YEA3sqoWdE9HgJc0G+OJk9edegW2+
	LMZkmOPeBa0RORuEsc0oF3oyeUVCs77phnBbibe0ANMDgYZ/6/Xa9GlPXYS2d4Ttwg==
X-Gm-Gg: AZuq6aKXwvlP2AfBmbAukKLyK6kJshi8ApQ7oM/r+z/oZXkhXZ6cSOwtD4T4x3x3myB
	2MPr9T35kt6nOgZtbShfjQZwOIaAc2OTXJ6NqWsXK80CGZixM7c4kLYg+YktsatgMbmLC7ukF1w
	2I7sZH9LwrwlBjFdZdUk72/pIQzu5EBBbexOh/vh7Zs+YqlEfXAxV0EIx2w1kuvOMWHmg8YdLcC
	3tHeWcUQE5OyXkjF03REM4yK/NUr6AwYSZx1QA+bc1+E64NiigXoTz7NQPF8Yv2Utq0gpZ494ok
	y6hMvAiKsChL8U/HPgt2mF4Tfm4JS3pT6RegX16Fbg3sUey+5Vv026ABsuJiaStkXf2D10k/qRS
	0r2I0kFJx98y2pWZ6SfxWzIVlJ6u67G01xYuG0XtOHDP0pfxRghV4fggbkvVCyaHusREUv2opNQ
	F1rHkO+Yvk3d9sBLNaP3cnSwgWNT5DVhKPpmO2iLPRRf5JZYRRig==
X-Received: by 2002:a05:6a00:1f0d:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-823ab684bffmr621422b3a.20.1769726000049;
        Thu, 29 Jan 2026 14:33:20 -0800 (PST)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd797sm6165100b3a.43.2026.01.29.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:33:17 -0800 (PST)
Date: Thu, 29 Jan 2026 22:33:13 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <aXvgKRrbfymW5NKb@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260129142158.00004cdc@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129142158.00004cdc@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_143322_039903_8F5BABA0 
X-CRM114-Status: GOOD (  23.97  )
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

On 2026-01-29 02:21 PM, Jacob Pan wrote:
> On Thu, 29 Jan 2026 21:24:57 +0000 David Matlack <dmatlack@google.com> wrote:

> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c index b01b94d81e28..c9f73f597797
> > 100644 --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -515,12 +515,24 @@ int vfio_pci_core_enable(struct
> > vfio_pci_core_device *vdev) if (ret)
> >  		goto out_power;
> >  
> > -	/* If reset fails because of the device lock, fail this path
> > entirely */
> > -	ret = pci_try_reset_function(pdev);
> > -	if (ret == -EAGAIN)
> > -		goto out_disable_device;
> > +	if (vdev->liveupdate_incoming_state) {
> > +		/*
> > +		 * This device was preserved by the previous kernel
> > across a
> > +		 * Live Update, so it does not need to be reset.
> > +		 */
> > +		vdev->reset_works =
> > vdev->liveupdate_incoming_state->reset_works;
>
> Just wondering what happened to skipping the bus master clearing. I
> understand this version does not preserve the device itself yet; I’m
> just curious whether there were specific difficulties that led to
> dropping the earlier patch which skipped clearing bus master.

Hi Jacob,

There's several places where bus master gets cleared that we need to
eventually eliminate to fully preserve the device.

 1. vfio_pci_liveupdate_freeze() clears it during shutdown when it
    restores vdev->pci_saved_state.
 2. pci_device_shutdown() clears it during shutdown.
 3. vfio_pci_core_enable() clears it when the preserved device file
    is bound to an iommufd after the Live Update (in
    vfio_pci_core_enable()).

I think it would be safe to skip (3) in this series, since that's very
similar to how this series skips resets during vfio_pci_core_enable()
for preserved devices.

But I don't think it would be safe to skip (1) or (2) until the attached
iommufd is fully preserved.

If you are just asking about (3) then I agree it could be skipped and I
can include that in the next version.

