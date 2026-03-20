Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62873108B8E6
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A4UVsuA1CIGtseeHhqgDwPJ1454aepRrEwLEr3XSBvE=; b=F3fcSiFC1BjG9pSV0B4fkHRJwn
	Q58wfFFphZfpgRlOV2tpAHAaYsvKUaXuiAkTWLKuTXE8slN5KE6Wb5CUsKuAuKyFcSAE3zeLDXNSf
	/vbC3BV7lH2KK3sD7t9awd1iXeOtBHDCppi6qC44YllINNpeXJ7kipjxM2wcNTwVQnO9YxDUFudyv
	oMdgkl9G12Vl7hl+W3I4cMAAuZaM5O8qlusDtjfMGU5hfeF8Pe3bUK/QvwKY4Vej6Wm6dQ3cfC8T3
	mXQNvVikYqQUfx7pWAUKkluVuDNWrg6qUrxlMQKe/WAmcfLnUupvbKj8mvytkKzHqiC4ZPsb6s2L7
	uy/MGAFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Wxs-0000000CZzS-00iS;
	Fri, 20 Mar 2026 10:20:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Wxp-0000000CZz7-0dCD
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 10:20:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F9624350A;
	Fri, 20 Mar 2026 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B713FC4CEF7;
	Fri, 20 Mar 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774002020;
	bh=1yi+uQrwdMAJsCrwNSFMANMj9LMkjSSp74fuqYJ+IqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UeliRVO36q2ztKGDDIqmrN17gvFUTGTzWyRqrWwIXx245mCicVOSERgewn5u7eQoP
	 MMqg3CCokwjQL3LZ+yzKsGQnOhHkNJqkDeCpM7hc3kO/ozsPv4MyTo9GErnz/5Pm6O
	 1isDpXwQKGH+PB1d5S5PpLqArQt6u6UwHZWt1ouOooyWvMwO9XeO8kmTvCJqwU1pp5
	 ZWCS7WeV6tUMtuVustN0kDekXMUut/Ff6V7dJvezQo5C2w+t4NYFwWP6g5lnapP/8L
	 Hbp1xmAY80qefXAY4QxYQ4GQvwJHp6dGk5g5lW7WaAbJSIXBBaayYqdPWP+w6yC4MT
	 oUQa1sMe0bAOw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  ranxiaokai627@163.com,
  graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  jasonmiu@google.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  ran.xiaokai@zte.com.cn,  Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
In-Reply-To: <20260317140828.f5edbc151f85ffb8751b0f2d@linux-foundation.org>
	(Andrew Morton's message of "Tue, 17 Mar 2026 14:08:28 -0700")
References: <20260309033530.244508-1-ranxiaokai627@163.com>
	<2vxzpl58f3oh.fsf@kernel.org>
	<20260314154637.86a7d4f07800b59c00049814@linux-foundation.org>
	<2vxzse9yddpr.fsf@kernel.org>
	<20260317140828.f5edbc151f85ffb8751b0f2d@linux-foundation.org>
Date: Fri, 20 Mar 2026 10:20:15 +0000
Message-ID: <2vxz5x6qby5c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_032021_232685_20E39C98 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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

On Tue, Mar 17 2026, Andrew Morton wrote:

> On Tue, 17 Mar 2026 09:09:36 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:
[...]
>> Sorry, my bad for causing the confusion. I thought the radix tree
>> patches ("kho: adopt radix tree for preserved memory tracking") already
>> landed in mainline, but I went and checked and it seems that they
>> haven't. They are still in mm-unstable. So we should just meld this
>> patch ("kho: fix child node parsing for debugfs in/sub_fdts") into
>> ("kho: adopt radix tree for preserved memory tracking").
>
> OK, that's how we presently have things:
>
> kho-adopt-radix-tree-for-preserved-memory-tracking.patch
> kho-adopt-radix-tree-for-preserved-memory-tracking-fix.patch <- "kho: fix child node..."
> kho-remove-finalize-state-and-clients.patch

LGTM. Thanks!

[...]

-- 
Regards,
Pratyush Yadav

