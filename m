Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66D606A323
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HxLi9CHB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ukz+9Mhm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T4MRWNIKTZkEJgt6oLMqXnO3+RBTvl3UjB+JLMtpOKY=; b=HxLi9CHBEmyLNN7B1PEjH/9OJN
	GHlyCE8o+nfmOwlv6PgL9TVhttJejtQRweqxb2HZLywHr/RIlXgMbngv8HE1Hv50+fD7d3OqY5kse
	aJ1ZqaW0hQhbMRBg4Q3v4PikJI40XFJ8IajSpEvI25yr7qvFcyoleD3Mz6w3m038A+w8v9zIdApKW
	ixESvdEVr3IbnAD/vgtutRwOvVWyBqgI+EPiFMgeTNtF193GlLehzyIMv+bIVU1WSb6qPr7nYktyR
	0wQPsMR8Cgw6CWgD/PZLAJy+UZc928SYc/AIxh9ZspZg4FYMKX2Whng2tgDWoRiHt4qH+zWkvtysl
	Uqlx7u/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQo2W-00000004R68-1Yoz;
	Tue, 10 Nov 2026 15:45:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQo2U-00000004R5p-3Ssw
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 15:45:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D720263A37;
	Tue, 10 Nov 2026 15:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F171F008A1;
	Tue, 10 Nov 2026 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325537;
	bh=T4MRWNIKTZkEJgt6oLMqXnO3+RBTvl3UjB+JLMtpOKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ukz+9MhmJgvTDWk/SeEpiCCkI/fDF9KMsJ5erGKGHdcFKSmOVmYTuc9CGKNmi6DYO
	 dkn7GN9I36tJwFurwtLxd9tnH4rhP3ZTL0xTnvt8Ej6TGmAUntAB+/8ZIcRXL2dQ+g
	 rifN3NXh9WBsTGWuMkwOlo+7aSbKUH3BUb/8YMVD5rvHHb+nZAmuu1RZ1qGQrm8aKZ
	 kcR26N0KwEtsC9GIr9bPuaxztpOFhhIPld6MzOkHAzbhZ/SmJaUr+k1/kb1ShQvPaB
	 ut0RjG/3MNIuOJ6mZDzOQw2lxSHNBQf8C7PmVh9omoU0F2pwM7nyjwYn7HlSS1l2OV
	 uoB3ljY2gbHUw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Christian Brauner <brauner@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 00/10] liveupdate: Preserve tmpfs files across Live
 Update
In-Reply-To: <auy0ThryqW5nVx20@google.com> (David Matlack's message of "Thu, 5
	Nov 2026 16:52:30 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261105-sitzordnung-nahkampf-ausbleiben-6db911d0333e@brauner>
	<auy0ThryqW5nVx20@google.com>
Date: Tue, 10 Nov 2026 16:45:32 +0100
Message-ID: <2vxzbj7witb7.fsf@kernel.org>
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

Hi David,

On Thu, Nov 05 2026, David Matlack wrote:

> On 2026-11-05 04:42 PM, Christian Brauner wrote:
>> On Tue, Nov 03, 2026 at 01:02:06AM +0000, David Matlack wrote:
[...]
>> So instead of LUO handing out a file descriptor for a file it invented,
>> let userspace create the file, O_TMPFILE, O_CREAT, whatever it likes,
>> with the owner, mode and xattrs it wants, and let LUO put the contents
>> into it. That's what the RFC did.
>
> I'm fine with going back to that in v4. The retrieve argument will just
> be a file descriptor for the target file, and LUO will only restore the
> contents and size into it. Everything else about the file is up to
> userspace.
>
>> The checks on the target are trivial: a writable fd to an empty shmem
>> file with the inode lock held while you fill it. A tmpfs file can't be
>> sealed, it only ever has F_SEAL_SEAL, so there's nothing to restore but
>> contents and size anyway.
>
> Sounds good. The one other check I plan to add is rejecting a target
> that LUO is already managing, e.g. a file that is preserved in an
> outgoing session and whose size is frozen.

I have been playing with this idea too, and I also stumbled onto this
problem.

You also need to make sure a preserve doesn't race with a retrieve.
Since userspace has access to the file, it can do both at the same time.
I think LUO should expose a "register file" function that registers the
file in luo_preserved_files. This should be the very first thing
retrieve does.

Also, today LUO core expects a fresh file from file handlers, so it
always installs a FD to that file in the task. When doing the "retrieve
into FD" thing, that will result in two FDs to the same file. While it
isn't a strict problem, it seems kinda ugly from a uAPI prespective.

Perhaps we should let retrieve signal to LUO core that "I already
installed the file", or a "I have no file to install", or something
similar?

>
> LUO will also add the folios while i_size is still 0, and set i_size
> last. So reads, page faults and memfd_pin_folios() wouldn't see the
> folios until the file is complete, and if the retrieve fails partway
> through the target is left empty.
>
[...]

-- 
Regards,
Pratyush Yadav

