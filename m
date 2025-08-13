Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6DACA0EE0
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3py2ZGxnW1KzTtPwlJixqrQVe2NX7ix/wKknq0CD5E=; b=X7OdPTLtGylVeBjmSnwTDBu8U9
	ibDKL7lNwhtgfnd1/udVAsee+GQZDHZze8bd/qAqkB3D0rsL/jZnFNCiJXWseHBTlbVpkIX2esY3K
	TwQEkJIrdxkMx7QCb2itJt024rosFLZc3vRPykBdcrezMBRW4jPw4rCRKXBJEBFG/EiK+PGcXmVrD
	YNXatN9GJ8w4P8bHOLgPbX/tqgTD8exuIgSXcBarq9tbUb4nB0mbayrXw6MOS/Mfmxy8IZ6HgYDIi
	0XrR3OvrAdnw6ayBpcWexUbDtFfqsMPvjS5cuPZ7wVMTwB3e28dilenDJEdukUdbL+3eqgVsHriXs
	6pYXlqFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umCMN-0000000DtZ7-0iz7;
	Wed, 13 Aug 2025 14:21:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umBs4-0000000DoxL-1GHN
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 13:50:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B5311601F6;
	Wed, 13 Aug 2025 13:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55C5C4CEEB;
	Wed, 13 Aug 2025 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755093027;
	bh=kgmkNi4FyNWpSQEulVVTL5fLq/GrDqNglBvivi4oPyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q1jN/zVuEQN2ad0P6Qcr4DZUk0jFORaWGUNrolSM5KKUqK63TaPvDhJVtIVYe0D1w
	 qCq8wEOB4s/uDY+53Pfn1RZrIx6V9QRLiidfV5Px7squI22fCWtmzueIZq2oUVcrOC
	 tsFHaGFK//++3BHNyUpKyw11Q6V7kGH4aywuYJ+2Ytw70Dn7Jbb99ItrBO5uRekayL
	 J7WqRF5gUpjt0Fq2NaoTWwLEFETn46ES66Gv39ippaXcz04SyOd4+YyAaFGjlIz/xk
	 MBthNFb0RZcrhkNGJOHtCF40JG5hew93XfGeXYK58xszMcQaefiEgTpiYUqc5Vsa2d
	 RijdHjK4FLGuA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,
  Thomas Weischuh <linux@weissschuh.net>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 2/3] lib/test_kho: fixes for error handling
In-Reply-To: <20250811082510.4154080-3-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
	<20250811082510.4154080-3-rppt@kernel.org>
Date: Wed, 13 Aug 2025 15:50:24 +0200
Message-ID: <mafs0y0rnuy8v.fsf@kernel.org>
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

On Mon, Aug 11 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> * Update kho_test_save() so that folios array won't be freed when
>   returning from the function and the fdt will be freed on error
> * Reset state->nr_folios to 0 in  kho_test_generate_data() on error
> * Simplify allocation of folios info in fdt.
>
> Reported-by: Pratyush Yadav <pratyush@kernel.org>
> Closes: https://lore.kernel.org/all/mafs0zfcjcepf.fsf@kernel.org
> Fixes: b753522bed0b ("kho: add test for kexec handover")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

