Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113DCD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 05:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e129xfl2uwbBORZTKnJ3i22zjcF3b+7zkkUcuJrSRlM=; b=tNrASsdLrmcNvKyYV293ffa7oM
	8kVZG9cCT363jCXtoSgIxZW+hhf+3fEW+aG7n4YLzZc7eQBvcEvYSQ392bzMEfM12wjU4lTcQJ8ey
	1b8JE42XbYDgeNebMHzIzRPebrzIT9K2XFYlncoelgDHsagOxYPbryZz/UPt5yUOk/ls0+GLsklWw
	HgMsrQKTCGlQByRTvyRY9eMIN6kKz6rdo4xUimuZ8dmFacy6MtNujjveyj3xV1Qg+ylY5yBuwLv7/
	/BsY5TrYIHUMUCPYRd0L4FeFH9tH6m9HF1i1xAeniltJvyS0dy9jQkJm1sFTW99eqWh63S8NfpNBn
	3yH5cUBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTull-0000000A8Vh-2nvM;
	Mon, 01 Jun 2026 05:00:57 +0000
Received: from out-182.mta0.migadu.com ([91.218.175.182])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTulj-0000000A8UT-0nQ8
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 05:00:56 +0000
Date: Mon, 1 Jun 2026 13:00:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780290042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e129xfl2uwbBORZTKnJ3i22zjcF3b+7zkkUcuJrSRlM=;
	b=jK8M9tTSYsgWEa+miw8zUAseNoC+gbcuCv9nUMAsDdJneXEMD6zUH9KN3eu6lVTxSHEXW2
	hSHndFlGvSyxQ7zV+0TKSQTKSS3hHU6muR0MeW7qGoat01tQoLxr28BDKQvwXidIPuZNdp
	eGw38CLTieSZYcpODkiAlFiju9A6r0w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Wandun Chen <chenwandun1@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 09/11] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
Message-ID: <ah0R8pEIyuk4N2Is@MiWiFi-R3L-srv>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-10-chenwandun1@gmail.com>
 <ahmr-UjoApj2j5JS@willie-the-truck>
 <ahsPcv8G1BR9rLah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahsPcv8G1BR9rLah@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_220055_389992_3436375F 
X-CRM114-Status: UNSURE (   9.64  )
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

On 05/30/26 at 07:25pm, Mike Rapoport wrote:
> On Fri, May 29, 2026 at 04:08:41PM +0100, Will Deacon wrote:
> > On Wed, May 27, 2026 at 11:29:15AM +0800, Wandun Chen wrote:
...snip...
> There are patches that move common code to kernel/crash_core.c:
> 
> https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com
>  
> Review from arch maintainers would be helpful there ;-)

Before, Andrew would put patch candidates into his mm tree and trigger
testing. If any adjustment, he would take them off. Can we do the
similar thing for kexec/kdump patches, unless the patches are objected
explicitly?

Thanks
Baoquan

