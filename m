Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E42CC88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SUM43IO6qNWvRdNooAPnPsLAAH/RcolhMgr+hyP1MvM=; b=3P1W6I7QBh5tBjt2RusVN2fZBm
	C13UPGJgSl0g80YXKXrQWcHq459HLnMupYGT4E5VKdkQve8hteGgBbRcUEapxNgyhvQtf1RcyIQqO
	cwX2jzy1xtjSkIvm6aiW8uVdo+dUeR0teh7jF14kZzWf19rYsAnUuALQhT8B4YKkMsnKEdnx3Cmdc
	xNfBw94z4el90ToV6GZbmoDjjnF65xYL5A/vNYEzAk/2MAJdyTi68yZZeTCn3Qcp02+t6eV28Gs1V
	9JZZ26jorWGwcuOU6lDiyHJlOk0lKzCOoI2MR5Bu4ITts8OffPohaGV1Z4dnBAevLmHAN/4pQyPY0
	lz/Ly0ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTH-00000006Dk2-40p4;
	Tue, 15 Sep 2026 11:37:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSR-00000006Cgo-0g3E;
	Tue, 15 Sep 2026 11:36:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 94A71600D1;
	Tue, 15 Sep 2026 11:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F6B1F000FF;
	Tue, 15 Sep 2026 11:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472174;
	bh=SUM43IO6qNWvRdNooAPnPsLAAH/RcolhMgr+hyP1MvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fXxOaBNdJwFX/Lk/E/kRGTURHefQKpPPy4SOimei8WnuQFymjQ54Osu1qX23oVPTQ
	 m0A8Uo6l6w4qKA2hJ3urgORqbpweOp4clPRtYTGkNID+oymAFlp8BwoOHfWgXjq00g
	 2jaCNdDGKnUTjAY9tG8l6AGYNW5fihLVRuWziN2I32TvRehjGk6CF4lsh9F7JKNwM8
	 v5WKv5XKjGiJgpuTC+6woLjedYHaONUBygXryBe6w8FmgPTi4h5Mt5Fbn+0QCTmLSc
	 1dRRPZi0WCjS5bVpj31Cm7wGEaPUy3iJpp2OQokIUXhIHQiwa1Leonc8PLtC/JB8/R
	 gVXIBaAx596pQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:24 +0200
Subject: [PATCH RFC POC 38/50] perf: stop putting the event descriptor back
 on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2461; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gBId4KwT9HjrpRN/GtoshdJN45hNk2Km5XhUS+Rx/dQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Knz3yduOPXT6cQYVeXHZzbnqs7Zqcayytk3qHiay
 eV9UyYIdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk7jIjw7OGE8fOrTS3bVvT
 7m02I8bx3+9MntLGq9z1gtyNvPx5jAz/fe684tNnVrol8LfYa7a9+/c7fcJ8jXoa4n6P/MXywr1
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/events/core.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..54834a7aca53 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13924,7 +13924,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct file *event_file = NULL;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
-	int event_fd;
+	const struct fd_slot *event_fd;
 	int move_group = 0;
 	int err;
 	int f_flags = O_RDWR;
@@ -13990,9 +13990,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & PERF_FLAG_FD_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 
-	event_fd = get_unused_fd_flags(f_flags);
-	if (event_fd < 0)
-		return event_fd;
+	event_fd = fd_prepare(f_flags);
+	if (IS_ERR(event_fd))
+		return PTR_ERR(event_fd);
 
 	/*
 	 * Event creation should be under SRCU, see perf_pmu_unregister().
@@ -14001,15 +14001,11 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	CLASS(fd, group)(group_fd);     // group_fd == -1 => empty
 	if (group_fd != -1) {
-		if (!is_perf_file(group)) {
-			err = -EBADF;
-			goto err_fd;
-		}
+		if (!is_perf_file(group))
+			return -EBADF;
 		group_leader = fd_file(group)->private_data;
-		if (group_leader->state <= PERF_EVENT_STATE_EXIT) {
-			err = -ENODEV;
-			goto err_fd;
-		}
+		if (group_leader->state <= PERF_EVENT_STATE_EXIT)
+			return -ENODEV;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
@@ -14018,10 +14014,8 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (pid != -1 && !(flags & PERF_FLAG_PID_CGROUP)) {
 		task = find_lively_task_by_vpid(pid);
-		if (IS_ERR(task)) {
-			err = PTR_ERR(task);
-			goto err_fd;
-		}
+		if (IS_ERR(task))
+			return PTR_ERR(task);
 	}
 
 	if (task && group_leader &&
@@ -14298,8 +14292,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	 * This ensures destruction of the group leader will find
 	 * the pointer to itself in perf_group_detach().
 	 */
-	fd_install(event_fd, event_file);
-	return event_fd;
+	return fd_stage(event_fd, event_file);
 
 err_context:
 	put_pmu_ctx(event->pmu_ctx);
@@ -14316,8 +14309,6 @@ SYSCALL_DEFINE5(perf_event_open,
 err_task:
 	if (task)
 		put_task_struct(task);
-err_fd:
-	put_unused_fd(event_fd);
 	return err;
 }
 

-- 
2.53.0


