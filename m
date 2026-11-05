Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DE606A336
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AbTmUrb6;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fevxLUfT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7+a5U8fHtsX3E5MaoZwCfMwFhX7Hac3DauAHwFYDfPc=; b=AbTmUrb6SVunn0M165P/eBaA8T
	X3aRbqlAlVENw5weNB9lAvqMxp7ytSdIi2FFlb8ZZXWO906VMwyNm0Q/LZkhG+u7u+5fSk5sSeISH
	49EvmdbP9xirQbH0s9CF9fmjVDHgndUzankcqOSowVW1AiiG34QNQLytuMVjobJHVfhZea3yIKrbe
	DwIteygs43BLo7U7wWP/9kNlMCeR7wTOSaHwHbV/8UhRs9DOcCEa19jutfY0gtOjKTPqHl5tSwI9T
	DS1KhO9j1ZnA83VKYRCH/VQgq0zVZBSZXRDnuvFU+xObeFskoNWHq7JHy+otARUmc/GSDaH9m+D9M
	UMGepCZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0hZ-00000009hxz-497U;
	Thu, 05 Nov 2026 16:52:37 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0hY-00000009hx6-2W04
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 16:52:37 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so1516297b3a.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793897556; x=1794502356; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7+a5U8fHtsX3E5MaoZwCfMwFhX7Hac3DauAHwFYDfPc=;
        b=fevxLUfTOdhHp8o5PmLFnQ0NiqTonA24ifFQ2FxoCoTMM5xLiGjYuqFXfTrfV3/iy9
         9Ae0SATZ/2huM16cbgf91Ta133+mVoVNX+dJXuu0fDg4cpPf/T0rCHe9+8/mCMjqGztF
         giOh7uhNwuqOUFc685tVEqqzAw8AZtkvq7nSZs/ckeM0X0F/mfsEGtLBl+ZYSfSVOH2R
         iGMcEqrqLukKh6EJ5v97EhomyNlrvbCHe3JGioTPYH7Xzi1cYeKc/QlihdI8M6mshIFJ
         DbBKEPUymn26HPjOMTk4IsvG/vflADLKESDyrPCJ3cRnF+3q/498PGXsQl8z/XV1/xMr
         FyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897556; x=1794502356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+a5U8fHtsX3E5MaoZwCfMwFhX7Hac3DauAHwFYDfPc=;
        b=XkTQzKCGELJBIvfr4udRon6VINMkt2sRAIEyKQgGhDYllhN6zO0rGKRt2amLrNVyvx
         EctaGaHWY8TmCRqztZfCskcAKqRzV1lehX+Dbu7lGu4+98AFzLpL/0N8g970DMK5ibYU
         aQnnZLtzLj9vLq+dIUXQsMX13OJSBExy9HFn3uHb2wmeAtl8qYW3ms9M2wEg7MIgQ3KD
         8gVuD8jlq8yIVMwaISYkERXSQoI6OTE8FfefQ+OtopmT2nZlNoS7BqYjLJC5wPU/rO1n
         rOMQp9ZYyNKiQ6+nIYb5uYjYCd2zESwzPI2nT0wH4Keze4/3s573ZCI8yO+mv0wivldv
         d/hA==
X-Gm-Message-State: APuU4Z+n8s2GWjjk/+G6D9tyf9XnmzWVNqAN2poKau5x5RBw7ZL+6ODl
	yZq5IdwZPJYc5iYIwFzYmlzxFsUtb4zJvAys2aFN2oxEgJbuLZIwi5mUmDtjAA6ynw==
X-Gm-Gg: AYBFou3ZEsTWzU+3KMAbk/GGDLhWRAfZgfal5+PFLBe7HX0l2YubErCdalJU6IFCvXS
	Wxs25oiiAaeOcuQdOxyBttEetE19qdfbOGz+2z5EvtPc1V7IpxVNA6awTZ4demmq7vPyyTzJVeL
	YswDpVI7Zv8E1FQcyuStXRWWd/IeH/qOqlHBLyXOefFDV8VRWOeecGMddlOCAnwL953zL/1Wckg
	ckzmd1b17m5vJgdf38tu3vsjSryzYVJJH1TT7IxpWPoVI3ELV8NChj5iUcYuzDOZTkS999Ntk8E
	w1owsOPuhAoRNydsOQ9CdltlI4xR4J/Del9BFowkv50GMnaTmvds8E4HXgNQwUjy6Y/2S0gmcbQ
	ZK2Eum7aZFhRYp2Ohb48bnLnXhOH5vfzTMrZMfOgKDxQTUXnmJLgt4BQnkRW2hDuKo81/uKLdm8
	RNUe7hJEyE1k5sL5eh8am5UMgHA1eYbqmtDZ2gKjpYrDAr5efzHv23nLzyjuhMLDLHBXVlySrzb
	iGCVtVFL1ECqou4WcUGpHTFnEluVRXFdSnr7elJHgynwgGO7Re0OZhHx2U0yAu9FYj6PUwejCE8
	yToanIIBe9rRKYFIJ7EdSu6o9EW2qgKkK7+/pi6an36zyb1tOPdm9IZOoUPmckVFxuHrAIWdCGq
	tmRAtGUkoMw==
X-Received: by 2002:a05:6a00:e11:b0:882:359f:ef17 with SMTP id d2e1a72fcca58-8a9bb7a0b64mr18260859b3a.12.1793897555111;
        Thu, 05 Nov 2026 08:52:35 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09bb48410sm2298197b3a.46.2026.11.05.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:52:33 -0800 (PST)
Date: Thu, 5 Nov 2026 16:52:30 +0000
From: David Matlack <dmatlack@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 00/10] liveupdate: Preserve tmpfs files across Live
 Update
Message-ID: <auy0ThryqW5nVx20@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261105-sitzordnung-nahkampf-ausbleiben-6db911d0333e@brauner>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-sitzordnung-nahkampf-ausbleiben-6db911d0333e@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_085236_639683_DF4060DB 
X-CRM114-Status: GOOD (  26.82  )
X-Spam-Score: -14.3 (--------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-05 04:42 PM, Christian Brauner wrote:
> On Tue, Nov 03, 2026 at 01:02:06AM +0000, David Matlack wrote:
> >   4. Retrieve files that were preserved from a tmpfs mount onto a tmpfs
> >      mount chosen by userspace, via the new struct
> >      liveupdate_shmem_retrieve_arg. The kernel creates the file as if by
> >      openat(dirfd, ".", O_TMPFILE | flags, mode), so the file gets the
> >      same flags, owner, permission checks and security labels as any
> >      other new file in that directory, and is charged to that mount.
> >      The kernel fills the file before returning it, so nothing else can
> >      access the file before it is complete, and userspace links it at
> >      the path it wants with linkat() (patch 7).
>
> No, sorry. That's not what we discussed at LPC and it's not what the RFC
> and v1 did.

[...]

> So instead of LUO handing out a file descriptor for a file it invented,
> let userspace create the file, O_TMPFILE, O_CREAT, whatever it likes,
> with the owner, mode and xattrs it wants, and let LUO put the contents
> into it. That's what the RFC did.

I'm fine with going back to that in v4. The retrieve argument will just
be a file descriptor for the target file, and LUO will only restore the
contents and size into it. Everything else about the file is up to
userspace.

> The checks on the target are trivial: a writable fd to an empty shmem
> file with the inode lock held while you fill it. A tmpfs file can't be
> sealed, it only ever has F_SEAL_SEAL, so there's nothing to restore but
> contents and size anyway.

Sounds good. The one other check I plan to add is rejecting a target
that LUO is already managing, e.g. a file that is preserved in an
outgoing session and whose size is frozen.

LUO will also add the folios while i_size is still 0, and set i_size
last. So reads, page faults and memfd_pin_folios() wouldn't see the
folios until the file is complete, and if the retrieve fails partway
through the target is left empty.

> I also really dislike file_open_root() for this. It's an openat()
> emulation inside an ioctl which is completely terrible.

That is fair, it is ugly. That all goes away in v4.

> > - Is patch 9 (retrieving tmpfs files with O_RDONLY) worth merging?
>
> No. With userspace creating the file this doesn't exist.

Ack.

LUO holds a reference to every retrieved file until the session is
finished. Since the target has to be writable, executing a restored file
will fail with -ETXTBSY until userspace finishes the session. But as
Pratyush pointed out, userspace can put binaries in a special session
that can be finished immediately so that the binaries can than be
executed.

> The preserve side seems fine to me. If you freeze the size of a file
> for everyone you better be allowed to write to it.

Thanks for taking a look.

