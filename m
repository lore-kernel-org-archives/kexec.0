Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E45E606A33B
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Izmtbp6D;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nwQSXUa2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/YxG2ZmZM2e9qBTSySrFx7lsy/MjifUIQN5iXXAUf9Y=; b=Izmtbp6DE0rCtB6NSQOD0OhjW7
	CYImxCSg83LhpyjlUvjXIJPuXiQiztK6qdw0HUQ5qEyRssQtuEpmZQV9TI2CZNaN9yAj+iIgcJuPx
	iLjDboqhzyYtEUF6HAcmaaPa8cqa0o2GcbDfiuYZcrLpOpv0GwquqZXGvEn7+OVP7qKwo45pJERLj
	zyIkLYU1PfXxsJzbPCv3aYgc8z0WW4On0vJk41liJxxbsM1jUN++EAeHzyaZd4w8SqpQ/Zhphr4MI
	dlXRhkYOX8YR6jSy8mRQxM3gGTGTbliQYuI5N07WfwaH12r2eYGegyq9XkWIF7RnM3BgQT4ZBKtvC
	OCbcYqFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPLxO-0000000Cpvn-0Wpf;
	Fri, 06 Nov 2026 15:34:22 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPLxL-0000000Cpun-2NvI
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 15:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/YxG2ZmZM2e9qBTSySrFx7lsy/MjifUIQN5iXXAUf9Y=; b=nwQSXUa2bxKpHSEVGdWaum6xXR
	37cQdyep4RT0SyJtpDSFXQKFwmgnl/SHD3v1bS9x8dz+WfGChe4RZlQo6CMksMfLOQjOvd5WIf1Fv
	FUY32LP0p9GqyFw4JkD6W6/tQouC6mOeunPW5U9N46Yj6ufJNgCch6IxSKxHVu8MbprY3loJygtuf
	GNNwLKM9kOvePIQeF56CSSltpiSkeNjMUtU48twJPZEnvS4SBrpf84DwTK6sVYY9kCgaWiGoXJliK
	hyW81dnLOPLA1/gIsMLFSc01fkOvYQ0v519R87UiwMiSJIHcPMnZLxLio1SfVs5EM0FId6L9Gyrqz
	wdqi8GMA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPLxA-009NnJ-1J;
	Fri, 06 Nov 2026 15:34:08 +0000
Date: Fri, 6 Nov 2026 07:34:02 -0800
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, jbohac@suse.cz, david@kernel.org, hbathini@linux.ibm.com, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, kas@kernel.org, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH] crash: keep crashkernel CMA pages reserved if activation
 fails
Message-ID: <au3zYIPmX8bvwjet@gmail.com>
References: <20261104145600.3708886-1-usama.arif@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104145600.3708886-1-usama.arif@linux.dev>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_073419_682606_F5DAB929 
X-CRM114-Status: GOOD (  10.14  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 06:56:00AM -0800, Usama Arif wrote:
> reserve_crashkernel_cma() adds each crashkernel CMA area to
> crashk_cma_ranges[] as soon as it is declared. If the area later fails
> activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
> inside it, cma_activate_area() releases the pages to the buddy allocator
> as ordinary memory. The range is still handed to the crash kernel and
> excluded from the vmcore, so kernel data that lands there is overwritten
> by the crash kernel and missing from the dump.
> 
> Mark the areas with cma_reserve_pages_on_error(), so that a failed
> activation leaves the pages reserved: lost to the first kernel, but safe
> for the crash kernel to use.
> 
> Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Tested-by: Breno Leitao <leitao@debian.org>

