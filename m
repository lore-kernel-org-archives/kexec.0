Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E2FC5DF94
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxE7O9ZFmLE9ZVAOicUw4dBWt6/MseNUe3p/fLErz18=; b=W0TiI7/ljRkR+ml919zahx4kxU
	dMq8+RvPC/WBtRCnzGZNgTQH/hAUBauKfLqY6hobNTrcGHN6HjxZwmSelxy0DABPsG02Vbo8cAzes
	EIkCe9ELenwTTsxQ7qxrbtvfUvFhPFLMPy2BQT9Io3AiqomdihRP8h2MO4Hfq7A6fD7G5H4qVY11k
	tDAjJ1kCiKkTQUJiVftTx8XorrV2NKLA6k6ALMFCpS80uwdmgKNRxzNySOQzI6qkVJ6AvgwnVdVoj
	O3tfvaFAn9BCXZFy0aBCUeSaEJ/TEsvJpHEegbFBsvMn6Q3d3XCT5j4g50a3Em2jyxyHig93xdj+o
	yMV3Gn9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUyC-0000000GimK-2cJ9;
	Mon, 24 Aug 2026 13:44:12 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUy8-0000000GilK-2cdF
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 13:44:09 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ccdf36f63dso158875ad.0
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579048; x=1788183848; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxE7O9ZFmLE9ZVAOicUw4dBWt6/MseNUe3p/fLErz18=;
        b=q+33jZjb45299AF6qp+hCKJV2c3deNgUrwz/rArkbZ6PVX4zSyeaRtlWfX8ql267jo
         bTdCwA7XJYhg42qbyf+3hkjFdSnUFyv0vYxHbsX4a/msY/sAPhjCOnPSWR8teJyXf4FE
         XtmN/soM4Y7QT1Zd8hugDVuYbARygPGbmK/Pl/ML2rrmUk5y1p34xDuGhgUAdrbIAI5a
         +A3MoexWX9PSL1qYpXrXqVYLDzlv2lqxRFiYlFVBmZnZu5PCHh3HtRM3Em6lrEllpBnR
         q0PF9cCVX9faz0ls+qLXXqsmY0m3wwqCvkAlTVmbsGE1lYp/dmD7T8mSmNmeR7rMePPw
         gI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579048; x=1788183848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxE7O9ZFmLE9ZVAOicUw4dBWt6/MseNUe3p/fLErz18=;
        b=XNB+olFjm+V3wnGRGdDqDvJqELncf9Dkg27NPVQs209KPxpBtxlvRmNPYNS0gjjOua
         usOTw7IfSdE3tJ08OQSbDZQTAfVGdVnf/ohqfSasIclblaEfgM9KJ5QGXma7ftsN5NFc
         Gk5LygSdkoCDXqxiznv7aOmfqrnc+AH5ddRSWbFR2XHlUgtZISe0oWpL+4dBkcRP3l/H
         gKeDVWhtKfxWrINORk7LQ6Ilg/Jtgqb6p0L2ISxXyl2PXW2bJaGZHmBZcnKkke0y/fus
         h9YcfCcZqj/Pzx0o1+22YxxNQIXqQ7HxiPFM2FSHNVeMmv3D+OOVPvy8gfTdujPrqFrW
         b0Dw==
X-Gm-Message-State: AFuF++kXfKuqvSlIA0om88t249lSSFQAhu8s2fVncbhnjn37ZvWTPJqX
	1y+Wv6RFjcjcqjAOwb1Zc0oMG1wz6HScW7sFCr6AwYpSQwNhFsL5Mdg8cwfMhtYhhw==
X-Gm-Gg: AR+sD10SI+65uDq7RJXMkc1ofG2tIu1xJ5khMDi0MzohoJnOlBWyb+rK7eCH871lg/t
	qIkIohBsmficP4IQHPPP8BywhmmUimiV++VPy8AUS2cHtdmwO80nQj6GOAdnBZbmIRcPVX6+BUe
	UXKZsCUCYMdObC6W0leR7+iO43eyniRYrqoMRkYuTZKXn9lS7+HBHeWz8Z7C97ztGUJU6O4wbMU
	roFQbICgw04K7cVeaj/V0RaQoZudIPO3KSiPrZ1z6KhlaGO032BiZAmG6NEgOENSQNJi1d66h6q
	A6ZhJJheOn9+mf7cB9ltoEXVlSnihvkLx3WzcRreoUeBerepr0P7vZADEl3OHVjgpOMTt8s6VLD
	0ggGaQGvEjMWxSfUA6vmhQlPaVD7Qz9F8M7kMUIPlfXf8X7wTwHpfcc5UUODeS6qIdZJq96N5UU
	rfgDRgx+uNM/xa4KYdFsa7uLMc6EOGdjHVGT5XYdtgUAfPlvb3eTHkkbobxvPL5eOLcLGy4mpdb
	WDM5tL1iJ3PVLOABpi8zl19Kg==
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id d9443c01a7336-2d673b9e9f2mr9511405ad.9.1787579047148;
        Mon, 24 Aug 2026 06:44:07 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676792e1fsm18085525ad.28.2026.08.24.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:44:06 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:43:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
Message-ID: <aoxKnSgUp0m625EX@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-10-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-10-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_064408_669403_90CF56ED 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jul 28, 2026 at 10:10:03PM +0000, David Matlack wrote:
> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

