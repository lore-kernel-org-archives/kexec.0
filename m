Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C243CD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXhPQdQbmoYxAcV9f2JludgA6q/58FaJSUv8UfHFRl4=; b=V5hz3sPtPP1OXtxFartMDm3MOw
	isxRufIYRs4hbl9Jv/bG/LbfNB/flTJYN70pMfHT0isjUzAnPp5W3B/k+oaiVbPWSOKbYPO9HsmWF
	WHT/oZAXq/WhJbkJciCNWdbCVuaIYQw1MDFNdv1jPiP7U55iq/DKlnJKFQEKbSUbVxJ41ZHp6oqHn
	mHobSEW2+Wr/RXxmC3TVaxkoz+97Y7YShy/0MVHNUtF4Y8kg7sfqswrLS2qQLLTEX5z6CT9FohVvD
	xrbXEitSaynNGy8hs9sDyqTYE6g0nchZUM/0qo4TEpvA2MGSG1nx1IZ1eprwoUnlF5KMDpIQg4mRz
	YAJGnsCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2yx-0000000BEG1-0jgN;
	Mon, 01 Jun 2026 13:47:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2yv-0000000BEFt-2zNw
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 13:47:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D78FE601D9;
	Mon,  1 Jun 2026 13:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258691F0089C;
	Mon,  1 Jun 2026 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321624;
	bh=VXhPQdQbmoYxAcV9f2JludgA6q/58FaJSUv8UfHFRl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=a2kJyXI1gAxua3NhkBOff+AUkJjnhgPLShZ/88+99yp64tJHwtjd8quIORXIi5PyB
	 9mSyIIlLImIB6U+wbfQ5aRikM5IkO3VFL/iSK3uMhUbF9EyEfx4Q2OUeoZws4yMFAk
	 BUuX79fXFgvZqgbNRe8KiMU8rStJ8qX5nPjCL+LBljsZbLcgxNDmqZcwJ4HMCqWEXk
	 s4zxvlfmuIOlvB00hxcodPp2ocg6vU2DviYmGIO6wCapBTaPWH2qw9K5Z8GKBF/yjy
	 gQUnBroinBXDdp4ReRa3TRZuAzEMSLTOCtRS57xC7ywiutabcheiqjjY8i1oPJN5MF
	 h95wh8sINQUjg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 08/13] liveupdate: defer session block allocation and
 PA setting
In-Reply-To: <20260530221938.115978-9-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:33 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-9-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 15:47:00 +0200
Message-ID: <2vxzmrxefk4r.fsf@kernel.org>
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> Currently, luo_session_setup_outgoing() allocates the session block and
> sets its physical address in the header immediately. With upcoming
> dynamic block-based session management, this makes the first block
> different from the rest. Move the allocation to where it is first needed.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

