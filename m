Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C4F364C8
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TCZp/0zpqKUcSUVUVKxZEKxPq6cY0vFtTi4h6UJ3eGc=; b=jPl4+pJAhqUZqUXyTZzVcawWji
	WpYMT744ES85Bjr8Du9YdqtK4FqxR81jXhDDCokKK+iR/uKjgfp+Sl3bAcbbOLX+kFSLkwHXFuxI4
	K90VZn9z8cEoDKL72R8qNd6FhcyUZYw6MMdOwodEGsNOV+Gx1mdjsQC7U3VJAxnakVZPEVaQBB7oh
	hJKTqwnvwJT6FdcS+Qw5bs5kp2yHPvCLRySsEeSB2Ikz5tPEzs1fJfEcAZu4cvavQsKAUGfSU2adw
	57+31XHQvQui1HtKRd74LOvT+K65OzcHd+XyiIzVmRoUNdQogLeIumnNBt47KWtOarICbcBa6oOxo
	JcCigISg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAxXj-0000000BGPb-0eSr;
	Thu, 09 Apr 2026 22:08:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAxXg-0000000BGPG-38jC
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 22:08:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6EF57438F0;
	Thu,  9 Apr 2026 22:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA32C4CEF7;
	Thu,  9 Apr 2026 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775772483;
	bh=+G3f1pApENEjUmf8/ey15GcIeDZlQhQyE/iU1l/XDHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nLTyAt5mpJa8aEV4EsEvUSy7WoQR9BIMvp42QupSvFk18TFbfPUzXH8oSXb5KXOG+
	 SVXgkBzZjYd6+q+sQFdD76OtTJQTXuX4vQ+m6EWmO7JxTlbRAd/j2pYmcPqinxyXg9
	 PccXarbDIljFQfHWQk1vG7nmzsIIlKuCTA7xndys=
Date: Thu, 9 Apr 2026 15:08:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: fix error handling in kho_add_subtree()
Message-Id: <20260409150802.fd7b91c9beea6abe4e8a63c2@linux-foundation.org>
In-Reply-To: <20260407-kho_fix_send-v1-1-b21977feb960@debian.org>
References: <20260407-kho_fix_send-v1-1-b21977feb960@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_150805_035138_A15FD949 
X-CRM114-Status: GOOD (  16.63  )
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

On Tue, 07 Apr 2026 10:01:47 -0700 Breno Leitao <leitao@debian.org> wrote:

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

v6.16.

> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Do -stable kernels want this?

Changelog is missing a description of userspace-visible effects, So I
(and others) can't tell!

