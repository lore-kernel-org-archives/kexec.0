Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60286CE8D76
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVOsGGNev+kFc4fmmK/Sez25eFhPMXojX9JX+N57FXU=; b=GjxcAZR0DjVbxVUH1s+3nIPEwC
	nW81lAS3I5LIOihxnepovnqijEqNA4tMM2+VZGXbFyt8J1kX0sfT46XJ3uZSGDU0mIEq11mGKDYg6
	fmV7PyC8TpiSvGqZzUnsJG8rOaCLgpYexmt4GolTJsFAwkBV7pl4XGr+JIRJYBzfS77srJc/OzfnI
	12IRNTA9VxMKIxVeG7uCmiCOxUmvdHi2//ty1tZWjmH0bfKRY/KWtySaTGamZLIieAn/oKe6JpNwT
	PDcG6UoWKfX+5gbrtAlDzinlofpv5kTWcpENFUzKj7K7QV/HIou+AVCpH5IS0wF/3lWXnHQNMrQAI
	24lF6EAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJza2-0000000D1Wc-3vRE;
	Fri, 14 Nov 2025 19:35:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJza1-0000000D1WU-119q
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:35:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4077260188;
	Fri, 14 Nov 2025 19:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8BFC4CEF5;
	Fri, 14 Nov 2025 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148932;
	bh=Zc97r0exmktwpRs9kQQA4bpGO3Sc8oaRn9s7KddLdwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kz1ExJB9ShhwyZCJrTmzMuqpRjtWv4hW2F7jZNB3rfQUowOAAacUIA9PnkDXUXXGy
	 xLhcc2rw7hSxiEIqfhbBUcVT9CvKryIbYxKgx8gSDhH6DPxm8qm1u6p2h4NU4y+eCh
	 jElngR6kvZ1B+ABXKxNxhL3hIGll1aJDF2ueT+YF5Q4Bkr8Q9r9knlbR1fBdFyTVCq
	 R2ND68jqTTUj1ZeLbaAN4/1I/L/AHp8N6psr/aDGPJdB4iWsFfp4u6FjJE+EFxuFiy
	 r945l83UMnqUx71Xg0fjH+ULU/gdV0SC6l9m//rhtkFv5zEouCT8tb8KzHp71NJNGW
	 JstnL8QGZWi/g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 12/13] kho: Allow memory preservation state updates
 after finalization
In-Reply-To: <20251114190002.3311679-13-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 14:00:01 -0500")
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
	<20251114190002.3311679-13-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 20:35:28 +0100
Message-ID: <mafs0a50o5rwf.fsf@kernel.org>
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

> Currently, kho_preserve_* and kho_unpreserve_* return -EBUSY if
> KHO is finalized. This enforces a rigid "freeze" on the KHO memory
> state.
>
> With the introduction of re-entrant finalization, this restriction is
> no longer necessary. Users should be allowed to modify the preservation
> set (e.g., adding new pages or freeing old ones) even after an initial
> finalization.
>
> The intended workflow for updates is now:
> 1. Modify state (preserve/unpreserve).
> 2. Call kho_finalize() again to refresh the serialized metadata.
>
> Remove the kho_out.finalized checks to enable this dynamic behavior.
>
> This also allows to convert kho_unpreserve_* functions to void, as they
> do not return any error anymore.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

