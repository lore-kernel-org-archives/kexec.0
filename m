Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4495D0E6E3
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pgCxIYHEQfA22YGlPMxky8DJplHtENfEj44WE3j2M/0=; b=mbP71C6utzVQcQobiyvBXQCU9h
	N1Bg+ANjPdAAC+5s7B11kAo1EGihdo6DVB+oVDli94Bd8a//OXZE4x8fETvnj9YhFbsRuTIFAp47U
	t/hPnTn+VygKYnEPIpCFN78nRh+ApKVSDK+0DksqfL9/Gn9kzYbOjz+0qSDLFW1JsAmhA81FjsKTN
	dTtjHvVYUvuAABd8r5dv7cfGwYBNbMTuRS0Wvrr/HKCBH/pw+zh0RpVHg88dNbBaaD9T1NbJ06PTV
	40+KnyESkTv0gZn2n0abLl9wib8WBIWjdPsiWO/FdnP64uXa8uZbNUqz4YVrBkyC9q8nmI2KvjdX4
	EqwDm69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsw5-0000000DKcT-0UAz;
	Tue, 25 Nov 2025 13:18:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsw4-0000000DKcL-0bLy
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 13:18:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 866176011E;
	Tue, 25 Nov 2025 13:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF35C4CEF1;
	Tue, 25 Nov 2025 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764076703;
	bh=ZKegHKbW1uMjjAwWvKSDoAguaNEuYrZ9rTK5/L6/Z6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gV87SkFbYBCZWBffDjqyiYcNhE5TCFHDo9JNLCvrShY5ZfLRFzr08B+qTfWat9e6C
	 vn+O5sqHPJPNCaK2y2cHhC9cc++ZIuTkcosfQkEJ7fCG6xmis4yuEBROEr9QD45vpy
	 +4OshqdvdM0OJ3qb5TpzS58XgZSQnBmzVy9p4xOQ4PIwB72Kqn0DUG2buCAqjKSZzW
	 PVMDwGQZ7c19m5hdI2oWYy98Xw+M2/wDN+DzhiXbR1/kzSU7AS7RRQPgPP7XPlyOXE
	 MtMpeafjQ2oVCASU3pOGRyt6yFOMHkM7xy6ZXAQJZ8XC4lm7kTmCIAEYU5EX0fsYDU
	 ZSWg4jJLkzfrQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: kho_restore_vmalloc: fix initialization of
 pages array
In-Reply-To: <20251125110917.843744-2-rppt@kernel.org> (Mike Rapoport's
	message of "Tue, 25 Nov 2025 13:09:16 +0200")
References: <20251125110917.843744-1-rppt@kernel.org>
	<20251125110917.843744-2-rppt@kernel.org>
Date: Tue, 25 Nov 2025 14:18:20 +0100
Message-ID: <mafs0tsyiw8rn.fsf@kernel.org>
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

On Tue, Nov 25 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> In case a preserved vmalloc allocation was using huge pages, all pages in
> the array of pages added to vm_struct during kho_restore_vmalloc() are
> wrongly set to the same page.
>
> Fix the indexing when assigning pages to that array.
>
> Fixes: a667300bd53f ("kho: add support for preserving vmalloc allocations")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

