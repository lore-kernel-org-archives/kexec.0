Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86C6CDB46F
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Wz5oprksRaCrRIjUlZSqxfZyBEaRT4sgoIBdS9jtKw=; b=gaonMGbak6w+lOFeDnIsdZdRsM
	76TIENW2+62lj1BzS0yrP93b0iS0aU7kO1iranpxIAb87GEQFbnJ52o9sWWN/PP2gmAcUngFRoQw6
	diNzW5my60tCGrlOd4QP/H1ztYFJ5WMiOO/Ggl2cOnmP9AtFAopqea3R5HNcJhgP/qB4Wa9HW5Wjk
	eHvhpGdrxeD36MHbSprwCpvWDbN5n8KGxgDdn5tnCWe2+kjW+KvneK+p/YWDW+RWycjAG4/dxSh0w
	QEn5QT1z4HWeQiDNBFpW4PlRyj2p7RxsYEkFVSM+/TYf53GCHXlNeSy5KNo2TeeejLp57WzxreSIw
	hhsZxbpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyjh-000000066zW-0GHn;
	Tue, 23 Jun 2026 10:52:09 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyje-000000066yL-4BII
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 10:52:08 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-c0afbf73482so375037666b.0
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782211925; x=1782816725; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wz5oprksRaCrRIjUlZSqxfZyBEaRT4sgoIBdS9jtKw=;
        b=AAjb4uGBlDfs37NlA3e0zkdYeF9lUJbBB2vAUS21cTYBEZkL+xj1vKt5bCTaJP5A/d
         9Usf/fJP0U5QvWm7uxK6jwYTY+vcjdvYmamK/Hi+FsWtaibVeH0zlH/oJiumEEOOGXQb
         dLNuvbE6sJWLLDcT4LsMkR/gVvG5+aWADAUHR9X1fOfvp0l9Pdc+c0f0ex/Br9uQEhT3
         xv0voKub4ZnZWeBwR7nWnlx21WM6NUkoo7JmD2sxDZ1oHojfTz3rU2vBugg3PJnha6aj
         Veke6v6dadFzZNpjPhMH25p7qgMpfU+UDcYyQ30OAoPEAPfS04vg5q5bu0BUycqseqLc
         KgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211925; x=1782816725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wz5oprksRaCrRIjUlZSqxfZyBEaRT4sgoIBdS9jtKw=;
        b=FinZMD8Q0wJC2fiyKZDfFO2QRmhoE5yL/O4ASYMk/vHqPmcFqVwSc6Wg5fu4AQq4zu
         QwxGG/5OoYeMMBZHymHWp4CV/iOOvy9TO/Yv/IB8UW6F/iW0i8XgUFLtLKgYuHvJGWMH
         FQPxdFY4eeZjGpzv/FYRlY0k3rKot07uBrWrdxE/wsch9R43FUDDONGCKKpr0XPX220c
         dHMh617J+zPenQ39RIUR4DjkePekpJ5weO+IGH9n032vzL4HxjnQjHVfC8wxCcSTot4N
         vFTX4wsni/8pg3D9D0cNL0XiT28U9ScFo56hlgx4CfTxCstt4ghIu0n/nqKgIBONjNZy
         /axA==
X-Gm-Message-State: AOJu0Yy9HdBA+0fZv5uyMB8PCnFKYm4JS1NRPgNiZ41eMz3Z1Hf4H8K6
	wowvJNK8g/v/ZOUKpUeBkv3Pzcz1XOJ8dPEMLKFV0vo8UyttGAO7b3PfjMXGkqiIhIYJZBh7coa
	hSRrxWTtA/9D6YsYz6Q==
X-Received: from ejef19.prod.google.com ([2002:a17:906:3913:b0:b9d:975a:28a8])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:a083:b0:c11:1753:25cc with SMTP id a640c23a62f3a-c1117532ecfmr18544666b.42.1782211924283;
 Tue, 23 Jun 2026 03:52:04 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:51:59 +0000
In-Reply-To: <20260623105201.3724592-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260623105201.3724592-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623105201.3724592-2-tarunsahu@google.com>
Subject: [PATCH v5 1/3] mm/memfd_luo: validate serialized_data before conversion
From: Tarun Sahu <tarunsahu@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_035207_046573_F6CD460A 
X-CRM114-Status: GOOD (  12.29  )
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

In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
on args->serialized_data before checking if the physical address is valid.
Since physical address 0 does not map to virtual NULL (due to direct
mapping offsets), the subsequent check 'if (!ser)' was ineffective at
catching a missing serialized_data, leading to unsafe dereferences later.

Validate that args->serialized_data is non-zero before calling
phys_to_virt().

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 mm/memfd_luo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..10f3983b0060 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (!args->serialized_data)
 		return;
 
+	ser = phys_to_virt(args->serialized_data);
+
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser)
@@ -522,10 +523,11 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (!args->serialized_data)
 		return -EINVAL;
 
+	ser = phys_to_virt(args->serialized_data);
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-- 
2.55.0.rc0.786.g65d90a0328-goog


