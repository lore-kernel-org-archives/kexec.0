Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E11AC53200
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARray8b9AEh9C2cKPaqckaUEH2ujUQq7n+eTL7HUcKE=; b=1C7Xu6jtPIxJbOOQp5OGUFSla1
	aWxW37tjFoJ+Q+hd+AxHBGDOoY/OnqU13DkqXfOqlbJOJDdsrLuo8KvjqO+/RQKMSRAh5gV71J2mf
	dqPJ2XgIfLQgK3/O8yv+2qvNMO8ffawJv3L7thgSFT6GU3frx1Gw2W1dpwbDSX240uTpUfwfe4sw9
	sR+Me37SQzIfZFPM//P2PFvLP/+NZE173DJJRlSfdUk1V80FhXsmyshA+OjOGcp5oMdiKnuk8i5Bk
	1w7cUfYNdbZ/XGxYTwpsSUSnMGch/wzYUnmLDgTA+DOF3xixdE5iYv7WUtR2WVKhfPpNJq7HJP/rf
	6p7IiZeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6P-00000006lMI-46Fi;
	Wed, 29 Jul 2026 03:37:05 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6M-00000006lLF-1IcJ
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:04 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-84e04df8c46so557613b3a.2
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296221; x=1785901021; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARray8b9AEh9C2cKPaqckaUEH2ujUQq7n+eTL7HUcKE=;
        b=axgEJWCWAjRgPaFO4STpaKzCVkhlf+Ct7wk35QuYubLcXMiz2M9Z65fY02B6LrE4Qq
         vhh/Cy3CfiDM3JnKSlKzkR6Xiyda+U/ayCOo46BFDsItu/PVm/YYpJ0afZsgBsbzmafB
         N4kQLpbsaQFvzJN7laASPnh667WnHEiROqgFlCntL/yv/r94+08dp7JB3YAX2uWlkBfL
         gjVH2UGYybTXQryeXzWkBCo7wdCtJBezgfcNX4ImBRw7DA4H1u3k6SDPPP8LHir4OJx5
         HyqYikofi/V1hJ3a7WMPAEuvZP79L4yDzf/LBAdT5t8eaW8/IYCLs52CkZpbUNSUPKSQ
         6YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296221; x=1785901021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARray8b9AEh9C2cKPaqckaUEH2ujUQq7n+eTL7HUcKE=;
        b=E8QkZOcqeE+1IMxTvA0xreuDA/1bx5l/k7P24iFWKJksmaEZdDnkGorCfOybdqjFai
         rNA0fyJ/DxTy4yqsN0EbKYzCk11H/Q1o2vDqikgZdRX6428eR0baP+WeTFui0bGJ9TZc
         WcdHJ6iwoY/9Nzz5oQ10pG8keJr06ga91+LdeoKK5kaoxB6m0EDV1T4BKrjE9LVKR2ua
         DaNqnOFAyOAkKLi623x4lL9/eufoz1JxGHBmRsEB7+hzwYIHpBE0qVSzn4C+TSlId+Bp
         IXOutntWLgzMbrqZG+QN72CN3cPHvGKj+AnKUph7VQcVxmrK/oRf8sJRHqQliBShHPRL
         0drg==
X-Gm-Message-State: AOJu0YzkqDiliPivxSIfkplXUQFXz4u3iTfBOFe+QjFydiRRNbJ2JXHd
	uxytVEUNzI7au58EWpvoN1JUHtvP7veYRpbPZR4Z+Ucueg0+j47OXqz+W5d7SehO++Ayow==
X-Gm-Gg: AR+sD13U0Fs62T04UqdrsPsxV2hwn2MbshIaXHsUcWMurb7rhsbVuWCrLuj8agM2Wq+
	WA1zWe55bV6mIXp7iwbUtoOW/KLQntczKR7txQwo+xOqehD/O8y+8RJuJh6+udLWFewCinhIDxJ
	x+y5t5VSp2V9jsPAGki9oU2zIMqm0BUF5sbR1gWo2YS0491/GL5XhIaV3kzobLMHRr7GxrNbf+P
	hU0TIUwpK+prnow5CYJucUfVol0zgKhbyjxLB2ZhCiYH6ftGY0vIsiyiUwOdfccOxbJiN5hsKaF
	4f/MMqiS7W9wOnGuOyd7w58yqkgtTjZRWIzL0lwdAHj++gvNRa7dyQhJxoYO5J3WMZF/16fCBaz
	0Dymj/zkAJNgcMTkrc5IJYC+bcLKRVeFb5GJ3Ck0jkhOGwWMgAkPkizFgIXfkH/n2w6/53JoiV3
	RA/LLCu84yXKGqr+j+w/mKOQeCqn+xn9aesl3VgE7lDDU=
X-Received: by 2002:a05:6a00:2e28:b0:843:49f0:f5a0 with SMTP id d2e1a72fcca58-84e9321d418mr5373617b3a.32.1785296221431;
        Tue, 28 Jul 2026 20:37:01 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f3:1e14::2ff:1d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm696242b3a.15.2026.07.28.20.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:01 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Coiby Xu <Coiby.Xu@gmail.com>,
	Bradley Morgan <include@grrlz.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/10] crash_dump: release keyring reference at the correct time
Date: Wed, 29 Jul 2026 11:36:41 +0800
Message-ID: <20260729033654.311541-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203702_379381_029900D1 
X-CRM114-Status: GOOD (  16.24  )
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

From: Guangshuo Li <lgs201920130244@gmail.com>

restore_dm_crypt_keys_to_thread_keyring() gets a reference to the user
keyring before restoring the saved dm-crypt keys.

The same keyring reference is then passed to add_key_to_keyring() for each
saved key, but add_key_to_keyring() drops that reference on every call.
This is only balanced when exactly one key is restored. With multiple
keys, the keyring reference is dropped too many times and may trigger a
refcount underflow or use-after-free.

When more than five keys are restored, a refcount underflow/use-after-free
warning can be triggered.

The early error paths after lookup_user_key() also return without dropping
the keyring reference.

Keep ownership of the keyring reference in
restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
and make add_key_to_keyring() only use the reference without consuming it.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-and-tested-by: Coiby Xu <Coiby.Xu@gmail.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
Reviewed-by: Bradley Morgan <include@grrlz.net>
Link: https://patch.msgid.link/20260704112509.3717884-1-lgs201920130244@gmail.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index cb875ddb6ba6..c685497cd470 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -81,7 +81,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 		kexec_dprintk("Error when adding key");
 	}
 
-	key_ref_put(keyring_ref);
 	return r;
 }
 
@@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	struct dm_crypt_key *key;
 	size_t keys_header_size;
 	key_ref_t keyring_ref;
+	int ret = 0;
 	u64 addr;
 
 	/* find the target keyring (which must be writable) */
@@ -118,7 +118,8 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
 	if (key_count > KEY_NUM_MAX) {
 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	kexec_dprintk("There are %u keys\n", key_count);
@@ -126,8 +127,10 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	keys_header_size = get_keys_header_size(key_count);
 	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	if (!keys_header) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
 
@@ -137,7 +140,9 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 		add_key_to_keyring(key, keyring_ref);
 	}
 
-	return 0;
+out:
+	key_ref_put(keyring_ref);
+	return ret;
 }
 
 static int read_key_from_user_keyring(struct dm_crypt_key *dm_key)
-- 
2.55.0


