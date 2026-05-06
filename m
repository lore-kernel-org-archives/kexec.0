Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A29CD343B
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeOlLbeySOVjo93lwLL44ciHnn2Ct1CFGUbHwbnHYfA=; b=HHimABpkEPL5u/bMWtaC0r5oEd
	BhLtKMcQCCJuUG1vPYo/UAWTPPIU7h+fUDvOuZzp/7W/zc93NhDsJH5tGbDTpOtMiSIrY2J/SSR8E
	XSSEFt+TlKrGRSY3h/lla0n6aRT7RozXyQ9dEHP2lKQfPVRZ+WA/9UeTtmYeo2Dw5kjiQEeFd0K0V
	4YtRLUtCyW8II12GFLiMB16plv8qTMKmmc399oL6ot8o7R7Ii1uYwrIEzor8EeVve7oGRE5awO5Jb
	BxF5yLvMemLOijxMW2a/uOFO0RiPfE4jjzY0NrOWmRUNkCUiFLyatReBH9AclhbwhWsOEbzXH4RLr
	m3xwIUgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrg-00000001lBk-0Ucg;
	Wed, 06 May 2026 18:20:56 +0000
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrf-00000001lAU-01pt
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 18:20:55 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-65c0bda7f15so7012786d50.0
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778091654; x=1778696454; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeOlLbeySOVjo93lwLL44ciHnn2Ct1CFGUbHwbnHYfA=;
        b=eEjkvajqB4tZ8QqBD7Lakgh5LySZH/4wI4hSqJ8zvpCpzE6biWFhoN2fZ8Qy6Abik9
         3K+ziEnXNLlBAQsOUSH27MXtgtvWaml8Y4NHTkud4tEtYx767HWdYZtImmHaDnwlMfMb
         QtMLKYrI7WeLbz8TUK8+YV3HgOzt573YpO4jJle9bZzvM+R6BJjXx/tkn3jiYHrj73Km
         Ml1k3b0h1aWPUTVMfmlbtPZEpkuaM0RCFlcOVcD1IuUjspFIZAOZYGmDncI4JGwmN6Vn
         3pOfm+pqOi0xa3ZAjQ86VfYWn+X8ciz3pl0c25/cFGy5ILmwDwSUVZyu9DQdnrsX3dWr
         Mpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091654; x=1778696454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeOlLbeySOVjo93lwLL44ciHnn2Ct1CFGUbHwbnHYfA=;
        b=M/LGTvl7fw5Tej5ORojDf5IZ3MQ+y6lUjeYDNMtB5EheA+WtxyOvffXmqmi8o7Xe44
         kPWOZ6Z4r00ihDdqe4ygXXRqZPn0UcysKvkwGAAWVyOCRTREpwMBLmRDOXXSRKpQP3AV
         6c60l+H1mhaGOcGgVLEd1obn4YuNZfx7a82S3JkJ97bXgQ4TkmdPHBCslMiceFfLp75n
         //AfbvCa6jYtRshp/+yT0GMa2YakxJ2scZ33He85lN8U1Z0krieNXnP/UjAXuwCy430a
         PMsoXuDyD3+5tpyNX3kLP/t+IJBryCp+5Un3PyEmO/b5goLpxCUJu66xw2KX4Pa7teV4
         SAsw==
X-Forwarded-Encrypted: i=1; AFNElJ9DFzixphSoH+MREdMl6g9KNTa0Z0VRmAW+VPYkU1YBKmfxeY81s4f1WRrc6ufvXvS+ofVDKA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3nEwyDnXf1DMwFMK78SihCWSaI75KnawwJRctb0aGTR6gLVtn
	BWT+CEDDppcDFaRSs7HAmUzpZsmU8GYNBrV/LKWMbUwVGbEe6GyC2/qExlmEqHoStnI=
X-Gm-Gg: AeBDiet3eHG/5NpqNsmJZhkmOO4y3FwcXRKPv76xYAOqEMYNOqIctBrk1kGSiAub0/P
	bg1QaxHgOvwVGeZw+0qz/2WsaeiRVqkk9SxAOHqd7tfR8MVaD5ONxsHkvM/v8chW6IR869VoLoM
	99jZ/jLpuAo8l/6VBnYXSXFDTfrF+mkQNIZ56hmXTmqNe2+1uoAYMDyXpkuym5I2tJn+eRg89f8
	sx6ZYQHpIh83hgrJA2QfKpQDYsP3ex/HC1a/PIju853cSOtj/vS0exidX0Ws3c81dlPwNDu8qr4
	L2x7ZR0zF01wE9rWy6MQGcH7cIHGuROkbVIr4v9gDHAHJW6yDbPcnNnbRpR/M/Nd80wiDnaUpoQ
	tisnqRuU0YLZ8XWITZC8gWD3p11GK3UAZqb/8sUj8UOfmT3cAGmecgqJhnJdeMgAl5BFzGxmjWg
	drk4Y2RkqqrTWMEyrBrt/NcMVucsE4nYFgDv7R5KGYmIwIySXMuzPdz/z5mIdfG4mv5duD4wiqh
	+2/nh9fP1u7q5CDssAkiJngZcLHthQVUnTbjDxN3HRa50WlzIYlZ36MY76BrKt8h18W6cU=
X-Received: by 2002:a05:690e:418d:b0:657:656d:5686 with SMTP id 956f58d0204a3-65c79875ecamr4910797d50.4.1778091654158;
        Wed, 06 May 2026 11:20:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7af9f8e7sm1389917d50.13.2026.05.06.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:20:53 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com,
	changyuanl@google.com,
	mario.limonciello@amd.com
Subject: [PATCH v2 3/3] liveupdate: block outgoing session mutations
Date: Wed,  6 May 2026 14:20:43 -0400
Message-ID: <20260506182039.2623553-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=9bYai8pKOAnNVwlD2anL3djes0qaooK823m/0bcYUZI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+4Z7J1f7PoQHuaJFFbbJWThp8lFFG84B/LMl7
 9tqkK87uKKJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafuGewAKCRC7dyhM23N6
 3u2JEACMQLgxhXLH2DdKJvtAaMwDkcMXd8y5qY4b6kqGDP9HGt5Ae/rRl+L+GRUL6wFCS+5gOQe
 OnusI0+diMcmjiZz5sFo7vBz/adytPClMKIvK2J1vb8PPy1dBuHrY0Z/Yx9mRrS1Ybztc2mIkwC
 VY4DcVknAahIhcU9pEG+HBT5oKMzP/9qf41PIcu2IR4+7xR7WAdFXO8V/wuVQ37h0BWKPgTqkU1
 MeJff9gJ8v1LT3CEtxKpJzHoQE1uxEGWV6bS0f2rsoKghbd6g5tpM/eIOh+c8NC88tIBAogisFN
 5Z3VUiiNsPJGjXGnKQhekZe+MesIqRlFMeGMV4YVdqVeF2T27QX+cimb1R9zA0TIGEw15TPfSFb
 FOmypPe7gZ/NmuSn/S6mtYqOrMAZx603SX4wAx2sYXug3n+Ts5EUaCOyv2KNCzlwslUbetOZDSd
 rOHMRwejCyGaHNxG2WjKPZ9XgnG7TjLGaj/Fr2Mxd5AUZljPADQnzdE5O9+QhzxuVZy5wdqGbVb
 zRN1VMGOUwTAYrb6t67Mof+TkqLcw8GZNBn5yCDzJroX4MSH7HO6Ura7LbyfUBFK71ijKqY7d/Z
 1P/ucoMBgY9W4+Qvs2edX/vhmMxOF6s0pdCyMxVWq2Slc4+9t41J6mSzP5B/K+7BrtLw1ctQKi7 PnPocLqD+gNpV8Q==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_112055_073567_70DCA105 
X-CRM114-Status: GOOD (  11.25  )
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

During the reboot() syscall, user processes may still be running
concurrently and attempting to mutate sessions (e.g., adding files or
closing sessions). To prevent this, hold the session header's rwsem and
each session's mutex indefinitely on successful serialization.

If serialization succeeds, these locks will never be released as the
system transitions to the new kernel, effectively blocking any
concurrent task attempting to modify or release a session. If
liveupdate_reboot() fails, the locks are released in the error path,
allowing normal operation to resume.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..12808c696def 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -189,14 +189,14 @@ static int luo_session_finish_one(struct luo_session *session)
 static void luo_session_unfreeze_one(struct luo_session *session,
 				     struct luo_session_ser *ser)
 {
-	guard(mutex)(&session->mutex);
+	lockdep_assert_held(&session->mutex);
 	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
 }
 
 static int luo_session_freeze_one(struct luo_session *session,
 				  struct luo_session_ser *ser)
 {
-	guard(mutex)(&session->mutex);
+	lockdep_assert_held(&session->mutex);
 	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
 }
 
@@ -583,7 +583,10 @@ int luo_session_serialize(void)
 	int i = 0;
 	int err;
 
-	guard(rwsem_write)(&sh->rwsem);
+	down_write(&sh->rwsem);
+	list_for_each_entry(session, &sh->list, list)
+		mutex_lock_nest_lock(&session->mutex, &sh->rwsem);
+
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -603,6 +606,9 @@ int luo_session_serialize(void)
 		luo_session_unfreeze_one(session, &sh->ser[i]);
 		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
+	list_for_each_entry(session, &sh->list, list)
+		mutex_unlock(&session->mutex);
+	up_write(&sh->rwsem);
 
 	return err;
 }
-- 
2.54.0.545.g6539524ca2-goog


