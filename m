Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1749AC79FA8
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3p8/iARn7Ne+mgy99vOdquYnoHq9+JHvsSKe/gLUKJ0=; b=MvybXd+3NzDEJb1Q6M32B7dt5p
	MnT3mw1bF6g/FAw9ZZKcDF3VMGM0/41ir/EDQZxfdGJOO4rJb4UkSjOr2vgKR5Gv0v6ML7MTzZwy9
	4g0z+l7J/xfB5FcK0cGWQmXN9LBaWrzMo7YkXk0nRzLEsLuox+KSv/842SsbZK/O50f3o2POLXqPO
	IINu1kzwhPBimo1V0EoDohuZbjK/YstlBgkXkXUVQ6svSpsUcaQlkAUgCuo4Hgc4KLqv0G6ej2iVK
	u51HJ+PAfUNoYVSb/IQ2xz+O5uwTjGSBs1BsqqkCB7SNFmpOOnbm6aDQQbxQYDdPhiKV5UzR/TtCC
	QRLAqU9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnuv-0000000Bln4-1hWf;
	Mon, 05 Jan 2026 16:58:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnus-0000000Blmb-3IKu
	for kexec@lists.infradead.org;
	Mon, 05 Jan 2026 16:58:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B44AE6013C;
	Mon,  5 Jan 2026 16:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2367C19421;
	Mon,  5 Jan 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632329;
	bh=fx5hU4O4QRxBLang5mD6EyamP0RPBzh181UvkxPwN3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svrBcNYNOWwFsNOsZuHPbsSLKKggkG3B9iIlMNA0mv8rsCj/DdlNBKj8SMVRsg9yo
	 jwcc/xtvtmEogZ34qkeP3/spCawq8zMu5sVFjAXs5UG25LCW7lDMpJ0oczS+ItrJY5
	 zwJETKF0vuG9yPhjn9jDmtas+9mkk/cPdRarDLjFFGLsBflYfDFpk590OWg0YgAZkG
	 NWlFQtC7p1/qa86uOxuF2wRPenf7iZ1zuq2MKxUBmISN7MbBGwnu/OaVghj9JJtJ8L
	 M1Sn1VXyGh0ANtc2LaBCUj9j6OAVykRJ1iYNQJsojsJiiV7nPRs3sr+9Oh7dOIkjkT
	 1Ba7g+REDsqpA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] kho/abi: luo: make generated documentation more coherent
Date: Mon,  5 Jan 2026 18:58:34 +0200
Message-ID: <20260105165839.285270-2-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105165839.285270-1-rppt@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

LUO ABI description starts with "This header defines" which is fine in
the header but reads weird in the generated html documentation.

Update it to make the generated documentation coherent.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kho/abi/luo.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index bb099c92e469..beb86847b544 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -8,10 +8,10 @@
 /**
  * DOC: Live Update Orchestrator ABI
  *
- * This header defines the stable Application Binary Interface used by the
- * Live Update Orchestrator to pass state from a pre-update kernel to a
- * post-update kernel. The ABI is built upon the Kexec HandOver framework
- * and uses a Flattened Device Tree to describe the preserved data.
+ * Live Update Orchestrator uses the stable Application Binary Interface
+ * defined below to pass state from a pre-update kernel to a post-update
+ * kernel. The ABI is built upon the Kexec HandOver framework and uses a
+ * Flattened Device Tree to describe the preserved data.
  *
  * This interface is a contract. Any modification to the FDT structure, node
  * properties, compatible strings, or the layout of the `__packed` serialization
-- 
2.51.0


