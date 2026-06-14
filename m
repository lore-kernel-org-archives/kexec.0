Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E662CD98D2
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8j7GYUuL2qMg/N1iU231lLW5+hnbXNtQC2/ZL4IkuJQ=; b=Pb9oSVqjTJLZ5tCR6zsnncqxL3
	dUm+G70rqcscRMsRf3psjqkn7xyLPm+4wrSLdnnen5RfzSEaOXbMVkuI5jrcCNl3NmlXfRkoM/PIA
	K1jd7+kQ1XsxczVOrAkRjSsxrB1g0WT8bexovBusz78/r59e00hIJNA3JmyeDQ8MsJhHYhP3S43To
	QskVaZN86AUI0ZzfxvqwnwnK49qmWFy/t3/3QoDBLzUE+Uu6YFZ23OsV1dYgLW2CjbFrgIEHl+wO3
	ckIltlt8ZYtiOEYFueuJO8YONdX7ZZxyC0PWl01185yFrSAQ1Z8fTj7kKPRhtYI6vssODna2kSw6a
	tVgOukOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYM-0000000CwyJ-1Heg;
	Sun, 14 Jun 2026 12:03:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYK-0000000Cwww-2bFY
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:03:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0FDF60132;
	Sun, 14 Jun 2026 12:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905231F00A3E;
	Sun, 14 Jun 2026 12:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438579;
	bh=8j7GYUuL2qMg/N1iU231lLW5+hnbXNtQC2/ZL4IkuJQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LksRWX1MPElWBZDiPqlUaZxR1aOerveBqLKzAlufmwBiZO6rbt79nA0DXZnELiG5w
	 U1+3SU/3/cgJcp/h3aowUy/de08VtPRQb7S8tDJCbkKKBYqCp2LSo7YOzc7hAU/9QQ
	 Pa0ufkJK54qwnsQoJKeUUgdc/J9pxAq63oNEj4Ut5nc7zYEQcGOvIknKzPdN7S9Bn0
	 Mz3dgF9BD7kI3I0eLEecLw4I4YBfCzZqtHvvcKzCXhas2NgkVqcTqZ7iFgSPtksg6N
	 GrbkpR8TIu1BnZKgvpDg41hvsArRTvFihGv0kVDx/we9PNv5KRM/QhltLpal+rhoGr
	 148fOZU0saLvg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 17/18] memblock: allow calculating reserved size by
 flags
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-18-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-18-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855122.2123877.17100233420255303699.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:50 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index b3b4a6145fad..a3b57066611d 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -487,7 +487,8 @@ static inline __init_memblock bool memblock_bottom_up(void)
>  
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
> -phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
> +phys_addr_t memblock_reserved_size_flags(phys_addr_t limit, int nid,
> +					 enum memblock_flags flags);

Ugh, I'd hate memblock_reserved_hugetlb_size() less ;-)

-- 
Sincerely yours,
Mike.


