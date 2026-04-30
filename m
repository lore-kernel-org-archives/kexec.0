Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C110CD13D3
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=; b=QupJ8NtsE6LhNDs+1FB5tkvxSx
	B3AaQpPIOGvwwQAk7s7tpGVkc2VX2H6TsOqRALRvLVEQ+iyqoLXQ3OPhyRyEL10oZkHOtikmPvPth
	6GSaOqgY6mlLRL2/XhVBPutl2kepyoXNiClzAfK/kaXcPxNcv6nOHl/23gXDjIcahubOunf+Dshne
	OJ873WckwSCfZUEvlVeV8OglqwDF6duXFDygfDjAmeU3fI4n0sSMFAPGmmBL4Gvap+d92lyIyg7Zl
	spDDmOJ7PeE3ayXrJf+0ryIiTh6NBwiVESlX4A5be/buEXYNo5fuBA1R/hWVvEbsH7h530WgtBx8x
	vTYy5RHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIY7o-00000005vZS-3XZg;
	Thu, 30 Apr 2026 20:36:44 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIY7m-00000005vYf-3uls
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 20:36:44 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so8076725ad.3
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581402; x=1778186202; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=;
        b=oV8d2Oa0g9aUu/8ph89ZI5mEFIm0TMaekyo7YjRS+J9LujJbGSLXZyGQOWx85gud5g
         HxsKwzCm1U13ei9lLjvfNao3On3Jf/EQUByoCQD9yQR+M7fs1W5zWjO+AM+gWHwMwhUS
         5CBho+mlUM1JI6HWZx3C+z+pKEOMhpSExzg6ZDSSsrqSNOPUZT7nuHhnD9v0TYqb8m22
         NIDfzyVPjc+388xHGXZH27v9Z3+8TiChDIMQDm1tMAEix/AXFN4T42gEvbfFiW7dPNGC
         xyNDko1Wu0K1z6sfTsYGkJmBryOok6/kGh/Z9tgKlE4DiVc9V6yYGwkLBttYjgdA2+zv
         c+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581402; x=1778186202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=;
        b=jlMm2E7iehAoU+DMQ9wDBHoHCQ+iguG+bStwQ7ux9bMaY4oRNUlB98UocmqN/2GLZc
         WY0el1u+GXR/DPA2yQqB6I1gPezIyEmrse0W5+cFhFBtsLXX6epy8ikDMbqbGVElOpy6
         i0PRMpWirnMWgbh6HgiZUfh7tJm04TOkPmLlOwx8+8Fk4LfdYu+xFyYO33Md3+2rjkuk
         v3Qt1VSnh0wxXs7YT7njx/IpA4VI27OGqRq/KajkPBumEM6mBw4lJeevk2c+SeQmtgp8
         7wRwAv/Osuboz2GAtDwHnUvEmYMAhSb9LSGeCe4Znh3fnavGN7mA7dX7oGv8BIPjBNfK
         xQrg==
X-Forwarded-Encrypted: i=1; AFNElJ/1ie5bH42lX2mjlvade7DsdgupabFgJ9X3kv5CEMNyuZQpImAK7BdKzOW3ihBJ2Oz97jyvoA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxzi0F29th31DR288x+pUL4GLqKkY1fgg1uqHxrG3U1blCd3DWr
	YsS5xzVgltmSGXPJiVbve5wrDkq8mjOy0XuK1F7hWlsbKzFHCGqnaRvW72KE96J4Sw==
X-Gm-Gg: AeBDievy6So5KECjQ1RdKujIZifazMXZscmI0p8irLLf59MhQ86XNHrx+d6D8Sp+Q/F
	DQykt5Zbk/kFvipIXaJXVd/9PdnPT+EG2ngAm90I5KBuBi6IB3kMg3x+s5hCubyq+F8BzTHRepE
	gM6FLJ4P7r0bUuYc7ivO+HGSGRcdONQv1fY4K3eFIzGLZhBSSyCZfXLONokaO9BoBAXb69XzcGS
	QI/GCGxXJAnhUvDb362l4NhlttS2Ulfh+7FUORaUnX4+R7jwzw3rK0Q6/Q6KQtJUQAz5GNe5Uy0
	hmi81DYHWspM2dBpwroLwjzbMSjgN/w1nRGrmXtV3FcRLyznXoSxlxfGu6cv++vwQZD6HQpLTZl
	OQGTWTGdLmm2/tMHKQA+HmaNuyYOUNW3aKNtWv9ZXVYm+vG1Cs34sfwSX7rXf6+RpDCIGGbGHTE
	BrLk3dWSKTasciN+6qbpjcrZiRRMz5sqf3HdaKzv+DQ+5+yCVYiCr0blImQMV+vGDxmvQRPFx71
	/AX0A==
X-Received: by 2002:a17:902:bcc4:b0:2b2:490c:410e with SMTP id d9443c01a7336-2b9a23195femr34674875ad.7.1777581401489;
        Thu, 30 Apr 2026 13:36:41 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae4a127sm5909845ad.67.2026.04.30.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:36:40 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:36:36 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afO9VOckgyiiokw8@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430175916.GA13902.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_133642_979269_6BFD2672 
X-CRM114-Status: GOOD (  23.20  )
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

On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > +{

> > > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > > +             return -ENOSPC;
> > > > +
> > > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > > +             /*
> > > > +              * Start searching at index ser->nr_devices. This should result
> > > > +              * in a constant time search under expected conditions (devices
> > > > +              * are not getting unpreserved).
> > > > +              */
> > > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > > +
> > > > +             if (dev_ser->refcount)
> > > > +                     continue;
> > > > +
> > > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > > +             ser->nr_devices++;
> > > > +
> > > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > > +             dev_ser->bdf = pci_dev_id(dev);
> > > > +             dev_ser->refcount = 1;
> > > > +
> > > > +             dev->liveupdate_outgoing = dev_ser;
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     return -ENOSPC;
> > >
> > > Since it is executing under a mutex, and we already failed
> > > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > > here and return -ENOSPC?
> > 
> > Yeah I wouldn't expect to ever reach here.
> 
> Will you be removing it or want to keep it just in case scenario?

I'm not sure how I would remove it. The code doesn't not compile without
a return.

