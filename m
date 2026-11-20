Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8E606A33A
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PVYjkcXK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmeJ271N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NGj0qVuLIFFATf6LyggXZB3De6ZTU5Fq7s/WOWKevVw=; b=PVYjkcXK07TPcYPrX4tLvDcLmg
	vhwjVg1TvYMCzDRhLbFmuWcn0LXNeX7Wkxulys/5yKygMBO7YQfmWYaREqNPX84Jj1e2XVcnv84PI
	0zcXORuqcrPc5+/SVjK2TqqmrhJXHvEdHxPgCEwhTrUVgLCMtqCd03zB40Nbb7rPuDpLfBr1v2k07
	KWz/+pbm7F062MRVi7TIzF6Mxmmt/tJjLpzGgqFrK8PkKNBXPvNZKdQVkmVIfWXeIeW1Wp30OdfnV
	WfuIy3Fjk4OzFj8vSnOQgVjxzMSBFoVgaD1QBiIra33+y3TAAcFJxY2bOzm8lSGY6o9D6YexkW8Bf
	gsXH4QjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQmz-0000000FSy9-0ly3;
	Fri, 20 Nov 2026 15:44:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQmy-0000000FSxx-22pl
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 15:44:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B989C629CF;
	Fri, 20 Nov 2026 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B4D1F000CF;
	Fri, 20 Nov 2026 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189475;
	bh=NGj0qVuLIFFATf6LyggXZB3De6ZTU5Fq7s/WOWKevVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mmeJ271N5f02C0B1RJgXSd6hkgBzr5xSxlMsyenlDXMd0wCPGTa7FRYam0L+pK+Nd
	 2nDwSnDOv012h1FYqMdYNMO6bs1iHUSB9PaeWSr6tD3E999ON/i1nZJrZlbyopx/zH
	 1WOxAslRKxAb9EIJj4yAqjf8N6R6HgMZS6aqktcvJIpdXVTkB3T81w8/pracVLAw5I
	 wSJIVpaYPJpzClqE6eNqFKYfrkrqP4tYZGjR6OqUAdtKVVC5HgrjgK71tSO2C0h5E2
	 +yEM8XVc3jF9BMQI6AHMNt7a5VhqmQ68piHOjE1DJhS6l88PoRjNwWQFZutTDw4942
	 yHBaa6mbzgwGw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Samiullah Khawaja
 <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/memfd_luo: keep memfd frozen until finish
In-Reply-To: <20261114220528.f7d9874a014dbb5d@chrisdown.name> (Chris Down's
	message of "Sat, 14 Nov 2026 22:05:28 -0800")
References: <20261110175855.2437084-1-pratyush@kernel.org>
	<20261110175855.2437084-3-pratyush@kernel.org>
	<20261114220528.f7d9874a014dbb5d@chrisdown.name>
Date: Fri, 20 Nov 2026 15:44:31 +0000
Message-ID: <2vxzcxrz1p9c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14 2026, Chris Down wrote:

> Hi Pratyush,
>
> Pratyush Yadav writes:
>>+ * Restrictions
>>+ * ============
>>+ *
>>+ * While a memfd is preserved, and after it is retrieved until the session is
>>+ * finished, its size can't be changed and holes can't be punched in it.
>>+ * Operations that would do so (``ftruncate()``, ``fallocate()``, writes past
>>+ * the end of the file) fail.
>
> Not a big deal, but there's one more thing that fails in this window and
> isn't listed here. Adding F_SEAL_WRITE to a retrieved memfd before finish
> now waits about 150ms and then fails with EBUSY. That's because
> memfd_wait_for_pins() sees the reference kept from kho_restore_folio() as
> an extra reference on every folio. Once the session is finished it
> succeeds straight away. The same already happens while the memfd is
> preserved in the old kernel, so maybe it's worth mentioning here for both?
>
> Also, fallocate() fails with EPERM in every mode while the file is frozen.
> That includes FALLOC_FL_KEEP_SIZE inside i_size, which neither changes the
> size nor punches a hole. "Operations that would do so" makes it sound like
> only some fallocate() calls fail.
>
> Otherwise I've tested this across a kexec and it works well.
>
> Once those are fixed, please feel free to add:
>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>

Thanks! I'll fixup the two documentation things and send out a v3.

-- 
Regards,
Pratyush Yadav

