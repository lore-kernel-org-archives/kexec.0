Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57495CD4F24
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SeXyZ2K2XEjBeKwwGeb4rWTFXw2PqWPPbiWdlJeVqhc=; b=PQqCUbtifj8K99lOKvR48cVaV7
	/zJD8nzOwWPx5amn+/fH5FNjzY2/ZI0D6BGBIyzLxuTvjpqZKTLXOb2VH/dS4W+O0nYpfulz6eYjv
	wJi7Ar1puOvhQ6ih95PUEfCpCdZSymp/LY5XJSXpLqJzzYe6OnxY3PhRCVT6BNR0SRIhNlx9kRuY6
	Sa2BmmQywLpIEe+jpqwoC6LO+625xdsu91Zh+mFJLn9gORwaoji5V7KIp4Ukkz61PDJcSYH7cHYly
	6rSnIopGOzzrgfozQON4PYI64vY1qunnL0xcFWxQoAtGcmvnJjveuE0AV+/V6X1pGKMvc4uUxYnr9
	tPjmtXuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnih-0000000Gwp0-12K8;
	Tue, 12 May 2026 14:04:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnid-0000000Gwni-401c
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 14:04:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4ACED42B86;
	Tue, 12 May 2026 14:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE51C2BCB0;
	Tue, 12 May 2026 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594659;
	bh=Q8yAjyxfHY28L//mLfMimLlu3G9TMaVuo/gBH1FBvpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cq2MuUjxZaaz+oJSEXJdEeDtgTFAJIvx2jPoPT4P6i2bH/XG9P0Onm/6MTLHNcxKw
	 qoLuRi9AHWEatgSAaWFT5oiZwoPK1T5hcGQLdHc+Lg72YDYnVs3g2tzz1MTl1RiiR3
	 C4v1FuubXlphP8LVjCu4oVy53Rjqb12zvaF1rA7/dZ036+hm6IWAne2C34nnB7tcTp
	 auxKGuYUl/ylMxcMga0/vMAqhTqfNHr1cbjup6I/LfIcwOeI2Ylh14yHINQabwAWJN
	 y+kSgpKNsEWxbyTw/oGT1Obf5TzYUoR0dyqv4Xq6fVs201SJt7/HF3JZhvpg4n/SPH
	 nMxBaKQbDnbVw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH 3/5] selftests/liveupdate: Test session and file limit
 removal
In-Reply-To: <20260414200237.444170-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 14 Apr 2026 20:02:35 +0000")
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
	<20260414200237.444170-4-pasha.tatashin@soleen.com>
Date: Tue, 12 May 2026 16:04:15 +0200
Message-ID: <2vxzse7wafmo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_070420_028991_D24D5ECF 
X-CRM114-Status: GOOD (  24.80  )
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

On Tue, Apr 14 2026, Pasha Tatashin wrote:

> With the removal of static limits on the number of sessions and files per
> session, the orchestrator now uses dynamic allocation.
>
> Add new test cases to verify that the system can handle a large number of
> sessions and files. These tests ensure that the dynamic block allocation
> and reuse logic for session metadata and outgoing files work correctly
> beyond the previous static limits.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  .../testing/selftests/liveupdate/liveupdate.c | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index 37c808fbe1e9..0eaf97b19267 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -22,6 +22,7 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
> +#include <sys/resource.h>
>  #include <unistd.h>
>  
>  #include <linux/liveupdate.h>
> @@ -386,4 +387,102 @@ TEST_F(liveupdate_device, prevent_double_preservation)
>  	ASSERT_EQ(close(session_fd2), 0);
>  }
>  
> +static void ensure_nofile_limit(struct __test_metadata *_metadata,
> +				long min_limit)
> +{
> +	struct rlimit hl;
> +
> +	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
> +		ksft_exit_fail_msg("getrlimit failed: %s\n", strerror(errno));
> +
> +	if (hl.rlim_cur >= min_limit)
> +		return;
> +
> +	hl.rlim_cur = min_limit;
> +	if (hl.rlim_cur > hl.rlim_max)
> +		hl.rlim_max = hl.rlim_cur;
> +
> +	if (setrlimit(RLIMIT_NOFILE, &hl) < 0) {
> +		if (errno == EPERM) {
> +			SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE to %ld",
> +			     hl.rlim_cur);
> +		}
> +		ksft_exit_fail_msg("setrlimit to %ld failed: %s\n",
> +				   hl.rlim_cur, strerror(errno));
> +	}
> +}
> +
> +/*
> + * Test Case: Manage Many Sessions
> + *
> + * Verifies that a large number of sessions can be created and then
> + * destroyed during normal system operation. This specifically tests the
> + * dynamic block allocation and reuse logic for session metadata management
> + * without preserving any files.
> + */
> +TEST_F(liveupdate_device, preserve_many_sessions)
> +{
> +#define MANY_SESSIONS 2000
> +	int session_fds[MANY_SESSIONS];
> +	int i;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	ensure_nofile_limit(_metadata, MANY_SESSIONS + 10);
> +	if (_metadata->exit_code == KSFT_SKIP)
> +		return;

Nit: This is strange. Why not just return errno in ensure_nofile_limit()
and handle the skipping here? Same below.

LGTM otherwise.

> +
> +	for (i = 0; i < MANY_SESSIONS; i++) {
> +		char name[64];
> +
> +		snprintf(name, sizeof(name), "many-session-%d", i);
> +		session_fds[i] = create_session(self->fd1, name);
> +		ASSERT_GE(session_fds[i], 0);
> +	}
> +
> +	for (i = 0; i < MANY_SESSIONS; i++)
> +		ASSERT_EQ(close(session_fds[i]), 0);
> +}
> +
> +/*
> + * Test Case: Preserve Many Files
> + *
> + * Verifies that a large number of files can be preserved in a single session
> + * and then destroyed during normal system operation. This tests the dynamic
> + * block allocation and management for outgoing files.
> + */
> +TEST_F(liveupdate_device, preserve_many_files)
> +{
> +#define MANY_FILES 500
> +	int mem_fds[MANY_FILES];
> +	int session_fd;
> +	int i;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, "many-files-test");
> +	ASSERT_GE(session_fd, 0);
> +
> +	ensure_nofile_limit(_metadata, MANY_FILES + 10);
> +	if (_metadata->exit_code == KSFT_SKIP)
> +		return;
> +
> +	for (i = 0; i < MANY_FILES; i++) {
> +		mem_fds[i] = memfd_create("test-memfd", 0);
> +		ASSERT_GE(mem_fds[i], 0);
> +		ASSERT_EQ(preserve_fd(session_fd, mem_fds[i], i), 0);
> +	}
> +
> +	for (i = 0; i < MANY_FILES; i++)
> +		ASSERT_EQ(close(mem_fds[i]), 0);
> +
> +	ASSERT_EQ(close(session_fd), 0);
> +}
> +
>  TEST_HARNESS_MAIN

-- 
Regards,
Pratyush Yadav

