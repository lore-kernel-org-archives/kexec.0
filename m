Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256BFCD13D2
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=; b=4t9YGn8Ip1jMMEq7nM1PkhMwC2
	SBtY+ScqUsl7+S7fz4UKqwMfcaAb9v+eIyelCmUwuyzF6+5j9ZHbu5BzIaxZi6CDcNu56JvA3iDdL
	D0UAs3PPLA87mG/4hHjHNPTyJj0mRcSXO9wQqc+5yt7Bh0k7x/s5Hd1dxhS6L/1qJLC/Or2XP3AQi
	ByzCn3R66UeWPfL4jEEOUMDZGQ6Gg+86wxJ6yPR7pUH4Weh0JohjIbSnAkmQSnKupX/GUzFn5asIQ
	5Yep34F0rlFwA53RT0vXKNoMIXJIZRRmzvF8FEvR4RxZluJYpKRXAHpZw2CxxyPaobYit/l/Zz4yw
	0rSD2lNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYjJ-00000005xsD-20MG;
	Thu, 30 Apr 2026 21:15:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYjI-00000005xqQ-00Er
	for kexec@bombadil.infradead.org;
	Thu, 30 Apr 2026 21:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=; b=gjN0j6pSSw98UqpskqzT/p+uu4
	ApdRjPQAhEB4SnqxzDI1UlopnBaTk2/GdVvwgwa13PWOum0poN6cijENAQRCA6/YG6U+cquTrM12/
	QS01DRiONxIHBKT1UQreaSRDGCCH8nfc9JK09x++6qSUB+7cgAJEyRleD2jeknXMvUzKxqb8jboX2
	twE3JzHStS0nsxtYCQS3dgGvpFl/VTLz/EVL/Befanpd1BLhD0PdLZtFkiux4fAyJ8hTmsuRJIWOU
	FD5HT1Q1eZb3GwU/6N1J9PanGdcpYcBjlb6JkTrNLEltjtdNhTCbrC0C5/ICScrFMTP1yi7/nxAFI
	r5TMc3sw==;
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYjE-00000007qJC-3n8F
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 21:15:27 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1161384a91.2
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583721; x=1778188521; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=;
        b=lZYRkcNDQPhzTGZu0ne35F0pkP6d5Zu1XOwlWwKnOLucH8wtBIwx+Bz66bKNUQMufI
         APKX6vGl0GBHq6iVAsi7B0iC9OfAJ4FSAinpBrVOLP147ESr92nfhCy+dYlD6f8qOxtf
         AVK2QEnvRzJ2JmsKVNv8XoFUW49T66zZxj61DReyLp0jEfFrbqPYf5YvYS8h1pSZWOr/
         TLl4XbWKgWjXxpw1NJpAt1HuojDeLX6ge8gJmCrsBiFEly5AXEZUwAvYujgDKM1DIwuZ
         NCIsUD8xzLsRmFogYeFBPRJetYdbn9i5FIzKZwRLbexxiEItB9RjMwXRv9b75qoSRz97
         CoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583721; x=1778188521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=;
        b=HZvleJJzR8oO2DjbJZXF50cVM2zoX03HOPxGIVu3dwwL71vW9evJdZSZJ5EZkM1QcD
         r1cFhJjqSzfKl6xoevidn1Ivt3qxOEvZrcZRB70Vty3WbOt4pr6YDOIf0bbfaZ+NHiyu
         b4QyD5vf5Cetctd5Io6oAnFT28jChZVCpwjvUR41qHTEI28tN94+Ri1/Kx3ZgABuVQKU
         A/1RCbI1mk3F8PkjixpsdUw6mHODLYPJMHUxVySmhsq0Wd0czjFkLJEz4TuyNdlcDdQb
         SW/0loH8lp2v3F6tXo/c2ZJWP69kLczyDpGZKiWesrn5/7EkcqK7WFwWr4MMt0KGE16v
         X/2w==
X-Forwarded-Encrypted: i=1; AFNElJ9VwWGkp3vFwbGK4WuscpNSzG8bjEwU6V8YTg5USkg2Xm8MLwt5CKmx0KQMOirhRV1VevYKFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQZwrsZlH4Fz9tAGfo1bcM0bJUqzq1svJpNOwXfy3Yu9i4j1Vd
	L5mCmVrueb8k5pk3cZzdJbnIRkDqGhnQ2fyew0h4ZAXbI25IGPCanhFxB75Jmiu5NQ==
X-Gm-Gg: AeBDievDW6jlDoPTkzxoDWfm5h+cCodrhtIkr+aPrOVGl3rHAiY+owy1YNqW5ZwCIOl
	ed/pccyBUlAnNpqkFt9jPT82bvd677E6cENwapi/D+/9mziJstEWKWcvniZV8QoP80smSaFzuku
	zcSHVPj9o6gXHC7T9NaHLYhdszfFJg/RuIIHCPiO+wwbNGTzQStajztSl63Kf5R5Jkck5COTkM7
	+u9psU0gcmaPADn6lZavbgzEWc+8cL8DJyfEn4+N40YHWJTp0eNvgMp+6SeNA6j6bA4tpiFIpXj
	wnAqZTC4DZC8vAsoyc9JmmlkZr6NqhtOCUU696F645snRWxPGE5VznXOl1NpOu+l3SK9UfClDD0
	WJhnI9iFjG/GUraUnYPDIMXucH7RdBjM/uYuuYsFGDTY4A/UEqZ4I2e5sRqY67Yj/zFRmvaSLNp
	qAvH7P8fWkb6Aqltgwj4unYmG+wSSM0qpo88vlsok1Kp3uHIWtb/pjcjYUpVnQ1qv4FOEF0Rz4R
	5ggZ2rJAW5orej6
X-Received: by 2002:a17:90b:2790:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-364c309bc21mr4610958a91.16.1777583720228;
        Thu, 30 Apr 2026 14:15:20 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebd46484sm474408a91.0.2026.04.30.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:15:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:15:14 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afPGYp145FbrvURR@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDqs6oqWlhoVqMN@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_221524_982514_8D05633C 
X-CRM114-Status: GOOD (  19.73  )
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

On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:

> > +	for (i = 0; i < ser->max_nr_devices; i++) {
> > +		/*
> > +		 * Start searching at index ser->nr_devices. This should result
> > +		 * in a constant time search under expected conditions (devices
> > +		 * are not getting unpreserved).
> > +		 */
> > +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > +		struct pci_dev_ser *dev_ser = &ser->devices[index];
> 
> nit: Maybe we can move this logic in a separate function as down the road
> when we expand this to add VFs and Hotpluggable devices, this might
> change significantly? It's good if it is self-contained.

Did you mean to leave this comment on pci_flb_preserve() where it
decides how many devices to allocate room for?

> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
> > +{
> > +	return dev->liveupdate_outgoing;
> > +}
> 
> Is this expected to be called under the outgoing lock?

For now this API is only used during shutdown, at which point userspace
should have already been stopped so drivers should not be changing the
preservation status of an outgoing device. So I don't think this needs
to be under the outgoing lock, but it would be nice to have some more
explicit synchronization.

