Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E24C88E4D
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 20:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mIQ6jM8juF2PvO8eUkaKKIYpJrRvH5Gc2fB112shtA=; b=CIj3abMGJK1Fq3ID9B2hz1ZQK6
	1qOd0TYbYIKfChWoJ+YBHAVX1oK+rogf1Jq0DozmqRYoJiWYtdV4fD9B05RxTfufsyjiMrLEqf1Y7
	5W3Or4H0kCAvPVCJPXjEDx7ckUwWCX+40zfcutMumXlh5fZjPY8VMlsQerIMgZY9c+nzslOQzNYKJ
	VzDFPl1NQNAUK7e2BWXGlbRRDgLln+qJnarqziISUtgLUjahlTzPgs8iCjNFyRBhBIs4GF+b9MzG2
	Ju7kN0vKOkIjxKABNOKpFtM7aVmEqwl200sp0YdhZDndzYD2rHMEUuvNmFDBKinlVjrSRQzTo5cv9
	Duo8uQpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58L5-000000008Em-1ZOx;
	Fri, 11 Sep 2026 20:59:15 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58L3-000000008DS-0rso
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 20:59:14 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-90e970f710cso14204466d6.3
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 13:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789160352; cv=none;
        d=google.com; s=arc-20260327;
        b=RZ83+iT8v90OdlQmEiNXFUaI3Geo91x2+osmsXdbO34SxlJbQORT5udvJAx3Igyg89
         xh0h4vuldxlwuUH/gx5j4/D/J94lY3mLJ93m3Rmkvjc+WgFA6N7hcMRAQ8lJIC3028Y5
         gAmDkEOpi04J7C62QScSCa21JhxXlifkh06BiDVf/wrpGITtiJybWs2aaz59IH8lneYc
         c2ndDKBXIEAM54jHFmhGZJcI29Jmi3384MIwRfAiYP5cE1hQwVKKVcP/EhG2L4tp/MHt
         OrFwxHqSmnvWcEhPKZdQU9UMTBV1tKVYsO8Gheilu7MjpglYfV7EVFvvTWWFYvoyNq+r
         7/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9mIQ6jM8juF2PvO8eUkaKKIYpJrRvH5Gc2fB112shtA=;
        fh=G8OgDvSzapJeegs+SudNoUS0d5GikXgRW+fYgoi7rcU=;
        b=JCYJgjZD4yjNTv3Y4JGoL/a8FE4nbDL9PzW8M7tuDv7/+qTuSMN3OTK0SZGySnWSl3
         sHid74bcDZ0xiLmarVOFoHMJV4fU34j3ud3S9WSaaI3yAfUJwyWTxQTOiiUYmTNBa2cm
         Emzc/1dEZlb/3wWxNN5DT2/15uOHupCksliLT4/vV1WSuHumAgFSwkDJa4SpQPhQFhdx
         oMZkq5LSSlzLV4yNYlLyQ435V2/V54rbhYoUjLIqtMukaaclVDqMHfwhnObqtfWtsYEs
         Eh3KHGbyQ3lewc93+IkeFtcdMDq+fqyZ5iryP3pw/EUIMhYOquqvw6BXn235Ny8nwjq8
         vAog==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789160352; x=1789765152; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mIQ6jM8juF2PvO8eUkaKKIYpJrRvH5Gc2fB112shtA=;
        b=C48Dw7fJKe/4oX3zH/S7R9zHwJ9ZyOxMqr2+bSTl+tqInaOLOa/pdlIzfeNBvJ4600
         o2Lk+N0FxrGDZz8uSaxpmkwEUBig4Q8BNvLpyV+w09SZ93C8zbq8iloF7HmltopcCsZG
         iED/U4sKgwgKKGnqXywTrYvJXKJZZ2DBGhJEH2qOhR2FqFssLWzIJwHf0srvKJhNW6lA
         j8hY4c401TbUJp71jwQ6kKnfxU5lAQ/m3pkwDzYkB21K5gfjYzb9Kt4JKNcg2jintvtJ
         7dKOtYBHX+PhGjXkvt2Mqdf8gmQROSvppzlJKuXAR/hug+eqVhjWcvW4yzHMGF8ZbdIr
         WClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160352; x=1789765152;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9mIQ6jM8juF2PvO8eUkaKKIYpJrRvH5Gc2fB112shtA=;
        b=HbNyJHBIoqXpUVJzLmg9xQJrB0a/U7Zqv8GPER+ThgP32aOmvO0JP1teAON9vTTwMA
         S5MqLgVxl54jJjUz/3EAtF/TMDgZoSaYRCCMppgDu6CEF0mc32d+DlELxch+UCVmgy5w
         QZi2ux8bGuADuWwzFoNIafnrHfB08y4Gzag25+k2YMADGz1jIbqGZ1vA+7rRSYjpgPtz
         vw3W9nYqtvyEV/HNkY8KHZzIe+cH7HWhf0ZTuQk9xm7t9nrJx2/ZWspbtmG1fqjBflKb
         rHpYUNHPY2sY7Z61w4XEUjAlNm6WHxex2/fAXOM9SvrqFdYapPvY5CxolTGtczst8r7F
         mCwg==
X-Gm-Message-State: AFuF++kJ/vhXnR3O2MyoRdIlPes1UHtygmrt839loH7WD3yeaaH8OgM2
	x4f/owzlhva5L++/qbeNvw9BB4IRa/Gvlm3KZT4pk1sw4vUL0YvKx9qL2wlOuCEZSQElB96baHQ
	0Ps3rlTNZOFwf6vntYhoFk2MHM+T8k7S4VRl0kKqg
X-Gm-Gg: AYBFou1gnO9Mx6OGkpSs7gP0DlDdwS2L5oqEiPJmBbziEx+WFZgELatlOFZ4fqNqx3s
	lp5kaEMMlYsTM33z52113mPTAHaupYuHr2lyCzESu0yc3tYSSRjx86RC9YjUy4mKy/iheKJY4nW
	Sjkgq0aMTkVdma0ykpTt0hyzJzjZ5xPjkAqJtdGIKXQF01PNks3XyYhGi5cstBSy4sPXgO4q5JI
	WVU+BQXmZbphukZsFdRpW9gxuIRTuHjGjlYPbZ1iAUJh6YCEWOi0QoBQhP9ZjtIprqVUDeifgw0
	Rdnz6bD58x5XZ+BZ1GMuDo6PJvlPvm4jqHd8W5M1SM4vYW5XhELJCPJpqVF/zlM68Ss+P9gO96M
	fxJlNQI5yNpIND+p8SsH3keOkMPrwHtsPC3xLJPXNRA==
X-Received: by 2002:ad4:5f8f:0:b0:910:4c56:76d8 with SMTP id
 6a1803df08f44-9121207d6d2mr79542346d6.1.1789160350811; Fri, 11 Sep 2026
 13:59:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 13:59:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 13:59:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aqRFSiicubfsw3N6@google.com>
References: <20260901180713.4185641-1-dmatlack@google.com> <CAEvNRgEs82CVTL_CUn=Ovrwvt86U1dxzr8psWGu=nk98ZH6Esw@mail.gmail.com>
 <aqRFSiicubfsw3N6@google.com>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 13:59:09 -0700
X-Gm-Features: AcwNN1VXiGYQy4JW0rBuiz4KjYly49Wx8Xl5G5ezJF-9TY2IawBLiOKUcfGow4s
Message-ID: <CAEvNRgFCrcyk6F0vJ11pgj2EDSUAXj6Zw-oEdZpfj2SrH1Cv9g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_135913_267518_FFD2F6F6 
X-CRM114-Status: GOOD (  41.42  )
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

David Matlack <dmatlack@google.com> writes:

> On 2026-09-11 11:04 AM, Ackerley Tng wrote:
>> David Matlack <dmatlack@google.com> writes:
>>
>> > This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a new
>> > UAPI to enable preserved files to be restored into a userspace-provided
>> > file instead of a kernel-allocated file, and uses this to support
>> > preserving tmpfs files in-place without any changes to the LUO ABI.
>> >
>>
>> I'm interested in the idea of retrieving folios into an fd for a
>> different reason, I'm exploring handling over ownership physical memory
>> to a guest_memfd.
>>
>> > The Live Update Orchestrator (LUO) API currently explicitly returns a
>> > new struct file for every preserved file during retrieve() (e.g. via
>> > memfd_alloc_file()). This then forces userspace to use anonymous memfds
>> > for all in-memory files it wants to preserve. This works reasonably well
>> > for VM guest memory but does not work well for other types of files that
>> > userspace may want to preserve (e.g. in-memory logs, binaries,
>> > configuration files, etc.).
>> >
>>
>> Does this assume that VM guest memory is usually provided using
>> anonymous memfds?
>>
>> More generally, is the problem that there isn't a simple way to
>> implement retrieval into anything other than anonymous memfds?
>
> Roughly, yes.
>
>> > Preserving entire tmpfs mounts in-place would require a large amount of
>> > kernel support and would effectively make tmpfs an ABI, which is a
>> > non-starter (or so I hear). Instead, we can delegate the reconstruction
>> > of the tmpfs mounts (directory structure, permissions, etc.) post-kexec
>> > to userspace. The kernel just needs to preserve the contents of tmpfs
>> > files and provide userspace a mechanism to restore those contents back
>> > into a specific file on the filesystem after the kexec. Hence,
>> > LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.
>> >
>>
>> Suppose pre-kexec, the data was in a tmpfs file (and fd), how would the
>> preservation work? Would the user have to
>>
>> 1. Transfer the data from tmpfs fd -> anonymous fd
>> 2. Preserve from anonymous fd
>> 3. kexec
>> 4. Set up the tmpfs fd
>> 5. Retrieve into the tmpfs fd
>
> No, the proposal in this series is to support:
>
> 1. ioctl(LIVEUPDATE_SESSION_PRESERVE_FD, {TOKEN, tmpfs_fd})
> 2. kexec
> 3. tmpfs_fd = open(..., O_CREAT)
> 4. ioctl(LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, {TOKEN, tmpfs_fd})
>
> No transfering to or from an anonymous fd is required.
>

Cool that preserving a tmpfs_fd is supported. How is that done without
preserving the rest of the tmpfs stuff?

Why is it possible to preserve the fd without the rest of the tmpfs
stuff but not retrieve without the rest of the tmpfs stuff?

Is retrieving into an fd a bit too much of a shortcut? Would preserving
the rest of the tmpfs eventually be required, and hence retrieval of the
rest of tmpfs should also be eventually supported symmetrically?

>> > An alternative approach to restoring data to a named file would be
>> > supporting a zero-copy sendfile() that can be used to convert named
>> > tmpfs files to/from memfds across the kexec. But this poses significant
>> > challenges on the *preserve* side since the preserved file might still
>> > be actively in use. The benefit of the retrieve-into approach introduced
>> > in this series is that it does not require dealing with two different
>> > files. There is only ever one file that owns the preserved memory.
>> >
>>
>> Would it be more symmetric if the process is
>>
>> 1. Transfer the data from tmpfs fd -> anonymous fd
>> 2. Preserve from anonymous fd
>> 3. kexec
>> 4. Retrieve into anonymous fd
>> 5. Transfer the data from anonymous fd -> tmpfs fd
>>
>> As to the exact details of "transfer", I think the best we could do
>> would be some kind of move from one fd's page cache to the other fd's
>> page cache?
>>
>> Is the goal of the transfer to avoid any memcpy and fully transfer
>> ownership (so, not just by increasing folio refcounts?)
>
> Yes this is the alternative proposal that has been proposed and
> discussed a little bit off list, with sendfile() and copy_file_range()
> being the possible mechanisms to do the "transfer". I think there are a
> few fundamental problems with that approach on the pre-kexec side.
>
>  1. iommufd requires that fds mapped into it are preserved. If the file
>     mapped into iommufd is tmpfs, but then we transfer that file to memfd
>     for preservation, iommufd will fail to preserve because the tmpfs file
>     is not preserved.
>
>  2. Even if you only use this feature for files not mapped into an
>     iommufd, transfering the contents in a zero-copy way seems
>     challenging. What do you do if the tmpfs file is still in use when
>     you want to transfer it?
>

When you say in-use, I suppose you mean folio is in-use by some IO and
is mapped in IO page tables, and that the IO must continue while the
folio is transferred?

Are you expecting guests (as in stage 2 mappings) to continue to be
functional while the folio is transferred?

I'll have to think a bit more, I was initially thinking of just
transferring folios where I could unmap from everywhere (processes,
stage 2, IO page tables) for the transfer.

>> > By leaving file and metadata allocation purely in the purview of
>> > userspace, programs can create the target files where they want, with
>> > the names and security permissions they desire, before directing the
>> > kernel to restore the preserved folios into them.
>> >
>> > Currently, only tmpfs shmem files are allowed as valid target receptors.
>> > Attempting to target populated files, or anything other than an empty
>> > shmem file, will trigger -EINVAL. HugeTLBfs files could be supported in
>> > the future.
>> >
>>
>> Is this basically that at some point, all in-memory filesystems' fds can
>> support transfers?
>
> Yes, theoretically.
>
>>
>> >
>> > [...snip...]
>> >

