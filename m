Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D617A109316E
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 02:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYVW+mY55uzfqPfTCFo7zJeYYX0vBKUEot6RLC41cU0=; b=QbbhWuK5OR/Zy7f2QpNWl5MwXf
	G96kRz3WWht96agRdOUr7t+/dsExJtSmEfz2eY20rKu/3ZsrRg9vbr++8ZLuBX4Qg9Vt90yMIRurl
	CObUBAJmReCeN0F3rDdBluhT5HMuo9KgLT8qYcWjckwihiCqKpzjW9pm0VMjw8ZCA7k79xuCT+cey
	BEgRp6N4JL4rh2B+E/Fe9BDCX+PJMw1lm/xsgj9N3XsI8V4Bk36UTtkTTjfEf5FR1la20DPUKSqwe
	LPh7BsliUFcyfhCOtexikNIKXUj6AZeNCJPyAVIpdH6EV79OoaiJnc7spgJPhh8kR4HVySrxjDghv
	0VYAhiqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Pk3-0000000BwGn-2eiz;
	Fri, 20 Mar 2026 02:37:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Pk1-0000000BwGR-22h1
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 02:37:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB84940687;
	Fri, 20 Mar 2026 02:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECEDC19424;
	Fri, 20 Mar 2026 02:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773974256;
	bh=Ce9ZvvedBVgFA/+wmV2hIlsGSiYitcDJqHPohquR+Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Om6KcrXu8DE2JhUZs0+F2J+y4aA2hbY89smr4crrjx5cRej3tpnwOxli02mGOXb5b
	 0HZvTa5Zfc83wD+u2NAxu5b7wvyTPBmHCZiD+dySxaGGzRg0SxQpDz5fDdp9gdzJlb
	 Obs5tI+hxPgFgGOf2mx7oJ3SOuqr6d+c6LP4BxUU=
Date: Thu, 19 Mar 2026 19:37:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marco Elver <elver@google.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] kho: use checked arithmetic in deserialize_bitmap()
Message-Id: <20260319193735.2ea34594b36d37e7850a8c37@linux-foundation.org>
In-Reply-To: <20260319210528.1694513-2-elver@google.com>
References: <20260319210528.1694513-2-elver@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_193737_574778_BBD10355 
X-CRM114-Status: GOOD (  12.07  )
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

On Thu, 19 Mar 2026 22:03:53 +0100 Marco Elver <elver@google.com> wrote:

> The function deserialize_bitmap() calculates the reservation size using:
> 
>     int sz = 1 << (order + PAGE_SHIFT);
> 
> If a corrupted KHO image provides an order >= 20 (on systems with 4KB
> pages), the shift amount becomes >= 32, which overflows the 32-bit
> integer. This results in a zero-size memory reservation.
> 
> Furthermore, the physical address calculation:
> 
>     phys_addr_t phys = elm->phys_start + (bit << (order + PAGE_SHIFT));
> 
> can also overflow and wrap around if the order is large. This allows a
> corrupt KHO image to cause out-of-bounds updates to page->private of
> arbitrary physical pages during early boot.
> 
> Fix this by changing 'sz' to 'unsigned long' and using checked add and
> shift to safely calculate the shift amount, size, and physical address,
> skipping malformed chunks. This allows preserving memory with an order
> larger than MAX_PAGE_ORDER.

AI review asked questions:
	https://sashiko.dev/#/patchset/20260319210528.1694513-2-elver%40google.com

