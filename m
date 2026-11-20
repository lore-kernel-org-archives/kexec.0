Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B9606A320
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DuOTBoYk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnhVylqs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K6Ek4iGcbq3vQ07GRWmSQBnPhMgNe+rY+J8oqtO23vE=; b=DuOTBoYkVaesO5tWNv+0v6gmva
	0uHHyIinWh7nHPMoeoOAITbWfgsOsKdQEfjoWZx0f0KeWEl45yVDOVaIt9o9//lnLyzyOnMPmz0nW
	UoRayZd6bZcNPBMcHmPEOKuFOtM7ZTXjWxeehZ+BzvPC+SXwoMm9vRWvtKeRgmwc8JF80GK/TLw0C
	DHrdZmqWd0q1cHTib5LtqSn9XDTYd/q2V/eDHfq/AZK/Yny8hYbd9aioASesy3yb/PyExZxdnTGOR
	LLjE4N6qTs1stO9VEnG0s8pYGYaygPj6QLcRPPOdXBH6m/Jjt0+sht+n+G2IxnTh7UQeuBMIxzfii
	/HtDKihQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUP5H-0000000FBrK-3izZ;
	Fri, 20 Nov 2026 13:55:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUP5E-0000000FBq4-3tmJ
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 13:55:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 256C361912;
	Fri, 20 Nov 2026 13:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0C91F000CA;
	Fri, 20 Nov 2026 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182919;
	bh=K6Ek4iGcbq3vQ07GRWmSQBnPhMgNe+rY+J8oqtO23vE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cnhVylqs5ES3JxvaYjPvjapckpsryCakLkf58K6cdu/yj6hEpK55l61/r5leNICKo
	 27nkXsy8zKUdCQYesScKFBHbzuGcGSMTih+K4Glwu9mkcllzFD6NIpLxeRhwpSbtMC
	 8Tfec7DkiYTiaSZiSkRmUJmpAOFLegUbO39jNFJfK+g4mT0xpEX0u8r1ziz2VFRy0U
	 gdAk5alXFHUQX3rzuWjGG9rreAoYk7Is3htWwhisfUatj5QU3Jwe0ghmm8AbUKx+GH
	 MNOwscOVMcGYsVJ/tbFp27qzAeWLDbB6s2DJ/r6JsLVSupBwX+z3TmQJqYkNS6URJ/
	 JYvAfbSkIEcpg==
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
Subject: Re: [PATCH v4 13/19] mm/shmem_luo: Allow preserving tmpfs files
In-Reply-To: <20261111002358.1842967-14-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:51 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-14-dmatlack@google.com>
Date: Fri, 20 Nov 2026 13:55:13 +0000
Message-ID: <2vxzld6n1ubi.fsf@kernel.org>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, David Matlack wrote:

> Allow preserving files on tmpfs mounts by dropping the link count check
> from shmem_luo_can_preserve(). The check was meant to limit preservation
> to memfds, which never have links. It isn't needed anymore, since tmpfs
> files are now retrieved into a file on a tmpfs mount.
>
> Userspace can keep using a linked file by its path until the Live
> Update. The path of the file isn't preserved. Userspace creates the file
> to retrieve it into, and can then link that file at the path it wants.
>
> Preserving a linked file affects everyone who opens it by its path,
> since its size is frozen while it is preserved. The permission check
> added by "mm/shmem_luo: Require permission to preserve a file" covers
> that: Callers need permission to write to the file, or must own it if
> its size can't change anyway.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

