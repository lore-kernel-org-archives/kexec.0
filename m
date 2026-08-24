Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A93C5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 20:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RLVkVU6ts+TGH9dPTmESJlrY5y1GivISoEDjr8mjxtQ=; b=2owxLcI16m+M381dnZRx3b8PL3
	tEFWUeivEJhbx6WQmGI4WjtS8yF29pP9CXLWOkSLpawmNSyN+7LyMrJqv/sxAbSUFS2SGYyzDJrfA
	tU8ygrf7oVsw7QVPM0jpZjyI3OffNtS1ID1obJ/X8MY3ZzwMEaenFnS/9ngi2O+5uzWTG3+slrdA7
	5eT8gQVb3nSl8M/fKbyXyD5/UmtVv/GQChihstyRR1TGPxAMHIJ5mMWBzqRF+5PcevoiIWfEItISr
	yBzM9HqvSNyfuL1hM002a0qZH1VXacvh54+kAuUgQbkL+gVOE8+g8MrDHVefJmw1oB8fb8X8Qv38w
	oLR9LaZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyarl-0000000HKzD-1lGT;
	Mon, 24 Aug 2026 20:01:57 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyari-0000000HKyp-2GYg
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 20:01:55 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cede6375caso34175ad.0
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787601713; x=1788206513; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RLVkVU6ts+TGH9dPTmESJlrY5y1GivISoEDjr8mjxtQ=;
        b=UanKfurzg/fGrTHRPHQdQZsKVaGRd2H5tfDUGRchd82fJhY0SKiDbwaFu6DP7YknrK
         ZjmggFI2P8/5Pr1q0a64XCSlGDjq8PN+i2QYPAo9NgKZd1kgZmb/kp13L05uU+q9INWi
         uLfG6k0+KmjG1EY7DRTdplVjva5/v4nNJo+3BWJE5PE/wC4RyNAjoTokQv5lJ4v9I65W
         MfTYnKfEV+HlVWScUfSTThAqs6omStK5Gs1XyFa4+2F01TEkvTdiVSt5OrySSrgZm47M
         KkmHfUUpIslbxPNFc8kz1o/Ev02PMYkoum00HLds2g0ZJ36bN/qWMzC+DcSMJBIYG9Fh
         1AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601713; x=1788206513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLVkVU6ts+TGH9dPTmESJlrY5y1GivISoEDjr8mjxtQ=;
        b=hLcji3aOh/RFgCCd0mYWk+itM94qqLfFz4w4M1N1gwBq7du41bPBL11lfIJ9QVsm28
         m8ImM7RGP0iyya1lEyKX81bbF3RofYk/1gkDdwTG/bdYuLcuv1PkuXLnMh8wjnGXJE2G
         TwtuR6EI+qv/MC5IWzdJvzJkvlBwTbQbTz801OCE+Rd0jkbSHLmTb9UkcS7uZebGygXz
         8Ej/pvUeqqBt5EzYZ9+7pBZwC45FbXoQquPVG3xoY95rAceTiHcJzbGAhaRP2L3+FYDp
         QXeQCuEfTWJIqTquziN+wsvD2b1iNzXURvSpW4TsDJomREDVa+tUeqfjKrj1F9hKnPIA
         Ns4A==
X-Gm-Message-State: AFuF++lUnH+9iyMJwYOQSdACIOOLVbHrBZMKuARdHF4qoiY0xmoDd2Na
	ENEJaQvHP2srgjOjmKnH7WkpY9ZUStw0qrEAtWMMcoaY1kClw7F9eKLCCd05U+QzZQ==
X-Gm-Gg: AR+sD13OKfErpBmal1zLsumJAg0SdqYZFpY8igXBCXqJeIhGNa7Ut4zY6WcoSexg8F9
	f05g3E9j2rQey6ku1Vlya9aQM2dCtxXx04Fm3mISZIpNsFJ/WBHo0yaT3IYpzxdKPYou+Q+RqW4
	MQKOK2iClAiM4E8vgacveR57kjYvIpUJTiEW2YLfDMa/uSrrd90Z533f+llubkrcPNjJVhTNa1S
	HtWUloP+e4cAeqzLmYnDF/BwQGuFDTErup66wjJZ7RX1XtE4utTwgLIA56NyenNcrYvewrD0CuG
	yCgFEJb7DIA13+S+0qaEsLnK7X9FMZmvulHRA2GLNdsl8xG6CYtrdT/pNO7ymF79bFfi/U+Hrgg
	u/8XR+v7PnCn1Rj+XvoN1QFaBmTS+i1tEQXbOBan5FRb9D3J9o0rNmKSZJ8vg8VGhlxXiIYo+8T
	+FrRVohFI/zHnPTNRRmCZL5RxJcfiYj2PvoEF/spccV1TeCyOIFk9Z98Z1nz/mJQ8iF+A3ZlaLb
	EjsA1hQ8vjuRzhqQ2ITS34ptP6ffU1mBkXXBTK50ePxAdLIMQaiQusV5lE=
X-Received: by 2002:a17:903:2f8f:b0:2d6:3c22:994e with SMTP id d9443c01a7336-2d6e083547bmr879725ad.11.1787601712132;
        Mon, 24 Aug 2026 13:01:52 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef2ffdcsm2379917b3a.25.2026.08.24.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:01:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:01:44 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 12/12] Documentation: PCI: Add documentation for Live
 Update
Message-ID: <aoyjEftPTSs8GDvo@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-13-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-13-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_130154_607672_B29DB3B7 
X-CRM114-Status: GOOD (  10.98  )
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

On Tue, Jul 28, 2026 at 10:10:06PM +0000, David Matlack wrote:
>Add documentation files for the PCI subsystem's participation in Live
>Update.
>
>These documentation files are generated from the kernel-doc comments
>in the PCI Live Update source code. They describe the File-Lifecycle
>Bound (FLB) API, the device tracking API, and the specific policies
>applied to preserved devices (such as bus number inheritance and bus
>mastering preservation).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> Documentation/PCI/index.rst           |  1 +
> Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
> Documentation/core-api/liveupdate.rst |  1 +
> MAINTAINERS                           |  1 +
> 4 files changed, 38 insertions(+)
> create mode 100644 Documentation/PCI/liveupdate.rst
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

