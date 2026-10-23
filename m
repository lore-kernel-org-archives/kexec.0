Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93E60A2600
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OVt9k1xH;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dEp9P8wt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XR763hCbspNzvt9Ja5KlngGTT7u+E0yj2HR4cp4PfjA=; b=OVt9k1xH3IhVVS
	GPo+K7Mzp03GMFkmLLf0CfcaagQtRA/cVwGf/+xVytcouTVtaTm42qnk9Pyzb4dPVm4B9zcZ4kL2K
	Wd9hrxXhIoeJ2u1xgztNWG1iVL0wCI6AiO1Tg32MjhDYUZrFJfKIDAlBYeNvlH74IJ0U5TP52/26L
	MVyONn1Jcg+8smCXvYvhPI6S44Kw73FzvN/Krv5d3/IzHr9BUpVp/4zPukLrTPJ9QgpiVFgj3VNv2
	Vuui1JseieAaGrJy7lOlJ+gOZw+XMBa+5/dM6T9sEg5m5XMp8hlGjTocgrSZf+8PWjMjaXQsQOmS1
	GKy50ZE04krmozOcF7Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDGC-0000000GDOd-1iwr;
	Fri, 23 Oct 2026 11:16:32 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDG9-0000000GDMp-0oVw;
	Fri, 23 Oct 2026 11:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792754183; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XR763hCbspNzvt9Ja5KlngGTT7u+E0yj2HR4cp4PfjA=;
	b=dEp9P8wtKFFnU9ygvZhkHsuOeVWzaAuomqIWciSFKZ+L9UE6UfM4JQuBFeedv7e1nkFVu/G9DWjpVO9pG0NcEJKTnwwH/Ok3T4uD7ImX0uhE+QmFFFjyO2eT1qQo9hfITP+QeEXi28Yz//e+8iFUpGCH0XDaw2AC6/kdBK/c2UM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDM1n5K_1792754181;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XDM1n5K_1792754181 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 19:16:21 +0800
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
Subject: [PATCH 1/4] riscv: Call early_ioremap_setup() before parsing the DTB
Date: Fri, 23 Oct 2026 19:16:09 +0800
Message-ID: <20261023111612.2134-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023111612.2134-1-cp0613@linux.alibaba.com>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_041629_420782_6849B9A7 
X-CRM114-Status: UNSURE (   9.77  )
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

early_ioremap_setup() fills in the slot_virt[] array whose entries the
return value of early_ioremap()/early_memremap() is composed from.  On
RISC-V it ran after parse_dtb(), so an early_memremap() reached from
the device tree scan returned "offset + 0" -- NULL for a page aligned
address -- and the caller could only report a mapping failure.  This
stayed latent because nothing reached from parse_dtb() asked for an
early mapping before; the DT based kexec handover parsing is the first
such caller, as kho_populate() maps the handover FDT and the scratch
descriptor array with early_memremap().

Move the call to the top of setup_arch(), which is how arm64 and x86
already order it (early_fixmap_init()/early_ioremap_init() before
setup_machine_fdt()/parse_setup_data()).  The BTMAP window is mapped
into early_pg_dir by setup_vm(), and RISC-V neither calls
early_ioremap_reset() nor defines __late_set_fixmap(), so the virtual
addresses stay identical across the switch to the final page tables
and nothing else in setup_arch() depends on the previous ordering.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index d79f99b86033..45e2ef9d32fa 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -308,12 +308,12 @@ extern void __init init_rt_signal_env(void);
 
 void __init setup_arch(char **cmdline_p)
 {
+	early_ioremap_setup();
 	parse_dtb();
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	*cmdline_p = boot_command_line;
 
-	early_ioremap_setup();
 	sbi_init();
 	jump_label_init();
 	parse_early_param();
-- 
2.50.1


