Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF19ECA1001
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFY07kvOZ8n+on6q5CM7v7BCfr6Li4auFTnWartdWMw=; b=FgKdycZX2qZ7KcSPRgfwxy5Bc2
	u5KX3LKWYpZAToZybBZWO4ty5X8nvS4K7q5j3OxOfEaqb42HYUc4CFNFpzw2XpnwyVXdT+syEqLeF
	D+D4bLFvYralcDI2igoLtuV4d2GKAroAzr5+f99o7Athcrp79wFgJJNATUUHrTKIDfQ3VnwB+nWT5
	JsHr5E/1DezptNh9WByqotvg9L4JJFIbaF8HkVsLQO0GOz7y8NDCilLcWmwl7ZNtPY/XS2EQCCKyD
	n6b0RBtXX0bW8dRVz+3CRpufKwsyDJS3KleAJS9H5aBIyaG156sXj6ovYrR3UjQf7KTQJCaKavHXa
	5h3LczQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDE-00000005Ihu-1x0U;
	Fri, 29 Aug 2025 10:20:04 +0000
Received: from out-189.mta1.migadu.com ([2001:41d0:203:375::bd])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9M-0000000561k-2SRt
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:12:01 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFY07kvOZ8n+on6q5CM7v7BCfr6Li4auFTnWartdWMw=;
	b=naAAYD8Yg+wsZ3BUYgDlfzFbKJ7bMZsX8z2X7yIiX7YsKsLrANeX29y9ojZ+4e2/wZhgNj
	1S4n6Imya4RSioV3lKZLwJzaof/p1ONTxuJ0e3XMUmriytNqduFQea2vk/O9NKoW6/Q3Ki
	4W70yaoKgC+pQ67JGnPmSjhnTUkOTdY=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>
Subject: [PATCH 1/7] kexec: Handle removal of multiple 'crashkernel' parameters
Date: Fri, 29 Aug 2025 17:10:34 +0800
Message-Id: <20250829091040.35827-2-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021200_764820_65340644 
X-CRM114-Status: UNSURE (   9.06  )
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

From: Youling Tang <tangyouling@kylinios.cn>

When the kernel command line contains multiple 'crashkernel' parameters
(e.g., `crashkernel=1G,high crashkernel=256M,low`), the original
`remove_parameter()` function only removed the first instance. This
left residual parameters that caused conflicts during kexec operations.

Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
---
 kexec/kexec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 6bf12d7..c9e4bcb 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1153,6 +1153,7 @@ void remove_parameter(char *line, const char *param_name)
 	if (!start)
 		return;
 
+again:
 	/*
 	 * check if that's really the start of a parameter and not in
 	 * the middle of the word
@@ -1167,6 +1168,11 @@ void remove_parameter(char *line, const char *param_name)
 		memmove(start, end+1, strlen(end));
 		*(end + strlen(end)) = 0;
 	}
+
+	/* There may be multiple 'crashkernel' parameters, such as low and high */
+	start = strstr(line, param_name);
+	if (start)
+		goto again;
 }
 
 static ssize_t _read(int fd, void *buf, size_t count)
-- 
2.34.1


