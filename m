Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E86C46CD2
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gQxKNqGMALzdQ4EfvlXYZ4aoKsCbQZ+eviOBKvGax2Y=; b=omDVvK3E+MGjR3
	9mWmBQbP5yvkIwra4aq75WEbXgBNUQLbBThnjlt0zAFKBWfHL2fa3/1q1WQ0z4LV5ZrPtqwgI0ewt
	8pOlpb6kA4LbU/fXL66eHQqkyGUIzbi5OfGOiDnPL07pEc6gzc2bpi2uzUrY1eANk2UnVmYlKcEAq
	bjquig6fTfnvejk4ie8s1sbTMjB8iCwppe3J2SqOCTmgL+/2qIBKxhrqlZXI0qJPlDByvtvyOhg8O
	3V87omuCVaMZIYk1CVjDIhPL+KQDg1YFNZs+Kep5M107CXgH2YT8gGhQUXkGBCLqdcU4y183wo5j/
	oFtvbEu5JsxZS/wT366w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGmw-00BW23-1w;
	Mon, 18 Dec 2023 16:48:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGms-00BW0P-1q
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 16:48:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 00581B81038
	for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 16:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FFEC433C9
	for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702918091;
	bh=m2s5nMY/7ge0NmABCX7/6/XOb+1wuLsrKwG4msYK5BY=;
	h=Date:From:To:Subject:From;
	b=rEfr5/3Ot2gfcerGtFE1YtVDNX7woNkH+A5kMx3OrSWn9Z1d+d+oMo627/q2BOe+5
	 F5FzJct83ibygQbho0gcVHDju02tXKZ4w+5XfpdIM/1itHfkVzmdINV81sQyLFGXmI
	 eAhDpQ4gOKzhHByhI4EUhMyJ51/EGmWHeIQdFZWUlqmRpXkh218UmsLnqd3utQWgRe
	 LYAq7S4Eord8mkLXFtGzXORDs+h1m0uGHVFAbivKwKARMrlVp5Qyt+/+40/GfrodDJ
	 ycHNfa0SzCZAw0XNjUpd6pTjbRU1RNTi5I4N+W3kpmlwM/sLB1aqhncevNRciy2guB
	 KfvHyL7OnXgug==
Date: Mon, 18 Dec 2023 16:48:08 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.28 preparation
Message-ID: <20231218164808.GA759837@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_084814_797209_1846238E 
X-CRM114-Status: UNSURE (   7.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi all,

I am planning to release kexec-tools v2.0.28 in the next two weeks
to roughly coincide with the release of the v6.7 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.28 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.27 are as follows.

Thanks to everyone who has contributed to kexec-tools!

549466430ae6 LoongArch: Load vmlinux.efi to the link address
ba0ac0efe299 LoongArch: Fix an issue with relocatable vmlinux
74dfaefd6316 m68k: fix getrandom() use with uclibc
22dcf5cb940a lzma: Relax memory limit for lzma decompressor
44e7b73c331f kexec: ppc64: print help to stdout instead of stderr
74d66d405f30 workflow: update to Ubuntu 22.04
ab3a70af8567 kexec/loongarch64: fix 'make dist' file loss issue
6419b008fde7 kexec: provide a memfd_create() wrapper if not present in libc
118b567ce74a crashdump/x86: set the elfcorehdr segment size for hotplug
d59d17f37239 crashdump/x86: identify elfcorehdr segment for hotplug
a56376080a93 crashdump: exclude elfcorehdr segment from digest for hotplug
75ac71fd94ff crashdump: setup general hotplug support
d6cfd2984844 crashdump: introduce the hotplug command line options
c36d3e8b2e99 kexec: define KEXEC_UPDATE_ELFCOREHDR
bd0200c47c45 kexec: update manpage with explicit mention of clean kexec
2495ccfc5206 zboot: add loongarch kexec_load support
8f08e3b51f25 zboot: enable arm64 kexec_load for zboot image
c3f35ff06e54 build: fix tarball creation
056c179cd3c2 kexec-tools 2.0.27.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
