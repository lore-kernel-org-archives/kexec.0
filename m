Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF9CD6E4E
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpCsC6C+qH6VW/iV99P+6fjIK3KTX0m1gB7hOlYbVxk=; b=Z6RnZsWY28/wCHXEyhTmuQ6Kly
	lr9SuDeAQwNBI7bVMDgLxOwakyMuRYvno7MPIun8NmbkGrO+Gdz4BNxMrWZPw0hQL8Bs4MVJ8Cdd7
	7Rcc3DL224Q69RQXKBezaXBg8cdbQWjJ2wpqPDJPhwXg45xI5G9xdY/LXVtr7DXyaG4566uEPRjkH
	Z3hLtsDefbmuM0mWrSnGmi8LGij0NZsU8XgeJ83wl+WmzWEH2LiLRHpbTeQSNTjGz+Z2A+/RAmYSv
	0RpbCNfyvpIsnyaI40ww0g5V9Axa5iMxh698d9nhaprjJC2AjZT21regGNxvvewwJ39eWlf9CFoMb
	Vi0mj96Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmi-00000006gVP-3UF2;
	Fri, 29 May 2026 03:21:20 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmc-00000006gR2-1Xjx
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:15 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-5148cbdea08so111437511cf.2
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024873; x=1780629673; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpCsC6C+qH6VW/iV99P+6fjIK3KTX0m1gB7hOlYbVxk=;
        b=abDWsCY74hT9d3U7oVMIOTI0mEib/Wd/jvA7Fnk2zyN+Og8z2eaKsA0S2yMM3oZuYI
         xg3gxIi+IC2bASUxSn2qU9af30cjbghq6s0VwscJ9j49DtgbXhIGNBu2UKlpJSiMAwBf
         NJHR1z/stsvETATIJCXwTXwVFnItrC3ufxVa5uGJciyULruvh44NenEy80+lSRVO5BBE
         DDNqsevBHUx34G4SoqeOfict/m3MD+AQY7xwPmxVFAJk5gaErPP+nUt/5M9/MCXgTUQd
         dEwlfb99CAvW1S+sYS2iz2WiQ+KAg4PpRJ29i4Iv6LEHRP9ObngNEJ3vq4bvQW9IakSI
         8MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024873; x=1780629673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NpCsC6C+qH6VW/iV99P+6fjIK3KTX0m1gB7hOlYbVxk=;
        b=T8yMbHGrtbymxuwKRN+fh+Hv1PHc5fRNQFdW3IPbMVt3q1uAmb2h3sN/j76NsBsWVW
         p5LFMLbL/SBHhyjT68wlZ3ptARwIsiFEuRgWXU5Giq4igy3AAE/Nlr4G86yXdqps5Whq
         ebv8vaBZlZ2GVEyjJR/8yqzr31yxCWhPRv6EmbcX64RZNfF+zahhGy28zo/LaL7YzoQr
         HfFw1S/giqXdJBGBnm0GUAKXzwt0c8aQRj4izFdF3hPGtG+SQdzLldhPlrREi671DRiq
         l2cxwPbP/tc0vVyp6kulVRrHUtKzeZPyTa/QZVjee2pT2TH8/hw+5GUIGB0wkKDMcMBz
         FPyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mGmM+D40sCEz0twg2233xNOGryh/hF1XmyRUxMTsT9QuPSXaGcVmugqDMFJSK4yQS/Q4l9w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwyCfXC+VGJw5x3EEYKU//LCqxyQ3tZZbhAjzbQ7spOUfQPZZ8A
	ONdcjDLfYaFEzVZ77MtBsfcpJOfId5nrxS/AEfvmdZFadt5OXsiisI3zHzgcziL7PLA=
X-Gm-Gg: Acq92OH+YRRaVUfmj+FESVn5X5GVt7pbM8WAjCMyb2e+qTSThQalDaYM+uWfNb6J2z9
	GzPwPlL82cyCX8AGZPZ697g80d7xW3TJv4/bK0PM4GA5VLG6IsS75Fgd5Q1zurcJbMrVMUP/RHl
	7Du6mme1+QWRYXLnwDBBmSuf2OVopmIjcw5l85TqJEgELjePnBRPHOzp3REa1nLsn0T5w/dLlGI
	rTpQ/p7l1bHDakWvFyzAf4Px0KEj2VKQ7QjFa2hmmr62D0j37yHBxWynCE0lASAcblN7OkF2EyH
	S2hb9yLWVONbgGf4qPhx0TxIpFMoldNd9QsG7KbyRsZskZNJjhqBRIsiQoWEC3shpgf1vE/BLBu
	Q6uhsc/ToxBx88mtOg780AilEEPiLeLIqLFkAMDBWI4mSqRpfGg3epGy3lHQNI2185LRxGRgx42
	hfq41zOnxRMMDi4Fkc4cFZQ9V+nAixJPcPrsBn7OzESIllaVTeN9UX0ZOrjZVFeA==
X-Received: by 2002:a05:622a:4c1b:b0:516:d955:ea2 with SMTP id d75a77b69052e-5172daa1350mr16395121cf.0.1780024873082;
        Thu, 28 May 2026 20:21:13 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:12 -0700 (PDT)
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
Subject: [PATCH v3 04/11] liveupdate: Extract luo_session_deserialize_one helper
Date: Fri, 29 May 2026 03:20:59 +0000
Message-ID: <20260529032106.1505796-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
References: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202114_422276_1E73F229 
X-CRM114-Status: GOOD (  13.11  )
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
 kernel/liveupdate/luo_session.c | 62 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 1cad54ea8209..5c092c71797e 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -526,6 +526,40 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
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
@@ -556,33 +590,9 @@ int luo_session_deserialize(void)
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
-			return PTR_ERR(session);
-		}
-
-		err = luo_session_insert(sh, session);
-		if (err) {
-			pr_warn("Failed to insert session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			luo_session_free(session);
-			return err;
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
 			return err;
-		}
 	}
 
 	kho_restore_free(sh->header_ser);
-- 
2.53.0


