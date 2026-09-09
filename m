Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B51DC79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++us62bnNsUPvWVqDmA/JgoyZsHakSa60fnEd2AY7KE=; b=LEkKSJXB0zhkAj4wP67JHriOMn
	8tZWUDlGKZihAEQh3b3m0KKm8WB2ioGYBQrKK6jFCf1wcJhjlCKRrMB0ZA2ob+6baEh2ekFSnW3ae
	jHV9LCpp+eC5bLjry06wrzNXT/1wCzNzK4xvMBaQzZYP8mtVYdqJBDKAU8Ckt3ylUS2e7pNCVIEsw
	7OjEYRicjmu6esqrnzY3Vyff9j4KjPKHgHfLzDQgYW/EHOuI1zokDp22g7mmvOdLXDhAtL1AR3uV1
	s/Tw3NvLzFl/ff0OyhekvCdsu5KIbhJjyx3+tjn2WVr9VndZz3j4WfAHLIaf3gjJDkqPPquZYy9Jq
	7FJ8pckA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Jw-0000000AVno-14fB;
	Wed, 09 Sep 2026 00:37:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Jv-0000000AVmK-15md
	for kexec@bombadil.infradead.org;
	Wed, 09 Sep 2026 00:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=++us62bnNsUPvWVqDmA/JgoyZsHakSa60fnEd2AY7KE=; b=YLgt3/pKFTuk49KQsZSH6AtMJF
	m7o52gDpt2pjGFoujxoIcOc8pWdXiEOb4DreRvWKms/oVcwCtNrr5eocsD0A3c42tgYjuPq2+XRLr
	VO5eWZlIGoimBjIkf2wEw+yWDZxJ0Sbqqrp3gIdESHstJ3yj14u9Ium7IoS31W5LJ9Cce37OvmY8s
	tGa3dKQwBScPQ4YBdid5kdAO+4AllU8CKMyxONexSgfxstD22xmD7pk5w5Uo0t2IvUwZPW9FEmQap
	yvtx22Bia7GfLKdVfyKEqXqhyxzW5CvKU8sVMD3Lk6kGKEfESZDnYXrELz+9FZWR8yomkfoe8uP5e
	i2VmVmDw==;
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x46JY-00000000YJU-09yh
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:37 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2d715f4a587so73329655ad.2
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914242; x=1789519042; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++us62bnNsUPvWVqDmA/JgoyZsHakSa60fnEd2AY7KE=;
        b=AVBh+oO/pBZcw1KMRSPeRCcNo+VUVyGQCyFMN+n9R25mjjMoKiEi2ZYvBcYRvFSoK3
         Q2de0El/nr6vGOeIesTA7BkDzjP+Jc0LOpZsEz9TGGbmT1CDYV1q4MP2Og7VgxPHMGK5
         ql02qAILIaL7Z0ZLI3kTY+5lss8jaTW4g+Vuc/4NdxFIcwRuoQLulDlexYko52djCm1q
         EQQGJ1f8F299dz3Bi6ubVERERBOERU/04xUzov4FW2cEMvpAHsd5nusqeH6SIXSJY76X
         pHz0f8myDHYvxt0c6qeGd7FdgPFEDwWuze4G+Ptx0qv8TReP1e8JmfLfAK/zD72AfXkt
         iC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914242; x=1789519042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=++us62bnNsUPvWVqDmA/JgoyZsHakSa60fnEd2AY7KE=;
        b=ZvAOkG1MedIK0CE9MnxFs9GUWf5lcKhDJLSfPMfFD+4OVaH8W577eLRuA4gstPdIMA
         O+q7MB+cwAQd00HeCR0DwYzksJ0dVSKbG4YeNmCmq21wjApgHC4PjkCV//DcKODeuTgB
         ssaarKuEV5vNtZLX8FIag3Oz6Uv9PJ+Pr052mKXjtMiSAvCAxFkudRHU4LPYVJZ+bcJ/
         91+5oqCcx32vvFVZxXwTSglWKKBhJ+DlEJ9plVnU/Vg55T3Hb2gDfOsuY9uE6PbmJW8b
         tgTR5txOFj1WIQV/cnX6SnaXdKZrq6ztcVNqjU6JV3lhg/c/G1SBvH9LQzcLIlLCouZ/
         BPtw==
X-Gm-Message-State: AFuF++lob93fUwfkkNTB3saHJYr3Xp4Ew3cMj17mTssDN4vSHu5oj4Hz
	upGuOm3Mq4QhGNJWuHpUrQEf+LY3Qs/3dIi5Nv16ESTDhXVg1WL+lPn8bmjx9IieyjU=
X-Gm-Gg: AYBFou21OhbsO118P7A1S0w5CahaO4eIxJ2rMStNYRUEUKIzMpeptH5B0WSX7L3dQa/
	o9yu6JFJQG4CjAaN3pVi2nliqg8a/h9ATr0BzmfK9k5N6ddXS77uJKayavDTV7YqBJuWQhjLbxB
	MYoJ9/9BXceqzIsSNd77oO/06PfzclnRnZ9fL+C0F3zvRoe4vnFVXo2MDXU6QMWw2qg2FxaaIHX
	kt25awWBxpmFoW6y49lrfnSv5GiPgEaGei8F/va3MOIZ8FMrgRFmnerlMTjSYi/jvLvVJLSlRb5
	nMVjEZ3zO5+O+GxAW7eyHjheU5EnuIRTy88PEAFovBjxUmLdnnAAY8VYa4OVY4m2IbW2E4tSk/n
	c4DgUjynk0L65PkZqTcqG96syV7boR1NzHK6JjqxuFEMdiireLqEKoEBhdBvtPho3oEKsUwgUxs
	H96Zc6tz3E97F7rBau7P4qIJmE1ap4uOaAJk3OH6OjIyQwqOKw/+YkKfVTiERpdG2QCrF9sbQ=
X-Received: by 2002:a17:903:2b0d:b0:2d9:1dee:43db with SMTP id d9443c01a7336-2db1284b6dfmr457504295ad.15.1788914241741;
        Tue, 08 Sep 2026 17:37:21 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae85eesm62627875ad.82.2026.09.08.17.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:37:21 -0700 (PDT)
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
Subject: [PATCH v5 5/9] crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
Date: Wed,  9 Sep 2026 08:36:47 +0800
Message-ID: <20260909003657.1570544-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003657.1570544-1-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_013735_651281_99BBEDD3 
X-CRM114-Status: GOOD (  13.16  )
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

kexec_dprintk will only be activated by "kexec -d" during
kexec_file_load syscall. So use pr_* outside of this syscall.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index ff6055a97a4b..9ad50ac54866 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -76,10 +76,10 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 	if (!IS_ERR(key_ref)) {
 		r = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
-		kexec_dprintk("Success adding key %s", dm_key->key_desc);
+		pr_debug("Success adding key %s\n", dm_key->key_desc);
 	} else {
 		r = PTR_ERR(key_ref);
-		kexec_dprintk("Error when adding key");
+		pr_warn("Error when adding key, ret=%d\n", r);
 	}
 
 	return r;
@@ -129,19 +129,19 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	keyring_ref =
 		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
 	if (IS_ERR(keyring_ref)) {
-		kexec_dprintk("Failed to get the user keyring\n");
+		pr_warn("Failed to get the user keyring\n");
 		return PTR_ERR(keyring_ref);
 	}
 
 	addr = dm_crypt_keys_addr;
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
 	if (key_count > KEY_NUM_MAX) {
-		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
+		pr_warn("Failed to read the number of dm-crypt keys\n");
 		ret = -1;
 		goto out;
 	}
 
-	kexec_dprintk("There are %u keys\n", key_count);
+	pr_debug("There are %u keys\n", key_count);
 	addr = dm_crypt_keys_addr;
 
 	keys_header_size = get_keys_header_size(key_count);
@@ -155,7 +155,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	for (int i = 0; i < keys_header->total_keys; i++) {
 		key = &keys_header->keys[i];
-		kexec_dprintk("Get key (size=%u)\n", key->key_size);
+		pr_debug("Get key (size=%u)\n", key->key_size);
 		add_key_to_keyring(key, keyring_ref);
 	}
 
@@ -315,8 +315,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 
 	r = -EINVAL;
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
-		kexec_dprintk(
-			"dm-crypt keys haven't be saved to crash-reserved memory\n");
+		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
 		goto unlock;
 	}
 
-- 
2.55.0


