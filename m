Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD25CCD5BA4
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D0qXpUmS42FnaTJLjHbXnkRWlEE1LhP0zCdNruCHUf8=; b=ZKzFLLvr/cApkD+2RXTyIXzxIl
	RLM6G1iLa+51tdLyVvGx/yQZVcMYH5DqghR7OWAhgyvJkGww9Gi0PmLhSA+wdVK9yToiw9+6ueGaB
	kv2HZhp9xSsB72wjM4lhGGSuRRr8tH3XLHtGt9CkyVWY3pAsBN12GbtO+hCpjbnp0+nMoE7bR0I1F
	ojcg1tldMATZbqNj3J2OYHRPnOMiMp6o61OKgaKOwdvZdQctn0qGruJhiuqs6zBLWPvhri+gVZaP+
	3XT1f4m6inmaG7cAemMw+6KhaBQtWqtPVTkY16unvxLtf3VP2nyH/Rb3A/pzLNq2xDAm79NCnP1R6
	L5Jd5o8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPK0m-00000001Yyu-2PBl;
	Tue, 19 May 2026 12:57:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPK0k-00000001Yxk-1LX7
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 12:57:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 07E79434F2;
	Tue, 19 May 2026 12:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEB0C2BCB3;
	Tue, 19 May 2026 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779195445;
	bh=HC1/e9/u1l1OXJ6bpfGCNdxZ1DzqRMlRzmJrhTUILDw=;
	h=From:To:Cc:Subject:Date:From;
	b=nV62geiazNK8jvcc4zegkSeOYrEDb4mhGiLHkQdNmbhcX4xGL+vae8+JL2QAfdi3x
	 /Sz9pGx+hFxQyWtOwVMKIOpVyHln/bXxUw7efSTrDaypFHmNF4QX+ijYXPwLDES2Ev
	 fERZD/7vPl/+hboWadRnGktRQ7iysFumhdKprpOGBVsCb02D5hVwre6QTNgfRcFj4a
	 VSCGPJ6gz0zwC86sGqxfhqsgjttSJxS/kOiZwkl5GpXclr/sex8dOaRRzC2wWcTVYF
	 Awpr4JiwT9V6mXjQwbgpnpfauq22vYDC9WMLHHwQlmH5v6s457tkJqNuIsy5Vz47z9
	 1DfaAAA9aatKQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] liveupdate: document liveupdate=on
Date: Tue, 19 May 2026 14:57:06 +0200
Message-ID: <20260519125714.2435640-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_055726_380557_4E69E938 
X-CRM114-Status: GOOD (  12.28  )
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

While the liveupdate= parameter is documented in kernel-parameters.txt,
it is not listed in LUO's user facing documentation. This can make it
hard for users to figure out how to enable the subsystem, since enabling
just the config isn't enough.

Note the need for the kernel parameter in LUO core documentation, which
gets exported to Documentation/core-api/liveupdate.rst.

Suggested-by: Luca Boccassi <luca.boccassi@gmail.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    I think we should take this patch through the liveupdate/fixes branch.

 kernel/liveupdate/luo_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 803f51c84275..5d5827ced73c 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -36,6 +36,10 @@
  *
  * LUO uses Kexec Handover to transfer memory state from the current kernel to
  * the next kernel. For more details see Documentation/core-api/kho/index.rst.
+ *
+ * .. note::
+ *     To enable LUO, boot the kernel with the ``liveupdate=on`` command line
+ *     parameter.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.54.0.563.g4f69b47b94-goog


