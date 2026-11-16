Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EB606A885
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NqB1McF2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEpmx0Dr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5x9NAjwyHTj7gs1TvGr/q/XVOTeFRW8sCriRzxuuRiQ=; b=NqB1McF25Fa21b
	daHc9q8z1UE65Z6INc84Q18Cr6rOezM510kKqGJ76yZqzh9gOqmirBRMQs3mT3GdUZ/nnRcdrF2bi
	BcRvU1PS8KBw62P5rvjcexZAyfTEp6sqdqv8p3/HVyFpOxNr0mOgmEotLtLsFnHYeGQyWq4rWQBZg
	IWJeFVdc7l23BpawEltGHkvnEzIQ7cYxL6W3d0/s8A0hczbf1rzc3Gfw4F0HGpxV3NWciEkMZapbL
	Xr57iF4fJeoZYunIvbWlAnwgTlf9tDgnecBcee7OcIEUvUU5sZ5VSnQ0vePGJHKcdw7Pa/24KjUMB
	6LH9gF06X8Fj4loga4uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwi-00000002fOe-2LZY;
	Mon, 16 Nov 2026 13:40:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwg-00000002fNQ-3rNl
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 13:40:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 806414015D;
	Mon, 16 Nov 2026 13:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063801F000C7;
	Mon, 16 Nov 2026 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836430;
	bh=5x9NAjwyHTj7gs1TvGr/q/XVOTeFRW8sCriRzxuuRiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEpmx0DrzH4kQYgsIkL897GpxshBlqigkorGhJo3MJ8+VZnRor36BETgWpSsikiZy
	 a+x8UHIWtb8HhghpobzEAAnBRXwpM7ExMD864dFUseejt6SABl9jVOVY8hbpsYksHt
	 OxKRMzN6vkTW17vcw/CXflhsSrldtO9M0BDqg1zI1vvNTJ5w/xJJrhEGAjXo3PAe+o
	 asCk8iN5LZmhUgc+SRGVQ7Ae10QCHG3Toi9Lx5Win+W98o2Z8z8bDZzU8jXRbTc6EN
	 Ro84Nmtnjda6fCuTuKS+Yt8KSnp7JkiMTeC/eySOLWugBM2N1lFSx7ak8+ldOAsIPZ
	 ehRje7JdM3o3A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tarun Sahu <tarunsahu@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/5] kho: build KHO objects into a single kho.o
Date: Mon, 16 Nov 2026 14:40:07 +0100
Message-ID: <20261116134013.1636689-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116134013.1636689-1-pratyush@kernel.org>
References: <20261116134013.1636689-1-pratyush@kernel.org>
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
index d9f4694625567..bc679905ce3f2 100644
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
2.56.0.611.g1030f0b940-goog


