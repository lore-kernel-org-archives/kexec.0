Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8820CAC583
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 20:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BrTg0k8lCV2HUq6REznRngkexlNL5x/b5e/pmlQ15ZI=; b=T6zP10MV6btl+y2mlT6PUdewch
	6570zt/0yiZiARmnKu0djZGEkdWlgJv5WXkg4Oq1s9N5SPQ5c6+Gt06zKYaZ8fmC2cORlhuHM4dUf
	Oe/75iYySA6a2QvNHbxpPAgcjm3KHtxki7TNbMA4HfKF5ozAxJyazL3MOz2KulwjDYE3H0LrpwJE4
	alhwuVWg0kzTOk941OMifuus8DaoxxwW/sV2MaKSk4+k7vSRd/77PZT2r0XTI1ikvfKQetFv2wFxO
	L2c92ZoDv1ItH4AnqxqYpVSCFJPCTcq4GngMEwQKo4v8xvmMM74GD1fmaE0VxLlni/Zc7q7HRdLJK
	rRqo8sLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kd-00000009w38-1NlT;
	Tue, 09 Sep 2025 20:15:39 +0000
Received: from forwardcorp1a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:df01])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kY-00000009vyh-1lV8
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 20:15:37 +0000
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 03AC6C0178;
	Tue, 09 Sep 2025 23:15:29 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-l4Vy856v;
	Tue, 09 Sep 2025 23:15:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448928;
	bh=BrTg0k8lCV2HUq6REznRngkexlNL5x/b5e/pmlQ15ZI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=neGSZgoqXYXwpLcgher3hOxnbUXCh+LnfyKfxD6OWkli/tXddCyRc7h06ZF74m86Z
	 KOW7OV80CpU3W0NMV/XxwboV0qA0Cd5wpuLTqhRluGsQJYAxSqi2Imnkg+R/1mMtyN
	 lhAVl+kpBSt43LU/t9BrjK5i3nl0JtZpUGJwqX/w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v3 1/7] kho: move fdt setup in separate helper.
Date: Tue,  9 Sep 2025 22:14:36 +0200
Message-ID: <20250909201446.13138-2-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_131534_634833_0F03C68B 
X-CRM114-Status: GOOD (  14.48  )
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

Move FDT initialization logic from kho_populate() into a new
helper function kho_fdt_init(). The helper takes care of mapping,
validating, and unmapping the FDT.

This prepares for using KSTATE in KHO instead of FDT.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/liveupdate/kexec_handover.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 364a69a2fa1b..e5a436893f5b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1077,13 +1077,10 @@ void __init kho_memory_init(void)
 	}
 }
 
-void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
-			 phys_addr_t scratch_phys, u64 scratch_len)
+static int __init kho_fdt_init(phys_addr_t fdt_phys, u64 fdt_len)
 {
 	void *fdt = NULL;
-	struct kho_scratch *scratch = NULL;
 	int err = 0;
-	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
 	/* Validate the input FDT */
 	fdt = early_memremap(fdt_phys, fdt_len);
@@ -1107,6 +1104,26 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto out;
 	}
 
+out:
+	if (fdt)
+		early_memunmap(fdt, fdt_len);
+
+	return err;
+}
+
+void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
+			 phys_addr_t scratch_phys, u64 scratch_len)
+{
+
+	struct kho_scratch *scratch = NULL;
+	int err = 0;
+	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
+
+
+	err = kho_fdt_init(fdt_phys, fdt_len);
+	if (err)
+		goto out;
+
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
@@ -1151,8 +1168,6 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	pr_info("found kexec handover data. Will skip init for some devices\n");
 
 out:
-	if (fdt)
-		early_memunmap(fdt, fdt_len);
 	if (scratch)
 		early_memunmap(scratch, scratch_len);
 	if (err)
-- 
2.49.1


