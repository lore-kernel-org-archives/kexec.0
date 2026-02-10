Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCC4EA810F
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0SPraHkWY4ytIGa3ssvCkBPtYNsoLRqE5+KaHhxgq0=; b=q7ec3K84ZB0CVeAP89toDBqLwY
	E96ViM2UuKpz3iR3hA0s1hB92XbD5sDpZQ+HHRdyCLMNcJu1FT/l24fX6FzqqaAtKwhiL5cgfpjXU
	BkjindtTRDeVM5PTqBX4HUTQKMPgQC76gQKB9ErG7afYCBEiwAq9BraLNDXLCn1rsvbzGTXHoAa/C
	GKd5Per0DUw6nJD2eL88nMgKIF7UM6t9GvPawPoGrFnlBqm4RQuBiSKGN30ei9yRwwNwSZ1TYUsJh
	DX2ZRSX6DwmeH1h7I50IDHnN3ZEuHT5Zd2aW+AmUlDOZSDHOA57Cs3IE6qK/uKj+e79uCnNd9lsCZ
	4ld2hbag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnat-0000000Gz0S-3iY0;
	Tue, 10 Feb 2026 13:15:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnar-0000000Gz07-1M5a
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:15:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C4F260097;
	Tue, 10 Feb 2026 13:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D52C116C6;
	Tue, 10 Feb 2026 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770729352;
	bh=IV/D02QN8hR7lkLeDhxWOSdoEhss8wgB/k3cihsIPIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CjfTqjjZ07zhsQQs7536tQfJMZz4vCamo5ynyp/Pr4qbqJzAgqa/Q3peYK6WevRaq
	 FSWd0GQUj0rxiU+rMen13hnT1r1VOq7xnjrOnW6/1cNeAr3FjOmigw786oy4/Rg0ak
	 21/fUUSNVzUuXxdEZcCEEsr98oJTm1BDskt4yhJAy/IZ3mnvGdweeP3W/s/cdz9hun
	 CDQXcO66W1hcNsKKcoXIK/UF+LNL4z0n3LsFS2pTzU0mU9b3Rz2dGXGNCPiiASuh15
	 egAoYqh8GXpta28pgfRUofLlZDYHy9hlwZdMi6YflhOjd5L4NV6DzqlUpfP+hXatng
	 It1tMCEsIc/XA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Hugh Dickins
 <hughd@google.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
In-Reply-To: <aXd8I4czYUpl72qq@kernel.org> (Mike Rapoport's message of "Mon,
	26 Jan 2026 16:37:23 +0200")
References: <20260123095854.535058-1-pratyush@kernel.org>
	<20260123095854.535058-3-pratyush@kernel.org>
	<aXYGkb-QtYNaWYw4@kernel.org> <2vxzqzrca6cm.fsf@kernel.org>
	<aXd8I4czYUpl72qq@kernel.org>
Date: Tue, 10 Feb 2026 14:15:48 +0100
Message-ID: <2vxzo6lwu4cb.fsf@kernel.org>
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

On Mon, Jan 26 2026, Mike Rapoport wrote:

> Hi Pratyush,
>
> On Mon, Jan 26, 2026 at 01:47:21PM +0100, Pratyush Yadav wrote:
>> Hi Mike,
>> 
>> On Sun, Jan 25 2026, Mike Rapoport wrote:
>> > On Fri, Jan 23, 2026 at 10:58:51AM +0100, Pratyush Yadav wrote:
>
> ...
>
>> >> -	file = memfd_alloc_file("", 0);
>> >> +	/*
>> >> +	 * The seals are preserved. Allow sealing here so they can be added
>> >> +	 * later.
>> >> +	 */
>> >> +	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
>> >
>> > I think we should select flags passed to memfd_alloc_file() based on
>> > ser->seals (and later based on ser->seals and ser->flags).
>> 
>> Not sure what you mean.
>> 
>> I think the only seal we can set via memfd_alloc_file() flags is
>> MFD_NOEXEC_SEAL, which is really a F_SEAL_EXEC and plus a change of the
>> inode's mode. And now that I think of it, that is a valid use case that
>> we might as well support. But I think that should be done by preserving
>> the mode of the inode directly, and then copying the seals back. The
>> main reason for that is that the mode can be changed after the memfd is
>> created too.
>>
>> Other than that, all other seals are set by fcntl (via
>> memfd_add_seals()), so I don't see what else we can pass to
>> memfd_alloc_file().
>
> Hmm, "using ser->seals" was bad phrasing :)
>
> Now we add support for creating memfd with MFD_ALLOW_SEALING and at some
> point we'd want MFD_HUGETLB and huge page size.
> So I think we should have a field in ser that will define what flags should
> be used for creation of memfd and based on the value of that field pass the
> flags to memfd_alloc_file().

I am not planning to re-use any of memfd machinery we have now for
HugeTLB. The main reason is that the HugeTLB support is different enough
that any shared code or data structures aren't worth the extra
complexity.

So HugeTLB gets its own serialization structures and file handlers.
struct hugemfd_ser in [0] has a field for order which we can use to
decide the flags.

[0] https://lore.kernel.org/linux-mm/20251206230222.853493-11-pratyush@kernel.org/

>
> For seals support this field can be hardwired to MFD_ALLOW_SEALING at preserve
> time.
[...]

-- 
Regards,
Pratyush Yadav

