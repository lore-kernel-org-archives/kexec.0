Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CABF588DC
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2+fqkbJq3L5Dr2igTq44CcXT0ZR7odi5lkKx2bdprE=; b=4VaxpcU9wg9V9XojFX+XjJZlBP
	VZG3OsWRPaRje12EqNXJzjSRDd3VtGNUqjHGV78qaFgH8Ug58lKg57NF4oHvaA3N3newGWVgXVzda
	GZScbrWprQcPId1vTJ+KmQYiz7sDr66Er4iP0UsCCe88srcijCTaQwnWgJd+po5goUlyrFzuZ6+A4
	ejXCSTYlNO+Al3SgWzP+wAoRYHo+QkGI6C9jMOod7XlwEkAf0oRsw6X+gC0Pi+7ljmI6n/czT9Dxh
	wuHeRtRl7IAYcsuqt8DuFE+Arq8nGut+LgLhHSMAJ5HlzjbmWEEG3rwJoi/99Li7Wft7JXbSAm7bu
	bOq3s77Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRg-000000079sW-2jfE;
	Mon, 20 Apr 2026 14:17:52 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRd-000000079qL-41CH
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:17:51 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso2821316f8f.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694668; x=1777299468; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2+fqkbJq3L5Dr2igTq44CcXT0ZR7odi5lkKx2bdprE=;
        b=hyW+BaJx+hGAK2e5LFbrNAGe1fqWMikQZYia9id2qh0dQ5WLAiStVUCnscKpOaife5
         T7XFPtl61G9WHPt3hehgIcIFgn0LyEpPSj+EF9uPt3xN3xnHicqwCmHbKE372qKkx9MF
         RexSup8N6A2a/6EVlWVDvrdjLhsbVQCeqGtx1pwK06+XwRsB5+yFmYhwX3oNnaVSe+7Y
         sWloNkMQgT5InBLv+r6o5PskXxbSVnUuyxTGSD8OkuxuvInoxAIMnk5sBuOOe3dU7L4V
         Nvxv38hRWe4yD+npeFxLH0koncIzpKVDNPI0fKGIZEatv9ZTq+pkJgoE54wcShJCIKw6
         KGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694668; x=1777299468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2+fqkbJq3L5Dr2igTq44CcXT0ZR7odi5lkKx2bdprE=;
        b=NzZd1bcdwnrZ/y/WNYVMbSu8YzGXAf6OPqhNa630l01J6zSo46Swm1miJSBf52eDIO
         Ef5tZZiB0e+eMBdYodGZVS0sjyzaz/d5xh7BpO/1rdVHKvBWYfqaCVWVbELlnOkgUqOw
         HChbs7aUCg1rvfTehQGNr8CfGLLfVfYL/TGOt8zLFX+MdDCd35R26A/EQDqK4WxWrfT7
         SvI977v7xQrMX3hZwuI/EhoYsm0Am62mssBS0svoqLIahXJlyJk1EeHCbru/CGSrBytg
         iZi1FM8TUn/WYwfG70bKxaciVsnGgBedAmr+OLvmYTemTJwMCdOvLTuRVr+BcdKZZqnf
         tadg==
X-Gm-Message-State: AOJu0Ywr7unXpfxx+gYbSALtx9HjO6eYItkG2JaxvKmmdK+R2IREe4W+
	nxGBFixUUTBV5CZcDGsW5zPjkYw4a4YbW64JBp9EViAAhJzIs2oLEUE5Z541dg==
X-Gm-Gg: AeBDievI5fVjMkJCwm0WdtgwHzfLu3qhEBAl5cYNWiIlfSYQSu9o8nJ3NWCVWaXUmXd
	HONwcpsxCOgr9Iohj982FsalndjAiuMK8HTH0m6LfNoOjkXbmMKSaBvGwLtPaBpM8f9bykUXd2z
	zVbiDz6UbASn63Y4wwG49DkN209gITDltIt/2GNHdvdhTpOAzzJasZIBdmUZfBYi8nSAuU5uAma
	SuUNFRu0PT9iW5l9lRtOLvjFjFsoAanY2AKN+B7hji0zrxdHNMhsBV4gemkhRNsQSTMvECPdnH6
	0xOE15553QJnseo6tfF1NIwym+YBQUcBDHSD4wYGegfmA87DiTNDkdlHyniGjsJkVtf+YTEUZqu
	cv4MUF4fEVBrex5gAgLbW4aJlpECtf3cKiqSIdUz+QjPNiGQ0f54rAXeqHj3ugqRtcm+9+zdJF7
	pTmCVoDglM84EB9XkCUmw6s320TeCa38Fcah9EP28=
X-Received: by 2002:a05:6000:186c:b0:43e:a703:3665 with SMTP id ffacd0b85a97d-43fe3e0c6femr21089126f8f.25.1776694667476;
        Mon, 20 Apr 2026 07:17:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4cc375dsm26832847f8f.14.2026.04.20.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:17:46 -0700 (PDT)
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
Subject: [PATCH v9 2/6] selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Date: Mon, 20 Apr 2026 15:15:10 +0100
Message-ID: <20260420141741.2688371-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420141741.2688371-1-luca.boccassi@gmail.com>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071750_017517_B71335BB 
X-CRM114-Status: UNSURE (   9.72  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

Verify that LIVEUPDATE_IOCTL_CREATE_SESSION ioctl which provide a name
that is an empty string or too long are not allowed.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c2878e3d5ef9..f0a8e600c154 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -345,4 +345,46 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Create Session with No Null Termination
+ *
+ * Verifies that filling the entire 64-byte name field with non-null characters
+ * (no '\0' terminator) is rejected by the kernel with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_no_null_termination)
+{
+	struct liveupdate_ioctl_create_session args = {};
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	/* Fill entire name field with 'X', no null terminator */
+	args.size = sizeof(args);
+	memset(args.name, 'X', sizeof(args.name));
+
+	EXPECT_LT(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test Case: Create Session with Empty Name
+ *
+ * Verifies that creating a session with an empty string name fails
+ * with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_empty_name)
+{
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "");
+	EXPECT_EQ(session_fd, -EINVAL);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


