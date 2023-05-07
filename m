Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F9CC77B7D
	for <kexec@archiver.kernel.org>; Sun,  7 May 2023 04:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nHDdFK+Z/qUMKqCTo2m4+72FVn2l+/bmqguDBoodcuA=; b=e9E+sYC/Swwfp8
	KTIcUciygsh3wzJNGqoENzp6zukEpqZrGuwJqSvBQq++G9l+PDjq5cdN8KOnYrAV5SLrOd6Q+StcD
	XCLdgxZ7geuoV6mYBmCszBVmLwU05Y6cmNEdI5YIyLwIH7HlQah+kGFEF/oLRgG1Sz/322x/jYQaB
	SbJS0BgkerL6SgzlztmM4uct97EYeeboaGy3hr00F8M0iZDWpqNXOiArK8R7V5a3XZmWTghMG13KQ
	M1xiznO5eDTj1XkD5SJAQFGDyTWvH4dDzDkLi3/0EuZcm9ViASICq9ye1MiodM80sPixZm3xTQD9v
	YT7Noaku3md7UqXjZvrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvVgU-00F7Qg-1H;
	Sun, 07 May 2023 04:07:42 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvVgS-00F7Q5-0j;
	Sun, 07 May 2023 04:07:40 +0000
Date: Sat, 6 May 2023 21:07:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@infradead.org, song@kernel.org, rafael@kernel.org,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 05/24] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <ZFckDPpgpbvZBFyL@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-6-mcgrof@kernel.org>
 <Y/gqNaP4mrSMaDJo@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y/gqNaP4mrSMaDJo@magnolia>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Feb 23, 2023 at 07:08:37PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 13, 2023 at 04:33:50PM -0800, Luis Chamberlain wrote:
> > Add support to automatically handle freezing and thawing filesystems
> > during the kernel's suspend/resume cycle.
> > 
> > This is needed so that we properly really stop IO in flight without
> > races after userspace has been frozen. Without this we rely on
> > kthread freezing and its semantics are loose and error prone.
> > For instance, even though a kthread may use try_to_freeze() and end
> > up being frozen we have no way of being sure that everything that
> > has been spawned asynchronously from it (such as timers) have also
> > been stopped as well.
> > 
> > A long term advantage of also adding filesystem freeze / thawing
> > supporting during suspend / hibernation is that long term we may
> > be able to eventually drop the kernel's thread freezing completely
> > as it was originally added to stop disk IO in flight as we hibernate
> > or suspend.
> 
> Hooray!
> 
> One evil question though --
> 
> Say you have dm devices A and B.  Each has a distinct fs on it.
> If you mount A and then B and initiate a suspend, that should result in
> first B and then A freezing, right?
> 
> After resuming, you then change A's dm-table definition to point it
> at a loop device backed by a file on B.
> 
> What happens now when you initiate a suspend?  B freezes, then A tries
> to flush data to the loop-mounted file on B, but it's too late for that.
> That sounds like a deadlock?
> 
> Though I don't know how much we care about this corner case,

As you suggest this is not the only corner case that one could draw
upon. There was that evil ioctl added years ago to allow flipping an
installed system bootted from a USB or ISO over to the real freshly
installed root mount point. To make this bullet-proof we'll need to
eventually add a simple graph implementation to keep tags on ordering
requirements for the super blocks. I have some C code which tries to
implement a graph Linux style but since these are all corner cases at
this time, I think it's best we fix first suspend for most and later
address a proper graph solution.

> Anyway, just wondering if you'd thought about that kind of doomsday
> scenario that a nutty sysadmin could set up.
> 
> The only way I can think of to solve that kind of thing would be to hook
> filesystems and loop devices into the device model, make fs "device"
> suspend actually freeze, hope the suspend code suspends from the leaves
> inward, and hope I actually understand how the device model works (I
> don't.)

There's probably really odd things one can do, and one thing I think
we can later do is simply annotate those cases and *not* allow auto-freeze
with time for those horrible situations.

A real long term solution I think will involve a graph.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
