Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61705C79F9F
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucrMBG1dtLZNncX3iBo9nVwxchXvhveT00DBodHEBe0=; b=cGHc1jGtnrh7V+5byosCTn7iLj
	JNlwdWSz7CzMZDoU1Zf46inItSBmBKYXEi6JV+L4lbBJesV1uoyB2rd3UTAy5fmCNkjf7ECdZmKdn
	nw4LwqVRBnosoBn2gDt+Mv+A55ICMOeFbmKZ2ggXebVoLomyHJZNv7Ozm/3DWvbsQBiLB/B8t940G
	qyiNVtgKPXAiTweyn/+7aTscK9r6eR5OLC3FBEJ4PNXfr/9xqyFSOqt5hxlaoB3zVpROxDQdDq9ON
	rIWtHV0UcM3S9PQ+KdspHFX2ZxDMoEAU60trAzX1jCIFOf9oYQKGZA8n7a3FgIFc3HxadfHt4aG+r
	7neyC4MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ihu-0000000F5AM-3T8y;
	Thu, 10 Sep 2026 17:37:06 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ihs-0000000F59T-3LLL
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 17:37:05 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2d55d8cd938so127827915ad.1
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061824; x=1789666624; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucrMBG1dtLZNncX3iBo9nVwxchXvhveT00DBodHEBe0=;
        b=lY37P7kZhvkx7TURW11x7iXWAHBsho9jLGqf9dKLPJuvZvt2LNRnuvN9rqnbCWVBPE
         jpavUUoCfN6KRgWboJcYM1jC+hmNz+NGlAjLm2NKD9y/4q8U0TilVGXydvdTg5XdPUH6
         NmQ7l3E/s54VpaFlQA6PZxveEZzK1867GB9eWeGYANu5gfC1lwbtPgEDvLXGThdopRU2
         Sl1RHdnYaEn7ktrw2z6tc+hDieS0o2uUQdhrsePYLllJgAcXdjJ7tBw4O99gdyQ8AUdF
         NCQBPPUwhOaCXyBYTBBbmZLIgjRS1s3MmX8Iv+6Ru+YnBBTbR3RkO2aRQtgk2M7dsviC
         svEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061824; x=1789666624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucrMBG1dtLZNncX3iBo9nVwxchXvhveT00DBodHEBe0=;
        b=k2XPFY37MSJ5RBpHJs8U4IMTXMYNrMHu50ky48BbGuTriD1XjiajZOsGhrrOggpQzA
         nSpIbMqu60P5Xs7dEEh2CblJbN9ynYUnPwTtyGuScJ13jAqxPeJ1C+G+Hl7iEe+n01C1
         APFz5aMMF/+RbqjhNULz201feTkY0xzwnsICfmpDvkjnYSPTHBF3Yvqa8aqSFMs5VGbf
         Hbd/azSDjXpnUzmturcGj4bJYNtBb6drSBuFR7A6yYRY3ZaHANxxEzgeofUkj/qPGz2d
         njFjaG6ckdzmS6fIg+CheSf0HpWMtMrdQDmum+N/XvYVUA3erIFDZWpodgNyactrqPD/
         cqFA==
X-Forwarded-Encrypted: i=1; AKwUvBywEdrHW+H/yS4jvC+KOmSMXjaqzLxLL98o3tMoZa3ZFHufPGXS0NVSvvyJmdKciEh0AYKL4Q==@lists.infradead.org
X-Gm-Message-State: AFuF++lmkKQfZSUFnxmhvS9q43BucTXfNajIoEgR4pM1zl9wC8DEm7jk
	j6gSTrfhll7Vxe+eiztSUYOR6CFaLa/qbwz6ObDVjlwZgFzN73z3HU/9QCa/LpLwUGiQXfFQJ9T
	2aLhLN6VGWqKSvQ==
X-Received: from plmk20.prod.google.com ([2002:a17:903:1814:b0:2d9:227b:5717])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1508:b0:2dc:fdde:30c5 with SMTP id d9443c01a7336-2dd2a35779dmr7586505ad.17.1789061823421;
 Thu, 10 Sep 2026 10:37:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 17:36:59 +0000
In-Reply-To: <20260910173659.1945246-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260910173659.1945246-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260910173659.1945246-2-skhawaja@google.com>
Subject: [PATCH v2 1/1] liveupdate: luo_file: Add documentation for dependencies
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_103704_834648_A5FD98F8 
X-CRM114-Status: GOOD (  11.81  )
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

Add documentation for dependencies between FDs preserved by file
handlers. This supplements the previously added
liveupdate_get_token_outgoing() and liveupdate_get_file_incoming()
internal APIs to allow file handlers to resolve dependencies.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/luo_file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index dbae0715220b..a39992da504f 100644
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
+ * and used to fetch the dependency during the .retrieve() callback in the next
+ * kernel.
+ *
+ * Some of these dependencies can be resolved late during file handler's
+ * .freeze() callback, but some of these might need resolution during file
+ * handler's .preserve() callback based on constraints such as immutability and
+ * performance. This introduces an order of preservation. Note that the order of
+ * preservation of dependencies can be safely relaxed later, but it cannot be
+ * enforced later.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.55.0.1032.g73a4cd73de-goog


