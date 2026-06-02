Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236E8CD6E65
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=flqTP+T3G7cekhEWLkwDVj+JxO0X/Tc2hrAvIJPKbfc=; b=FRTKkYBo+HxSJOIbzTGgjOiP70
	jkzmsAbjyD4r9SH2gvbYn8RNfU2Qr44NjFTpj2G4BXlNbe+UOT+aoajgHZ0F+wQ9u6snvIoIuljIx
	0a0zMwtXjOV3Ky5345Pl9Ul7AdrPtxktvEyhSdILWNKc0laEHs2A1XhLzypFftic0Jng18M0USsqD
	EFGc2iyFqt7s/fnHxVNISmagff7vCfeXspDFcdGVgiTUWOx0hMmFIZFNVsveBPW6UnLyA1T8wA8kH
	1HuvKbt/doudImXO+f7TxizNz5s2F3n0m/aKAaxs7UOktvq9F4UW5ebp8IVIuTm5cu++GAcpG8v5F
	u6aSaGAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdG-0000000CDIf-20qC;
	Tue, 02 Jun 2026 03:17:34 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdA-0000000CDDN-28Mx
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:31 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-5174a0beffcso24149411cf.1
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370247; x=1780975047; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flqTP+T3G7cekhEWLkwDVj+JxO0X/Tc2hrAvIJPKbfc=;
        b=hUywLqIP9utLGx91eJSoReLRHqXMovexSD+xcWIDZosNklMrZ4KC5vfB4yhTyYsCrs
         sCGTSdFc0JxYo7AGY7Hkqnna4QIRdYU8293sa31WCGFBRKw+5sQzghmvQlWcwAhnpdZO
         90LAxufOa0e8H0+UJRdZa3QEgVdMnAWuQmU7X5nkfUwVxDjVokcl89e0lu19S4aMpOn2
         ZpbNLBdTksEiiwIWu6dLuERKfWYaGREb4uH4OY6u9FMx8sDIsGIFjKvDMbkH5YWWXbU8
         dUksUuuRfBHWCk1HqVVvB2IIhZTdjDG2ICYJ2zObw2Jqt6TimXwYNWuNYEAufkQ5T0ME
         VC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370247; x=1780975047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=flqTP+T3G7cekhEWLkwDVj+JxO0X/Tc2hrAvIJPKbfc=;
        b=Qif0F0dpdwe0zjsFaFU4n2mxbI+G3m6IuaeWwC/M2g4sdkHb13Vm/pOzRGDN71j05D
         qNbCF4ohLk5p8bjiYDBbOS9lk7mrC3q9djGqUYZ/OG52iGb6bnBUXcQ6k+M//KRfasU5
         4TCLiCLCzQ2oes1o0WP9q0cK26NsNz7/1/sCfFXM1hEcqL8HOeBn7WKfgh6LhJFNeuPW
         s6f10L2stv5BsoUzG+Ty6v9WdtwFO3Q7kESsWxOuTCfr2Cb7+5lBbpNegfub7Pma/Yic
         DMPTX4kJwC26YvNNJhggyQw4k912Fv9CQ/5VIef8oYE0nwx+Dze0hfFqy287Vb+VTIIv
         69wA==
X-Forwarded-Encrypted: i=1; AFNElJ+mCJGS0yz7jrZEhi2rvJzlY4i+sS7okzbkKtY6Hr6+NW42HNvnxbpBXkFxeJ7NhEFgBNVVKA==@lists.infradead.org
X-Gm-Message-State: AOJu0YydmPp6LRb4VApHbD5EP7vbWG2RrqX2qnOR0GF2PL0lOWhkBNxp
	WwBkjDnQY+OJpdXfpq3uJ7YnEdmEYC6no71TumyJQEiT8FT4zZVMPcMe+CiNupDFaI8=
X-Gm-Gg: Acq92OFJB+9aLYz9bpy68CXL5EakNK3xC3yF+iIviBLvsjXN1SgYwyXCs8PB+MWz+LH
	EMZyIjQS6J6Ea/r1eNlCmEKFxug4sUWGspr8Yz8eCtxw116OVOVbevZnSprw6ddAdOSNAV00akC
	jNRnEzdWoNag2WbOf0OUOqKj3e6Gho42n1n7d/sCbYbpKZuLMi8H/oTczUN0GzDmeVzRZEClsyl
	uL8FHfimM3B2zsmP7vsF+pYg7h7fTizb1HuJHJnpoNRKBJXmmeiDGffR4kLrmZhYGK51Yw7+9vE
	jp1ANC0lEjs3OZaeV+tnyYHf2jZ1XszYjkb0cwwbiRK+sOJ98wzo7yI7+FaCQKFJYKKHekmXmks
	23yM5lIembC747S1QDhkeOqch+aijZ+qCa/UNUv7eIyhLqKCMU9pj1jT4ecGEJKpbngfM1Z3B7x
	M4ff3ccWW5WEQMYfG+tgG8+66qUIEt/zzID+8iCRSSh8ORZ/SsUxXOZZIlS65mrg==
X-Received: by 2002:a05:622a:251b:b0:50e:635b:5579 with SMTP id d75a77b69052e-5173a73ae37mr218885561cf.19.1780370247179;
        Mon, 01 Jun 2026 20:17:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v5 06/13] liveupdate: Extract luo_session_deserialize_one helper
Date: Tue,  2 Jun 2026 03:17:10 +0000
Message-ID: <20260602031717.197696-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201728_559869_01A9C411 
X-CRM114-Status: GOOD (  12.72  )
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

Extract the logic for deserializing single entries for sessions into
separate helper functions. In preparation to a linked-block
serialization for sessions.

This is a pure code movement, no other changes intended.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 63 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 3b255ffd1bf1..9f72a8b0a9a8 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -553,6 +553,40 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 	return 0;
 }
 
+static int luo_session_deserialize_one(struct luo_session_header *sh,
+				       struct luo_session_ser *ser)
+{
+	struct luo_session *session;
+	int err;
+
+	session = luo_session_alloc(ser->name);
+	if (IS_ERR(session)) {
+		pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
+			(int)sizeof(ser->name), ser->name, session);
+		return PTR_ERR(session);
+	}
+
+	err = luo_session_insert(sh, session);
+	if (err) {
+		pr_warn("Failed to insert session [%s] %pe\n",
+			session->name, ERR_PTR(err));
+		luo_session_free(session);
+		return err;
+	}
+
+	scoped_guard(mutex, &session->mutex) {
+		err = luo_file_deserialize(&session->file_set,
+					   &ser->file_set_ser);
+	}
+	if (err) {
+		pr_warn("Failed to deserialize files for session [%s] %pe\n",
+			session->name, ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+
 int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
@@ -584,34 +618,9 @@ int luo_session_deserialize(void)
 	 * reliably reset devices and reclaim memory.
 	 */
 	for (int i = 0; i < sh->header_ser->count; i++) {
-		struct luo_session *session;
-
-		session = luo_session_alloc(sh->ser[i].name);
-		if (IS_ERR(session)) {
-			pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
-				(int)sizeof(sh->ser[i].name),
-				sh->ser[i].name, session);
-			err = PTR_ERR(session);
-			goto save_err;
-		}
-
-		err = luo_session_insert(sh, session);
-		if (err) {
-			pr_warn("Failed to insert session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			luo_session_free(session);
-			goto save_err;
-		}
-
-		scoped_guard(mutex, &session->mutex) {
-			err = luo_file_deserialize(&session->file_set,
-						   &sh->ser[i].file_set_ser);
-		}
-		if (err) {
-			pr_warn("Failed to deserialize files for session [%s] %pe\n",
-				session->name, ERR_PTR(err));
+		err = luo_session_deserialize_one(sh, &sh->ser[i]);
+		if (err)
 			goto save_err;
-		}
 	}
 
 	kho_restore_free(sh->header_ser);
-- 
2.53.0


