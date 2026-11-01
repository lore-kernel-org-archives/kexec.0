Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C660A6F66
	for <kexec@archiver.kernel.org>; Sun,  1 Nov 2026 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OozjHVpe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmGl7Wg9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=W87d5476muuX3/O8DzYP4tAKHPl6gp8nviee8ooqz2c=; b=OozjHVpe/E4N6d
	wzlyCDyyM/mvLvbcvQ9h+vX8+prq1RdDiQ8XDCDWsYiKi60KnOoTD8KEd1dceMRaN+hg1EAUJhnB2
	yPwfUMf0BawYt4ZMLoc9Leq+ZP/1DtQlVV9pYshQRufY2qu6/spLriuiQEyLvRjID4o5a8MM0tJU2
	S9cGWfEA/I6STzxsDzQHwJ9hQHvAey3YUa2HGrnb8LR23bFuQO2qELrG5A1l2QnDzFTxa5z6W+IZy
	uesk37CCtb+EWyNY3pEj4dfzoILjsv5ekub0qBsUfdAEbXM7fAKlXYGUtqpbaoF4SoZR1G6AowDJc
	sCR9ZPx3qTtA2Q0YiGbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdqY-0000000Ezf9-1MWq;
	Sun, 01 Nov 2026 22:16:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdqH-0000000Ez2M-0MdT;
	Sun, 01 Nov 2026 22:15:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 63140605CA;
	Sun,  1 Nov 2026 22:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED961F00A20;
	Sun,  1 Nov 2026 22:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571356;
	bh=W87d5476muuX3/O8DzYP4tAKHPl6gp8nviee8ooqz2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SmGl7Wg9g1RxLvPfW2dALi+8QfaputCLxqfCXXzYwQxYXBE+HvzPQgFDkM9HsWvTL
	 Xkkz0PMUmTmvi/9Cla9KrdHM8gMqSRVDrIS1Q2Awnl4sjtfhB9oKLuislGoFVvEj8h
	 B3b5eyTdD/3KWwfeuWkUb0b+N6f8Y8ngmSseQOZcfrUINE2oZehPMiqWOBxoVj7O9T
	 BRDW1sUwlnFaN3KWeyuMYiJv0qlIvtBeI6VC6WOVxEwu0HebGW+Scz5MniIlsKSd6F
	 Yy+z6qlaX0muqhV6dMFi4jyvg06S8qEnYCKjcUoFuToUfoPo6JQ/ZrhT1lyDNFTzVO
	 Loi5eGgGSeZJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0315838003B8;
	Sun,  1 Nov 2026 22:15:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] kexec: fix probe error codes and error propagation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <179357135454.2624073.2428991164390583415.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:15:54 +0000
References: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
In-Reply-To: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ltao@redhat.com,
 prudo@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 kexec@lists.infradead.org, include@grrlz.net
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to riscv/linux.git (fixes)
by Mike Rapoport (Microsoft) <rppt@kernel.org>:

On Fri, 21 Aug 2026 19:19:56 +0530 you wrote:
> While debugging a misleading error on s390x where kexec -s reported
> "syscall kexec_file_load not available" instead of the actual EINVAL
> from a kernel command line that exceeded the architecture limit, we
> found that some kexec image probe functions return -EINVAL instead of
> -ENOEXEC for format mismatches, and kexec_image_probe_default() has a
> bug where it returns whatever the last loader returned rather than
> always returning -ENOEXEC when no loader matches.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] kexec: return -ENOEXEC from image probe functions on mismatch
    https://git.kernel.org/riscv/c/2792b4b15f14
  - [v3,2/2] kexec: fix error propagation in kexec_image_probe_default()
    https://git.kernel.org/riscv/c/b7c94f4d0961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



