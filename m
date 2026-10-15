Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D68CCA465
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 18:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fejDPgUdb/iOyoCqBL5K47RANMeJV8pAF9VzuVR2mQg=; b=Hdie/j3VOwINzzbnGlj3vlEPEb
	1IISYWoAiLiaYkjI+EiJYebDnrTfmVApMaScL/cvf6ijOfPoBPJInewgHRhtjC2UPzXR9jE3PEk+r
	B1D0SlmoNzfa8CsnEJfv7YIbIyqyM9du6TIsL9vlFS/ftjYEp23nl0nDVwfi5IgKzkZaGS6mrsvzf
	mREVc/cGHZh9BwNzHiwuhF3DxLIl4c9vLjykLygbqaPXjjgshkWuyxQfmh+WwMC+pVhOpqtIZ2uMe
	8Gxw5TLs5g+/pDv6jwz3THNv1mKnnlldfZWHC8VBwUYAtyge8qOvyXioC9OFs/1EhiJEb9L0SfjCa
	Uvi4p5Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQ7Z-000000018yH-3oc7;
	Thu, 15 Oct 2026 18:24:05 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQ7V-000000018wV-19WN
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 18:24:04 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5e931215e5fso643585e0c.3
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792088640; x=1792693440; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fejDPgUdb/iOyoCqBL5K47RANMeJV8pAF9VzuVR2mQg=;
        b=IG0RinQlFz2x+4h9kEpYVBlMHU9ebvupDNZUqBh2/6rNLlbkUCRFVF1Jaj5zqZ1p3x
         DzJkfIH35iXLfZkhQ8+5cNsXFm4h50+t8xQIahyrhRfDHAsesc6qQdsDPwDqYrK9Zpdt
         7V4i910XzP6F08VNkHrPYLUYNg9q+IST/DoKrvemmPA8777YuwF6ymh+QJhibC5KQ0m2
         ZseUbdsNjCvdgMnkVIiGD4i5p2jYlDVJMY0N7P0k2saPaOdX5OU6DLUYzgyE3ZZa5zSv
         Ifo6t2byDXbq65wTCl0+JVMVBX/LMUxUU5Y1K9vNwIY6b8n2Aeg01qEgJn7WtQ40Itge
         SvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792088640; x=1792693440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fejDPgUdb/iOyoCqBL5K47RANMeJV8pAF9VzuVR2mQg=;
        b=Cxk2Nv7c5fnap2nm/mWkMMapTC6CzUBhtYq/NVdDPAnw1ePHZODK7kosTJCdQ5ywee
         fEdXh4x8DCJor39s6unrnJd57A+vE9kWYxqB8XAWG1jevGrjIw/LqX+3xr1OVZeGq21j
         GEYzKqWvEpUlxGmldRJ06MdMH+xEp/ZQQfTBO0q903W9T2CwaakeMejqfHMJ3JRnqdSX
         31ExYBiUWNZkrfjDtclD62UYn0udVyfmgBPa9hAd2U4mR8U/k70j2xEKPjMqtDBJp0w5
         Ij9/OP1OJsFGC2+WW/BpizTdmbuP71461gZys+BGJb6gH8oifoZn2ke6VmXQQ8lW8GpN
         5Pvg==
X-Forwarded-Encrypted: i=1; AKwUvBykC3UTC0VjYjkfpX09DK8I3FQcUPOLIjIHsnXtZhMSEpH7Kamb5K8fxCRST9iePoFzsXeiNQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ0m9HC8AkL5sPpSMCLwmoQWJBrmpMwXOBna9DF7zQkV/3oZcD6
	B15PFksXeH7EuClnFGL2HXtfA+YD9874bmIy5wRxwvmmZA+D5FRfGuahA4UGM2Psbmg=
X-Gm-Gg: AYBFou3ub+ciSXHzpaL0QHoY6AEzPsV8vt3VRZBFpYuGUA724P1fk9zQNVa6H+Epq9/
	vvxG8p1LaM30YeRhmwGi+Btu3TZNK4gYsoMRuxZMT0ElZ45jdxX8n3Dlf8Sot/AJGfNIDLo6MRZ
	36MCuiQ8k7O6s2SSDZgTn/zSADGd9qgGO/MTCyGP+GUUzYRUi25VufQW6maKzM4ZXXB0iGbYYlg
	svdHrh8/wTmYYCA0aMQmLT6VnxyTyI9CCjfAbhXSMK1dYQJ9lxMszwg7AMTbOenFtgvAa0hlrFM
	/IU+utF/mwEh79+AhXNqxD9RCIkUvA49Lrn27rj5+zsKv6FT+xiqhQo/EGkavqAy4J2beYoaCL0
	E67xq9ewPv8KXqc/E21zQ6XhfHNMzQ2RsnAUHL4LgTBfhkDcLZmmOzsi22yfG3Lfok3RirY0fOS
	Uy1uI+nKqeoUSEGJ32ttyJfZQ3U1QpSQlnLwHalsTkvpqc26zWiemDQEZ2y8P2q7VrZEL190JH2
	iz01ItFh8NS7Z0pyyBEfTx0rb/xRg2hmJME3Foc7cOGNOXxEu3SjtFSVi85qeL/Uvk4696YFuuY
	TrNKJVe5tw==
X-Received: by 2002:a05:6123:91:b0:5ce:b65d:22c4 with SMTP id 71dfb90a1353d-5e91f51f7d0mr7511976e0c.16.1792088640045;
        Thu, 15 Oct 2026 11:24:00 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9943d7ffsm331215e0c.3.2026.10.15.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:23:59 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:23:58 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	pratyush@kernel.org, graf@amazon.com
Subject: Re: [PATCH v1 0/7] liveupdate: tmpfs preservation and early freeze
Message-ID: <atEaPuWNOm5VLc7A@google.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <atESAwf17pJ11S9U@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atESAwf17pJ11S9U@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_112401_508126_4721F542 
X-CRM114-Status: GOOD (  53.24  )
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

On 10-15 17:48, David Matlack wrote:
> On 2026-10-15 05:38 AM, Pasha Tatashin wrote:
> > This series allows preserving files in tmpfs via LUO to survive across a
> > live update, and allows userspace to decide when to freeze a session
> > instead of delaying until auto-freeze at kexec time. Once userspace is
> > done with a session, it can freeze the session immediately (and across
> > multiple sessions in parallel), reducing blackout time by not postponing
> > this operation to kexec shutdown where all sessions are frozen serially:
> > 
> > 1. Early session freeze (LIVEUPDATE_SESSION_FREEZE):
> >    Currently, LUO sessions are frozen automatically only inside the
> >    reboot(LINUX_REBOOT_CMD_KEXEC) path, where luo_session_serialize()
> >    iterates through all outgoing sessions under global write locks and
> >    freezes them serially during shutdown.
> > 
> >    Add the LIVEUPDATE_SESSION_FREEZE ioctl on session file descriptors so
> >    userspace can freeze a session as soon as it is done with it (and freeze
> >    multiple sessions concurrently, since luo_session_freeze() only acquires
> >    the per-session mutex). During kexec, already-frozen sessions skip the
> >    late auto-freeze step; if an early-frozen session is closed before
> >    kexec, its files are rolled back via .unfreeze() before being
> >    unpreserved.
> 
> Thanks for putting this together. I'm on board with driving
> retrieve-into through a per-handler argument instead of a LUO-level
> flag. It's what Pratyush suggested on the RFC too (sorry Pratyush, I
> never replied to that). I still need to review the actual patch but
> I think the idea is fine.

Yeah, Pratyush and I discussed this at LPC. I've been using this extra
argument in my cpu_preserve series to launch jobs at a given entry
address on a preserved CPU, and figured it would be a useful, generic
interface for others as well. So I decided to send this series now to
reduce the extra infrastructure I carry in my cpu_preserve series, and
your tmpfs work was a good reason to land it now :-)

> However, nothing ties the arg struct to a handler, it's interpreted by
> whichever handler owns the token. At LPC we discussed letting userspace
> pick the handler in PRESERVE_FD/RETRIEVE_FD, so that it controls which
> one is used when more than one can take a file. If we do that, the
> handler name would also be the natural key for which arg struct is
> expected.
> 
> > 3. Tmpfs file preservation and retrieval:
> >    Using the file handler retrieve argument, extend mm/memfd_luo to allow
> >    preserving generic shmem-backed tmpfs files (not just unlinked memfd
> >    pseudofiles), recording MEMFD_LUO_FLAG_TMPFS in
> >    struct memfd_luo_ser.flags so that preserved tmpfs files must be
> >    retrieved as tmpfs files and preserved memfd files must be retrieved as
> >    memfd files.
> 
> I've been working on a v1 of the tmpfs preservation since LPC. v1 fixes
> a number of problems in the RFC that I think this series still has
> (sorry for the wall of text, it is LLM-generated):
> 
>  - Failures that userspace can fix lose the file. The folios are
>    restored, charged and added one at a time, so if the target's mount
>    is too small (ENOSPC/quota) or the caller hits its memcg limit
>    partway through, the target is truncated, the folios are freed, and
>    the failure is permanent. Only bad-argument errors are retryable.
>    v1 restores all the folios first, charges all the blocks and memcg
>    up front, and adds all the folios to the page cache or none of them.
>    It keeps the restored folios in private_data between attempts (LUO
>    needs to pass private_data to .retrieve() and keep it on failure),
>    so the only permanent failure left is losing the KHO state itself.

I think the current behavior is fine: if the file doesn't fit when
restoring, I think it is okay to lose the file permanently. We shouldn't
keep preserved data around in private_data once we have started
retrieving folios.

>  - memfd_pin_folios() doesn't require the inode lock, so iommufd can
>    pin folios of the target while they're being added or truncated
>    away. v1 starts with two patches that make iommufd take the lock
>    and make memfd_pin_folios() assert it.

Hm, isn't this mostly orthogonal to the change we're making here?

> 
>  - The target has to be opened for writing (FMODE_WRITE). Since LUO
>    holds a reference to it until finish, that means a restored binary
>    can't be executed until the session is finished (-ETXTBSY). v1
>    instead requires mnt_want_write_file() and file_permission(MAY_WRITE)
>    under the inode lock, like FS_IOC_ENABLE_VERITY. That also rejects
>    immutable files, which a fd opened for writing before chattr +i
>    doesn't.

Ah, good point.

>  - There's no file_modified() or fsnotify_modify(), so setuid/setgid
>    bits aren't cleared and timestamps aren't updated. The normal write
>    path does both.

That is true, though I'm not sure fsnotify_modify() is really needed
since the whole file is restored at once and I doubt anyone is watching
for modifications during restore (clearing setuid/setgid via
file_modified() makes sense, though).

>  - f_pos is set through fget() + vfs_setpos() without f_pos_lock, which
>    races with read()/lseek() on the same open file. v1 uses
>    fdget_pos(). (Sashiko called this an ABBA deadlock. I don't think it
>    is one, since vfs_setpos() doesn't take the lock, but the race is
>    real.)

Right, this was reported by Sashiko; I haven't looked into it yet.

> 
>  - Early failures leak the preserved folios. The seals/flags check
>    frees ser and records a permanent error, so .finish() skips the file
>    and the folios are never freed. Sashiko flagged this as well. The
>    new MEMFD_LUO_ALL_FLAGS check adds another way to get there. In v1,
>    early failures don't consume anything and aren't permanent, so
>    .finish() cleans up.

We originally agreed that if retrieve() fails, we fail permanently and
leak resources until reboot to avoid memory corruption from ongoing DMA
activity. However, now that we have the retryable option, we can start
relaxing what is considered a permanent failure vs. a recoverable/early
failure that .finish() can clean up.


>  - If a token was already retrieved, luo_retrieve_file() returns the
>    existing file and ignores arg. Userspace that asks to retrieve into
>    X gets success and an fd for a different file. I think LUO should
>    fail with -EBUSY if an arg is passed for a token that was already
>    retrieved.

Agreed, if an arg is passed for a token that was already retrieved,
failing with -EBUSY (or -EINVAL if the target file doesn't match the
originally retrieved struct file) makes sense.


>  - Sashiko's WARN_ON(liveupdate_claim_file()) report on 3/7 is valid:
>    xa_insert() can fail with -ENOMEM there, and userspace can trigger
>    that.

Yeah, we can address that.

> One place our series are not aligned is MEMFD_LUO_FLAG_TMPFS. My
> thinking has been that RETRIEVE_FD should support retrieving into any
> shmem file (including linked files, memfds, and O_TMPFILE). It is
> userspace's choice at retrieve time. The only thing the kernel enforces
> are the fundamental requirements such as exceeding the file's mount's
> limit.  When I think about it that way there is nothing special about
> retrieving into a memfd and MEMFD_LUO_FLAG_TMPFS is just artificially
> limiting how a shmem file can be retrieved. WDYT?

I do not want LUO to change the type of a preserved file across live
update. Take seals, for example: a memfd can be sealed with the
guarantee that it will never be modified, whereas a regular tmpfs file
does not support sealing. Allowing a preserved memfd to be retrieved
into a tmpfs file would create a loophole to strip seals (or bypass
mount/superblock boundaries). I strongly prefer keeping the file type
strictly the same across preserve and retrieve.

> One last thing is my v1 also comes with a dedicated tmpfs selftest with
> much broader positive and negative test coverage that I would like to
> land (things link O_TMPFILE and read-only targets, executing restored
> binaries, exact block accounting with statfs() and st_blocks, including
> large folios that extend past EOF, etc.).
> 
> Maybe what we can do is keep your 1-5/7 patches and I'll rebase my v1 on
> top and send that as a replacement for 6-7/7?

Sure, please go ahead and send the new version.

Pasha

