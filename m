Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2966C3601E
	for <kexec@archiver.kernel.org>; Mon,  7 Apr 2025 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JQgJbeUZtkNYyjn60ZimgY+eKq6HmGtvolToCT1zCrE=; b=YL39efnZ2C485Fl7eVgLtAr0oN
	QxI9C34HkbpiifIU2ZulpLHnTrd8WmgPyH6r4X63Cz76ycT8wfBX/TB4GCf1OevBGhUj8hiV7o1mv
	M0nVamjrWLN9L5SdrYw21CyA5cZ+mxssUrsJ1rJ7rmqCvHl2pJ4Pln6i6tK+T+lk69jpMLEEWgvyI
	R8zsHroNRLWGe3+DfFjxJPn3rd+zHrVs+c63WQm6iYkk52gbzhSvioyi2uoU0ZidGiIIjPN17MQmK
	++LGzbMBoFhxkg6gpP47iYlELAfEG50GN4J9n51+tfKcjhyBsRZcOMzCljiNMbwqbW3LQD64YONDX
	hG0OCrPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hMv-0000000Gtri-3k2G;
	Mon, 07 Apr 2025 07:58:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1h6O-0000000GoqL-3wRj
	for kexec@lists.infradead.org;
	Mon, 07 Apr 2025 07:41:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8498D49C95
	for <kexec@lists.infradead.org>; Mon,  7 Apr 2025 07:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B92C4CEDD
	for <kexec@lists.infradead.org>; Mon,  7 Apr 2025 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744011664;
	bh=JQgJbeUZtkNYyjn60ZimgY+eKq6HmGtvolToCT1zCrE=;
	h=Date:From:To:Subject:From;
	b=J5KeF69eZIZ+r+ZpYyzQ453pWRa2WoYL6BQcAiUrGjoA5eWGoSEoviSuZoi0S2FvR
	 2z2rQq0UH1VXtwb6tKkUvYm1iHqp9vw4egYjs8Yn3Ia5VU1bAbYOmid7WQ1SVOj+Rv
	 AckcX2PBVHD8JUmSoNIL3TT0uHI4jnB4gw0eijviseX3a0Ag//+Ij+m3qcwh6eHUVp
	 vR9aULXGX59Q8dsOb/luguLot3n8fYucCKzQtkcT5q0BAsvwH/Yy1f80bPaGcXa32V
	 V/iEHDbtnsKDrUrlsiV9Eg+Qs5pwVF81cpYZQXwteWhUsGJggTXftONPkwAixBcMhl
	 hz/IzuCIv+wQw==
Date: Mon, 7 Apr 2025 08:41:01 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.31 preparation
Message-ID: <20250407074101.GH214849@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_004105_006991_0DAD19ED 
X-CRM114-Status: UNSURE (   6.50  )
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

Hi all,

I am planning to release kexec-tools v2.0.31 in the next two weeks.
This is somewhat earlier than the usual every-second kernel release
cadence. The reason being that zstd support seems to offer sufficient
benefits to warant bringing things forward in this manner. And, to be
consistent, I will be open to bringing future releases forwards for
similarly good reasons.

I would like to ask interested parties to send any patches they would like
included in v2.0.31 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.30 are as follows.

Thanks to everyone who has contributed to kexec-tools!

a7fcd424c4c8 kexec: Enable zstd in kexec decompression paths
60ce9bdf0e5c zstd: Add zstd decompression logic
aecc554e7ba8 Correct string specifiers
6aecc32c6db8 pe-zboot: Truncate the trailing zero if Image is signed
455f55c7c029 PE: Extract get_pehdr_offset() for reuse
0475ec5d3246 x86_64: Support UKI image format
c3a991a169e7 kexec: Create a temporary file to hold .linux section in uki_probe()
99d32ffdf1ef UKI: Split out the routine to create temporary fd
21361a91dedd kexec-tools 2.0.30.git

