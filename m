Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0572DCA5FC4
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 00:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yIoi1CTTQE+H6lBdui6vFwHZt26KiAg5p1JL2AMiq80=; b=nbSt5kw9CZwhoI/kBQkZFZHtew
	S5nZbSfDsjplBgFiY+THcjYxvcwDsFcAz6lxFyY+lumejkf6NBqPCjdLX0aHERg+4KnFG80vKAa8c
	K+9Z8JoEDaWZnuhWZQaKGsoWptPqkdG5yF5Rm2teG2vhc36EbhWrYpL6Q1a+A3aIRAgqjdGCZNNfu
	rQGAtT/RiRKkBwvylpn+vt2G3Kq5o6VMNyRGx85oDwCCNTI00k5O7Q9Rvy3Y1D7GZkhBjwxdSLD2F
	Vpxz8wiJY/o5gpWQ+JkG91ir6ftcQ5jwoY3eVOISVs2AINHFmQyBTmiBUtU93E0JGSCgWQw/v/FLR
	oA+CLlNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57M-00000007XHJ-3POx;
	Thu, 01 Oct 2026 00:57:48 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57K-00000007XFZ-0tPN
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 00:57:47 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cfa4e4684bso99750545ad.2
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 17:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790816265; x=1791421065; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIoi1CTTQE+H6lBdui6vFwHZt26KiAg5p1JL2AMiq80=;
        b=i6upH5VHDSMm6xAd/kE25sspLfyZK3S/8co8eA0QzxtnCNB7uB12wGeY4mELbSn3/f
         /bcOhYkCg+4V5SUn+G9oLBNwO2Pr2oZ+RZFRPo0Og/B3mZaOTVQPFFlBdnWDPj8472Ox
         nwlljltZK1Y5ypmEyCrpgPxSlnX5sAA/ONhhGqWpS7GZF9Od2mowCvCHm8bajXcDf2Qa
         C0OiKNAcj9Vp09cZ1UwuZi2Lv/vk27F38joWe+t2ynKrMYyMqSSGlpKEm2c3nYZgQPPU
         Ng5lmpsU04mdb2+U5NZOD3COQBnFKEJqOjITVpK5KIcssjcTxbew5S3bPT4baqAMTQJ9
         q9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816265; x=1791421065;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yIoi1CTTQE+H6lBdui6vFwHZt26KiAg5p1JL2AMiq80=;
        b=PSafTlHVFJXUZaL+j5HKw55TQ6cR0JE4yX26zvYm2DOKE6pakRDdVx5WppvlQB15jn
         Mu4BUP0GWBjLyGddlMI5lHxclNUUD89lOTJmhhztU5L9k/uIrTCeSxi4yua34r3XuAYR
         JqtnG+1VOmuRrAubyn1Sc1cZL67xeQ0H1oAWEV/Z5UC/GlUfbmfC4JRzjxTeMXtj1w3/
         W4xcL3snY7y3ZOcYN478DjAOhSLhN0dxzHSJXNcFrvJj8cR4anX5zhaJpytnxoml/vdL
         2DhJLpSlZVVnYBRSY2tLS1G+s0/kmf7tHbLOLL2Kh/mwLgqdD1nMVh/gH7aRqV6Q/l9p
         nGGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaW51hOAM0g/HrG9kiQyANOAp6my+7Eg8QbZ5/fljU4mNVKnUiaSW07q+8QsaiIZGMfM514w==@lists.infradead.org
X-Gm-Message-State: AFq9FYLWB64YJKkiNbxZ2CQ/4u513jUyD0CO5ectFap3uH8dqt9bd6+L
	8Kp4lLG79+30oUjMAdfVPvHgSRGxDuuImFtKIQaFtbNwFjd2zEuCVEh52Ne4ofWkJIUClUkCpV6
	xr8+xIOdWwQt9gw==
X-Received: from plan4.prod.google.com ([2002:a17:903:4044:b0:2df:8ab5:8354])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2983:b0:2e2:dc0c:1615 with SMTP id d9443c01a7336-2e2e4b3399fmr25155855ad.31.1790816264954;
 Wed, 30 Sep 2026 17:57:44 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:57:33 +0000
In-Reply-To: <20261001005734.1033516-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20261001005734.1033516-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001005734.1033516-6-skhawaja@google.com>
Subject: [RFC PATCH 5/6] selftests/liveupdate: Add API to preserve a batch of FDs
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_175746_261230_86B7E1A6 
X-CRM114-Status: GOOD (  10.92  )
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

Add luo_session_preserve_fds() that can be used to preserve a batch of
FDs using the LIVEUPDATE_SESSION_PRESERVE_FDS ioctl.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  2 ++
 .../selftests/liveupdate/lib/lu_utils.c       | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index fa07fed08364..9aaf6f28ef56 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -29,6 +29,8 @@ int luo_get_session_name(int session_fd, char *name, size_t name_len);
 
 int luo_ensure_nofile_limit(long min_limit);
 int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
+int luo_session_preserve_fds(int session_fd, const int *fds,
+			     const __u64 *tokens, __u32 nr, __u32 *failed_idx);
 int luo_session_retrieve_fd(int session_fd, __u64 token);
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 74d41115c281..1290f27ff004 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -93,6 +93,26 @@ int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
 	return 0;
 }
 
+int luo_session_preserve_fds(int session_fd, const int *fds,
+			     const __u64 *tokens, __u32 nr, __u32 *failed_idx)
+{
+	struct liveupdate_session_preserve_fds arg = {
+		.size = sizeof(arg),
+		.nr = nr,
+		.fds = (__u64)(uintptr_t)fds,
+		.tokens = (__u64)(uintptr_t)tokens,
+	};
+	int ret = 0;
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FDS, &arg))
+		ret = -errno;
+
+	if (failed_idx)
+		*failed_idx = arg.out_failed_index;
+
+	return ret;
+}
+
 int luo_session_retrieve_fd(int session_fd, __u64 token)
 {
 	struct liveupdate_session_retrieve_fd arg = {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


