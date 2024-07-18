Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9CBC3DA60
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BjylcDsRkVXvnGmiz0w3NfPWEmCPvS/+xc7dgMZ7gD0=; b=L9eKUicQSWsgZp
	5s1/BP3U5yIuPFq8N5qFUJQtXWUKo/FBD7OhOmTIHzOczElknYybKopHvGtgdz+b2cfutjWcJpzap
	jAtvS/qksGhG3iGneN9NbpqxAoxmKdPrbgVxVxRgvInI/82+8UgoxZI7zkZCfH3vkIbM+OiOwP9Xe
	MtVp26FS9DnxJqNk4f3NeNF3cyhV1PvgWgZ+Wn0dX9XRYZKx14NL9+zqIQvrHbX4MpewH8w0LIuZ/
	iqjCcexwRxvexHc6oPc15qAVamgiR3TNWWElnLHFZE/y+qK0GyilP9UWsInoPp1g7wbEvB0i4jufz
	wF24B71B1QIn69y/vbSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUNk2-0000000GbQw-1z3T;
	Thu, 18 Jul 2024 09:48:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUNk0-0000000GbQJ-2Ia5
	for kexec@lists.infradead.org;
	Thu, 18 Jul 2024 09:48:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EDA8161A6D
	for <kexec@lists.infradead.org>; Thu, 18 Jul 2024 09:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C655C116B1
	for <kexec@lists.infradead.org>; Thu, 18 Jul 2024 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721296079;
	bh=9MuXB0CgTKaaQSRnEGipL6RN73STbk4gcAviJU9yCcM=;
	h=Date:From:To:Subject:From;
	b=inZE5bYRdVf0Hq5LYF66pXQQj5pMWQbRC7T3Up1D4T2pA2j9s3FManJz7Wng8U0X6
	 OXAU8uCDRAGUbgHnHchHffCR/CvlF+2ToJPeqsJ21mp2zS0+LcdbXoeK89vMpaX8i4
	 atbRFGxTgPPBbZxEENe4/u10Ctnk/ZgzF8omf50RY04hOWSX5M9MlJzDcLMkF0YMp0
	 sYQVlvyJsZvpOUQMM4Umk2kaSvwzM9jEnWz+m+fka7vf9wepHHxE1XrZ95qCCOBCsn
	 o1bx/VxSpbvmX7ijXv3zNPgeKL75jk7j0b5sKL/yPcZwIB/OaaMZw5ihrPf041ygXH
	 JW96RGzeHHG7w==
Date: Thu, 18 Jul 2024 10:47:57 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.29
Message-ID: <20240718094757.GA617987@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_024800_655807_5D072454 
X-CRM114-Status: UNSURE (   7.86  )
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

I am happy to announce the release of kexec-tools 2.0.29.

This is a feature release coinciding with the release of v6.10
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.29.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.28:

992c419f6cbf kexec-tools 2.0.29
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
