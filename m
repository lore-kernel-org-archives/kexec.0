Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D98606B417
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m0pN5gfc;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cmaAuP8N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1E8ZwW2Eu8WYRG4t6PuIDQjLMNRBTfUw3ilSDjs1rRU=; b=m0pN5gfcWPBgCGSNFbMzwVM1ZS
	dGSkG8wRsOYtJqp8sFcTJh74prjyktySVINI5MWdFVcs9BXU6McjLm5yWqMerA+Yz+kK4y0HV6289
	vlVLTjDUhLMdxJHhkfjgRi4svkDvMRZBTiGokwqcGrIbBe4pTZWX2cgCeipMZc9ElIQf4hC1MZX6t
	MsCRdV/3NJ6VyYFpw5iwT/0nQgYMFxhjJzVwLnqKpqygVARf2k6xQU3w/Wh2YYmEq7AZkxVsVy99b
	jF66K8XFqGz5o2ZvVaxoAyg97yVarq0YgGAeB3HXn9ZwBkRxA06WXFIlVLGcKGngprbLUJYLB2IOx
	EdMfAkeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6CU-00000006RNC-2UnL;
	Wed, 11 Nov 2026 11:09:10 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6CN-00000006RGW-49l4
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 11:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1E8ZwW2Eu8WYRG4t6PuIDQjLMNRBTfUw3ilSDjs1rRU=; b=cmaAuP8N+P52iDtJVOwMGPU1Rm
	FqzHy98fPelH0mq8DY0owqaAxg/oEFesnLx84zScoPFheV2k7WVlrIMZiD+YqhJOtdi1Uad5BMK9F
	6en5BPWw+v3fE+/rL0Y5CGl2nlw31TWn7YIv55D9SZjD1cX3jcE0XFY9dru8/P/fJ9kxPBYu19j9r
	dQCRq3bb5gxvXhKwVOCKpAVuCo/ZyutzCT/zkQXD2VE5qDpt5OROuRuNhBFVcpEfNi5ysabYpZyI6
	NrlmK+fONZ1CyH6Ge32APS7qP0t5pyBN5b2pWN8ZWGxHWvL80WG44ipLS8WqhJtviyLV0r98zCRA3
	+B8IoyiQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xR6CD-00D8c2-2m;
	Wed, 11 Nov 2026 11:08:54 +0000
Date: Wed, 11 Nov 2026 03:08:48 -0800
From: Breno Leitao <leitao@debian.org>
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/9] kho: Reclaim the metadata page left reserved after
 kexec
Message-ID: <avRMoA8Hy3P6k72d@gmail.com>
References: <cover.1794383544.git.chris@chrisdown.name>
 <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_030904_054819_4D725E53 
X-CRM114-Status: UNSURE (   7.69  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:52:55PM -0800, Chris Down wrote:
> After a KHO kexec, the new kernel keeps the page holding the previous
> kernel's kexec metadata reserved for as long as it runs. It only needs
> the page once, since kho_in_kexec_metadata() copies the previous release
> and the kexec count out of it at boot, and nothing reads it again.

Good catch.

> 
> Free it with kho_restore_free() once copying is complete.
> 
> Fixes: 76aa46b9e404 ("kho: kexec-metadata: track previous kernel chain")
> Signed-off-by: Chris Down <chris@chrisdown.name>

Tested-by: Breno Leitao <leitao@debian.org>

