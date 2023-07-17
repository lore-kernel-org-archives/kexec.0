Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8929CEB64DC
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7CSxseN3dRrOgFPW/LOViQL49Ck5amie6F1RP7AOy0k=; b=iEnOLz5xjUy2IL
	ROou1rE3A1bQjN2WPv9bZVv73GxK4wCrsVq6ekJXzkSFdaJ6E1Gr4mLbpNZpFcbcIB3OlP5Ub0ESr
	XV1xGtnIw6MfWpL7eH5IJ6ZrmOIqWngPxx9Z5+6T46wqjAPvv0EQFLjgBycO8MkDB5K664PghY+lu
	y2mokrfmabFTAWebej2hFKNYRC4gyS6HKP3x/6opo1A9shMmmI5fCEEON7DroezP6WbH+UTi8flnj
	e9BKWvuyYQU78uwcZ8VfjuaDZspFmtgmJEhfA2dUQbJg+B5YS04VFYH4U3+zcFUKHBUAZ1POFW/jZ
	vG1+BHEZLtl26a4c+I4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxn-0043yi-1a;
	Mon, 17 Jul 2023 13:08:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxD-0043vs-2d
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zv0ZIBcubRVFd0aPY9hgjti2jW8lVVyFHpftPXK2YY=;
	b=Z7K6slPIG2T+qUEfSeedvk5WH2DacMHr9UfyJMxz0V4qSGJypsIF6pNuNcfj2HTyyyVtAz
	xE/1yPQrmOXX7sXgeQdcn7mk9KDpxQsRP+HTZUUH8NakQJUx6ih2pyRQDgcYBVSsQy9/fd
	F94MeKhOa45rk5nITsBpUhvH05mb1mw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-DAqKbSnEO8SyRmsu-l4maQ-1; Mon, 17 Jul 2023 09:07:52 -0400
X-MC-Unique: DAqKbSnEO8SyRmsu-l4maQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93D548F77C6;
	Mon, 17 Jul 2023 13:07:51 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6C34E1121315;
	Mon, 17 Jul 2023 13:07:47 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv5 1/8] arm64: Fix some issues with zImage _probe()
Date: Mon, 17 Jul 2023 21:07:25 +0800
Message-Id: <20230717130732.22710-2-piliu@redhat.com>
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060756_223237_B99C7D85 
X-CRM114-Status: GOOD (  11.38  )
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

From: Jeremy Linton <jeremy.linton@arm.com>

Current compilers note that fname will be null while
attempting to print failures from strdup().

Further fix a memory leak caused by kernel_uncompressed_buf
never being used/freed before the allocated block is replaced
by the one returned by slurp_decompress_file().

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/kexec-zImage-arm64.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
index 6ee82ff..3eb1ad8 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -55,8 +55,7 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 	}
 
 	if (!(fname = strdup(FILENAME_IMAGE))) {
-		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
-				fname);
+		dbgprintf("%s: Can't duplicate strings\n", __func__);
 		return -1;
 	}
 
@@ -67,15 +66,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 		goto fail_mkstemp;
 	}
 
-	kernel_uncompressed_buf =
-		(char *) calloc(kernel_size, sizeof(off_t));
-	if (!kernel_uncompressed_buf) {
-		dbgprintf("%s: Can't calloc %ld bytes\n",
-				__func__, kernel_size);
-		ret= -ENOMEM;
-		goto fail_calloc;
-	}
-
 	/* slurp in the input kernel */
 	dbgprintf("%s: ", __func__);
 	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
@@ -128,7 +118,6 @@ int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
 fail_bad_header:
 	free(kernel_uncompressed_buf);
 
-fail_calloc:
 	if (fd >= 0)
 		close(fd);
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
