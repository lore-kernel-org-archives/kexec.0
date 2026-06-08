Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54BACD6E79
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zc7hciXDAJMejuhqEhFFQ+iAWZDaZQLuCctzxmyuzcM=; b=f+YVnn+mNJUBTPrs7pMKE5+LnH
	piyFo0MJVd6rqUtOCs6l/D8KrhSUnbKyTdPw8yK/ImV21GLSoKxku43XUbADyYIMTy09MxgAe8Vj1
	+51LarY+oe79TH8SF+eLU+7ePaOvXfFmTAzqfG0/OlxPuArQcktUM82a43EjUhgsRiMPuCN06RFeV
	UNVhpjkASCMNdlPvvd6QwhRae3cWJchd/OrxcpBVSgHVg2Dihvbf2/k4ykWAB2pZKUCqwvVONvckK
	avqdTp2RCDcdjeZHANLYnoqkCUQqMssGwOi+lzIf3AeVlIis/b8xiKE+hEllHKQ77qnaRtieN+8/z
	7cgjWcbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWewI-00000004HU9-3Z7S;
	Mon, 08 Jun 2026 18:43:10 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWewF-00000004HTb-2gFU
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 18:43:08 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-490ace40f13so21030865e9.3
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780944185; x=1781548985; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zc7hciXDAJMejuhqEhFFQ+iAWZDaZQLuCctzxmyuzcM=;
        b=OUSM+NmXeV0eLt/FgonGguXnXFgLzQFZVIP21K3UMSI3H5rRfelWfu0D5nKkilx58T
         LwJ+wU0xg3947tz/jKSH+lKo0EypblEa5f5AIN9Xc3WVBnDvw7VBUFrMBjE+XQchuhzh
         3+o1LQkcLYgsWQHJyK9pTwMRAwFiCOtuyS7AA2WKxGjAqWECSQnFJtj1TzneBgbIoClv
         zjoSPUdT652AsYsnuqnFcgXfsUsNZYmbyB05jXZv6ubRJllttvlwsp2/DaTWWX4g5FUe
         U3YR4MYYrXFU4OFWVYeqtoQ2CGjntc3bAwlLIiELeTIGG7QSiPJJpjuL31/tJpUU5MWg
         UbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944185; x=1781548985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zc7hciXDAJMejuhqEhFFQ+iAWZDaZQLuCctzxmyuzcM=;
        b=QxQeGyFL9fTsuxkhNF9LcLLKR63ZcRAB5DWmNbBdgcMoXmE5SDVyTCVoW6ghGvtNX5
         fbEk09LN5lyMZCTNsf1K9my9vcyAggs7ne+9xoJefbvzltHR/SM2GHvUDZybMcOEJwsB
         DBUMJ2CklVeRonw7dKXLWD8gvlaq1THXrbAwiVfac/ahKOfrHwAHfmWeQMLe/sTgykbD
         ilmwYIshpI0PBIbRS4d/lyS6rI+5cD6oBkaAkzhy0+a7Bpf8jjRVvx5CFaaM+/i/z3Uw
         S08HnHX6nQ8IKCWHaFoBBnHB0xqug/83bQt/ZgguEyO+0OdUMI1nlB4ekdWOyslL8nSF
         fiIA==
X-Forwarded-Encrypted: i=1; AFNElJ+0g9tLbYzpyU9+/lXjSsvQHbUaVjp4gxDwepwpAyXz05hXmNXvYscZIU0iI1sJ/rROxoBpSA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBLudWWbbxb49XKqEf7FLjmJovWDnCq59Z9RqySOVXk0Vo55gP
	A+70GAbVXLF7gS+QlHIe940ChT3K7hPLtirC7Z04iYtRLLUM4UYiWiHESpRU+2svIwh+X748vFr
	f9+ptDIPxIvgF67gp7A==
X-Received: from wmbg11.prod.google.com ([2002:a05:600c:a40b:b0:490:b22d:da02])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450a:b0:490:c2a2:b1d3 with SMTP id 5b1f17b1804b1-490c2a2b3c6mr250645405e9.34.1780944184869;
 Mon, 08 Jun 2026 11:43:04 -0700 (PDT)
Date: Mon,  8 Jun 2026 18:42:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <074445fc4964961f12171ea129f2a7690322a78a.1780944056.git.tarunsahu@google.com>
Subject: [PATCH] liveupdate: Document that retrieve failure is permanent
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	vipinsh@google.com, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_114307_687691_FCC59323 
X-CRM114-Status: UNSURE (   9.32  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/uapi/linux/liveupdate.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 30bc66ee9436..a564d2bd05c1 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -168,7 +168,8 @@ struct liveupdate_session_preserve_fd {
  * associated with the token and populates the @fd field with a new file
  * descriptor referencing the restored resource in the current (new) kernel.
  * This operation must be performed *before* signaling completion via
- * %LIVEUPDATE_IOCTL_FINISH.
+ * %LIVEUPDATE_IOCTL_FINISH. Once retrieve call is failed, retrieve status
+ * is saved. So it is permanent failure and retry is pointless.
  *
  * Return: 0 on success, negative error code on failure (e.g., invalid token).
  */

base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
prerequisite-patch-id: 30753743cdfab5c3c5355ecde725b6648f1b7a17
-- 
2.54.0.1099.g489fc7bff1-goog


