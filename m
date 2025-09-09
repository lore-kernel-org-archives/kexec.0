Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F4DCAC582
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GncCjE3LDQxPsQwNFS4V0AxPTaIdO+pj35MKoSPtZiU=; b=Ts/70fz183AK+Gu7vLFwtLaxwa
	uDwTBG832BfChtyllZq8kUjC5x8h5p5YtYEZp7jAZLN1DgHqZVazWK6Jc1NnAjrc+OW9T1dbtjC2E
	nxCLMLIXaaIGGvTU09QHURn5dKFZMTYOMAze+dkVFyxjmQINBoYpt4lTUkWVnAOTim22zFIBZqVTB
	QaffpnCMiLsjLtLZkzrDZfLxyUScKBECn9ckJTKYWnDuU+1urp7nvb0tIj4SuvFdlTJWS3BJwSKc/
	VWoiJgyiFtyMjEg50Y0477wVwHBFnzzTFpfQhvabEWBpXvhqUTwNqTkHwPpbB+lz5rptuG2ajPraX
	bNQ01Ucg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw25x-000000093oH-1Xmz;
	Tue, 09 Sep 2025 17:25:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw0SI-00000008AYk-1ElD
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 15:40:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AAB9E6022C;
	Tue,  9 Sep 2025 15:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD52C4CEF4;
	Tue,  9 Sep 2025 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432425;
	bh=J+P+ERGtyQIPqKHoHTRunn1D/v4lU1nzFD4xwAWeJEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YXslSKOpOjN++5UFXUYxNV490+NFjX291NvrK3OsZheHLjV2yS1bWPcGMqzcImcz2
	 NOc8KlRHnla4/PGZ/HqtrTIyv7hdBGYEm7b48WdAgJ1Uoott2Pd9/NHmqISuWWj+Pa
	 HNuOPgSc7Qiy+8mN4a7jIoHWLJosYqgMVgDL2MmHZJslXSv/YI+N6SeCIx9xyPiTAu
	 f5ypmAzDDRNFUD/dg/J9TwOMMHl5bIoIf5ytrhq8p/O4ddYNGX6igaKvDYQlqfAkgy
	 oDKZdeNHzNDHH3w2hgUmQ63xi0GgV2AVgW0tsEmvAKSHsrCWo7Fj5fJk+SfkZCpNUk
	 JgoAWFI0onM2g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Thomas =?utf-8?Q?Wei=C3=9Fs?=
 =?utf-8?Q?chuh?=
 <thomas.weissschuh@linutronix.de>,  Chris Li <chrisl@kernel.org>,  Jason
 Miu <jasonmiu@google.com>,  David Matlack <dmatlack@google.com>,  David
 Rientjes <rientjes@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] kho: introduce the KHO array
In-Reply-To: <20250909152814.GL789684@nvidia.com>
References: <20250909144426.33274-1-pratyush@kernel.org>
	<20250909144426.33274-2-pratyush@kernel.org>
	<20250909152814.GL789684@nvidia.com>
Date: Tue, 09 Sep 2025 17:40:21 +0200
Message-ID: <mafs0ldmnk522.fsf@kernel.org>
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

Hi Jason,

On Tue, Sep 09 2025, Jason Gunthorpe wrote:

> On Tue, Sep 09, 2025 at 04:44:21PM +0200, Pratyush Yadav wrote:
>> The KHO Array is a data structure that behaves like a sparse array of
>> pointers. It is designed to be preserved and restored over Kexec
>> Handover (KHO), and targets only 64-bit platforms. It can store 8-byte
>> aligned pointers. It can also store integers between 0 and LONG_MAX. It
>> supports sparse indices, though it performs best with densely clustered
>> indices.
>
> That is a bit of an understatement, it looks like worst case cost is
> 4k per entry. I would expect better efficiency than this if we are
> serious about supporting sparsity..
>
> I think you need to encode the start pos within the entries in some
> way so worst case cost is bounded to more like 16/24 byte per entry.
>
> For instance if the page was broken up into an array of structs like
>
> struct entries_block {
>   u64 flags:1;
>   u64 num_entries:13
>   u64 pos_increment:50;
>   u64 entries[]; // contiguous pos
> };

Right, good idea. I can look into this. But only if we get an agreement
that this whole idea is worth pursuing. I don't want to waste time on
something that will not make it in at a fundamental level :-)

I think another idea can be run-length encoding to make this even more
efficient. But I have stayed away from that so far since I think that
can get tricky and bug-prone to create and parse.

PS: do you know if bitfield layout is reliable for serialization? Can
different compiler versions move them around? I always thought they can.
If not, I can also use them in memfd code since they make the code
neater.

>
> And if a high 64 bit pos can't be represented with pos_increment then
> you'd have flags = X and entries[0] == pos instead.
>
> Jason

-- 
Regards,
Pratyush Yadav

