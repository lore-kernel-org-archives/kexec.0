Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C2BCC6B39
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8gmOZqAjPixYY6Ob7IGv/llQqi0+9XdrKezybj1a6U4=; b=Xp69Z5G/xclUD7At98eca5Cshp
	tl2gtgrH7pUHH+M6Q0rtX2mCmtON7XSlHEJaSRewpdfW1BFKg4SUk0bmRr3ZbIOzaIt88G8DDGesu
	5iq9EmsmP5amxKttpvYgixmAZZBfe+8Q9xwSGNxG48tmt3t1Nf1uMLENSlQUQ/jB3bQr5ajFnxInp
	/PqpkxSDYCEmTluS1Pg5n6towRzT3PbH6BLlwdc61V6d/8EiXzBX0FjYyaMPWN5glOajJdh9cK0UM
	RsPGQiv1I5pbd/463ge17X5eEkKI9KqPkr3CLCSKkcO6OAix0SVUkzXQPSENtiF4+0OvM1ZisiXxs
	jP0x4RxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHPZe-000000012uZ-31gv;
	Thu, 15 Oct 2026 17:49:02 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHPZa-000000012td-0dnD
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 17:48:59 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1045157a91.3
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792086536; x=1792691336; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gmOZqAjPixYY6Ob7IGv/llQqi0+9XdrKezybj1a6U4=;
        b=h4wVnKS6TS+sd8jgGl69FNuCwj9Cu1x//SlkV6Z7kSrDmoZVDrvbs2uoqUHB18L1AM
         R25NM7j8+h2mp1G2Zo76ULg+cMs5PDctRt5a6VOW3OmpUNgzskvm3o4vl+Gb+P0zStLP
         1wsLLmfa9Fs3qG8Ph/y4np/LOdeqoG/8oF2M1ZZxTyjQiuwlUXYclVCIw7+T7SGx0yEh
         lgXyhyxomHcrvTzTSaEsNwlOI96qxlYEQwkZYEu5RiCggx8M8yceP9ES+0PO+7pc5OWh
         I95z/3KFXS3R3dfzd2HeWJF9jXgQeYl2q9LFIgex3IZgmWTnKsJ+jrFz6xKOfGzyDGnB
         0rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086536; x=1792691336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gmOZqAjPixYY6Ob7IGv/llQqi0+9XdrKezybj1a6U4=;
        b=1DiwjwixhE1j20aQP0LNH+vcEyZe21JG2vFU44j97xzc87a+1y8axTD84uDaCFZIFh
         NC0Z3AoaH/ENLiZDK+ODukUM5Ay/QxQQwGXugb+SdxTNaWGGkXlKa2tbmKrwVy4Tfvu5
         NAwouLStqWjHEyNjc4oZkjHk/9/5OyzyU4kbzftf0vmAU7c+4HaJwwm0LgY1wlzr3xpb
         1xVy4l+P8vTCJBCLHmEkiepleYVbYIewuXakHWJfBgelSnMY4bweLzx0PRAfywFFQ6A6
         SJ1E2waHAG/HoGVzXGywBfDHeA9S6CsEclBIVkMIxAvlR34LaDD74NosvPF5PxmJwE2b
         CDCw==
X-Forwarded-Encrypted: i=1; AKwUvByJ8YhY8c+Zt95ujIK1JC9NB7jKACx1XJ67vkqSqPp2VMNXWrAucRV044cbeUf23LKH+sIN6w==@lists.infradead.org
X-Gm-Message-State: AFq9FYJo+PeexlAuaSe94IDmjZLRs3MhNF+oyrWUfj1phzsbNFfgIg+k
	+LhrNcuqlNNk5i5CIG00skjkIFxgx7t2KjlzsgdKLV4PAfd36XG7+8OmwrSfjnh9Zw==
X-Gm-Gg: AYBFou0eP6JCC9VUlXg0UO5sq6OJ1GZCq7k1h1J1LkwcaqyXgmwZ9GBSMZBRVmDSqPc
	SGy6/V99QDWG3gg3Sza9yjS1y+fv3vSBBvFnhVb3i9BJlQZwTg7qTwbyaunvptqD9TlSY9KijHJ
	fiHR59oGKM+uXiAbywsN71Ifk3mOHGj8Y07Ic5/3JR1Icul32DwgHqUKkiUFr7HFotqRc9b00Vx
	mR57urtGPdw+hMReuwFozt9YyYuvtzmuHWkuO31LR1Y7WiNW4TGpEFVzbJMjLi0EbPLV7e/fDOG
	gYm/GWGPZnwhflKghLO3A8iCbt7C4lIqwyibgEhAnjHELp0vI6sf5r3HZWHE/EL1lVb+rURBAuV
	zIl2OGTPz+HXLyi12/xH9bdakSWZABQjsGjswsdXXQ+7RAJSQB2lRkro7qaTgJD6y83YElDMCgM
	tpaxp+/dfhiKdxpy4B7AIYSZIJwar98LqOA/Df2icPsh6fSN0oafY5NtD/3SfQbkijMKWGyMTnR
	bq5jyZU4Zu3XUcKb9/r4Dsoq+bmYxBWQGRnVKAk8v0/7g==
X-Received: by 2002:a17:90a:bd7:b0:3ab:f38:2b3b with SMTP id 98e67ed59e1d1-3ab9628e531mr9843506a91.21.1792086535442;
        Thu, 15 Oct 2026 10:48:55 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm5041683a91.11.2026.10.15.10.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:48:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:48:51 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	pratyush@kernel.org, graf@amazon.com
Subject: Re: [PATCH v1 0/7] liveupdate: tmpfs preservation and early freeze
Message-ID: <atESAwf17pJ11S9U@google.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_104858_230852_AE283FD7 
X-CRM114-Status: GOOD (  34.19  )
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

On 2026-10-15 05:38 AM, Pasha Tatashin wrote:
> This series allows preserving files in tmpfs via LUO to survive across a
> live update, and allows userspace to decide when to freeze a session
> instead of delaying until auto-freeze at kexec time. Once userspace is
> done with a session, it can freeze the session immediately (and across
> multiple sessions in parallel), reducing blackout time by not postponing
> this operation to kexec shutdown where all sessions are frozen serially:
> 
> 1. Early session freeze (LIVEUPDATE_SESSION_FREEZE):
>    Currently, LUO sessions are frozen automatically only inside the
>    reboot(LINUX_REBOOT_CMD_KEXEC) path, where luo_session_serialize()
>    iterates through all outgoing sessions under global write locks and
>    freezes them serially during shutdown.
> 
>    Add the LIVEUPDATE_SESSION_FREEZE ioctl on session file descriptors so
>    userspace can freeze a session as soon as it is done with it (and freeze
>    multiple sessions concurrently, since luo_session_freeze() only acquires
>    the per-session mutex). During kexec, already-frozen sessions skip the
>    late auto-freeze step; if an early-frozen session is closed before
>    kexec, its files are rolled back via .unfreeze() before being
>    unpreserved.

Thanks for putting this together. I'm on board with driving
retrieve-into through a per-handler argument instead of a LUO-level
flag. It's what Pratyush suggested on the RFC too (sorry Pratyush, I
never replied to that). I still need to review the actual patch but
I think the idea is fine.

However, nothing ties the arg struct to a handler, it's interpreted by
whichever handler owns the token. At LPC we discussed letting userspace
pick the handler in PRESERVE_FD/RETRIEVE_FD, so that it controls which
one is used when more than one can take a file. If we do that, the
handler name would also be the natural key for which arg struct is
expected.

> 3. Tmpfs file preservation and retrieval:
>    Using the file handler retrieve argument, extend mm/memfd_luo to allow
>    preserving generic shmem-backed tmpfs files (not just unlinked memfd
>    pseudofiles), recording MEMFD_LUO_FLAG_TMPFS in
>    struct memfd_luo_ser.flags so that preserved tmpfs files must be
>    retrieved as tmpfs files and preserved memfd files must be retrieved as
>    memfd files.

I've been working on a v1 of the tmpfs preservation since LPC. v1 fixes
a number of problems in the RFC that I think this series still has
(sorry for the wall of text, it is LLM-generated):

 - Failures that userspace can fix lose the file. The folios are
   restored, charged and added one at a time, so if the target's mount
   is too small (ENOSPC/quota) or the caller hits its memcg limit
   partway through, the target is truncated, the folios are freed, and
   the failure is permanent. Only bad-argument errors are retryable.
   v1 restores all the folios first, charges all the blocks and memcg
   up front, and adds all the folios to the page cache or none of them.
   It keeps the restored folios in private_data between attempts (LUO
   needs to pass private_data to .retrieve() and keep it on failure),
   so the only permanent failure left is losing the KHO state itself.

 - memfd_pin_folios() doesn't require the inode lock, so iommufd can
   pin folios of the target while they're being added or truncated
   away. v1 starts with two patches that make iommufd take the lock
   and make memfd_pin_folios() assert it.

 - The target has to be opened for writing (FMODE_WRITE). Since LUO
   holds a reference to it until finish, that means a restored binary
   can't be executed until the session is finished (-ETXTBSY). v1
   instead requires mnt_want_write_file() and file_permission(MAY_WRITE)
   under the inode lock, like FS_IOC_ENABLE_VERITY. That also rejects
   immutable files, which a fd opened for writing before chattr +i
   doesn't.

 - There's no file_modified() or fsnotify_modify(), so setuid/setgid
   bits aren't cleared and timestamps aren't updated. The normal write
   path does both.

 - f_pos is set through fget() + vfs_setpos() without f_pos_lock, which
   races with read()/lseek() on the same open file. v1 uses
   fdget_pos(). (Sashiko called this an ABBA deadlock. I don't think it
   is one, since vfs_setpos() doesn't take the lock, but the race is
   real.)

 - Early failures leak the preserved folios. The seals/flags check
   frees ser and records a permanent error, so .finish() skips the file
   and the folios are never freed. Sashiko flagged this as well. The
   new MEMFD_LUO_ALL_FLAGS check adds another way to get there. In v1,
   early failures don't consume anything and aren't permanent, so
   .finish() cleans up.

 - If a token was already retrieved, luo_retrieve_file() returns the
   existing file and ignores arg. Userspace that asks to retrieve into
   X gets success and an fd for a different file. I think LUO should
   fail with -EBUSY if an arg is passed for a token that was already
   retrieved.

 - Sashiko's WARN_ON(liveupdate_claim_file()) report on 3/7 is valid:
   xa_insert() can fail with -ENOMEM there, and userspace can trigger
   that.

One place our series are not aligned is MEMFD_LUO_FLAG_TMPFS. My
thinking has been that RETRIEVE_FD should support retrieving into any
shmem file (including linked files, memfds, and O_TMPFILE). It is
userspace's choice at retrieve time. The only thing the kernel enforces
are the fundamental requirements such as exceeding the file's mount's
limit.  When I think about it that way there is nothing special about
retrieving into a memfd and MEMFD_LUO_FLAG_TMPFS is just artificially
limiting how a shmem file can be retrieved. WDYT?

One last thing is my v1 also comes with a dedicated tmpfs selftest with
much broader positive and negative test coverage that I would like to
land (things link O_TMPFILE and read-only targets, executing restored
binaries, exact block accounting with statfs() and st_blocks, including
large folios that extend past EOF, etc.).

Maybe what we can do is keep your 1-5/7 patches and I'll rebase my v1 on
top and send that as a replacement for 6-7/7?

Thanks,
David

