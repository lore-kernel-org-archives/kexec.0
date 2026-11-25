Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AC606A329
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Uzp/jk5O;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ryx9s4qf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=; b=Uzp/jk5OJ8UEHVSz0CaGrXpPLE
	KRIu7UByIv2OKPFf+q8Km+65D7Zm5N835SQc708RC+xP5MEpuGRnWr3Er95kCkDuf+5Fz/QT5PGsK
	9SPgx2s0xKiP1Hqr8OsjjGjxopm0rM5NQTVcaH5SnHsOhRssRYqONrEuTPqBwIqJNaN8f3aYGJSsD
	rztQnbJiNZUFMlp49UPWIpfNsiE9SKos4fLRzYLERv3JzNi7/gZjqMcoRAiO1bF+jkLRwbB12P/gC
	3W+hr7ruq0LTKL1iiUQlev3IVzUwV3EYmsmXGa6pf5wsJSTPA7DKHP+C0l9ONmdJa9po/odbTxegP
	vtu8/4mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0o8-000000088yD-1PPx;
	Wed, 25 Nov 2026 00:24:20 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0o6-000000088xt-2zTS
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 00:24:20 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2f048bc09d7so242645ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 16:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566258; x=1796171058; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
        b=Ryx9s4qfE9dROiAp/B450C2FWWJtO/dh6I4kEdYjK7QZMUZ7Iahxyjh77RvVyt95At
         BZ4jLq4sZSQSqaDPy62mVjNIlfRlgMYTgrOZKambpbwztBthc4oOSCcjWOaS7gIknrXJ
         j0ryyHCdlgrGXqjE/5iLm/p7gVtt/SKQV1Y5IO2IPCGdXJv3O7s2kzv4RkTtm9+Uyrrg
         xHzSRRD1oIYg2YoE0ugEDCvWyV1g4axc1yhH0sZbXhIHbFtMHug3alUdp8bD3jkD0c/3
         /izmhmanoqSNxT+wLr3Tg3sMG1VHM4JTppVtHSCeICHFVQKOFqDmTezheSlHW8WjQNxW
         Rt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566258; x=1796171058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
        b=24HmC9RHWSMJfDv4qeSHxEuYHh9OIWnWMV7anTxnudCgyihG+m6Gem5htcCJFaRkpr
         keImrfDq9SrhP/kZAhwT1QmFObSzETvoV7Gg6TLbWCFpbjzPJitdgORLfgLGjx5OygWQ
         iIf+Uttt1CU1eQJgLWyYFdbgfcWMPZ/4gvArpmU4rpA3KhtAjMiq3ulxQeOkdT9iJlYN
         HRHKVVOrRS2rGWkkyXIITeijrsjYCeWBsWGFKAz4+/Zs5gD2cR53Ts5dkYZSd/h1QS01
         U7GDQyyHD8EVJGieoVep4wNA8fhOwJKUf7yF4eJg2MKmnmbCcP8C8ZBHCMYqXi36Tfyq
         5e+g==
X-Gm-Message-State: APuU4Z/5dzHgIvcPT2wAMz2BlkUpQeF7JeXVmgI/4tz6lwP6TkxHmXrC
	o8dMDZDwomWHO2QNK0+xzx95+oP9wROf26jaK2oGthEClHMBbREEfO5xyUxH3G4Jmw==
X-Gm-Gg: AZFdTZe++H8TNCFyv9aj7B83+2jF9NXczMAYjlabdlQFt0pfVcExfbs29PT8OPHxm6b
	O2c6zrtrNELA8XJ0b47cejJjLSS/MNtGGkmLPIPnR3nmIX/Kwa1OM9O5LeYlkCU4yhNfw2HmAi7
	+aofRyWvwzMYCydm9j+PHBiWFMOJJVOE4UZsXgTMLpOnV3ReZA80QxtKlV8S8FuQ6D1vdmbOHDz
	yKzTnGC6D4UAgBP8XQ6yIpT/TQbTWuluWsldknESieBKcQz2gfTUMoxYHj/sioA+8Mzdr0JYi/h
	rUneiWjMj6jcuZbmCh53pm/2xLqaBvSe64thSklMS3rjGfzf3kQzjzNrpkiWJR3w8G1twq77Rrr
	D3e/cmIKxAMs+FLNMtkH63ctTdM+WZsPLoqovhSFsTUPO7AFB9kik2KTcdmfJVeLVz/fJzQJmnk
	7UV3KsYENGg3z3Xb/o4kv2+nu28VPnbiPzL0TP7RrYjAZuORW9S3utHmbdg2CZYpUjGXUQpqNdJ
	k6B/nqilnnnZq7gHPA8TyMdEyKRpmk+7cLGIvSNDmfkgb3j/ZqDZ3gqtSm4B/21rYclEjICwvVt
	yAkzbi5CWovv4aeaanbuTezbRzt36DgYiMpWS3J25ZDhIyURXdgGcNTrWz+hP1g7WJYY1bPg150
	mDiyINnPwrYe1
X-Received: by 2002:a17:902:e950:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2f06242bd42mr16475105ad.2.1795566257244;
        Tue, 24 Nov 2026 16:24:17 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm7632022a12.15.2026.11.24.16.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:24:16 -0800 (PST)
Date: Tue, 24 Nov 2026 16:24:12 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <20261125002302.GC3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-13-vipinsh@google.com>
 <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_162418_756682_4ADC3878 
X-CRM114-Status: GOOD (  17.17  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 04:19:34PM -0800, David Matlack wrote:
> On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index 12557d45dfee..e6ca4c3fda06 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/module.h>
> >  #include <linux/vfio.h>
> > +#include <linux/pci.h>
> >  
> >  struct iommufd_ctx;
> >  struct iommu_group;
> > @@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
> >  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
> >  #endif /* CONFIG_VFIO_DEBUGFS */
> >  
> > +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	struct device *d = device->dev;
> > +
> > +	if (dev_is_pci(d))
> > +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> > +
> > +	return false;
> > +}
> > +#else
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
> 
> No need for the ifdef here and 2 definitions here. If
> CONFIG_PCI_LIVEUPDATE is not enabled then the compiler should be able to
> optimize vfio_liveupdate_incoming_is_preserved() to false.

Okay, I will remove it.

