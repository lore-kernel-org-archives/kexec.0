Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D455CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2hF44QBQfUGRJ9iAPSXn6oHYpoPJZaLfD83FbTWLpNs=; b=G5k9QBYhS22T16+s+qArkd00DP
	1OMloqpbkROchfywnXRP/jH0jkqp2w9aIlhmpIm392PhuHjZszLFU7iZ0h6JrRbgqvh+hsY6CRRHe
	RlBaMApxLFd2cDw7YCI2Oq19Kv/Z1/HAnG9atZkavf+h0/QIsrg3rvkT1gh/rNDGQvU1tppS+rb8k
	xMZoiMscX8wu+YABGQKjrDcXLDvdhyDOT0mU+3k8RS0RrKC5yTOpfXa1O1Xe9laVFizZZTTCroZC1
	8lYCgg342AKAuNBj8NQjS6s9gb6pS2nJocUmu+qjNC2P37BIFlEJdd8u11YDKQ5H+llRnr0wsUFfV
	kXosOlMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3SH-0000000BGcY-1a5c;
	Mon, 01 Jun 2026 14:17:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3SG-0000000BGcO-20ac
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 14:17:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A0BB66014C;
	Mon,  1 Jun 2026 14:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34081F00893;
	Mon,  1 Jun 2026 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780323443;
	bh=2hF44QBQfUGRJ9iAPSXn6oHYpoPJZaLfD83FbTWLpNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bCsLsbpFf1I2jIhql6W7+uBxnx3jEUKFN5cFzZWZo6CIsF+hI2WutwsDUEbUPviJJ
	 oRV9Ueh2aOziXxB+xBQbTl8qQi1ygOSeQJn8sPgZBnp/q98drLJgRrzSjs2sZjUbKp
	 dWl9vlcRbvItA9+hdOCEXt95ytfWSdkos5XeWE20pDKnlXw1iL3XPENRPNKj8d95g2
	 Y0z9UgPbkn92Elp9yfffpJnylqQ19mbq3+h1N9eeOxp0e8itjuXTZ0bk+knwrzEVe2
	 Vq7KfwOqmH1gpKR3r4zRdBtwkSC7N1g01XBW3ixKM6x/rKTI0vf6+uV3xT26yDU7C0
	 SXGetPm8P9v/A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 11/13] selftests/liveupdate: Test session and file
 limit removal
In-Reply-To: <20260530221938.115978-12-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:36 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-12-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 16:17:19 +0200
Message-ID: <2vxz7boifiq8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> With the removal of static limits on the number of sessions and files per
> session, the orchestrator now uses dynamic allocation.
>
> Add new test cases to verify that the system can handle a large number of
> sessions and files. These tests ensure that the dynamic block allocation
> and reuse logic for session metadata and outgoing files work correctly
> beyond the previous static limits.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

> ---
>  .../testing/selftests/liveupdate/liveupdate.c | 75 +++++++++++++++++++
>  .../selftests/liveupdate/luo_test_utils.c     | 24 ++++++
>  .../selftests/liveupdate/luo_test_utils.h     |  2 +
>  3 files changed, 101 insertions(+)
>
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index c7d94b9181e1..502fb3567e38 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -26,6 +26,7 @@
>  
>  #include <linux/liveupdate.h>
>  
> +#include "luo_test_utils.h"
>  #include "../kselftest.h"
>  #include "../kselftest_harness.h"
>  
> @@ -499,4 +500,78 @@ TEST_F(liveupdate_device, get_session_name_max_length)
>  	ASSERT_EQ(close(session_fd), 0);
>  }
>  
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
> +	int ret, i;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	ret = luo_ensure_nofile_limit(MANY_SESSIONS);
> +	if (ret == -EPERM)
> +		SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE");
> +	ASSERT_EQ(ret, 0);
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
> +	int session_fd, ret, i;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, "many-files-test");
> +	ASSERT_GE(session_fd, 0);
> +
> +	ret = luo_ensure_nofile_limit(MANY_FILES + 10);
> +	if (ret == -EPERM)
> +		SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE");
> +	ASSERT_EQ(ret, 0);
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
> diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
> index 3c8721c505df..333a3530051b 100644
> --- a/tools/testing/selftests/liveupdate/luo_test_utils.c
> +++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
> @@ -17,6 +17,7 @@
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
>  #include <sys/types.h>
> +#include <sys/resource.h>
>  #include <sys/stat.h>
>  #include <errno.h>
>  #include <stdarg.h>
> @@ -28,6 +29,29 @@ int luo_open_device(void)
>  	return open(LUO_DEVICE, O_RDWR);
>  }
>  
> +int luo_ensure_nofile_limit(long min_limit)
> +{
> +	struct rlimit hl;
> +
> +	/* Allow to extra files to be used by test itself */
> +	min_limit += 32;
> +
> +	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
> +		return -errno;
> +
> +	if (hl.rlim_cur >= min_limit)
> +		return 0;
> +
> +	hl.rlim_cur = min_limit;
> +	if (hl.rlim_cur > hl.rlim_max)
> +		hl.rlim_max = hl.rlim_cur;
> +
> +	if (setrlimit(RLIMIT_NOFILE, &hl) < 0)
> +		return -errno;
> +
> +	return 0;
> +}
> +
>  int luo_create_session(int luo_fd, const char *name)
>  {
>  	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
> diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/luo_test_utils.h
> index 90099bf49577..6a0d85386613 100644
> --- a/tools/testing/selftests/liveupdate/luo_test_utils.h
> +++ b/tools/testing/selftests/liveupdate/luo_test_utils.h
> @@ -26,6 +26,8 @@ int luo_create_session(int luo_fd, const char *name);
>  int luo_retrieve_session(int luo_fd, const char *name);
>  int luo_session_finish(int session_fd);
>  
> +int luo_ensure_nofile_limit(long min_limit);
> +
>  int create_and_preserve_memfd(int session_fd, int token, const char *data);
>  int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);

-- 
Regards,
Pratyush Yadav

