Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEF2C3DA59
	for <kexec@archiver.kernel.org>; Fri, 19 Jul 2024 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=edZ4Y7nyTgXiopy2cLk95rGO21dJql6C4Wvn8r8Zo2M=; b=zDXLYmGtajEdkp
	cK+t6xPFvP8wzJVNvWzz7qJccU91MokJ7XI1pWKLr753ARr9Tyjsk6sLpOupvfm8OWwimLA2v4oDU
	fuV3DYechxVBVMgg/MfTRj8tHgNDIhwAXvEB0iR9TILh0lnZMur9Ss5odjWbMmSa3qcVv1NJ0ppGp
	vJsKpOZpQetQBlBXCHkUZG2eklMOJcIpd9bFgk31rRKDfi6wqU607uzFD9S59Teo7gY7WV31w6N+Q
	j1NX5boW4ClrYBdcmgPxt42UQYTrQA91eqMGEbwEmJZQonNnem5p/oIxkvtF4+sU2nNEnzVbds2f4
	41Myh8854vwAHB4YhqPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUl1o-00000002PxE-0uiw;
	Fri, 19 Jul 2024 10:39:56 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUl1k-00000002PwJ-3UwC
	for kexec@lists.infradead.org;
	Fri, 19 Jul 2024 10:39:54 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2eee083c044so20904411fa.3
        for <kexec@lists.infradead.org>; Fri, 19 Jul 2024 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721385590; x=1721990390; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igSaV7XZ3Cr6vZxP+aTe+2LlltaNI5nN7ttSrnUQLKQ=;
        b=U7iyb7qJtoMsX82G3Q3KNokOGCkPoDiN1q6fn9ysjCeIDImG/Gh+FnTV3EXDVLHN7q
         wYJebeRNck2RI9y7PcVXENYyN35TfLLrG1kaDhHwZxVkJcGYHp5g6AVyAnk2HT/Aext3
         1i3AtwLTlZI1F/4kY8W72oYs+rBMG9EpjX3YkQEwz26D05Xli8aHEVAT26DTjrfEGfdg
         EnOp97GdCVi0Xy8xSnTXQb9vGpD/hjdGhiTd6TK4D0YH3j7nWZKq+FtoNyDDWSmzr1z9
         wC5jZ4G8WwMPuodLWK40MSmmZw/BLYhRK1GScQDoUI7OfMCE6wWpWAFlASeZQurRX7Q9
         BFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721385590; x=1721990390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igSaV7XZ3Cr6vZxP+aTe+2LlltaNI5nN7ttSrnUQLKQ=;
        b=GbXEmEEWZY2RFZzczFEwWhpJwbJ1pFJHTO0CLayDYPEqkNzyGz8c+HnGKqNQJ3elXf
         SRrlrQvgXZObwmhFpxuOmWV7cwv5JmyXNpSn5DCRXxPobWZQ6Ri9a52GIUlugQNNV8EU
         XrDZoFMN4R2gp5d7lLqun4nNeGqGzkptJAyo74K6Q/Q5JSiGr1IM0qKNGb0fYtRXFO7I
         CQh4T2duq0wgLeK/jMM0yrrn0sQeAnC5tqnyZ+jrW9naHnyFDOLP1IUaDdL5mtgxTiZb
         W5aqFckMEXAYuqut6arWf78y0tNK2GlvOaNKQOsAsi9A8tC5RDzd7fRRKIpbAofEmNJF
         xCIw==
X-Gm-Message-State: AOJu0YzrAYvFW5WXsRXrU1yunXYrnJ2q2/4kiZrlEc+CGozOWbBuEEtc
	oesfoJruPKpHXZuuiZuxupyYdZewv34lX4FYhj0xayRh/5IlPWjcEMuZ9bsf
X-Google-Smtp-Source: AGHT+IGDMZz5Ed0SYJ86pWbecobgjSLO1BwlQZsL9m550SurHJlk/eyq8D+wFwn/pahNaIpsuWzXZg==
X-Received: by 2002:a2e:6a18:0:b0:2eb:f31e:9e7b with SMTP id 38308e7fff4ca-2ef05c78c4amr33331211fa.14.1721385589731;
        Fri, 19 Jul 2024 03:39:49 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa247dsm969213a12.22.2024.07.19.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:39:49 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in kexec_trylock()
Date: Fri, 19 Jul 2024 12:38:52 +0200
Message-ID: <20240719103937.53742-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_033952_890237_AE7996F0 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Use atomic_try_cmpxchg_acquire(*ptr, &old, new) instead of
atomic_cmpxchg_acquire(*ptr, old, new) == old in kexec_trylock().
x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
---
 kernel/kexec_internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 2595defe8c0d..d35d9792402d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -23,7 +23,8 @@ int kimage_is_destination_range(struct kimage *image,
 extern atomic_t __kexec_lock;
 static inline bool kexec_trylock(void)
 {
-	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
+	int old = 0;
+	return atomic_try_cmpxchg_acquire(&__kexec_lock, &old, 1);
 }
 static inline void kexec_unlock(void)
 {
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
