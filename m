Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC72CD3427
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0cMvZy0EdvXdtjZIbYJP2hPzOnX4/VXPNfSPuv9FZzE=; b=D/QxwqLLopelKcnTVuAZvmI661
	GbCA4V+Q12knKCu0m/CvPwBjrrAkcEz+7ktGd0+dBL55mAFR38K3IPtkk9ScgmfvX06CPq/nnt5c8
	Z5qTGmK1XUmFe5j6aD5y2ciegGvN7ryT7MIlZKJvXqGZscAmewY9sfFrX926KK+m3E3XWH/gHh23+
	2DsGScxe3I+SJrn/IIGP5QMPQsRt6VyvONIP1pzheavL3ay5d1KaLsSUNnvcExLPmV7XHQLtE2YZa
	cMcBCp8mkOBH8ag9zuE70sVsjSSVuej98bIk3Q9HB4HLK75VfV4MXg8Cpgr5/DPRPfUpGU7ABizrM
	+WEdydTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXD-00000007qhY-1X9W;
	Fri, 01 May 2026 23:44:39 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXB-00000007qgl-1xki
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:38 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso966880a91.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679077; x=1778283877; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cMvZy0EdvXdtjZIbYJP2hPzOnX4/VXPNfSPuv9FZzE=;
        b=F6stnb6MOis3bxUTdivIdXX6vhdK642q47Jvd5kUKTe1YgHDQMgYuM4Te51qQPo73U
         a/tiiz/TL8RKdXkMJFS61zl/eTuHssS+bVjys3wEPkEZG47cIc8rmmPVU6kSEP8qm+/F
         4ISuTXQXdYd19s4ZeC+ZJdMgdWUrgAHLDR7WoV6lsiKsgTAz10wvurtbi6UFRr/101Lb
         0Bnsz9ejWVi6AO4j8lrfdCChRdGZY/4c9/wdsTevv6NniEuSe+fdJe9joUTSUXl3gJQC
         1DV//SllvyUwBc9jUUGCNVUoSTyZcxWKOieGRuX3P6lAs95VlhhWJlJLtWsEhTw37y7C
         IREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679077; x=1778283877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cMvZy0EdvXdtjZIbYJP2hPzOnX4/VXPNfSPuv9FZzE=;
        b=cMjDdFiBBW0m/rjuEf8sMgGmEGJ2nXIC1uBiDy/g3LLw+mKuyWg6KMinftyIoDWdVO
         HZG9qHUJm15bDlXcV214JTHOOPQRSUO/XBKc3D/OjTh/oxVdl/jP6VU8lnAj8AHOnvF4
         DKzQHypc8Wj07MU5jNFoAct3DpgXPKUb3fd1ms5Qe69y3F+IehU4+79rzGVuqrhLfuHD
         GwIWFV8AX0la2izY74BDIljEod3ZJCHvG7Qpq5XE2R61F4Wft2weddCg7TybBx0xfN4Y
         AFNOqWfglSBlE4lQYDaWPujSShL7qbHT/lZoVqSzRdhaUsgZfYC27dYNqhb85XvcFVCE
         XvWg==
X-Gm-Message-State: AOJu0YxJJGE6NyD3rvdUcqxxN+u7+UB5Z1pCG87sbFXWpTPGAdig3Iyx
	995c7B2KWYuz4APUwCjuv01l0lBSaxX0N3VtcRab/ieLgEyG7N+fdxHl8xIp8YXjZlyUgQ==
X-Gm-Gg: AeBDievTna7Y2r6Yr8jNYjhTpP3FzjCBcT4urw+PIerGQ7sRpH7dZZtsynyufns4zZa
	GPW27q3yO4USEtFwmE5r8BqgbYCsL025cs7+UCF91NYPuCgESWxGe/rJdtIRpoVbCC4kqFyJHyI
	z+woR8IhjHcjSfHraq4JRt7nq23ByxUJdGnJMdfA3hUltYYL14eh09GduYrMEoCNMBc8tXI0bXu
	u/Z/ohTCdlc8pMxyrs0oO8O1BnIN+wxAg6zTzw1ZGNLnjSzjFyVbeAkZOMk6RMMzaxAJrOeawVd
	Q2Sn62bdYkWDlLEoS+Cu/HbdvEO8MU8xXmqUXJlDADJG4nU9HTTWe2LcPTg/yXUldGO1vGUicY8
	gtqP2GdTRzLVkl+BsMAke7M7XswDvsQbdY6qEzl962mEVSSnKnpxqGwzeJyhsew3/S8Yez4UD8r
	+vY5hc+G0NLfthn6KDDHUv85rXwKbBNw==
X-Received: by 2002:a17:90b:530b:b0:35d:a3b4:2f00 with SMTP id 98e67ed59e1d1-3650cdd0ab3mr1204489a91.8.1777679076659;
        Fri, 01 May 2026 16:44:36 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364d1c70d8csm10098961a91.13.2026.05.01.16.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:44:36 -0700 (PDT)
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
Subject: [PATCH v2 5/9] crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
Date: Sat,  2 May 2026 07:43:34 +0800
Message-ID: <20260501234342.2518281-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164437_503245_1CC026D5 
X-CRM114-Status: UNSURE (   9.27  )
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

Although we expect the system to reboot immediately after vmcore dumping
is finished, it's still good to free the temporary keys_header buffer.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index a3e460714d23..72ae2dffb077 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -117,6 +117,7 @@ static int get_keys_from_kdump_reserved_memory(void)
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
 {
+	struct keys_header *keys_header __free(kfree_sensitive) = NULL;
 	struct dm_crypt_key *key;
 	size_t keys_header_size;
 	key_ref_t keyring_ref;
-- 
2.54.0


