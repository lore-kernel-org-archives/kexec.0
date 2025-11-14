Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA67CE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQwUHs9mWvyDTTdNsueei2ITz9BbdtS8MZ3avVTDba0=; b=1IEnzXPTQ8VqyZnsoUN0tyf3Ld
	tGPE3xZ+TGNiux86jR5a9sPk5uLBwIIhTDSlC8KB6b4U2FnGN6AV2Q0JarUcvwNX0FOWBLWA58hEB
	xbVssjENKKkrTj03EPzO8zCAAOiyD9GWrtVOrbn98/Z4IETQWBOlPI0ulQoEccgzgpzyC2JOftk4r
	pXqq94JR8tETBWvU1obssbbM06vqV0JMPy12vqh9UJy61cocQmjSLbbyU2qavZtB8VV9AEA7D69wg
	ifxbQciSLjHY+kEVApbSBqQ/KGPnDTOctB0M82zoNJYqAj7GySLsNP17ZikRmpT1lUNOm8Fl+SKzN
	XZ+atlbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwjK-0000000CkMi-38Wk;
	Fri, 14 Nov 2025 16:32:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwjJ-0000000CkMO-01Zh
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:32:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 384276016F;
	Fri, 14 Nov 2025 16:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB46C4CEF1;
	Fri, 14 Nov 2025 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137975;
	bh=fy9goWnm4WyDrFh6uM2Y7bCHkbvkrMLy5j0RbsMDiTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VFeoJ6AE+ab565fJGL0NyGcL684TvXpyQDHI0jD/X4tc9MmYPcp8rhjUchr38DYrC
	 MlI2XwZfDQ+P7jMolPtXjOxmTwQQY8I7nvHAdffhTA2EMP65mqswANw4qJDeGRTyoh
	 dOMoEMNKxP24ISiCp3Sq0qKO+N9hkDgNU3n0l3DEeyOL0Cb/ydyjHxyqzPr1MeIO3b
	 QtG8Y8+hSi6VLjaDZu0KmoJb9ZhqJuk59kasYggKZrt+NI4Zxw6CeNUEGhUQg54ETu
	 2iIQHOl7RFQP+20PonMZKaD0vpTepVwssKwzQmTalxR6HsH1lHzEbccJJ+YiVmKE5X
	 RFrxGbK7LM1kw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 03/13] kho: Preserve FDT folio only once during
 initialization
In-Reply-To: <20251114155358.2884014-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:48 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-4-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:32:52 +0100
Message-ID: <mafs01pm08thn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, the FDT folio is preserved inside __kho_finalize(). If the
> user performs multiple finalize/abort cycles, kho_preserve_folio() is
> called repeatedly for the same FDT folio.
>
> Since the FDT folio is allocated once during kho_init(), it should be
> marked for preservation at the same time. Move the preservation call to
> kho_init() to align the preservation state with the object's lifecycle
> and simplify the finalize path.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

