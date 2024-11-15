Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E267DD6DDEA
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6weGsHZJ7lEDeIWsom06LawWMAtqogWmg8RFr72Z98w=; b=cFM/nPKt4Z+4PoONt2Z2fGevsJ
	Zszfe0ypUfq20GkbuoKzHSF8fG15B+3etpiv0qLBDLml7LUDrBx+hepooex/Cess7haf4lLwAZ7BX
	ZKsAdwWXzqwzbKygy3UtH4qQbFb9PKzbUAnpbbVkbuXJZFAA0uSLm6G/1RSMUYVlSsahNb96QvERo
	gNII0mYL2ZCYJShnwVxInuXb0L+5f/2tloMDkAscYIf7BLwuQfxI0c/Kg9O1PDpkmNmBLimbdtqqx
	VffBpGwTrL3I/CguKjRUqbaWhE4ZZIVS9hrda42ur5/Bq45FyNpTq81rLuzgf8gzp8ztuem3vJh+K
	PiPxgRfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBt3e-00000002GYr-3q3v;
	Fri, 15 Nov 2024 09:56:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBt3Z-00000002GWe-1hZq
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 09:56:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AAD9F5C627F
	for <kexec@lists.infradead.org>; Fri, 15 Nov 2024 09:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA9C4CECF
	for <kexec@lists.infradead.org>; Fri, 15 Nov 2024 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731664560;
	bh=ENaNivzPiDPpZqroDQJd9wuHbAhyw7gS2OA+hTiEu4I=;
	h=Date:From:To:Subject:From;
	b=W+cDjN9szewDOl9OWJ6nsPEXIcPK3bwGTfdHbmQSrGfbvLay7FK6ODaeXrPalzBvu
	 pkjIBj7u7357LexonyH7HqkiaBVZh5t6Oio+uS3VkhwvIh0r/9v2ZPoB8ol4vM+Rey
	 zXbNU8/K9At8IErf+xa04rdxPNRmaktMYzFHFu0zmUuCCWlginUmTIKNqrGZKzQSEZ
	 EacyhlZ/HQjat4yIM6NM7M4ztgzwL6P1h4HZEpJprDc+NT8wMfu8RSoVaMLnDBEhai
	 TBBjrzClTPoUoZ18EjUWWom0lw1AOzMhhKvEODmKjVRC3xiCONhpRLPKll149JILap
	 UEOfkNJt3FRsA==
Date: Fri, 15 Nov 2024 09:55:58 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.30-rc1
Message-ID: <20241115095558.GH1062410@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_015601_496902_4425ABEF 
X-CRM114-Status: UNSURE (   9.57  )
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

I am happy to announce the release of kexec-tools 2.0.30-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.30
in a weeks time. Testing of 2.0.30-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.30 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.30 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.30-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.29 are:

a7fcf2b90916 kexec-tools 2.0.30-rc1
07a6217af3cf kexec: x86: Include pref_address when looking for a memory hole
ec3e4dfeec22 kexec: x86: Use init_size in 32-bit case as well
fb9302eb9bc8 Fix fd leakage in uki_image_probe()
13e0a9327a42 Before adding to usablemem_rgns, check if the memory range is already included.
cd360f9f1aac arm64: Support UKI image format
0c72c4426ff5 kexec: Introduce UKI image parser
14fde160b906 kexec: Introduce implicit_initrd_fd to pass internal initrd information
ba1ad3017946 build: Update configure.ac to follow the changes
d2f42971661b util_lib/elf_info: Fix format specifiers for fprintf()
07821da7cf96 kexec: i386: Fix format specifiers for various printf() and scanf()
8767f1e1b25e kexec: i386: Fix 32-bit right shifts on 32-bit architectures
5b76649e0c23 s390: add missing limits.h header inclusion
8dd984687b79 kexec-tools 2.0.29.git

