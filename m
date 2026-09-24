Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C848C98318
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zl2fNi5BfSzkgDSihIsrR46mveZ03y1JQtjuR5aZ97A=; b=YP+xprsYYOE0B6kNJIBircTR5d
	xgVXm5B4RyQV53u+t0KemrQkUA9NllcZXVweDY0PIxxiE+4iMkPzk0NZQ7Mm8qNFGmTRCFXVI6C2A
	mzkRcR5AcL+GE464mNCC8846qRO3IcObQ7EakRogKCC+w5ez9bCdjXzDjzJjXLqM0cGlzTcJKHVNH
	UIgk1x3VR4/YGTZLrp8xdxrERMIA6Ku4DTQkoan/NBwcxEKQrlu0t+RCPV8Z5kLhANNCWyvqTNSac
	9gCOvRg3Vx21J6cb41OeXo+N0Eu5FYRj5DzPG1+ZrDTmXVDYplK6RRzwm88J/7Sr4LH9CVIWQpgG2
	z19wmvKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9qht-0000000CCHv-49NK;
	Thu, 24 Sep 2026 21:10:17 +0000
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9qhq-0000000CCHV-4AA0
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 21:10:16 +0000
Received: by mail-pz2-x0c.google.com with SMTP id 41be03b00d2f7-cc75e33cc69so72456a12.0
        for <kexec@lists.infradead.org>; Thu, 24 Sep 2026 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790284213; x=1790889013; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zl2fNi5BfSzkgDSihIsrR46mveZ03y1JQtjuR5aZ97A=;
        b=LN3mHwvyqa7LFaB7+xe3PhwgL8URtTgFOJj67O7M5KcSUgTPgDA/W9iM5o88gvFDxr
         5Pe4+w/zlwz2g9aNQ0zalzJzMhbEdV0dnjAMQNM4SESP5d2PKcaRe4QArQenqlNMU34N
         VGSzRPDZyO8PItxT3vEs1jhVuTWF8fsxkN8QOBUkwHtKiwwziIVTpohyz22q1+L0Blky
         a71vkRgd17+65iu+0Hw9GGpO9Hz0519fw5jD+V1AkXm8jbXQq9Hto95pKEz3qaX7mgRe
         5fOrLV1PPqUbiTvJo55fFn4AxgaqMLkPIgiaJHySRYiqhEjW/7J9LnB7MfKhbrqGZkTU
         VQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284213; x=1790889013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zl2fNi5BfSzkgDSihIsrR46mveZ03y1JQtjuR5aZ97A=;
        b=zQEXZjWs9NPO4REFAY8wKMJZ3bputiHMBWLdvOmhuMG36JzjkPFRhoQGyz3c8rMaZf
         nvDInuQeLp5N8EMhsDX9Y3BVL4vs//2p1lcTSAeXYtlTluGcIoffP9rfpwVw/Oj91e7c
         YIkg6uuFGREJUnVAUXf1DuIZdGseYfU8fbfIY8zU5wyofIsPteayXr5+OmRLq1qsThWG
         hq4IDw01uOlHAznfH+P9mH8CX1D3JAHABemMFc0BxPSdhxRVrj7id9k1Vib5KtjfGNjA
         SBls+BtMjsyh5AZKVOwCQGZHSP/Tj4ZDuubRybIsdmPy6aGW3hVa69cRyiap7xXx28b3
         H0wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLKpkGw3oFZW1KZiX/xHQhOLnYPRiTGOKAwod+DnAMJ0IiPmZIM6taa/Nlt++zpOFsr9AjXg==@lists.infradead.org
X-Gm-Message-State: AFuF++kjxj00zDYfTnEsM0ELwYjvwt9WBEHlXlZkfgLTo257MJmXa5Yu
	KEPs6cB96q3Zace29bThO/t/mKm+hNHO/5igGSBMMMNNNnleeKOx+cshb/S9i1ES4fc/usPZLGC
	+Du/Q+A==
X-Gm-Gg: AYBFou38JPxOwyHOevyQIXMupXIPnui7z/VZI2kCmphaCPVSoN3re4xLMl17d04NqBS
	q5shh5OihpjFRoXyEHph3qxSKIeyZzwCw+D9rBfluDnQr5mP+6OB0+brVDj/VIssDrAXzj3eq6r
	Evt+z+mvJrrnMAyclvPOuSMtGy16sVgHqkRnBovbbAp7RHA+okIQNalJyUa9IaSuJnBn/hzlEx8
	7WBUw6fl2VoD777NTs5GBmTxcRif4QpI42ESMeeCgh4UlRAxP1WEiMHlKwyS+Y5yurSIbsDE8Ap
	wRktaNkRU1afNLlCqFrACoulKnod2Iy7exM2Fy9PaO9BfVd6st31YwtwDPQ3doiM09rxjUaZRuE
	bBnBnhbYkYjYnogfK03CPk5sApOts3eB9nkee8OC2rfzfEDLhy7SeC9sYekbZQ/tJ5pAb3nyfat
	/y+jz0LjSDNPDJt6rPqYRaCi/gv5PVGjz5EV3v0ye+du6+fTdqljEtQYoWADcuz3VBHVh5lYjwU
	bQsNX0j0tjqgN1ipW5SSfYGYo/HWbzp6SvV571C
X-Received: by 2002:a17:90b:3d81:b0:3a0:2c7d:edd7 with SMTP id 98e67ed59e1d1-3a098ad4cb9mr3516520a91.10.1790284212075;
        Thu, 24 Sep 2026 14:10:12 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9892dbfsm434036a91.11.2026.09.24.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:10:11 -0700 (PDT)
Date: Thu, 24 Sep 2026 21:10:03 +0000
From: David Matlack <dmatlack@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Alexander Graf <graf@amazon.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] luo: tmpfs preservation
Message-ID: <arWRq4ZRbmyWK4SI@google.com>
References: <20260923224408.3745689-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923224408.3745689-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_141015_044809_49AFDED6 
X-CRM114-Status: GOOD (  44.34  )
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

On 2026-09-24 12:43 AM, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> I brought this idea up in this week's Hypervisor Live Update bi-weekly.
> I decided to try using an LLM to see if it can produce a
> proof-of-concept quickly. This series is the end result.
> 
> The main use case is preserving in-memory files that have a filesystem
> path. We already support memfd preservation, but memfds can't be linked
> to a (user-visible) filesystem. This is needed for storing VMM packages
> for live update on hosts that don't have a disk. A cold boot fetches the
> binaries from network, but that is too slow for a live update.
> 
> David tried to solve the problem by introducing
> LIVEUPDATE_SESSION_RETRIEVE_INTO_FD [0], which lets you provide a FD for
> LUO to retrieve into. This is an alternative to the idea. It uses the
> standard preservation and retrieval API that LUO already provides.
> 
> The core idea is to allow userspace to preserve a tmpfs mount FD. Once
> the mount is preserved, userspace can pass in regular files in that
> mount for preservation. The files take a dependency on the mount token,
> and that is used for retrieving the files in the right mount. This saves
> us from doing a full FS preservation and makes preservation of each file
> explicit.
> 
> Currently only files in the root are supported. Files in subdirectories
> will be rejected. This is mainly for simplicity. Complex mount features
> like memory policies, id mappings, or casefolding are also not
> supported. All these can be reconfigured after retrieve if really
> needed.
> 
> The code re-uses a lot of the preservation and retrieval logic from
> memfd preservation. It only adds some extra file and mount metadata on
> top.
> 
> As I mentioned earlier, this is heavily LLM generated. The code is not
> very polished and has some rough edges. That said, I have read all the
> code and did significant cleanups of the LLM output. This includes
> turning the 1600 or so lines it generated to a more modest 977 lines.
> So (I think) it isn't complete AI garbage. And I think it does get the
> core idea across.

Hi Pratyush,

Thanks for posting this. I wanted to compare this series against the
RETRIEVE_INTO_FD approach, since both are trying to solve the same
problem: preserving files with filesystem paths across a Live Update.
Both are RFCs, so I'm going to ignore implementation details and focus
on the design.

As we discussed at the Hypervisor Live Update bi-weekly, this will be a
topic to discuss at LPC. I'm hoping we can use this thread to align on
the pros and cons of the two approaches so I don't unintentionally
mischaracterize anything.

At the memory level the two approaches are the same: file contents are
handed over using the existing memfd folio ABI and re-inserted into a
shmem inode in the new kernel. The difference is who owns the filesystem
topology around those folios.

  - RETRIEVE_INTO_FD: The kernel preserves only memory. Userspace
    own the fileystem topology, recreates it after kexec with normal
    syscalls, and then asks LUO to fill each empty file with its
    preserved contents.

  - tmpfs handlers (this series): The kernel preserves the mount and
    the files as first-class LUO objects (name, mode, pos, etc.),
    rebuilds them after kexec, and hands back a detached mount.

Everything else below follows from that difference.

Comparison
==========

What LUO preserves:
  RETRIEVE_INTO_FD: Memory only.
  tmpfs handlers:   Memory plus filesystem objects and metadata.

New uAPI:
  RETRIEVE_INTO_FD: One new generic ioctl, or a generic extension to
                    the existing RETRIEVE ioctl.
  tmpfs handlers:   None. Existing PRESERVE/RETRIEVE with new file
                    types.

New LUO ABI:
  RETRIEVE_INTO_FD: None
  tmpfs handlers:   Mount and file structs, plus a version bump for
                    every new attribute added in the future.

New VFS surface:
  RETRIEVE_INTO_FD: None.
  tmpfs handlers:   Kernel-created mounts handed to userspace as
                    detached mounts.

Where the filesystem topology description lives:
  RETRIEVE_INTO_FD: Userspace, in a private format it can evolve
                    freely.
  tmpfs handlers:   Kernel ABI.

Mount options:
  RETRIEVE_INTO_FD: Anything userspace can pass to mount.
  tmpfs handlers:   Only what the ABI enumerates (currently the block
                    limit and root mode).

Dirs, hardlinks, symlinks, ownership, xattrs:
  RETRIEVE_INTO_FD: Free. Userspace recreates them with normal
                    syscalls.
  tmpfs handlers:   Each requires new kernel code and ABI.

Userspace complexity:
  RETRIEVE_INTO_FD: Higher. Userspace needs a manifest, then must
                    mkdir, create, chown, etc. before calling
                    retrieve_into.
  tmpfs handlers:   Low. Preserve the mount and files, retrieve them,
                    and move_mount().

Metadata consistency:
  RETRIEVE_INTO_FD: Userspace must snapshot and keep its manifest
                    consistent with what it preserved.
  tmpfs handlers:   The kernel captures metadata at freeze time,
                    atomically with the contents.

Trust surface for previous-kernel data:
  RETRIEVE_INTO_FD: Userspace validates its own manifest. The kernel
                    only validates the folio list.
  tmpfs handlers:   The kernel must validate names, modes, etc.

Generality:
  RETRIEVE_INTO_FD: Applies to any handler where "fill a
                    userspace-created object" makes sense.
  tmpfs handlers:   tmpfs only.

Arguments for RETRIEVE_INTO_FD
==============================

1. It follows the principle that LUO should only preserve what
   userspace cannot recreate. Names, modes, ownership, directories,
   and mount options can all be recreated by userspace. Memory
   contents cannot. This approach draws the line exactly there.

2. The kernel ABI stays small. Every attribute the tmpfs handlers
   learn to preserve becomes a stable KHO ABI that has to be
   maintained across kernel versions. Reaching parity with what users
   will eventually want (subdirectories, ownership, xattrs, ACLs,
   symlinks, hardlinks, huge=, mpol, quotas, idmaps) implies a long
   series of ABI revisions. RETRIEVE_INTO_FD gets all of that for
   free via existing syscalls.

3. Policy stays in userspace. The target file lives on a mount that
   userspace configured, in a cgroup and namespace of its choosing.
   The kernel never has to guess the right configuration for a
   recreated object.

4. It is a reusable LUO primitive rather than a tmpfs feature.
   "Retrieve into an object that userspace already set up" could be
   useful for other handlers where the object must be created in a
   specific context, e.g. HugeTLBfs files come to mind. The tmpfs
   series adds a one-off pair of handlers.

5. It requires no new VFS surface. There are no kernel-created
   mounts being handed to userspace, so the change stays contained
   to LUO and memfd, which lowers the cost of getting it upstream.

Arguments for the tmpfs handlers
================================

1. It gives a filesystem-shaped abstraction from the kernel's side.
   The kernel knows that the preserved files belong to a mount,
   tracks that dependency, and returns a working filesystem. This
   maps directly onto the stated use case of VMM binaries on hosts
   without local storage.

2. Metadata is captured atomically. Name, mode, size, and pos are
   captured at freeze time alongside the contents, so they cannot
   drift. With RETRIEVE_INTO_FD, userspace must keep its manifest
   correct across any renames or chmods that happen after it takes
   its snapshot.

3. The restored mount can be hidden until it is ready. The mount
   comes back detached, and userspace chooses when and where to
   attach it with move_mount(). Nobody can observe a half-built tree.

4. There is less for userspace to do. For the simple case of a
   single tmpfs mount with a few files, userspace needs very little
   new code.

5. It leaves the door open for whole-tree preservation. In the
   future the kernel could preserve an entire mount with a single
   token by walking the tree, which RETRIEVE_INTO_FD cannot express.

Where each approach hurts
=========================

RETRIEVE_INTO_FD pushes work and correctness onto userspace, likely
requiring a shared userspace library or daemon. The kernel also has
no notion that a set of tokens formed a single filesystem. It just
sees unrelated files.

The tmpfs handlers are narrow in scope today, and every extension is
expensive. There is a real risk of slowly growing a partial
filesystem serializer in the kernel. It also couples LUO to VFS
concepts such as mounts, namespaces, and names.

A possible middle ground
========================

The two approaches are not mutually exclusive. We could use
RETRIEVE_INTO_FD as the core primitive for file contents, and provide
a shared userspace library for the common "rebuild this tmpfs" case.
Kernel-side mount preservation could then be added later, if and when
a concrete need comes up that userspace cannot meet, such as an
atomic snapshot or availability before userspace runs.

That keeps the kernel ABI limited to memory, which is the part only
the kernel can preserve, while leaving room for the more integrated
model if it turns out to be needed.

Thanks,
David

