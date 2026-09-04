Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E9C624D3
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LhjxLhACs+nHcbwiRjUkpDk4h0tix+V7Njvp0UeHg00=; b=I6jYfhn5xE8XTQBsOAL0an6ayF
	F+kPsTI3yYg3y0eWC3oSsEoeaneXaML+UHp0uYrWyGzmTF06yMHDCvx783ozTFsi0W1NRoFBA/A0m
	DbK0Y7Rvc4Jr+XXc2hn+AIbwjR1/ETxWwdcd4uVLI5R+AqR5uh9vk9f9OXRbwmryyZbJ1ElonmBP/
	5at8EntnNi39+fmlohF80hW+9yZ1cUM3v1Bo0oiemyzJflFaDqldBSQRSPPB4V4QqC4RYXP3S138q
	rFYgtTlseeUh1ep5w+lZzygocCTCxqRObtcXlmziZPN93Vaeav+NqJAyo86Tj/F+I2bjHgTNNGUkX
	nFYN9vMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Qsa-00000001cnh-3wJU;
	Fri, 04 Sep 2026 10:10:40 +0000
Received: from out-91.mta0.migadu.com ([2001:41d0:1004:224b::5b] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsX-00000001ckp-3wTa
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 10:10:39 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=3cPgANBsAN0TCTPt7lj+YGACHJ2FHFsC3fuQuOraQMA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788516636; v=1; x=1789121436;
 b=jOYuemRcWo5KL+QgZmCOv9MMIDTecQV4sy4qKJZoKBEmf5d3iNXBGG9bnLcIf1/rcI4GcegT
 fTUoHhog/yvL5xoVRmK1vLBPfhssLCgKuA5gqPNvAsN6NJaLVLdygn8180W+R8x0Ym3nDkEmxor
 QWjA6/7/PTIMc6MQxWL3/CAY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 031a72623a973772;
	Fri, 04 Sep 2026 10:10:35 +0000
X-Mizu-Trace-ID: 031a72623a973772
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 4/5] LoongArch: enable kexec handover (KHO)
Date: Fri,  4 Sep 2026 18:08:51 +0800
Message-ID: <20260904100852.26006-5-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904100852.26006-1-dongtai.guo@linux.dev>
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_031038_138838_4ECCE4DB 
X-CRM114-Status: UNSURE (   7.48  )
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

From: George Guo <guodongtai@kylinos.cn>

Enable ARCH_SUPPORTS_KEXEC_HANDOVER for 64-bit LoongArch.  It selects
EFI_KHO whenever KEXEC_HANDOVER is enabled, so LoongArch uses the
architecture-agnostic EFI configuration table channel
(LINUX_EFI_KEXEC_HANDOVER_GUID) introduced by this series to carry the
KHO state across kexec.

LoongArch boots through EFI without a device tree, so it cannot use the
/chosen FDT path that arm64 and riscv use; the EFI configuration table
channel is its handover transport.  No arch-specific setup.c reader or
machine_kexec_file.c writer is needed -- both live in the generic EFI
code.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a21f51e5815e..5eaa65578d58 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -685,6 +685,10 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool 64BIT
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool 64BIT && EFI_STUB
+	select EFI_KHO if KEXEC_HANDOVER
+
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool 64BIT
 	depends on KEXEC_FILE
-- 
2.53.0


