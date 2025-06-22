Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C07C7115A
	for <kexec@archiver.kernel.org>; Sun, 22 Jun 2025 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fq5irle5V5JYKonMlaAinQz89qUAsyxfkXOU9YDMcQk=; b=KR5jLIkP9yH+sfFGzQKRGUvaPr
	XQT8UyuhO9INsAfUr4PTgYhgpIB3TYWUXqyFvHFGBZuEkUz+PzcYWD4c7TgFa8ZF0yqt68dZfrvOq
	NK9bYHvYoaW1wESo7envqZmuVQNLq2djzFb0MRI6VwLLsoTxj/zMS8rK+05M6gh/y67wNdvIEJSzz
	cYhUc1B8fGrPwdXdogIuVi+ojifqKVZonB/n6pQIhf5rcVH9hBZxeaPomdf+AUqQh8yAJIZjMe8Lq
	OrO04uhBFna8eFCbiJYZOiv0uXvWBzm9UYq8jE/A48bnbNBEzoGr1ExtlaoJLgMoZp1wOnh3U+8cK
	F+XK4iHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTKVq-00000000slx-2yNr;
	Sun, 22 Jun 2025 13:13:34 +0000
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTKVn-00000000slZ-2DL4
	for kexec@lists.infradead.org;
	Sun, 22 Jun 2025 13:13:32 +0000
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A1E311400E9;
	Sun, 22 Jun 2025 09:13:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 22 Jun 2025 09:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1750598008; x=1750684408; bh=fq5irle5V5JYKonMlaAin
	Qz89qUAsyxfkXOU9YDMcQk=; b=aJpiwxPNcVAIxpeYvUhQGPcjGSouUxucwoudf
	E+XKCiTWpWMduy7IYQYlKt47WW0/H7eaF7TSXYWXk+63HXVIV/qFfoAusJbWiSwV
	k+2X2ZjMF3BqMyk66W/pMtAp9drKCY2ZROJeEMqMWgw3TRyZhYW0ZWVwxBXIjBCj
	dFCSh4aTYCac9iK0RhrcqkY+4GAWLRVQA1aUJEptYXcc/hXM5OQ5EJqRU4tZGxjJ
	BoBLSWx3sWfVodEIWXSeVyLJ6OCsgvz1ggEdqS6itPAofidK7SweZ0A/IZ75R86E
	hY7cGF3lvG+GzUBsYdC4iDmOduGHDnaxdflwQlPZs0+smtfJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750598008; x=1750684408; bh=fq5irle5V5JYKonMlaAinQz89qUAsyxfkXO
	U9YDMcQk=; b=LzjCjG1IdE9+8bozzxciCcKj43u51DdalFR4in4clEwQDAX0UL1
	HK9IkgC7vsGTqrO7rqQsvU+FHvGzd89TucL+AiCgXNd/UD8fu91ARLmSzIHcvcza
	d0H6ocdObHlpem+OWfVMtz3bRvLVvOpF+cfUAIaycPzG2NpddpbX2mmXUShHlJK4
	eI0FQfhXEiLi6hGLSnodMRAmKlJrTuZAC25pGl9lz3j2+J4cOaQ0UzPzS/BM63bZ
	TRyRJeq24g3wdNpN6e3Fw6T0qF957GGKbJ/BDbR/1IOzxHLCIndpGbLHc+nSBHiN
	OdWnXCnI2E9z0G8B5j362ocH6t9ETwp0xVA==
X-ME-Sender: <xms:dwFYaCUtMczhewZDV8o6pwRLdok1RvMExlv-FqK6IRtXNZuqpe4s2w>
    <xme:dwFYaOmSkRvHXhx07bspoPnTwLqPEWD4GymZlq2s2VoI22vNNMwK3Jr1dBSah3uSC
    v_toMzYbjcVTliKK4c>
X-ME-Received: <xmr:dwFYaGY7Jft2Xe9A_eJwIFYbLNzQ2k3j6Yj3QNG2yHxTJbfzjQZxPK6fLXAf4DxkyCtQSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefpihgthhholhgrshcu
    ufhivghlihgtkhhiuceoohhpvghnshhouhhrtggvsehnshhlihgtkhdrtghomheqnecugg
    ftrfgrthhtvghrnhepleevleeitdffgedtvdduffffhfelueeugeeludegfffgfeeuueff
    keeukeetvefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepohhpvghnshhouhhrtggvsehnshhlihgtkhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvgigvtgeslhhishhtshdrih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjvghrvghmhidrlhhinhhtohhnsegr
    rhhmrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepohhpvghnshhouhhrtggvsehnshhlihgtkhdrtghomh
X-ME-Proxy: <xmx:dwFYaJVaI91eBtyv_aWRQQ9L3b9EDKJa1__RWMUu1ANDclsn6P0_dQ>
    <xmx:dwFYaMkzD9_THt5Mu_5maY_4U7NCWPHnbi-MDIovFKT9Y5xf9hoj1g>
    <xmx:dwFYaOc-Mi4jh86OifpensONrJrXTjc3_vib8bK71LFsJH-tviOPvQ>
    <xmx:dwFYaOHjeZEaim2I5HQhqXbIjjB8Ixyeuofv7T6gpDI8YwO9ba-zJw>
    <xmx:dwFYaGYoW_0gm3mdeiPM7UhKMbPgfgrNXjy09ITqzo8aYYbPx_AmBb9o>
Feedback-ID: i78f146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 09:13:27 -0400 (EDT)
From: Nicholas Sielicki <opensource@nslick.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Simon Horman <horms@kernel.org>,
	Nicholas Sielicki <opensource@nslick.com>
Subject: [PATCH] kexec/zstd: fix static zstd build
Date: Sun, 22 Jun 2025 06:12:53 -0700
Message-ID: <20250622131253.34886-1-opensource@nslick.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_061331_906373_D5E9A004 
X-CRM114-Status: UNSURE (   7.68  )
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

60ce9bdf introduced a local reimplementation of ZSTD_isFrame to this
tree, as the definition in libzstd is only available for static linking.
When a static build of libzstd is in-fact available to kexec-tools, this
was previously causing multiple-definition errors at link time.

prefer the ZSTD_isFrame from libzstd, if it's available, by adding
__attribute__((weak)) on the local definition.

Signed-off-by: Nicholas Sielicki <opensource@nslick.com>
---
 kexec/zstd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/zstd.c b/kexec/zstd.c
index 79d5bf3..eaa76b9 100644
--- a/kexec/zstd.c
+++ b/kexec/zstd.c
@@ -21,6 +21,7 @@
  * Reimplementation of private function available if zstd is
  * statically linked. Remove when it becomes public.
  */
+__attribute__((weak))
 unsigned ZSTD_isFrame(const void* buffer, size_t size)
 {
 	uint8_t *buf = (uint8_t *)buffer;
-- 
2.48.1


