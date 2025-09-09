Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D616CAC582
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 20:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v6j9zrtMltmIoN7tcvqfcj39ZzhThRROT8000Oa99k0=; b=EJK5I1zobcj32pbN6T0XOHnrsR
	kva6nlKKXJ+8UJCBlHljThmiYQ9JwmcTjnHUSLldn/MO82fRTHqFLtHq7iEaYPiA4ZcdMxs8rnoIV
	Po6/Yj4hiQHpW8FcPtUDNvcwxgrXObxiIEpi5hxqqR3nnTwlQSfm4s63yDWx6L7KSqb0CGHTEVLvx
	uM8tiKK+OQPWxbCFKUIhu5+uaIdxZHGW1poPXgR9efAZEUYhtmvBG3v0jcW7Obk2L/625AverRz/a
	G1PTRKE+yffZeSEDGHI4sSM+ndBgEytOFpR09nmW4df6gXYFyHBWUtcUE7JQeDGqeyu7lhEqTqgLc
	dX97bKmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kc-00000009w1w-3Jsb;
	Tue, 09 Sep 2025 20:15:38 +0000
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kY-00000009vzj-1FqI
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 20:15:36 +0000
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 93B5EC017C;
	Tue, 09 Sep 2025 23:15:32 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-lKmQ6Yfi;
	Tue, 09 Sep 2025 23:15:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448932;
	bh=v6j9zrtMltmIoN7tcvqfcj39ZzhThRROT8000Oa99k0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tUHIM9IlFhPrnvOXOM+8JQ/i0mj302skwkptt6zMP16DhVcdP4tW4deIOK4JJP3yD
	 mN3ebdg4uVK1ZkH0Io+gOBUGzVZlGDfE8Uh2rX0ZDfqoO6ePTTS6rxm/DASPVuY9h0
	 iwbPtIEVLaRWS89T8gLAY0+3oaK1BizzhT9GYSH4=
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
Subject: [PATCH v3 2/7] kho: move scratch memory in separate helper.
Date: Tue,  9 Sep 2025 22:14:37 +0200
Message-ID: <20250909201446.13138-3-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_131534_505572_47BA6FA5 
X-CRM114-Status: GOOD (  14.94  )
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

Move scratch memory initialization logic from kho_populate() into a new
helper function kho_scrath_init().

This prepares for using KSTATE in KHO instead of FDT.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/liveupdate/kexec_handover.c | 34 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e5a436893f5b..a99425fdfce4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1111,19 +1111,12 @@ static int __init kho_fdt_init(phys_addr_t fdt_phys, u64 fdt_len)
 	return err;
 }
 
-void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
-			 phys_addr_t scratch_phys, u64 scratch_len)
+static int __init kho_scratch_init(phys_addr_t scratch_phys, u64 scratch_len)
 {
-
-	struct kho_scratch *scratch = NULL;
 	int err = 0;
+	struct kho_scratch *scratch = NULL;
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
-
-	err = kho_fdt_init(fdt_phys, fdt_len);
-	if (err)
-		goto out;
-
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
@@ -1161,6 +1154,27 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	 * memory reservations from the previous kernel.
 	 */
 	memblock_set_kho_scratch_only();
+out:
+	if (scratch)
+		early_memunmap(scratch, scratch_len);
+
+	return err;
+}
+
+void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
+			 phys_addr_t scratch_phys, u64 scratch_len)
+{
+
+	int err = 0;
+	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
+
+	err = kho_fdt_init(fdt_phys, fdt_len);
+	if (err)
+		goto out;
+
+	err = kho_scratch_init(scratch_phys, scratch_len);
+	if (err)
+		goto out;
 
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
@@ -1168,8 +1182,6 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	pr_info("found kexec handover data. Will skip init for some devices\n");
 
 out:
-	if (scratch)
-		early_memunmap(scratch, scratch_len);
 	if (err)
 		pr_warn("disabling KHO revival: %d\n", err);
 }
-- 
2.49.1


