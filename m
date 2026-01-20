Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B55D26284
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGSkGElZi1cLOojEet4P0f949OnKsvKzNEf/YSqlH4s=; b=cG+2boJBD2lp6te7Kb19qMY4F4
	U3MtbXnZZHsMl4jjcrMUIWQODV3zwRvK7hU6qojZTFPx73o0SHsD5ebFpYpn51kkvA6WulosOwOWG
	keszyNapJYZQEMtHo4WSMVflGnowrJfh10YTfN7bGBy0DNfCtIntdLKj7/dhxtWYXJW5WZJW+Y7ls
	9G9guPVBS9hJjHxWEvh5U2+nX2TZ4Ax+ih24/ARejdp4Ddhm9wz84l3A69eHJQwpnwBYJq17/KFeu
	m1F8g61b904Exqv7aMp44aABeJwgaaQBJQhHN6SZ3q83jsDuIV56ajmAfGxG6Fn6ZqepdMurrJ2AJ
	D4nNfonQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGiD-00000004JfX-1ln3;
	Tue, 20 Jan 2026 18:44:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGi8-00000004JfC-2uPZ
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:44:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 11AB443D4E;
	Tue, 20 Jan 2026 18:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965E4C16AAE;
	Tue, 20 Jan 2026 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934655;
	bh=+LEXTeoZdMHLGFiNXxSwJZf0gVNOtmF4IeqOGsRfK6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rfna6mHD2LRS7oTOemBIwJdZafQvXxTBtjtJzov0cI2eTcGpPOxG9WzD6132eCHP7
	 x9MV32MZI4jUaUJTgYTtDbBBV8NGFpQtkeIrRss0itkOoX+8rlieEhajWmM/qOzj17
	 amnNjFssKpPSpgx1kz0SfcUbuZDuCj2rqAFs2zmDKUmSGo25kf19/PE4WuwHaKjcqd
	 WAqLKOUi9ZOnLtdx7VUJJ6x/o/1T1d1go3OlbaRW0W+ZMgLMCFzxk6WMbUYL3YNAps
	 vh5SGjE8mhhzYLZtfsTncHoQIshzuWqT3upKMLuEZd/uFM4y1DkE1uD0IrGoFzBmmY
	 KnJq9N5FZYICQ==
Date: Tue, 20 Jan 2026 20:44:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/6] kho/abi: add memblock ABI header
Message-ID: <aW_M-HYZzx5SkbnZ@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
 <20260105165839.285270-7-rppt@kernel.org>
 <2vxzqzrkckkv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzqzrkckkv.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_104416_759928_89E41D62 
X-CRM114-Status: GOOD (  13.20  )
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

On Tue, Jan 20, 2026 at 04:31:12PM +0000, Pratyush Yadav wrote:
> On Mon, Jan 05 2026, Mike Rapoport wrote:
> 
> > + * reserved_mem node:
> > + *   These nodes describe all reserve_mem regions.
> > + *
> 
> I think you should also mention that the name of the node is the name of
> the map.

@Andrew, can you please add this as a fixup:

diff --git a/include/linux/kho/abi/memblock.h b/include/linux/kho/abi/memblock.h
index fbfb2eb1b1cf..27b042f470e1 100644
--- a/include/linux/kho/abi/memblock.h
+++ b/include/linux/kho/abi/memblock.h
@@ -45,7 +45,8 @@
  *     Identifies the overall memblock ABI version.
  *
  * reserved_mem node:
- *   These nodes describe all reserve_mem regions.
+ *   These nodes describe all reserve_mem regions. The node name is the name
+ *   defined by the user for a reserve_mem region.
  *
  *   - compatible: "reserve-mem-v1"
  *
 
> Other than this,
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thanks!
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

