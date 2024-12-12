Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C08E7717F
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a2NKUdFagQKoM3erLHXoMtaJbgNLFhBI+bejgxjrFKg=; b=iPhIQ3J2PbZxiDgXSW7HQTAGAC
	rYIVL6mU3xg7UXeup4rUdEAdG1++1L8UrJvfL7JKgdUdfJdzCrJ3Pipo89yIisWln4BRJFIwOrkKS
	Ao1p1/7mYWEOcmCNTDNvJvzIOgKnio3MWtYwKo0X7ydDIq8/lyIeTgWa19M/pwQb4Cf6q8YRtElW1
	KMqk/UXrdtWCO/FVMZR04u3U86OpZjae9VyLySxDMQaFudqPIlN6Ys1cgqIPbcEhJL2ZSvR/CUrw7
	hoxNoD9tweC1D5f+DyZUWxH8zOwZGJFBlzSbgTNzb5yEfUIPHxZ03jI+K1Hvy4bDJ1PTf4wukkE5e
	cxGdnK+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqWD-00000001vLC-316l;
	Thu, 12 Dec 2024 21:14:45 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqVK-00000001vDe-0DB4
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 21:13:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F7C1762;
	Thu, 12 Dec 2024 13:14:14 -0800 (PST)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF41A3F58B;
	Thu, 12 Dec 2024 13:13:46 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: piliu@redhat.com,
	horms@kernel.org,
	arb@kernel.org,
	dyoung@redhat.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [Patch v2 0/2]  ZBOOT zstd support
Date: Thu, 12 Dec 2024 15:13:23 -0600
Message-ID: <20241212211325.805138-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_131350_130914_1AB1E12D 
X-CRM114-Status: UNSURE (   7.64  )
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

v1->v2:
	Correct some formatting issues
	Tweaked core decompress loop to simplify it
	Number of comment tweaks
	Added PingFan's ack, but not tested-by due to decompress tweak

Jeremy Linton (2):
  zstd: Add zstd decompression logic
  kexec: Enable zstd in kexec decompression paths

 configure.ac           |  10 +++
 kexec/Makefile         |   4 +-
 kexec/kexec-pe-zboot.c |   3 +-
 kexec/kexec-zstd.h     |   7 ++
 kexec/kexec.c          |  10 ++-
 kexec/zstd.c           | 181 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 210 insertions(+), 5 deletions(-)
 create mode 100644 kexec/kexec-zstd.h
 create mode 100644 kexec/zstd.c

-- 
2.47.0


