Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C67F588E0
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNDqlHkLA3XwzqBTWyzDtldlB60yiBhHVXXXYk5oIQI=; b=cFS7F0tpWkgCSDMyE/F52R7bRW
	A4hm18/8HapYxh2/E8/SuvgBYkLIAvvAc+gsF6oGoRisjuET2VIfVBsCKYkXjh25QMlZIgfHelOug
	tJbgX99At24pcj3zlA0gbtwtj5t+5yqJqjwsLont8JPaDiWnvFvFZWpifP/So3cnyywSfYn2Jz6j4
	Sf4UZ7GIOd/VF66JNWUrhRwC1Y8+iZasvuuW425t/hezZ3EgTB4bx9Wyl6SOkhXiwmeUhv9bll+VV
	mVk7Hq2L1gcpcfvwUsxe7DH3EdvjDL5DxMnQw+9g2M5ELWB0IYBxHKZz8kGbCNNSt8FhI63IcHa2n
	hygeEBhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRu-00000007A1T-3uv5;
	Mon, 20 Apr 2026 14:18:06 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRr-000000079yi-2ldB
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:18:05 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso11630785e9.1
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694681; x=1777299481; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNDqlHkLA3XwzqBTWyzDtldlB60yiBhHVXXXYk5oIQI=;
        b=lJhHu9SKiEL3xyUqyMQw14fozU2qGzV+pUgZ4KN1FKASw1haSIhEPDKVzlphHJxZe7
         yCB82VkxMksaVtdU10ASHY3YQtClLsnjNY7y7Bt82twaTfx/csKqArakykeGHRuWYgJY
         hx2kd0XtkbrzndSVMwaGecZDas78o0mpfzqtqyoj2UxefmSUSOeUM4BOEddnvQJ70qzX
         O0cOVJsadw59UKCpBZFm0LfPm0bWW15llyELxZHJqKhzPFNXPXiiTtQ32n4xaNYu4XcD
         jkx5fumHEjT7o2ViapHVfrYb7D25E0JO3ID+gdEjRqGeVkz7MejdStt6Xz/LPuvDVbUi
         sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694681; x=1777299481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNDqlHkLA3XwzqBTWyzDtldlB60yiBhHVXXXYk5oIQI=;
        b=UiUQLLL76tnuR4c4G99TZQ42kmzVkJgip+DUlk4zkBXbhT32H77hFD+wAgpSGwaSva
         6A5OsMqNleLUBe/XrH1henoFKfW+epRZmu35oDbO/60GXN1c3c2S5Ox+THZc7zxvyz9X
         MKVPKSYZVT7+hSzJSviGxaPq3BsyGFfHc/s1paZMszndQnnAXhlPXkNdxMluVumsx6MQ
         ZtkjCs8Y84BixLPjQHS+TzdqJBOtfv50Dx8z4HMFzKCqDIlT0XA8V6Yr3D8edS7zWBKQ
         5+peBd8MaacdifzlcoW+IEDwebpyxP12o5y5I680FCQiCIxyG0UgX6/+Rc3kxr+rj/eS
         DVZQ==
X-Gm-Message-State: AOJu0YzyVA85XvOQ8Ol+eGUTRu4lrs3FBv6pOExN0uwU0IYp4VCTC1fn
	UEmrcIBwVkowVTtaWtVwN8ESSsjFiPZoxPXhlBGT3UxZg2rjctl63q79xzBmFQ==
X-Gm-Gg: AeBDieuyaE+F2+t4V4lje9ysrps36nrbf+ai/gNdCX0XbbfUcYfEsTtd5KVfbLV2cmC
	1MYCxvzv7WSskFmI+VypbKumJ5rCiVcaCuKdrHuGNs9Tc7v83Zr28He8eTPtm0HO2zqAzkwExjP
	SY9ZXF7rLEK8d0jB/zaZbq+QVyFr2yE/bAZ7qiYQuGkQUG5lcrbIuNHybtRLyrBVp35F9HCsyrI
	B2Kyeezm7a6zxjmrV+38362NxE4+lUdDeCYdJCfmdQ+qbWfXT/q3s9HNInFWMXYeZghG/x38qUX
	8fXybePwxvcVaqNv2FF0wx0L8oT4+Eujdce7hvCXlvNIYVFzeVV78WLo+68+u8r2XkIIF5DyC1I
	YFEPaWDj+8usYPvXnv0Or1s7IRz5iD+4HrGcPO5gSQDlhsjz7pyG30n6OrewPF/zT64EBkeTKku
	Ih6TZWIqbDIit+8PtZDWRwbLFOq8QEOTpFifif2ME=
X-Received: by 2002:a05:600d:8447:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-4891ff5efe1mr30879445e9.6.1776694681215;
        Mon, 20 Apr 2026 07:18:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a52d232afsm6942375e9.31.2026.04.20.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:18:00 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v9 5/6] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Mon, 20 Apr 2026 15:15:13 +0100
Message-ID: <20260420141741.2688371-6-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420141741.2688371-1-luca.boccassi@gmail.com>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071803_717193_09431A37 
X-CRM114-Status: GOOD (  17.15  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

Userspace when requesting a session via the ioctl specifies a name and
gets a FD, but then there is no ioctl to go back the other way and get
the name given a LUO session FD. This is problematic especially when
there is a userspace orchestrator that wants to check what FDs it is
handling for clients without having to do manual string scraping of
procfs, or without procfs at all.

Add a ioctl to simply get the name from an FD.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/liveupdate.h | 21 +++++++++++++++++++++
 kernel/liveupdate/luo_session.c | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 30bc66ee9436..3a9ff53b02e0 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -59,6 +59,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
+	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
 };
 
 /**
@@ -213,4 +214,24 @@ struct liveupdate_session_finish {
 #define LIVEUPDATE_SESSION_FINISH					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
 
+/**
+ * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
+ * @size:  Input; sizeof(struct liveupdate_session_get_name)
+ * @reserved: Input; Must be zero. Reserved for future use.
+ * @name:  Output; A null-terminated string with the full session name.
+ *
+ * Retrieves the full name of the session associated with this file descriptor.
+ * This is useful because the kernel may truncate the name shown in /proc.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_session_get_name {
+	__u32		size;
+	__u32		reserved;
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_SESSION_GET_NAME					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 9e343b6ce513..885e1f346caa 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -292,10 +292,21 @@ static int luo_session_finish(struct luo_session *session,
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
+static int luo_session_get_name(struct luo_session *session,
+				struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_get_name *argp = ucmd->cmd;
+
+	strscpy((char *)argp->name, session->name, sizeof(argp->name));
+
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
+}
+
 union ucmd_buffer {
 	struct liveupdate_session_finish finish;
 	struct liveupdate_session_preserve_fd preserve;
 	struct liveupdate_session_retrieve_fd retrieve;
+	struct liveupdate_session_get_name get_name;
 };
 
 struct luo_ioctl_op {
@@ -322,6 +333,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_preserve_fd, token),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
 		 struct liveupdate_session_retrieve_fd, token),
+	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
+		 struct liveupdate_session_get_name, name),
 };
 
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
-- 
2.47.3


