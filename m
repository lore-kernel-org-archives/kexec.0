Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BC606A33D
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e7jltw2O;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNVf3e2f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NIe3hOKLCnHqFNzGUF054ejmgeEIVGuZTJTbO+auWw8=; b=e7jltw2O8J6i6Wc/NNrMLF2x/9
	A0dUPW430qu4LN/g0OEhaR0nP9/Kg4tY+CzQmVjC+p1m/0Ye/HbLgwwwYzGlDofdsXHQMY5yFLE//
	0hVVJvpQyC/fgEIpB7r8jKPagV08E9CjPM681JNHsazKlgHsZpube25WEFanqYOqnPAsfiW/Cl0GP
	OWKImkukj7ggQIoUSpssLfy/flI1w4/5dBUxvaVD3bjGM26Z7gPnBIvHO0Cv17Rg+6txzY3bT6Fsg
	9WElKAUPpWX4qJt5VNKVuotY+m8xoorF3++MuCIwT+lCgkJo4JHbHhdD7E2KTc6Q+MeCRvkVbLGf4
	wuQoFxmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMuY-0000000Ep3W-1uEO;
	Fri, 20 Nov 2026 11:36:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMuX-0000000Ep33-1Qmq
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 11:36:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D0EC6265B;
	Fri, 20 Nov 2026 11:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C0E1F000D1;
	Fri, 20 Nov 2026 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174568;
	bh=NIe3hOKLCnHqFNzGUF054ejmgeEIVGuZTJTbO+auWw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LNVf3e2fuB6sV6i+MOVpjyM8ou9ybEJWd/y2YnESvyNqyqZDV/JUVifcofk3GSUh9
	 wdDRIJZgSFB03R34CTubN4uNtnYupEInqCHzDpZSNOvG391LTBj34OpEYqI8reWNJF
	 fxGiQTz24XlLet/fihwDGBNU9jRmT5QHyqZ4XW2KeqI+1m7PNKK022IPB1zUXwsRuf
	 o9/IvtHEr8a8yFSdiQOcoB9AEKq4dXLYytA8O11f5kEhZrEBfMs8qPfnTvKsOsJEaZ
	 wzbWR5kBFfbuI/qOpigQGtu4DM8/GbQsjMEEquZ3MudbSYuenkNEPnv/ezcqMiAkS4
	 oGlsk2V2hEp5A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: David Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
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
Subject: Re: [PATCH v4 08/19] liveupdate: Let file handlers retrieve into an
 existing file
In-Reply-To: <20261120-gedulden-rausgeflogen-spruch-cea76174d5e2@brauner>
	(Christian Brauner's message of "Fri, 20 Nov 2026 10:23:28 +0100")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-9-dmatlack@google.com>
	<20261120-gedulden-rausgeflogen-spruch-cea76174d5e2@brauner>
Date: Fri, 20 Nov 2026 11:36:01 +0000
Message-ID: <2vxz7bi73fby.fsf@kernel.org>
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

On Fri, Nov 20 2026, Christian Brauner wrote:

> On Wed, Nov 11, 2026 at 12:23:46AM +0000, David Matlack wrote:
>> A file that is restored into an existing file is already open in the
>> caller, so installing a new file descriptor for it would just leave
>> userspace with two file descriptors for the same open file. Retrieving
>> the token again later still returns a new file descriptor, like for any
>> other file that was already retrieved.
>
> Thanks, this looks way better.
>
> One thing: Please just install a new fd like for every other retrieve.
> I think it's pretty meaningless to return the fd number the userspace
> just passed to the ioctl.
>
> The fd number is also not useful as it's not tied to anything. The shmem
> handler looks the fd up once and LUO keeps a reference to the struct
> file:
>
> 	CLASS(fd, target)(arg->fd);
> 	[...]
> 	args->file = get_file(file);
> 	args->fd = arg->fd;
>
> Which means, another thread can close() that fd or dup2() something else
> over it before the ioctl returns and the fd you hand back refers to a
> different file fucking over the caller (shared fdtable etc pp).
>
> That also gets rid of @fd in struct liveupdate_file_op_args and the
> special case in luo_session_retrieve_fd(). And a retrieve into an
> existing file then behaves exactly like retrieving the token again.

I suggested this approach because I found it odd to return a FD that
userspace already asked us to retrieve into. Any sane userspace would
just end up closing one of the two. I didn't think of this race though.
I reckon we could return -1 in the FD that LUO returns, and let
userspace use the FD it already has to work around this. If userspace
wants to close the FD in the meantime, that's their problem. They don't
get the file they asked for.

While I like this more, it's not a super strong preference. So if you
still insist on having a new FD, that's fine too I suppose.

-- 
Regards,
Pratyush Yadav

