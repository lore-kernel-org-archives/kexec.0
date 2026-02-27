Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B889FD9E26
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MbrSIpDE3Y8TNhyTW+6lYUs18ku3UAynLvTznEtk/Vk=; b=Quwly6aBWma6Q7Zhvtum5//JHI
	U6GyB0ed4HrQxc/+gUZyRxe2uOF/UdN0WhZB3U7ZFPdDMuPHGhkjsD9VhcQLYbE1VIAGmXiPxWGO8
	zvjHNWcbdm+hNlowOTyuR2Yq4k8Ie1eB1Vu6iGPCldOC5/U0YsO4RYRXEDAlVJ+d9Auo9wPf2ba9r
	pIV3RwUlWa3bZtt58CkPUBnpfXHkpAT/BCC0fttUARV8M75fB3tMmng6AUGoKR7iJzOXS7DDFFUWy
	3zIG3ebKAHlZhNfSdkj5MsxmeJw/OH/ss45HRmbvPtK1wXHzeTHINaGo1nzC1cpBExl0n6O71HXxP
	vAmOwTwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvm4k-00000007RaH-3uMP;
	Fri, 27 Feb 2026 00:51:26 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvm4i-00000007RZt-45CZ
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 00:51:26 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ab077e3f32so6414415ad.3
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 16:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772153484; x=1772758284; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbrSIpDE3Y8TNhyTW+6lYUs18ku3UAynLvTznEtk/Vk=;
        b=bxskMeuUIoPCRa9d0avSnYuZ8iJAyzp4T1oYkk4KwwKTSWSR5xD2aNjhH0SVaAG2BZ
         yOuK32nrhXcpFWMPzu38FQmk0PtBf0b3GKvL46TW8bmn4KCPEZ4ruqjco7x7GGLQ1+9z
         C66YuNph3DF6ZFCeecjofty9QYWQe1itXFFQT9WI2D5YBIZzdTJuqG0eEDOU5bp+zuBc
         jsDlXHU2ApebfnmPBX3us0iQDXIREeRaPXZkEC0oAo6/2Kk+HhC1c/k7RWZRVhpTg8FE
         rrmPyDpHV02xbodvFfHzXVRKkAes6dLEpkev1KtLQimCbeXubRK3l1EFet0OCdOf1wjb
         Q62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153484; x=1772758284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbrSIpDE3Y8TNhyTW+6lYUs18ku3UAynLvTznEtk/Vk=;
        b=fToEiV6X2MxDAcrh6/ZVhtEfRhIh/P2ojjqU0BR2AbA/efG2UJBG5CqXcDuhOEwyV6
         IyR3MVJF4MKIoySKA9pBRo4ZYTlCUQ31LVP4pKUl3sw31WVWP1H3GLZE+ce+LtAVCR7g
         ZpUbOwlPsZybwiNAQ2iArd1+QsHfOgqqqPrcyqew+JjH+bdoy6g1NgMUQiPPWDDgzQXt
         p4maBkcXsDxU9/WAj2PwP+No/NvwP2uVINDQYOyZQyI4aBkL6ZZKlAqGOOie0b6LFqcO
         sWwN+ld9BILgxEdZu0h90CM83rkSJXkgvmqsTcTG/d+F3q43noL7JELKFrqpgVPF6RjO
         K7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVIChIBEe1c8UjlEV/2nBoDaDrgxHfdFEkf/q/BOMAZK+YAT0+G7yPRSgKl6b0YopIZnBhAkg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7kAzSEbCpyozgo5KxoFKYZoOjgL8aGe92XpVtnwT6SVc/YjR5
	KO/X82diIxlBFWiLI1VxiXYtUXeuvtC/BY8ccBFLQdx0VDByr5LsjeM0RYRp+XKp4A==
X-Gm-Gg: ATEYQzw90mcoj/rNDTuJHRWWu6xIZI8wgsTq3om54EJs3BWl1BpSCfR1dOWE77ieqL7
	Lt7qUrlH+S2JpSgFmFCT0sEIk3hjhTJypa9CSvwdP/8Ks7y6O+A7BO2hZO0vlQKiDR5z2vJ1vsn
	2KpU+T7NlJvuG1twjakpJ2ipG2OXs4zJncZOCk7So/YVjHmXlVt9HsQc19rffle4txJ15/DZf63
	9vjZV91mp3ZHwlW7fFbP32/0KmzGa1obO990SCDFoZnWe0gpNY8Xi5AZ8BQfbr4/nLXb1BBx50z
	XeC5RrXXT5QlcES894iQ3IIXYzZMKVUMpsT5/aXeHgT57VyH/IeSUOYLw9bHxlhzIHhKEXF+1uK
	rnuwmOhjI12W9F2tyVUMauzYdCAELplU853PpuEzMX1p9TvLCgB1YRoLpqA7Q9pgS0sg0eE+4zp
	vhdpsPOyR8U+WiBLutN2e1DWhVF7MdBGPejmw6fhv7pdo3QPYrt20YdHuJKGe2lw==
X-Received: by 2002:a17:903:41cb:b0:2ad:ba04:40ca with SMTP id d9443c01a7336-2ae2e419430mr8325415ad.25.1772153483265;
        Thu, 26 Feb 2026 16:51:23 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b974csm34254135ad.65.2026.02.26.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:51:22 -0800 (PST)
Date: Fri, 27 Feb 2026 00:51:18 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
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
Message-ID: <aaDqhjdLyf1qSTSh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226170030.5a938c74@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_165125_052386_A1774483 
X-CRM114-Status: GOOD (  24.91  )
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

On 2026-02-26 05:00 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:57 +0000
> David Matlack <dmatlack@google.com> wrote:

> > -	/* If reset fails because of the device lock, fail this path entirely */
> > -	ret = pci_try_reset_function(pdev);
> > -	if (ret == -EAGAIN)
> > -		goto out_disable_device;
> > +	if (vdev->liveupdate_incoming_state) {
> > +		/*
> > +		 * This device was preserved by the previous kernel across a
> > +		 * Live Update, so it does not need to be reset.
> > +		 */
> > +		vdev->reset_works = vdev->liveupdate_incoming_state->reset_works;
> > +	} else {
> > +		/*
> > +		 * If reset fails because of the device lock, fail this path
> > +		 * entirely.
> > +		 */
> > +		ret = pci_try_reset_function(pdev);
> > +		if (ret == -EAGAIN)
> > +			goto out_disable_device;
> > +
> > +		vdev->reset_works = !ret;
> > +	}
> 
> This could maybe be incrementally cleaner in a
> int vfio_pci_core_probe_reset(struct vfio_pci_core_device *vdev)
> helper.

Will do.

> >  
> > -	vdev->reset_works = !ret;
> >  	pci_save_state(pdev);
> >  	vdev->pci_saved_state = pci_store_saved_state(pdev);
> 
> Isn't this a problem too?  In the first kernel we store the initial,
> post reset state of the device, now we're storing some arbitrary state.
> This is the state we're restore when the device is closed.

The previous kernel resets the device and restores it back to its
post reset state in vfio_pci_liveupdate_freeze() before handing off
control to the next kernel. So my intention here is that VFIO will
receive the device in that state, allowing it to call
pci_store_saved_state() here to capture the post reset state of the
device again.

Eventually we want to drop the reset in vfio_pci_liveupdate_freeze() and
preserve vdev->pci_saved_state across the Live Update. But I was hoping
to add that in a follow up series to avoid this one getting too long.

> > diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> > index 350c30f84a13..95835298e29e 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/types.h>
> >  #include <linux/uuid.h>
> >  #include <linux/notifier.h>
> > +#include <linux/kho/abi/vfio_pci.h>
> >  
> >  #ifndef VFIO_PCI_CORE_H
> >  #define VFIO_PCI_CORE_H
> 
> Wouldn't a forward declaration do, and the kho/abi include can be kept
> out of the public header?  Also should be in the previous patch?

Will do.

