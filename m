Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF25CF8575
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 09:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qExihDuno7MaUro6s8FSJYa8KtjgfePenn0sjuTqV9s=; b=Vw3rZnQnzcoJogbLAAIEFCCCHq
	pWyq2oXGhC0uXstMLhlX/FPcBhXhHoLkc/ZfmPpaofrj+tEey+OsDq8GcB0GcSne1rzBBqDi9Nbjj
	ixM9075DG9H4UL2m+ZSo57BqJG0MpL9Po2m9s9owSDHNk1YSDrfkxOuDh2vk5rYULnxfdiKWAmR68
	/ww9RA7q+didBkn3XyOlQxLrCZ1JQ/IRBygqgSJ0+QUvcLC8B3cwMocfTIFi2DpZ+G531RkskEgeY
	7VXCVS8B1udN87ceo/SlOw8ETrBCwaeGX0tPWicZj+vzn+Hw4iTEADc+hSRt5lYKvEfRJWNn7uXLD
	odipGqig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM0r8-00000006Pd0-4BCj;
	Thu, 20 Nov 2025 09:21:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM0r7-00000006Pco-46Cf
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 09:21:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 263446011E;
	Thu, 20 Nov 2025 09:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69759C116B1;
	Thu, 20 Nov 2025 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630492;
	bh=qExihDuno7MaUro6s8FSJYa8KtjgfePenn0sjuTqV9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eu0rkwm4OBhsJQEJ00dt0+Lu8W7F8Xg4qqtuoQiXLuc7+DVYohnk+hBynpVP84HCo
	 6va4jxO0d2DFSzImL/zm7JxlR0CKNPehqnSq/KA27pgEZqlBnEgVkmRUzhkO6vKWsA
	 4zGwzDAiMNtewJneTXI2NcaND2UFiWBZCWdiO793ZNhKru4FzNo30AEq45vj78cSCI
	 U8Z/iDCQidE84ggxTX1yRdVvyUmgHxYRiPuWVeB6peTPUAfzzI1bTgxDkqXRV04Bj9
	 O0FibFGbf2QjoPt4zKGcP4tl8MKahPARfvWzscDk+GGESNDrjDIhszZIjM+rhvh6Fm
	 OO/SQekExeOAw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Pratyush Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Matlack <dmatlack@google.com>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kho: free chunks using free_page() instead of kfree()
In-Reply-To: <d41ce2d1-e353-4e5b-a17f-52d888a560b4@web.de> (Markus Elfring's
	message of "Wed, 19 Nov 2025 21:06:49 +0100")
References: <20251118182218.63044-1-pratyush@kernel.org>
	<d41ce2d1-e353-4e5b-a17f-52d888a560b4@web.de>
Date: Thu, 20 Nov 2025 10:21:30 +0100
Message-ID: <mafs0qztt2h5x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 19 2025, Markus Elfring wrote:

> =E2=80=A6
>> When the commit switched to using the buddy allocator directly, it
>> missed updating kho_mem_ser_free() to use free_page() instead of
>> kfree().
>
> Would another imperative wording become helpful for an improved change de=
scription?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.18-rc6#n94

"the commit" here refers to the commit fa759cd75bce5 ("kho: allocate
metadata directly from the buddy allocator"), not "this commit"/"this
patch". I figured that can be understood from the context and I won't
need to spell the whole thing out again.

I don't understand the technicalities of the English grammar so well,
but IIUC imperative mood is used in sentences that give a command. This
paragraph talks about a past event.

Anyway, if you have something better, happy to take suggestions.

--=20
Regards,
Pratyush Yadav

