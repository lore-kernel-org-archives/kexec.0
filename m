Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE5606A891
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vXjaNRjm;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqzS3vcn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qYip/S6YR8HP6EPMfD+DO9PeevjFwxYNpr2ap+wiblQ=; b=vXjaNRjmdBt25r
	F8WFwlFDVJYUoZAviQCGy/v+Mi+spKyphpmKcO/sCwMP7msS2V2Yz4KHBAypre1GnhBjXepjUTMEk
	mJDJMOAXg/pog8nMvGWXJtOuuRlAx1iguh4Dh6fRLO/x0qiP5o3jgwYalrT3ruTwu4KhajIzBJY8R
	9QPcppJpBTONAYjonS0y5AI+PEpjDdUMAlZSKq9+Pu1fZbVMrZPRSeIUfO68YqGh5DkxUSuLFLP8J
	QJz7LChMDuALQ9zYugGFlz/g+zpsJGacPN2ZoBdrt4d9PhI9zT/OU22uPVPluY8nyhP27o2pugrq+
	eE5fVahliRDLrotaCRMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6M5-00000006T48-30nQ;
	Wed, 11 Nov 2026 11:19:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6M4-00000006T36-0VcR
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 11:19:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D9F18438B3;
	Wed, 11 Nov 2026 11:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333081F00A06;
	Wed, 11 Nov 2026 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395943;
	bh=qYip/S6YR8HP6EPMfD+DO9PeevjFwxYNpr2ap+wiblQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GqzS3vcnCAk7RcM9m0TvajMcoWIE5tsCDTZDcdpms/zdOpMd0QJB+8k35zijIKLZ/
	 9zMZaltBrIBk/p9iRKmL+q19QJxxJSkV3ewQwBIpTKZBwK9WP2DepzICMR5JH/Rfgb
	 cxRWRVFpuNsMg1wugipdX3i36sBiYPJU+Km+w1Sh3SlIyRUAbg1+kNi0/VRpuax7jn
	 kap/zpwjdpfDyIKPvnNqMuePwSyKJVfA2mFNJO6kaLwq8EuveY34RPGKhFDGjI5eJX
	 fjk3pYjwjTrr8JpqdZaWbLH3WZnmoPAcxQUEL9vzgasoinjwD/Iy2Z5AlIfhdD6xt4
	 GAckGa/L7Ow1w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 5/6] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
 vipinsh@google.com, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261105050053.3063001-6-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-6-pasha.tatashin@soleen.com>
Date: Wed, 11 Nov 2026 13:18:40 +0200
Message-Id: <179439592041.425130.6098227055493441109.b4-review@b4>
X-Mailer: b4 0.16.1-dev
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

Hi,

> Currently, LUO sessions are frozen automatically only inside the
> reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
> iterates through all outgoing sessions under global write locks and
> freezes them serially during shutdown. On hosts running multiple
> workloads that quiesce one by one ahead of kexec, userspace needs an
> explicit per-session freeze point so each session can capture final file
> state under its per-session mutex as soon as its workload pauses.
> 
> Introduce LIVEUPDATE_SESSION_FREEZE on session FDs to freeze an outgoing
> session early. The ioctl runs .freeze() across all preserved files in
> the session and serializes their metadata. Once frozen, no additional
> files can be added to the session, and subsequent freeze calls return
> -EBUSY. Freeze is only valid on outgoing sessions and returns -EINVAL on
> incoming ones.
> 
> By default (flags == 0), session lifetime remains bound to the session
> FD: the session stays frozen while the FD remains open, and closing the
> session FD before reboot (for example, to abort the session or on
> process exit/crash) unfreezes it via .unfreeze(), unpreserves its files,
> and reclaims all resources. During kexec, already-frozen sessions skip
> the late auto-freeze and are published into the outgoing KHO subtree.
> 
> With LIVEUPDATE_SESSION_FREEZE_COMMIT set in
> struct liveupdate_session_freeze.flags, the frozen session is committed:
> it and its FLB dependencies are immediately inserted into the outgoing
> KHO subtree via luo_session_publish_one(), and the session survives
> close() with full ownership retained by LUO until reboot. Once
> committed, closing the session FD (or another session failing to freeze
> during reboot) never unfreezes or unpreserves the session, allowing
> processes to hand off preserved state and exit prior to kexec.
> 
> Update the uAPI and core LUO documentation to describe session freeze
> and commit semantics.

Please teach your LLM to use shorter paragraphs, focus on why and don't
list every implementation detail, but only important ones.

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/userspace-api/liveupdate.rst | 30 +++++++++
>  include/linux/liveupdate.h                 |  3 +-
>  include/uapi/linux/liveupdate.h            | 46 +++++++++++++
>  kernel/liveupdate/luo_file.c               | 54 +++++++--------
>  kernel/liveupdate/luo_internal.h           |  7 ++
>  kernel/liveupdate/luo_session.c            | 77 ++++++++++++++++++++--
>  6 files changed, 184 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
> index cdd74627ab75b..d36537c556ccb 100644
> --- a/Documentation/userspace-api/liveupdate.rst
> +++ b/Documentation/userspace-api/liveupdate.rst
> @@ -22,6 +22,36 @@ change, so compatibility is not guaranteed when kexec rebooting between
>  different kernel versions. This is expected to change and stabilize in a future
>  version.
>  
> +Session Freeze and Commit
> +=========================
> +
> +By default, LUO freezes active sessions automatically inside the
> +``reboot(LINUX_REBOOT_CMD_KEXEC)`` syscall path, and an outgoing session's
> +lifetime is bound to its open session FD: closing the FD before reboot aborts
> +preservation and returns all resources.
> +
> +Userspace may also freeze an outgoing session explicitly ahead of reboot via
> +``ioctl(session_fd, LIVEUPDATE_SESSION_FREEZE, &arg)`` once it has finished
> +preserving and modifying the session's files:
> +
> +- **Freeze** (``flags == 0``): Executes ``.freeze()`` on all preserved files in
> +  the session under the per-session lock (allowing multiple sessions to freeze
> +  concurrently), while keeping session lifetime tied to ``session_fd``. When
> +  ``session_fd`` is closed before reboot (for example, to abort the session or
> +  on process exit/crash), LUO runs ``.unfreeze()`` and ``.unpreserve()`` on all
> +  files in the session and reclaims all resources. As long as ``session_fd``
> +  remains open, the session stays frozen across any failed ``reboot()`` attempt;
> +  at kexec time, already-frozen sessions skip the late auto-freeze step and are
> +  published into the outgoing KHO subtree.
> +- **Freeze and commit** (``LIVEUPDATE_SESSION_FREEZE_COMMIT``): Freezes the
> +  session's files, immediately inserts the session and its FLB dependencies
> +  into the outgoing KHO subtree, and commits the session so that it survives
> +  closing ``session_fd`` with ownership retained by LUO until reboot. Once
> +  committed, closing ``session_fd`` (or another session failing to freeze
> +  during ``reboot()``) will neither unfreeze nor unpreserve the session,
> +  allowing processes to hand off preserved state to LUO and exit prior to
> +  kexec.

Too wall-of-text'y, too much markup.

I'm stopping here until v6.

-- 
Sincerely yours,
Mike.


