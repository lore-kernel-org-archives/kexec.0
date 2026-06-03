Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D5FCD6E6F
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfziVgpqRfO53l/kiKYNLloUUY6f9C5CrjqJQDvl8iE=; b=1FNiIxLlE1XaTHhM+fm2x611QT
	WGzFF31b2303r6jrxT3Y9gaKALXkJcQYfj7aWS7IQCVKn1FQbkK0HMtrFMr9yLzm4udGFf4inFBqF
	DxfUKkXD78XIhXRqQioOkP94kq/ArUxRsSslojxtC6m0JfnMhLBbdEfYJeAkT+oNPJE9du9NpFN2P
	2yGQdVQQyM0PBVV0EELfwlXIPrrUpPgJwVDINIFN9bzBZYW0dc7PQECtGv0nGILO/32VCDsKtIHk3
	SmUKFFux8smAU/JXfZ2ZOuJwFrLT1SGH1xsCyjdWoFcBdNDjpeZu9rJAW0rEd2ISrdlX4v7CEkdDC
	X/3ai8fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIB-0000000EAyy-1ms7;
	Wed, 03 Jun 2026 03:29:19 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI8-0000000EAwA-2ngW
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:17 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-51758478240so14359951cf.2
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457356; x=1781062156; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfziVgpqRfO53l/kiKYNLloUUY6f9C5CrjqJQDvl8iE=;
        b=QEOadZBzXdVSTacBRwLgSBrTV3239SfJ4gxLmX/o3d7lEetlfsOXlCeIEK5QYGIs5u
         nVUF64WTTu9M74z8MX33uAD9onxSeIXkXV6sIGUsdMyNq4wEJDx/A32ydPZLFETJIggJ
         6eCfyNhd8edE/m/45e4tA2AwLfA3esHPToBkB/2NXxXipnHklbNsHyEhbldSythBbZt9
         rNq1/CNqpL1lJ3oHCm22P4kJB+iv9vAAoqTHF+nu9x7HQQdQzl9xnCAhWFHQz/aAyAWN
         Rv/AvQvid3RRTl2/CuMdWJajSvoBu5JVjIf7mqETcQ1cIA9HPPj/sDdLe2b0mCW4dDOr
         Vskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457356; x=1781062156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QfziVgpqRfO53l/kiKYNLloUUY6f9C5CrjqJQDvl8iE=;
        b=ZTerTRYZd1Y5M1IXxvpwq0xANanHdjRZlocYBuv8L9gPquhYGsg7v7ndxSBJXoUBnm
         Il5paEBdx7kugL2EvyJlKiiJlnYrTsNHmhvei7zOZ0VIFs61Faeovxrt2B6Rx5kXCD4f
         9aQwpHV0DrCkyr4xG9mfX/j8d479JnLaKYlo9GV2FYI1QQENzUPA4KoAEaXfcXP+TOtX
         mVHxJDPpolgPB54MG2F4iIaCeTrUeLd7rUZkI5ntZj8BnPyvFMTCiDRlI9DlSP6f+1o5
         IaN153dKIa4/JTqNqMU0CvVkMz4IhPTgL+NXO0ervU6D8oDSRJHIckR97oz7MOrvq23c
         AeBg==
X-Forwarded-Encrypted: i=1; AFNElJ9O5AHEKYPzJiaa1pnnZrtpnzB+Ox9v6LzTjdpJrM6uVWHJjuyh4LC5jj3uOzL2pbvqrydEtQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJQlSBWZvtOcXNOD+D1/daZE+LEBQ9tvIeBOefrPJ3sIdRVw/m
	VsxDZQmY8yFu5BgfmORnDOJiSRxf2lSwTRhyStg4atEA+yBK98goqQP8g2MwT+3krm0=
X-Gm-Gg: Acq92OFaFt0CfddSz1BjA9ABPMalcsS6Xaq4xm3NndPygrYV/X0SGyn8M/02Bp8ktbs
	JXHuNFXIOd93uAn5E251hEzst3ZgOX9Hz4djOYDQwAmKA335ec7YnOaFGaAUhEO0O5jx+E8yt1/
	cFVxcTC9uBIk9TIcFoVsLEJkXNr8RTtgy97T0J9nBbh6+zK4faVqyndiCBoEncGeKd6RyiP+M2+
	f7soR7k5Majj+E3uG9UdkcQmgm165ezrD0j5At4DNf5Mrf+aCC65SgkaYlUhKvLqvb8z4pAAUQ1
	I9ekOoOvAVDzEKb0HVVdMWt95dlevjiS0tX/B2ipCIqXH/TawkoEYEqMMY8/rr07RGR0UC9L0Kx
	vAAUo+00eSO29m8kKM2ejW6A8KHmy00AgXsBPeVnAKPtS4yPUasRg2F31A80avjLGnJuw88OCnD
	hJ+p32E0taIyQR/iGJ4miTTSpNPXUoQoBMUWKuduIfVyQ7u2IQE1r0fT9MuY6nIA==
X-Received: by 2002:a05:622a:1c19:b0:516:cfb9:2856 with SMTP id d75a77b69052e-51778683f95mr26668491cf.31.1780457355655;
        Tue, 02 Jun 2026 20:29:15 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:15 -0700 (PDT)
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
Subject: [PATCH v6 06/13] liveupdate: Extract luo_session_deserialize_one helper
Date: Wed,  3 Jun 2026 03:28:57 +0000
Message-ID: <20260603032905.344462-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202916_722853_AFE435FD 
X-CRM114-Status: GOOD (  13.06  )
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
index 85782c6f3d6c..1cd315e0f6de 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -555,6 +555,40 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
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
@@ -586,34 +620,9 @@ int luo_session_deserialize(void)
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


