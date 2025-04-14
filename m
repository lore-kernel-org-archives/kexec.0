Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185FCC369B2
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nkTx/KNaECJJfWhTzH27BIkNs5tfk4l/WmLtWpuv0j4=; b=35KslAamt9rDxiFDPBDtyybw0K
	PEHe6TSltKEhoNdI7OvKs0S90EXgL9yN4C3CFq5lLBbKYZeGixTRhFatsaqRWmKv39WLEOnACa38u
	zFygHtXY3kp97csTXL+FLClNLfGLGdTFPOisNRPgUOkID1uBtG8r/IDpprtOlTQhlwzYHb+wy4sDJ
	WFJJjarz1Clcemr4wN1F/7tkhmw144DrZpIXuvn4tIN1323w5LxOZXDTZF8HhRAUc+OBAoghbi7hX
	rMK5DJ3AwM7YwEwdFkrYDlSpLN2SU/sEgFuiznWe/opAb1SUGPEdxeL6TBuxNNjsGNQ6/IUfM9KgY
	zrSrumZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Hfo-00000001g0k-0ueZ;
	Mon, 14 Apr 2025 11:08:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4HWs-00000001dWj-2ofB
	for kexec@lists.infradead.org;
	Mon, 14 Apr 2025 10:59:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9701761148
	for <kexec@lists.infradead.org>; Mon, 14 Apr 2025 10:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E46C4CEEB
	for <kexec@lists.infradead.org>; Mon, 14 Apr 2025 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628345;
	bh=g1NUf1WCV+nJFn0rJwm6bCn+DojQizJTHs+Z8bJUQwk=;
	h=Date:From:To:Subject:From;
	b=WCa81ze42mhTAxQD78tMKh6atU7uh/amp6W4E3fZYsUa3VmzQhygEB8/9jr1yCLYY
	 15p3rrBHZKsyhKWNPYPGgaj7VDiADDfO/PI4S6yrUoRa9/X7FhX/Jg0kMg8oZvsYLI
	 yeGAfRMJbt3ddz4zHw1J19BKLW0XfxQXngZUgrDW/shn/XO/Ui81F9f2zDYBsTynov
	 uo/n3LaYIYr7u0uKyjeQIQL5fPACvgWXPByNXblT2NKHpyswvYpdwgjoH7VrLx/pvL
	 NmeNJ2nJiyyaD8NiVNRSoEVFmTMPC+xnm4fbqgmT3BTaE9FEAQfsd7qZxuj5spOtS9
	 RNoYMPqORgC3A==
Date: Mon, 14 Apr 2025 11:59:03 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.31-rc1
Message-ID: <20250414105903.GA1498567@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi all,

I am happy to announce the release of kexec-tools 2.0.31-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.31
in a weeks time. Testing of 2.0.31-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.31 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.31 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.31-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.30 are:

f80553597da1 kexec-tools 2.0.31-rc1
a7fcd424c4c8 kexec: Enable zstd in kexec decompression paths
60ce9bdf0e5c zstd: Add zstd decompression logic
aecc554e7ba8 Correct string specifiers
6aecc32c6db8 pe-zboot: Truncate the trailing zero if Image is signed
455f55c7c029 PE: Extract get_pehdr_offset() for reuse
0475ec5d3246 x86_64: Support UKI image format
c3a991a169e7 kexec: Create a temporary file to hold .linux section in uki_probe()
99d32ffdf1ef UKI: Split out the routine to create temporary fd
21361a91dedd kexec-tools 2.0.30.git

