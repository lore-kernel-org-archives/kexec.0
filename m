Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBECC36014
	for <kexec@archiver.kernel.org>; Thu,  3 Apr 2025 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7nTgTP3NXOGE1VcUlyux+afCSP2rmTQen+lpws4idg=; b=O6H+nSHfd11Jp02RBW1pmYJqLw
	NH8FQDBNCPsDDGlSaoEgt3nKigE5/Q8hdHLwfEDm3BQjon3cG/w+hakruiwp26GKC9AuiKa8eKmfZ
	DrsuZyXniqeYTEsTxtRt6FF5ieZiKHBznssntR1tBV+r5zrtfG7RiP4KmSJp1zSKNpwJEy+6q7RDf
	+GOpoM+g+KjjJGsa+hgraBjmtw6P/aLZEf0MbMjDHgJxt1RPaqZ6PVoSiffLEUinNqcy4PobeFDDw
	ZzgJFXX1LwscALMJX0ard30xKgR6ue1uBZS/ud2J945DLaUvA1lbnxnBaKznn/K/IdqvuUW1GAnCR
	TD6vc3Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Sbw-0000000AEiY-42LJ;
	Thu, 03 Apr 2025 22:00:32 +0000
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Sbu-0000000AEhd-09b9
	for kexec@lists.infradead.org;
	Thu, 03 Apr 2025 22:00:31 +0000
Date: Fri, 4 Apr 2025 00:00:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743717627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7nTgTP3NXOGE1VcUlyux+afCSP2rmTQen+lpws4idg=;
	b=pIKlnPAD49IT9newoKNv2EugDGyKrmm3GRZWVHdONQQtFQnhhEeZHDy8ng2S54Gsq2l7kW
	S17+FPbKs+SWNcpfvCApNNXj2BzBV/E790l5A3L37pXVr1rtk5WmopP/jZvpm2ZV6T2M+7
	tONLvKp7muaBoz7VWw3UMpoGHLg6H3ikKkka2dG5v7F+elDAVs4xYJRyKh/zANFupgyOZw
	iPrm0z0mORJrP9iZrtwj4Cv3JofzVEEmgc5sh0h2yHquEgQhCnkjtLstlHuTsJDXyJIRnT
	kpT1cenc2RwUCkBFeqDq1wQoSm1OG3evlAnDV/mcRJmCd2P55lpy2qFhJwZSRA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: msizanoen <msizanoen@qtmlabs.xyz>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-8E-LLs1dFWfn6J@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_150030_213462_0AAD89E3 
X-CRM114-Status: UNSURE (   8.00  )
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

On 2025-04-01 19:59 +0700, msizanoen wrote:
> [snip]
> It seems like `e820__register_nosave_regions` is erroneously marking some
> kernel memory as nosave in the presence of sub-page e820 regions. In theory
> backporting
> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ should
> be sufficient to avoid this but a fix for the actual root cause is
> preferred.

When using kexec_file_load, this patch series fixes the issue not only
in theory but also in practice.
But the issue with kexec_load (see
https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
), which might be related, is not fixed.

