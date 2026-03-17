Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D7FF3381E
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLI/bZM+cSBD8wVwTESyfSKw+Jwsxjddwt/oR6H0SR0=; b=pYZouO/FkKyk0ue5oOY9TqcLWR
	Ki27MxcIftji8KKKrtLlHUBq535T4R/frNwzWrVet1CEiycQVO7BfW7G1IlhTFQZtHJZ+d0GDLwKj
	N3iqD/GaNnZFdcgnfmi+UoiMtSRMP4NX6ghnhMQzFkCAyxWdeVrvUTgmWVCAlboHl3qVAaf+BaGgs
	g0HVBcgb3I+Ml05T3DJy+hbhUAgv13tLx/ikoCxmPlPAwD5J8DO24ghUCwPyyw7dS9oDqApUJO4+I
	5bT401P0kxFfxBmKkT/Qj5ivKIoPPwJxts1QHAeapM/ki0DvpUOwoPHt62hb6lg6tc9OUKH67z/E5
	sk3fqhkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QTR-00000005omg-498U;
	Tue, 17 Mar 2026 09:12:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QTQ-00000005oll-0sDU
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 09:12:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 78CFC434DC;
	Tue, 17 Mar 2026 09:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B50C4CEF7;
	Tue, 17 Mar 2026 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738743;
	bh=mg1XRSjP0lyWKLduKNpAhmOLtj6KEMMUpquKvbP4yzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mCZgaD6KOl4NSTvradsDqu9gM/HxUVIdrWrJzFCG3NpmQRzxXB6cpFVf7i0XSNUsU
	 sBBhdtVC3l6lOJ6gKK9nyDiKxhm7+JhNmY3pMoBWtjsfFWPR3xt8E5iBfgXdibGoL6
	 C2d2zx/FUoHViLg4+OOcVbYNrXtg+72aw7pDXGnEsQ4xx72BH5L5eweQQB6EcMhZzC
	 jUjYJkPeMtkj26MK8yF35s38QTxuf9lHnHoAtlI+pgUyqBuI7YS8bc6UVDhWYF4tgn
	 0VrUCQIQtzOGZY4IS5H2EruN/PN4SICGCPHyUshAIx5ayU6jIV4J539TcrC3l2IFIa
	 Az3X55mxCQJ1g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: drop restriction on maximum page order
In-Reply-To: <aa_zglmh3AU2_RA0@kernel.org> (Mike Rapoport's message of "Tue,
	10 Mar 2026 12:33:38 +0200")
References: <20260309123410.382308-1-pratyush@kernel.org>
	<20260309123410.382308-2-pratyush@kernel.org>
	<aa_zglmh3AU2_RA0@kernel.org>
Date: Tue, 17 Mar 2026 09:12:19 +0000
Message-ID: <2vxzo6kmddl8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_021224_268719_87BE8A78 
X-CRM114-Status: GOOD (  12.20  )
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

On Tue, Mar 10 2026, Mike Rapoport wrote:

> On Mon, Mar 09, 2026 at 12:34:07PM +0000, Pratyush Yadav wrote:
>> KHO currently restricts the maximum order of a restored page to the
>> maximum order supported by the buddy allocator. While this works fine
>> for much of the data passed across kexec, it is possible to have pages
>> larger than MAX_PAGE_ORDER.
>> 
>> For one, it is possible to get a larger order when using
>> kho_preserve_pages() if the number of pages is large enough, since it
>> tries to combine multiple aligned 0-order preservations into one higher
>> order preservation.
>> 
>> For another, upcoming support for hugepages can have gigantic hugepages
>> being preserved over KHO.
>> 
>> There is no real reason for this limit. The KHO preservation machinery
>> can handle any page order. Remove this artificial restriction on max
>> page order.
>> 
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> One SOB should be enough ;-)

Hmm, I figured the unemployed me (who originally wrote the patch) and
the employed-by-google me (who is doing this new version) would count as
two separate entities and there should be a S-o-b for both.

Anyway, I am fine with dropping either one of the two.

>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

[...]

-- 
Regards,
Pratyush Yadav

