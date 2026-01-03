Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380F1FC6182
	for <kexec@archiver.kernel.org>; Sat,  3 Jan 2026 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxmRlp16vnAjFvCk4KFlk0C7OnwvbDobH+tqhbPlU1c=; b=domeXw+reRFU6nDWh6QCXBNI+s
	833fgNhLrxAQKkV5UoDROk64QU/hu/SzJJCFD0gb5IwrzFjrgwfXJacaY3To/Rpo4HAZl7D3o8Li7
	+P+kbn/cqWWt0pRNHTEmiIbAWyuNxZ7du4yHxlbFbUL8dB72FlPuHy4DzJXqtvpTlNJ0Mm96mZ7uZ
	la+AQhHoAAqidIXBQP2c74LhZJdCNtBrwptSOus2kgiEftj2fo0MravoRVSK7i3S0AycH9c2iZS3B
	kV7HBb6dS1dJA2paOSyJnXPw1G6sNAlISEvr3WaSfreaiJdyfapwU6OEwhMTi4EOJR0+I6Vg7NrXr
	kAdbrbrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vc6r5-00000009hZ8-1UGR;
	Sat, 03 Jan 2026 19:00:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vc6r0-00000009hZ0-45pV
	for kexec@lists.infradead.org;
	Sat, 03 Jan 2026 18:59:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09ADA60017;
	Sat,  3 Jan 2026 18:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB19C113D0;
	Sat,  3 Jan 2026 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767466797;
	bh=omBZBCfeRSyWOrBJ6BZZYx870z71q5DnTs3+5igQ37M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daWX40jTgv4j4LKq0g1uveUBTG7eo9odO7BGheJ+fHT0MwEC3l0Y4KRMLSyiZRN26
	 /EWuxz7s0xZI3PadQZhOcP8+upJrUpGh7VZvt1smhEnRryciGxID8pD0bA3dEYTDfk
	 5dVz8IzZXmPQAtm51yk8bubc0zvEhxgjzCJodcyGJOMRg65iaqQB08RPukYR7A14ll
	 JoYjx+MPJfr+DUcgeRKqGyukoBzyf0mHZaGEZqZxrGEUZR92ATGKbDGEmZa0DlPKH1
	 /3s1IFM4fEayAHdcVSTRMBfPN6zbXAuwXUvaOYPkBuyInEZaUdd+quJLeV962G7uNv
	 BqniYHmjqzleg==
Date: Sat, 3 Jan 2026 20:59:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/4] Make KHO Stateless
Message-ID: <aVlnJZ7vN6-FEL6z@kernel.org>
References: <20251209025317.3846938-1-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209025317.3846938-1-jasonmiu@google.com>
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

On Mon, Dec 08, 2025 at 06:53:12PM -0800, Jason Miu wrote:
> 
> This series is broken down into the following patches:
> 
> 1.  kho: Introduce KHO FDT ABI header:
>     Adds a dedicated ABI header to define the FDT interface.
> 
> 2.  kho: Relocate vmalloc preservation structure to KHO ABI header
>     Adds `struct kho_vmalloc` and related structs to the ABI header.

I think these two can be merged independently of the radix tree change.
They seem ready to me and having them upstream will make it easier for new
KHO functionality, like e.g. "kexec history" patches 
(https://lore.kernel.org/all/20260102-kho-v2-0-1747b1a3a1d6@debian.org)

I'm going to prepare a series with these two patches and some few more
updates to KHO and LUO docs and I'll send them in the next few days.

-- 
Sincerely yours,
Mike.

