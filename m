Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFF1CA0FFA
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=97phKYJUx5OnCwWWmQFRZk4JUHqONh7wY7yW2pnQKlk=; b=k9xUvIrabn//bk
	UUoolDoTz1nO7LdSE3dlbM6C7fYyLsDaEQN5nXCMGHEBQUZCCWlMwRSlzEP4waY3w9o9N7VEmJF4m
	/zxyTUVlz25rxQ4kjbY/UnSoffpAUiKisUegZNBScCUl6Bfn5LvShaNEqyMk7FeqkhpXbS6T1FLVn
	Jayuimp/Yhw8kDT5YmjCug/EhdNLk4tu7Plsfu5ImYGESe1EG15AH7vyxi+grcQ5KrrfC0ZY4hqEe
	CDUT9k9Mb/oBnytaphjq8yAX5C8by19C1R7j6g2kKlMvM+07KgZQTN3ikC9xyWxc3P5xQfnw6ZR0A
	6/QnwH6t0wyERp7Wgoew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2XQ-00000006ayf-09LD;
	Fri, 30 Aug 2024 14:23:44 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2S0-00000006ZlC-1Hvt
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 14:18:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v6/zyvof4qMqjJ+4xzc0g1Ye/jBKn1I/cVtXd5Huwfg=; b=ez/ZxdhRyaLTDXkcXt65kzdlXC
	2F44k9Z3lOfVzv7CwMwOroZhtPXAalN0AmKaIGuapFlajlqY1xlF/6PB5aRl5wk116Iao061OZ0mA
	akWE8kVPlF5imhW8ZGxMyxKcviQXCv2rKt/qZfsqSoA51I1n0N/NklNUkLUIdfLBj2fIL5M+lDtI6
	ka3De4ySH7ImuAqJ+F28rzMXkemWtdw862wGu4V8hcvcRNj7Em4oeUUu9I0/XjawFmvAZDVrwYQRX
	uBuQlkvGzuLeSY/wFa8o/crROA326Xbtg6lHoytkl4bh6lO2ccY/o9NMLPiH/RbsyhX5dH3D+gZZz
	YdxGJBgQ==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sk2Rs-007B3a-Mf; Fri, 30 Aug 2024 16:18:00 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH] powerpc/fadump, x86/sev: Inform about unconditionally enabling crash_kexec_post_notifiers
Date: Fri, 30 Aug 2024 11:17:15 -0300
Message-ID: <20240830141752.460173-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_071808_366350_1883A74D 
X-CRM114-Status: UNSURE (   8.67  )
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
Cc: brijesh.singh@amd.com, dave.hansen@linux.intel.com, stephen.s.brennan@oracle.com, hpa@zytor.com, bhe@redhat.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, mingo@redhat.com, dyoung@redhat.com, vgoyal@redhat.com, thomas.lendacky@amd.com, ashish.kalra@amd.com, michael.roth@amd.com, naveen@kernel.org, npiggin@gmail.com, bp@alien8.de, tglx@linutronix.de, hbathini@linux.ibm.com, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Inspired by commit d57d6fe5bf34 ("drivers: hv: log when enabling crash_kexec_post_notifiers"),
a good idea is to signal on dmesg about unconditionally enabling the kernel
parameter crash_kexec_post_notifiers, which affects how kdump works.

By checking the source code, found 2 more cases besides Hyper-V, so let's
print that on dmesg for them as well.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/powerpc/kernel/fadump.c | 1 +
 arch/x86/virt/svm/sev.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a612e7513a4f..37dee89a0bf2 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1819,6 +1819,7 @@ int __init setup_fadump(void)
 	 * notifiers are invoked.
 	 */
 	crash_kexec_post_notifiers = true;
+	pr_info("PPC/fadump: enabling crash_kexec_post_notifiers\n");
 
 	return 1;
 }
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e5..ac445ad2fcc8 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -257,6 +257,7 @@ static int __init snp_rmptable_init(void)
 	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
 	 */
 	crash_kexec_post_notifiers = true;
+	pr_info("AMD/SEV: enabling crash_kexec_post_notifiers\n");
 
 	return 0;
 
-- 
2.46.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
