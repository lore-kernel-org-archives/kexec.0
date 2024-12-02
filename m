Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E9D7831B
	for <kexec@archiver.kernel.org>; Mon,  2 Dec 2024 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tF+gN7LHyZ5Lg+PZUi6vUi9LlGbzcNm9pP+VdVkq13o=; b=Bc2NCuzXgwb9F0aSuk6ejt0MiJ
	OacwqjJJfKz3Q0HpWVm230obQDECAF34g1oltqkJnFbP9W/LPntF1r5J+hHBRKiVe4n80PeCwCqF2
	AgMNV3Zf3ZnNGnjP6Zhvuzua6gpxkPWMqOKy4gI7aw2NBvatz9MBCznUDSXywO8FY+XGbMY8Z4MFQ
	o2vHXX0a5wfCDKxPNYCsqnSMI7i5RNXC5q2/l99ewl8638lBRf5Q3QijYtZuxY8+z7uOWhpLaVD0S
	w9UlKyjPSZG2QVP/A98kX/Hl8W4x44gkefBM8DTHhlpQP3bJFo+NCe1hcu5lxiy9CNzCkcgxmD99R
	8vanVumA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6NL-00000006E02-3zdS;
	Mon, 02 Dec 2024 13:22:07 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6Lv-00000006DjE-3a6u
	for kexec@lists.infradead.org;
	Mon, 02 Dec 2024 13:20:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 97645A40CDB
	for <kexec@lists.infradead.org>; Mon,  2 Dec 2024 13:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342F3C4CED1
	for <kexec@lists.infradead.org>; Mon,  2 Dec 2024 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145638;
	bh=DdJK1Pyu6R3W/fvUuXXj8OXMCv7/Kacm+1520mSDymI=;
	h=Date:From:To:Subject:From;
	b=WtJ9fpSPQyR1HoTL+/4Yenzqc4Bc99SITiOP7rnGN1kvwtI7834QMb7lgwaYPM3K8
	 pV66Kkwi2t0+QVu+mKSowiFT8RXiF2ZKoYG/l3B9q7fOyeEJ1b/UPh5d8d6b6ZWIMB
	 D3iyjghasI0BfEhtjfef9FJrL+fCqN8cY7jN9+hSQsHiD8raW3hZEhezsdm5WF1j5c
	 JOZJfyHNNVhrYUR/CnEhOerJCN2nkJnUoZHwWH5Hu5XWUZGOztPZ7hm13wfhire5fb
	 dHJlBNbvTh/W4M3WFZnDBcl1SmkfFV7tAj45zNn4zkBBW87UBjM+nGNLG6vHTiMO29
	 KSe6hFZ9rPWOg==
Date: Mon, 2 Dec 2024 13:20:36 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.30
Message-ID: <20241202132036.GC3737@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_052039_957395_2D92E6C5 
X-CRM114-Status: UNSURE (   7.25  )
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

I am happy to announce the release of kexec-tools 2.0.30.

This is a feature release coinciding with the release of v6.12
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.30.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.29:

2c8ca05212ff kexec-tools 2.0.30
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

