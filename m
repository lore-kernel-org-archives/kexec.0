Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85142606A333
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Uhoyxzxz;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ELkh//HW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=L1yhfvEqBP7e5XFUmbUnaIa/8XvUMLf0rUD2vnzu2NQ=; b=UhoyxzxzLQ+dCs
	29+peH4znbY1xUd40zFB6dD/B5QB+K04jdjcAVK8H/510p6gZpCGeVbwZKpWh4XLC1SUIajxboBYr
	zGs+XqNOIvcPYYzn+j/HC7QdW5S0hOScNm/kiOUJ0wMrYrYbWdO3OAGSsdsspDtaLHynI4hHGrumO
	1fnJfKrrSwPEa/XfLd68a040ZuA7BxmBFfv+LapxFYS1CpPb+Ern3nWp5P7oRpxKU2ro12EL36HY4
	0lBMPY0uv1G0DVi0kjsLAgSgI644Yjq4NvSRrNfH1nbRPuWunQveOpNauNPu33JGrL14P1Bkhg+zd
	d9n3k4sycMHVsaUcYmxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnDB-0000000AJhD-0nwH;
	Wed, 18 Nov 2026 21:29:01 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD6-0000000AJcs-3xKe
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:59 +0000
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-7d2db6408cfso973862137.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037335; x=1795642135; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L1yhfvEqBP7e5XFUmbUnaIa/8XvUMLf0rUD2vnzu2NQ=;
        b=ELkh//HWzRzPjsLN0jsTXpeDrDq/zEINz15a8U7GG/gpKDDXidifWqks7UWQXEw114
         adMTUcn+ClOohJ1TDEk0qxyp4sazmcwXyFPBbq2xfMJbdnvh+dZdWS9Xv8AsM5etxJgV
         tDOsfBgmIQRZockmWYAUNhTluKePJwq+LFNfrAp6bE5z5BuXWhhDh+8+DjzkhOza/NxQ
         qY87XrO4L+uJ+4qSLreeF/4R+LUiaYSBkg/NIy8GeklAp505BdGspDrzg5OYMtm5rbT1
         uxNy+SIf73E36Hz18hhR7QtjfXIlH6yZUnz4NftUSWYzTxxjto+MTkxMEEGs/EupiIMQ
         GGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037335; x=1795642135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L1yhfvEqBP7e5XFUmbUnaIa/8XvUMLf0rUD2vnzu2NQ=;
        b=VGqAK/iBTyKSz1SDFPQOEYjzvzggqyjbfZGeLb/xY9Ml+hSJDUpgnQHiw8ow+FfMXf
         8XZriKq8/MDqUeFXvWU/jA99kJvZj6n8FgsLq+ZLKkd7LxQ7RZm5ZHxHXgZ+rIuooCtN
         KbGZZjuyhs0GH3jthlWeK5FccfGAUWtOAtQMJk9a86sNxdkl99bkJVVp6Sy8KtHEJpBg
         FMV8P/SbHPsCc2TZEHRuwlUcfm1Y/BjrMqHFfmx1NcofPT4I73b9S4mjTxG89M/q81bf
         emQx9bM8rzq2HscajzTXHY3CsrWD9nSbp5oXSKcczqz0EPR2xQdFoGs2T9OD1ZOZoN7d
         c3GQ==
X-Forwarded-Encrypted: i=1; AL+hErGJjwTHwW1rQOB2pHx9U4r+6Fdqg0JwLSasYhASr8cgB/YWV4p79ZXxs6rHgAc+ZsB390A9sA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/ezzOChkbIPB/mQcS7jG+zoZMWzAuQxeNKOmiQwx8+A/fjEzvH
	SlsbBHwS1PhL0YmakZT5T0xi5HvXf1tQsjFFB19UM5eJli9BCoEHIF8pG7haSrSDGF8=
X-Gm-Gg: AYBFou03v47GP8Ev/k1/l66DTS41vgQiCtBQ7MP79FiXLsQb/dU02uMDwpBxn7fK+zE
	29grGnchWgirf/CP3yhSYZKFH14OQSZc6b/DX4edj46teBC2mf8HBnhMakLneY1deSuNOTmqOyq
	xSAKHFGDQISHWTows1IfRUTEoXC678ngyItJHLoqWKpZw1a91y1FA47qDGLsZIBIiSHDS8oWbKN
	Oq3rCcYzoDUWmyYm2i8bdZ/xB9aov8FKgwyUwD0JmH7CZgcRvHTAJ0FUd/wSyqeZWkARnR+BGGL
	42AVa5ZhtihO2lvmVGamkiW+Ur3toSIC0ZskJ2+UfLiXJMragNQfF/5NM9dSD+6LH7ebn1LuQ9c
	7go6nxztqh73f/tO7XFu40GVCaXaAj7cqDj0bR+3FExTLakn81FazYe0PjkDg5fa6KQAEv0eTH+
	vBaTOjTR2W7x9EH3x4yp111PlDuDOvcIYaNq19mAkoq4RTD19CpqtLUG1hngtakDpgwPeG7M6/A
	YBtUrFCXW2BPkqbcFOM8DayFB+cKrYVx6uJofTi9JFVKQdtSymgb9OxA8PBDpcyJvF29sHruhuQ
	+ReR/e6A7HYLe3BBAdX8JMutg4R7UaDxfZ+ofxzlNtN/AOHfj/PL7wZvhuyVucUyNNYAE8Wi+vz
	sihQnFLW1mURB8qHIqKVbpbiDHK54vFHxN7LRzqNGLvl2HGUt+4w7QWy5kp59rto1gllV/4pGeg
	==
X-Received: by 2002:a67:e113:0:b0:7c3:2b19:6267 with SMTP id ada2fe7eead31-7d6ba46ca11mr1512091137.32.1795037335676;
        Wed, 18 Nov 2026 13:28:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:54 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-api@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v6 7/7] selftests: liveupdate: Test LIVEUPDATE_SESSION_FREEZE across kexec
Date: Wed, 18 Nov 2026 16:28:42 -0500
Message-ID: <20261118212845.2855249-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132858_003586_73B54A2B 
X-CRM114-Status: GOOD (  11.63  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend luo_multi_session.c to exercise auto-frozen, kept-open frozen,
closed uncommitted frozen, and closed committed sessions together across
a kexec reboot, and verify that freezing an incoming session returns
-EINVAL.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../selftests/liveupdate/luo_multi_session.c  | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
index aac24a5f5ce3..3b09cd63c832 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -15,14 +15,17 @@
 #define SESSION_EMPTY_2 "multi-test-empty-2"
 #define SESSION_FILES_1 "multi-test-files-1"
 #define SESSION_FILES_2 "multi-test-files-2"
+#define SESSION_CLOSED "multi-test-closed"
 
 #define MFD1_TOKEN 0x1001
 #define MFD2_TOKEN 0x2002
 #define MFD3_TOKEN 0x3003
+#define MFD_CLOSED_TOKEN 0x4004
 
 #define MFD1_DATA "Data for session files 1"
 #define MFD2_DATA "First file for session files 2"
 #define MFD3_DATA "Second file for session files 2"
+#define MFD_CLOSED_DATA "Closed session data"
 
 #define STATE_SESSION_NAME "kexec_multi_state"
 #define STATE_MEMFD_TOKEN 998
@@ -30,7 +33,7 @@
 /* Stage 1: Executed before the kexec reboot. */
 static void run_stage_1(int luo_fd)
 {
-	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd;
+	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd, s_closed_fd;
 
 	ksft_print_msg("[STAGE 1] Starting pre-kexec setup for multi-session test...\n");
 
@@ -57,6 +60,8 @@ static void run_stage_1(int luo_fd)
 		fail_exit("create_and_preserve_memfd for token %#x",
 			  MFD1_TOKEN);
 	}
+	if (luo_session_freeze(s_files1_fd, 0) < 0)
+		fail_exit("luo_session_freeze for '%s'", SESSION_FILES_1);
 
 	ksft_print_msg("[STAGE 1] Creating session '%s' with two memfds...\n",
 		       SESSION_FILES_2);
@@ -72,6 +77,25 @@ static void run_stage_1(int luo_fd)
 		fail_exit("create_and_preserve_memfd for token %#x",
 			  MFD3_TOKEN);
 	}
+	if (luo_session_freeze(s_files2_fd,
+			       LIVEUPDATE_SESSION_FREEZE_COMMIT) < 0) {
+		fail_exit("luo_session_freeze for '%s'", SESSION_FILES_2);
+	}
+	close(s_files2_fd);
+
+	ksft_print_msg("[STAGE 1] Creating frozen uncommitted session '%s' and closing FD...\n",
+		       SESSION_CLOSED);
+	s_closed_fd = luo_create_session(luo_fd, SESSION_CLOSED);
+	if (s_closed_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_CLOSED);
+	if (create_and_preserve_memfd(s_closed_fd, MFD_CLOSED_TOKEN,
+				      MFD_CLOSED_DATA) < 0) {
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD_CLOSED_TOKEN);
+	}
+	if (luo_session_freeze(s_closed_fd, 0) < 0)
+		fail_exit("luo_session_freeze for '%s'", SESSION_CLOSED);
+	close(s_closed_fd);
 
 	close(luo_fd);
 	daemonize_and_wait();
@@ -91,6 +115,13 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 			  stage);
 	}
 
+	ksft_print_msg("[STAGE 2] Verifying closed uncommitted session '%s' was not preserved...\n",
+		       SESSION_CLOSED);
+	if (luo_retrieve_session(luo_fd, SESSION_CLOSED) != -ENOENT) {
+		fail_exit("Expected -ENOENT for closed uncommitted session '%s'",
+			  SESSION_CLOSED);
+	}
+
 	ksft_print_msg("[STAGE 2] Retrieving all sessions...\n");
 	s_empty1_fd = luo_retrieve_session(luo_fd, SESSION_EMPTY_1);
 	if (s_empty1_fd < 0)
@@ -108,6 +139,9 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 	if (s_files2_fd < 0)
 		fail_exit("luo_retrieve_session for '%s'", SESSION_FILES_2);
 
+	if (luo_session_freeze(s_files2_fd, 0) != -EINVAL)
+		fail_exit("luo_session_freeze on incoming session did not return -EINVAL");
+
 	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
 		       SESSION_FILES_1);
 	mfd1 = restore_and_verify_memfd(s_files1_fd, MFD1_TOKEN, MFD1_DATA);
-- 
2.56.1.708.g77570a6a1d-goog


