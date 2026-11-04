Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA6606A334
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e0h3DZR9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVXe39cp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TbExPZxbTeMwQMvr6C5iO2LZTzsQVMp/KAjDfnAxAsA=; b=e0h3DZR9/kv7qDhtbTIMKpQMHw
	Hyh7HAPhYzqqm8hGlo3hOqWnxrpfLR08mc2C8DL76K1oJ1aTI5PWGPJaDT2QqBVBxFtcEWquhLQxJ
	GEL3Mdz+mkxiez+jFFZb4Fx4lttyXGGvaK+WpV5bunTf3XrOgCJYkktA8P5VDEVq4QZEaMsRnwcZh
	0Wjl0VUPBZ63KFaY0i/rh2Po355PXJVkLaurcDb881W9GIyUcokX42I1pciY9OHzELVKwmT4FL13e
	kGm13bkL4IHBuE4/gGKB4cXcP9LnmduRJ2QtNR5VFtY8M77gwNBwrV8vTZMKNavkrPi7qpfkXw6wf
	ysYKlDbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeE5-0000000677O-2U6p;
	Wed, 04 Nov 2026 16:52:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeE3-00000006778-2Vnt
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:52:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A96842E00;
	Wed,  4 Nov 2026 16:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863471F000C1;
	Wed,  4 Nov 2026 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811159;
	bh=TbExPZxbTeMwQMvr6C5iO2LZTzsQVMp/KAjDfnAxAsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bVXe39cpVVcLguYmk8EACqs3hMlDpO2DUlD9NW4R6vZdAbeUsJ2gAV5m8uPsX3MM+
	 uBLD2AhG1qjg2zDH6eW0xq6rjKOLzEgtecSyZoU6wJWL3DfMryw9p0hYVBXBgHvOW0
	 4wn524rxoxn5Nb6GNB/CGP3plpbD1hK8p8f3TLvF+Vmehn9dYVo7pSD94J41K2Zp6V
	 mCJHRVbjEPEUw0045ku4CI8dhVZ5A49Dk6S6igqBDQ6/yHy3CbUeqpXFqFdKTUuh9S
	 /zdY0WfTdfVJLSsrvUxXkeqmzeFlB5bMkIaNav8xtirU1gA2dMCPyRe4q4iM0yeBRK
	 aANSnFkLhO5GA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files
 with O_RDONLY
In-Reply-To: <20261103010216.3447716-10-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:15 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-10-dmatlack@google.com>
Date: Wed, 04 Nov 2026 17:52:34 +0100
Message-ID: <2vxz5wyck08d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, David Matlack wrote:

> Allow userspace to pass O_RDONLY in struct liveupdate_shmem_retrieve_arg
> to retrieve a tmpfs file read-only.
>
> open() requires write access for O_TMPFILE, so create the file writable
> like before, then reopen it read-only with dentry_open() using the flags
> of the writable file, which file_open_root() normalized, and drop the
> writable file. Like open(), which grants the requested access to a new
> file regardless of its mode, don't check permission for the read-only
> open.
>
> Retrieving a file read-only allows a restored binary to be executed
> before the session is finished. LUO keeps the retrieved file open until
> then, and executing a binary that is open for writing fails with
> -ETXTBSY. Being able to execute restored binaries right away matters
> when they are needed to finish restoring the system, e.g. to bring up
> the services that retrieve and finish the remaining sessions.

Can't you put all your binaries in a separate session, retrieve it as
the very first thing, and then finish the session? Then you can execute
those and retrieve all the other sessions.

Why do we need to support this in the kernel?

Also, please put the motivation as on the top-ish of the commit message,
and the mechanics later. For example, your second paragraph should
likely come below this one.

[...]

-- 
Regards,
Pratyush Yadav

