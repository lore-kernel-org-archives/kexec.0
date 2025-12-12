Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39869D4415B
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDF4h3Jh9GgHGMLVFPx83dqWDttLVLJuGGw2qG0PEFE=; b=tnSHsxKbiOQnWfI/XiibFog/ho
	KbngBica6N9ZSRGeZYQz6jkzpLLc9nftSkcqea/nHSRYbPv9YNRmZEde0XZYCuREqi6TCTCbWjPsc
	/ZQE8PY89kaBMDAWbGHAAa34YUp8JMB72ZiDet26LLy7UMGchTPDQE36uuSW+Ony+Z9J9y86VZlxg
	P4KoUqGf82r2twTfXCzULk99yiVmZiO+xxBWdNCZmJFhMZcAICqTMLB8dcdS1kraZtsHuCsgdKFGM
	pDlK3ZR7dN2qJgUn0F78v6cEaIn9eDTuRp3Bem9Y6RvnoHnuSP76nj421bFzaD3cXt1Vbj9zXt9ok
	QD6XIrHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzvg-00000000OJ8-2gjV;
	Fri, 12 Dec 2025 09:59:16 +0000
Received: from smtpbg154.qq.com ([15.184.224.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzvd-00000000O7d-2mSl;
	Fri, 12 Dec 2025 09:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765533499;
	bh=UDF4h3Jh9GgHGMLVFPx83dqWDttLVLJuGGw2qG0PEFE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pocyk6rt90wWecLApJceu7Z3U291nCt35GOb5zlr4sjwqxr3MHs9LW0wd/8WtkSJk
	 qUcs6Ir5gwXECt05OY8+Uy/eQKvQulKmljGf0RHCdoXcSmX9mv4CYOxbxDztgn7h9L
	 6/EKZtvpEByQUYcD9WewJgZ61v3BCDLkA/0C9sJE=
X-QQ-mid: esmtpsz10t1765533481td99b2432
X-QQ-Originating-IP: oMxRptJH/jlDFbSL2STyXsuYHe+8T3FtiJgH19bPqXw=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Dec 2025 17:57:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1331570126672029609
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v1 3/3] arm64: kexec: Adjust the debug print of kexec_image_info
Date: Fri, 12 Dec 2025 17:56:49 +0800
Message-Id: <20251212095649.857796-4-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251212095649.857796-1-maqianga@uniontech.com>
References: <20251212095649.857796-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M7nxhb6mzyWmhLP0LYDlObFZflKY+utZ4ScscwXUbeQtE28KFijNut8b
	Z/8CI7efEcyuqV8BZZqOOjcx4omkDinWSr51VJe7iGUoTPg/bwZTGt5by+Kl+YPMm94Tgv7
	s/eXKXi+4Ek4Eaccy7c6ECNjrhd8/53qvqeM8WRjPiDSqDqufFKUGV5A5aMaPqBCUhST13D
	vgq/X9uRy4JHXqjRC4KvcdOZqRArS5P82oCaM3EJpv1nb4N2FI3cZa9lhWgkqM5tlbSi+YC
	/kOjMsy1caPSijxxFIUh03b7fYi63NfMnVhQcKtInLOdDTUsnlYMYd4N4JP8tVrytm0QOPD
	A4IaHc8NBYHoVIpc34uOmc6yZvY/3iuM1GkvRPzA1vkhDtEffQG44HfkuR+fhY56LUkIfDR
	4GzJsDpLIvm9XZS9HPIQ/8TjO01a0RMsh4/v/JTamhpmCmeZWt/a0ajGw3KjKaOXmKJlyvb
	COUaMLEnScw+2NZNa2ubwn1WNPYPWbQh3F8+XeEvH1gZRB04kKsB6S5buinucjEBRAICqg3
	udfUcfc2QdonyZDptxRAEaRqTC6RGBv/3lZT50ttRmYYp7z2oIQ942wAwo108TGWvDs+bGP
	7uI72J5mQ9xKd4IMo3ettTmEubQLkPu3ylpRT1t6fXesWtlW7FewhBpJy42IjweRt4Oko1j
	fM7e2YYE+JhNbNNGuyorh5SXF/m/so5dWtgM9Xhp+0fWMrLCXe02VBGzpS9wcF3rRh7r/A5
	2TWAXoc7rt3MNpqyhzJWtGVYt5PzKzVBhkiS3GFoiFQxJxrYkpAFGM7IWJoqwjLJm7f8oaT
	6kOKU9UU9rWTUIDhzstdfTPM4e8ELr3AQRDuOgzHviZK08vOYOKsF0sWeqgd+5WE4+Tzj+H
	qVU38NLNSCNHLdT4P2ULZQT5DwD6kXpdsx37hZ1274pkVp/glGAjP4njW8aQE+IpkLRLCPP
	4tR66xoPsBJtiGSyEPWmarIHJXYEftcHhbE88J8u+PbLTl1NTeCPwMpKB1ZOJF9awb413tx
	YB7pwJTA8H17pPAQ9rv91UZnVE4bRe0T82tVoA+A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_015914_288279_86D22A3F 
X-CRM114-Status: UNSURE (   8.11  )
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

In the previous patch, we move start/head of kimage to the
generic code, so, we remove them to avoid duplicate printing.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/arm64/kernel/machine_kexec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 239c16e3d02f..0896e3e6a811 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -34,8 +34,6 @@ static void _kexec_image_info(const char *func, int line,
 {
 	kexec_dprintk("%s:%d:\n", func, line);
 	kexec_dprintk("  kexec kimage info:\n");
-	kexec_dprintk("    type:        %d\n", kimage->type);
-	kexec_dprintk("    head:        %lx\n", kimage->head);
 	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
 	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 }
-- 
2.20.1


