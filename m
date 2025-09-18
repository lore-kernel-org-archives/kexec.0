Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0863CAC597
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbpgG0xzDyYfgotSXiIlnajj+xcL9QM94oPCfZKoeW4=; b=jkUrRy0Yb5OX41oEIL/NqRSzpK
	ZrrVP8HxRD2PE47w1ht8BDujRj9eI3jCvobuVpoQFzuA9Y5n6/tRIn2S3rdAix6OzRV1Nb8ztHXiG
	8fyBykXzeQDw7BEi/9ViWO/V0TLbTTyFKEvWW7n6xi0u1hidQOuHXqdn0A/x94QPKzkLxmQOliX0n
	kwtIAAgkM6d+I8GY/ZjcqcwaXURol9SpasQ0yyzXopij6YdKTkAF5bUGMHgP4clw0KRYV+wjW5Vcw
	eNhFNXZU6BS4OY8o3Pqce4v4xIi30gIyKglHN+cL4CzBV36zDqrdp8k7QSRhAn/s2X6DvvCnZvbk0
	rEasFLww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBzl-0000000H6FW-2tS8;
	Thu, 18 Sep 2025 10:36:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBzj-0000000H6FD-27EL
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 10:36:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C25F40A15;
	Thu, 18 Sep 2025 10:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64085C4CEE7;
	Thu, 18 Sep 2025 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191767;
	bh=mZX5B1t7YSBW9QkRnh+ZDz1Rd/PMlNLLBRIAPafjyqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fz/6zZL0PAGE1z0p2ms1Dh2wy28tKMl7oNKY8JwicGiteN5NCKn0g689nlEuCrbzb
	 NaKK560c/yH7EgZ7p5MM1Tr4LngKm2VDM0u8P36cmot9SSElPNKEf1K3sC5f0C6XUP
	 4SZ+RDR6NpLCbIAMdogqTjWvzm/XM9yY0k8hgLrGrx4gLYXe4X+tUq5TH324GFCPWT
	 /KfIS8vbv/qopXT9nsg+YSvPwJPkgJga3b6YKXSjcrvb6tdjvW5mEn7yG7CWPCWqIC
	 A/1eyl51xk4hfh9iJ0mRVLO3Zdbd9mSPn4gbJnga534wRGJpBuV3ic6sPSeACCNtNM
	 SIL79ex3q3z4w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] lib/test_kho: use kho_preserve_vmalloc instead
 of storing addresses in fdt
In-Reply-To: <20250917174033.3810435-5-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-5-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:36:04 +0200
Message-ID: <mafs0wm5wf3or.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_033607_559750_1B542B10 
X-CRM114-Status: UNSURE (   8.82  )
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

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> KHO test stores physical addresses of the preserved folios directly in
> fdt.
> Use kho_preserve_vmalloc() instead of it and kho_restore_vmalloc() to
> retrieve the addresses after kexec.
>
> This makes the test more scalable from one side and adds tests coverage
> for kho_preserve_vmalloc() from the other.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

