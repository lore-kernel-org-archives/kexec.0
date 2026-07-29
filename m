Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32874C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=prshWjmC+BMvmjIFuL3b3WiZTV2ulzUtgLsObUBvHpc=; b=DOLU10fCH9/iHj4Qc7zjwQ9M3k
	fkDrJhzSDBfuwYDzGuq6zIs5NLGUQ57eP5Kkz9sSPy/5pHeFYgpPAcl3PIg9KQJ069k00TcUhPFqF
	dwPdGbwFgTXb1tVBsEKTUQHj7s/85E0ZXnceDc5xcdxm9bzGoKnpbwD6Ai3DBU8CYhZ9QB/KfguxF
	/okPe7hOhUUVL/BPmv8RjlYr2EtRSDA0+b4vtapiS8q9A/1PSPTvi9ZKuHh43wvBnlUAABNWp8RC9
	DnUaIRP0Xu594D3ETROxXL6RcrMD8OsBCMgMLx5WpgogaR4pw52kOACpsncs6j7sfHesGccwgQMsB
	NM8OT1tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6X-00000006lPS-0jT7;
	Wed, 29 Jul 2026 03:37:13 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6U-00000006lOR-3fcq
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:11 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-381216921aaso450861a91.1
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296230; x=1785901030; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prshWjmC+BMvmjIFuL3b3WiZTV2ulzUtgLsObUBvHpc=;
        b=OshfaaQrCWIZYz6IQwtnA8UswW3eZizZJ0DR2M+vKZTwbwOXT8YYEkwFFOsNq9oSh+
         TlPCeG+B19oVxKkiniuiCB2YsbBj7Nb10ilAGPcB9F5khXAUVCYR5MY8TtUV4pAywWT2
         BMEisMuFU4Op2vnC/jcnbzNnXU1K0aI4qher9cb/JjEnuo5nBPbv/DEZCp0x7LoKFrc3
         OFgA5iil3vH+QQevWU44Xoafc3a77toW8EdyVCD0n6uIej2oPfg/Q9uszfhRHnJDLAEB
         pv06AmTVEJCyCuCsNt9y5CPvNYwzbnqucxDRv7y1GDuWeXuCFznfQJC7K/0cSVCSheN+
         FcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296230; x=1785901030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=prshWjmC+BMvmjIFuL3b3WiZTV2ulzUtgLsObUBvHpc=;
        b=ji6pQEQE4kosTHRZ8gbhZlA1T23866MTgrJFMGpgiRT0AsoGXG3CLwIiWvUwikMEBK
         wxaGl+Fj1bERYf0FuWiZjoLxFnZ6VSU34FGXovtWMHP54kDk7mnKUincRw15KyV+M71w
         lE+VDFmKF92u37CJlAYlY27u1bxUlj02sI+jjyRhGXpFM1+UuEkWZ4rlArVWm7k3P4/n
         apLulsLU1WQF9Kyj7JRCXijhSGDn5MQDe+r9DOwiOm9GOEP+i9zfLjbqtKcuvFCvRhzF
         pLLTCBXwewxshhDQJEsh/62nfFRzm//6tFT+CmEZN5e8apH0Ec5PQIO4sGRu0i/C/K6a
         0HEw==
X-Gm-Message-State: AOJu0YxxIvpFBEAVq2T8/aKUcRs+TCsMof1NN6yy3fxqQEg1RGRcZ2HE
	Y6A5VcsRcXrydFq/kp2S8C8VwQLUU7qO1NQ6Cdh3AfbRv7nT3FuUgNTCcWw57AFydw9IiQ==
X-Gm-Gg: AR+sD11iUSTWX4BXMyNCbOZy84KvkRc+VoDAJ3Vr40UfpNymE8qA0yRrvPncGZTZRtI
	7LtuvhZGRdmbPJtXe92r4lOgQlmIHziN5Se6KyQC1yQ3uPFwj99zBab9BxF+jMQ8ZDYF01HxE8d
	BspmBq/2uNbzsCTCEzbMlL7Rk+eARx8TPRp3pdpa5M1MN4f+WNTYFr4JV2Zanhhp3NJIs765D0u
	kg7TxU9r2XIgvQ7MJarGer41j0hzIjv8SMDL24kJ59djgbeyh4H75gnwbOgkicBYsnFXhqpJJ3q
	gu11ZqSURUK+8FN4/rpTld1e1Dot4hqlvGL4jVvrObUFtbF5C50Dp4CpjIHy0Sz3x7KYcTISJKr
	ddfmqS5Jo0XuZqK5NJthgqMhWB/GQM/7OaTYaxHfCsXChon7/M1t+pTQDhNu/orvg3jwRRRObBC
	1s9mQhaUQUPKSed99RwDMF2Sg5iwSQHfXpsXSbXD+qUqs=
X-Received: by 2002:a17:90b:1e48:b0:38e:ab33:9551 with SMTP id 98e67ed59e1d1-38f6a48018cmr4817854a91.42.1785296229894;
        Tue, 28 Jul 2026 20:37:09 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e14::2ff:53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f814cba32sm250391a91.2.2026.07.28.20.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:09 -0700 (PDT)
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
Subject: [PATCH v3 03/10] crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load syscall
Date: Wed, 29 Jul 2026 11:36:43 +0800
Message-ID: <20260729033654.311541-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203710_942811_3B1C53A4 
X-CRM114-Status: GOOD (  15.67  )
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

If writing to the configfs group happens concurrently during
kexec_file_load syscall, it may lead to the following issues,
  - buffer overflow if dm-crypt keys are added after allocation
  - stale total_keys if dm-crypt keys are removed during iteration
  - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
    set true

So hold config_keys_subsys.su_mutex for the entire sequence during the
kexec_file_load syscall to ensure a consistent snapshot.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 4335b6cb1fc4..d2e66c6fe6f3 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -293,6 +293,7 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
 static ssize_t config_keys_reuse_store(struct config_item *item,
 					   const char *page, size_t count)
 {
+	struct mutex *lock;
 	bool val;
 	int r;
 
@@ -302,8 +303,12 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 		return -EINVAL;
 	}
 
+	lock = &to_config_group(item)->cg_subsys->su_mutex;
+	mutex_lock(lock);
+
+	r = -EINVAL;
 	if (kstrtobool(page, &val) || !val)
-		return -EINVAL;
+		goto unlock;
 
 	if (is_dm_key_reused) {
 		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
@@ -311,11 +316,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 		r = get_keys_from_kdump_reserved_memory();
 		if (r) {
 			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
-			return r;
+			goto unlock;
 		}
 		is_dm_key_reused = true;
 	}
 
+	r = count;
+
+unlock:
+	mutex_unlock(lock);
 	return count;
 }
 
@@ -421,6 +430,8 @@ static int build_keys_header(void)
 	return 0;
 }
 
+static bool mutex_acquired;
+
 int crash_load_dm_crypt_keys(struct kimage *image)
 {
 	struct kexec_buf kbuf = {
@@ -432,6 +443,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	};
 	int r = 0;
 
+	mutex_lock(&config_keys_subsys.su_mutex);
+	mutex_acquired = true;
+
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
 		return 0;
@@ -481,6 +495,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 		kfree_sensitive(keys_header);
 		keys_header = NULL;
 	}
+
+	if (mutex_acquired) {
+		mutex_unlock(&config_keys_subsys.su_mutex);
+		mutex_acquired = false;
+	}
 }
 
 static int __init configfs_dmcrypt_keys_init(void)
-- 
2.55.0


