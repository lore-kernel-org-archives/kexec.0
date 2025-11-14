Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C985CE8D5D
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmkGOgnl3lzVVMZao+EOw6oK16wcWquPYMJhUNT9Yfw=; b=ZYXopSWcXBmnkBL4E2DuAkvI5K
	uvW7PhOD4garL9p27zWNKn+bQ+991AmUXkfQ5fW2lhnKV5cipVpEjevX62SZzo5O+Z6JNtyrMHw3z
	CLjlrTTMS9DJuf9+lWJWoNlagzwdtAgxuF4voA1ICJEebrQqrNujo2IhxXMVZzGSW4cxi8ZrM26/M
	JArj5lqg2MDEy+j3gnoXyz6q25/jLE50m25CyteI0EEZ9vSHE8d4cHFmmCNKZX5zG38H8nHdmIczJ
	26BgUP3B338QjPMYujQE6r35l4w/lpC7oFuEreju+T0q2DxOD2ltFlAdKKmOIKcbmRKlr/uYzDoSI
	lwptEqZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxDz-0000000CoAp-1FUc;
	Fri, 14 Nov 2025 17:04:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxDx-0000000CoAg-38jw
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:04:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BB3CF601A1;
	Fri, 14 Nov 2025 17:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453CCC4CEF1;
	Fri, 14 Nov 2025 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763139876;
	bh=wLxrgv3sUOLNiDmnHHWigIAhY0EhWAgzWSDG3kdvF1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h4zz5ZeRaWdLKj5ZUywCVx20N6rT/1NPuF19hRA82nQZkaw/xIZpxHcPUImLnXdjb
	 Az92XgTJNNKawV8Wqc1OzMEMlpRbYMg3tVVh1y/PLxq3PpDvGflLojKtICeL/6Yza+
	 UXiHi5bHKk+xvlZuQShfy2JdjDlYCfV+6ONP/iZ4rLxTSb49eTTtIPsZpYWEsghWYe
	 KUXfoLkEr68Jh7+PBn8Dj1DFefacL43z5wNGb0LR6IbsUKhdw9XUN3b2QuhT23y/ly
	 MpdT3sBGOlNXhlcSLOpvcTuRrjLiActa3LlVV+oGJdSV7B2nBP/FFkyqwQwlBBU8N/
	 iCyYosA4CzMcg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 06/13] kho: Simplify serialization and remove
 __kho_abort
In-Reply-To: <20251114155358.2884014-7-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:51 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-7-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:04:33 +0100
Message-ID: <mafs0ldk87dge.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, __kho_finalize() performs memory serialization in the middle
> of FDT construction. If FDT construction fails later, the function must
> manually clean up the serialized memory via __kho_abort().
>
> Refactor __kho_finalize() to perform kho_mem_serialize() only after the
> FDT has been successfully constructed and finished. This reordering has
> two benefits:
> 1. It avoids expensive serialization work if FDT generation fails.
> 2. It removes the need for cleanup in the FDT error path.
>
> As a result, the internal helper __kho_abort() is no longer needed for
> internal error handling. Inline its remaining logic (cleanup of the
> preserved memory map) directly into kho_abort() and remove the helper.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

