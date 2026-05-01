Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E34CD3427
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ZwXWqX5mmyJ9M+JCMtLba+Y9auGcISsk1ZjDGvIp3s=; b=FRuQBMhZ3mujYLoTQFYx+nhpFe
	ycYL7PpfeVWOCyMsf0tMWDQNzluVTNEU6sURqs0K+BROqmbnMHVFBU1jQmj9DwS6HO1ISw3HE89lk
	6c6fyiSXn++/k5qlN2TjPvsQvjz9w5Z2EJ0PVO1RDGG3GQUDQ5o9vynq2IBMhaDdHvsuSobib9wi9
	UWxfhLcWCqM66w/X9xo/CzO5byI3rDNaX5NCEprJtzdfidW0BqfcZvw/zrX7SXaAyLkddHKyMDSYS
	bT7EVdTJtAuu0gRsqIyBLMEhghuwA90ei1PHTpUJ6xKXL8pF+uzBa8rDUmcwp4II/2AeLf6/p5C8d
	P74RyOIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXX-00000007qnW-0eFh;
	Fri, 01 May 2026 23:44:59 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXV-00000007qmo-02VM
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:58 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2b24fede2acso13485765ad.3
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679096; x=1778283896; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZwXWqX5mmyJ9M+JCMtLba+Y9auGcISsk1ZjDGvIp3s=;
        b=WCI2UXs77co45MUE+BH5IRJsVHqzEWQTv/KHtpkrj+yQiqZwLbmD+3Mn2B3YpSkTjN
         5EOyamXxI/OkMDLxN64LIaXi11ABAImSZavL/DgHnSn4NH/SUnAVo3mru0XQfF3AJU0l
         vTuaUNrGL1iARpIs/QmudYGBZf0Xvt2BQAx8uxrsxRcUVH39bFiXEAhYp03zLTTU55oQ
         T21uV6+1bV4Mi3fSFvvyB+f6kvOx4QasXsjcKZrvYAlkgRZdFencDfKySZygo3Tjo1FV
         7QnnXvmUyTF4h8nELWHpTBrFZZng+2oKIVXzV1d2heBl1eXX5+4/yx85JH3pWpHj6mu3
         4uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679096; x=1778283896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZwXWqX5mmyJ9M+JCMtLba+Y9auGcISsk1ZjDGvIp3s=;
        b=DNN6NHKR5jJ8kET3wdge20S4pXxKO1fAWEQuyUYUpttyc5GYPPjCPnqavzfmFnpkfv
         z3ph3YczaWvO1J+jAzVz9nr4GkK1Bk/EeI1KbD2cy8yFIxjJvMw7uNsIPwLX4DX7I08H
         VkPZCD86LzKgBqZ2/3/sLIGFEwfGV3EVvUq8/fiRrBFTYH4Xxf6rc/oTP23CJN7oNGYG
         dQxPjNpQWzP8qPXMF5X4X4iIgNB+O6v/BAXQ6TDD28cxcGFjiGgve08HvjJUP+aSfNBe
         8Esim3kl2+KXhUKfeUfF2y3Wb4gGn3G4O7EeroIc6Zg/rM9ZAi3zQS0DNSePqONFkwuh
         42UA==
X-Gm-Message-State: AOJu0Yzx2SAPFhUJ4LHxukFS+A9m6Z5dkHCir/RgG9v+DHnJTurvIaQ5
	jHTogqhthIiWFeey7ZRhoB5V2YHDRCIPRAfeNzalzjah0NinisPmoUUadLiosK1Y85KtUg==
X-Gm-Gg: AeBDiesL6INKwVKOJZrJ+fjg3DCAqLXqaADo5C/cmxKLbVj9pWxQKK21ar25RVfWOTV
	cGI30MgTR61vcP8MI6TnQO+wLNg10yIj/io41eao0wYzKKsMSDxWzQ2fYC9bfwLrCRJGynZ0tdU
	W+C4Jaa2KHE4j0EigNCkSytJf5ceBoRDw1lw0traHhmzH4K6kAH/qa+HZOkH1u7TMPdEeT0ACYX
	lZeFnrD+MVAd6nlsIs4V3JpF3RVPvNe/l4OH3BZnuIY29Xa4WdC2F5E+19C7cFUT6I/XuHvwhYo
	aGKLYVG/q0+7+bEa58eYkpOgvHaqlICCHrI93lka3jz4cEbZJxFNNBj2d6w5G8BAiC4P7AogFQM
	FHOLy7+Ex2Xl7mwKKLQePzP/nTf2OEm/CkWOcWGKBcI1pa2inw8MAk1Z3a4kzFwPNNAkZacqAKX
	T/fotr+eSaCEftRINLoqdQIPQi0+D0RQ==
X-Received: by 2002:a17:903:1aeb:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2b9f256dbe8mr10210015ad.2.1777679096143;
        Fri, 01 May 2026 16:44:56 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae1e2a9sm31131775ad.46.2026.05.01.16.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:44:55 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/9] crash_dump: Improve readability of config_keys_restore_store
Date: Sat,  2 May 2026 07:43:36 +0800
Message-ID: <20260501234342.2518281-8-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164457_050369_9CE7F9AE 
X-CRM114-Status: GOOD (  13.48  )
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

config_keys_restore_store currently doesn't validate the user input
before restoring dm-crypt keys. Although it's not necessary for the case
of vmcore dumping, it's better to do it for the sake of consistency and
code readability. Also check the return code of
restore_dm_crypt_keys_to_thread_keyring.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 545d712428d3..36e51807d94f 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -358,12 +358,16 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
 static ssize_t config_keys_restore_store(struct config_item *item,
 					  const char *page, size_t count)
 {
-	if (!restore)
-		restore_dm_crypt_keys_to_thread_keyring();
+	bool val;
 
-	if (kstrtobool(page, &restore))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
+	if (val && !restore) {
+		if (!restore_dm_crypt_keys_to_thread_keyring())
+			restore = true;
+	}
+
 	return count;
 }
 
-- 
2.54.0


