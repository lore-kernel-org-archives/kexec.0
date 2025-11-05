Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CDDCCFA0D
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DSYtVYesPT+uPOSCEtsHnwsEoSoALSXmDXfYkOu/A/M=; b=SMaB/AE9ANR/0zoirRD0nxX6/O
	wlHHx7zhOFmCoqs4AZGTZvmuj8E/w+5q1gcUxKPEUfuIrwX/WrViOpVJvbJcX8FiegCvv4EOwAQDg
	Ib9/gASMKihZhTXj9vVy6S2WbsfdarcEXBxjj5AMdC/vLTSayKrhi4an/me2p6SniHMk/AV1ZMN9B
	T8w57BoU5eK+5KdVBjW4Y78gNrXdbZ+tE1Rl8syagSkIi7TkR0tuLyDW0KQpRKUUsY5QCo9B+UTV/
	sIhXpln/L2RmfevheVw6g6/e5SB962BP6Oienjf6Wzey8OOf9QcsUkPY1zPU0nf9/1s1X1o3d0Ys9
	F+V8TgRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGa46-0000000DPLI-2esy;
	Wed, 05 Nov 2025 09:44:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGa44-0000000DPKJ-3OiT
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 09:44:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 93C3F40A07;
	Wed,  5 Nov 2025 09:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12BFC4CEF8;
	Wed,  5 Nov 2025 09:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335867;
	bh=f3wFnyn7p1ibiWpNXb4gDEfB5F9l6iHTRscnD2GSoXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sPcNwgIiiVHovHHsqHZmZAIiEIWadNXqW6T9n9yqfpChf6SOVyUkgo7HYHSyxc5XK
	 e8HkW+LZT1vumMdFE2XHx4eJi+BZFM855xUeVfMIKfHpIc83km7fyBsVz2TOBVYHiU
	 4tofgurwBmk0+3xxiVWrfFQoNDTXYvV7C3I9vz3zMGgssfMUSs0cHKyVNJ4NaUV3cy
	 8sb1DJJ0IPdIe4cAgKNPLsqczRGm0rkgm71t3HnD61LO2UVbqDnbJiPvMmoxkVuX4H
	 YUMH208nwqYPuo6tSUy3abEdcIFsQUbEFUzzJgT2EPKTPqvJrRxVahDt6HK2xoFWiW
	 p1TJe/OZD4NzA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Changyuan Lyu <changyuanl@google.com>,  Jonathan Corbet <corbet@lwn.net>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kernel-janitors@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend file entry in KHO to include
 subdirectories
In-Reply-To: <20251104143238.119803-1-lukas.bulwahn@redhat.com> (Lukas
	Bulwahn's message of "Tue, 4 Nov 2025 15:32:38 +0100")
References: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
Date: Wed, 05 Nov 2025 10:44:24 +0100
Message-ID: <mafs0y0okbypz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_014428_867910_8ABD8E55 
X-CRM114-Status: GOOD (  12.59  )
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

On Tue, Nov 04 2025, Lukas Bulwahn wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
> file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
> means that all files in kho are included, but not files in its
> subdirectories below.
> Hence, the files under Documentation/core-api/kho/bindings/ are not
> considered part of KHO, and get_maintainers.pl does not necessarily add the
> KHO maintainers to the recipients of patches to those files. Probably, this
> is not intended, though, and it was simply an oversight of the detailed
> semantics of such file entries.
>
> Make the file entry to include the subdirectories of
> Documentation/core-api/kho/.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

