Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BB3CCFA13
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gtld5SUkIp01JJT6a8E7AwwCws3CqpUZMHCHkcwnTLU=; b=Iop41OaunutOuayjm/qxctjAHx
	6RbSEhhx/wDVHiSwNB1g1u/0vqotxJrajsc9b4MrIHh7s870QK3ktA5lJDkcfNlo9jFamsZMloEPU
	hPOVbNFhiv7cArKxImE61kZXjjPkhHg5saf4JDHGBCKTxvNkaDt//O6EWaZx7LW/n8TbZcOoFnIyG
	HWaXKviWzf/6qsPggf+pNst5y095hf9bJ8nHK5XqUy0x1L+7/YK6AIXvJTp+VbJM/RKZMMwCSiShg
	BKEFOUxZD+EnDJ7UBUaaRrrvIMtfdiJPn189ufpWABcC84pR7xdl1qfJKCb29ThDKjNRs86Z5iLOI
	Drj3g8Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMe-00000004EQ9-2yfm;
	Wed, 29 Apr 2026 21:22:36 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMb-00000004EMu-3bEb
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 21:22:34 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-441209fb77eso149253f8f.1
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497752; x=1778102552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtld5SUkIp01JJT6a8E7AwwCws3CqpUZMHCHkcwnTLU=;
        b=Fwbjki/yiVqQEmQFE5km6rjDQvWYjK8dHZsYzf3IcEtlNqff5P0qnevrNiTuADqJzS
         h0bs0k/mqMAmX5zBCzkEcJsYkcqHRY6lwsIMA1eRY/IzozdQZVG5X9ZARBoNJ/xdQhly
         c/MEUn5SjY+BWP1auEwsIpklr7t4pF0KR0IHm9VAKvSlKABm27TvGxETXLoc9lAqXr/F
         GD62NiDJ4jLyupIdVmpKX0hRu3sUgQ5a9qXOpJcnAInkMcOl/et1ZC37j72vZL507J8M
         3qWiByQs0hLpejBR7mAKBSATwQm6Tqve4GsmbI1cjcpKIus5NYvsx63wmvlZcgdC5SaD
         Z17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497752; x=1778102552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gtld5SUkIp01JJT6a8E7AwwCws3CqpUZMHCHkcwnTLU=;
        b=BGd8NcnAV/sw5r+nIh6kAVYVuPW0HxMjCverxPHadxTXMuLjOtRGkyc7OXSic3yuN0
         EjhrAfO9E3istdNxxpUyjAUPWmRWPljo2WU/RXvs40e2907ENi36kzLHtvp1fU+ZcMVS
         Sm2tBKPniXaMovh54rfUwTECTCl+ZxILjWpbBreCb9hd2+pQapl/87lRTQfMHbmR36ao
         MlezpG8dzqQHhlefFeYbV/4Xpaq2Kn3SoV/IyZ+B7C48mn2U63UIGxnOfHmYRZs+bmE7
         4C6wan8lhfCpy01kuKR59dEZIaPEPE1ML1zSETyspzVwSItPiU8BWIwJ3W8KMqJkjrKf
         O1qQ==
X-Gm-Message-State: AOJu0YxcN/UpU4epWb6XxUwg7LhgcBbW3c1t/+La7sjQKT700zqlla6d
	TX7/LoKcwdffRUOUBK00SpXst7R++aoNzbnxoZIZOuUNfLs1k5kcwC+cF84jBw==
X-Gm-Gg: AeBDieuiIkbeiA/6t+5mlmVQT7BIqu9bew6ZGBTkJ6dtO/diapFNnM8hgJhcUM5FsDy
	kJiVLb13HM4aJYzTw7iVIiUcr33RZkXY7xXeeKqJNP8k+OOX7PK9VyOMZp4jgYe3eITgLi1u9T3
	KpJg4FJUZmN0rNl2c7jGN6J1KySzBS3F3Cfe4MtFdRs3b4zSeQdwNsVJAEpfjiAnCzw4bOI6sSu
	sEJwVb45kBBzwU4F8kgOY6WSV6GH+cSAPoAeLUSNuQ34YDWcRZR5Fow1LyPkasluSnCg+0lSoFM
	TbiGdt0HNiKSKIbILCJJquMpy+8GebOQua5ZH4/+lplcAtDdLRgPoDKRYnGJTirzqVl16xS1ZVN
	TDKu8IaVlJJq7LuuO5c8jfcE9Nc8i8FNMA2hnRnVcAfDBqIweeiOvtp/6wauzJxubaL8KenEr/F
	lJ9ExTK3tLSmBC4zgLpVaMqpD3v7smCUrSAmIhhkE=
X-Received: by 2002:a05:6000:2892:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-447aab56f7cmr8979841f8f.17.1777497751434;
        Wed, 29 Apr 2026 14:22:31 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-447b76e5afesm7092080f8f.30.2026.04.29.14.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:30 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v11 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Wed, 29 Apr 2026 22:21:17 +0100
Message-ID: <20260429212221.814107-5-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_142233_913892_585B8FE4 
X-CRM114-Status: GOOD (  12.37  )
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

Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
as expected via new test cases in the existing liveupdate selftest.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 90268d86684f..c7d94b9181e1 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -102,6 +102,22 @@ static int create_session(int lu_fd, const char *name)
 	return args.fd;
 }
 
+/* Helper function to get a session name via ioctl. */
+static int get_session_name(int session_fd, char *name, size_t name_len)
+{
+	struct liveupdate_session_get_name args = {};
+
+	args.size = sizeof(args);
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_NAME, &args))
+		return -errno;
+
+	strncpy(name, (char *)args.name, name_len - 1);
+	name[name_len - 1] = '\0';
+
+	return 0;
+}
+
 /*
  * Test Case: Create Duplicate Session
  *
@@ -428,4 +444,59 @@ TEST_F(liveupdate_device, create_session_empty_name)
 	EXPECT_EQ(session_fd, -EINVAL);
 }
 
+/*
+ * Test Case: Get Session Name
+ *
+ * Verifies that the full session name can be retrieved from a session file
+ * descriptor via ioctl.
+ */
+TEST_F(liveupdate_device, get_session_name)
+{
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
+	const char *session_name = "get-name-test-session";
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, session_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
+	ASSERT_STREQ(name_buf, session_name);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
+/*
+ * Test Case: Get Session Name at Maximum Length
+ *
+ * Verifies that a session name using the full LIVEUPDATE_SESSION_NAME_LENGTH
+ * (minus the null terminator) can be correctly retrieved.
+ */
+TEST_F(liveupdate_device, get_session_name_max_length)
+{
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
+	char long_name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	int session_fd;
+
+	memset(long_name, 'A', sizeof(long_name) - 1);
+	long_name[sizeof(long_name) - 1] = '\0';
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, long_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
+	ASSERT_STREQ(name_buf, long_name);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


