Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCCCCD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ltaXiFoo1nairUBpGpJ8j/GAOTH4OfEDT0rk/sDRyic=; b=zzehIEQJ4n/j3M4xKo5ZfV8/lF
	yeZQUlfdbJEEHIOh5NxXKjuLWPDzQkwHeSXImfZ8s7iMHbTDrFRaSB3g8rwWbbq5HFawVlo+Pzxuv
	d5IBxV9PyQ4B0N9uzkt0sADCG81xnfVFwRnP9tRKKgBMunttCyhoQfmtS5sBAWQsL98trE4M+9D+z
	/Y2rYzEYi9GzKi1lIaCqzP8XMwo6DeMExEEiM9g2hApXMhDOlagD6AFbJcHJbjetzCgOUS0D1GS8e
	YFb5lGfuiBngCiSWcOLXH7q/eMJX6g28kSyJ8wcs+obBU6/6EtlG6SznH9+4numtlQqJPJukecOuE
	0Un0Uppw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Y8-0000000B6Hm-3XfM;
	Mon, 01 Jun 2026 12:15:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Y7-0000000B6HV-027I
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 12:15:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B05B6001A;
	Mon,  1 Jun 2026 12:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7B11F00893;
	Mon,  1 Jun 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316118;
	bh=ltaXiFoo1nairUBpGpJ8j/GAOTH4OfEDT0rk/sDRyic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LrLGr0LC0lZ73GBlsNqoWTij/nowRsxj8FcJtxGy/x3vJbBGSFfxhCHJ3TMxPXTMT
	 0l/fsBT3+ZQ6P1KG7wGVm9h3EuXxXAZp8vIPj5l5pX6Pr+anZGp7Hh3nhmvIp3TTvk
	 DS2+wYZwNDCpfNg4pLx83G4y+Kxtmn5QvYwDxqAAcnhoV3TNbztDhfedUzdD02y3ff
	 3mAMVOGycckc+PHcLi3GJuwhqiygfQDjtvAT2rWr5vEWcJ0GudPJVLdh7MDzWWmAU/
	 YjJi81zfqwBHk7JorK+28N/GZ3am1L1UaaB613UCfuge+P6IY51C0aZlpR1PWWIK3K
	 eucUyEKcXQ5wA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 02/13] liveupdate: avoid mixing cleanup guards with
 goto in luo_session_retrieve_fd
In-Reply-To: <20260530221938.115978-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:27 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-3-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 14:15:14 +0200
Message-ID: <2vxz4ijmh2y5.fsf@kernel.org>
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> Refactoring luo_session_retrieve_fd() to avoid mixing automated
> cleanup-style guards with goto-based resource release, which is not
> recommended under the Linux kernel coding style.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Perhaps we would be better off moving to FD_ADD() at some point, which
should make this a little bit simpler?

Anyway, this patch is still an improvement, so

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

