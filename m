Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0EBC79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3DIfLClOscXDd9KVxJaaVjKVKAOJFDQ3rKOe0P9cdo=; b=kZPhofHiBJXCzHhTJSh3tpwy68
	k+vfYmUQ2NN6DEeotLXrwuHrkDdghPeFYW+7Dksj9eqe4jBUNnNK3iq1j3fEyHKAThRa0xUrExFhp
	S1iBtpKlZ6MJOHo6JgdEQbEhPf5xRWfDuxDiPdhQQWoXF0H21n9DvJzAARjwfda8bQnPIAyF6lMoE
	ULo//dzdjpgDqdltWCmal4t4KMwqGSZkglWHBwbTb/TPQrVGqGKQfZURKQXkPu1LR9NZNcsGTQ4Ly
	Ta5L5ItLgNas/xhwdE4dimqk+r4fYx39btkdM44GeXht9BAip9P0TavQdS7ndAwI8tpnF13Kmisxb
	6fmP+3hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Ja-0000000AVQH-0ruO;
	Wed, 09 Sep 2026 00:37:26 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JS-0000000AVKb-0Cf4
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:19 +0000
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469d28035so616767b3a.0
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914237; x=1789519037; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3DIfLClOscXDd9KVxJaaVjKVKAOJFDQ3rKOe0P9cdo=;
        b=RA4yQQ515IbNgSbVm4c+8GRQadQxcUByYIqLW8AZcTLGlWbS2JkiirC6/1T12sUVIA
         frihAHfAFhEO6MUX4SVR56gI9xJh9eUCA559IS0KgkXGUISzfk4aYAAtPPeA41Q7HQ6K
         coD19zmxjD5vUOziyOkfbbsXiAgEcpX3LcGGP00PCSmPfZ3OBhJtwr2plm/Tgb/hu55K
         Qmn1Vv2sJCOeFHffhKYdIg42NhxqG1eO6YCgEYsqxHL9LeMVy/tNucAwztqZoPDXftd+
         iLUVel4NLlHOdK58/gUgeYTqNsYBJVOwUhcrOsuObbz1x0tnIVIsfgchp4OwxHjU5u/t
         angA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914237; x=1789519037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z3DIfLClOscXDd9KVxJaaVjKVKAOJFDQ3rKOe0P9cdo=;
        b=IIvmerH/mP1yfjjPdEUgGSMthC5NxW9cvuWNJzgtkO0+n5SKHKf04Grz01phXfDS4t
         dxcspimqUt1CYHndTw9PReTtFNqRpo7C87dqp/idq/JXycl+ISr/WRvO0w9A2LdEvCeX
         xCdLXOIjxMjUtrl3Eb8MuCBTnYj/Cv1qjnItnvrlPhxJViUMIzn2riuQpOwgd4o133yu
         PWfzDM/DEiv7N/Hde4DPG8wVJdgbbCDEt9iXmSIgJbeobbSh8BZxkyJngKVvixx/mlsX
         kHDzPyjnRf9MVabcoc7NPtTiXYxtJChQyTJSz5lBB3s8+i5aXF2i/fdXW61fY+Li+LQh
         hxIA==
X-Gm-Message-State: AFuF++kid3jMAlkd4TeGeRYJhzmR28nX2da1em0bVQD37aJpMHrhF6n6
	nKkszLCqnA43qiosXH2dUeuFJvP0YgNDjdiWIs65KEltRSK1Ou+BUQ2olpsiR2iIpRc=
X-Gm-Gg: AYBFou234M4SZ0+DH7xNyRG7Rj5LERC4T+8QuUbkbo+/Cd/VEk8vi9hMWHwSOcT2nsq
	xnw0YmlmsszITMM6oXGL5YiTE9eO1HI8k7GShs//ZvQ8qtzp23kaD1wh/d8MsHT5UKdPNyygUne
	TCbXrUEc1z/G9oQThJEDdtfbLl0yrZeJuc0745PBXS+J/TzVMZK5HSrWDgcLnoyo5PYtoPPMvL1
	elvCIhjSfBwmqSNP+sGVKWpkdTOi5JwKtpOH/cFuN76txbaW9hgmO0z4WIggudEoY4Y6m006EgL
	nBsgiz+gpwrKK/HyPjMPlGKnON+vFDwOPC3BKHXb9N3k0UbnQRa6TLNKUpNsRgFzvapcc3Ahp+s
	k8Nw2VhvTzElw0x756jFCGpWflkU6HqpDXP8mGOFQ3pRTtIWZS4VlofAn8Q0mp2HHSuA+2P4Zqa
	yHcfW2Dihr3DqjemKMMoUNIkFLPlWGVezgxpeNNoGSIzPU46thkT/9277KF48g
X-Received: by 2002:a05:6a21:710b:b0:3bf:b9de:8557 with SMTP id adf61e73a8af0-3da9d98d1bamr9827360637.9.1788914236936;
        Tue, 08 Sep 2026 17:37:16 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc46da5acabsm4326371a12.8.2026.09.08.17.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:37:16 -0700 (PDT)
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
Subject: [PATCH v5 4/9] crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
Date: Wed,  9 Sep 2026 08:36:46 +0800
Message-ID: <20260909003657.1570544-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003657.1570544-1-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_173718_138013_B44D3AB4 
X-CRM114-Status: UNSURE (   9.87  )
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
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 580534d43b66..ff6055a97a4b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -118,6 +118,7 @@ static int get_keys_from_kdump_reserved_memory(void)
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
 {
+	struct keys_header *keys_header __free(kfree_sensitive) = NULL;
 	struct dm_crypt_key *key;
 	size_t keys_header_size;
 	key_ref_t keyring_ref;
-- 
2.55.0


