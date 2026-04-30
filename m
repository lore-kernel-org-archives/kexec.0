Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A2CCFA13
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=; b=bkISREAkeZIR3eeyUFn7BsC77Z
	fqQstWNne+mTcZMQuGCZQyknnlEv3i5fPadQNOcwg+V484XMMLQw1v4OvCD6FYKQ+C51F/a+BIREl
	PnKAcT4yimHpfq1CofHU5m2bZqmOV6sBZZDGisKFn/PMA5EuQJRZMJUl9IKR3l2s1MaYHmeRd40ev
	6I2yPgA/qhbZfnNxmmMTs15Isabg1hrSTuYpQvVXujZD4nzOUttoWpeY4reLNVgqVQmyz5J6fscuU
	uNjE+eg16RzVyYt+Z3rqVHwCGtXotNoZkZjmm6Hf1x+/n8C6n6/enHSM9BJOwwfd6h2aMHNAQ9byu
	u02Zj2hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYDY-00000005vuU-0gy6;
	Thu, 30 Apr 2026 20:42:40 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYDV-00000005vu6-0qL0
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 20:42:38 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2b46da8c48eso9855ad.1
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581756; x=1778186556; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=;
        b=FKsfw8fpH4Z6+pHXIOiCEJ7SE7vDk2kUuyRiBMTOfl77MstUUOD/lj4iF3QOmzSmc5
         oYcSRkK7/uW8Kvn7u/D27ddJCqKirLZdVEQlxGY8WpLddHKB/pp2Fk91C8YcNN095nbF
         UdVBB17g1063pn8asG1I30pUSWfyKHbX13f/wme6xdz5si+ID146jSNDckhmURxc/R7s
         lzWqqVGLoCNk2cGhSnJbBqrFBKWfrakAC+Z2Mbbabon3XvllHnNH5XJae5HPaS7CkfXt
         dbfvGpb3YT8rPMQaKeMOpoqYCGY51/DAechijKt6W9qsA3WFjx3cQ4LAT1rADy5x8Co1
         TQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581756; x=1778186556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=;
        b=iZsuoA61u3l/u3/Q3LLjnBCm9PV6LlW3zNV9UYLO7hToecu3+X8aRyGFT6yEe1Xm0n
         oxvmL4JzqS4bknTpb5WVd2gCsu8iOLi8hQ5WUp+d/VZfUwHoWO7upK24HzY6rxcUUBT7
         pRBhcIcj8ohX68B+6cwmOJD8OX+svAK+qg2y+4+i7+Yg2/C+iI85vBCb6mc87q4kijOJ
         6NAMKtg1DEGgpl591StjNi52B5qxbfinQCi4BEi6+fkaMuvH5iBNgGS0zNMmum7OsYjC
         ttKMdv+PgYA5QQxFHL7tyJVPCkbz6PmKCYpCpUskZMUxqh4nIWIziqh//rNPf4I4EAEk
         do9w==
X-Forwarded-Encrypted: i=1; AFNElJ9eZVDlQwd/3j4FsMzyVjtZXAR4jSUnW9bIDsmlPBexzc2hyDDEhePjDJQwQ0CJGO888OWMCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHk/YJ8quuzi9aQdaTKyAuP+kgXI+XjXeJ/YaOXdiHurWgoaoc
	8Xv7ZCb0Af8s17SsQd7dYj5RYaEPZiZDk9LfEBmb0L21utXwZojWngHRV4ZDYm4YCQ==
X-Gm-Gg: AeBDiessksHzjXKxLbm+0gKwP1XQwBT9TVA4aS+KfQD4DRXyizYh5h/WaJs5pNgHEuD
	DZW0R8zMTiKGSjfNWdnb38o4SKoMG8/uCiRPvdze3SDmWmU8h7FxCVGVfbDWQrMwE0hhfaR0lX1
	UDgKDNQ8BPqeSMTVav85c30jmq2ikmclzb1Pu13BWR3HQvT92rELD4usOS5ESv33t4iynpgmK4k
	1RxuyibjiKZHShQi0UP/+9x4Lc8/fQJ10X+Ao7FdfGSKjmDH98bcVgJaO2qH/ZQThmaFUjCFTQr
	8H64OyuadVDRRJPIEniIU8UJ4BIV2qAUwNB7AlQ0arNIgxWxYK7frXlPd8VV6cCTFmDsAhW1WWH
	2trjqoSQYEpQTdXrxPmztfNvh+uJBeWJXnj0WVYcQNoGJcm+ncA27Q7R8xchiomY7LwlQu4YQSE
	9CUI/rtNUqePwDuVMvSxj2eaJ/gCdvQOFan2SXlRuDJvOLW21qkSvi5CStRXCnZuAgXMc4vpY1A
	G0fWfm3IA==
X-Received: by 2002:a17:902:efd3:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b9cde4ae98mr575255ad.20.1777581755636;
        Thu, 30 Apr 2026 13:42:35 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae55612sm4897165ad.73.2026.04.30.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:42:35 -0700 (PDT)
Date: Thu, 30 Apr 2026 13:42:31 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260430204009.GB22297.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com>
 <afO9VOckgyiiokw8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afO9VOckgyiiokw8@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_134237_554442_EF93B0E0 
X-CRM114-Status: GOOD (  25.12  )
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

On Thu, Apr 30, 2026 at 08:36:36PM +0000, David Matlack wrote:
> On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> > On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > > On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > > +{
> 
> > > > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > > > +             return -ENOSPC;
> > > > > +
> > > > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > > > +             /*
> > > > > +              * Start searching at index ser->nr_devices. This should result
> > > > > +              * in a constant time search under expected conditions (devices
> > > > > +              * are not getting unpreserved).
> > > > > +              */
> > > > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > > > +
> > > > > +             if (dev_ser->refcount)
> > > > > +                     continue;
> > > > > +
> > > > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > > > +             ser->nr_devices++;
> > > > > +
> > > > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > > > +             dev_ser->bdf = pci_dev_id(dev);
> > > > > +             dev_ser->refcount = 1;
> > > > > +
> > > > > +             dev->liveupdate_outgoing = dev_ser;
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > > +     return -ENOSPC;
> > > >
> > > > Since it is executing under a mutex, and we already failed
> > > > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > > > here and return -ENOSPC?
> > > 
> > > Yeah I wouldn't expect to ever reach here.
> > 
> > Will you be removing it or want to keep it just in case scenario?
> 
> I'm not sure how I would remove it. The code doesn't not compile without
> a return.

Oh, I meant, inside loop a break and outside just return 0, that way it
won't be a dead code.

