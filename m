Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58320EEB580
	for <kexec@archiver.kernel.org>; Sat,  9 Sep 2023 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZE0C8JLikO3nAdnp2HKxFCJvZiac4VOYpD/3KFaGyH0=; b=W/5dkLqQ9oPT95
	3FkqMcbluezGwjKEjALnC476RFtrP3qUHuv5F/dhAtXy0r6qbi7jrxKqdvkXTy83s6H9TNsRvHU4T
	EvxBJ75A9fZBnmZ3RViEZWEmqV8o3V+RnSREyV/1K4Bmv+VSJOHU2/vwzxiq0rl3oFgE99ENN5GPD
	GBDcdYrhP6V83cUbakggIpYa0Tg1Vprr4531NvNC7CB51iWdqBqdlS3o1+rG2hiDo1l7NIM3MoGk+
	r/Q3uU/QP7QVxi0OvfqY5PLaFt5Ga/FFS9WkGwpmbnzciC4C6qinavYVnyZCGBEuskojFIXsN1PcU
	GBORW7GitHT5+VdO9ZIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qf0gE-00FcoT-1e;
	Sat, 09 Sep 2023 16:19:30 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qf0gA-00Fcmy-1P
	for kexec@lists.infradead.org;
	Sat, 09 Sep 2023 16:19:28 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 6F5593200906;
	Sat,  9 Sep 2023 12:19:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Sep 2023 12:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1694276358; x=1694362758; bh=M6wmMumG4G
	BxFWlO6TZUur1MLDcccw0IA9bEJxeSNGM=; b=ZQovllt6MTMezPd0k27xXp7Zlt
	eD1Iv0eIRAoAv8bY5pZt1yPp2u0Oxn3SWbD6NVyU37HL8xyI3rZSc1ctFAtIzOop
	iB1XhXzuroyAkhcQfceaYBkNMrITKDt9kcR8PaPLU7nas2SZ1UtI6uudsYWjU01P
	odsqvNgkSVX53gjwQN9WmbI+OLwmOSHjYVXAMIPBgjLi+242+KkBb0zgvWPhn5k9
	WYF2aTe+DFMkaDY6wAvTPQ25pIoQQauOTvBXjX1GeQnLEIdplqh7WlsWjwPpBqen
	E1UWjetRfv38HvP2mv373pSEFQXY9fg9WcdYKatkqVHavVE+JfUrWB1F4aHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1694276358; x=1694362758; bh=M6wmMumG4GBxF
	WlO6TZUur1MLDcccw0IA9bEJxeSNGM=; b=qs1+qeSdE4kiwwsozL1htaz808QAu
	xpEA9BRVT7YL9j20aBJpnDpOYOi9Pbor3bmBHAMUiybyBbSOSNTGS5vS64To7cVT
	K2Q0QfixfA2pozZUxSmjNEyLYDBckXiYZrTqcz821A3MiX4tw2ll5CkFm3J5h9xn
	5tkoVYJsJ1XAVbFDOUOhVFtt148gaviT1J2dQrUMLoS8kx/N0ncxnE67+p3UsDR5
	SURthJg4+a9dOOuUK4WBc4yP7Q3Tsbk3HG60I54NtYi4//JYZTVd1sp91/4lc2u0
	fZxEbvu4uoKIGm+xdnjibCI0zqmISaCFyvwiXrPwuSzIJ2QBzA8PRekOQ==
X-ME-Sender: <xms:Bpv8ZOQHmuRjYDUquUOmY8Nt7juhf9PRZvU-l5vJxr17k2dScXr2cQ>
    <xme:Bpv8ZDxQ0v5eqcJH_Vs7MbJPPVU2iV3F9DJQGYyLETTbsT3NMBHdfRxX_cPahKOVN
    ySXCezxcj0hh8y-GC4>
X-ME-Received: <xmr:Bpv8ZL1pUmpUIK_BvWLn50VTCP3NIbdnpkO_7xtjHJ_SL_ZpPfJD764N26td6THx-49lNe31sJ_ahgcK9VQUy_gYKN0X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdluddtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhkucfh
    rghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeduge
    dvlefhtdelvefghfdugfetieeikeekjeeugeduhfdthffgfeefhfffhfdvveenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhurghpihdqghhrohhuphdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggt
X-ME-Proxy: <xmx:Bpv8ZKA_NvXZiIuNH8lfCnpGwrNVsRH3z09FX83hHZCK03YAdBQa5Q>
    <xmx:Bpv8ZHibBsluqj3N9tbAXe36m881wXAtZhWD3JENLkWLO6aO0CG3LA>
    <xmx:Bpv8ZGqeBGvdiwdPFzn-Br4gPAyCFgV7_j9EwRK5kh2RIJ_-g07OYg>
    <xmx:Bpv8ZAa7_TpCPyCx-lQW8Ge9baHpzDK9bIKjYMn31Qq6N4QljrQcsw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 12:19:16 -0400 (EDT)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	tglx@linutronix.de,
	dhowells@redhat.com,
	vgoyal@redhat.com,
	keyrings@vger.kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	bhelgaas@google.com,
	lennart@poettering.net,
	bluca@debian.org,
	systemd-devel@lists.freedesktop.org,
	kernel@jfarr.cc
Subject: [PATCH 0/1] x86/kexec: UKI support
Date: Sat,  9 Sep 2023 18:18:50 +0200
Message-Id: <20230909161851.223627-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230909_091926_854727_F5EE6AC7 
X-CRM114-Status: UNSURE (   8.61  )
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

Hello,

this patch implements UKI support for kexec_file_load. It will require support
in the kexec-tools userspace utility. For testing purposes the following can be used:
https://github.com/Cydox/kexec-test/

There has been discussion on this topic in an issue on GitHub that is linked below
for reference.


Some links:
- Related discussion: https://github.com/systemd/systemd/issues/28538
- Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/

Jan Hendrik Farr (1):
  x86/kexec: UKI support

 arch/x86/include/asm/kexec-uki.h       |   7 ++
 arch/x86/include/asm/parse_pefile.h    |  32 +++++++
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c     |   2 +
 arch/x86/kernel/parse_pefile.c         | 110 ++++++++++++++++++++++++
 crypto/asymmetric_keys/mscode_parser.c |   2 +-
 crypto/asymmetric_keys/verify_pefile.c | 110 +++---------------------
 crypto/asymmetric_keys/verify_pefile.h |  16 ----
 9 files changed, 278 insertions(+), 116 deletions(-)
 create mode 100644 arch/x86/include/asm/kexec-uki.h
 create mode 100644 arch/x86/include/asm/parse_pefile.h
 create mode 100644 arch/x86/kernel/kexec-uki.c
 create mode 100644 arch/x86/kernel/parse_pefile.c

-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
