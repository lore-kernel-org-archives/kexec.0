Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D6606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DdpcAiA4;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=tZSy5iHx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6RKT0O/a2ICAVlG42q1U3NHIVPPuSmn9M7UwQWzHXqA=; b=DdpcAiA4QOaVX6
	lyOOxbhrKqc7S5X9X097flN6m4mWZ+iORgLbCSmtZi/ShHQoSxXcNQRflKsapsx8ZprCY7g0xm8Fe
	9QDxyHbUk+wEQWzcPWb/iaT8WKg/dQJ3LjPmg4qdpECQVTH9PDQJ4o9gUQyWbYfpGJnsb1gC2Qi+3
	vGIlY6zSA5O4EMQcZX1a4cnm5kduYyyR/ncDTWrWfMz+9WdTO0SWEkpV54O1lJnXBmOyj0y+jNjyb
	FQdQxaG4tbQ6UhI9SUhc4Dzck33MOfHTGMpD8qhVVPwcm3LSAIbp80reRBZlfbHR8wDMl561zjR6N
	esSZZq5/9OKl3cB4VP4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYnP-00000004UWf-0xzW;
	Mon, 23 Nov 2026 18:29:43 +0000
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYnL-00000004UT6-0Mqa
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 18:29:41 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=6RKT0O/a2ICAVlG42q1U3NHIVPPuSmn9M7UwQWzHXqA=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795458576; v=1; x=1796063376;
 b=tZSy5iHxpKXau/8scmsuCbWl6lrffVjXRG9VmFdr3C/kIKixag/xuel4IMc9mid9ozacPLHA
 ZwBVAitu9Ix5fQLsX/y4FV+KRD4kElSq40dCiPbGBPPKLgbJAfjzJ+CH02wM3eOyEwEhHMVgyQQ
 VcrTR8zCd8PJbLaZdZnlVpD6o48DPDoHeZnNj5kAW49GkxlXO0dNHyQn6Zu+spbl82575q5D7zt
 t2lvnHHR//HwtqhdbwqwD9nLd+Nzv6pL6EHV6qRFrvYYsQ9yYqoaTLoDzHvNSeqKtRcnBwwY+hl
 T9ph0wRW94wyZZPhmZZKPtVH0XlQ6mQENx77z6oaCJCzw==
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 37519310d25481af;
	Mon, 23 Nov 2026 18:29:36 +0000
X-Mizu-Trace-ID: 37519310d25481af
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] x86/kexec: Type relocate_kernel() to drop __nocfi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Nov 2026 10:29:13 -0800
Message-Id: <20261123-re-5825067c5cd5@cressey.dev>
In-Reply-To: <avVUv4_eeOOr7ZX_@jpoimboe>
References: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
 <avVUv4_eeOOr7ZX_@jpoimboe>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_102939_326798_09132830 
X-CRM114-Status: UNSURE (   7.51  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-12, Josh Poimboeuf wrote:
> No objection to the change itself, but PLEASE no LLM-written changelogs
> or comments, they tend to read like Rube Goldberg machines and these are
> no exception...

Thanks for looking at it, Josh. You're right that the changelog and
the comments are much harder to follow than they should be. If this
goes to a v2, I'll fix them both.

