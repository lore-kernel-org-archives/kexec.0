Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A24DE7E36C
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdLkX+T+geuPxnAcCrsQTc83eke1BcvJBuYuVeCU424=; b=q5q9kiD9s13BaSPX7S+jnekF22
	kJQtYxQzny1BNNxuQHngq0a8QfBXm6nr/Dxp1UKVcZRwhVpuUb7JI5/226s0o8t/niat8SSoZ78yj
	LbKkxuoGy8jYVOpZvrq6xAOwscKmSzI3Akyp5qYHW601U7b6J/STD/+5fEd7oAZTVKZWJlDYwebIL
	Qq25cFuVdMLkkQtyzzpFy1HVnD22U5HRyOkwZLpVcuCKOmiHC+xVYrV4nWrdCS3e3FcZkQcPslcn9
	4UZqJlcC8hRidNqJihBEOkekvieCYie44yqmXrsTiQxEao5RImOAuOpuDiqjv23+ACuxOOrKMXL2L
	6oHf8Rqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8caZ-00000001wnS-27lr;
	Fri, 03 Apr 2026 11:21:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8caY-00000001wnJ-0rZf
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 11:21:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A4A1960121;
	Fri,  3 Apr 2026 11:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C78C4CEF7;
	Fri,  3 Apr 2026 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215281;
	bh=C2PE0QSFewGyAGB7w24PL7F8mQ26TmpseXExWlTHEWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KnOMtt0Y7qhdjpMeGPoOcoZzqzzIQ8bv9ED6tBakBnpMTCVr5t/aZUH/yShW+kwBO
	 /E2OZ019G6iRF3IQ792ESCtxHs8GPQZBq562VKyr4/bxj2976VMZNZ07swz+bUe1Qa
	 ZtzRE2+6UfFy+gOhX20mXNwcHni8iH0Rejl0Cs2vUZZx5gnYtDdLPdfLmtmJ69IyMs
	 N2PwyydrgIkOPhcG/BkRqLSiTDjIATePGlYEMu1bajcReeOZmit3q3LXmhAo09TpHW
	 d1MH+pIx1nfc5NNBB+Rm2S97U8CFTy3i+QuA1YH3xdXmB2cfpux78gF0vPlJMVL9yN
	 a5wtgMCfecICQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usama.arif@linux.dev,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v9 1/6] kho: add size parameter to kho_add_subtree()
In-Reply-To: <20260316-kho-v9-1-ed6dcd951988@debian.org> (Breno Leitao's
	message of "Mon, 16 Mar 2026 04:54:31 -0700")
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
	<20260316-kho-v9-1-ed6dcd951988@debian.org>
Date: Fri, 03 Apr 2026 11:21:17 +0000
Message-ID: <2vxz1pgwe1ci.fsf@kernel.org>
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

On Mon, Mar 16 2026, Breno Leitao wrote:

> kho_add_subtree() assumes the fdt argument is always an FDT and calls
> fdt_totalsize() on it in the debugfs code path. This assumption will
> break if a caller passes arbitrary data instead of an FDT.
>
> When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
> calls __kho_debugfs_fdt_add(), which executes:
>
>     f->wrapper.size = fdt_totalsize(fdt);
>
> Fix this by adding an explicit size parameter to kho_add_subtree() so
> callers specify the blob size. This allows subtrees to contain
> arbitrary data formats, not just FDTs. Update all callers:
>
>   - memblock.c: use fdt_totalsize(fdt)
>   - luo_core.c: use fdt_totalsize(fdt_out)
>   - test_kho.c: use fdt_totalsize()
>   - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)
>
> Also update __kho_debugfs_fdt_add() to receive the size explicitly
> instead of computing it internally via fdt_totalsize(). In
> kho_in_debugfs_init(), pass fdt_totalsize() for the root FDT and
> sub-blobs since all current users are FDTs. A subsequent patch will
> persist the size in the KHO FDT so the incoming side can handle
> non-FDT blobs correctly.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

