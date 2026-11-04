Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800F606A335
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GP5YP1VY;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=b2vNlAUP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KRXI5AlbB9KpB+65wVIGCYZD4BhZazr9WIMOqzWe5bM=; b=GP5YP1VYohZWBU
	x5nJ2+YesPICx8OMlwxz67mRoAAKbyTRcZn0rwbrqv+IX0c9YzbalSWcXVuKQHNXB+hYaTrzvxgDg
	IoIT8sUyiTeWtfbx2EIkZZxNVv8pgK1JCEuCw7B62fnlZPoAa4W3IwcRS+rLGXFqTcwe0RXby/Qct
	a2YhOo8Y3NJE2DQ5hBy1h7DCmOJkrjlA+jlTO0QWBaZxDUKThP0kveI0CzKsbbWM2yZUckf6q1lG5
	FMu5ntvAk9UX5MvIzxI/B2Za1cu1ut8Ik+q0fhuPs2lrJQyGeuhblGaDnLYbLRUrNHBGMGp9l4+UL
	GE4Y+8UHJAWkJv9CguLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6d-000000040pQ-0bT0;
	Wed, 04 Nov 2026 00:43:59 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6X-000000040or-0zzk
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 00:43:55 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-9908c849564so48205241.3
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 16:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793753032; x=1794357832; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KRXI5AlbB9KpB+65wVIGCYZD4BhZazr9WIMOqzWe5bM=;
        b=b2vNlAUPyxhu2L18DsJfcnup3G612KaLCBa/y4K2E+kMlQjX/OgE479g2MxXIHOMbt
         6+fQqjZIrw+x6ux+Gyjv0yS+RuB7HQ7iOpOKJc15Zod/6+bO8b5kw4d1VcS0packirXW
         OK4RakzMi6mA0IeDu8wS6jygCGCG6wTnpcWEMROG0fkcXweJ3/v3SE5yvfpd5FZy6Soe
         Ou7vcv1rDbGuEl//1o5Gn6zMOs6rHjB33kOL+BT4Wfwj4b+3gYOMT4OG9Tp0VPAXkgV+
         MeBln/cEBj5w7b7fZvnPhllRkrnKGLl74P2nJuVo8MCPBVPbvpA0HTZn56CfdW/8WWnx
         bqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753032; x=1794357832;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRXI5AlbB9KpB+65wVIGCYZD4BhZazr9WIMOqzWe5bM=;
        b=Z2gRZA4c6BhWRLL9EY8ClbAOAup3/5gIk57ja5sp1GZlbUiWVUccNASm+lDpugWZ0K
         n6uTu+/CT/8aB+u6HOBQmJ0zKJ22/zkOwQWMeZUY7qm1u0PxzMRIimPaw9a65pqAHbde
         n3z8M6Ci2cEMl/pyQd+2ShttMlOyydMAUW3GYufjPc6s5J4oNi3n8cP/3PmKy6U/LNgV
         KhCmaINCRmJGFRElgwpXyRuM54nSku8SUYgfJPaM+CCvubbtvOv+M6+OdSYw3jxiKnOe
         jDQ5Qp9McNojaaF5eEy7n/2V8iL6vTOsXJY+VZm5C95lE89/TQj7lWorzzT3gQkTUat4
         SPIg==
X-Gm-Message-State: APuU4Z/gfbHqfw4R/Wl8KSPEetojmSVw+MLgCvZPCqmOPMufgQ4KcFNi
	2PkozJBwEE+mdAsf2vC458vN7BI+OZeS6csnn7gxGYFEWpwBUKlnuAnY4+J/9Pj4rTA=
X-Gm-Gg: AYBFou0CnpBatbLDRcQvJvs8xuYHlmaM+0GFHjXm9o/pCQ9+DSI46XvgwBrfjt1zj69
	BFb1mtYwN3NYj21kIPFC4NBASH3FyBS9TNoqLTZm744KZEy3Mz/dJ7eylaLgdlLHsC+duKMc2Bj
	LI8wOyuDX8mRfHNO9lUabCOa5qGGkar2dvrCPGid/RpvH7yPfjopaQ2yrn3gx19OOX7YKkk/kl2
	YrMxmrk/uIk6H52UHLlBfs2pg5IFWsvIMVXlRjv/sFTzaiuUHBp5aUOMLI6Pz3cNRdsbxHzO7hg
	1Ri4vuOT9Fd8oLRkIRPj7TCute6x6gvooOA+vjg/yhf+rqiFkLQQMYUEreueeSUQ0hlGjldBZCn
	gE1Z9R3wC3HUGKAEA5KjF3FI0NvfBm5jsXh6xPYuFeFBgBCJUs0yN2FVlbUudrGGnV6Ehpd4iWE
	HC/5ngcc9amRaueerbW7k8G/v6Pf8wzYuqkaDLDkrMP/1WX/6f53eQiK0v3LB4l88UDtH6UR69G
	P0W6gW8DAgNTFpoE1GGu4x88QMkXaUiLpQFpBiHzQcGMv7PjMW0LS9q2pe/kLVEAKsWxljhE6FT
	65xICEHaOvswVF0VJ9M+vn6CcLBjZszIFaFA8jdTMo51G1hLqXtQueBH5iRTjKtmfior+KjGuAh
	u+vrhj4F5lSYUWVEydhScKegjWInf3Uhi3PmimtJOdpqU
X-Received: by 2002:a05:6102:4a53:b0:7d2:76af:fcce with SMTP id ada2fe7eead31-7d276b006bamr791137.9.1793753031752;
        Tue, 03 Nov 2026 16:43:51 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm527432137.11.2026.11.03.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:43:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 07/10] mm/shmem_luo: Retrieve tmpfs files onto a
 tmpfs mount chosen by userspace
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
In-Reply-To: <20261103010216.3447716-8-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-8-dmatlack@google.com>
Date: Tue, 03 Nov 2026 19:43:45 -0500
Message-Id: <179375302574.727293.14537040566857910268.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=vqAe2yDDLEwKgdF25FVv1O+wpJlIipaSEL5hDK2VqOY=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6n/ET4OO45vZ6StOR902DLzVLY6Bj7770P8sb
 nnjgwQuckuJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaup/xAAKCRC7dyhM23N6
 3jnJEAC0kky9VSu9xkI04nj8RiMbjwZNaipgbM8c84yf/wc4An6yU8htiqArYikDHsF3LbfOPIu
 ZJUI96h+M87DI496Gg92JK+uzFrY3uJjoyYr6us6+nUjcMcRYRWUS14WbhTxF7LoVgCU7SpDi1V
 MK7oieNjQXNfVgW/NL+Slwq5olNJUkvSgPFiAU8xQjVJxJHLYJmIJIXxc5vrbOVfL7YzAy7OxvD
 NuTg0ha8GM19+ZVxhZjYxkwGpmHD/eqTqJKoDVST6z17DZBoHHTbkpvXEHEsHmPCJhdTnBwejzX
 hbQEnk5/nzD5A3xC2edrsjyws0b8KclIaBJ4mNo4RtHUlelIO/ETzlvNcSmgpx/32KI74IwNr0z
 V4G6BxZrPeQ2TvjDEOTsCOP/lKsVlCx5YHTZYdhgmlBgR//QxXA76UCWPPpy0P1U4kNlZyNH6XV
 e3oMwZs1iPhhtd9+roQtAfbc6IPf+TbFCwI0KxQyxKaJvIxQQl98TA9L1QxJK3Eu32Hg8sqs8ED
 afWk9iPUD+ACfrf9HgHLFHlyw6RWtNm1UGEI9lvbzR1iPJesYxMSuVxfAANKfyZIR1g/hjH50H+
 OTddQgi8QtOA6wOiO+tOIvWJWdjD706Y4+8m7qxO6a0u8szavw1N/NXcclT2ViuQIaOrPcVya3z
 1YbZ7UGOm90VVsA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_164353_308319_2A2C75EA 
X-CRM114-Status: GOOD (  21.30  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Retrieve files that were preserved from a tmpfs mount onto a tmpfs mount
> chosen by userspace, instead of as memfds on the internal tmpfs mount.
> Add struct liveupdate_shmem_retrieve_arg, which userspace passes as the
> retrieve argument of LIVEUPDATE_SESSION_RETRIEVE_FD to choose the mount.
> Record which mount a file was on with a new SHMEM_LUO_FLAG_TMPFS flag in
> struct shmem_luo_ser, based on the superblock of the file.
> 
> shmem_luo already accepts unlinked tmpfs files, such as files created
> with O_TMPFILE, and a following commit also accepts linked ones. The
> mount such a file was on doesn't exist in the new kernel, and userspace
> may want to put the file elsewhere anyway.
> 
> Model struct liveupdate_shmem_retrieve_arg on open(): The kernel creates
> a new file as if by openat(dirfd, ".", O_TMPFILE | flags, mode), so the
> file gets the owner, permission checks and security labels of any new
> file in that directory, and is charged to that mount. The kernel then
> fills the file with the preserved contents, size, position and seals
> before returning it, so nothing else can access the file before it is
> complete. Userspace links the file at the path it wants with linkat(),
> or passes O_EXCL to keep it unlinked. Neither the path nor any other
> inode attribute of the file is part of the preserved state, which keeps
> them out of the KHO ABI.
> 
> Pass the flags from userspace to file_open_root(), so that the VFS
> checks them like for open(). file_open_root() silently ignores unknown
> flags and mode bits, so reject those like openat2() does. Also reject
> O_PATH, with which file_open_root() would ignore O_TMPFILE and open the
> directory.
> 
> Keep the type of the file: memfds can only be retrieved as memfds, and
> files on tmpfs mounts only onto tmpfs mounts, so that e.g. a file
> can't be moved off the mount whose size limit and quotas it was subject
> to. Passing the argument when retrieving a memfd, or not passing it when
> retrieving a file from a tmpfs mount, fails with -EINVAL. Unlinked tmpfs
> files were retrieved as memfds until now, but nothing relies on that, as
> the LUO uAPI is not stable yet.
> 
> Like the other failures before the folios are restored, problems with
> the argument and with creating the file can be retried.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Link: https://patch.msgid.link/20261103010216.3447716-8-dmatlack@google.com

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


