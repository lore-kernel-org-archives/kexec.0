Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C667CA0FE9
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8ciS4aeZyhgyzVeLqSuRnRZPZL20ARBE7rKJdoYK08=; b=5DvG0x2eHs2FLPvXGJjRiXqtrU
	JD9BPHRJm90g/oSoPVktsxewmee2YIy1MzzDoTFnDIaLfn6tTF5Vow2WheQVPAwd4C7pm7Olc6T51
	UHGxNXLM470fymk4lB+CEMOA4D6FR6suDMyewRZ4udkT/6/+TlViqlBGeQqJWe+8E6N3Jl1MD8TsO
	I31cHOeC/+TXEPDFyGy8P1LlDn9Fjb9l32KOBOBh8jHQOGu3ebkamaUmJWS1EWA5BJk9HRv9VHjQO
	+vFNidVL3Fz30olZLwOe9c0qg0W9+Hn5cBrxsUz1NfHgvzSa+N03bbDfFb09DQD5Xlvazov5/5Ez1
	QMCipEgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtBg-0000000C0CJ-1KoA;
	Tue, 26 Aug 2025 12:54:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtBd-0000000C0BC-3Ev6;
	Tue, 26 Aug 2025 12:54:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3767C5C4C2D;
	Tue, 26 Aug 2025 12:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BB6C4CEF1;
	Tue, 26 Aug 2025 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756212845;
	bh=VqBfKPuvRHBKNrtaTa7Cb0yVBaKmtsKCiD5waTaaQD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g5BND8LIk17igmrS4/oA2wN9wTwM/qROa1VS9wg7QrnPjtmYCxPi8o7qO/aIXs1kr
	 nA1ZvXiZmCePvMByn+/Ra+z/m2H6p0G3C5Kmlq98Xv+cPxxGpx1S5RnpIYcBTFgCkw
	 MsxKKjMndnWRMUi5P+Wd0VZPf46fUOHBGLcGpmEn8rFaejj88tVFQ+5TqkxpUDN330
	 KpfFSV6ZvV+3WJJZNlgTe0oeYAjbDzsdy3DfH8etedYRptIP3tZTzNL0olS3R/8oiU
	 Y++k1RYSMbYklKwv8Yn+itCHLr5r8vRsYzlwVyId67HPYl1bsFqzRvXAmEMN40bGLK
	 zEOvtfpxfk1Nw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  kexec@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  bhe@redhat.com,  oxu@redhat.com,  berrange@redhat.com,
  kernel-team@meta.com,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
In-Reply-To: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
Date: Tue, 26 Aug 2025 14:54:02 +0200
Message-ID: <mafs0qzwyxmz9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_055405_854631_426E63A9 
X-CRM114-Status: UNSURE (   7.88  )
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

On Tue, Aug 26 2025, Breno Leitao wrote:

> The kexec_buf structure was previously declared without initialization
> in image_load(). This led to a UBSAN warning when the structure was
> expanded and uninitialized fields were accessed [1].
>
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
>
> Andrew Morton suggested that this function is only called 3x a week[2],
> thus, the memset() cost is inexpressive.

Yep, and it is only 80 bytes on an already very expensive kexec load
call.

>
> Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

