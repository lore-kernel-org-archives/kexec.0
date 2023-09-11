Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0D1EE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 05:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=20FiYTFCLa3s6Pp6LJan0lPNeo72FW6Yp+k76HeEYU4=; b=x0kT76dhP1wlwu
	liWB7nXC/CnRDsJZl8zWNwG6xsb0PS4yMkHaEcN6vbgV2ILW6t2N21DiWxbyDsus4hPS6HL3rNO+W
	TE1T1csyiTm0GJEekRk1tcZ4PJ3MdNWAGDZhNuMDsUKgWRy+KmdDG+mZMr6V1gvEzLfSp8zECNa4I
	+t7kuiotuhYrP7OeHkjQIukH92mORTBhTAfuxp528Bb5hHsfW2yQ0qcZRaq993iOVMivDqzT1+ezX
	3MtbffDJ3cWNyjVmtdzg7TPWy7Z5Q+6cIYm9dXsk/pPNlF7x84KABWbhVMRwY8uE+RgzOeoGT3Ekk
	epo3ba2mBELrHXDaGVcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfZRJ-00HGCk-2j;
	Mon, 11 Sep 2023 05:26:25 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfZRF-00HGC8-2M
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 05:26:23 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 2BFCC5C00CB;
	Mon, 11 Sep 2023 01:26:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Sep 2023 01:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1694409977; x=1694496377; bh=ISzuE6kxyu
	373zUFLIZaIlGGdyfh0Ff0EwyJx2kMvEo=; b=iBWyvEFUzLaLY8nJsiWoG4pLSo
	aY6eYkWwkRDrk9DYsEItfexzuVp83R+eQB5tKees5KmO4yqj+SVELB8487RQWhnO
	YCfoWdy0vs7N56B/uOUJCTZuXNnKR3NRntved5jkApldNJBys3aTYwwioq67ZcQp
	GpCkD0JVHzlYmD86Hj7EcfeGHvt4UizUvzrAukyOUlZHCJDG4w6iUu77cd2C2YDU
	KIHDVQZW+OY29gxpj+WPLIhgw/8JMADGdyYdOzvrF3AZ6QtKi1F8h5+PnTQfkzop
	BHjjbEdYBQga0wzQK8CL6ac0SqV2MtikGtG9my7bKbWUavxoY/w5mIWdYEIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1694409977; x=1694496377; bh=ISzuE6kxyu373
	zUFLIZaIlGGdyfh0Ff0EwyJx2kMvEo=; b=YqBLTd/3IdgVhZlUK3o+UtZOhwbMP
	ejbsYMhTrfD5hSNo9/m4t/LlCp4ky9kbAUiNH8SwIGyvefgFJAzzeu8RsZ3bVLlw
	CnpUf3DMWAxFLfH8HbubovtbNHNvkU4he80miP3Xg5Ln6BsRpY2t48Ng5Dy7Hhuz
	9/ukIjRAGuAuFQlh/7WLl4KN0Dw/0NgvRFT0vgkF69SsNjdTYVpLcx+uzWINnl9Q
	sCqTDgHlm1niGbIud/gn5iBGTh3Aid33t25SGqTGfDZdu0tzTMfsIdP6E0T6EhMn
	PjZ4YS5Z6Kazj8p80W89FeQnFji1o23AKzsAr61k8PEjgZV9As8fSGzuw==
X-ME-Sender: <xms:-KT-ZKAtKW2KiLqBE75ukSWS9M9oUlAknLhDl4rJhZItBl4t91FQew>
    <xme:-KT-ZEhJ_JCNWJTjJmeG3aWP76ABG-K_i3I5AHXzWsonmx-sjXCuYjnfzLRJnNROO
    bE4djA9t8_UOpL_1pE>
X-ME-Received: <xmr:-KT-ZNk7Alvkx1Eki4UYeupMBNR1QqLQG83Z7O8FVKc_bz6m6e93VLXcCVlqKeOodWKMghMq8YKr_4xVN6rJz9xRKwwS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdluddtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhkucfh
    rghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeduge
    dvlefhtdelvefghfdugfetieeikeekjeeugeduhfdthffgfeefhfffhfdvveenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhurghpihdqghhrohhuphdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggt
X-ME-Proxy: <xmx:-KT-ZIzdp2A_ugGqsQaf1fCHp_CCMpw407p9kxQK-nlq-kquVF_lkA>
    <xmx:-KT-ZPTg2NnQC48NGHMGWKmuUuXUSTVlgU5HJic3y1yWoKYwb4b5NQ>
    <xmx:-KT-ZDacSRUX1id5a0De2mFiXq9aR4IBIfggRIoZADv4rrTvjccv4g>
    <xmx:-aT-ZHYo90HgkSbKaVqUJ8NKIqH1zUb4BNOUXmmWuTZA7yN5SE1CSQ>
Feedback-ID: i0fc947c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Sep 2023 01:26:14 -0400 (EDT)
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
	bluca@debian.org,
	lennart@poettering.net,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: [PATCH v2 0/2] x86/kexec: UKI Support
Date: Mon, 11 Sep 2023 07:25:33 +0200
Message-Id: <20230911052535.335770-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_222622_157871_D02BDD2E 
X-CRM114-Status: GOOD (  11.94  )
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

this patch (v2) implements UKI support for kexec_file_load. It will require
support in the kexec-tools userspace utility. For testing purposes the
following can be used: https://github.com/Cydox/kexec-test/

Creating UKIs for testing can be done with ukify (included in systemd),
sbctl, and mkinitcpio, etc.

There has been discussion on this topic in an issue on GitHub that is linked
below for reference.

Changes for v2:
- .cmdline section is now optional
- moving pefile_parse_binary is now in a separate commit for clarity
- parse_pefile.c is now in /lib instead of arch/x86/kernel (not sure if
  this is the best location, but it definetly shouldn't have been in an
  architecture specific location)
- parse_pefile.h is now in include/kernel instead of architecture
  specific location
- if initrd or cmdline is manually supplied EPERM is returned instead of
  being silently ignored
- formatting tweaks


Some links:
- Related discussion: https://github.com/systemd/systemd/issues/28538
- Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/

Jan Hendrik Farr (2):
  move pefile_parse_binary to its own file
  x86/kexec: UKI support

 arch/x86/include/asm/kexec-uki.h       |   7 ++
 arch/x86/kernel/Makefile               |   1 +
 arch/x86/kernel/kexec-uki.c            | 126 +++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c     |   2 +
 crypto/asymmetric_keys/mscode_parser.c |   2 +-
 crypto/asymmetric_keys/verify_pefile.c | 110 +++------------------
 crypto/asymmetric_keys/verify_pefile.h |  16 ----
 include/linux/parse_pefile.h           |  32 +++++++
 lib/Makefile                           |   3 +
 lib/parse_pefile.c                     | 109 +++++++++++++++++++++
 10 files changed, 292 insertions(+), 116 deletions(-)
 create mode 100644 arch/x86/include/asm/kexec-uki.h
 create mode 100644 arch/x86/kernel/kexec-uki.c
 create mode 100644 include/linux/parse_pefile.h
 create mode 100644 lib/parse_pefile.c

-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
