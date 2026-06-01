Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E3BCD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UOzybEzeLExkH9mUl9oBfp93NZv2EoV0lRz4YiNg45Y=; b=UpvWlqYCPXMHYpEg/m+sYptYMI
	kkbzqvLLC7VGuTyTiv9RBsjwdypFk5WIpW5K8jIq1YLApyQhZw/iz/hAkZdwlBSxCAzVPtGTSU8eC
	hkXDCPU7+lZLU6zUIwpUeiqEJ/X0/hXm4dCsnVV8evs1Fbkf2eGrvMleRY7tAxnloUU0G0OGVGOkV
	AhQVzynnsAQKmoe0ihrc/SFo+nwWR1Zk+oi8UTZVFYa6228sL/Z1Wqp+pOzOyjO6XGH/6AE2RdD2H
	o+yrda2HDJDdgbM5idbZK9dFzXr+HLEPvNUSkHXfi7bESvyUgDpaEXlB9zLhPr1jva0GsnvFE5aeN
	94aezOdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3Up-0000000BGqi-3lEO;
	Mon, 01 Jun 2026 14:20:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3Un-0000000BGq8-1d4B
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 14:20:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 19E0440AE9;
	Mon,  1 Jun 2026 14:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8611F00893;
	Mon,  1 Jun 2026 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780323601;
	bh=UOzybEzeLExkH9mUl9oBfp93NZv2EoV0lRz4YiNg45Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=aBxSk4mHUoODPHO12PREt7EgMTEXEXpHHJMcvZe3Vj+AIchbsf4rNiraqBIyY6eX1
	 2lIPQiH14ZViB/aO962wV/vfy2NPH5cUJNjbg4Ueb+xFdvhfkoqf4C/0LmHee76TPw
	 G1y7++6qdg4AhI5A44YjrrmPBR4TBL+6BrlMjWCdFXRP22vxxThNpHfDx5LwxHNOTb
	 6rqVRRP/vSRSya8f84xsWMqmbd/4DhaxZKbnXzCjvTBl+gbBCkPkG88joWnHnS5o/L
	 lnX3Wg28hqTzwxADnDOMWa93KPLkugVqAmXGl5IAUJfJUU0fxBhNcZ07/Jw6CsU6b+
	 05evwhABEcYyA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 12/13] selftests/liveupdate: Add stress-sessions
 kexec test
In-Reply-To: <20260530221938.115978-13-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:37 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-13-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 16:19:57 +0200
Message-ID: <2vxz33z6filu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_072001_447224_21CCC36F 
X-CRM114-Status: UNSURE (   7.21  )
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> Add a new test that creates 2000 LUO sessions before a kexec
> reboot and verifies their presence after the reboot. This ensures
> that the linked-block serialization mechanism works correctly for
> a large number of sessions.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

