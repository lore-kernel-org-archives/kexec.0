Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C5EC47079
	for <kexec@archiver.kernel.org>; Wed,  3 Jan 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4QcKoIPvc615/nQOLcwv/NghQmDbDA5DS4UuXUeiKyM=; b=OwPron1ohhcFIu
	BfIO3TOvrlaQQSOW26UsLOiNnBOrRhLqCgf9dKuZWTNQxO+IJbXRgQhbes1y8J0L5akhKE1AHlDaN
	eOfsmwXl+rUGAHk/0+nj0WCvejWjNkAu7sjBxotKYeJ1oTWIRvsL+rqNsEdwYpAYUxTLgw1VZ4ZN+
	9nziQXyP12aVDg7wzds8WYC3qdXkQ7Fgzc8a6Q8EXAF5u47j6cGUcdU/05ZtW1qOvatfkhGGut76h
	syvhtatdJAeNlo8Lsy7HYLKjT47G7S6Sc8bP5WwIM8OXt4SeC2T3pqJzVmpolQ/VlhbgQ/ehodrT/
	cZG8exe4mCnOdReQUrrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKyMl-00ANXs-3C;
	Wed, 03 Jan 2024 10:20:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKyMg-00ANWH-37
	for kexec@lists.infradead.org;
	Wed, 03 Jan 2024 10:20:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4BD5ACE1182
	for <kexec@lists.infradead.org>; Wed,  3 Jan 2024 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089C5C433C8
	for <kexec@lists.infradead.org>; Wed,  3 Jan 2024 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277243;
	bh=eTYKrnWga/3xz8WxcsQA4atlz8xtTgIsThJWLAjEXmA=;
	h=Date:From:To:Subject:From;
	b=fYBvhF+2Bxm8vfJbz6Nu+1fRstPCv8WRP15DyeEqcZz55CnbcP1XkLuatRRMGuxKK
	 AaYRZBcCKe2t4hHqLEtAw8hmhUzgzK+QKxJYAAr0KUBZKsvFDGTXVxHBBOBEEUWeis
	 Pj/FplUYfd0XMJyOW3Bz/k9A67I25kEDDkf+Dun6RVcmkX+RzQgnftpgc0sUu92XM1
	 /IBR72uqJ01uvfz1DufDaRXX7CGDWfmtfv4g3nc46rgZ6yYSQuiOCnRWHw8G5Y+mZZ
	 VBdnBca0FWUqCCp0Jv5VrVEB1GnqwMtnNBQVGEk9KqeHzAboQiccMUO2vAJhjamU4R
	 m7/BJO5hS5gmg==
Date: Wed, 3 Jan 2024 10:20:40 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.28-rc1
Message-ID: <20240103102040.GA29630@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_022047_290761_0646042D 
X-CRM114-Status: GOOD (  10.77  )
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

I am happy to announce the release of kexec-tools 2.0.28-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.28
in a weeks time. Testing of 2.0.28-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.28 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.28 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.28-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.27 are:

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
