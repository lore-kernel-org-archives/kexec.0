Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91270C369B9
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XD4NsjIFCyd8Ex529NDCunOYWuzACOtjmPfQb41hkJg=; b=nxRW0kqsRdKrnvxNFfx0E/fvLF
	6GodbOl3UaEr3iJAcD3gXcdzRHIlPsTbIQ40TJ35Rb39mL/Sm9IV1khRd4IdZd+Y2PHlK7CbX/Y3l
	3A0KLEHYSXMtSZ4FoRBL79jF0Ss9MvoBqLiuIEilpk4QPO4z/iVzZxuK8GpYZRc6VggJfCuqUs5M1
	UFw4FrjXaMDVGsJ/VA/IlAJrO7nOToIUnI+yFIVL3OkNPdUoysRHL9SVHx2y7t23mTkK0TkCvioQC
	Q3rDgJ1CjtPiDY7tpMQkyvo+Q8cjuW22K86BiEVHE8utDQwbNySxzrWl0qTVwSWroj3Tlu7ulgQg/
	xVD8uJJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJS-000000017VO-1AAT;
	Mon, 14 Apr 2025 08:37:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Quq-00000006bUt-3X2t;
	Wed, 09 Apr 2025 08:36:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A2F36A49875;
	Wed,  9 Apr 2025 08:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D8EC4CEE3;
	Wed,  9 Apr 2025 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744187771;
	bh=AjITk3Md+AG+a9nq5/1M/7k+M+xWBDNKTQp+Pam8Qec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxl4EkcTYBvpu02SHiv4NYKjhRHuI1QV1VXtqxPQ6xmZhA9y0GaGbXlIT3hyEO7S7
	 5viRVWZH4JiIx/RIg+ayZEQEhaWtFgahx62A+n8kZ4DU/nRT9mIhBjmCPfoY4hZ+Yf
	 +4RAFEBv3UpOO5m4cOfJTXaDBDL8ygyC6Du55rytLyi2dvoGXmwMRTZEir/CqwlA62
	 IbcINznr+djTduj1Sy8XSTZEaHL6tM9ze/2nO6qrmacw1KrIyPMyWeKZ1S/vhd1ywP
	 et0eFpvt+49XTr2LuywdEfwAr8kc3vv2m5q6Mxv+lnvokkoxZkglhy0D/BNkW0rWmR
	 ZOpPouY0e55uQ==
Date: Wed, 9 Apr 2025 11:35:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z_Yxa7fTA70YEe84@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs01pu9qm6r.fsf@amazon.de>
 <20250403161001.GG342109@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403161001.GG342109@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_013612_938614_910ECDE0 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Thu, Apr 03, 2025 at 01:10:01PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 03, 2025 at 03:50:04PM +0000, Pratyush Yadav wrote:
> 
> > +struct kho_mem_track {
> > +	/* Points to L4 KHOMEM descriptor, each order gets its own table. */
> > +	struct xarray orders;
> > +};
> 
> I think it would be easy to add a 5th level and just use bits 63:57 as
> a 6 bit order. Then you don't need all this stuff either.

Even 4 levels won't work with 16K and 64K pages.
To use tables we'd need to scale the number of levels based on PAGE_SIZE.
 
> Jason

-- 
Sincerely yours,
Mike.

