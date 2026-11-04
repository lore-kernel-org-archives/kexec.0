Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA0606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=krdMarm3;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LZB8bL3k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GRG5s9Ykm6gdotG16z6YfBmoncjsZwUpCfdfDleiz1Q=; b=krdMarm3oqmkHU7fc84mIbyYf0
	7qmj859tYUB62BJfs4nAFfu2lQaWDYG1csEfLh2mAAtvBHleQ/eDtT3YI51MQUlwwMJRnGsdLjoxP
	UgNw4IDFBFNCpbCQxpUBX2ucYY/XgQDbQ5lTMTSQJ37PZPYlaAurWN5w2rPNdLoFSxiykjFAoCTb2
	2HPt+Paz8vNcxLwe5wlSBxHHbY9qcZhxsy1QWhcfhCtU7u+bwd2Ia3lM9ADn+64ZX1JEcezNU4gPq
	te4WFV0ul914sSVUOTbQmTh6zZfDeljp47Wuni80hgbAWJ6oTovNDvwgRKpALrKhknkRe+8lEFQZx
	eQrgZCdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfNb-00000006LqA-3a7r;
	Wed, 04 Nov 2026 18:06:35 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfNY-00000006Lor-2ybB
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 18:06:34 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so472444a12.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793815590; x=1794420390; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GRG5s9Ykm6gdotG16z6YfBmoncjsZwUpCfdfDleiz1Q=;
        b=LZB8bL3k4f2PY6Wajw0cdCw84KQg1zIXKcWPgqAuRxCGQqbncyNiaKsHuEhAWAOeWz
         fOFgt899wefTEUia91i2YbOT1i1lT3WoduCrv4fPkmAh9s3opRBu/Jvv7SsKczEOaGqE
         r2bmDRlXMGBAMo81QzE+ltbsYvkO/0nURMmd1bGZSosoaP23xm5jg/pUg+oGOdS5YIv4
         sRFIb752KSgIBl3WWZfScWxR9OjHD4fyDPBD8eybIBs+tLZu8YLHzQyjeJMKe7uuiYQ7
         w5Ig5eHik3KRrFaWIbKvSIULgV4OKRzsm6HooPqw766H/69+G96RvwsWCrZoK27oPnfr
         6yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815590; x=1794420390;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRG5s9Ykm6gdotG16z6YfBmoncjsZwUpCfdfDleiz1Q=;
        b=lamyGA0xrOc4dqU6aYIvsq4PFdOPyE9qCW0gf5jzoo+s+ZHEYNXFDBI8QROqunwgps
         Pso7aJTuyympTAZ8MbDLurRHoklh3pmKRl9wO/69iuXrLJZ8Ps/BeVOWcCSeDW0cF4rL
         P868VXocsdsVUwG23W7NHe6li3Kq8DbXvpHfztCya3Gt6tOCmYFuXwWBDyitk/BcL7NI
         9/8paFbQAZmUXfxahdrqFjwdGliEOS8YgJEpIcm9A4w1vnJJAZNvzNT0vAdQ6WNkm0Xv
         7kv636AfAV6mZgrHrKjP0YXl7sNWaXRXWr1s98PGFJc9nRk77RYfXQuhrvjJjhuHpKvY
         pgug==
X-Forwarded-Encrypted: i=1; AKwUvByuxjU4fZ4v8KT6atE0dwBgqHk6lcamwZPgQ74JX8BqLm7EjAxEtBzsLfTBsJKsVfpWYuyE5Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z89l/t8YRcv3TejOSfMtZZ5EgfANC1WrXqUBjz6+LokSxlJGcmN
	fy+BzIrCo/NVOopOE1G1cl9HELBGbgtzmI67Lu3IbwzAgiIMHY+cFr9tmt36qfFwAA==
X-Gm-Gg: AYBFou2a0HqYbytG+doA9MdxAz0H20v6YzIdE2nOIbZ0/79VJ2JI2eMvUJyx9CP5yF3
	jhCnpfOB7FpA5e3bSmkf5opVrbWXPhrAN6Wb1ESfw/nwl/GLtlb2ByBIOelmXwbeh6BGDA/7kIk
	alI+FG9wcs+i1UouwzK1mbyL/zd/er2uZFSYjEYNlZUopVwTHFyA4UuVNN9Zlq+UwTbh8kgfpaR
	ugVMOr1qeviFwUBfJmCnv66iFeuXK+AdlAbJWcNdc7LJGghghVIHBxz2ZVJPIH7fWyaWeNE3kK1
	TBdx6vYkiYrT7D94ycO/9fEAtLh0eoNKGCH4+Hpcjo5txvIeGIvaFb0ajRfR9VAOjCQOj/T0Itx
	WovnfAgEYNX/JH5CJ3A9fo8a9u1niGwGnBZH8Um8PUnmlnBUBKqJsUcNNSosoxzce29TmLt3ux/
	WOihwDwuGSqdM/5mQW+kjMCltzquEXokfIzxEtoaKmqH8jOtsrfRlPeKg+xWlfwkg0CErZbrpJg
	JDmrdc8pxnq33yul4hFS+48BuHu1szn87jhCm4elibQMsIe5y6C08vW0z4xjs2grD+JCn1adDCG
	iKM4TQKVbzHQt71cZGfok3C+lFCoN065tQWYBSmiu2vijI1thBdZbZSCIbOiIXBv
X-Received: by 2002:a17:90b:180d:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3ae8983f058mr13975312a91.46.1793815589132;
        Wed, 04 Nov 2026 10:06:29 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4694a0e0sm1481545a12.20.2026.11.04.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:06:27 -0800 (PST)
Date: Wed, 4 Nov 2026 18:06:23 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <aut0H65XKAHUqPR9@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <autxCZPJ9yiE2ucq@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <autxCZPJ9yiE2ucq@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_100632_756210_BE1EF4E2 
X-CRM114-Status: GOOD (  20.21  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 01:00 PM, Pasha Tatashin wrote:
> On 10-13 16:25, David Matlack wrote:
> > v10:
> >  - Save and restore the ACS Egress Control Vector along with the ACS
> >    Control register, sizing the save buffer from the HwInit Egress
> >    Control Vector Size field (Alex) and drop Bjorn's R-b tag
> >  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
> >    rather than adding the dependency later in the series (Pratyush,
> >    Mike)
> >  - Reword kernel-doc comments to read better in the HTML docs and
> >    spell out "reference count" (Mike)
> >  - Replace the version number at the start of struct pci_ser with
> >    required_flags and optional_flags, and record the size of struct
> >    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)
> 
> Hi Bjorn,
> 
> I am planning to target this series for the 7.5 merge window through the 
> liveupdate tree, as we previously agreed. However, there are still 6 
> patches that lack an Acked-by from you. I believe you might have 
> reviewed some of them before, but the tags were lost during subsequent 
> refactoring. Could you please take another look at the following to make 
> sure everything is in order for us to merge the series:
> 
> PCI: liveupdate: Set up FLB handler for the PCI core
> PCI: liveupdate: Track incoming preserved PCI devices
> PCI: liveupdate: Document driver binding responsibilities
> PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> PCI: Save and restore the ACS Control register and Egress Control Vector
> PCI: liveupdate: Adopt ACS controls in incoming preserved devices

Thanks Pasha. One more for Bjorn's list:

  [06/13] PCI: liveupdate: Preserve bus numbers during Live Update
          https://lore.kernel.org/linux-pci/20261013162529.1928093-7-dmatlack@google.com/

Bjorn's Reviewed-by on it was dropped in v9 when it changed materially
(albeit based on his feedback).

Alex, could you also take a look at the two ACS patches? 08 includes the
Egress Control Vector save/restore you asked for in v9.

  [08/13] PCI: Save and restore the ACS Control register and Egress Control Vector
          https://lore.kernel.org/linux-pci/20261013162529.1928093-9-dmatlack@google.com/
  [09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
          https://lore.kernel.org/linux-pci/20261013162529.1928093-10-dmatlack@google.com/

