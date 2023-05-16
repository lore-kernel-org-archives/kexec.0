Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E84C77B7F
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a8/kZoz3OK1cBULFgB4iZql3k9Wuy04VpUOx9ow2ykw=; b=nHjVwlv6e/g9B9
	WBTogNvIiGj3OdpXRLpamNlHC3vXLhmqkKBjE2yGUtYXi8BVszbrMe5f9xwQuRxALM/gdxv3YscPL
	EJRWm6ylX/saRZBq6/1BQWvnacRrNc7J8XPyVIf1EFLVg7ia1PgLtNUZgo0c99UDD9eRbeeBAc0Qe
	jBWzm2Zx2tzUo1wZRpzRL6pJfgU32n7O9+dr+DZkz4+N9PnIMhhHk7TjATzAEfYHXOcyGR5bVFcmV
	3Ue0+LgIa24GLGvmQLLLYclf+RdqfkrOYfsIf95PL5acbFWdAP8tp7cZFb0wNpMAbLV7Up1XS22xQ
	qkKxeU7NMtVI2/Ty9gOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pywQV-006DiC-2a;
	Tue, 16 May 2023 15:17:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pywQS-006DgS-1o
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 15:17:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2FB63B3D;
	Tue, 16 May 2023 15:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71041C433D2;
	Tue, 16 May 2023 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684250239;
	bh=zbsLxnAMj2vSIfOTUoVRyfsNlOWW5Uqw9nion1XeX4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMTpX/YIRwsa4A8MO42slLD90eYpwk5Grd8dbmfPivPpPaa1JOWehAz+POdgblVEh
	 D2laHfSTr4zpFVohDVcUfQfbV2iXxVg2/qSgRoENMhBp4K6MQciHSqd9P5f+bXTsYn
	 gDugDHX7qYxEug0WIvsmZsSQo42q4vGEUBe/KagYb8Gq8ZADtQ0aUARE/frffW64xP
	 tGfTPg9hxILttqTIwg99VYf4MXvfWPAuuuC4osf00WezPA37h8Tp/z7rW55J+VR938
	 qE4WkuZyjG/1nZkz5l+EhlqVV/Oju2SjjDvgJB5Y8YHOWbAEGauCF63DmsD44zDIno
	 dg/3E/HgJg8rQ==
Date: Tue, 16 May 2023 08:17:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
	sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
	mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add automatic kernel fs freeze / thaw and remove
 kthread freezing
Message-ID: <20230516151718.GP858815@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-7-mcgrof@kernel.org>
 <20230509012013.GD2651828@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230509012013.GD2651828@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_081720_682154_86221F90 
X-CRM114-Status: GOOD (  39.23  )
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

On Tue, May 09, 2023 at 11:20:13AM +1000, Dave Chinner wrote:
> On Sun, May 07, 2023 at 06:17:17PM -0700, Luis Chamberlain wrote:
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
> > 
> > This does not remove the superfluous freezer calls on all filesystems.
> > Each filesystem must remove all the kthread freezer stuff and peg
> > the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> > flag.
> > 
> > Subsequent patches remove the kthread freezer usage from each
> > filesystem, one at a time to make all this work bisectable.
> > Once all filesystems remove the usage of the kthread freezer we
> > can remove the FS_AUTOFREEZE flag.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  fs/super.c             | 50 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h     | 14 ++++++++++++
> >  kernel/power/process.c | 15 ++++++++++++-
> >  3 files changed, 78 insertions(+), 1 deletion(-)
> 
> .....
> 
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index cae81a87cc91..7ca7688f0b5d 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -140,6 +140,16 @@ int freeze_processes(void)
> >  
> >  	BUG_ON(in_atomic());
> >  
> > +	pr_info("Freezing filesystems ... ");
> > +	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> > +	if (error) {
> > +		pr_cont("failed\n");
> > +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> > +		thaw_processes();
> > +		return error;
> 
> That looks wrong. i.e. if the sb iteration fails to freeze a
> filesystem (for whatever reason) then every userspace frozen
> filesystem will be thawed by this call, right? i.e. it will thaw
> more than just the filesystems frozen by the suspend freeze
> iteration before it failed.
> 
> Don't we only want to thaw the superblocks we froze before the
> failure occurred? i.e. the "undo" iteration needs to start from the
> last superblock we successfully froze and then only walk to the tail
> of the list we started from?

I think fs_suspend_thaw_sb calls thaw_super(..., false), which will not
undo a userspace freeze.  So strictly speaking the answer to your
question is (AFAICT) "no it won't"

That said, I read this and also had a raised-eyebrow moment -- we
shouldn't (un?)touch superblocks that fs_suspend_freeze_sb didn't touch
in the first place.

I wonder if we should be using that NULL parameter to keep track of the
last super that fs_suspend_freeze_sb didn't fail on?

--D

> > +	}
> > +	pr_cont("done.\n");
> > +
> >  	/*
> >  	 * Now that the whole userspace is frozen we need to disable
> >  	 * the OOM killer to disallow any further interference with
> > @@ -149,8 +159,10 @@ int freeze_processes(void)
> >  	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
> >  		error = -EBUSY;
> >  
> > -	if (error)
> > +	if (error) {
> > +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> >  		thaw_processes();
> > +	}
> 
> Does this also have the same problem? i.e. if fs_suspend_freeze_sb()
> skips over superblocks that are already userspace frozen without any
> error, then this will incorrectly thaw those userspace frozen
> filesystems.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
