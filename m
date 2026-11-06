Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB31606D801
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0E7qmYF3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/HGem5K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nGx2NwMDbqtPHMPNsh9EPN5476lLpafXJ5wg9iLlkU0=; b=0E7qmYF3iCRFQHVuzH2UW7xDQY
	Flk81IlZNp4gW8NcxhO76tI+hjnaSLrUzsb2uXpV6Nnb1mdNV3IkscKIIY4eEbtlYxl4VX4/lDydY
	gVNQjyEcny9D6XJTg3wymLppJkzPTG81j4pgN29syv41yRMEKmCwK/5RJ1wPDAuCKX7/a0LNqrvIU
	J1UbS6jSFbCD57firYUJY4KcqWZjSlJDDwwZjRpj7JwOZMrNHxQG71VJWLIvhhiVmmqalDfFPvmcv
	AkMx4adb4VSkys8RkBw9XcVZJTZ1fsRCWAjZ9FT/GXQ3BQSJrkNRZf6c3g4+rEeFZ7OLDdW/Ypq4s
	xI4lxQMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKnK-0000000Ccjz-26xO;
	Fri, 06 Nov 2026 14:19:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKnJ-0000000CcjH-0oSK
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:19:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81DE440B46;
	Fri,  6 Nov 2026 14:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6B71F0089F;
	Fri,  6 Nov 2026 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974792;
	bh=nGx2NwMDbqtPHMPNsh9EPN5476lLpafXJ5wg9iLlkU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=g/HGem5KtJgc9W8TdrJwmhR17aQrSNJ/3WiUgE8cbYrwLqR+8CiOTS2uxScKtbGx1
	 2c6ZPsrzgjJk6QeVkM7SksMsqAMVHzIPtrjoCThNVLRzZkyXLs3fRlcuk/1ieJf6uA
	 XgkSZqPTiFHZAjJQx4O1D77vN3Kr4sy7gUnO1Av7IfWWeiZWgd+rsuGRaN35Jjvajm
	 JYPtGJ+oHjIv/8muL9XlSFCGAMWWSEVdAtfBIdf1rN+YqwnOkIcKs80n6KttGgm/cr
	 w8WDikVb8t/E8NiEJJ8ZwKg2/Bo1m50TCIzF1c/Frj+iJVc2sPClcjdQanVGjc44Nj
	 04wzD72CKNRcw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  Christian Brauner
 <brauner@kernel.org>,  David Hildenbrand <david@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Jonathan Corbet <corbet@lwn.net>,  "Liam R. Howlett"
 <liam@infradead.org>,  Lorenzo Stoakes <ljs@kernel.org>,  Michal Hocko
 <mhocko@suse.com>,  Mike Rapoport <rppt@kernel.org>,  Randy Dunlap
 <rdunlap@infradead.org>,  Samiullah Khawaja <skhawaja@google.com>,  Shuah
 Khan <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 10/10] selftests/liveupdate: Add a test for
 preserving tmpfs files
In-Reply-To: <auu02-iDbVaEL-4v@google.com> (David Matlack's message of "Wed, 4
	Nov 2026 22:42:35 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-11-dmatlack@google.com>
	<2vxz1p90jzx4.fsf@kernel.org> <auuJM8c-bE43NP54@google.com>
	<auu02-iDbVaEL-4v@google.com>
Date: Fri, 06 Nov 2026 15:19:47 +0100
Message-ID: <2vxzjymqhwjg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04 2026, David Matlack wrote:

> On 2026-11-04 02:37 PM, Pasha Tatashin wrote:
>> On 11-04 17:59, Pratyush Yadav wrote:
>> > On Tue, Nov 03 2026, David Matlack wrote:
>> > [...]
>> > 
>> > Umm, no way I am reading all this...
>> > 
>> > LLMs are great at generating tests, and I'm not saying there is no value
>> > in this. It is just that this massive code dump is unreviewable by
>> > humans. It is also unfair to the human reviewer because it took many
>> > orders of magnitude less effort to _write_ them with an LLM.
>> > 
>> > What do you all reckon we should do about this? Trust the LLM to get the
>> > testing right? Do we give up human maintenance of tests entirely? Do we
>> > do fault injection to test the tests themselves?
>> > 
>> > Or do we make the tests smaller and more human reviewable?
>> 
>> We need good test coverage, but I believe we can break this patch down 
>> into smaller changes where tested features are incrementally added.
>
> Agreed that it needs to be easier to review, but I'd like to keep the
> coverage. Here's what I have in mind for v4:
>
>  - Move the preserve-side checks that don't need a kexec into
>    liveupdate.c, like Pasha suggested in his earlier reply: which files
>    can be preserved (permissions, read-only and append-only files), the
>    frozen size while preserved, and unpreserve. Those then run with the
>    regular kselftests instead of only in vmtest.sh.
>
>  - Split the rest of luo_tmpfs into several smaller commits that add the
>    tested features incrementally, e.g. one for the test infrastructure
>    and basic retrieve, one for the open() flags and creation checks, and
>    one for block accounting. That makes the series longer, but each
>    commit is a few hundred lines and can be reviewed on its own.
>
> It will still be long, but I think having the test coverage is worth it.

Agreed.

>
> Does that sound reasonable?

Sounds good. But I think practically speaking, it is not possible to
review the tests as carefully as the main changes. I think I'll rely
more on my LLM for those.

-- 
Regards,
Pratyush Yadav

