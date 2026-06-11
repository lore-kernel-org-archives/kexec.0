Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642DFCD98C7
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 09:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jad+ABumvty4Afl/cOu2u5kAzyK5CuVnZh2s0pggACY=; b=PzA5FXePy2hO1J0BsPPvaKw0/O
	LmFjXwv9KZZAnap7RG+x0rZOdkqEdrG2e5wuZ+AQaTqJASqMzGxyE7Vs1FgB0zpF6J4+BKkON9RQ9
	YKX2sfQKa77s0QF/udbgbQFZLbjWNvBixscQJs4/NIW2I7tnFtFfge79btq7WYc0fhMkQYAtoo3VC
	n2WwtCll41roW6MFA64IeWMJK5z8hQTcpeemP8tKGhrdi2Cw6Un4fSNWYGrstf9pHaOfQ+v+guV72
	ydg1zTpHTBk5bF1iZaLghZyG9IUxAT0uCf7zjfpiWjnFb1xJ3CQT790il4lIskNA28U4QaLfAXVrs
	dsa3rhnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbkP-0000000985f-2EYW;
	Thu, 11 Jun 2026 09:30:49 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbkN-0000000984R-1G73
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 09:30:48 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bdad545342aso1076916966b.0
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 02:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781170245; x=1781775045; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jad+ABumvty4Afl/cOu2u5kAzyK5CuVnZh2s0pggACY=;
        b=HLVCqLfZrPMN1AXhS/5tn6ABqB30xscPtCUR+fQ1xXrgYsnyOJEWVJ3xkc0LCfEQKd
         RRDsgdb0M+JsKPi8W3gzwtNn/kEWXLfdOaU5pzwPur6C6nEMWzesuHZkSs8qaUdRo/55
         eLXFl1NKZnR7gvAYVZArJsUw3kUm8rHm6d2bxV6rhaYgUVzSIGFMtJ9cMVRRbAXvKhs5
         nOdaC6kcTCdCdOe4JwxvkKHIC3EA4Mz65FnrkF1Hh+smFjmyDcc4e0zoN5G2pCB/YS5l
         l6hT8odsRcInlExq//xS1gQuanMhx7ZyxIKJUsC1vB0v2Id5VYUn3JWl0yPGr4lPGahU
         K2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170245; x=1781775045;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jad+ABumvty4Afl/cOu2u5kAzyK5CuVnZh2s0pggACY=;
        b=k8RR7lM+EfkhmfxV4ic8E4QphcdigBB+QIxebDfcs/QVWqWDDPCWvQ0P+9VPhD/yqu
         z1K516z85/0phabfkRcdNasBQKZkw9f90ZiUfK2xZ6rdiTLq8HazBHjpnYd7zGxp1mlY
         wNug+0dqn9X467z4r0uLQzxvYv+Y1yA9CKlzF1Cp+uVQnrkqnUC5k+N8UT76aAoHrzvk
         rXxFR3u/YNJJeOIFD98tEyn9D+i4lNHZs/yS8AnMGHu4lS5K8ncOPuyOPqcwgCmK+NfK
         xj+3Z+rdC1al0knOurgIUacwVPaJxHHWogEmDBf/a1QKyu12g2L5F5lxhrGMZoHyxLrC
         f7gg==
X-Forwarded-Encrypted: i=1; AFNElJ/HcH1GF22rUfEBdYeuOJLMGxT0VjQprLz11zAlvxSjircP9ibffzKqDspYPA7XyifRTI5WRQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzxtzIl7bhOCgXWp+JHkUX5NQwZ0c7vlp/cB5KnkccGnrFnrHTv
	7TshiGvGK5q1Wit+LrHJFpRPOBSiQP5C/yVX8NmSIYplYrrD5gxbelMMra7Hd+9g8LoJ6A5iDUy
	DfplvtMqN2LI+OEgrWA==
X-Received: from edwt4.prod.google.com ([2002:a05:6402:3c4:b0:677:1dc7:ad3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4307:b0:691:b5aa:5a5c with SMTP id 4fb4d7f45d1cf-6930e2d10d3mr927852a12.20.1781170244568;
 Thu, 11 Jun 2026 02:30:44 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:30:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
Subject: [PATCH v2] liveupdate: Document that retrieve failure is permanent
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, vipinsh@google.com, 
	kexec@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_023047_346526_91E71AFF 
X-CRM114-Status: UNSURE (   9.71  )
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

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/uapi/linux/liveupdate.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 30bc66ee9436..d06aa24350b5 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -168,7 +168,9 @@ struct liveupdate_session_preserve_fd {
  * associated with the token and populates the @fd field with a new file
  * descriptor referencing the restored resource in the current (new) kernel.
  * This operation must be performed *before* signaling completion via
- * %LIVEUPDATE_IOCTL_FINISH.
+ * %LIVEUPDATE_IOCTL_FINISH. If a retrieve of a token fails, subsequent
+ * attempts to retrieve the token fail with the same error code. Failed
+ * retrieves are not retried.
  *
  * Return: 0 on success, negative error code on failure (e.g., invalid token).
  */

base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
-- 
2.54.0.1099.g489fc7bff1-goog


