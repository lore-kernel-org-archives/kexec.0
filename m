Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A356606A329
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=to1e6o6L;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7FoqcmY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CTsd4K4FS1c/0QtVRFQ6L4sBWzBDsskkKVi3HBwNbgQ=; b=to1e6o6LG5TrzTiDXzm7HIRHkC
	Sm2JmYartltMrPcOhDHTwkQR5WgdVzM9AUfk42jBugTx5rvzRqDenQGcQnl8cN/ZN3uVe8oVPCEPy
	rYcxHJv7m0jrumhlnAmTetU9yxgUj6F+/qd2FmOsQposwA64vSwShBzEFnO1V1KbIBwysSkm8kI/F
	tL4t6xB9YW8PjF1lsLZnSZNV7ifxrU0eg7AAwUPl/NRpH+uR6mQGCDmVJYClOxxu1MejcIs1WVk/f
	WeJPdBswHNHEZyGYAPwyi4+7Pa+0gfmYqvkb7gGvyo+ayKNQ4sCfQHcL9qgh1t23ASIV6Y/3G7YTI
	nnBH4Dig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzc0-00000009Qs7-2dOp;
	Thu, 05 Nov 2026 15:42:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzby-00000009QrO-1wbZ
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 15:42:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 04E9342148;
	Thu,  5 Nov 2026 15:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5BF1F000C1;
	Thu,  5 Nov 2026 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893365;
	bh=CTsd4K4FS1c/0QtVRFQ6L4sBWzBDsskkKVi3HBwNbgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l7FoqcmYX/+njg5zd1k1bA+FOA+lDCfiQNMdQHITGrpFOtDmfodmQeUvlG8+8QdRY
	 dDOSBg47/nnwS77SH1jriKunFI3Cf1YOogrSEPvaokKcDhCBbxJ51evpByksS3uR8Q
	 jAz59rW48V/DSQ7VFwoWcUKs7VhS9lxCpN33OC0L6hW91Z0COzvnr2cl5dHN5C18SK
	 xqs5IN75QQH3MMCyO2H21i49gUXYNT2NULY4YudARb8bmgEuX3EWn+M7+wEvTRWNWI
	 OV/7ivC6SN+MnTQoWZ2WI8WgIXhh1udieUA8CDzRCP1Og1YArIngLLm/7fkA5e7d31
	 SW+g94h6ECq8Q==
Date: Thu, 5 Nov 2026 16:42:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 00/10] liveupdate: Preserve tmpfs files across Live
 Update
Message-ID: <20261105-sitzordnung-nahkampf-ausbleiben-6db911d0333e@brauner>
References: <20261103010216.3447716-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103010216.3447716-1-dmatlack@google.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 01:02:06AM +0000, David Matlack wrote:
> The kernel preserves the contents, size, file position and seals of each
> file. After the Live Update, userspace retrieves each file onto a tmpfs
> mount of its choice and links it at the path of its choice, so userspace
> decides the directory structure, names, owners and permissions of the
> restored files.

[...]

>   4. Retrieve files that were preserved from a tmpfs mount onto a tmpfs
>      mount chosen by userspace, via the new struct
>      liveupdate_shmem_retrieve_arg. The kernel creates the file as if by
>      openat(dirfd, ".", O_TMPFILE | flags, mode), so the file gets the
>      same flags, owner, permission checks and security labels as any
>      other new file in that directory, and is charged to that mount.
>      The kernel fills the file before returning it, so nothing else can
>      access the file before it is complete, and userspace links it at
>      the path it wants with linkat() (patch 7).

No, sorry. That's not what we discussed at LPC and it's not what the RFC
and v1 did.

There userspace created the file and LUO filled in the contents. That
got turned around in the v1 thread and I think that was a big mistake.

The kernel is now responsible for creating the file and for its
permissions but it preserves none of that? No owner, no mode, no
xattrs, no security labels, nothing.

Instead userspace passes a struct that duplicates the open() argument
list and the kernel runs umask, setgid inheritance, default ACLs and LSM
labeling on it. That makes no sense whatsoever. Either the kernel owns
the metadata as well or it stays out of it completely.

Spoiler, it should stay out of it.

Userspace is responsible for everything but the contents. Take systemd
wanting to preserve a whole tmpfs. We already know how that works and
discussed that at LPC with you.

- We generate a manifest of the filesystem ith every file with its owner,
  mode and xattrs using UAPI.17 manifests (cf. [1]).

  We stash it in a memfd and reassemble the tree in userspace after the
  live update. All it needs from the kernel are the contents. Having the
  kernel recreate any of that is pointlessly complex.

So instead of LUO handing out a file descriptor for a file it invented,
let userspace create the file, O_TMPFILE, O_CREAT, whatever it likes,
with the owner, mode and xattrs it wants, and let LUO put the contents
into it. That's what the RFC did.

The checks on the target are trivial: a writable fd to an empty shmem
file with the inode lock held while you fill it. A tmpfs file can't be
sealed, it only ever has F_SEAL_SEAL, so there's nothing to restore but
contents and size anyway.

Pasha, your argument for creating the file in the kernel was that
nobody can reach it while it's being filled. **That's what O_TMPFILE is
for**: Userspace creates it unlinked, LUO fills it, userspace links it.
If userspace hands a half-filled file to iommufd that's its own problem.

I also really dislike file_open_root() for this. It's an openat()
emulation inside an ioctl which is completely terrible.

It redoes the openat2() validation by hand (reject O_PATH, unknown
flags, stray mode bits), force O_LARGEFILE, and because O_TMPFILE
insists on write access you open the file O_RDWR, copy the normalized
f_flags out of the first struct file, dentry_open() the same path a
second time read-only without any permission check and drop the first
file again.

So an LSM sees an O_RDWR open for what userspace asked to be O_RDONLY.
Whatever path_openat() happens to do for that synthesized flag
combination becomes LUO's behavior. That's brittle as fsck. All of it
goes away when userspace is responsible for that.

Fwiw, the permission model you end up with on retrieve is write and
search permission on the target directory, i.e. vfs_tmpfile()'s
inode_permission(dir, MAY_WRITE | MAY_EXEC) plus mnt_want_write() on
that mount. The new inode is owned by whoever runs the ioctl with
whatever mode they asked for. Nothing about the original file matters.
IOW, the kernel has nothing to contribute here that open() doesn't
already do.

Really, please make the kernel's job stupidly simple: let userspace get
the contents and let it be responsible for the actual complex restore
and the filesystem layout.

A hybrid helps absolutely no one.

>   - Is patch 9 (retrieving tmpfs files with O_RDONLY) worth merging?

No. With userspace creating the file this doesn't exist.

>     are created with mode 0777 (or 0666). Is this the right permission
>     model for preserving files? Should this apply all files or just
>     shmem files?

The preserve side seems fine to me. If you freeze the size of a file
for everyone you better be allowed to write to it.

[1]: https://uapi-group.org/specifications/specs/file_manifest/

