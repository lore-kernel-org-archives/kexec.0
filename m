Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD2606A33F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WRAvwSYZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1IltH/h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4ChK0INPk67gm1yU3y9ycjg3DavhKidCa/NOKnRXt3E=; b=WRAvwSYZy2jrfLkEfNuqcz3ir2
	iz7KwDPFskiFADujWPAYYHOmbBLaYa7l/JWleYTmZh80GFv+z2EzAh+gDT3HLVsmGnQrTnZVRYXWP
	Tlcwk+4hHVcB+uhFDP9+r8V17+31pa39dST0V4SKk5JQslug/U12zkbXgjUUxrKC9Owgybq0sfiGU
	1IYTWqHa3SfsoUS/3tslhex1blVrFN464DVGbdgbVDKzxwu50EGb5dk9t8Gixk0yQKqy1suxbFrgy
	5ofTgMdQLloblXBfB+UBNccXHyE7Lir3tTtF/E9jl+d48hKMGL1r9Fflnj2vYGuCD4z14T1o8dIfI
	ZLT0ssCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeKc-000000067hA-2DJw;
	Wed, 04 Nov 2026 16:59:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeKb-000000067h2-0sPI
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:59:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5ED5B60609;
	Wed,  4 Nov 2026 16:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768EB1F000C1;
	Wed,  4 Nov 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811564;
	bh=4ChK0INPk67gm1yU3y9ycjg3DavhKidCa/NOKnRXt3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e1IltH/hwj2W3cR9SklfIBuPpiVdyAm/FwepfN/AbRq+r8/IbUR3jqQcUVHkVJ80C
	 06+cz8P8GC+/B3dQEvITq/W+IOwGtPORC1nuZoa/6OKutaQGnsh83PiXBnA9hes95x
	 EPqBgYzbCWN4QjyuZGXgMfRbQEIim8rvmmPr5uktGj+13/5AvaJJHw4UbVjaULZ2tK
	 pCDl6L1xa5eInJrm6UBMG3QojaQTUDyGKuWXwm1yAFbOvEUusx9/f9j6sGLzm20Ogf
	 BAEVoJuBMkBD9xBLFsEL4PZKuRi8DEIrQC6f5DA4taC8fdjRcHOrNyLQw38Yjcy+9r
	 5OL6kcEsw/Fyg==
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
Subject: Re: [PATCH v3 10/10] selftests/liveupdate: Add a test for
 preserving tmpfs files
In-Reply-To: <20261103010216.3447716-11-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:16 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-11-dmatlack@google.com>
Date: Wed, 04 Nov 2026 17:59:19 +0100
Message-ID: <2vxz1p90jzx4.fsf@kernel.org>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, David Matlack wrote:

> Add luo_tmpfs, a kexec test for preserving tmpfs files and memfds, and
> for retrieving tmpfs files onto a tmpfs mount with struct
> liveupdate_shmem_retrieve_arg.
>
> Stage 1 preserves the source files of each test case. Stage 2 runs
> each test case in its own directory, with its own tmpfs mounts, so that
> block usage can be checked exactly with statfs() and st_blocks. The test
> cases cover:
>
>  - The restored file: contents, size, position, seals and holes, for
>    linked and unlinked source files.
>
>  - Creating the file: it is created like with open(O_TMPFILE), with the
>    requested mode minus the umask, owned by the caller, and not linked
>    until userspace links it, unless it asked for O_EXCL. Also O_RDONLY
>    and O_WRONLY files, other open() flags such as O_APPEND, O_NONBLOCK
>    and O_CLOEXEC, read-only mounts, and directories that the caller
>    can't write to.
>
>  - Preserving files that can't be written to: a binary while it is
>    executed, through a read-only fd, files on read-only mounts and
>    superblocks, and immutable files, including sparse ones, whose holes
>    are filled. Preserving someone else's file that the caller can't
>    write to fails, and so does preserving a file through a write-only
>    fd or an append-only file.
>
>  - Executing restored binaries: a restored binary can be executed
>    before the session is finished if it was retrieved with O_RDONLY, but
>    not if it was retrieved for writing, since LUO keeps the file open
>    until then. These test cases execute copies of the test binary.
>
>  - Block accounting: the file fits a mount of exactly its size, and a
>    large folio that extends past the end of the file is charged in full.
>    Running out of space, or hitting the memcg limit, fails permanently,
>    and leaves nothing charged to the mount or the memcg. The session can
>    still be finished.
>
>  - memfds: they are only retrieved as memfds, with their seals, and
>    files from tmpfs mounts only onto a tmpfs mount.
>
>  - Interactions with LUO: invalid arguments, which can be retried,
>    retrieving a token twice, and outgoing sessions.
>
> Also check that the size of a preserved file is frozen, and that the
> test doesn't trigger kernel warnings.
>
> Enable CONFIG_TRANSPARENT_HUGEPAGE for the large folio test cases,
> CONFIG_MEMCG for the memcg test case and CONFIG_TMPFS_XATTR for
> FS_IOC_SETFLAGS. Those test cases are skipped without them.
>
> tmpfs quotas are not tested, since the test runs as root, which is not
> subject to quota limits.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/liveupdate/Makefile   |    1 +
>  tools/testing/selftests/liveupdate/config     |    4 +
>  .../testing/selftests/liveupdate/luo_tmpfs.c  | 2055 +++++++++++++++++

Umm, no way I am reading all this...

LLMs are great at generating tests, and I'm not saying there is no value
in this. It is just that this massive code dump is unreviewable by
humans. It is also unfair to the human reviewer because it took many
orders of magnitude less effort to _write_ them with an LLM.

What do you all reckon we should do about this? Trust the LLM to get the
testing right? Do we give up human maintenance of tests entirely? Do we
do fault injection to test the tests themselves?

Or do we make the tests smaller and more human reviewable?

>  .../selftests/liveupdate/run-vmtests.sh       |    1 +
>  4 files changed, 2061 insertions(+)
>  create mode 100644 tools/testing/selftests/liveupdate/luo_tmpfs.c
>
[...]

-- 
Regards,
Pratyush Yadav

