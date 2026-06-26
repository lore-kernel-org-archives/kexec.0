Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C69CD4F26
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YpMyR+qlvlqRuVjps8vxBolsZnShA75KeyYR5QZWZI=; b=uqVor6IBtiRQXtHfgREcD6NvYb
	NzKgwBYikAr/D5wz5DN3NRLsmr0sOtmCmnMkJ0n9CBf5+iTfPvoYtgmc1I+3nXdgsuKc8WY68sKIn
	nvJnC1kN8CFvmNvNInKjmz3Tq2R4Tt6s8zGr2OUv2GLbHBGcH9ON0eKWJccaSedFo7sebF9FmnZ8g
	IeQCe5W49kaOBhiohhQ4UbChafFC8Ss5xRXUVnhXc59AQBMjuNb+BiY/E1MGpc5yFfLE35KR+bLx+
	BLe6ju+2BGVvmwxFmRXIhW5m8Q3dfLP9z4htaIxHki3/uvLEh3R758OjJMyYMx81TS5FR2xUAMjik
	mPTIGvLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd5BL-0000000BGVu-47r2;
	Fri, 26 Jun 2026 11:57:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd5BL-0000000BGVn-074s
	for kexec@lists.infradead.org;
	Fri, 26 Jun 2026 11:57:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 59DFC40ABE;
	Fri, 26 Jun 2026 11:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F51F1F000E9;
	Fri, 26 Jun 2026 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475034;
	bh=9YpMyR+qlvlqRuVjps8vxBolsZnShA75KeyYR5QZWZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Bx1YAzWSid7owFWxMCfA0186eDDpPS6Bk1iUsg+5y5Ugl2P9liT+7/arQf95DTE4S
	 HW+dq6UYThVhQ9NIFmWe8tFD2BlNMJWJaVVk+JZX4xuPvF8cmg5B3rOmTwW7ZTRg58
	 T7RbELABusb6j+rLGCeH8mpsvLl5yXS00wxwbkJHNLbmweXgbRfVy8v7Owq6GAzcY7
	 3kHxztfz8U+TqCWxUt9uQydBK4QYk3UwDBX+mf4JwlBYIElybqH1uEgseynnD70u92
	 +7njhKUWT8E49vgLRmSWdFkjWBnLtyosTqxRf/6QkwYBJJTCqHZR9Pw/4v0hWtMQep
	 lpa9skKfM/ccA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  David Matlack <dmatlack@google.com>,
  tarunsahu@google.com,  open list <linux-kernel@vger.kernel.org>,  "open
 list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,  "open list:KEXEC
 HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
In-Reply-To: <20260613012521.835490-2-skhawaja@google.com> (Samiullah
	Khawaja's message of "Sat, 13 Jun 2026 01:25:20 +0000")
References: <20260613012521.835490-1-skhawaja@google.com>
	<20260613012521.835490-2-skhawaja@google.com>
Date: Fri, 26 Jun 2026 13:57:11 +0200
Message-ID: <2vxzwlvljyzs.fsf@kernel.org>
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

Hi Sami,

On Sat, Jun 13 2026, Samiullah Khawaja wrote:

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Live update orchestrator file handlers depend on the preservation of
> other files. To make sure that the dependency is preserved, the file
> handlers needs to fetch the preservation token of the preserved
> dependency. Similarly during restore, a file handler wants to fetch the
> restored file of the dependency.
>
> Add APIs that allows fetching token of dependency during preservation,
> and fetching the restored file dependency during restore.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

We discussed this once already on a call, but I'll write my argument out
here for everyone else to get a say as well.

While it isn't obvious, this patch implicitly defines a part of the uAPI
for live update. This patch says to VMMs (or other live update users)
that "you can restore dependent files in any order". That is, VMMs
don't have to restore the files in a topological sort order or
dependencies, they can do so in any order and the kernel will manage the
dependencies on its own.

But on the preservation side, VMMs still do need to follow the
topological order of dependencies. Because if they don't, the
liveupdate_get_token_outgoing() call will fail and preservation can't
proceed.

In simple words, if file type A depends on file type B, VMMs always need
to preserve B before A, because A's preservation will try to find B's
token, and if B is not preserved that will fail. On the _restore_ side
though, liveupdate_get_file_incoming() implicitly retrieves the file so
the VMM can restore then in any order.

I don't like this for a couple reasons. First, this makes the API
asymmetric. If the VMM needs to manage dependency order during
preservation anyway, why not do it on retrieve as well?

Second, the API is easier to misuse. The VMM can restore A but not B,
and then close the session. It will go on its merry way never knowing it
did something wrong. For example, guest_memfd depends on its VM FD. With
this patch, LUO will allow restoring guest_memfd without restoring the
VM FD. This makes the guest_memfd practically useless. Yes, it is a bug
in the VMM anyway, but if guest_memfd restore was denied, then it would
be easier to catch.

The kernel will keep itself safe in either case, but it will make the
API harder to misuse. And you can always _relax_ the ordering
requirement if there is a need in the future, but you can't go the other
way round.

So that's my question: do we enforce restore ordering? The code change
should be relatively simple. You just need to fail if the file is not
already restored in liveupdate_get_file_incoming().

In either case, please at least add a piece in the documentation about
this ordering. We should not leave it implicit.

[...]

-- 
Regards,
Pratyush Yadav

