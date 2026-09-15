Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AA3C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MrvtETchtY74VhNhdP5L1TLK5JZUI/4E6S7ET6JvLE=; b=STTj9KBIsFZ2pMlA6rRkL9dRdU
	Fd0+O3ecrLXDuoDZE/oPTEWfnJQbUjvrBDMBGya5It9h+EfOJxdB+fAzrPxJZfjtGEj7RrejQOAEV
	TaHo/FS1ZVargYxJ4/YNctJNFTVaBu3W3imCfGA7Syl31hl1adwu2z8AfhOuQ+TlTrM2cp1wY1ozT
	XW/njWm7qfL/JcG1Bm+FyjwnLudNTLih4MhGCpyVblnwb8TdWsqEBtkezUToTK2tOJqMvgfbRXbJ/
	49CzlY6fT8OquIuDu92qqXqbTLuRhBkbkXTk1RcxkWWkKkoC/UxSskEWL3ZeP7VJfycsDnwb4SeVw
	GyrDvHVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSm-00000006D5I-36jw;
	Tue, 15 Sep 2026 11:36:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RRv-00000006CIb-0sme;
	Tue, 15 Sep 2026 11:35:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EDB76415D0;
	Tue, 15 Sep 2026 11:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C21F00893;
	Tue, 15 Sep 2026 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472142;
	bh=1MrvtETchtY74VhNhdP5L1TLK5JZUI/4E6S7ET6JvLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HEvP3jmwChKyeHdJ9Jg3mkRQ3dA8Vigmgn9aN70pEyemzrmDRt+HBflUFt5dg79cy
	 nmMA9QgA22+3lDgeMbCub5jO8UBj8OpN+VauBt7p0dIet/Okhi/+8AxBkWACPQan5v
	 iQ0CGGPOK3xa6Bp++Ti5WKZZzuDFnPibEu6y50nXpqvsbgWZb46/QO9Fp/CohuBmiy
	 4H6uR9SGKU0GNDbp8fufyXpe2tUFSDQhZvLM/dJkrYmbemLCUe0oHuhVmELpbcwMRe
	 lCVZjHzvU3NtKwOBPfXEcCycM3OMg+ZekdadygNaeC/QE91ROYMdhIuR0e/OpAPmhY
	 Sv9/raR2HHHcg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:20 +0200
Subject: [PATCH RFC POC 34/50] sctp: install the peeloff descriptor when
 the syscall returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3999; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jxeTmf0RLLPrfqfHR6VaW0QlyLJFo9vgcxMApZCym7U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Km7cNv2coTSh6uv2SKV9J9xe1cli18O2fg9bbWMR
 XmeZEFFRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQuPmT4ZzXhBS9/eF7krI4v
 9nuSVLY1Xi4SeKo2SeDbFrPXBqrPxBj+yrHXSsXOVdm4U/HG2oqX3ly9K7UCc6pmru7Si/L9f7W
 YAQA=
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
 net/sctp/socket.c | 78 +++++++++++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..b75c50af8c16 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5744,46 +5744,41 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
 }
 
 static int sctp_getsockopt_peeloff_common(struct sock *sk, sctp_peeloff_arg_t *peeloff,
-					  struct file **newfile, unsigned flags)
+					  unsigned flags)
 {
 	struct socket *newsock;
+	struct file *newfile;
+	const struct fd_slot *fd;
 	int retval;
 
 	retval = sctp_do_peeloff(sk, peeloff->associd, &newsock);
 	if (retval < 0)
-		goto out;
+		return retval;
 
-	/* Map the socket to an unused fd that can be returned to the user.  */
-	retval = get_unused_fd_flags(flags & SOCK_CLOEXEC);
-	if (retval < 0) {
+	/* Map the socket to a reserved fd that can be returned to the user. */
+	fd = fd_prepare(flags & SOCK_CLOEXEC);
+	if (IS_ERR(fd)) {
 		sock_release(newsock);
-		goto out;
-	}
-
-	*newfile = sock_alloc_file(newsock, 0, NULL);
-	if (IS_ERR(*newfile)) {
-		put_unused_fd(retval);
-		retval = PTR_ERR(*newfile);
-		*newfile = NULL;
-		return retval;
+		return PTR_ERR(fd);
 	}
 
-	pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
-		 retval);
-
-	peeloff->sd = retval;
+	newfile = sock_alloc_file(newsock, 0, NULL);
+	if (IS_ERR(newfile))
+		return PTR_ERR(newfile);
 
 	if (flags & SOCK_NONBLOCK)
-		(*newfile)->f_flags |= O_NONBLOCK;
-out:
-	return retval;
+		newfile->f_flags |= O_NONBLOCK;
+
+	peeloff->sd = fd_stage(fd, newfile);
+	pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
+		 peeloff->sd);
+	return peeloff->sd;
 }
 
 static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval, int __user *optlen)
 {
 	sctp_peeloff_arg_t peeloff;
-	struct file *newfile = NULL;
-	int retval = 0;
+	int retval;
 
 	if (len < sizeof(sctp_peeloff_arg_t))
 		return -EINVAL;
@@ -5791,24 +5786,17 @@ static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval
 	if (copy_from_user(&peeloff, optval, len))
 		return -EFAULT;
 
-	retval = sctp_getsockopt_peeloff_common(sk, &peeloff, &newfile, 0);
+	retval = sctp_getsockopt_peeloff_common(sk, &peeloff, 0);
 	if (retval < 0)
-		goto out;
+		return retval;
 
 	/* Return the fd mapped to the new socket.  */
-	if (put_user(len, optlen)) {
-		fput(newfile);
-		put_unused_fd(retval);
+	if (put_user(len, optlen))
 		return -EFAULT;
-	}
 
-	if (copy_to_user(optval, &peeloff, len)) {
-		fput(newfile);
-		put_unused_fd(retval);
+	if (copy_to_user(optval, &peeloff, len))
 		return -EFAULT;
-	}
-	fd_install(retval, newfile);
-out:
+
 	return retval;
 }
 
@@ -5816,8 +5804,7 @@ static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
 					 char __user *optval, int __user *optlen)
 {
 	sctp_peeloff_flags_arg_t peeloff;
-	struct file *newfile = NULL;
-	int retval = 0;
+	int retval;
 
 	if (len < sizeof(sctp_peeloff_flags_arg_t))
 		return -EINVAL;
@@ -5826,24 +5813,17 @@ static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
 		return -EFAULT;
 
 	retval = sctp_getsockopt_peeloff_common(sk, &peeloff.p_arg,
-						&newfile, peeloff.flags);
+						peeloff.flags);
 	if (retval < 0)
-		goto out;
+		return retval;
 
 	/* Return the fd mapped to the new socket.  */
-	if (put_user(len, optlen)) {
-		fput(newfile);
-		put_unused_fd(retval);
+	if (put_user(len, optlen))
 		return -EFAULT;
-	}
 
-	if (copy_to_user(optval, &peeloff, len)) {
-		fput(newfile);
-		put_unused_fd(retval);
+	if (copy_to_user(optval, &peeloff, len))
 		return -EFAULT;
-	}
-	fd_install(retval, newfile);
-out:
+
 	return retval;
 }
 

-- 
2.53.0


