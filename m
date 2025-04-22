Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597A7C369C2
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4kcXi0c7exJjBPfOwD8rQ33aBiAar1Nud5N7ZdjRcq4=; b=ulnFc7kKQOvS27rJUpGKFTML88
	g2jER7YzIAGTTgkZjOB0VzWdNlk78fjXkDvOnCnR2eecf1BPnfM2ctasYx2oK606x8OMkNDHgPwt7
	9pYRfc74zQIYy9HuKi07EY7lE5OShCfIrtFIBMnUarcIDiVTDt85uyOKfxz7ynXFJCp5/uhuTTv6s
	qvsWdUq+N5w96UhPiQ2t9ALCOF77C2GV6eAwTmL98Hk1ECkELMKzwT7mm2CqdPtqBemSnGD9oaStz
	KR/XTsB5K/9hCednliWXz4EbRwiRSk4Y26ZGNFMQ01doOwTSnJxLQ5RA3+YFrXMSIgii0E7cwg3IC
	cCQrqhTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ArN-00000006l2P-1ii4;
	Tue, 22 Apr 2025 10:28:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79oZ-00000006XOI-46H9
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 09:21:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8939A6116E
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 09:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D84C4CEE9
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313675;
	bh=1IoTMdalR5WRv6kf1QSc0VwRcDFFktbSUDL6ysGs5ZA=;
	h=Date:From:To:Subject:From;
	b=JDohwKJgqKvv64xzDltBJl16DDnrbwUgsfIw9go1DccOrr2gvG/UyxFTtFwMZxRiq
	 ieefj7Y7yD6QA1UGZKGeAp/HdGQyVCNTs/u3EDJSNWeAV3yhqHVod5yd2vFURJjBv9
	 I62i0AYxQ0mTdQkhh9Lw3F5+ZSaRRsc4QqsIYIc3VWVVRbPnB/qI6kvBhw0C2RDeFS
	 oSB0JXo5wZ2UCHS2HtL9fncN4jbQwK+YhYF+OD9UORLg0M31vvX2YSlZgwkk9aUtIp
	 snC7J6cw7E2SUeDP41WxmFWb3Im7H6x5MNPvU5kdhwnSKm8cfdr+3Hid8Qo3FP7ewt
	 pdpEfje1uXqKw==
Date: Tue, 22 Apr 2025 10:21:12 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.31
Message-ID: <20250422092112.GR2789685@horms.kernel.org>
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

I am happy to announce the release of kexec-tools 2.0.31.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.31.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.30:

d0d0a5991526 kexec-tools 2.0.31
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

