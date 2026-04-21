Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F883F89252
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fOVhWn379rJaJvK6pUaaSJtAPJheIjl+VWuC5JneF4o=; b=oGkGhv8mgCIA6UwDPErsU4+H+P
	xOtbFjfpA218pvXxSKrVknZvOFsCbU3Oeu9f/gDekWSP9jAbM5gYGto2QJiXkIN0QeRAyS89GVR8O
	LFpFwdUUfpo2wGN/nLhKhTCvJ5Q27VXWTiZhN+MP6rcMdksHKJ8livdUj9lVpKx1bIpefjsfA4xYD
	yKjLJ7j/aScjQZ85tZhq9MYSttG9sBUdhpCUh8GSLEqvGcFaNUvJxKxubrJa1MEO7ICKtEufF0YTq
	sJcW9a7YYVKCWCJSUSnLs70jQ9c3xTN+LRlp8jIs+UGUXF56arAjgjM5KsRGCBnIcpBYLTUd9YzJt
	4C9OLw0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Qn-00000008Rxr-1vqf;
	Tue, 21 Apr 2026 10:34:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Qm-00000008Rxj-2Dkd
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 10:34:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FB3960133;
	Tue, 21 Apr 2026 10:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585A9C2BCB0;
	Tue, 21 Apr 2026 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767651;
	bh=ohwc7f4xvLfkQrWbOMULG7DqY75uoI42N8YjYFEYjwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNr3cg9eZIJCPpOfr3PFQwsan4XWF3084HZ1dnOQwDda2m94gnDjdXzMlCL89paI3
	 iuU0cx+rB0ztcu9+5GfUBWT9QJUz16ys29akaZEu6SAXsrfq7yFLiMi2opOt4zpUOv
	 GmwGXRmErmI72VWdP/W/q34JAJbnHBcFRgGeJ9lP1AXXOQnFNBxa4o5fS1X3lAeEPP
	 lEgqoyN6ob22X0EcKohnaAmJkWR4pcvdazKl091Q438nUXyr/aM1Q82bhbRUBpmwua
	 O+W1WFR/gKCCs4y7+sdM1txK3R9PMa3uAPyZwRadgBQUZArycZpaY3E2xdnktDu0Nq
	 BEtO4NGuD9RxQ==
Date: Tue, 21 Apr 2026 13:34:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/6] selftests/liveupdate: add test case for
 LUO_SESSION_MAGIC
Message-ID: <aedSnGnrXwTuDUGX@kernel.org>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
 <20260420141741.2688371-5-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420141741.2688371-5-luca.boccassi@gmail.com>
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

On Mon, Apr 20, 2026 at 03:15:12PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Verify that fstat works as expected after the switch from anon_inode
> to the new magic number.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  .../testing/selftests/liveupdate/liveupdate.c | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index f0a8e600c154..5e99af0cc6e9 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -22,9 +22,12 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/vfs.h>
>  #include <unistd.h>
>  
>  #include <linux/liveupdate.h>
> +#include <linux/magic.h>
>  
>  #include "../kselftest.h"
>  #include "../kselftest_harness.h"
> @@ -387,4 +390,41 @@ TEST_F(liveupdate_device, create_session_empty_name)
>  	EXPECT_EQ(session_fd, -EINVAL);
>  }
>  
> +/*
> + * Test Case: Session fstat
> + *
> + * Verifies that fstatfs() on a session file descriptor reports the
> + * LUO_SESSION_MAGIC filesystem type, and that fstat() returns consistent
> + * inode numbers across different sessions (shared singleton inode).
> + */
> +TEST_F(liveupdate_device, session_fstat)
> +{
> +	int session_fd1, session_fd2;
> +	struct stat st1, st2;
> +	struct statfs sfs;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd1 = create_session(self->fd1, "fstat-session-1");
> +	ASSERT_GE(session_fd1, 0);
> +
> +	session_fd2 = create_session(self->fd1, "fstat-session-2");
> +	ASSERT_GE(session_fd2, 0);
> +
> +	/* Verify the filesystem type is LUO_SESSION_MAGIC */
> +	ASSERT_EQ(fstatfs(session_fd1, &sfs), 0);
> +	EXPECT_EQ(sfs.f_type, LUO_SESSION_MAGIC);
> +
> +	/* Verify both sessions share the same inode number */
> +	ASSERT_EQ(fstat(session_fd1, &st1), 0);
> +	ASSERT_EQ(fstat(session_fd2, &st2), 0);
> +	EXPECT_EQ(st1.st_ino, st2.st_ino);
> +
> +	ASSERT_EQ(close(session_fd1), 0);
> +	ASSERT_EQ(close(session_fd2), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

