Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E2C79F89
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFPQMsmC48q+wz7mUdVX+fcsDqeGsLw2XrmLniTg61k=; b=pglzuusBxjCL2cZGxQ1Tk/Nft3
	uYlWq+25y9YyCx0NY/qGFpd9JD7damaaK8spFnMrzm5Q1KbSwVAZpTJ0We2bFuteyxcECDEA0gxL5
	40ymkUu/vqxojtfnfhcnIRR8IYOxV8jpoZKzyIq3O85F+woT6m9w/TPf8QUtI7dDXq7mAwVCYRsSs
	uKHqOGIkkzcqDibVLPZg5IbXkg7NBmzr8iTluxgOq54PRBekOtOa046oAFIYDusWqPegoO7E3x7XO
	qG9i8e/dirmmngK8gDNUq79DH3bOpyT8iLI+OLgnfiGTodt6f27KPiyIm3nXGVLYHsXFB4o2VDiQP
	aEVWCpSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2c2u-00000003Mot-1evx;
	Fri, 04 Sep 2026 22:06:04 +0000
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2c2s-00000003MoD-1nNN
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 22:06:03 +0000
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc1c1cc5206so1780362a12.3
        for <kexec@lists.infradead.org>; Fri, 04 Sep 2026 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788559559; x=1789164359; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFPQMsmC48q+wz7mUdVX+fcsDqeGsLw2XrmLniTg61k=;
        b=ahTcEZKFztgtzuSP6Ykx2vJLA/mUEucQ5lm4eQ42nVFdObPDgEo9nSDgymydCdykY5
         K4i4AZSjIXskSQnF/rT9bE2BAzJzK4Us+ige/rYJydJF+1f1dIuOJOTb+ekxc3CKrXS8
         oOPLOcxGrqrnbHswUGLxzTyGjSZ/0Coyj6OTDIr6qRd1rI1X+woBGFaaS1K1nY9ZDB/C
         W6KphMBB5SVRHiBW2S7zYNT+xvHR3oK68FLlBuuJVvEB0xuIDwhCGrTRCqBA3mt/Uvau
         lj+85623P2h0P0dJKuSH8Xux4ltB2KwN4jcYVnY8sMfLKm+zrDUCOyeCefvcOl/FrUlX
         2QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559559; x=1789164359;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFPQMsmC48q+wz7mUdVX+fcsDqeGsLw2XrmLniTg61k=;
        b=AS5tJKtxlEyejrcqEh+a/GqD5d4zaHjPdUSdsw/AkyukoXK+PpALu35YH5S2BEEnJC
         a0BrYnmx/JbpdZLr9VG6FoSs7n0FUVru3vefPbyjMgl1l4uyKkQR3/nvqHJzOaVAjTvH
         xnSBMstWlUOKe7YaqiMQNG5uOzqecoo3qBlgMKLPlHAGS77/CfPfZ1fHKTD2EOOTouXG
         B/XDiICUqDmuBsLSZdlf1nZxJvcWnE00KoLXnRZDvATWXvefqD0WLZgcBb1JuWH3GfYJ
         y1Y3s68xrxxgHDgKeZ8K1BAnfDqY29DvTnb7KainVvyS3WMxX8zB4d427iV45dLb/w6V
         ts3Q==
X-Forwarded-Encrypted: i=1; AKwUvBySIXLIY/EbAPLEABdgGhs/dk8MfUoIwQ6zm5uCk4eGLKltiju8RsW4BmtXEcc0pTXmqkHJfQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nI+2xVxEfHsDlXBUys+3h4EaxA0DeQrdwlyHmgyBhkM5nd3yog
	R4dAgU7x1ha1wNbATJ7Q4fb8T2PTUgpy5ukX6pI0k4YQ5s6mg97WWZD6iUJAaQh68ouS8h/N0j+
	Vzc2vJxeDONvYiw==
X-Received: from pfbhm10.prod.google.com ([2002:a05:6a00:670a:b0:859:a043:9ede])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:13a2:b0:858:6307:5f7d with SMTP id d2e1a72fcca58-86166dbb899mr12027017b3a.8.1788559558716;
 Fri, 04 Sep 2026 15:05:58 -0700 (PDT)
Date: Fri,  4 Sep 2026 22:05:54 +0000
In-Reply-To: <20260904220555.589752-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260904220555.589752-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904220555.589752-2-skhawaja@google.com>
Subject: [PATCH 1/1] liveupdate: luo_file: Add documentation for dependencies
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_150602_516025_7A12644B 
X-CRM114-Status: GOOD (  11.46  )
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

Add documentation for dependencies between FDs preserved by File
Handlers. This supplements the previously added
liveupdate_get_token_outgoing() and liveupdate_get_file_incoming()
internal APIs to allow File Handlers to resolve dependencies.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/luo_file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index dbae0715220b..0a4994377c98 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -91,6 +91,21 @@
  *    again later. If the issue cannot be resolved, these resources will be held
  *    by LUO until the next live update cycle, at which point they will be
  *    discarded.
+ *
+ * Dependencies:
+ *
+ * Preserved files may have dependencies on other files that also need to be
+ * preserved during a live update. A file handler can resolve these dependencies
+ * by querying the token of the dependency. That token can then be serialized
+ * and used to fetch the dependency during the retrieve() callback in the next
+ * kernel.
+ *
+ * Some of these dependencies can be resolved late during File Handler freeze()
+ * callback, but some of these might need resolution during File Handler
+ * preserve() callback based on the constraints such as immutability and
+ * performance. This introduces an order of preservation. Note that the order of
+ * preservation of dependencies can be safely relaxed later, but it cannot be
+ * enforced later.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.55.0.1003.g10538fe699-goog


