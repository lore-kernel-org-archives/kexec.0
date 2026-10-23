Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59AA606A328
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qBYPwAw6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qec53LB/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r4wmPWcRwAYNvROfFkIzQ3+TvTf3iBKeJ+QLx3ENVDU=; b=qBYPwAw6xdWYUr5aF7bDyLXxiY
	X7xzKe3QqhYe0yv702549Gr3kC6606RvvWGBNyo5pb/v4ogc7OCWLYz2FM/2vQBEAlqdtbGcYMjFt
	OzYi0ooNwubFHrWgy86+1NOTudo+SukryqW/ksfgWg0pOx7F/e1o4Y382oAun2/eZHkOQ+YWTcikz
	dTdBh9qOOS7y9tRj69yUPfqSCDeF/3jFH1AdwXGNaTMuL0rewxCyyC6bgesH5w47CAsQsE66xBczm
	NQINuAr49W0H+fRUkDPeFPk9sO9MsnacSpZmvGPEwiQg/mkVkQGTtCA2sCY/5USneJA6etH4BCd/j
	XYP/pmoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9jC-0000000FkjR-1ROB;
	Fri, 23 Oct 2026 07:30:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9jB-0000000FkjJ-1Dfx
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 07:30:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 508FA424B6;
	Fri, 23 Oct 2026 07:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFBD1F01828;
	Fri, 23 Oct 2026 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740612;
	bh=r4wmPWcRwAYNvROfFkIzQ3+TvTf3iBKeJ+QLx3ENVDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qec53LB/A1eayaCEjYLDFL9z+iuJE7bAuXTc06fl/8KJFTDdrImX2I5Dt6mpPtgZi
	 J4YK9HrpfUneKeQyozUR739UvzP0CwZeRE3vf8si30GCWKbiNowKUqUECkKz/c++GY
	 VFKz57zcN5q/l0HebM2mGTVbJffz17gB2dS3/A93a45UKO70+FZDsOixTXd6bqqXvy
	 y3LiPc1ShAWQty+3eIo8ATnpQcJL7zoHv3Om65qullG30F91UT0l+nvNAj35DUdXc8
	 UrpvYCVdiiZfgsTMn3ipa0c/FgKnYXK7Q8hdXNnA0d5M1FLkfZotYY+NoVjdbNgD5B
	 sgtH2DdeBTRXw==
Date: Fri, 23 Oct 2026 10:30:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
Subject: Re: [PATCH v2 2/2] selftests: liveupdate: Add tests for
 LIVEUPDATE_SESSION_FREEZE
Message-ID: <atsM_WTjuZNl1EGG@kernel.org>
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
 <20261020144710.4154339-3-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020144710.4154339-3-pasha.tatashin@soleen.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:47:04AM -0400, Pasha Tatashin wrote:
> Provide luo_session_freeze() in the liveupdate test library and add unit
> tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
> tests verify that non-zero reserved bits are rejected with -EINVAL, an
> outgoing session with preserved files can be frozen early, freezing an
> already frozen session returns -EBUSY, and attempting to preserve an
> additional file descriptor into a frozen session fails with -EBUSY.

Please teach your LLM to use shorter paragraphs :)

Do we need the entire list of what the test checks in the changelog?
 
> Also freeze the test session early in luo_kexec_simple.c to exercise
> LIVEUPDATE_SESSION_FREEZE across a kexec reboot, and verify that
> attempting to freeze a retrieved incoming session returns -EINVAL.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  .../liveupdate/lib/include/libliveupdate.h    |  1 +
>  .../selftests/liveupdate/lib/lu_utils.c       | 10 ++++
>  .../testing/selftests/liveupdate/liveupdate.c | 49 +++++++++++++++++++
>  .../selftests/liveupdate/luo_kexec_simple.c   |  8 +++
>  4 files changed, 68 insertions(+)

-- 
Sincerely yours,
Mike.

