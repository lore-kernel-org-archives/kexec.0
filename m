Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF8E77183
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 02:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8vUqsqy9SxDx4Z1tYvDGdsUzg3OrjLYvGTeSYGx5cuQ=; b=zUFCinvBrcoeEVZxDnRieTI1KP
	gYfVch51AuW5ctTxPKRSgHPugG7sHXn6wPo3I7p0s4ZLYRlKmea7ij7n1hzsdODcUzpbG5AlynHCD
	rraVRcaISSca9O4ynSVCsRBukjmMShilawFkgwqI1Y37e41s5LWhyL2uF+vUbsy2l5ihcU2cR+Zc2
	zd9Xp95Qj5lCCtOso5CXIXca92Glv9Nsip8PiXCPxqTVc//pAaiu6pFVxSkvPfwuB3uTl02r8OjVZ
	4SmxQWHuSAyCGallAVxtFyPHoSWG93jxECDaYSzkfougwo5YFfc2qxyFjI4UL4M+NEop/xOaSAPGw
	cqtyPtTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLCvh-0000000DZ2S-10GH;
	Wed, 11 Dec 2024 02:58:25 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLCvd-0000000DYyw-1fGz
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 02:58:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6572F1007;
	Tue, 10 Dec 2024 18:58:41 -0800 (PST)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B40B3F720;
	Tue, 10 Dec 2024 18:58:13 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: piliu@redhat.com,
	horms@kernel.org,
	ardb@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/2] ZBOOT zstd support
Date: Tue, 10 Dec 2024 20:58:08 -0600
Message-ID: <20241211025810.242894-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_185821_475228_B786F910 
X-CRM114-Status: UNSURE (   7.22  )
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

This set adds zstd compressed image support to the image decompression
logic. This enables kexec with PE-ZBOOT images compressed with
zstd. zstd is one of those algorithms which is better in most regards
than zlib because it both compresses data better an is at the same
time faster. This is in large part because its written for modern
machines and is less of a byte oriented compression algorithm which
optimizes well on modern 64-bit machines.

Adding this logic to kexec allows distributions to ship zstd
compressed kernels without loss of kexec/kdump functionatlity.

Jeremy Linton (2):
  zstd: Add zstd decompression logic
  kexec: Enable zstd in kexec decompression paths

 configure.ac           |  10 +++
 kexec/Makefile         |   4 +-
 kexec/kexec-pe-zboot.c |   3 +-
 kexec/kexec-zstd.h     |   7 ++
 kexec/kexec.c          |  10 ++-
 kexec/zstd.c           | 191 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 220 insertions(+), 5 deletions(-)
 create mode 100644 kexec/kexec-zstd.h
 create mode 100644 kexec/zstd.c

-- 
2.47.0


