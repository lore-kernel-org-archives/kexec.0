Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39887C7EE25
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZD6lJ+RM0YH4zHQ6PImtlOQJzsHDD2PS1wwc0EzvflY=; b=3KwsZ3ZYJZSyjz
	Pk1skf/DD6+LTdF5/EyxaUBZPbO22iZTQHyzskb6naZF4Su+ErGvc55k9FUoxF132lG/VqAOBGuFs
	mwHceVU26+luyNkCCf2mV+E/a9T6xOh7PCEnOlTtQjUFvm+i9ugSlp5a1heT7ZnHJh/W/azsNe9FL
	tlGT5quQ1BgdhNb2Mo8MUBxLQFWFZOorI9jxKuDu26hIpR5A7b9tLqJD9CXhZp/xARR4bTkIKZXZD
	6/aLrl1n+mySMt0OYFkbXvfu/OFrzkguzzE3Az6O8sUcELH0L6pl/9745YiolHKddrhYdkFNyau6w
	jzOjRv1Mcz+OkT1m1NcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1p-008M3f-0V;
	Thu, 04 May 2023 16:42:01 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1k-008M1Y-2d
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 16:41:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF71D1474;
	Thu,  4 May 2023 09:42:38 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37A193F5A1;
	Thu,  4 May 2023 09:41:54 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	piliu@redhat.com,
	bhsharma@redhat.com,
	ardb@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 4/4] arm64: Fix some issues with zImage _probe()
Date: Thu,  4 May 2023 11:41:47 -0500
Message-Id: <20230504164147.1166614-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504164147.1166614-1-jeremy.linton@arm.com>
References: <20230504164147.1166614-1-jeremy.linton@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_094156_933384_752D188A 
X-CRM114-Status: UNSURE (   8.59  )
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

Current compilers note that fname will be null while
attempting to print failures from strdup().

Further fix a memory leak caused by kernel_uncompressed_buf
never being used/freed before the allocated block is replaced
by the one returned by slurp_decompress_file().

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
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
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
