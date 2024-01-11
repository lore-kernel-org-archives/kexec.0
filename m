Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB2C4707B
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TCmsgWNdbOMvh5aMzNEDIvX2rfbDlCk+6l9mmjXtghk=; b=oCHEE6SQ6cDcL6
	zoWp5OJ3qv3YPay2go9myHUgqK1eOTDzTWa/DsrCvm3GJI+HtUVnPF6DE93b6SUVQNIxOi0b2TfOr
	SV1ZzrAiNjs3ld6ZT3EVT/dNNHPgHwdcyEwH7lwbLi8qE/hnK9vrEHWNw9qB5Q8c7anLZg58AjTcO
	tgnspbmkIqRFTB0qyDS4pnsosChDLbM9xRlAuCOKsaSekJeVmpP8V73bvOfQI3uCHOXl2tRF+52vx
	72vEPjQrQB13GZFDxVm4AWaK4VzGRHLcualgSuwAGgndNqaRjlSocvTZPUAv0IXCOr4tD3pOEU8ic
	MC1PvRNCWS/jASJ3UD3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNtQa-00HRJ6-1m;
	Thu, 11 Jan 2024 11:40:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNtQX-00HRIZ-2W
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 11:40:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 38E1E6194E
	for <kexec@lists.infradead.org>; Thu, 11 Jan 2024 11:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA14C433F1
	for <kexec@lists.infradead.org>; Thu, 11 Jan 2024 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704973248;
	bh=ns/K5VlCfzRLiziFjRvD1qeu6rENymTtphmuY6VCfd8=;
	h=Date:From:To:Subject:From;
	b=ismFpEY/GDHOuauGLTq7alTVA0wqg3yLAobW8Ku7myrjX+2Gw2+3GMLhuLDVQZWJB
	 xWgm5Dceulh0wBT/FdYwGHXNulY+bpko78Qt8CKF+X6teLHmj1Gs5icqfsCHLIq/0+
	 GAOLiJYnngrgP+qMuH0FTGhJvZ7jK9r3pTfLZx9HCbPG3ToToVlRD9JPXshbs10x15
	 nAqZ4UK2wX7GDzuLnpqO5i2AO+ImYxabe2SsFGduDRI4OGjQhN3Qj+nD8mWx1iQ+7L
	 uWFdoDZiL2JKeIXKBLsXykICWGxaArhJJOIOz2ObmmYQWxq6NvXuzMg4C+yXTFLlDH
	 o1Chsf5PfYj3A==
Date: Thu, 11 Jan 2024 11:40:46 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.28
Message-ID: <20240111114046.GC1312035@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_034049_858411_392D6321 
X-CRM114-Status: UNSURE (   8.25  )
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

I am happy to announce the release of kexec-tools 2.0.28.

This is a feature release coinciding with the release of v6.7
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.28.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.27:

adef8a8e4bfd kexec-tools 2.0.28
5d7bc25cf15b kexec-tools 2.0.28-rc1
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
