Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E5C43602
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAsxDYXFInz/u9XO8E/+whzViujYIZ7xqJPgfSxLHig=; b=0iLYyi5zIMNB5UAKzAIEBQbcbD
	njMC4NMkXsZ+gT6tJwEfz+c7u5pYie/jUOwAUl2uYYajdJrnoGUK1wQmxUZjkpNwCFqmAlGuzxo0y
	xbJe4N0BqXjFvsWTfr9EdPtM1ZlmCJ7Um1opy5p6K5fo3Q/0125Lh/ph4gzVZ8qUHNkOUrCzBYJ1f
	BcDaGcLWGgo3nJhPLfE4pN06bnVV61iPJM5OEJZ1OaWfwrARAaf8GXj6L0AANoHlMoDgidwJXJl7z
	aN79dOI9Jsby0/+0lcWand4+MBjCiAWzK0v4DNyg+6/HVR4icdpyhlj6JF30whxU7xbd+Afuam4Ef
	ajXbwrdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfccO-00000006tQC-3XPK;
	Fri, 03 Jul 2026 12:03:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfccK-00000006tPy-1Pcn
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 12:03:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 060DC404D9;
	Fri,  3 Jul 2026 12:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4657C1F000E9;
	Fri,  3 Jul 2026 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080215;
	bh=oAsxDYXFInz/u9XO8E/+whzViujYIZ7xqJPgfSxLHig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dCCEtaSF/82Gg+fESiFsLbe3u4kjptop+mQO1dQk2B+zmQRhm2wOS8c52WvQNZVey
	 gc1/JGOEv+o1zfjT/lecu0W8xbfzddXrH+Qq4E9IXeuQJeSpSCZLgHoM0Uj8VZuo5H
	 KFvryI9mSP/kSoPyqFZm3F1Nkh0gilIitZfroTW0IFWDcpUoh62b/QsUrFIEJD8fmh
	 oPlfN0mEaDqysTk4w9dWO+45wR+Q3+4aG4wQ/mAAiXwU2em4mdKxUFatGSBk6Cj+KZ
	 ma2yoMPueeV26/qj4Fmm1ayLZJxJFtCVS0g40tWK7yBYViejZbTR1c/N00MM/cwM21
	 PiNnCZteu4XPw==
From: Pratyush Yadav <pratyush@kernel.org>
To: mdshahid03@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,  Dave
 Young <ruirui.yang@linux.dev>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: crash dump: remove redundant NULL check before
 kvfree()
In-Reply-To: <20260703112642.65498-1-mdshahid03@gmail.com> (mdshahid's message
	of "Fri, 3 Jul 2026 16:56:42 +0530")
References: <20260703112642.65498-1-mdshahid03@gmail.com>
Date: Fri, 03 Jul 2026 14:03:32 +0200
Message-ID: <2vxzbjcogu0b.fsf@kernel.org>
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

On Fri, Jul 03 2026, mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> kvfree() safely handles NULL pointers, so the explicit NULL check
> before calling kvfree() is unnecessary.
>
> This issue was reported by ifnullfree.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

BTW, Sashiko [0] pointed out a bunch of problems in the surrounding code,
and they seem to look legit. If you're interested, help in fixing them
would be much appreciated.

[0] https://sashiko.dev/#/patchset/20260703112642.65498-1-mdshahid03@gmail.com

[...]

-- 
Regards,
Pratyush Yadav

