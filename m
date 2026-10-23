Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092360A260D
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZpmIinTe;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l3Zp4gkU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PGqMJHk6LUVuJtb9sOmDDL50VOC0Sssl6rxAA31XIdA=; b=ZpmIinTeEoL261
	PTIKTH/vNshr9wGbj8kj//d87jS2rPpWU5qHg1qOQIExMKjosFy6ND2ls5a4uJpAHng/v+48v3pCy
	LCA0Y5K11YzgTFKdtHRLGeKHoPGDOCvAqJlawSTjf51I4qja5DTAlx9MUFUhDC0kZkZdJ9wgr2dz0
	YGmhtKNnakW7H0NufkIyLIyqmE4n+msX8yrt7Bh4EBBEaCL/eua2Rc4J5x+LMuHpc5Hen8klALaBN
	wHhwPWW8h7llG/QdFpjUz8j3S5q/sOFVYhqwx6QouhcIYmg41YrUcKoZa8EOzDP06ShZrwIQnqcTo
	F3b1hmjE/ObGNA2+D/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDGE-0000000GDPh-3j3d;
	Fri, 23 Oct 2026 11:16:34 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDG9-0000000GDMq-0j4W;
	Fri, 23 Oct 2026 11:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792754183; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PGqMJHk6LUVuJtb9sOmDDL50VOC0Sssl6rxAA31XIdA=;
	b=l3Zp4gkUxMeF3lIIPkCM/jGo5ZCCHJlORzXBc3zlZXSzIk8WuaFNHU5fYnEZHyrRHvpHPy657kgOr3cj0Dc45kIg85+jAQz97TjgWJ2pmybPVzPXU8GcrlH6Vj7DqoKah12F/wx5X6PjlguSPD66PmnGg2yWuRQYiptY3DD2ryM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDM1n5k_1792754182;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XDM1n5k_1792754182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 19:16:22 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	graf@amazon.com,
	shuah@kernel.org
Cc: guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH 2/4] riscv: Add support for kexec handover (KHO)
Date: Fri, 23 Oct 2026 19:16:10 +0800
Message-ID: <20261023111612.2134-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023111612.2134-1-cp0613@linux.alibaba.com>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_041629_521713_9D2210E6 
X-CRM114-Status: UNSURE (   7.11  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KHO is architecture independent: the outgoing kernel publishes the
handover FDT and the scratch descriptor array in the /chosen node of
the DTB it builds for the incoming kernel (kho_add_chosen(), reached
from of_kexec_alloc_and_setup_fdt()), and the incoming kernel picks
both up while scanning that node (early_init_dt_check_kho() ->
kho_populate()).

RISC-V already builds that DTB in load_extra_segments() and passes it
to the incoming kernel in a1, so only the architecture symbol is
missing.  Depend on 64BIT to match ARCH_SUPPORTS_KEXEC_FILE, and on
MMU because KEXEC_HANDOVER selects CMA, which depends on MMU.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5874ca30f4f6..4f7d2f3f80b1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1125,6 +1125,9 @@ config ARCH_SELECTS_KEXEC_FILE
 config ARCH_SUPPORTS_KEXEC_PURGATORY
 	def_bool ARCH_SUPPORTS_KEXEC_FILE
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool 64BIT && MMU
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
-- 
2.50.1


