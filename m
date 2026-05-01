Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F327CD3427
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XeTNxJd+dGh3/lcRtrryZahi9C2dex0hV8YuOKjo544=; b=j5hXXXP27I7lhxR6cgedNZC6IN
	4CvjhSyXJrZc0w0RDSD+kQSJUr64JEyO9VRYMCNT4WdlfoS2UaPuOyJJY1JEFAWDxTLI7RtRnzjGm
	1vgyNKL4+bQ+hFSP/bZBE0PXTGC1C3V72K7wSzW6fSJ2ADAxQoHOuVEspkWKety43YY/0//s0MixM
	FaRXCEKJ6Rfzv86dkO0esFq6rfAJG+6U43DqzB3/5NkawgpzxxhPp0kLUWQt1Fi4U+Vd6zImR5I2j
	JxFknbfKmKeTzCnumib8j5SE+SjKiTxswvE4VhHsKpze3JXaqqcI4rIgAj77I0+QcghV2YT99sylV
	QRHwXNXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWd-00000007qVn-4Bp9;
	Fri, 01 May 2026 23:44:04 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWZ-00000007qUy-3UWm
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:00 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so1693602a91.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679039; x=1778283839; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeTNxJd+dGh3/lcRtrryZahi9C2dex0hV8YuOKjo544=;
        b=l5i6udCrrXgqxOLwbkbd7OnBEprBLpyDOF5/HLhf10UDO3xokmg22LmSLJK6qs2DrA
         U7DqC+++IF8sTVpCXUhHCx6tfA4Aq3iAwWDPk3/6c/XomZCvSh6+9dlUZqBj3kZKdl53
         UoVF5QTgKvLraCb0s1o8OHdhWYCaKqAZzaRbvmfrqdSRKjxsIXHVMM38QmirYYFjo3Xx
         utoIoGlZsXf3999J9csrFmWK8y7cZKzWuPyU+fLQtHwxVs9dcVhNa6OsntzFPhs41bOi
         xWRa4VYl9QHxdiTo8vwYAQmp9pwjW9kGc+GGNwg4g19IY0QdOnEjXDOvZz/vgIghNOWf
         DciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679039; x=1778283839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XeTNxJd+dGh3/lcRtrryZahi9C2dex0hV8YuOKjo544=;
        b=E28utGfpMJHqIFC+y1PhqeH9MMXRM9qKcs0x1EiGQTRdIs/2aFUBQ6P91l6rKe9Bmb
         tUr2kgCUOlq4+0p/sppMPrFq6RVnOUc0Ys8MdbqwrPOrWFGcN6OWsqNGoMg4tmB8Oade
         JpWxlAWfiA4NczuiQc2PxfX91LPsQl5guuSfh0peIYOa26ZTDSt3hasCRC5eeecFdQEh
         T3fHIfaFTFt5+/QvUrp/h4dIK7q7712bAGs9MA3Fry9PhgeSxpSn4bp+Vw6XlzCClCQW
         aeahB4flhlxfwNWMWz5DGkwc44oxdLpMwNzbhHSrh40qu41gvAs2DP/9pq63OiRoWmVK
         jAYw==
X-Gm-Message-State: AOJu0YzP7Tn9svKD0AaK0XCef878lKbF/sq29dL+d3zZQepOQ62TZwUQ
	vCzslLW0G1ZhfAeE3uS+1kkdd5G1KLgQBPIGpiSlGOx8tbKQwe/omg/uIVEhhRXgPp/60Q==
X-Gm-Gg: AeBDieuHyQaOtq82fb/hJQ5dOz3aYgO0sI+DgGHt+owBwTDFPtdlwNruEqhlNgB8loW
	Xc+ehaR2I6qlJ5ic+DP+x6klG4m2reuSKPov/UdLMer/CBxcfSH25L/ybyC83K3D8l3QR+7Btqb
	WZVzOBOyBCQ+ZyObiTvZKqe+8tX8Ocjg8Uq4vjWRGCt3D89t88uI3FFcMH0rMoX5IsNzhb/rz/r
	zsg0vm/cYUK7z3kBj5Cx4N1oJl+xEH5C7SCKQSzkm8YACL5jTCz+CpsZ8+ujzkAfVDysedFGIWh
	aRJCTg3KTW4goQLP0NeYd1c6QdEuOVEHNNWN4VCGWIGJak7756L695F5C+a0+xiHa0U6+C5m7r9
	eEeC5WvLJ6PzKFn7e7JPYuse/lVN5IRZmFIT6pUDzUqr/m4dfYEZwfWIc4zfNCH46+Y6CE2xWvz
	jgi0JdTqOSLGwo2mBfKJDIx36onXQp4A==
X-Received: by 2002:a17:90b:5112:b0:35f:bcc2:c351 with SMTP id 98e67ed59e1d1-3650cd70549mr1163477a91.6.1777679038947;
        Fri, 01 May 2026 16:43:58 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f4558e0dsm1511826a91.2.2026.05.01.16.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:43:58 -0700 (PDT)
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
Subject: [PATCH v2 1/9] crash_dump: Release reference to a keyring at correct time
Date: Sat,  2 May 2026 07:43:30 +0800
Message-ID: <20260501234342.2518281-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164359_875219_1AF36656 
X-CRM114-Status: GOOD (  13.09  )
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

It's incorrect to drop the reference only after adding one key to the
specified keyring. If there are many keys to be added, it can lead
"refcount_t: underflow; use-after-free" error and some keys will fail to
be added to the keyring. My testing shows the error can occur when there
are more than five keys.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index cb875ddb6ba6..eac4f436a8d4 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -81,7 +81,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 		kexec_dprintk("Error when adding key");
 	}
 
-	key_ref_put(keyring_ref);
 	return r;
 }
 
@@ -126,8 +125,10 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	keys_header_size = get_keys_header_size(key_count);
 	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
+	if (!keys_header) {
+		key_ref_put(keyring_ref);
 		return -ENOMEM;
+	}
 
 	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
 
@@ -137,6 +138,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 		add_key_to_keyring(key, keyring_ref);
 	}
 
+	key_ref_put(keyring_ref);
 	return 0;
 }
 
-- 
2.54.0


