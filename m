Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D1606A337
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EgeyNv9N;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=aW3hOf3T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+Vi8Uo03fcHCO6cbzt4Mec26MkR6iEWVyQcc5YT5w1Q=; b=EgeyNv9NLSTyfD
	E3ptzkYBVaJCkRxhVzmMO6oxF3Wxg59AT3/jtieREdnWZ9+wIX4KnNZiSgwkOuVuLVEXZ+23pzwZ9
	l8Ux0rs2yxhAq0J/DgNN36CnrEKvzcSDANwPjzsWKKerJjZ3axTsZZVXsvLoe2y6dUQxScuVQ6GKZ
	xE7UfFewBSysocBrHJ3tfMn+jiHnRiEr36geT1up8pshyVt7i8DQTEz6QpurOc6I1MnvMDN4nAzrd
	sawbDseKQurvTAmzTMsM5jcEMiQwhRWY+yLwB4DJQJSZfpWWXwyx+YMfm157b7YRoPZ8gtnSFTWAQ
	eZMz6ssITP6oyzYUODGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaKq-00000004nF0-1gOA;
	Mon, 23 Nov 2026 20:08:20 +0000
Received: from outgoing2021.csail.mit.edu ([128.30.2.78])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaKn-00000004nDL-1ChB
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 20:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Vi8Uo03fcHCO6cbzt4Mec26MkR6iEWVyQcc5YT5w1Q=; t=1795464497; x=1796328497; 
	b=aW3hOf3TR/vMm47JYd4bgacFurNJLfItiu4l8buXflBbT6PTeR1xIQVNzu42YFXU1wQPjpA1/uX
	8/zWbu+A7j10xPEB/IfibXgTOQ5M5PZeyx+vhP2JhmrpDKeaGoYTXYy7H1Kt5QjgfDXQsT8O1vz0y
	x8DAegEhIBLrbvOkgbp+X+TbulHF+qM+N7qVpZgZ7zKKpuB9QPGwyIsdrFtqnKKTvLut4+BiAGOFv
	xlRy9G0EusxDkLjHvNEHViM6Af/O5zF1gYiYETz4SxETaWtiZK64LV+aFxX6wi+R9BE9usAd7LixT
	TMUove6Xrz+y/sVbsVYlhKSmXCiEa6DV6LhA==;
Received: from [49.207.211.146] (helo=[127.0.1.1])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xVaKf-006jgv-EY;
	Mon, 23 Nov 2026 15:08:09 -0500
From: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Date: Tue, 24 Nov 2026 01:37:53 +0530
Subject: [PATCH 1/2] MAINTAINERS: Add missing files to KEXEC and KHO
 subsystems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-fix-kexec-kdump-maintainers-v1-1-79c6a6144de4@csail.mit.edu>
References: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
In-Reply-To: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_120817_332209_8C06D28C 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several files related to kexec and Kexec HandOver are missing from their
subsystem entries in MAINTAINERS. Hence, scripts/get_maintainers.pl does
not currently recommend the kexec maintainers or the mailing list for
changes to OF helpers, IRQ shutdown helper, purgatory header and kexec
selftests.

Fix it by adding these files under the appropriate KEXEC or KHO entries
while preserving the existing Device Tree, IRQ, selftest and live-update
coverage for these files.

Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 012a21e4afcc..bb4d9c20db06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14775,10 +14775,14 @@ M:	Pratyush Yadav <pratyush@kernel.org>
 L:	kexec@lists.infradead.org
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	drivers/of/kexec.c
 F:	include/linux/kexec.h
+F:	include/linux/purgatory.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/Kconfig.kexec
+F:	kernel/irq/kexec.c
 F:	kernel/kexec*
+F:	tools/testing/selftests/kexec/
 
 KEXEC HANDOVER (KHO)
 M:	Mike Rapoport <rppt@kernel.org>
@@ -14791,11 +14795,14 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
+F:	drivers/of/kexec.c
 F:	include/asm-generic/kexec_handover.h
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
 F:	include/linux/kho_block.h
+F:	include/linux/kho_radix_tree.h
 F:	kernel/liveupdate/kexec_handover*
+F:	kernel/liveupdate/kho_block.c
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
 

-- 
2.43.0


