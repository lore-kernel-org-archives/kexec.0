Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7355FEFB6E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8o0TeKupqWBpq050X2z2KjPSahNrCwyfHa+2hao158=; b=cKvcoA+PQPHQj40tkJBj/9MEF/
	eEqGYekirXaTeX+8Kj8K06ruS6c1twgyQ/wksj5CsBhlEPbIfe1darssbiJnJzglO33QGETVBtpxb
	j/zU65q/Lnr+5xB2yq63ah8g2Ewb28bhjDwbXM0jaDp2KagoxF0o1Oel1loc/oR6nMcVPC0zuYMuc
	f5sB2KhchgLhxpJPGW6EuIMx7MvFn4E1fIIaE2IcRTUpUczRNFPSYPfnRaT+pBJxKb/1cfut30Yvi
	DT3RjcmbEAKgn0QmeH+esbfh0CmVVKjLJsqLnr3t3js5iI1JVANxg6h1qNX/O5l2u345eFK/ifV3a
	eg6MaxNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0li-00000008jmI-0YJ8;
	Fri, 27 Feb 2026 16:32:46 +0000
Received: from flow-b1-smtp.messagingengine.com ([202.12.124.136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0lf-00000008jly-2sJm
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 16:32:45 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 471F51300DDC;
	Fri, 27 Feb 2026 11:32:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 11:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772209960;
	 x=1772217160; bh=U8o0TeKupqWBpq050X2z2KjPSahNrCwyfHa+2hao158=; b=
	UvJQORvM3WSu1z7xDhvqaxf9hC6sa76YjMz/scZXjdy/L6YljiwPnaTuJ30TFex8
	PNntGEmwaqA+vIv0O+jRj4gyQ4JqJiAsTjaCPr1D9eoxzBb0MdI4dA9c8o/Z5v2S
	Q7gv4UM6c872LJRvs3yM96dYLdxOWYtX0T8q8F/WO51S2yri1/DKv0Rsi/6k4StV
	SJOkAcVzvRHWFuj8vjnWS4vJHiStYc2ycYxTaeRSSSYtEoMXjoX8B8uPGH7gahuN
	Wlz80WBR9iQTvIHWdFYAGZGJtbk21w+DNatLmEZw1qds3V2G/xe8GUqfcxC3fgKg
	fXkztxWj7Y0GgGnzi73A1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772209960; x=
	1772217160; bh=U8o0TeKupqWBpq050X2z2KjPSahNrCwyfHa+2hao158=; b=h
	DQJW6C9ZQsl+cSxSNqXEkYgt1MeeXA/LF+V/Q0vonxd/ZtKg+svWyiVt8Z0aQ9Gb
	oG0Z/DkH/k6F1SsBn4/xRb6V4mz8s20F0k0/F37P0D3aX3UnJAmUZGWONhKWbGHr
	QWgpqzs4CKH2WOJGvtuwZ5MDZGVF0YFNKXQtuIGYlbYDYu5u+xbmjDrbHTQOpYZ+
	JjbPTUa78tPkuJUWrdp9YRAKRCZXuL57/vIzkXCJbPky9cyeiKEwz6BQfcyR5LPy
	ns6iQ0WzaR1UssEeqJpnlymBANVKyhfpBExBaSeb0L6E8p7sLgfPncAbGLZ6auM0
	bwTM1Qb4qg6OGApznwbPw==
X-ME-Sender: <xms:J8ehafZlsZOjc3_GLRFi4h5tWZ_j39o91QnUDyRJrItDzcwi7KraSA>
    <xme:J8ehacD4oLMaXgiufHOx7RuNmUZ2KcT58IQXmnadBxkzX7loWOuT_Faz9z10-R47c
    s_mMj9iSe2a56NsAIHTwW5eXMvsyKiSrrmFI4cRQULuNzzQFJSrFQ>
X-ME-Received: <xmr:J8ehaXgvfUMoIDFx1-N0_S2LZI5xIUBVR4hia4g9tz0jTB1PQar5sxgb1Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeeftdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegkeejhedvtdelledvvdekuefgieelgeeuleevhffghffggffhjefhfeeh
    ueffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghj
    rgihrggthhgrnhgurhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgrhgrfhesrg
    hmrgiiohhnrdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghp
    thhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghkphhmse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrnhhkihhtrges
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtg
    homh
X-ME-Proxy: <xmx:J8ehaZQZcL6lZPF1tlS2vXNQrO4J8CAoDaz7yWMPTyzWglyUwjBO5g>
    <xmx:J8ehaZsrct2tN8zKyTrWREhB4jzHQ_Fv2oAmSJc4BikE_AF4Xj42xg>
    <xmx:J8ehaT_vdDuQ_DgLxEW0346_iNl-iCv0_xBOZodxKDVm2Tf1CiGErw>
    <xmx:J8ehaVYG6UTWYipiljkmMYLzXh80DAKiM45iJealDLXXbTVMK8PklA>
    <xmx:KMehaZfMe4KUyMFYKfHfXG7vObZA_yiAuEBY2xndXJSajNdx2KREBiW2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 11:32:35 -0500 (EST)
Date: Fri, 27 Feb 2026 09:32:33 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
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
 =?UTF-8?B?TWlj?= =?UTF-8?B?aGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>,
 Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, alex@shazbot.org
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <20260227093233.45891424@shazbot.org>
In-Reply-To: <aZ-TrC8P0tLYhxXO@google.com>
References: <20260129212510.967611-3-dmatlack@google.com>
	<20260225224651.GA3711085@bhelgaas>
	<aZ-TrC8P0tLYhxXO@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_083244_155036_C0BF150F 
X-CRM114-Status: GOOD (  16.74  )
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

On Thu, 26 Feb 2026 00:28:28 +0000
David Matlack <dmatlack@google.com> wrote:
> > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > > +{
> > > +	struct pci_dev *dev = NULL;
> > > +	int max_nr_devices = 0;
> > > +	struct pci_ser *ser;
> > > +	unsigned long size;
> > > +
> > > +	for_each_pci_dev(dev)
> > > +		max_nr_devices++;  
> > 
> > How is this protected against hotplug?  
> 
> Pranjal raised this as well. Here was my reply:
> 
> .  Yes, it's possible to run out space to preserve devices if devices are
> .  hot-plugged and then preserved. But I think it's better to defer
> .  handling such a use-case exists (unless you see an obvious simple
> .  solution). So far I am not seeing preserving hot-plugged devices
> .  across Live Update as a high priority use-case to support.
> 
> I am going to add a comment here in the next revision to clarify that.
> I will also add a comment clarifying why this code doesn't bother to
> account for VFs created after this call (preserving VFs are explicitly
> disallowed to be preserved in this patch since they require additional
> support).

TBH, without SR-IOV support and some examples of in-kernel PF
preservation in support of vfio-pci VFs, it seems like this only
supports a very niche use case.  I expect the majority of vfio-pci
devices are VFs and I don't think we want to present a solution where
the requirement is to move the PF driver to userspace.  It's not clear,
for example, how we can have vfio-pci variant drivers relying on
in-kernel channels to PF drivers to support migration in this model.
Thanks,

Alex

