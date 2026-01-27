Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F2D2595A
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1IAoLAKw2Vg0PzPanaLKZXBk7NDv+OxvP+pKfiIL5A=; b=0ftFjUfNEm8/o+JIzq1GgdXW56
	P1XPKTiSbsEZiVKqr2Oospc2kf9xrIzQZbz+UxMKb6eXlt+Mr6+jt5lNcuNhpJCH41uNiq4Jqoj+0
	cbtyQ+9JV9PbBdi5b+fVmlffMkGiy+zwbFflwUSLCQGjopcESFvESFGsJPL4qlkBrSaVjK3cUAAIx
	RhfFeXB26AVEfCdxJuoUQtrBRx5E8rnhggytRPsN6TqVrVJ6GnXns+vyJ4JD4ilaW3EKm9iaFpsnn
	iyGbECYcRBcbQaQGi3oY7e8y69w8jIcjBGA7KN1AIYPp84mBnNHdmlgRloqlAq1gc2MHfK7M4rXvh
	SM5lDJJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdZL-0000000Dmdf-36gv;
	Tue, 27 Jan 2026 07:32:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdZJ-0000000DmdJ-1sdi
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 07:32:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B029241976;
	Tue, 27 Jan 2026 07:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938F7C116C6;
	Tue, 27 Jan 2026 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769499176;
	bh=mcYw49oBRDHwBRsps1hLbRA9pNvVL7ckmnD/EZWaycg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWkAIVI6JJWgtjMbliTTZz7rAATFbBOFtk2u9m62j90Alz0nkLkJ/kF5uCEnurD1B
	 71YoP9EcyxM0LL0aKZykj6W+rkSAU2mwAg9ZAdb6TWZpTwL/tX3L9iUcrmUsK2rSoq
	 jATETtGfv+CbT368L+hBw9M7bByOThCQtxZLXV+O1qYzVNrsdVKRcgTsSKyLmPaYTy
	 Kc/VG8gWLWdUH+/WzkNnkYSUdE3QcGpFoizlS2cJ+gCC1RXOsnKwmuhw8aPXJWdmpD
	 5M7xTWGttZ/l3rb0Kcg557rRf/UWWMacrdpmTv3mZa4SZvn5Dg/bufstnzNx1NITjh
	 KhAKErT+Ag2tg==
Date: Tue, 27 Jan 2026 09:32:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v5 4/4] kho: document kexec-metadata tracking feature
Message-ID: <aXhqIDAPKdoXYme4@kernel.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
 <20260126-kho-v5-4-7cd0f69ab204@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kho-v5-4-7cd0f69ab204@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_233257_509144_F3260D15 
X-CRM114-Status: UNSURE (   7.85  )
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

On Mon, Jan 26, 2026 at 08:07:26AM -0800, Breno Leitao wrote:
> Add documentation for the kexec-metadata feature that tracks the
> previous kernel version and kexec boot count across kexec reboots.
> This helps diagnose bugs that only reproduce when kexecing from
> specific kernel versions.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

