Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9090606A335
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=noAZr18n;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izOZUxYS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=RvmTX8t5j5/IoltMXAdXZ4t6ouHAYznQwasZalqaL6s=; b=noAZr18np9YNqQ/Bue6U//E3x8
	z/e5zEwO3wzz4PjX3Dedztxt3gqVFS3BYw0L2Ng6FMOQwSSHmssPTTB/EiKgXI6nvBTnqOjSs5K8r
	4xs6PAv8vWmZlt3WqjJlt1ipLLr1pqRs/Jaqi5J7nxe1KYEzyWyDWmWN+c1z1UfFkQhAT8CG/LawH
	q0nlPusEHh87N3KsvjSwC7gsI5+w24VHVGKEirSp2RlxJ7a6+W0M0Wzr5UuK4fiQtnqmStTHxiP3J
	L6ZdCf0IgLbNh40Dk/OdqIuHRugIDw9jXa9VxgLAlThPGCJu0P1nRx6OecNWoLW1Z10aux7iy2KR5
	J7zElfLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSSNW-0000000H4fN-0eWD;
	Sun, 15 Nov 2026 05:02:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSSNU-0000000H4fH-0A4E
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 05:02:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F052B4372B;
	Sun, 15 Nov 2026 05:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59CA1F000C4;
	Sun, 15 Nov 2026 05:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794718926;
	bh=RvmTX8t5j5/IoltMXAdXZ4t6ouHAYznQwasZalqaL6s=;
	h=From:To:Cc:Subject:Date;
	b=izOZUxYS8HzrKJi/UTtmkSX1XsfKOfNT/yiOgTXLdnD2mb1BL2X5Y0LGXWS1HHELm
	 u5zNT/MvMnyq5cDMbRI+VExbc48PKodmpXx+pcb7xSEg3xoWvRxJtt4dGYjLL6O9s7
	 YM5O0UmhtfXCvw4ZKHKaesI0+OPAda34j10NsiEiSBP1cua2JuJGQAUXekQkSYyEMG
	 3n+6t+xGDvI6xfCthg7ELLZaNoJPC4i9v72Ttw6PT3H3cVrCAFWqcsgP2C7G4tEooH
	 52EdZ/htiGD5VY4UChDHYXH7saYSG/+F/XE0EgCNTNMZvxZugmg2YahDHt2zasdGpC
	 2UHhDR1omBYWg==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] kexec: MAINTAINERS update
Date: Sun, 15 Nov 2026 07:01:59 +0200
Message-ID: <20261115050200.1847508-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-fixes-2026-11-15

for you to fetch changes up to ab75132e99eb0b7dcd3a1882e35519f8229a669e:

  Remove myself as a kdump reviewer (2026-11-11 00:37:37 +0200)

----------------------------------------------------------------
kexec: MAINTAINERS update

Remove Dave Young as kdump reviewer

----------------------------------------------------------------
Dave Young (1):
      Remove myself as a kdump reviewer

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

