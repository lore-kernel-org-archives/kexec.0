Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02753606EE8F
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qewdcJME;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aEWWWx55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=6yjgp9P+tr1bzQJ5Up7RsRaaww+TiEVtVQnPOHgsXSk=; b=qewdcJMEcHsllU5z5SdWyoaHaq
	PuuNtJwN/YOOeIeT2sdsolU5rJfHDFh8c2yGTJ2qiodK17l/tOPN7ahqBocOW6mU8ND4S7fRD2J33
	wn8JAFXpT9gg+qR/8bwe5erz1/4gcD1QzVPjdGittVKhWgdYi7UnzmsA1KLMPN45OJkVogc2AGVj8
	w1t6ZfV0Ia8XXbUJy++68dMiqurxKvkzggdtq0+mTTtuxdIEAFdf4djNJwcsrgxSejRsMOBaZ2zwH
	IuYyGK2ojkB9tk/vYAa1K1IEYqKo2WcMRmMrQdYt//Dez/4mzzXHvh2uRT/LoER4T42tDkzcjGZzY
	uSnEKfFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v1-00000000m9k-242s;
	Tue, 03 Nov 2026 01:02:31 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2uy-00000000m7V-24Cz
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 01:02:30 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e941532594so40857345ad.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 17:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667745; x=1794272545; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6yjgp9P+tr1bzQJ5Up7RsRaaww+TiEVtVQnPOHgsXSk=;
        b=aEWWWx551LMF5S36hptdK6B1mg4VUKAECuk18qfDE6Ap9Y9LuYesgvVg3oLcbDT/aH
         Ikj7ggYC45U7Ni52zXbjD272A9vhHaP2Z3Fg3qWCTDzO5DQbZ5PnbfPA+HzmovuXLPOo
         S8ddA6QFZA1kD98bj5v/r6EjombEiOCsrboSUx0AcLtA8peJw/v27yUuiChtT4pIJAcN
         Ls1Lt4d9CRKN5luhWZFhxNx1itvkoK9qK3xRA5cyrOz0UJ7Z/bqY5HW8EeyWVHuKrOah
         t5m15edbufnA+AlsWA3SpGn1APnZRyQY8/j15l3QtHeoHfswJrYfMxmebtERFsBYcoKh
         OC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667745; x=1794272545;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yjgp9P+tr1bzQJ5Up7RsRaaww+TiEVtVQnPOHgsXSk=;
        b=oVOP8ELdM52dYiDqSBzW7V4CZWpdk55qS1c1i5fvUxqckKGbDviK5pIuM8VNbAVQLr
         o/mkuOAKjvUIS8lXuc68Tv7QuBm2ZKZpbz8qxE2eRtsViZ+DVJuspmtK0jJ83eeJYppO
         q+6jwyLjN19vc4OwKp43YTleK7KPoOtTbbOZkxu8V8BP+D69WiPeYiTJhO5pkDKGNlBs
         hUICr/xLTaF7NuVBY/fqn7Ufa97K380G3NzBT++lz69BC/MeDmUVYmodkEY3nvN1OFYH
         co7E8ZGm7VO2UkASqWapYUZODzJRQqUy8jo88YbHE5ITbaSstz6fcG3X4R7JGA5n6QC5
         QsJg==
X-Gm-Message-State: APuU4Z+MjVlfdBvNGIxeAAM1ap1aNTyeW7GzU2EPs4CE2Nt+bij0Wp+/
	3dac8PcWRJA+D0hpBwr9WECjNGTNB2qy437ggd4XsPT+mrEYij7YHYNqYwnBOwyoxaphwp7et58
	uXaj0cMxAJ2t+gsD6WtwBd1/gCODzOrjnj8EL/EtroNFkaxkvwAky3VtTSZ/PcEl3MovDto83v0
	DT1kxnEj0qb+E1314A/svG+jTT0JXad2OxgDoH9NJJEAH0yHBCZW8=
X-Received: from pjbfh3.prod.google.com ([2002:a17:90b:343:b0:3ac:7545:d82e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b90:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3ae8984b662mr9765034a91.58.1793667744325;
 Mon, 02 Nov 2026 17:02:24 -0800 (PST)
Date: Tue,  3 Nov 2026 01:02:06 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103010216.3447716-1-dmatlack@google.com>
Subject: [PATCH v3 00/10] liveupdate: Preserve tmpfs files across Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_170228_685901_DC3FB708 
X-CRM114-Status: GOOD (  33.34  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/tmpfs/v3

This series allows userspace to preserve files on tmpfs mounts across a
Live Update, in addition to memfds. Today the memfd file handler only
accepts unlinked shmem files, and LIVEUPDATE_SESSION_RETRIEVE_FD always
restores them as anonymous memfds. Userspace therefore has to put every
in-memory file it wants to preserve in a memfd, which works for VM guest
memory but not for other files that live on tmpfs mounts, such as
in-memory logs, binaries, and configuration files.

The kernel preserves the contents, size, file position and seals of each
file. After the Live Update, userspace retrieves each file onto a tmpfs
mount of its choice and links it at the path of its choice, so userspace
decides the directory structure, names, owners and permissions of the
restored files.

This series builds on the per-file-handler argument for
LIVEUPDATE_SESSION_PRESERVE_FD and LIVEUPDATE_SESSION_RETRIEVE_FD from
Pasha's v1 [1], following Pratyush's suggestion on the RFC [2], and on
the design discussion on Pasha's v1 [3].

[1] https://lore.kernel.org/kexec/20261015093816.2438942-1-pasha.tatashin@soleen.com/
[2] https://lore.kernel.org/kexec/2vxz7bjmkjeu.fsf@kernel.org/
[3] https://lore.kernel.org/kexec/atE53vmlDeA4cWD2@google.com/

Series Overview
---------------

This series implements the following:

  1. Let userspace pass a file-handler-specific argument to
     LIVEUPDATE_SESSION_PRESERVE_FD and LIVEUPDATE_SESSION_RETRIEVE_FD,
     and let file handlers mark retrieve failures as retryable, so that
     userspace can fix a bad argument and try again without losing the
     preserved file (patches 1-3).

  2. Rename the memfd file handler (memfd_luo) to shmem_luo, since it
     preserves shmem files, which will include files on tmpfs mounts.
     Preserving memfds created with MFD_HUGETLB will need a separate
     handler, so naming the handler after the filesystem avoids another
     rename later. The compatible string stays "memfd-v2" (patch 4).

  3. Fix two existing problems in the retrieve path: a WARN_ON() that
     userspace can trigger when tracking a retrieved file fails, and a
     leak of the preserved folios when a retrieve fails before it
     restores them (patches 5-6).

  4. Retrieve files that were preserved from a tmpfs mount onto a tmpfs
     mount chosen by userspace, via the new struct
     liveupdate_shmem_retrieve_arg. The kernel creates the file as if by
     openat(dirfd, ".", O_TMPFILE | flags, mode), so the file gets the
     same flags, owner, permission checks and security labels as any
     other new file in that directory, and is charged to that mount.
     The kernel fills the file before returning it, so nothing else can
     access the file before it is complete, and userspace links it at
     the path it wants with linkat() (patch 7).

  5. Allow preserving tmpfs files that are still linked, and require
     permission to change the size of a file to preserve it, since
     preserving a file freezes its size for all users of the file
     (patch 8).

  6. Allow retrieving tmpfs files with O_RDONLY so that restored
     binaries can be executed before the session is finished (patch 9).

  7. Add a kexec selftest for preserving and retrieving tmpfs files
     (patch 10).

uAPI Changes
------------

  - struct liveupdate_session_preserve_fd and struct
    liveupdate_session_retrieve_fd gain a 64-bit @arg field, a pointer
    to a handler-specific argument that starts with a 32-bit size
    field. Callers that pass the old struct size are not affected.

  - Passing a non-zero @arg when retrieving a token that was already
    retrieved fails with -EBUSY instead of silently ignoring @arg.

  - New struct liveupdate_shmem_retrieve_arg, with @dirfd, @flags and
    @mode, for retrieving tmpfs files. Files that were preserved from a
    tmpfs mount can only be retrieved with it, and memfds can only be
    retrieved without it. Unlinked tmpfs files (e.g. created with
    O_TMPFILE) were retrieved as memfds before this series, and now
    require the argument too.

  - Preserving a file now requires permission to change its size (see
    Open Questions).

ABI Changes
-----------

  - struct shmem_luo_ser (formerly struct memfd_luo_ser) gains a
    SHMEM_LUO_FLAG_TMPFS flag in its existing @flags field, which
    records that a file was on a tmpfs mount rather than the internal
    shmem mount that memfds use.

Open Questions
--------------

  - Preserving a file freezes its size until it is unpreserved: For all
    users of the file, truncating it, fallocate() and writes past its
    end fail with -EPERM, and the owner of the file can't undo that.
    Linked files can be reached by anyone who can read them, so without
    a permission check, anyone with a session fd could preserve e.g. a
    world-readable file in /dev/shm through a read-only fd and break its
    owner. Patch 8 therefore requires permission to write to the file
    (inode_permission(MAY_WRITE), but neither a file opened for writing
    nor a writable mount), or ownership if the file is immutable or on a
    read-only superblock, since its size can't change anyway. Like
    FS_IOC_ENABLE_VERITY, it also requires the file to be opened for
    reading and rejects append-only files. The checks apply to all
    files, including memfds, where they pass in practice since memfds
    are created with mode 0777 (or 0666). Is this the right permission
    model for preserving files? Should this apply all files or just
    shmem files?

  - Is patch 9 (retrieving tmpfs files with O_RDONLY) worth merging?
    Without it, userspace can only retrieve files O_RDWR or O_WRONLY
    which then LUO keeps open until the session is finished, so
    executing a restored binary fails with -ETXTBSY until then.
    Supporting O_RDONLY retrieve is fairly simple so I think it is worth
    supporting.

Merge Plan
----------

This series applies on top of the next branch of liveupdate.git
(commit 27be83a12b24 ("Merge branch 'lu-pci-preservation' into
next")) and is targeting Linux 7.5.

The series will be merged through liveupdate.git.

This series conflicts with Pratyush's "mm: allow freezing mappings"
series [4], which also changes mm/memfd_luo.c and replaces
shmem_freeze() with mapping_set_frozen(). Whichever series lands second
will need to be rebased. Pasha suggested keeping retrieved files frozen
until the session is finished [5]. That builds on AS_FROZEN, so I think
it fits better in Pratyush's series.

[4] https://lore.kernel.org/kexec/20261027173031.763213-1-pratyush@kernel.org/
[5] https://lore.kernel.org/kexec/179322496574.1894369.544573858973645958.b4-review@b4/

Testing
-------

All patches were build-tested individually. The series was tested on
x86_64 and arm64 in QEMU using the Live Update selftests:

  - luo_tmpfs (new): 33 test cases covering the contents, size,
    position, seals and holes of restored files; creating the file like
    open(O_TMPFILE), with the requested flags and mode, the caller as
    owner, and O_EXCL; executing restored binaries before and after the
    session is finished; preserving files through read-only fds, on
    read-only mounts and superblocks, and immutable files; rejecting
    files that the caller can't write to, write-only fds and append-only
    files; block accounting on the target mount, including large folios
    that extend past the end of the file; mount and memcg limits;
    memfds; invalid arguments; retrieving a token twice; and that no
    kernel warnings are triggered.

    The main downside of this new test is that it is large (2k lines).
    It was trivial to generate with AI, but can understand if it is too
    large to review. I can look for ways to simplify it.

  - luo_kexec_simple, luo_multi_session, luo_stress_files and
    luo_stress_sessions.

  - liveupdate (including the new preserve_memfd_with_arg test).

The selftests were run with vmtest.sh:

  $ tools/testing/selftests/liveupdate/vmtest.sh -T luo_tmpfs

luo_tmpfs was also run on bare-metal x86_64.

Changelog
---------

v3:
 - Rebase onto liveupdate/next.
 - Collect Acked-by tags from Pasha on patches 4-6.
 - Drop the Assisted-by tags (Pasha).
 - Explain in patch 6 why it has no Fixes tag (Pasha).
 - Define shmem_inode_on_internal_mount() under CONFIG_SHMEM, like the
   other shmem helpers declared in mm/internal.h, to fix a
   -Wmissing-prototypes warning with CONFIG_SHMEM=n (kernel test robot).
 - Require a file to be opened for reading to preserve it, and reject
   append-only files (Sashiko).
 - Reopen files retrieved with O_RDONLY with the flags of the writable
   file, which file_open_root() normalized, e.g. by dropping O_CLOEXEC
   (Sashiko).

v2: https://lore.kernel.org/kexec/20261022225035.377445-1-dmatlack@google.com/
v1: https://lore.kernel.org/kexec/20261015093816.2438942-1-pasha.tatashin@soleen.com/
rfc: https://lore.kernel.org/kexec/20260901180713.4185641-1-dmatlack@google.com/


David Matlack (7):
  mm: Rename memfd_luo to shmem_luo
  liveupdate: Don't WARN if tracking a retrieved file fails
  mm/shmem_luo: Don't make early retrieve failures permanent
  mm/shmem_luo: Retrieve tmpfs files onto a tmpfs mount chosen by
    userspace
  mm/shmem_luo: Allow preserving tmpfs files that are still linked
  mm/shmem_luo: Allow retrieving tmpfs files with O_RDONLY
  selftests/liveupdate: Add a test for preserving tmpfs files

Pasha Tatashin (3):
  liveupdate: Pass user argument to file preserve and retrieve
  selftests: liveupdate: Add tests for preserve and retrieve user
    argument
  liveupdate: Allow file handlers to mark retrieve failures as retryable

 Documentation/core-api/liveupdate.rst         |    2 +-
 Documentation/mm/index.rst                    |    2 +-
 Documentation/mm/memfd_preservation.rst       |   23 -
 Documentation/mm/shmem_preservation.rst       |   23 +
 MAINTAINERS                                   |    4 +-
 include/linux/kho/abi/{memfd.h => shmem.h}    |   56 +-
 include/linux/liveupdate.h                    |   55 +-
 include/uapi/linux/liveupdate.h               |   52 +-
 kernel/liveupdate/Kconfig                     |    8 +-
 kernel/liveupdate/luo_file.c                  |  110 +-
 kernel/liveupdate/luo_internal.h              |    5 +-
 kernel/liveupdate/luo_session.c               |    6 +-
 mm/Makefile                                   |    2 +-
 mm/internal.h                                 |    1 +
 mm/memfd_luo.c                                |  621 -----
 mm/shmem.c                                    |    9 +
 mm/shmem_luo.c                                |  834 +++++++
 tools/testing/selftests/liveupdate/Makefile   |    1 +
 tools/testing/selftests/liveupdate/config     |    4 +
 .../liveupdate/lib/include/libliveupdate.h    |    3 +
 .../selftests/liveupdate/lib/lu_utils.c       |   17 +-
 .../testing/selftests/liveupdate/liveupdate.c |   44 +
 .../testing/selftests/liveupdate/luo_tmpfs.c  | 2055 +++++++++++++++++
 .../selftests/liveupdate/run-vmtests.sh       |    1 +
 24 files changed, 3237 insertions(+), 701 deletions(-)
 delete mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/mm/shmem_preservation.rst
 rename include/linux/kho/abi/{memfd.h => shmem.h} (54%)
 delete mode 100644 mm/memfd_luo.c
 create mode 100644 mm/shmem_luo.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_tmpfs.c


base-commit: 27be83a12b246b6b3783e7d3ac5c378ff7520f25
-- 
2.56.0.385.gac671c819a-goog


