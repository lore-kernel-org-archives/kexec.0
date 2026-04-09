Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F07FF31E22
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDMMuMjkCH/zvpm/wBiiLnM4NhgXDlBnFuaba8hq630=; b=GeJ0tgPG1W6QwW6CLk+/ZSmjQW
	v65Foy7vf+56ojb5Fwy15/gDoY945a1ew1V/6xvwJAd72+Nj6Sx0x8ykgXpeWGrxPf6tojvxOm948
	cKZ72ZL06k2mMd2gvVToUS47UzEvu6S+ndPqF+1cbAidLEIESG0tRdPtw0+zM8CLp/tLxdovSQnxQ
	YXiQw6W+BGWch99em+EcAjyfGJXFdd4vu252t0Yxn+XonrVVOLtmZ/VuYGyTuxwH9myq98UXMQnYt
	abevL/+PwECSsBwQ1RNLsTmWul3eIH6fGmc/w9ZuXcSs9xTTGDjboNjmTAY6BVnTWyPzlDwSa/I2m
	FsiO7upg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqKi-0000000AhRs-12JL;
	Thu, 09 Apr 2026 14:26:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqKY-0000000AhRJ-2JZc
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 14:26:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B35BD60120;
	Thu,  9 Apr 2026 14:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B25C4CEF7;
	Thu,  9 Apr 2026 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744761;
	bh=fu+LIzuUi5owsNa6jgIR1Y2IJXiqfxhvVZVLMHNlvzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyOQ2NedlinVaantTOIWp8Mbve3ID4oXOIpjPPLyzN8e9mYyxAx+aND1P7Va31kC5
	 l7CNesPCXFHnVMyvRwV0lYPoJl3gdQuBpGZIRXG2NCgT62eQuF9NkK72rDMQAUBrIq
	 i+dpZCmEeSgu5exbmRjV5nCCsWY3mWtT8Wdaywa+x/tX67bl/kuqg+BpApFljIYpAb
	 hexJ54xSDFSPBtrh4UIr6MUgzWj9XCed2mgh34JZilViP6jLAfi8ieWZEB037RKqQX
	 7wuyjFpF7flx11azbTJ63ioEUUirWYVTJnykqa0SfqA6hhdaeIjLviKXG4RFYxfANy
	 rxfNOl66xintQ==
Date: Thu, 9 Apr 2026 17:25:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] kho: fix error handling in kho_add_subtree()
Message-ID: <ade28zxgU8gLofnB@kernel.org>
References: <20260407-kho_fix_send-v1-1-b21977feb960@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-kho_fix_send-v1-1-b21977feb960@debian.org>
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

On Tue, Apr 07, 2026 at 10:01:47AM -0700, Breno Leitao wrote:
> Fix two error handling issues in kho_add_subtree(), where it doesn't
> handle the error path correctly.
> 
> 1. If fdt_setprop() fails after the subnode has been created, the
>    subnode is not removed. This leaves an incomplete node in the FDT
>    (missing "preserved-data" or "blob-size" properties).
> 
> 2. The fdt_setprop() return value (an FDT error code) is stored
>    directly in err and returned to the caller, which expects -errno.
> 
> Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
> out_del_node label that removes the subnode on failure, and only setting
> err = 0 on the success path, otherwise returning -ENOMEM (instead of
> FDT_ERR_ errors that would come from fdt_setprop).
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

-- 
Sincerely yours,
Mike.

