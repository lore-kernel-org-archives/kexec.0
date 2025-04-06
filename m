Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E47EC369BA
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PoKYFZojw/fxAM21aM9B8uqhKJ0oYEpyYHaTcaEMkY=; b=phq81gvU4YsRMA1YDCoUv/Tqnj
	EPgLl21a287qpQpel0+VtF5cGidJ0qAW3PnxRb2+3LCAbfEGizSyWC9pRLuXr283LPCrp+qf7IYPb
	mSwp4qWaI5Z3oE7xjsKIBqOB51HVOlW3hb9uCMNqkiaqajU9LE1LFxrVsYOhgbyD4BzLFUf2uhn7F
	aOzzN2saKJJLwH6nv/vOYXiyREd9pUjPnumDsk5hnzUUq/R43GXyZqL4MBxsKjp7rdKciAOpS0wZ1
	o2fGOj99jDUSPQEEF/bL0VF/tkXfl4+pkF1GNtnYSheuwsStNbZmkUpLFXZk9vAbB7Pacr7t8D7n8
	hETWOuxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJO-000000017On-0jEA;
	Mon, 14 Apr 2025 08:37:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1Scr-0000000FX5P-0FaT;
	Sun, 06 Apr 2025 16:13:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADF4660010;
	Sun,  6 Apr 2025 16:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D958C4CEE3;
	Sun,  6 Apr 2025 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743956015;
	bh=W0OMGEKRCIzqIrkZA9af/iDCd9Ojc329+ipStkNg+2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVL649jauEKYI4l+zYBSX7ppwy6IT04RV3unP/HxPdVIchTz9J7xinl7ighu53XJc
	 VInujhiYAW68CGsOaP8QA3dL8s/ECb6HJYdDLnKaEh8XCMv1JCLAVpujC3668IHOXT
	 jMy1/loS0VOWzECX6bTjCZin36JS3TKm1zBHmWiIee7BwnDJGcozLzX0IAXquRbBuu
	 engWpzJT15+C+mpkMxWTg3sLPTx5bTToRcsXa/K8RxtmsRJzxyxBDSm2Kg1A5m1Mvx
	 FAV+YRjrpYEr6Sooj9ZzL6hh7r4S4m+SWRgQ9AXjP+eUXOAWs/Mu8eErqLF6D4bfBn
	 Ji+To1URvuL+w==
Date: Sun, 6 Apr 2025 19:13:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Changyuan Lyu <changyuanl@google.com>,
	linux-kernel@vger.kernel.org, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
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
Message-ID: <Z_KoHxDLzrzQAjhK@kernel.org>
References: <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <mafs08qofq4h5.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs08qofq4h5.fsf@amazon.de>
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

On Fri, Apr 04, 2025 at 04:24:54PM +0000, Pratyush Yadav wrote:
> On Fri, Apr 04 2025, Jason Gunthorpe wrote:
> >
> > I'm pretty sure this is going to be the best performance path, but I
> > have no idea how invasive it would be to the buddy alloactor to make
> > it work.
> 
> I don't imagine it would be that invasive TBH. memblock_free_pages()
> already checks for kmsan_memblock_free_pages() or
> early_page_initialised(), it can also check for kho_page() just as
> easily.

And how does it help us? 

> -- 
> Regards,
> Pratyush Yadav
> 

-- 
Sincerely yours,
Mike.

