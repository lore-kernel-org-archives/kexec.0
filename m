Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7BEC88E53
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vv9o4OWee1pnKi5CCaT/T/8GgHGqw9lOYuHZfnosco=; b=Gsa/tiXwfdJiuMYZiuk0KEThp1
	+V87OHsQLXVzTTEd+A+Qi/Bp4j9grhtTwfPbE+3WBh9UjFmrPI0dm06RgxgbFrYZKTBRYffBkhUkL
	ZnjvkzpysGzbA3WBq52WbJj2zq82aFMLL8JPx6AmL7japO3B0998hvMrJcWzUihueo5D995Jig07k
	Gl2nd4tem9cb8C7WDkb09OxsNOv2UHB596l263kwgugj0M8GXay/mowXnVmpl929b/M/JeZvHtni1
	2pioV1SSDU02lT6QSlkmnvobeWgWw0/eSnYlfn/t5CzCgol1ebVBkPXiD1AQhsI7Ja8uepbd58CGI
	Mp7EuVSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x55bl-0000000HPJR-2kjV;
	Fri, 11 Sep 2026 18:04:17 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x55bj-0000000HPIm-0NYk
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 18:04:16 +0000
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-66e4ab2029eso44296d50.1
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 11:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789149853; cv=none;
        d=google.com; s=arc-20260327;
        b=ixNFNE47MLpx+fJslNTZ8oj3+Z7iRKwSoL+eOQg+TfLSL5oj9UxYPVtjFF06+b2nip
         YRIHWSQR0EOAsb3BkAfz40mnxA8JMDgKRvBtaQMjC2EsA8dysRkfCm4Gf39sEY00k0zn
         y/epRYCgT82ppkFx0AMrT0YegZrbSlw0GFfmP5u0IUgE8Qh1nKDzmnkPZuA7a8V11lAZ
         NiGTvgoWZmAtDmuH/LUIhG0JoBge4CzS3Nx/kLyeQMKEM/JUDZCm3yDELQUnkVaRqGK+
         0BoCjBHxmZzjBSDpiBuh/mdpoufmtpgbuXfVyEoZUuIW0+gl06OX40cJ80gxSMQ6Wr5P
         h8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7vv9o4OWee1pnKi5CCaT/T/8GgHGqw9lOYuHZfnosco=;
        fh=sF+4m6LQa3HHWbGe7p5IOexo2noyEVT2FyIKH0pmbE8=;
        b=JkY6buahIDPcSgVsUVE/vqpALfe7ZA4UIrLN+EuER4WBEUmnB4rBA2CQxI61dfYIaF
         cLswXBPfWrfkFHQFcz36m5LgMBswyuq5N5/KgY8S98PL147FP6Y9fd09YTiDvLYP7J9s
         5/EnHxnT2LhK0/9F3wcHktvL7XNyAnCRmG7GpXW61rDSpZzRO8dVbMgPG5XoDejqGUIb
         ZwVqzumeLcnIpXoA17nRfA3ISiCdC86GCX5mLteQHdbEJFnXejNxKoaFSTPcWO0E/rLT
         3kE85YjohGjvH6bnI1qrGjakHFXzlKPIEETWXDw8T4jt78nKhxkFlt056kFk7j6Z7vFd
         dCgw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789149853; x=1789754653; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vv9o4OWee1pnKi5CCaT/T/8GgHGqw9lOYuHZfnosco=;
        b=TTtCl9OjZv3AXDC6FKxSbzQvJvczGOjdIHgbD7cxJan+71M+e93AGaVl1dCugF9x2P
         Jbj0MiHlLaalN0OQTF7+DjGPk4QNCKhsynh8ZOUpCDoJAUvrkYSF3yXElFu3bhc9Ty/J
         W9/VgUZ0SAabqS+ILBZFIfOYfAu1MF13sqXlMc++5Lseu7yPqc42bFP0fS9w+XJTimqI
         WtTtiQCXWNC87ml3d3bHlRB8cVAhbb17InCg7ODGgFRu3W9SbmH+Z8PE1bYh5Lp/bFc8
         Q5OX1uzYDkCdoBRAO3x8coGtuE8Lj4rxsUFlUjiNfkx+p6kwzzoXVSUIkvXgX2D4+LAS
         ae8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149853; x=1789754653;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7vv9o4OWee1pnKi5CCaT/T/8GgHGqw9lOYuHZfnosco=;
        b=WlJZ6Yy1BZoqo5qg8EB54gB0NjC4iPxdaUxeMpdHYAYNhm1hEDz1eu1LB7yFyTjx/1
         n3HuHPXvvIkh+iwxSiKepAPcEElVfXyW19BwEwdoccESO+pByO/fhgII/RSbxFqTRXxo
         JJV3DurxlLqQdo6ftMecu0lGEMFroQnFyNoCVlsVZ0qMY0j0GZjC5o4KcZetWKylbMUz
         /9KEsC3NA9yx+ZZv0EAhw7BoPh0Kl0hedQnqFTiK2qsrCmF+XOoid6wqJHss2ffp0V9j
         OYh6qL3OsW9R1pLT30mhHDBxLkDTF78AqzbzjVxshcZvNN0bfLgNlC957nExj/LtHGGC
         s05A==
X-Forwarded-Encrypted: i=1; AKwUvBwetRdUo0AgG1eVQQrx3CvlNKroPWhzP2eqpcy/Vl547g1BMgn670oS3Fl03ohB1B/RkkIYPg==@lists.infradead.org
X-Gm-Message-State: AFuF++n7kjb+0wqq9oq78mVSciHGgguWtxAvB2ZBj+QUnG86TIrhafFW
	rOL7d4xwT8JsY4uOeQh7aaXiwMTs2UlgPVUzVZCWp9E1rbeeFsPQtCcKmfMdd6bXpDUdMd5rmGd
	U1DIzf+pp4CXQ92+ds85Gjv7juJDtrpzH2y7dyMrP
X-Gm-Gg: AYBFou3b1PX+QJyosP3Wb5bJJQuHSukxAm4sw2posnaa/4+/n16DZfNSElpdaUyExYl
	2xaw1wpU6IHMc0HzDb0S6IaDhFCEq0Y/0GV6Py6Qy0nORUeSTnrvU15fYJ3czzfJ8IPN3ULlNaw
	FowrRJVdDHPY4L3lc3aQmfOW3XtSd5QVb+ttPxXwaGBuWwfinA0oFDgdC2+8mX2tsLyNBVQP1kM
	boJ9soEVoVnilNU/NtsIJR8XlfXu027Vz3LeCVamVWuDaO1Lsh3xwztcAmuTkFcdPoqDWWyxSEh
	a2+shl50uGYYPO1xLSWmLxnfGCpWWnbX2JVjyS8BMHnEb7LYNsbkpjS3R8Gp4F3ljcpXHFiNASb
	2Zsz11o1LKLrOlYA6WmXQVCYCDEEIfZzvy3mOFxHOTA==
X-Received: by 2002:a05:690e:1341:b0:66f:c1bc:87eb with SMTP id
 956f58d0204a3-671249f425bmr1974723d50.68.1789149852145; Fri, 11 Sep 2026
 11:04:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 11:04:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 11:04:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com>
References: <20260901180713.4185641-1-dmatlack@google.com>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 11:04:11 -0700
X-Gm-Features: AcwNN1VDqbMSWzZBtW5WvtCjBXts_71wkcwIE-pv_51Ep9lT2w25BfsfGqo2_lU
Message-ID: <CAEvNRgEs82CVTL_CUn=Ovrwvt86U1dxzr8psWGu=nk98ZH6Esw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_110415_166856_01CF1760 
X-CRM114-Status: GOOD (  27.10  )
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

> This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a new
> UAPI to enable preserved files to be restored into a userspace-provided
> file instead of a kernel-allocated file, and uses this to support
> preserving tmpfs files in-place without any changes to the LUO ABI.
>

I'm interested in the idea of retrieving folios into an fd for a
different reason, I'm exploring handling over ownership physical memory
to a guest_memfd.

> The Live Update Orchestrator (LUO) API currently explicitly returns a
> new struct file for every preserved file during retrieve() (e.g. via
> memfd_alloc_file()). This then forces userspace to use anonymous memfds
> for all in-memory files it wants to preserve. This works reasonably well
> for VM guest memory but does not work well for other types of files that
> userspace may want to preserve (e.g. in-memory logs, binaries,
> configuration files, etc.).
>

Does this assume that VM guest memory is usually provided using
anonymous memfds?

More generally, is the problem that there isn't a simple way to
implement retrieval into anything other than anonymous memfds?

> Preserving entire tmpfs mounts in-place would require a large amount of
> kernel support and would effectively make tmpfs an ABI, which is a
> non-starter (or so I hear). Instead, we can delegate the reconstruction
> of the tmpfs mounts (directory structure, permissions, etc.) post-kexec
> to userspace. The kernel just needs to preserve the contents of tmpfs
> files and provide userspace a mechanism to restore those contents back
> into a specific file on the filesystem after the kexec. Hence,
> LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.
>

Suppose pre-kexec, the data was in a tmpfs file (and fd), how would the
preservation work? Would the user have to

1. Transfer the data from tmpfs fd -> anonymous fd
2. Preserve from anonymous fd
3. kexec
4. Set up the tmpfs fd
5. Retrieve into the tmpfs fd

> An alternative approach to restoring data to a named file would be
> supporting a zero-copy sendfile() that can be used to convert named
> tmpfs files to/from memfds across the kexec. But this poses significant
> challenges on the *preserve* side since the preserved file might still
> be actively in use. The benefit of the retrieve-into approach introduced
> in this series is that it does not require dealing with two different
> files. There is only ever one file that owns the preserved memory.
>

Would it be more symmetric if the process is

1. Transfer the data from tmpfs fd -> anonymous fd
2. Preserve from anonymous fd
3. kexec
4. Retrieve into anonymous fd
5. Transfer the data from anonymous fd -> tmpfs fd

As to the exact details of "transfer", I think the best we could do
would be some kind of move from one fd's page cache to the other fd's
page cache?

Is the goal of the transfer to avoid any memcpy and fully transfer
ownership (so, not just by increasing folio refcounts?)

> By leaving file and metadata allocation purely in the purview of
> userspace, programs can create the target files where they want, with
> the names and security permissions they desire, before directing the
> kernel to restore the preserved folios into them.
>
> Currently, only tmpfs shmem files are allowed as valid target receptors.
> Attempting to target populated files, or anything other than an empty
> shmem file, will trigger -EINVAL. HugeTLBfs files could be supported in
> the future.
>

Is this basically that at some point, all in-memory filesystems' fds can
support transfers?

>
> [...snip...]
>

