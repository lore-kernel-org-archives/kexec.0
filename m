Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1DAE99056
	for <kexec@archiver.kernel.org>; Fri, 10 Apr 2026 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eX6xcryDUIa7Vylx/0UzTyLSmyeGAUYHjEMq2Mi0C0=; b=z9YZnE+5nMOF2dNR0tRcH4urPL
	3Vvaqm7o1ViNbb7whwQcxqbBiKVUj5Efa0CAyUcm2XByZWIARdA4/9QbsU8E8g2/vKewQam48uupC
	HiuyEjX7iBnL5BQTdwYnVibDxgfUY1wZUe6TXuEiYqgo2amPkjzLwupCK2TZyXfV0Ax++SF7oquH8
	dPT2LI/TG8PZOUeAnBaKU5IcE9ojLpMtZIaQvYQzk8T4xynd/o51Mr/FHajajYLwVmEFk76IBKtO0
	zOs+g60xoeVOW6fGQKekt1G74zo+WR3y3w5BWMzkSnJtlwXgjexuHk3Xlwsehb+0N5G21MImVzP5v
	QcwjUqtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB7bB-0000000BrXD-36oY;
	Fri, 10 Apr 2026 08:52:21 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB7b9-0000000BrWm-2Qys
	for kexec@lists.infradead.org;
	Fri, 10 Apr 2026 08:52:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0eX6xcryDUIa7Vylx/0UzTyLSmyeGAUYHjEMq2Mi0C0=; b=jdzNlHbJtZA4YfAYyP5O25FLE4
	wKMHbefxjS0W6vs98qdeJa7V4gHj25FxGt5RkcNyejrww3iujsYvJedlbpghLpIyJXt6yg92o7HjH
	ejtUgep8gK+7Kk5Ir1vy3lSwOLbNk/SZIIhe0qaZa6nxv8sGiP/m5p16Zc2elgg5mOhuFOpsJ2xJq
	8fsQMLPXtU31MF2boEItGD0v7RZ5TBCYFxWx3WYHawnxPqIXGBH2VOXy4DPBqJRWvbROvMjl2i9Ey
	8XPy0a51PJuJDlGFP/Nt/gxjYLkfj5f96kCChp45u7g/wnhyg7uKJsfQmAzr6r5HSz0WtHVGp9hnW
	Z2ukoSlw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wB7b2-009rYK-2Y;
	Fri, 10 Apr 2026 08:52:13 +0000
Date: Fri, 10 Apr 2026 01:52:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: fix error handling in kho_add_subtree()
Message-ID: <adi51hPc8n5ITHbU@gmail.com>
References: <20260407-kho_fix_send-v1-1-b21977feb960@debian.org>
 <20260409150802.fd7b91c9beea6abe4e8a63c2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409150802.fd7b91c9beea6abe4e8a63c2@linux-foundation.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_015219_617874_7DFDECF3 
X-CRM114-Status: GOOD (  19.06  )
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

On Thu, Apr 09, 2026 at 03:08:02PM -0700, Andrew Morton wrote:
> On Tue, 07 Apr 2026 10:01:47 -0700 Breno Leitao <leitao@debian.org> wrote:
>
> > Fix two error handling issues in kho_add_subtree(), where it doesn't
> > handle the error path correctly.
> >
> > 1. If fdt_setprop() fails after the subnode has been created, the
> >    subnode is not removed. This leaves an incomplete node in the FDT
> >    (missing "preserved-data" or "blob-size" properties).
> >
> > 2. The fdt_setprop() return value (an FDT error code) is stored
> >    directly in err and returned to the caller, which expects -errno.
> >
> > Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
> > out_del_node label that removes the subnode on failure, and only setting
> > err = 0 on the success path, otherwise returning -ENOMEM (instead of
> > FDT_ERR_ errors that would come from fdt_setprop).
> >
> > Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
>
> v6.16.
>
> > Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
>
> Do -stable kernels want this?
>
> Changelog is missing a description of userspace-visible effects, So I
> (and others) can't tell!

Agreed. I'll improve the changelog to describe the user-visible impact
and CC stable in v2.


