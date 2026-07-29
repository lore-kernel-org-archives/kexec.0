Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92719C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQxOZCQ7b1ZQfbOfxmGvWNNQbymgGNjjs2UV3I3nla8=; b=RvDqO1VcPjxwsyfuerRDl0YgTB
	X1RRM4jenyXjvRhGXTo/Zg7HI2qm4p6Zt9KwCSS+9V8Rd/YAIgSwax+gBu88QbXtuB/vaqfkMgiFb
	pAouvZcXX0MVVuR90HMZwLH/71VUyhUFKSR/X4vzhpNnVFNkYQND1equ2ksZasnCs7dndeKEO9bKV
	gFMAHHFu69OcpYi5dgdlTEOrJvJlaSbY0p0C7MIiZ0G4KQ7MmzxBdxu9Kem7kLxwYFnG0XhKM9jp4
	N1nxvwHmKbMu+iVEEz+vwP5So3jFg6+cAqkFgpBTF+dBwIDOXnXwZkyKZ5rQiTRQ+sxBmCkUj9HnY
	Az1RCUmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6n-00000006lY5-3X26;
	Wed, 29 Jul 2026 03:37:29 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6l-00000006lWj-1Hb7
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:28 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ce98cb8165so5044465ad.1
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296247; x=1785901047; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQxOZCQ7b1ZQfbOfxmGvWNNQbymgGNjjs2UV3I3nla8=;
        b=G+WmYW0CI6YDqIALE0zZ091U28FGIbmWiwPpuhUeLwMpwldxajGqeHmhNQojaxIDSg
         hA4H3/GADtX8hpYMwFUGeAk4ifs4N7zs+oEaFbhYzm3svJOO75yAmbDWffdxRqtekujc
         s+sohGtDokstcCWddYX49AMBFd2clGkUgBp5EE35pLNTLR5rGDyk5Lc/nOTALB7SLqBa
         tueLoviewJaOPK/rMJFmfABXUJwSSi+3kT/VHfqeshEenICHe5bJqfx+UCTa4w97807k
         +AeenrfOlDFfdKyH5Y13YEyU7sR41O68OVqj86mgfeEwycL4bLKdnNDr/ENvD9iHmBAG
         w/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296247; x=1785901047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQxOZCQ7b1ZQfbOfxmGvWNNQbymgGNjjs2UV3I3nla8=;
        b=HV95gslkxXCy44DZa4sfF2Dnq0FR7V2655N/G/g3yPqO1uup1/AkZps22ye9ipPET7
         khCv82dbSl4CU1/o6Vh+LSGYMonoR2RKCkmPT8IMZpu12TrTcRUJoZUxJD7cTMXAfq5G
         SlpaIUzO2o93RhY6Sw5yyNPl89awvkG8yC4ATjVxF+3ftXutnhd1qYYS6FOgIcIYx6UV
         nzJL6i74HbkckIigmrh2iqu5jZRQq7jxItW5KY9V5mu59iE2qxbi6GJEDSl0Xv/SENiE
         8TtoCHZngOKgjJyKKcuvQOQPlnWFuTsZGuFfqESqLaI0oob+L/LCisuOVTTcJRabAl8V
         teXg==
X-Gm-Message-State: AOJu0YwhvOJ/KVY0gjToKBfj89hGcwX3WTdoZuzPk26njU4qmu40+WLD
	6B4TfCZjsEMUuZHmF5MPuuSS227mQM/rirs/hkdslHLgwJu+mjVmTb3Z6iNaHkmw7kXsDg==
X-Gm-Gg: AR+sD11suSdw/8LSXvxg/vLaIw1m7owuGxHt7nDklV76Yf4YGr5MU0KELcTDLPvbWQ8
	iME90ofi+wJy8PFaqR1+GnERkMvA/QnSDVfTAI6xg+w1Z1YNpGA+7c9AdoGyITUqeEcl8B3Z1NA
	Yte17HiBQ63XbD/grPUEVmEOdoiILKO+x7QO5/ENpiKygyOsA0TFZDFGHKcWei3spc4AucGdxsR
	qyHdDCtnYNMIL02p8c3Wy58Cg04OkFoG8RVjSKHhEntYrGAKx6A7yl3OV07zBx7CqirbGnhJk7l
	VzWsa0mtK8VSDvXBmkDBiiKPFsT7HtMUk2D1Wdzars0cKuCD1X2Y4Detu/3OARy8R7VBiLCKe2e
	hCc9BS9JyQiJWKE9IPVTAG1GuFwsH5WgAvGowqYRMc7sYOr/29zcxsc7vlKgJBt2Z42M+b3qSYB
	EeGtFmXD6ObxGq26whsk4eIoJAyaSab7Zjk/syQsusfqOTCp3zq3Eeq+4=
X-Received: by 2002:a17:903:2282:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2d0266945f4mr7544035ad.9.1785296246599;
        Tue, 28 Jul 2026 20:37:26 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a152efsm4433805ad.11.2026.07.28.20.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:26 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/10] crash_dump: Improve readability of config_keys_restore_store
Date: Wed, 29 Jul 2026 11:36:47 +0800
Message-ID: <20260729033654.311541-8-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203727_355394_C1FB8696 
X-CRM114-Status: GOOD (  14.49  )
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
 kernel/crash_dump_dm_crypt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 3ee01996778f..1f4549956824 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -370,12 +370,19 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
 static ssize_t config_keys_restore_store(struct config_item *item,
 					  const char *page, size_t count)
 {
-	if (!restore)
-		restore_dm_crypt_keys_to_thread_keyring();
+	bool val;
 
-	if (kstrtobool(page, &restore))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
+	if (val) {
+		if (restore) {
+			pr_warn("dm-crypt keys already restored!\n");
+			return count;
+		} else if (!restore_dm_crypt_keys_to_thread_keyring())
+			restore = true;
+	}
+
 	return count;
 }
 
-- 
2.55.0


