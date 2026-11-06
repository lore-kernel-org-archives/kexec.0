Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103E606D804
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iarHYxW5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2ewZjrC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BLPH8onp6C7AoW4lZMqXDExv0D9uGk4L9LfjO8m+oHo=; b=iarHYxW5xpk2wd1D12oGZRY1hY
	SSblR65YWVvoNKeSznNHIo3wdVrAexqWySEgWvZ/TTmFLJViSsIxRSHwZr+uvf/I1Fiw5eYFE9JMt
	FXCW1YaRumoayeIX0dwZc4pxR/OTMhXvho5GeKFRZFIsdmW7k4Xah/GwGmRkJAuTKWENrlrIeJGlg
	sIjxJbbUqf5fcOwbLL4NB59hAz7ioVvBNwlEq9cqFEVvybiB7mwDmNbWAeSEcIs12rl6IAgiyetf4
	dCvnFG9Hx7KCfIxHobPUhslepAkAkANW+llrhZuYGBgX2r6YSLyq7feEwpg17sCSfuVOgNMHKs4/i
	MIJVbEfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKfI-0000000Cbzx-1y2D;
	Fri, 06 Nov 2026 14:11:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKfH-0000000Cbzl-0nQG
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:11:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9AB3C43D04;
	Fri,  6 Nov 2026 14:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C2F1F008A3;
	Fri,  6 Nov 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974294;
	bh=BLPH8onp6C7AoW4lZMqXDExv0D9uGk4L9LfjO8m+oHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=g2ewZjrCHw3WTRPfHVHQxqbS1wA2g3wTh8480oj0lnvKZf5Py0zb7HkGFUGjZ6QSA
	 RBZ/BrP5GFgfXjKQaVwBIgtyh70yIGqFmj4eNHDJaFS+UrScNolIuIm1Irq/glNT9u
	 RMDoXxZQVVC2FARzVwO+iCwWeWc9ptgaHE6/yBn88hSeN9ODaTw6HiftZ+zI5VCmSw
	 G4llq4/bkghvyG2s/hIh6+lM2R0qBGt3H1Mi+CnIcMHeiJUSx23GA0JPC0gbGv+KTT
	 KZ8ZhjL0UGyyvHaMcFPS0aaWi+hoWsnP7ATmE7NywBYeukjSNn2NrqVIxtLA9oW0aY
	 RDRxL2XiQij7A==
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
Subject: Re: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files
 with O_RDONLY
In-Reply-To: <auuzKNZsPD10XM4q@google.com> (David Matlack's message of "Wed, 4
	Nov 2026 22:35:20 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-10-dmatlack@google.com>
	<2vxz5wyck08d.fsf@kernel.org> <auuJ4msatqzoOrjN@google.com>
	<auuzKNZsPD10XM4q@google.com>
Date: Fri, 06 Nov 2026 15:11:29 +0100
Message-ID: <2vxzse1ehwxa.fsf@kernel.org>
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

> On 2026-11-04 02:45 PM, Pasha Tatashin wrote:
>> On 11-04 17:52, Pratyush Yadav wrote:
>> > On Tue, Nov 03 2026, David Matlack wrote:
>> > [...]
>> > 
>> > Can't you put all your binaries in a separate session, retrieve it as
>> > the very first thing, and then finish the session? Then you can execute
>> > those and retrieve all the other sessions.
>> 
>> This is a good workaround. I am not opposed to this patch for 
>> completeness of functionality, but if we decide to keep it, perhaps it 
>> should simply be squashed into an earlier patch. The current diffstat
>> looks bad, as it mostly deletes code that was introduced earlier in this 
>> series.
>> 
>> In any case, given Pratyush's suggestion, we could also drop it.
>> 
>> > 
>> > Why do we need to support this in the kernel?
>
> That would work for binaries, and I agree that use case alone doesn't
> justify this. But I see O_RDONLY as part of the retrieve interface, not
> a feature for one use case. The retrieve argument is modeled on
> openat(), and openat() lets you open an existing file read-only.
>
> open(O_TMPFILE) only requires write access because it creates an empty
> file, and an empty read-only file is useless. A retrieved file isn't
> empty, it has the preserved contents, so O_RDONLY makes as much sense as
> it does for any other existing file. Without it, every retrieved file is
> writable, even when userspace only needs to read it.
>
> Preserve already works the same way: a file can be preserved through a
> read-only fd, as long as the caller has permission to write to it.
>
> If we keep it, I'll squash it into patch 7 in v4, so retrieve supports
> O_RDONLY from the start. The commit message will lead with the openat()
> reasoning and keep binaries as just an example.

I'm guessing this all goes away after you do Christian's suggestion? I
don't think we should be retrieving anything into a file that userspace
has opened O_RDONLY. Retrieval is in effect a write operation. So
userspace _has_ to retrieve a file and reopen it O_RDONLY after
finishing the session.

-- 
Regards,
Pratyush Yadav

