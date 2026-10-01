Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D5ACA5FD2
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMPGmzqrPtOSz+orjSMVvFs/mFFB+41nKh4Vba0ZvzM=; b=zAbnRMhUXDq6NLhbiBX9jNLh1d
	AzVEijxL4642iVbXnyHfzvQW6ibuR8OIKKx64FqG83fSt65jbuonJ4UyevMdrfeN5pf4iseIrV2lf
	ySv2H0tmOo/aLK4Ni0DD4Hqe90bvdOSnflxcxAn2ztJEBRhCK7RjeIVKII6rJkNbWuAc60Tc1GKkJ
	8bUzRUrOsp1TKdIDj1FB+WrvCMquPlwUt7PYEiCza3A2yS+PD3/qDckSlHVjQfzAfuQx1EPNK1dOU
	F3jZ7n7Gz34GkwxZyVrG9PhC2pNOJ1yQhRNa9ci49nC4EE5HWg80JwtdJ27Q9yV14ZCz1HcxELEpu
	Kdkg0iDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57P-00000007XJV-1I0Q;
	Thu, 01 Oct 2026 00:57:51 +0000
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57L-00000007XG7-3aXj
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 00:57:49 +0000
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so10677405a91.2
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 17:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790816266; x=1791421066; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMPGmzqrPtOSz+orjSMVvFs/mFFB+41nKh4Vba0ZvzM=;
        b=eHkx6giZj9vA8HZuH8BrkwJlBjHfT1hq0ekM125tweFvUIaZyLRTWreCOwoM/yuuXL
         NBBr5I3hTU2X4ExOFNc/x0cQbGUXFv9bPiTF9wDqDa9rYtJcpFAYXdoJ9RyKpxiZB6Sg
         W9fi8J2wP3Vrw3Az2Dp+2jxPd/D6VZjfrn/+ps0FCn2qZKo7rczG7qSjeMkoLuodj+Dh
         Tr95+OoN8Ekle3dvWBWg8PBCMLYIE5aObfhWxWKhTzgup8hQnbAAWaBkbDmrrpp0ThGt
         r7HZhKgv2S4Ap0al6Wdck2IzONestZHMKtS0rNq6+nyw3E3V4jB6jo3XYR4rFngv8cLu
         fTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816266; x=1791421066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMPGmzqrPtOSz+orjSMVvFs/mFFB+41nKh4Vba0ZvzM=;
        b=d7aUqb/M2JxtpZnh1NqUvmIxcDWiaEJfvtqGwqIyg0OMvzvpZP/MAHc3FyqOO/+H6T
         8AfsL7Nc1CfEKDod7eVJuuMG4bmXoo1jt3p+kI+RU2PVQ6KCnj0LxIFmVfEcloaexgwG
         +djEr8TEUbMdoF/wLdrTlP4uj49S9p4FwLe06+3v4yI/hzLP93oDfimlWQEPifF4szg3
         snrJdkf584MV5z0H6+TIkCp4fBvCVNsp23ZYh4igRpATCPzd+/9XeU23Xd7BgCk5hlzJ
         wfy7432WPa7BJFkueN+BW2W+8yf2/YRu/etlGadgLZV6hr1XifvAu5HKQ3YF6X1o/2CB
         +Lgg==
X-Forwarded-Encrypted: i=1; AKwUvBx5Lva/GBNokMhCQ4fuU0fyZbaAP3yWVdSEwciDkqmzMrOF7VqPOAeiKVi5KPQyCEklW14wcg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJHyXjtb4/wIZznJco2DkQzsTyZVWWEszZXAGZ/po2rQvL9Vaq9
	OfZaxK1sHVmCeEkxa4TkmPLj8hE532L+nfzTHLkL6CYTxFhSIx9bQIRj+C/462Cxgj3BI5VuqNF
	bt6uatIm9mzzuKQ==
X-Received: from plei13.prod.google.com ([2002:a17:902:e48d:b0:2e2:dc3d:e914])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b8b:b0:3a2:b490:c459 with SMTP id 98e67ed59e1d1-3a4d1787222mr2759686a91.25.1790816265844;
 Wed, 30 Sep 2026 17:57:45 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:57:34 +0000
In-Reply-To: <20261001005734.1033516-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20261001005734.1033516-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001005734.1033516-7-skhawaja@google.com>
Subject: [RFC PATCH 6/6] iommufd/selftests: Preserve all the FDs in a batch
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_175747_903323_EC692AED 
X-CRM114-Status: GOOD (  10.55  )
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

Use the luo_session_preserve_fds() to preserve vfio cdev, iommufd and
memfd together in a batch.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 .../iommu/iommufd_liveupdate_kexec_test.c     | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
index 26c7e15b6187..3ce282fc1a33 100644
--- a/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
@@ -153,6 +153,9 @@ static void setup_iommufd(int iommufd, int memfd, int cdev_fd)
 static void before_kexec(int luo_fd)
 {
 	int iommufd, cdev_fd, memfd, session;
+	__u64 tokens[3];
+	__u32 failed;
+	int fds[3];
 
 	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
 
@@ -174,9 +177,27 @@ static void before_kexec(int luo_fd)
 	if (!luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN))
 		fail_exit("Preserving iommufd without memfd should fail");
 
-	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
-	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
-	test_luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN);
+	/*
+	 * Batch without iommufd: memfd is preserved first, then cdev fails.
+	 * The whole batch must be rolled back, including the memfd.
+	 */
+	fds[0] = cdev_fd;
+	tokens[0] = CDEV_TOKEN;
+	fds[1] = memfd;
+	tokens[1] = MEMFD_TOKEN;
+	if (!luo_session_preserve_fds(session, fds, tokens, 2, &failed))
+		fail_exit("Batch preserve without iommufd should fail");
+	ksft_assert(failed == 0);
+
+	/* Full batch, passed in reverse dependency order. */
+	fds[0] = cdev_fd;
+	tokens[0] = CDEV_TOKEN;
+	fds[1] = iommufd;
+	tokens[1] = IOMMUFD_TOKEN;
+	fds[2] = memfd;
+	tokens[2] = MEMFD_TOKEN;
+	if (luo_session_preserve_fds(session, fds, tokens, 3, &failed))
+		fail_exit("Batch preserve failed at index %u", failed);
 
 	close(session);
 	session = luo_create_session(luo_fd, iommufd_session);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


