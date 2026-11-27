Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AB606A337
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EwIGLn6h;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcjiUnC+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=a0qu0j6AmOnocb4ErsG1/P7x86Ov3PdyD2eIAJ7Q9CI=; b=EwIGLn6han8iGE
	HHAc7HKYyzDP9spYONmzqEcH8J4C6Ds020JVtcixnLwV/Z8sVzA6uOJ1R8kqk4sZvvOeJQ4Gl5zjv
	2BFUl7AOh1d43Q8bWwPxV988l3lNL/8I6FaUfAjcyP5oOuW1UWF3QTUjojSnIr1icg2K6/K6t2Ash
	wOjWPwaJaC15LJ03Ezpqxi38YD8KxlM8r+AqT9PG+lJ8P7u719NbYS05ructV6fQdK3Vro3QbAD7+
	tiwzajQoLrSKDWFQiiyBQheBm6pFiaZfwJGq4/lZ2On4f8ij5S1uEfi1vf05mX8p0yry/0qWT93Mh
	Vh/z51XuRPIOWH6TxGKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1U-0000000G7GA-354r;
	Fri, 27 Nov 2026 12:25:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1T-0000000G7FL-1pZz
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 12:25:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DD1E6621F5;
	Fri, 27 Nov 2026 12:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CEE1F0089A;
	Fri, 27 Nov 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782350;
	bh=a0qu0j6AmOnocb4ErsG1/P7x86Ov3PdyD2eIAJ7Q9CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcjiUnC+QzW1+A5q+f0vI+yQYATvfZE3rf+/VClnaksrClJRA0VBOqNUxEFicVdAO
	 Xowu3GA9Xxw1sQ5V2Q3Pqd7gy6qqh5ePMP/Vv3jRF2bdQ2bfVMfFIQnwhQ9V7IlXBX
	 ZAPjUnFKFmFoAIAk/cza7ql5yzSaEa4Xw7zeiTxVpYKgN9WfOzODcvW28KstEe5yQz
	 9zqoCOZdGaipyqB97hbfWemWwSggmOFhvhGIlMIW5zeIFtV7xn47pGJ8UxEA50LdBx
	 Dl23WXcx4qmnaGRNVdfYSMZwNeMmsbUB7+jH32gQj42UlCl9eiYwNCxJ8VyaP2WXxC
	 ARwmGerIkA2iQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/6] kho: build KHO objects into a single kho.o
Date: Fri, 27 Nov 2026 12:25:27 +0000
Message-ID: <20261127122536.3708770-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

kho_block.o is part of the KHO infrastructure, but is currently built as
part of luo.o, which ties it to CONFIG_LIVEUPDATE.

Group all KHO objects into a composite kho.o, built for
CONFIG_KEXEC_HANDOVER, the same way the LUO objects are grouped into
luo.o. This also gives a single place to add new KHO objects.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d9f469462556..bc679905ce3f 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,13 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 
+kho-y :=								\
+		kexec_handover.o				\
+		kho_block.o
+
+kho-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kho.o
+
 luo-y :=								\
-		kho_block.o						\
 		luo_core.o						\
 		luo_file.o						\
 		luo_flb.o						\
 		luo_session.o
 
-obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
-
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
-- 
2.56.1.839.g22a8290db9-goog


