Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E760A2612
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KRIbtewN;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=bUsofb7a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SSI9syxLw5WcjFuLZ1glFarNni2XFz8U30mQtyysmWI=; b=KRIbtewNgsA6a9ZctcSg0rGB+Z
	a/1cnlEnb9VjmGkcSmDkKwURR6Wm7uNjtVFvu5GaDCYJw1OZVkDEyVYtmq8/ygG6J3qjpghsAeo2X
	gnxB9r8Ve+/MWz3+JVuNSFTvVSODTWqu73SiWwJX8jDYrUuRmzaNWlO22992pSLX4Zf1QUJ6ibdXz
	xwsIsJPtdsnkwpkXi5oIDCz1bx8/HcdocVtiYqhPXs4xhyTzZbQIkgyyrCWImzxB8KUdynwiWo+Kz
	YUmOCoJCQAWlJXdHE1g6ZcEsOYuhmggNXEvT718K1NI5pCIh4PtWmpoBJA7XCGzmSfEbbeDOH5fKE
	i/of85Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39W-00000005y9V-0lqp;
	Wed, 11 Nov 2026 07:53:54 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39S-00000005y6z-1XeW
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:52 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1521742a91.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383629; x=1794988429; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SSI9syxLw5WcjFuLZ1glFarNni2XFz8U30mQtyysmWI=;
        b=bUsofb7ap0Lj4XaH5NGtQU6dXLYchVzg6yll3rco0imVrwl0ZiEVd8VMDlfXa6cDMm
         V5ZvR+TbWXRZfltK80EBOAIWskPiNTVeHdNub04b8xnAhXaGI3OhhrYlWe0BvZqPjONz
         gYR6+tTICnMDqaLIzvUVN+PAynCcG21b3QwuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383629; x=1794988429;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSI9syxLw5WcjFuLZ1glFarNni2XFz8U30mQtyysmWI=;
        b=fwNRJkaDzMAtew6jdb6fB3ChTEDYSIhu+CxNKwdCbaxwCOfrGUBTUhDOqI9Z0EhyGq
         tkhIjWVYEIUaj3IhUl0prTCv1WbgWyD+vCUmq8cAHr4YRogobkvxTRN72A5cJda8EW9x
         UyDDWQTIv8Na6O62INELw4X/kL9YgwEpWsJhKDIZLNmH6HR9f95NoYXasJnFX6XtKQFj
         bt2/SM9zC1nED8xuqSvy9v51ssQBvr/e9zMF5HQ8WlJUqcad+rOlKI/WU8VmAcuI6Df6
         DJ6C5K6o7kTU/5bUAjwlMyeUtx+ZVxrU5qs90kjbVkBzBtdDY2gvNyiS7YclQCXA04iy
         mijQ==
X-Forwarded-Encrypted: i=1; AL+hErHBk/mHV5PMMgtzFCNT1apvN8RntNqKHPu+d0zIX0SMr1Dj0+6LUBfVIj19xh3pvA1rFLCaTQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8tZvwn7olQiBfmyginQ17LKG2J8eN+oUrfFQbAXu2HZRsPapzF
	jWAbks2cItY28zKgvjXnaz/JTihIcYl8a6ak0m6dYARspFL/neYuFJufWewxDyl5W9k=
X-Gm-Gg: AYBFou11+67XHiGNV9o9KYti7QJpTIm7eNVADXNjx8gb2PjGiZUyHhnWLmOdUSLNe0z
	dL7B4rFL0PA40MF1uE+pvmadCtRhBvs1UZlmZr4Rgk1RwQm/fZNl3Ic4RE+vZDNg7QlBDd54H7t
	If5XFlIIKHMA1/t/8sLkK5CobGlGzcHKq2UD1cVZlkntqVlbI+ebCxW8IpFWtVBMpF06AMwUPzS
	9zzxO/kWoe7kfmK0Mml0Y8OhvhiwXgvkWsqkW67ki6HtHzYVc8QcJ+meN/m4FGWrfcEQaTIQJxj
	kqZ2xSzCmjY5CZaSs1B0TfODuXHI1u7DWlK1QPTL4CtHEwirMMZczNA543lGa9TM83+Jz80yRNt
	0W0RTJd9f8JkSLDcCK8/WOZZ1cAawzPVesGUN/l9wdRr7GkbPQqCPN3Tdnib+cldfHNpChq6sEM
	c/WvNIHYl5WKUQrR5ecGMpAgJz5+OcpmT2c3Gi8UOqo3JCiugxnx54dOwAMD2jQXeZwbljlknIN
	bsyTnrE/zzh6+lqHUe5nrowp2CX54IZc6ENxZLoOVfX1IyUGgckWjuTVr4Px6qgnJJWd9K1ap1u
	m73n1XGReKlBWpiilvZ0TtEyB6MWBF+Vcm9IaMnD+QsQRfjFANXhw6EwSfEzOO/D0geiHPAmCgR
	XX1jhWKq1euEHFmoSgJP6FKSo3W7lxGLVlyLHI52MNCY5MgW4nnbggvOb7BWcOQR3ctG+chFKQ3
	lZem8hHTyn7EZTHrR+fyB0UWdbhP+Ahad1vMb4GC0SwOylrQwQPZUt
X-Received: by 2002:a17:90b:5483:b0:3ac:80dc:f419 with SMTP id 98e67ed59e1d1-3b182fb308emr1835511a91.25.1794383629583;
        Tue, 10 Nov 2026 23:53:49 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17da4cd8csm3404966a91.2.2026.11.10.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:49 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:45 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 9/9] selftests/liveupdate: Check handover revival, sequence
 and memory stats
Message-ID: <738fbfd19034ce495de9b22c705a7815a236907d.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235351_415640_6D9E97D8 
X-CRM114-Status: GOOD (  18.20  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the handover stats test to cover the new files. On the first
boot, kho_incoming/state should be none, liveupdate_num 0, and both KHO
sizes 0. After the kexec, the handover should be revived and
liveupdate_num should be 1.

restored_size should grow by at least a page each time a memfd is
retrieved or dropped. The memfd in the unclaimed session is retrieved
last, once everything else is done.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../selftests/liveupdate/luo_handover_stats.c | 74 +++++++++++++++++--
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/luo_handover_stats.c b/tools/testing/selftests/liveupdate/luo_handover_stats.c
index f18df79dda55..2863630b823e 100644
--- a/tools/testing/selftests/liveupdate/luo_handover_stats.c
+++ b/tools/testing/selftests/liveupdate/luo_handover_stats.c
@@ -10,6 +10,7 @@
 #include <libliveupdate.h>
 
 #define INCOMING_DIR "/sys/class/misc/liveupdate/incoming/"
+#define KHO_INCOMING_DIR "/sys/kernel/kexec/kho_incoming/"
 
 #define SESSION_CLAIMED "stats-claimed"
 #define SESSION_UNCLAIMED "stats-unclaimed"
@@ -28,13 +29,13 @@
 /* The first open starts deserialization. */
 static char state_before_open[16];
 
-static void read_incoming(const char *name, char *buf, size_t len)
+static void read_sysfs(const char *dir, const char *name, char *buf, size_t len)
 {
 	char path[128];
 	ssize_t n;
 	int fd;
 
-	snprintf(path, sizeof(path), INCOMING_DIR "%s", name);
+	snprintf(path, sizeof(path), "%s%s", dir, name);
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		fail_exit("open %s", path);
@@ -54,6 +55,11 @@ static void read_incoming(const char *name, char *buf, size_t len)
 		buf[n - 1] = '\0';
 }
 
+static void read_incoming(const char *name, char *buf, size_t len)
+{
+	read_sysfs(INCOMING_DIR, name, buf, len);
+}
+
 static void expect_state(const char *state, const char *expected)
 {
 	if (strcmp(state, expected))
@@ -61,13 +67,13 @@ static void expect_state(const char *state, const char *expected)
 				   expected);
 }
 
-static unsigned long long read_number(const char *name)
+static unsigned long long read_number(const char *dir, const char *name)
 {
 	unsigned long long val = 0;
 	char buf[32];
 	char *p;
 
-	read_incoming(name, buf, sizeof(buf));
+	read_sysfs(dir, name, buf, sizeof(buf));
 	for (p = buf; *p >= '0' && *p <= '9'; p++) {
 		if (val > (ULLONG_MAX - (*p - '0')) / 10)
 			break;
@@ -75,19 +81,45 @@ static unsigned long long read_number(const char *name)
 	}
 	if (p == buf || *p)
 		ksft_exit_fail_msg("%s%s reads '%s', not a 64-bit unsigned number\n",
-				   INCOMING_DIR, name, buf);
+				   dir, name, buf);
 	return val;
 }
 
 static void expect_count(const char *name, unsigned long long expected)
 {
-	unsigned long long val = read_number(name);
+	unsigned long long val = read_number(INCOMING_DIR, name);
 
 	if (val != expected)
 		ksft_exit_fail_msg("%s is %llu, expected %llu\n", name, val,
 				   expected);
 }
 
+static void expect_kho_state(const char *expected)
+{
+	char state[16];
+
+	read_sysfs(KHO_INCOMING_DIR, "state", state, sizeof(state));
+	if (strcmp(state, expected))
+		ksft_exit_fail_msg("kho_incoming/state is '%s', expected '%s'\n",
+				   state, expected);
+}
+
+static unsigned long long kho_size(const char *name)
+{
+	return read_number(KHO_INCOMING_DIR, name);
+}
+
+static unsigned long long expect_more_restored(unsigned long long prev)
+{
+	unsigned long long restored = kho_size("restored_size");
+
+	if (restored < prev + getpagesize() ||
+	    restored > kho_size("preserved_size"))
+		ksft_exit_fail_msg("restored_size went from %llu to %llu\n",
+				   prev, restored);
+	return restored;
+}
+
 static void expect_counts(long retrieved, long dropped)
 {
 	char state[16];
@@ -111,6 +143,10 @@ static void run_stage_1(int luo_fd)
 	expect_state(state_before_open, "none");
 	expect_count("sessions", 0);
 	expect_count("files", 0);
+	expect_count("liveupdate_num", 0);
+	expect_kho_state("none");
+	if (kho_size("preserved_size") || kho_size("restored_size"))
+		ksft_exit_fail_msg("KHO sizes aren't 0 on a cold boot\n");
 
 	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
 
@@ -144,11 +180,16 @@ static void run_stage_1(int luo_fd)
 
 static void run_stage_2(int luo_fd, int state_session_fd)
 {
-	int claimed_fd, mfd, stage;
+	int claimed_fd, unclaimed_fd, mfd, stage;
+	unsigned long long restored;
 
 	ksft_print_msg("[STAGE 2] Checking state before and after the first open...\n");
 	expect_state(state_before_open, "pending");
 	expect_counts(0, 0);
+	expect_count("liveupdate_num", 1);
+	expect_kho_state("revived");
+	if (!kho_size("preserved_size"))
+		ksft_exit_fail_msg("kho_incoming/preserved_size is 0\n");
 
 	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &stage);
 	if (stage != 2)
@@ -163,6 +204,7 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 	if (claimed_fd < 0)
 		fail_exit("luo_retrieve_session for '%s'", SESSION_CLAIMED);
 
+	restored = kho_size("restored_size");
 	mfd = restore_and_verify_memfd(claimed_fd, MFD_RETRIEVED_TOKEN,
 				       MFD_RETRIEVED_DATA);
 	if (mfd < 0)
@@ -170,6 +212,7 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 			  MFD_RETRIEVED_TOKEN);
 	close(mfd);
 	expect_counts(2, 0);
+	restored = expect_more_restored(restored);
 
 	ksft_print_msg("[STAGE 2] Finishing '%s'...\n", SESSION_CLAIMED);
 	if (luo_session_finish(claimed_fd) < 0)
@@ -177,6 +220,7 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 	close(claimed_fd);
 
 	expect_counts(2, 1);
+	expect_more_restored(restored);
 
 	ksft_print_msg("[STAGE 2] Finishing the state session...\n");
 	if (luo_session_finish(state_session_fd) < 0)
@@ -185,6 +229,22 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 
 	/* Finishing the state session must not drop anything. */
 	expect_counts(2, 1);
+	restored = kho_size("restored_size");
+
+	ksft_print_msg("[STAGE 2] Retrieving the memfd in '%s'...\n",
+		       SESSION_UNCLAIMED);
+	unclaimed_fd = luo_retrieve_session(luo_fd, SESSION_UNCLAIMED);
+	if (unclaimed_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", SESSION_UNCLAIMED);
+	mfd = restore_and_verify_memfd(unclaimed_fd, MFD_UNCLAIMED_TOKEN,
+				       MFD_UNCLAIMED_DATA);
+	if (mfd < 0)
+		fail_exit("restore_and_verify_memfd for token %#x",
+			  MFD_UNCLAIMED_TOKEN);
+	close(mfd);
+	close(unclaimed_fd);
+	expect_counts(3, 1);
+	expect_more_restored(restored);
 
 	ksft_print_msg("\n--- HANDOVER STATS TEST PASSED ---\n");
 }
-- 
2.54.0


