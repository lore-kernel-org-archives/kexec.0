Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50203C55174
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSMqYBzIGEd+bEQZKAp6F83EI/D8TARVrS07DYO5Xqo=; b=UnQkSqmMrqMeUGtXI0cil6bSJI
	sjJrEUEM+ga278cE+28mfvgMXV7QQuakoV5RcjYkYK+yc7V3VsYpvXyLyYQKblDGh9pNuENho431O
	wzFgGFYceb+vHEWYm3RlCO5vKr+tAjkcoMuocuCgwyf4TDE3WFBbC9ypMRdpv5vuNtgiZqmoeMUFe
	Qj8i50NAIYsqzLrMOA+DToxHu53ix5xS7E0xh1/zAlBBtAwzVIPIFfX7LaDj15wvN+j6Nf998piaO
	Lj0HO5W2EwTamCIhQXtJDAcY6Ko8yaRO1MahzhcUh/OObxdrn4fduuN1I6+M/CqgWL0DWOKO5VdTX
	2nEmFG3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrUkP-00000003HSB-3tVg;
	Wed, 05 Aug 2026 06:05:01 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrUkN-00000003HRO-36Gf
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 06:05:01 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cacef7d299so54455ad.1
        for <kexec@lists.infradead.org>; Tue, 04 Aug 2026 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785909899; x=1786514699; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSMqYBzIGEd+bEQZKAp6F83EI/D8TARVrS07DYO5Xqo=;
        b=JIdyvvbKCWDKdlzug3BJbTZXxCebR31/bs1Tx9EkERAdnpoKjL2UTCnf/jzAHHygD2
         Qqq5QEI7CvG58Ya8zPBlW6oGQrgto3iLopqWI2CWRP1ApSG3+frra45+vZrX5X46yL+m
         a8lVzIXSfnmSg+/b3UbbgilzlWUjkMzLad+gGQo1ScsRJefqiW5FZ9+/QYU43ACWMzoA
         ac2rx1iDBo4Ra2pXurk5q/XryJGoanGoVCZUg2f/om9X7JkmTHJr2cNA9FfqZkIG5l+h
         Xe2mV7Kwdtj5E26ItB9mYDlMcVxSuX8jTV3UNT9no+NdIayvUAKJxoJn2rOY7SS3SBNn
         Kt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785909899; x=1786514699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSMqYBzIGEd+bEQZKAp6F83EI/D8TARVrS07DYO5Xqo=;
        b=lFTNIP9r2c9cy0DNeSIHZRGmCjzc7N78bWWo/I9VzOxEAwg6JYUmJ+lv/nKU5jcrvf
         t1y6ugEMpDTls4Y9rIMfjYSILU/Gp70frPPYj5YtlVLdWCgfkOCtApilMmg4OEoP2vVw
         fcIzdS74K507llT8zCXMwx3U9CdBPAKQWjNLa3U1Kvxpj00DvoymRLc9LOKW5raTSVSh
         oSoFxx5x0qVixBa2HVma/BySNOuzlEPtM1eVEBc88rR386GwfVaKU8wOBddsgTTxP9Zq
         wwy/JomFKP8yLrEfX7qQMQSiTFEcB0SmMAH6ANlg30gm6Jh/qcPLpXVDrKrpa5EEXMzV
         SQTg==
X-Forwarded-Encrypted: i=1; AHgh+RoqzmZhQPPXiYiDPivbEBeuy+a70YS3ZcWV+0KP0vNJLy6RGfW8giuUe2pdpGGX7gbFlUafnA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyY6wzNl+MiX3+xjXqiccjhmHwiGLSh1ggfV+TPoqrfOhOMqVmu
	/zryoW/dDLmSawhGQZLE3kt3hg174FOJJBfgGYA4wXOzwM030zjol/HaSGS6uCpMNA==
X-Gm-Gg: AR+sD10jrKnZJsCrAhUs66WRimhYI6EHxsQqb8nwON7Y6JQmEoMZkYYjiSGsLeq1Wuq
	gULm/sMXMXLNIiGBtfoPievTmgX52W+wJk3P6L2YwuxAlNac+aqvcYli+pD+gDBU5349lvtpmVp
	JLOSMfAtHe+6ZmwidxqPv5tLxFUMtvqhTTVC+0dTmoPX3jBhH8fYno6q1HhSocdDzSa2ppKq8DC
	JcwvEliGqxqCX9fKKLAwf70OB3Xtva2fW9NS6vj9F+wCpaTR5QZJF17oGPLvPYkRhQjPseFwKIs
	4Htsba1+WN1Us2eNWvw22OTnr0K6f3xL/AL4PfjHSa9CIFRVHFGj6XS67VOQ6ifpMkGvO4gOhfo
	TOBEbBYxgG62L4ZObZHK9kGBi/WlWJRsz8R9rzrHiRmi6bM3/8FK+f7SvkmGQzhk+uVCuvvO5zj
	tvddSQT8lsuzKeJblb1krsWlTWy3prv9bvzKboy2kwAvrwW0QdaCWTHp5hGxjdNl5j5jnypQAZy
	A9HwUPG8OJqtq1RoDPYjA1r6Q==
X-Received: by 2002:a17:902:da89:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d0cae8f44amr8339885ad.8.1785909897932;
        Tue, 04 Aug 2026 23:04:57 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707cab37sm740464a12.7.2026.08.04.23.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:04:57 -0700 (PDT)
Date: Tue, 4 Aug 2026 23:04:53 -0700
From: Vipin Sharma <vipinsh@google.com>
To: alex@shazbot.org, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org
Cc: ajayachandra@nvidia.com, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, 
	corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, 
	parav@nvidia.com, praan@google.com, rananta@google.com, rientjes@google.com, 
	rodrigo.vivi@intel.com, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
Message-ID: <20260805060336.GB806762.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260723215749.GC260824.vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723215749.GC260824.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_230459_815517_353D3991 
X-CRM114-Status: GOOD (  15.31  )
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

On Thu, Jul 23, 2026 at 03:58:45PM -0700, Vipin Sharma wrote:
> On Tue, Jul 14, 2026 at 08:14:45AM -0700, Vipin Sharma wrote:
> > Hello,
> > 
> > This series can be found on Github:
> > 
> >   https://github.com/shvipin/linux vfio/liveupdate/v5
> > 
> > This series provides the base support to enable Live Update feature for
> > VFIO PCI devices using the Live Update Orchestrator (LUO) and Kexec
> > Handover (KHO).
> > 
> 
> Hi Alex, Pasha, Mike, and Pratyush,
> 
> I'd like to discuss which maintainer tree should take the VFIO Live
> Update series.
> 
> For context on related efforts:
> 
>   - PCI Live Update is targeting the Live Update tree (maintained by
>     Pasha, Mike, and Pratyush, with David Matlack maintaining the
>     PCI-specific code).
>     https://lore.kernel.org/linux-pci/20260710212616.1351130-2-dmatlack@google.com/
> 
>   - IOMMU Live Update is planned to go through the IOMMU tree.
>     https://lore.kernel.org/linux-iommu/20260614233728.2212104-3-skhawaja@google.com/
> 
> Given these different approaches, what is your preference for routing
> the VFIO Live Update code?
> 

Hi Alex,

Gentle ping. 

Thanks
Vipin

