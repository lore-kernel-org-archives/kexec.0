Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484FDCD98F6
	for <kexec@archiver.kernel.org>; Thu, 18 Jun 2026 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4tEO25PqFz25pgHfhYt+Am1cv1s/x/3/gtnJ8i8EOSY=; b=rVn9+wpl+aLYzgCxy2lWgDaXbn
	zUPcVk1RWUR0sJkQpHnUAC+FDyr9k6Co82vP+s88TE0JBLuXlk7UTlvXoax/IoLozaWHfExuVPVEm
	7xhVTeuotdp1v/Jyyv7vR1i8SuedwAK3n2Z6CeaFmkoADSdvDUzkUiwShGZDRlqpiLVYLh/7KQDpe
	Koz6ZeHGO8euZCVaIgDIWk6+Zw/JCFC2kylrUx+s+VZ62pSf08FipJ5HbefkrZUdL0ikNofClgdNB
	lNx4sApHGCCSqwOEbIPH33MHnqNeJFblHe26towpKTOy4NCzRC4HdUbTBNgL7852D44JVmoDnPdZE
	w4MV1yiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waEyo-00000001VkT-3wNX;
	Thu, 18 Jun 2026 15:48:34 +0000
Received: from flow-b4-smtp.messagingengine.com ([202.12.124.139])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waEyi-00000001Vj5-3j1m;
	Thu, 18 Jun 2026 15:48:30 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 4628E1300A6D;
	Thu, 18 Jun 2026 11:48:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Jun 2026 11:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781797704; x=
	1781804904; bh=4tEO25PqFz25pgHfhYt+Am1cv1s/x/3/gtnJ8i8EOSY=; b=L
	davLJB1vDO89/q4tFIcyQELeUm9dzIjmUJ/Uf6ifSrchn9AAKiLumZr1Yd7byjl1
	4cW9GzN/lPdEg+7Qmp3OmgXLIHnJMzo8Fj+C8o3eV34mWgFPzqZXpyYRk++7iCCi
	SeNz/wUmi+ejw8lP5J+jZWcPsjw1v9DjRQd79p7o+Z31pmd/zbgtkocY7A5QPv8O
	80TMZulWnhx3b2moRaSzySgGnJZXaX0vJaP/Vli4hFgGOsOOtyDTLTG5hrKw7g40
	3u11kCsqy7bkSXoPfOP4UadvIzH8KAdDyiMqnTgHPLRq3SOx9HfZXnZVKHBH/527
	ISUFQaPnUIiTYP4xJDf2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781797704; x=1781804904; bh=4tEO25PqFz25pgHfhYt+Am1cv1s/x/3/gtn
	J8i8EOSY=; b=I5ZYv2kDbqdiKbxjY/prtAFdb9yldmfBUNgaPJ/QxQ2o/aAiUYm
	QFvSK11vs9X78i7WR2eZ993jL+tF/CSUSbpowzEQ6YWrVZuVtoixx4jJfp9hHkWo
	wXx8DLpA9tdWPSjpzH8KtECbHu+rthcCqU6l5NV4sPz19Atfd9wjQF1V76O6rYVF
	kr09KjxY2hrGGaT1Fer2dUt9asYodQxQiQf+/w28unbrzZg2byn5JXdjXjqmXZDA
	3t6JEh8AVM7WyTdGnZgp5lwfDFVuSGAXr4sCqMzAEey4b0GSSqad1gshs68IagMo
	ksATcAFJGtP7szJajeIIQWhzQ0bd5RVD3SQ==
X-ME-Sender: <xms:RxM0anQLiRUbDeVOtVvnD-9GAPRNvclRP-Jt_9J2nqXDds9uG4aHkQ>
    <xme:RxM0akdmlwf6QrhrQdcE0yiX33BKoiH_flZDNjeMiXtcTZ0_crSZQGqJzyNCZTOXh
    iQXSLXjr3IoUyVD5WM4lv76VLe9jK5mLEj5hmVlv2s6ChlUeXq5gXc>
X-ME-Received: <xmr:RxM0agf0Cdf4MxIBhMjTMeawu0vy-iqvGmzp44Vdm_OwC1iu06e_MQ0Fte9v5w>
X-ME-Proxy-Cause: dmFkZTGYvoDd5mRxF2GgZ/xYFR9CGSPnoKLLG3KNJBtsiI0jBANzy7IkD7/sUIekyF4Ivl
    uYePHgIvX6kC6VCNjxqFgRP5TtgWDzaP5fynvnLS9EVDesEgbbQB3eANlvPbd6Ro4515rC
    tvbBH2W8y6bH52vRCpNziIueOV4Q+DVfuCs11eNTpSY9ZfTGP/e189obW0SmOu1oaRVhWi
    zy648yFJJ2tjrfVMTmqc+mhtUmaAuLsdao/Qw90HEmpvYxzlEXT9GxwfNhKIJmUE7jAAKP
    Jbg4gHnVzyiimccfrjzHQHBxl9kuAqiXtLS/hd1bHqsZgrPn439/1jmAovUE7KKGOkbVde
    FvOgCwbPDcbODhYu2flUckSXxyClSKTqWpGoU8HeYKRC1txqW3rH5OIxPECJ2ZgW1J0Wtg
    Vn2gUK8QvCFA900fWeQRxhRs4UdOV+mKZ634Ukqf7gOAZC6cUB6XSqiNBn5RKU2ZIp881N
    LAziaYJSMbkH5UEaZwWZBNLHPkpfpn0z5bUw9F+gW7dvcdwY9+c7J8XNtplGnmvonasJVR
    x/ZwhaD6iTZ16WHr0A2Dfq97A8WMZ5vB1vYxsZ7xO1Vs8h27T9ZsLEkQ4yJvQk1iYqhCIK
    EDw8Foxv/NLeFhCZIxeXxpjP3f6qYuTh4U9zJfSNxwrxssYlJypWVTSESkfg
X-ME-Proxy: <xmx:RxM0anT_8HWKhgXTWE64dddEENLYnrAz6QniyyG3qHGrfIT7FDT96w>
    <xmx:RxM0auhBNb_2dALob9ej_DF3bGu_OGCh0kxhnXPxKztOMK4ertIJLg>
    <xmx:RxM0ajoh8qmQd27CToj84eicLETgR8EAia_eRbz535wYqFOBDIHrsA>
    <xmx:RxM0auPY-o5PxxqQu6dlQjVgAbjjL1eR9NRQXW0aWokKSbZp6Ee4rg>
    <xmx:SBM0alUhyGSpG5Npxpqo_L-pgFfDgLT4JuD_GSTxLYbI7rjeBfCfr-je>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:48:22 -0400 (EDT)
Date: Thu, 18 Jun 2026 16:48:21 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Julian Braha <julianbraha@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] drivers/firmware: add SDEI cross-CPU NMI service
 for arm64
Message-ID: <ajQTC3onU0SswJOt@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <cover.1781709543.git.kas@kernel.org>
 <ab745689c0bfd01438d98ed1c79328bf2121be3b.1781709543.git.kas@kernel.org>
 <a372e209-fbf9-417f-ad08-226cb7025949@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a372e209-fbf9-417f-ad08-226cb7025949@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_084829_238425_525D7692 
X-CRM114-Status: GOOD (  11.75  )
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

On Thu, Jun 18, 2026 at 11:46:12AM +0100, Julian Braha wrote:
> Hi Kiryl,
> 
> On 6/17/26 20:20, Kiryl Shutsemau wrote:
> 
> > +config ARM_SDEI_NMI
> > +	bool "SDEI-based cross-CPU NMI service (arm64)"
> > +	depends on ARM64 && ARM_SDE_INTERFACE
> The dependency on ARM64 is redundant here since you already have the
> dependency on ARM_SDE_INTERFACE.

Fair. Will remove ARM64 in the next version.

> Maybe a comment instead, though I think
> it's pretty clear from the prompt...

I don't think the comment would contribute much value.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

