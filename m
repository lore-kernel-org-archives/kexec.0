Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179DCCD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=; b=0Uz+9h0Z6zUT7NOcrBSffEDZ7D
	qjaLr++w14w0F/HAGcp9C4Za6DOgrW50xafI99XF1JEhKVroY5Ag2rDdsUcP1QGDZSFmEYupFozFH
	wuB/YTNFIvvy2el9YHVdkraUbcd4tmPgbYG3EzB7aJE7vCNk+IyXYaRMUZriB+xZq/KNEGhIHObXJ
	J43tMi5PfJe03N0nozC310MzRicmwfsf/uAfc5QWGGgCMIxpJU3LiFy5AOEPDclyCIclGHrNh+KVY
	c1ATVM4GYC8Pbd9JLdC/iiQz2NYj8n5Ehpz/ZAS00YUwazfr5FrpxWVdKk6CsRQh8q/cHyvvJZqXD
	eqQasCnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIsQT-00000007YwR-2UPK;
	Fri, 01 May 2026 18:17:21 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIsQR-00000007Yvy-0Fbi
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 18:17:20 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso9855ad.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659435; x=1778264235; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=;
        b=qa2II5wp8EBHFQPx5lWnUTb3Pd75rfrXoziOpl8dAqGV0b0bvs4rn9acsujMaz0Enj
         yX6Czdb0PC8YhKiRi1XrbTOjd2w96+QRK0UZuOuIMpSockLlkpxMbGtVHkDiyyZFeUCj
         Kc7UZxnOA6tGT8/vpjv7K0+Mb1rb0TOUd8wweGPohcA77S5133KZIDa5L5MMFIPGoZ2x
         89FUnI3PcnuKpcSXrJzNNdnSJ3DcK7IfnUPDcUmnbAnLbpDwGnVB+wMCydvFft+h896x
         YtlbHTZ3TvHcmN3PG+VuOY8j4t/dP2Wdnebwx70ng1wKoY7/xB1O3KAt3Ut6VQB7JL80
         9uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659435; x=1778264235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=;
        b=kWCx7lxbpUn7lZfAsVHX1jcJGMIhaOQGZfa4P9AuubumfmRDmDJDTD7ssi4Y/y7z1O
         K78S7eGSKKvtVAApEb+nVSNpn8G3DmdI+IwpUn1iFwaoOzppf10+L2qEBpaCWGtbVmQ5
         yw4Wg62Ml1/v6sLlJF6SL1inH6T+R8QF7swVpgiF76hkgaUSowj58ldIORMQq0p0XBmf
         KMnoNOnZiS1yoPf1VWbcbzl82lRRVr85SyVXM/UaL1Pj0oUVoA9rjLdrsHXlAyz9p/sD
         Iv3Qr89WXthFleKUdHf1V1Kk526NnEjI7wRdVxztvTBPHyDO62bsmuWxy33qi8E0obvL
         XcGg==
X-Forwarded-Encrypted: i=1; AFNElJ8M3AOPbcOU5UCofpRvyXf48wojdAyT83U5umRVeLeWAALsQu+0haNjGiN+MI+coLS30Q0DVw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxs3PkHxxQow505G9im99gufRytbWfqRHv1oSVygNiHGRhNu67u
	dBuVHLnkWDJe8ttLDhcPR4Gu7+F45Gd4Ep8IRwASuFpHEbavqsxDJlWukyGXOwMZZQ==
X-Gm-Gg: AeBDievnknAtcuHY9sophx9NUL3anvb7ro3wqXPFJHBGvBbgPe+58eBWfV2+8r3Rqkf
	oeexZran5rdHC1sojuHiAVXWnrZblktCSuIBlYuK9HHzpUrViaBVO0lpiC0H+B/bldLs3jxYOe/
	rMDYPSQHd7dQ60VaIJxwzJ4e8f8qDS0EORIWrYhmd3RHrmq4NwY9xQL1JDyCFO0g/ctJmZMCFPq
	Hzb85cRPjmBTIo+E9nC88TjXHNcruDL4RR7VF6S6w2oIHBnGVjdOOK+CJoW7KbnkoOeSV9phSAq
	HEeecagIkdsEtAfVfGk4/RRRZtuWCkb0HOCWXqFn1U9Olsgx04MVQSA4cROZOVJg1xwMhvJUnSP
	m39wDOMKKEZPjd/wcqZsvWSxRpY6UyE1YXd6Di/yeEydlPa2V4a0w564IAf81HGme31RaL/25dP
	OdsB7fmUMzXK2YMm2AAJkx+aKL143lhiDshz+KpfJKD2+8AWvGZDLISBbX+hICWh04hOwvgeRBA
	ppjoDyBoOivCA6OHAVa7w==
X-Received: by 2002:a17:902:cf4c:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2b9f38a41abmr300485ad.13.1777659434630;
        Fri, 01 May 2026 11:17:14 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc85c61sm2776855a12.22.2026.05.01.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:17:13 -0700 (PDT)
Date: Fri, 1 May 2026 18:17:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
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
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afTgOXpUNWMapPAS@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
 <afPGYp145FbrvURR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afPGYp145FbrvURR@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_111719_125020_16997A83 
X-CRM114-Status: GOOD (  23.39  )
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

On Thu, Apr 30, 2026 at 09:15:14PM +0000, David Matlack wrote:
>On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
>> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>
>> > +	for (i = 0; i < ser->max_nr_devices; i++) {
>> > +		/*
>> > +		 * Start searching at index ser->nr_devices. This should result
>> > +		 * in a constant time search under expected conditions (devices
>> > +		 * are not getting unpreserved).
>> > +		 */
>> > +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
>> > +		struct pci_dev_ser *dev_ser = &ser->devices[index];
>>
>> nit: Maybe we can move this logic in a separate function as down the road
>> when we expand this to add VFs and Hotpluggable devices, this might
>> change significantly? It's good if it is self-contained.
>
>Did you mean to leave this comment on pci_flb_preserve() where it
>decides how many devices to allocate room for?

I was talking about this one, as I think depending on the scheme we take
this might change significantly. Just a nit, you can ignore it.
>
>> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>> > +{
>> > +	return dev->liveupdate_outgoing;
>> > +}
>>
>> Is this expected to be called under the outgoing lock?
>
>For now this API is only used during shutdown, at which point userspace
>should have already been stopped so drivers should not be changing the
>preservation status of an outgoing device. So I don't think this needs
>to be under the outgoing lock, but it would be nice to have some more
>explicit synchronization.

Ok that makes sense. I have similar cases in my series, but maybe we can
add kdoc regarding these stating in which context this is expected to be
used?

