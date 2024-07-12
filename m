Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC408C3DA4D
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=coS5xIAUm20o8MG2wJRfZH/s7b+jxchLkBeVrqh7zno=; b=SeYbTQgyn+bn5M
	EGyePMVSnOgorcxk7AGyDK8W9mJ5ttmdw01wvuy+ak9zH7iZCsi7Zb7cDz/nQ64iMcULYchluoNa5
	kf27Id6QekWTf1fMD6mUHj9FZ1OWUtxy0GQp2Rkzwh4NLrRg4QslBnRHzNcSb31oIQRl6b3GIFK2h
	1QG5bSDOlQJ1T+18U/EPfgsJLRXtOg66YCBFQZWSbLUUBugkCQJVPgsNVGwI0qZ5hidZ1vgdpbQ/1
	PLRbDv7zc9zvyufDcARY1G5nofNV/xutr0Rq0Hnh99JBPyrcbyS3kTF3hVJ5cw1VQ5ojrT5S+pwN5
	ZW5fG4Cf+36yLduR9Bog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSCuH-0000000HBGK-22Mx;
	Fri, 12 Jul 2024 09:49:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSCuE-0000000HBFD-09DZ
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 09:49:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E4C8461E40
	for <kexec@lists.infradead.org>; Fri, 12 Jul 2024 09:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267BAC32782
	for <kexec@lists.infradead.org>; Fri, 12 Jul 2024 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720777772;
	bh=Kv1ji0Xmd4liMbrEo1zve7DDj3GdRF1fFvb8051clEI=;
	h=Date:From:To:Subject:From;
	b=eRsk4Lwg0PJPJ9RTillKbWDn2V8udn4Bans6jlwG/CDqs/lsMzLUOgl9Ct3oNuSFk
	 v+ISMmBCZRv4O+UocsVKspGMh/AnaVX8ET4+4oQU+2FvomwUsbNrnTQHRb3lztUIA2
	 lsS8cwi+BgG1oFE4ffwmoMkuedivwe+iM5N97S/RJ9YPYWhOiyw/Kbgjmn+LR1avQV
	 bDz/BzfQtXjgC7z3G6vtq8Nhwdwb7KviUM50IyJeZCvZOXq6YL1enEzvKvS3ZlEwui
	 fQK8WvJw/IZEu9dvzVQsSw7riF0ACPDyVtqHV9dLzCehYKvTFhWIm5BKb0hOEJHIu7
	 AWOZZLMWKeVtw==
Date: Fri, 12 Jul 2024 10:49:30 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.29-rc1
Message-ID: <20240712094930.GA120802@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_024934_159308_C66B32C1 
X-CRM114-Status: GOOD (  10.28  )
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

I am happy to announce the release of kexec-tools 2.0.29-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.29
in a weeks time. Testing of 2.0.29-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.29 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.29 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.29-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.28 are:

920ae8851837 kexec-tools 2.0.29-rc1
0be146b65771 doc/hotplug: update man and --help
b8408c95e7c0 powerpc/kexec_load: add hotplug support
3c47f384f1c4 kexec_load: Use new kexec flag for hotplug support
4fd0553cdfe3 x86-linux-setup.c: Use POSIX basename API
2e8a93af1e85 kexec: loongarch: fix load command line segment error
69ccfa12d5e3 kexec: loongarch: add multi crash kernel segment support
3194d1eba9c1 LoongArch: fix kernel image size error
2a3e54e9f734 ARM: Fix add_buffer_phys_virt() align issue
f53bcef5063c Fix incorrect Free Software Foundation address in the license
623ceb333c18 util_lib/elf_info.c: fix a warning
9d9cf8de8b2a kexec_file: add kexec_file flag to support debug printing
6ee2ac1bf739 workflow: update to use checkout@v4
328de8e00e29 Fix building on x86_64 with binutils 2.41
94fbe64fb22d kexec: don't use kexec_file_load on XEN
21ea4569856a kexec-tools 2.0.28.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
