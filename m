Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A694FCCF9F8
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8bZBUPtzzzev37+uLhtrdVviulgMuIjvC1GY3crWBFA=; b=y7I6o+5ZuhAXj7EzmcmawMvWcT
	uMVxr6R7umQs/pjS7zog+Y6pdVgovHHkTZo+wqkWHbvssEbiVK166fC3mOWLG9pPbPYeqMzwx25tM
	lihYjBqrHvqZRBkBMNi27FNESTXkgbimYq0CC+RvNtaVzQQtN1kDs7wzNxysaWLwI4YNVgDnoSz8b
	49+5bQIgTaJDhh3Hfjyg/gS5jcafgUpERMUhc2r7e6w+4edDLO4vuorHmHi5ehVraM5KKz+0jbMYt
	K77kDQe99R9g4HLgFWq700p2ufZ79gPpjkfyTxIok+TBd52cjt0GTNH7Z+vncLYuRcozTSHn4Lrsd
	YQbBpdfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGhTb-0000000EC28-1yG9;
	Wed, 05 Nov 2025 17:39:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGhTa-0000000EC1z-0xM2
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 17:39:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4AE2F60215;
	Wed,  5 Nov 2025 17:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1058C4CEF5;
	Wed,  5 Nov 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364357;
	bh=bnh3/CAPolVJG3UKOT5bLfJBBm8bDPtW71CYPwpR/mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqsEtYSWwRoLiOeSsx3jWqVxakKTAiqjHt3pYO+HqWKIOgMb8Yv//+Q4+L72UVBBh
	 3y5NxBtKZHptCNufrfu4o+4y0RITkyywqH4qoGrzfzjTs58y2KKkTJcQKKU5RGWe0e
	 teyXwwpyWA7Vp3b3rCKTXj+TLa6cPruHE69TBxiMprtcD2sV2VuhNzG685aYPXuj8n
	 qOBGvBKiDh1AKxQ3F7/O4eUnz2HDhRzxyKnl3EzGswJndnPzAImRIu8a1Su0tLd2Or
	 rmpOjTcW7kuYuRDkgB+kGV1av2uWHZ+9vPbiHvs75FsEuC/i0MN8b6hImRNqw+2m97
	 gtxMrrog8iW6g==
Date: Wed, 5 Nov 2025 19:39:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend file entry in KHO to include
 subdirectories
Message-ID: <aQuLvVjH12g7L-fY@kernel.org>
References: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
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

On Tue, Nov 04, 2025 at 03:32:38PM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
> file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
> means that all files in kho are included, but not files in its
> subdirectories below.
> Hence, the files under Documentation/core-api/kho/bindings/ are not
> considered part of KHO, and get_maintainers.pl does not necessarily add the
> KHO maintainers to the recipients of patches to those files. Probably, this
> is not intended, though, and it was simply an oversight of the detailed
> semantics of such file entries.
> 
> Make the file entry to include the subdirectories of
> Documentation/core-api/kho/.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06ff926c5331..499b52d7793f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13836,7 +13836,7 @@ L:	kexec@lists.infradead.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	Documentation/admin-guide/mm/kho.rst
> -F:	Documentation/core-api/kho/*
> +F:	Documentation/core-api/kho/
>  F:	include/linux/kexec_handover.h
>  F:	kernel/kexec_handover.c
>  F:	tools/testing/selftests/kho/
> -- 
> 2.51.1
> 

-- 
Sincerely yours,
Mike.

