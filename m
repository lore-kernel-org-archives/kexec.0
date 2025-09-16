Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D11CAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BrOBE+c1PVVlV09PEfbREdknOTw7yYX5nTsWQm067Y=; b=p1O+5vUSmfK3iPUILfirx/WZ2F
	xjSFC+n/SjTUXE2xL6ylvVDG9Gv5KlhhS0wGYe2hc1vZU9ZeLl6irRiZaekQPlweaSEmbT1Ra10hV
	dYbX6faWX9QNF0nHXLR7LZlzxWzq0aRo+HhW1aTNf7NuAyEnCMb8/ahC7ft2Yq7aOHnvC8jajBaUW
	CAmsHgnSDvOgwxhtXhvT+HNt4v+WHUGf/3LE+FyezP//YUl0uHIHVvwLQGm9CQtcX/AQqq9LtmNku
	ratkT753vdOjZ+PqN9iQKvYPmYppAwh+xvNLdslqbBAbFINJx/JpRNWLYE5V7X+NJY3963UYWZ3n9
	m8R7fU+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxe-00000006D1Z-1xs2;
	Tue, 16 Sep 2025 01:58:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxc-00000006D17-2TmJ
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6BrOBE+c1PVVlV09PEfbREdknOTw7yYX5nTsWQm067Y=; b=o/LRpOmoECIl+I4sKsFDS+CwQa
	25woiUAJWChGzwFG01cv5xWkEMQPkGxcf4kVEWqxtzY22zE16+Su3r+Z1qPeULlg1fF3FjDDAx/qO
	UvFx870v0hsAcLp6QEJc5xQtfOL9mAc9xTgDqf5Km8tfvxtmNFpIlQtIupH0+gEUZzgjrbfrX4zNt
	nJw893mEbpTHdCHQVORLyqtHw4hxCGWzQjzfswfXmDYL2hs5GRrxbdetyyPQ4EzlNoETXo7jOu9k5
	RlRPmhvC6uRdNoZCvCyQjOmPD5acsh8q0ZAFwP0FVC5T0AV4sL0Eq+bP4qRww4/O387gDROrXdasr
	YOHOB8OQ==;
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxV-000000077yN-02fB
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:58:20 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BrOBE+c1PVVlV09PEfbREdknOTw7yYX5nTsWQm067Y=;
	b=rN8UU8Rw81SaMazAq8xaGr4nNfRyqJZ3aXWKwO4A61Fj/4bpZEdnyOwxmorfhUZlrKMFF6
	FiEsvBFzDFEafkCK+D006WDoHjASX232DwA0Xt2+b0ry+9ei7FLjoZBCbnP6LQMffUmgSH
	kMQCfuy430vFNKPEY95FjQtLmVhG+n8=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 01/10] kexec: Handle removal of multiple 'crashkernel' parameters
Date: Tue, 16 Sep 2025 09:46:46 +0800
Message-Id: <20250916014655.841632-2-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025818_373928_8D9EC4D7 
X-CRM114-Status: UNSURE (   9.27  )
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

From: Youling Tang <tangyouling@kylinos.cn>

When the kernel command line contains multiple 'crashkernel' parameters
(e.g., `crashkernel=1G,high crashkernel=256M,low`), the original
`remove_parameter()` function only removed the first instance. This
left residual parameters that caused conflicts during kexec operations.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
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


