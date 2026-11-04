Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D08606A32F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uBGuaFMN;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=aPKwl7S0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1jCvTwZL8MS+SjFAQ29LXN2yWrpb5Y2gngTvzYEqhZ4=; b=uBGuaFMNyC/58P
	VV9YwmXHDhA1rdrntBEfLAkT4Q5KJ43OAUqaehrAqGGwyl8GXXF3pxeyMIXHQIsL1yqU1E8J3E/M9
	6Xbtt8sZtV1Sm8L8b3BjrxKol9FdxbAm+F6D7/gndfXYJMo+l4NxGEzpNlATC9T6+FU17OzHgrwlD
	btlT6D/fj/CYTx02TeRoPDgkh3yQd3QXWFa65SjnAyUaR5Xk4lBTS3M6MG7P7rBmN09rzKURt2Lup
	UIKeZbaRA5pK+IPIp+jJy1Tjfgm73QfgFeYQfaXyY2T9973KfzbVesofyj+CHJnUrr7pO0B+dgxKx
	ywWdcJkiTX1BGeb1AOSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6g-000000040tY-2B9X;
	Wed, 04 Nov 2026 00:44:02 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6d-000000040qq-09mE
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 00:44:00 +0000
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-7ce77f98658so39125137.3
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793753038; x=1794357838; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1jCvTwZL8MS+SjFAQ29LXN2yWrpb5Y2gngTvzYEqhZ4=;
        b=aPKwl7S0pIoWSlgq8O6jxH+r8WOisEL0ApRNev7pAtbv6UdJQlM0TaXmvpvzr+wHDe
         0aPp/jY9jmi4LnG/ahHwiNDLyVRIlBqpXCCwFBMCmV5LkXy/A9CNtnJCdbMedtrIKeeO
         rmItwAOYabFcG2QM1wdeD8u/VsjgJVfbI44zglRH62/n1nMWKK6m6ORJFsgH7bboMMmB
         5JzL5qSYA1PlAo+VHPrGSEVbx7vmoxitGrSQVtVvR9UbPhsZdl8EQFhdma0g4OVottfw
         fGBq0K3p2E1iAboUr7zYS/M+G/MrQ1kHJCoUNzQq/ZwfLxAjlAZu5+UvohIYWM/sJwnI
         NlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753038; x=1794357838;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jCvTwZL8MS+SjFAQ29LXN2yWrpb5Y2gngTvzYEqhZ4=;
        b=cninOcExPW2MrNCb9wHHYjdKSXS9xCN10BkjG9u2h6kDf+y/b1d0FfXFVREjpFMwvx
         hhQOqro5DGYWcDIpT+E2955rikSXgF5qyQYAMskBvR6/KBvxSbH0MGjf0vEEzLL7hFif
         2iJa8LbfDIrwaQxwri6xQE3i4IWrfHuoZ8tPUkr+SB762bcugs7WpvhuH0jyURPvgw+V
         xLAJMM4m1jYy6BpSjjj6vgqRbssHRO3m6GoBfEa/0IEBnVHfyu2fwqMxeDJf2w7NzUE9
         1MG9D47AvKtczSlTa4jSpaj7y7ZV2Ut68ZVrTIIijC/DM0x1BNPo2XMC+AMeCkwpJgcL
         arDg==
X-Gm-Message-State: APuU4Z8Sy4xEWhIijngX1u5Beo8F/wZUpdkSnZaEved5U7JFR8WscUFF
	chmcnuvkKqFbZXXhyN3Nx9yKP75/VMzlovx6XRoBFbdY+ah+uWIJFxYYFkPUFwTJ9/I=
X-Gm-Gg: AYBFou3mSRRagV0HGF9qc8VEfs/iXfoon9R49URmAP10mliBuQRvjqZVZTaTgZTup+Z
	KdMSSeU4MVPBzgwwqwR3bYkpWAe1Y2B3veYvz8e9EgIRchtA1y79jg6qljElMl3/W9fvm49Hxjn
	RAYenNEg3ZBM6fLob/6h9W6RX0UWM6Z5iXrWffP5BYhxHT16paj8F6BQmaCEtClotwEm9QNOOAM
	ljgDf00l+6OdDTrVc+NUoIMPfX1aXbqgSI3RmiZJILPVpO5KbEdMSlos2lVX8dIeFE+pk8LeJRY
	Wk9gtoJHMOX29WvXD2HsdMcB3FOt6HIadO1J/DtNs7rHEdloJb+8SUIMfveYEJZOG68rO6x+NTz
	yYJLbyuYO4lDCc90+Q30EbV4O/xnvjcPHcX5J0gGpqK1U1Cdm5CsxxecCl77m0sDNOhQ0Wc35cn
	zrW8o9kQtbihbwOemDEicXAAR2krfwDzQPHoebUWXggDhgMJ3BhsvCDkAOV7uuspimnKpO9r+2m
	BEunzTw4KN+O5zZjoNBjPnC008KNg3iZlDra/wv9xCgo/+TT+s7dG410VvUMgO9RWGaP+yM7/Tz
	U4ioczqpS4zSybvoPgWlgxAXNhu+hOkpHz6HNx3bHGOSKtcY56l+zoIWMS/iKDCzioh5KE2PoTW
	h+qywVG9AT/dDbzWDADDrKmXP3JBSc8VeqreAkNOkCazl
X-Received: by 2002:a05:6102:358a:b0:7c3:a6f0:99cb with SMTP id ada2fe7eead31-7d072719913mr4878960137.33.1793753037717;
        Tue, 03 Nov 2026 16:43:57 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm527432137.11.2026.11.03.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:43:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 10/10] selftests/liveupdate: Add a test for
 preserving tmpfs files
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
In-Reply-To: <20261103010216.3447716-11-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-11-dmatlack@google.com>
Date: Tue, 03 Nov 2026 19:43:45 -0500
Message-Id: <179375302575.727293.18102345692701869647.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3188;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=1Sz+eMhTI1TOTbxgSk7ZOC8CrCJdIfx3Ze9Zg3ES4c8=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6n/FzIqSwYCXrxsnr7zksMS5TfAEmFOQUj9PS
 7XxUL7XYFyJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaup/xQAKCRC7dyhM23N6
 3nTOEACAI6TfigjjQvteQKuwVbfhXqGx6bxoozDfCeoenFpsOHHU2tRSPDHrF2LinhmG2pyX3Q8
 IdNQ59F6clZBMmDb/eOe07rYUzfUWj1TUdh5D/SLuP13olwOUmaakHONOrG2Uaporgy7rW/JvCo
 H2L7Jk9k9ONnqREnNjgeAzTwu/zmxI3kBLYcpoEe4e/qloHN2LAqn6iVZB5b6I/duQg+0sSKEgp
 qF4OBNh/aIA1foatwzOu597LOjO9yQGRV3iBJJYo51P6K86O3J78ymlKWGJLCLMOMPk2DZUnR8M
 jLp931wUPz3YeNyDlYE5pYInd4W0IpRLQkJs6piLRVQ/conGIWbGkL4KSSoQd/2jep3AT+iLZxT
 nQX3w7DUGKtNX41lNlBN5hBRLIL7IBK7aadPhrKz90SJNGH9ZPSeFVaGtwJRjGCWrPppwaO06yR
 VysyPyy9uNhOKJSHmwBYeXEJddw81NZYJIjeslUtu59vWS+R+q3usDK/yK5jNy6E0h6vvuwyhuI
 gmJeftNu95dEGsoOiTdU/+eZlCgissKpCpGEEx1LCEbcoV5iULkM6cczYHziRUNy4WEnse6TYs5
 JiM5brFJchE2M/+FwTTI00ZLZVJRSQ+PZmsg6nEdtwTUZDUhsHCd0cXftsjhObL8a8SsH7szZ7X
 ktyDeGGGs1LNQ6Q==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_164359_105631_38DE7368 
X-CRM114-Status: GOOD (  26.08  )
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
> Link: https://patch.msgid.link/20261103010216.3447716-11-dmatlack@google.com

Overall, I like the series. As a follow-up, it would also be nice to add 
non-kexec tests to liveupdate.c covering preserve/unpreserve/freeze and 
restrictions on various tmpfs files without rebooting. 
While that won't test retrieval, liveupdate.c runs as part 
of regular kselftest by pretty much everyone, unlike the much heavier 
vmtest.sh run.

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


