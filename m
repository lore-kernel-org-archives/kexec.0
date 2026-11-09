Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00319606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gu0wDepT;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htltHbUS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/EGlkjnTPXViKqQZVNQ5OhXpwdoUkAoPNRSYCRrjUm4=; b=gu0wDepT1+52z37CrEwrVfxEtc
	p/uVNt7wdiBE6JKlogGhajY9FUHl/TtYbhf538dP7BsoFDJI2JCgHBKeDO3pIDqCC4EajNQpkOQIg
	QmOVAqPPHweoWG9p1FB9RyCMh+cvXNCfBsfCyWLQ4d7AUm1OVRn1OJvqoYe8ux44/7e0FFperT476
	EZrCJ+v+eN+0lTinWp3rfIN/IrbwmPJT13672QjtV1yrk2kqbG6+mLgn0QXqglj8cOM1BTWvOhqT5
	z52mgP1PvuUuoVovb5G1AEweIxMrUKd2vovjiBmzpVAawZOaeSJmFf/Qhs/Ivs0fFKZco9LCS0myY
	BqHNoZEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNS2-00000000Vez-2Otp;
	Mon, 09 Nov 2026 11:22:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNS1-00000000Vet-0XEv
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 11:22:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 42F28613F9;
	Mon,  9 Nov 2026 11:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931A91F0089F;
	Mon,  9 Nov 2026 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223332;
	bh=/EGlkjnTPXViKqQZVNQ5OhXpwdoUkAoPNRSYCRrjUm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htltHbUSacOuNqzjJ9rauWTrqcdykKX6USyqFGrUK9Xsa38SnEMQxb7T/ZjiCXkEa
	 Q3m4xjJ9yNTSt0qsBs0OHMh2c3NiQTo/IkQbsECjBb82KMmTcgAvO/htFjpHzCaGRE
	 Dr34Ia6Ph2F0gzzJYkwD9mERLqFmcNp0qIXlhazhqzYMvO6QdiHSxnhmhYnRS3wVX7
	 aMdc9NiJL+XVYIbIVwTb5UEWJUq9mHr/u/UYPehQ14rEs0B4NUXfyGGzQsJQACdAUa
	 SvBWUQdAlhi4419n9w5EnjfN/FsofQ4t5bL/MY/OybcPVK/0yI0aCReWdGkuwdNUco
	 TSHC0IPQ2kIDg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v4] memblock: don't allocate new reserve_mem regions on a KHO boot
Date: Mon,  9 Nov 2026 13:22:03 +0200
Message-ID: <179422331231.3350534.16388829888932023722.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109075733.9051-1-azpijr@gmail.com>
References: <20261109075733.9051-1-azpijr@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Mukesh Pilaniya <mpilaniy@redhat.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Mon, 09 Nov 2026 08:57:25 +0100, Jose A. Perez de Azpillaga wrote:
> On a KHO boot, a reserve_mem region that can't be revived is allocated
> from KHO_NOPRSRV memory, which includes the bootmem the next kernel
> boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
> then fails:
> 
>   WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
>   failed to prepare memblock FDT for KHO: -22
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/1] memblock: don't allocate new reserve_mem regions on a KHO boot
      commit: d9a27fa1050902a6e38bdb780b0277cbf1dfa5a5

tree: https://git.kernel.org/pub/scm/linux/kernel/git/mm/memblock
branch: for-next

--
Sincerely yours,
Mike.


