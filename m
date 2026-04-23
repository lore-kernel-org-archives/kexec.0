Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE3AFDEE55
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3lDwu8Gbb329Ho7MTScUMWrS/rbRC2QHTMwbPQ3a3YM=; b=rntBqqs8/2ccGqiVqeub4O7A6S
	jNPN0XcaeaCr+RVJRij4Hy2S6udoy7tv8BGLMZuMU3sg0J4y4RKSTTMkc2tyxspWRNzxS0PWjrC7x
	GJMu3wi8Pm4vIhd4k+aEO5YnXpJr+7FxpZVP/CXqxL2U6v6HQmWH/U2tlpQ4p+CXsxFg02bmycgnI
	OStTKaaTqHo3rvAr/BIvzOg7gVIenIs0O4Xv9R8GAu+vNZ006W+Zs+PMud0Kyga8QxBotRIXSfrOW
	Pnr4FXV3Fwl3feFu9iATgwJJ1iARnAuTin5OUvcIyI8tdnNKiYQjbSuqlHmM6n1ii0qmO6QdaQHVl
	Dc20ec9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3nE-0000000CQDr-0Qe8;
	Thu, 23 Apr 2026 23:49:12 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n5-0000000CQ94-2Tmg
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:49:11 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so37230295e9.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988141; x=1777592941; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lDwu8Gbb329Ho7MTScUMWrS/rbRC2QHTMwbPQ3a3YM=;
        b=eElkng0q00U1EZNvJFF0ptqMkDInh+H2OmBFDA0tvCQuUBYorv0u8Gw1XOK1YpRRgQ
         KWuwSJXSjy7sW6TiA1wduWgNvd/bM6UYC31dRZ4UukePzBm4up/jXuAhyk665hWJsaXO
         US0OyMXo4KfYKZTs6gMNxv9PF1v3zt1lEcJrTToZVnDomWMLO3pAzkpUu2gX1v24si2W
         wfx7t4BrvQToOLrxLKxhVQq1dnam0uqmFiyz/sWBq+ZoVuM89fZ2QZS+rzNNwpIkQlHg
         +dsrafEH8W6SyQGuF2Um2mKpPibANFhMM0aYAiCtcsv6ttikdGOX13O5Cym9zy59Lhqn
         U0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988141; x=1777592941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lDwu8Gbb329Ho7MTScUMWrS/rbRC2QHTMwbPQ3a3YM=;
        b=RXTWFFUxGpbLIGbuN4nDs0iTxBoUbolWjrWRTze8W0UjBExzss1aAEMccSy4sNleJ6
         3bLt45mVoj/mQVE6grMH+8wRLWFH0EHGaSXpn4SlJYII0trSHKW9dAYrxvEnRqc8j3QZ
         fXcA5zBS8of3MARjHQ/WfKTU/suOc3odkPcTd3DYr7sTZIFjJyeAkOeq6XXKycltcw7+
         7x7Tq5wfN5IpXRlp7QqzJU9/KsNzUSLeG7TuMtM5nTKPz6843RAxdFYwxsjAt0tD1HFs
         XFghnwSH/+CqFj/2la3sYfa1uhOmUr223JQ8V58QogxYtICdO/D2P3hICW6BLrtsOMLQ
         H4Rg==
X-Gm-Message-State: AOJu0YyoAzySz1SDIt/70I9RgixBugRu+FAomkmDRU85tLu60XfyfL3P
	K+f3hzergHuPtwa7sAeohnU+zzrmJYJUpJwIrxT5Il6AFQB9dgTegQ8ki01Zxg==
X-Gm-Gg: AeBDieuuxu/X491Fc+gT0nHW3TozP5wJdp714lkVJjW6xNDJXS7qK4rR7fJLzThieno
	F04+wjXwjraDFBBWLriY2KILIb/WZLjQ+hd5bVA3/zda1Kpdo0oYrUNmruI1Tc2TxPxbieeV/Ah
	MY6AVXJrWjGbOcN0bkA3QLhj+GjF3PDt4ymGofee2WcZ1X9HewbU2fwsy7ZFpnTmRAqbAjutBWi
	W/NfVj7i+PwCZjSirz//vBhtFAUusG7JOCY661IC3HNxxmX1MUCuwsxlqifHUjcCNqwoNgswk6K
	pUvFsDK9KZmn0MKcXLesR66i1QBNSWdxzrnfiy7qAvV6mlaFURHiIZLcpMaf7xjFyYPUMj7zG1i
	wV9WyC0fyFz2VXB0KYzSmjdULzZGvzgMTrLcZOJM2jr3Gr9IhT1tDB7ZprzlxFW1JE6ZX2Zyb3n
	zthrUQ/2A3/2LhN1c/qY7m/ruXQEvdjmddwKrw02UpIUcRgRYrpA==
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id 5b1f17b1804b1-48a52d95604mr251358915e9.30.1776988141226;
        Thu, 23 Apr 2026 16:49:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e8d7:434e:1f34:2cb6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb75c695sm164971395e9.14.2026.04.23.16.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:49:00 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v10 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Fri, 24 Apr 2026 00:44:23 +0100
Message-ID: <20260423234753.3873095-5-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423234753.3873095-1-luca.boccassi@gmail.com>
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_164903_645829_5129B756 
X-CRM114-Status: GOOD (  11.81  )
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index f0a8e600c154..eda832125809 100644
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
@@ -387,4 +403,59 @@ TEST_F(liveupdate_device, create_session_empty_name)
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


