Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B230C79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/nSpHth++g/gUUsEL3F+NUVCLcirmCqvO6RY3lCswg=; b=zDGdwbI9p0GXysyVowxFviEY1Q
	S7z9PEPHqEvKWnnn8kR2H4xDEAFG9lah1ktzwlwB4Q48zOidKXPS3lBkMjM1wgWfvFDzEENVmlfqU
	oKhdFcnl3UF54OgyKKDikrSueowL3C4D4ChZZhdnvVxedWPM/uDmWRoYA+dV+dxpF53ipdV2ulUt3
	/DCdbGQc7vXkzaUsbOst7C0/GwRo1jdKLYXvtevOJRsiOXzAimxv+Jws47ytzEIBqgao2WYXe1yg6
	sCnWm4kQV3JoX7RKDmJABRyb/Y/+/Fsa1Mx8sn69YM3QlbsaT0e5sYro8qESOe6dpaCTKYNVM1FX1
	se6gf3Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Jd-0000000AVUJ-1gHM;
	Wed, 09 Sep 2026 00:37:29 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Ja-0000000AVR8-49yj
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:28 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so522722a91.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914246; x=1789519046; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/nSpHth++g/gUUsEL3F+NUVCLcirmCqvO6RY3lCswg=;
        b=olDw4AIZqHEaFPbmvaaAriW/ZS5bcHa7QxKEW5pyVIr6ulQas36pxoCHVovmLpflTt
         1YXr1uSyYT9fYzJkE+DVyfjwkyN/YeiCnlYKgOemDj/RFOeWNl47a9nzDEBka0sqd2hC
         lvlfbL8V/+FkafpssCODBWYzvNZIlySzYM0ehJSwdmlwyIA0dw2ofQVG6CMzR9CKxtw1
         XFiKChDYGr70mP123hqQfMr1hheYJJXCq3kGbkY8D9WCdCdc4jKaRWaU/iEdiu1WN5nl
         kvla/AVddfWVypRyG2olkArbxO6aC8Xvo99NSyW4Exo7BbQ5Yu2uCehGsPJ7jcb4kLGb
         fxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914246; x=1789519046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E/nSpHth++g/gUUsEL3F+NUVCLcirmCqvO6RY3lCswg=;
        b=Vf6tmmi1Dhepu6Xo4YkWaATUJvEOSy28E9f6VmJoOXS+OP+koxPykmzXYdpdGn2BBd
         7VeM1a48/t0nKC863kldAKx/zpZWA/dtjtprYKqDrLKDGK72vPBgaPBxvevb+di0AMfB
         vnIgML9D5jSY1oVLjFFomLPTkBdwwcyJi2YVdW6ZAL9FbkCP022DUE3eUO8TjV+wX7F/
         /CzXxcvYjtrsX7yLn2ahapkGU6aML0fPpx4j5l4TV+1UCcB9BA38SPaV6qKsQEtUqAql
         zRqigrOYDhN5666U0mXc9kJwGkEBhyTutVATCwkA2mXjasV9NA4a4KIUxjtOYhuWk6kF
         tMcA==
X-Gm-Message-State: AFuF++mOzUOih7lsCBs2ReSCKqFi7lOSH1cEvPZE2uW5b7MN147BaUEN
	aEO93ELCLZrp1BXmQWoqw+yWigfN/Iyx8YUBQRoH820XQ7ojQ52gdGu5BhYtB/wxwoM=
X-Gm-Gg: AYBFou1Nz7ZEzepqJ7CDQ8RYjRNQi/fUADrKmpkhDXX2W0y/vI2sSapT1R99hMXIgDh
	ru0yWmSkq2BlQmNTtzf6yVrh0Zbv3lEr2F6j0YqKUjAo51Oms2m76YliOFRIvi9EcNmhgwbol/X
	I5Gy8dVmbrPD4hONXsg/hThex1BEd0BZr3EldSTk+aCZ5lw219pitZtOXPO/mjkt0i5+JIbaPrH
	1gq3+hiceZNSHGeJyif471nGf99XSaoe6FsZW0oVv2HimDNikIADEhDH4NGSEivHYXPLaaroZei
	uGsLMkFONkkd4pgNsnfD8nWp1pe6B5bOYS39VyHY2kqiZ+fTdgiB2k1lhd3wGsPGzHZb9NneggQ
	d2YkQwybpvqfPwiAWoS5tmggSO+i3GA2/dxKxXojlYiRfpNpCb2ofh7OEmQ6zdYtdBHGFObaxtr
	qMdboJ2LENF+CdMarH2EoYvEpBg2StV/6HzjSBfVGi8iOYE+OxMQqJzDO8X+8Z
X-Received: by 2002:a17:90b:184b:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39b8bd03b29mr8739873a91.4.1788914246185;
        Tue, 08 Sep 2026 17:37:26 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm40660284a91.14.2026.09.08.17.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:37:25 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 6/9] crash_dump: Improve readability of config_keys_restore_store
Date: Wed,  9 Sep 2026 08:36:48 +0800
Message-ID: <20260909003657.1570544-7-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003657.1570544-1-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_173727_033114_B0035821 
X-CRM114-Status: GOOD (  13.59  )
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
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 9ad50ac54866..b8fe630462cf 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -371,13 +371,25 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
 static ssize_t config_keys_restore_store(struct config_item *item,
 					  const char *page, size_t count)
 {
-	if (!restore)
-		restore_dm_crypt_keys_to_thread_keyring();
+	bool val;
+	int r;
 
-	if (kstrtobool(page, &restore))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
-	return count;
+	if (val) {
+		if (restore) {
+			pr_warn("dm-crypt keys already restored!\n");
+			return count;
+		}
+		r = restore_dm_crypt_keys_to_thread_keyring();
+		if (!r) {
+			restore = true;
+			r = count;
+		}
+	}
+
+	return r;
 }
 
 CONFIGFS_ATTR(config_keys_, restore);
-- 
2.55.0


