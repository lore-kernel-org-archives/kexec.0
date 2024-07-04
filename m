Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D791C30653
	for <kexec@archiver.kernel.org>; Thu,  4 Jul 2024 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qni+B3/OB3BApQJYu4qhxKDDOH3j6/aeg8vir8rbuQU=; b=X5Ffm+IZOD276h
	bQrn4F/z5XkVISA0+uv+Xvi4zEDrExk22ll5fD1ExEj1dhGhLCLDRpJEQ+/+ep7Qlba8LKngbFPDl
	eV3kK93hxMYg0EI+crRNbF3i/5EtlZsWPrfqwBLbXX9GowIVcIgnIv0JN2y3Dfd2v09szsKQMSWYC
	5scyvq7UBteRdTAINp1hFQdCTM/xxPGz4tkFWv6yUs0+sCxSJ5x/giBaTj3InryqyjWqMyZoMM8Eg
	VRT/Vd/F6l5Wqob7WoVJCUZF8naYojazozc1aqrbNDZB+ySoGl08OzJnwe8ILLWadbmEdkoajWGKV
	pKgfhzPdxwfYLSkbldXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPLN0-0000000D6t8-3q2j;
	Thu, 04 Jul 2024 12:15:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPLMx-0000000D6sk-1uQo
	for kexec@lists.infradead.org;
	Thu, 04 Jul 2024 12:15:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0212CCE3438
	for <kexec@lists.infradead.org>; Thu,  4 Jul 2024 12:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C123BC3277B
	for <kexec@lists.infradead.org>; Thu,  4 Jul 2024 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720095320;
	bh=r1vk0YAizuAj5auz3uSWc6OhJhn1k9N3zbH0SY28U9Y=;
	h=Date:From:To:Subject:From;
	b=OahfblbZmotVhOs9O6lODw0/ddrOViwQCoJpssmVBYVvHhx6bxCxcnaadjNUrf1Qu
	 8bImmKO0+j4tnvqTvE26xY7YpefA+SSUVpm9Gmzqbk4VQDZdcucDRX6b+TJqTC1Cp1
	 YIBQM0j4EHXmzG/KJFu3rC8b2do6g82sToMq5VwvVmv6aJA4JLKMZz87nxqK+uFMgw
	 XuM8agsz6swo64Jy9kyaMM545k/e2xMC9Zw4+8XSeS8ZfVSlykPf5dfQyHMCfQ9M3I
	 4jtz5woH5P77P0MQLRuGwmXixTOrsZXU5CssuCl1BUKyUFemhqYj56e6duZSqMcojA
	 vAA2fNqpUjOTw==
Date: Thu, 4 Jul 2024 13:15:17 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.29 preparation
Message-ID: <20240704121517.GA1088210@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_051523_694656_91DE546D 
X-CRM114-Status: UNSURE (   7.72  )
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

I am planning to release kexec-tools v2.0.29 in the next two weeks
to roughly coincide with the release of the v6.10 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.29 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.28 are as follows.

Thanks to everyone who has contributed to kexec-tools!

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
