Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A12CCA465
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IltlA15ffn2teEWgoeALmwOWBDbtdgaPXsnTGsD5rwo=; b=PgGis+uqxgjE8KCY0u8iejYeBF
	2feRMXm+hT9pUoW5qWCKLuX3+T40Q+Jgi8l2umt/zTFUqe2SaPUgdc8MpzNtM0ToKjCeZ+A04qP6j
	qkRNEZXBp+GF6ReKIX0vgZ/bvIKCTn87UBRxR1zTqDtbsyCimKC2SvkbVwgsuB2fjvYXqH4a259D+
	1QkT5X+x2xy8ycBwoAs30+7ahGhOwRYEDSEHxARB4KDOweWXIDhSqCzBSpPqDoMwomJPG0TLGa9Ym
	VtFTtDhU7Kt5hgN6lxXkH60q5YFoKlAFs0WEdPwzRvPWre2Pgs5ilDTU3rIqcIVJCsg+acz2cm/uI
	2vRqkGag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQbR-00000001DJu-0fEL;
	Thu, 15 Oct 2026 18:54:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQbP-00000001DJj-0YPV
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 18:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IltlA15ffn2teEWgoeALmwOWBDbtdgaPXsnTGsD5rwo=; b=GDovUGGPO3DuyT+oRGuktWug0s
	gyORo5wTJyzXmV2S06ywcoerQSg2Sm5uISGhVIXy4ldt9bs6CbeOm1MjYdtdMXNnWam52H4OI/Mo1
	keX/V0LnKEMnnigUxfH1HVZpX6laSwbEAX0x+MlWPw/yZfMrCE4K2Vl0ghJtL/DLXwAGgRgLC/u2b
	wgdu1X0K2c5Br3pKCSn2un+NUfAOvVogsQFyWhsgLw6W0t655GjpEupeGJJPl+k/PjV5rq2ty6Pdr
	0SsT/GkjIttCqwSvAWc6HwoF+EcGlKWUsrWeJfOZoFWoTYfMBeizoJTFmjKw8/EAYfn6AsSZjyTmJ
	zWCZucJg==;
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHQbM-00000000kbc-1aTB
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 18:54:54 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1383680a12.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792090489; x=1792695289; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IltlA15ffn2teEWgoeALmwOWBDbtdgaPXsnTGsD5rwo=;
        b=e23IpKXLAVya7pZbtkGJFU52qttwQ6p5pdGtCSv7QLFl9ttWsWz6NwhoAusi6MZGE5
         Fvn3+F0sn1EbUqepdtgyaFAcmWJ/wm6k5nyPjVTAFjwu+b0EJ4hzjN5WIjRUkW8gvI13
         slBaZceLPLNRrKHn/W5DZt+eM3YYzvlW3tLFGkJnRi0tb3oNOTA+L0cSAXV0R2F+Rcpt
         HpenADp84hob4Q1XgglJ6LC6ji1QBeJQ6toGL8frZfnAh99kRB62+jJf0C7OZz29fCie
         TpigRcbbMiqA5VAoK2UtYSiFFHceUrbvbmVu1ReHrlVKieZs0jeBdWt3zwCV4c0CAGiD
         4Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792090489; x=1792695289;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IltlA15ffn2teEWgoeALmwOWBDbtdgaPXsnTGsD5rwo=;
        b=uZX8QikQTnQjl8+/130cjMKUSWOrxrQ1aIWVw5HUPWbALaoRioGX0ggQ91EQRGrGIE
         kLb63hmXRaFofvCp6NLBxeYLjEGbiNeCnm0X9EqX4N3ICVG/zV+jcjQOPjnEcBJ3XMyi
         mxVrxV1Fu3e2fQXmPsUdr0G+rAsKrNLKC5DNxc55rFLlEDzJQiYpmj7s7ebAxApijRUo
         12tGMH7p5eV9Wx8OybETMg5gqy/QLWctd+dd2NGOzIP4z2JAx1MPpMdPZiIy5JgeGntL
         q/38wrvnkjjQxb3dhJY0dxVaWNRWkqOpgR0NEc/IAkBm11fslYFlNxPlh9lKn/oaOIS+
         efvw==
X-Forwarded-Encrypted: i=1; AKwUvBxPuMV4Eh3VaeuRb4lxkAiFok3vFuJCtQ2S3pDcOfwP1zllSjyO/Dc2T3pECVHsFnpZvk6ZVQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIcznB64XlSxHgMXpXh7RkxR/A3FgX5SL8fEusFfLcJwd6qWBb2
	vKbLImo3oi1FY8S3A7A0h8o0QV0hPVf6cTxg/1mgyE312ZVZ+cK1v+vhPSBKi3EeHw==
X-Gm-Gg: AYBFou01jAFuNxwR4t0CbqA4GNcYz7rrpz4XhfqTuQ41B4Y1YDrBYLk9JPT0CSO2Soj
	QVN9TEY2oZv+RMgIy1an0ier5mt3R88wC6uGuB+4yF3MAk//WuRwaAoOQgAW8yzxz05Jdexh64H
	L/WdyeS/J0PNQrGzrjxphS+PTl4QA4YEe8hTrCwKxqcBahkPFOlJFoSDeFN3e4FmjObk1QCDRuZ
	4JAqcPZwZ165M1q93nuSo7/Z2YhRBiyye1oYi0J+YuoIV7tkngcCUuZ6GvKqWLes1BzV5PpguBA
	soYDLMQjZJh7LIcCxfE4Sr+0fezZ85kDz6xu5XqXY9DM0wTO/UcITHvedvHI/Lu6e8zc1nTjgSP
	mp3bPlrK8Npty9qV9XJGdPjKR9H9IrAqFu1J6GiPvTCopyDVaQENBK42LZotu5jRlFV6RmOn8ye
	GO77c/c3sJF9fFs1ueX3Wqg4QylUp46dDyYB7w+Sp+Z8cm01xmnMSWJCYSEJv9tox9tM5NrsFyo
	x2nYfDiZDosekBQBO3vkOXjWr6c76iL9f0=
X-Received: by 2002:a17:90b:390d:b0:3ac:b6eb:e0d4 with SMTP id 98e67ed59e1d1-3acb6ebe1c9mr959297a91.63.1792090488544;
        Thu, 15 Oct 2026 11:54:48 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm452704a91.3.2026.10.15.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:54:47 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:54:43 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	pratyush@kernel.org, graf@amazon.com
Subject: Re: [PATCH v1 0/7] liveupdate: tmpfs preservation and early freeze
Message-ID: <atEhc20Zawj4D62x@google.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <atESAwf17pJ11S9U@google.com>
 <atEaPuWNOm5VLc7A@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atEaPuWNOm5VLc7A@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_195452_558311_0EFEB7C5 
X-CRM114-Status: GOOD (  73.47  )
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

On 2026-10-15 02:23 PM, Pasha Tatashin wrote:
> On 10-15 17:48, David Matlack wrote:
> > On 2026-10-15 05:38 AM, Pasha Tatashin wrote:
> > > This series allows preserving files in tmpfs via LUO to survive across a
> > > live update, and allows userspace to decide when to freeze a session
> > > instead of delaying until auto-freeze at kexec time. Once userspace is
> > > done with a session, it can freeze the session immediately (and across
> > > multiple sessions in parallel), reducing blackout time by not postponing
> > > this operation to kexec shutdown where all sessions are frozen serially:
> > > 
> > > 1. Early session freeze (LIVEUPDATE_SESSION_FREEZE):
> > >    Currently, LUO sessions are frozen automatically only inside the
> > >    reboot(LINUX_REBOOT_CMD_KEXEC) path, where luo_session_serialize()
> > >    iterates through all outgoing sessions under global write locks and
> > >    freezes them serially during shutdown.
> > > 
> > >    Add the LIVEUPDATE_SESSION_FREEZE ioctl on session file descriptors so
> > >    userspace can freeze a session as soon as it is done with it (and freeze
> > >    multiple sessions concurrently, since luo_session_freeze() only acquires
> > >    the per-session mutex). During kexec, already-frozen sessions skip the
> > >    late auto-freeze step; if an early-frozen session is closed before
> > >    kexec, its files are rolled back via .unfreeze() before being
> > >    unpreserved.
> > 
> > Thanks for putting this together. I'm on board with driving
> > retrieve-into through a per-handler argument instead of a LUO-level
> > flag. It's what Pratyush suggested on the RFC too (sorry Pratyush, I
> > never replied to that). I still need to review the actual patch but
> > I think the idea is fine.
> 
> Yeah, Pratyush and I discussed this at LPC. I've been using this extra
> argument in my cpu_preserve series to launch jobs at a given entry
> address on a preserved CPU, and figured it would be a useful, generic
> interface for others as well. So I decided to send this series now to
> reduce the extra infrastructure I carry in my cpu_preserve series, and
> your tmpfs work was a good reason to land it now :-)
> 
> > However, nothing ties the arg struct to a handler, it's interpreted by
> > whichever handler owns the token. At LPC we discussed letting userspace
> > pick the handler in PRESERVE_FD/RETRIEVE_FD, so that it controls which
> > one is used when more than one can take a file. If we do that, the
> > handler name would also be the natural key for which arg struct is
> > expected.
> > 
> > > 3. Tmpfs file preservation and retrieval:
> > >    Using the file handler retrieve argument, extend mm/memfd_luo to allow
> > >    preserving generic shmem-backed tmpfs files (not just unlinked memfd
> > >    pseudofiles), recording MEMFD_LUO_FLAG_TMPFS in
> > >    struct memfd_luo_ser.flags so that preserved tmpfs files must be
> > >    retrieved as tmpfs files and preserved memfd files must be retrieved as
> > >    memfd files.
> > 
> > I've been working on a v1 of the tmpfs preservation since LPC. v1 fixes
> > a number of problems in the RFC that I think this series still has
> > (sorry for the wall of text, it is LLM-generated):
> > 
> >  - Failures that userspace can fix lose the file. The folios are
> >    restored, charged and added one at a time, so if the target's mount
> >    is too small (ENOSPC/quota) or the caller hits its memcg limit
> >    partway through, the target is truncated, the folios are freed, and
> >    the failure is permanent. Only bad-argument errors are retryable.
> >    v1 restores all the folios first, charges all the blocks and memcg
> >    up front, and adds all the folios to the page cache or none of them.
> >    It keeps the restored folios in private_data between attempts (LUO
> >    needs to pass private_data to .retrieve() and keep it on failure),
> >    so the only permanent failure left is losing the KHO state itself.
> 
> I think the current behavior is fine: if the file doesn't fit when
> restoring, I think it is okay to lose the file permanently. We shouldn't
> keep preserved data around in private_data once we have started
> retrieving folios.

Ok I think we can omit keeping restore folios in private_data across
retry attempts. It is a bit subtle.

> >  - memfd_pin_folios() doesn't require the inode lock, so iommufd can
> >    pin folios of the target while they're being added or truncated
> >    away. v1 starts with two patches that make iommufd take the lock
> >    and make memfd_pin_folios() assert it.
> 
> Hm, isn't this mostly orthogonal to the change we're making here?

Kind of. Today .retrieve() fills a brand-new memfd that nobody else can
reach until the ioctl returns. Retrieve-into fills a file that other
processes can already open by path and pass to iommufd, so pinning can
now race with the folios being added, or truncated away on failure.

In the failure case a folio can stay pinned (and mapped for DMA) after
it's been removed from the file. Retrieve-into introduces the race, and
the fix is two small prep patches.

> >  - The target has to be opened for writing (FMODE_WRITE). Since LUO
> >    holds a reference to it until finish, that means a restored binary
> >    can't be executed until the session is finished (-ETXTBSY). v1
> >    instead requires mnt_want_write_file() and file_permission(MAY_WRITE)
> >    under the inode lock, like FS_IOC_ENABLE_VERITY. That also rejects
> >    immutable files, which a fd opened for writing before chattr +i
> >    doesn't.
> 
> Ah, good point.
> 
> >  - There's no file_modified() or fsnotify_modify(), so setuid/setgid
> >    bits aren't cleared and timestamps aren't updated. The normal write
> >    path does both.
> 
> That is true, though I'm not sure fsnotify_modify() is really needed
> since the whole file is restored at once and I doubt anyone is watching
> for modifications during restore (clearing setuid/setgid via
> file_modified() makes sense, though).
> 
> >  - f_pos is set through fget() + vfs_setpos() without f_pos_lock, which
> >    races with read()/lseek() on the same open file. v1 uses
> >    fdget_pos(). (Sashiko called this an ABBA deadlock. I don't think it
> >    is one, since vfs_setpos() doesn't take the lock, but the race is
> >    real.)
> 
> Right, this was reported by Sashiko; I haven't looked into it yet.
> 
> > 
> >  - Early failures leak the preserved folios. The seals/flags check
> >    frees ser and records a permanent error, so .finish() skips the file
> >    and the folios are never freed. Sashiko flagged this as well. The
> >    new MEMFD_LUO_ALL_FLAGS check adds another way to get there. In v1,
> >    early failures don't consume anything and aren't permanent, so
> >    .finish() cleans up.
> 
> We originally agreed that if retrieve() fails, we fail permanently and
> leak resources until reboot to avoid memory corruption from ongoing DMA
> activity. However, now that we have the retryable option, we can start
> relaxing what is considered a permanent failure vs. a recoverable/early
> failure that .finish() can clean up.

Ok I think we are ligned that we need to keep the preserved folios
around until finish(). I think this point was saying there are bugs in
the existing memfd_luo code and in this series that leak the folios even
after finish(). Either way I'll fix them up.

> 
> >  - If a token was already retrieved, luo_retrieve_file() returns the
> >    existing file and ignores arg. Userspace that asks to retrieve into
> >    X gets success and an fd for a different file. I think LUO should
> >    fail with -EBUSY if an arg is passed for a token that was already
> >    retrieved.
> 
> Agreed, if an arg is passed for a token that was already retrieved,
> failing with -EBUSY (or -EINVAL if the target file doesn't match the
> originally retrieved struct file) makes sense.
> 
> 
> >  - Sashiko's WARN_ON(liveupdate_claim_file()) report on 3/7 is valid:
> >    xa_insert() can fail with -ENOMEM there, and userspace can trigger
> >    that.
> 
> Yeah, we can address that.
> 
> > One place our series are not aligned is MEMFD_LUO_FLAG_TMPFS. My
> > thinking has been that RETRIEVE_FD should support retrieving into any
> > shmem file (including linked files, memfds, and O_TMPFILE). It is
> > userspace's choice at retrieve time. The only thing the kernel enforces
> > are the fundamental requirements such as exceeding the file's mount's
> > limit.  When I think about it that way there is nothing special about
> > retrieving into a memfd and MEMFD_LUO_FLAG_TMPFS is just artificially
> > limiting how a shmem file can be retrieved. WDYT?
> 
> I do not want LUO to change the type of a preserved file across live
> update. Take seals, for example: a memfd can be sealed with the
> guarantee that it will never be modified, whereas a regular tmpfs file
> does not support sealing. Allowing a preserved memfd to be retrieved
> into a tmpfs file would create a loophole to strip seals (or bypass
> mount/superblock boundaries). I strongly prefer keeping the file type
> strictly the same across preserve and retrieve.

I agree that seals must not be strippable. I am not proposing to allow
that. Regular tmpfs files are created with F_SEAL_SEAL, and v1 refuses
to retrieve into a target that has F_SEAL_SEAL if the preserved file has
any seals the target doesn't have. So a sealed memfd can only be
retrieved into a memfd that allows sealing, and gets its seals back
there the same way F_ADD_SEALS would add them. Only unsealed memfds can
be retrieved into regular tmpfs files.

On mount boundaries, retrieving into a tmpfs file charges the blocks
to that mount, so its size limit and quota apply. That's stricter than
the unlimited internal shm mount that memfds live on, not looser.

This is what I mean about enforcing the fundamental requirements, rather
than enforcing something artifical like MEMFD_LUO_FLAG_TMPFS.

BTW, MEMFD_LUO_FLAG_TMPFS is set based on i_nlink, so it doesn't really
track the file type. An O_TMPFILE or unlinked tmpfs file gets preserved
without the flag and comes back as an anonymous memfd on the internal
shm mount. That changes its type and drops its mount's size limit and
quota, which is the boundary crossing you're worried about.

If you still want the type to stay the same, we can define it by
superblock instead of i_nlink:

 - memfds (on the internal shm mount): plain retrieve only, as today.
 - files on a tmpfs mount, linked or not: retrieve-into only, into any
   empty tmpfs file, including O_TMPFILE files.

That keeps your guarantee, fixes the O_TMPFILE case above, and still
lets userspace restore into an O_TMPFILE file and linkat() it into
place once it's verified.

But my preference is still to enforce the fundamental requirements,
since we have to enforce them either way and MEMFD_LUO_FLAG_TMPFS adds
ABI.

