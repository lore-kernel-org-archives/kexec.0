Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0543C61DFD
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gqj2K9+wp90YvEKZMSvL1LZpZwjNHSzCNuGCNxMefXo=; b=obiQek+46tUfhltTRD3XZjLHdV
	Y1N0xXcwk5JcPESvNsW1dDbmKtiE5Se+UfGCFVR4JnbsZezxOm1VeURIY8m3EJGxGdJCudeQmnl/I
	ZVoYnBz7mGPST6i0JbcScAH7cd/rE4Co0DdYz5iRAtKCIwT1jppFBh4rLF+wL3q+SOFQdpcA9vMX/
	h8jBRwffyzAthX9PgNnMH8lA2Ftbsi7luP3QW8ipsZ1EFXGoeUmsug689TW9gom801/Tgd2SUvk92
	f5D/Zr/LHmi2wTkZBu+k8vxG/arsQZVm3Y9bGrx/vWJD6TRi2tFUZj7iDALKrzzgXyt6GIHdM6kjl
	YHX3vSvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x10C0-00000009Aq5-0BDp;
	Mon, 31 Aug 2026 11:28:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x10By-00000009Apx-1G56
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 11:28:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7ABC960218;
	Mon, 31 Aug 2026 11:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1151F1F000E9;
	Mon, 31 Aug 2026 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175725;
	bh=Gqj2K9+wp90YvEKZMSvL1LZpZwjNHSzCNuGCNxMefXo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=SB3scY7d63d/eJqv4Mh0utENg6FNoyxZgIZfYT9wskjSLb93/ewvpTUimcqX/GycD
	 ea0MQ6BpzM0/16qegjhq+AUZrlZpEHHkiArnotvBjmtwdKodlaMy+08y3hHkQIK6AC
	 kAbh/Rl8Kbbr3alcBNFvuwg7AztwQLn0+63qIN6qn0nB0HRxIEV6moLayEbXbib4m9
	 wcds6YEC6MT4RzN0hGJlZgWRNfthKz7niDrcjOISOnnRkNo4A7wP2kMVd8VRT6RJC4
	 iSDkFFPBdt7alnLg0sK3x/QULuPoYlRtjTIkKJcPOMir+/q1BUfoP+kPGj0atA8DXv
	 am0ubi84jP7eg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2] kho: Convert error handling to immediate return
 pattern
From: Mike Rapoport <rppt@kernel.org>
To: LongWei27 <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, hewenliang4@huawei.com
In-Reply-To: <20260824024448.550552-1-longwei27@huawei.com>
References: <00c96a62-f783-497c-a7ac-1de495e4af06@huawei.com>
 <20260824024448.550552-1-longwei27@huawei.com>
Date: Mon, 31 Aug 2026 14:28:39 +0300
Message-Id: <178817571946.3691424.3757525664520719609.b4-review@b4>
X-Mailer: b4 0.17-dev
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

Hi,


> Replace the chained error accumulation (err |= func()) with immediate
> per-step error checking and early return in kho_out_fdt_setup().
> 
> Two problems with the current approach:
> 1. It continues executing FDT operations even after a failure, which
>    is pointless and potentially unsafe on an invalid FDT context.

Did you actually see failures here or was it an LLM suggesting that they
may happen?

> 2. Bitwise OR of multiple negative error codes produces a result that
>    may not represent any actual error, making debugging misleading.
> 
> Early return fails fast and preserves the original error code for
> accurate diagnosis.

The caller does not care about the exact error value, so the diagnosis
statement is moot at best.
Moreover, libfdt does not return Linux error values.

-- 
Sincerely yours,
Mike.


