Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7304DC53200
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bdIhn+OgUyuSi3aPTMJd+TLeK514CVbymufQ1vN9nro=; b=Im0pyfOGxfDmXqQCRq3h85BexU
	pVLLZ0MgDrbTBGCKkBS7u86oeRR824yZCLVsLRO6vVUCb68m+APDb04E50My62+YUBexlv/gPx47e
	CEsD6yxTViF7n5Pd7bh+wAMLAeGMM12jrxetD1IcSBvtzmjMlo0WBpfXrJGEwBREnQzDLvHztSYy3
	sIPpbXKq4xwNvuaV8/wh68RpbSf83xl+uVSzYEkav6ghVWLrYvokhRce1/h3yf45DpT1R4MWc2ykc
	IQwP3sI4d29qgblta5qhDNiYRkXNKFeFe9URHJh/69S+D4CFYUUjRclFAfBWpdwlYcjXmzlmQFyzX
	WsnjXIMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6f-00000006lTg-2ATZ;
	Wed, 29 Jul 2026 03:37:21 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6d-00000006lSC-1Ntp
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:20 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cee9b74ee1so4470295ad.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296238; x=1785901038; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdIhn+OgUyuSi3aPTMJd+TLeK514CVbymufQ1vN9nro=;
        b=EPwEnEsZ2smuA5s8mSWJKLe3dd/y5hkN5C7iZkYR0+gliQf73OFtq1/7nhzExAlKl0
         dpU557WLEQ2tFyQAU4/9HRNNF6F4GHsK9MjNq1sor3EVhbT/vsweAF0Gzw2Oj50H/rdY
         BeGfuurPWZ+vmrEwi7QOYWaN9CE0sx3CDzKZIa51AsI9cfnYnNaIn5plY9yx7qLGyZW3
         SHzmq+PMI3amyJjwfhI4tsKGcd4sFXMNoKYdyAqz2jTAM74c6hGoY7wMO7IzFECvvMIw
         ATGvPW/P1pxJn1sO/bZr5vh3OGKbppQn75ACyifDLXp0wkGsC/ChqRxOYbRKn9sK5cyx
         Yawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296238; x=1785901038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdIhn+OgUyuSi3aPTMJd+TLeK514CVbymufQ1vN9nro=;
        b=oyp3sKKSKuB7ilyO4HSEpR401TDgaSyz0nxk03C7GMBSy7tk6kpJDr+VzvcFSuZ4Km
         DgvizAYxieEVfFSh4C+lwpkzp4yxJalrd1Ga31DZ3mZJA7ZqSBNlevc5Iywp+m9nbXhL
         hBQ8Yml8ybapoEUTNhsMxzJUmlwOQrQ9ynugHxBti9w2RatwlwYw8V1OkTZYvF6dt+XM
         gxhX/6Zt/wjWUvS54QG5EgIQklemL1vb6FHD1GXiHfDm6r4NXXn16i9r0r8mb9n1rguf
         GJkrtqyZJ25M6wdlo6AbCBf/yWd14Mvl4YGjPrjXxJFLD5bw6hVHRmFk0bnqCgmvAOSg
         BmgA==
X-Gm-Message-State: AOJu0YyWEe/LLYUiZCeOEqAot9gSkuAOP4eT0wtb8HxcczOlACoyBfC3
	OCvTK6BwuOz4KRQACex9NGWc2+Jr3nhxj/d4jUN4d/7FH1sOo0SyFj50oZ7W/4oq75gl1g==
X-Gm-Gg: AR+sD10KD6F17+NePx48n2Luo+CKvUAO7DLGGYFkB/5gMWuUTFIyWGsyXk/bzvKXWIk
	ZyOhpn7rKmTAhgFcQHfTB/A0LeLpnkuW2ZwKMqVvyDXyzm3wv4fQnTFgEGRCY2yFlAVOL7lhira
	3yYffBXN1JjjCbjYahPBNtkjyMiMV0Itcf6/LDEVzorssBGfknRpfZ6J4D+2hW1zmwnBp7YgjR9
	f+5Ocp/t9arsfpDWkxKIwQ1juJOtQufdFraXbqX1XBHis/yY7KeFB6iWPR8dtmsA3yzCOdyKxH6
	xhbzKtP2mzN4Bj1VyfQeshAIGQ2AkwU+gaB0bo6VKtyXvZ0rz8YNEIg6cYtbmBikQThOVGc4p13
	3u/aIkeW5MiB4NQZvohoDfa7QmsM5WAEyL1P2B0F1sMqtgXCJgtFPAXo8/l2ecZyrLKFpvzp1Nw
	htzT07Er8tFivUozm8NxlR0I3BEnSikWKdfs4p36uBiPqmyNOOHdb15w==
X-Received: by 2002:a17:902:f705:b0:2c9:97a8:afe8 with SMTP id d9443c01a7336-2d015ed873amr56362225ad.43.1785296238280;
        Tue, 28 Jul 2026 20:37:18 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a7fabasm4509345ad.37.2026.07.28.20.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:17 -0700 (PDT)
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
Subject: [PATCH v3 05/10] crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
Date: Wed, 29 Jul 2026 11:36:45 +0800
Message-ID: <20260729033654.311541-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203719_369049_0ACCAAFB 
X-CRM114-Status: GOOD (  10.01  )
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
index a3996208738b..9a64e2d6841b 100644
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
2.55.0


