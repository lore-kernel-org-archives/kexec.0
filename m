Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BC606EEB6
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gBM830me;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ/nNwuo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MRMdP7FIxigSeDqcsgSUYB9b6BNpnFg/wAimEqAPxEs=; b=gBM830mey96/rkc4TA8jdj2Joh
	9fUbM3xb89pBOSFGetyMIvZtn1j8r0PyC5iC5cIfplpyCtrH4enQd5QMZj2a2RgvMMC47DCnftI1X
	MH6tXNMM0s8BCNxrjatH4kS8aR5HzbXIhxC+EEuBE5/u9dgBMuvz62k+4qb6ZMvG81xftMZb3Y1jC
	VP9Bu1Z/B+XpcdjzznxVZEygtvKnH1p3vswuWgwcM9lrb5ZxdJPe3NW5o5gtkFTLYm56VXhi1qPXz
	2SVAYsFMsrJAelssg9sQdwc2xJyO8I8IOJe4KHBM4kps0twBwtvprx2l1+fM032ph18qVVsHwR+vf
	NfGKEQyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHXy-00000003BGk-2yzW;
	Tue, 03 Nov 2026 16:39:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHXw-00000003BEs-30qK
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 16:39:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 671AE43B17;
	Tue,  3 Nov 2026 16:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEE01F00919;
	Tue,  3 Nov 2026 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723980;
	bh=MRMdP7FIxigSeDqcsgSUYB9b6BNpnFg/wAimEqAPxEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XQ/nNwuodkCBEaeYlDPGXQ2NBVyaOu+nuL3oimLdbSA+hZnOnCMyBEv8BHrYgwk/m
	 6VRgMfJqoFXxFR5EnYPGf1ATg09kypE1i/OaABYNEuqdO5agM7Fzz0cf/3n/BjKYZM
	 khi+2N49jwOr20dXQgySeVZQ9Nuqnaii9228cGUqmaA9nvn0Bo2QFeSR7x+Zj7TPBN
	 DsnqdVZFYyPlE6EQk0LhOkfKZhj3KG2NrjGmOrcKa6pa4XM1UVKP+71e961E7SnLHB
	 vkz6atcfZ7p6OvtLIdPK+tn8iO+IrzrFsPPZ5RZWhEpbynuwXHq2NjfH4sIU6OUzUj
	 zfP/LOwKBMdTQ==
Date: Tue, 3 Nov 2026 17:39:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
	linux-input@vger.kernel.org, linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-modules@vger.kernel.org, Chuck Lever <cel@kernel.org>, tytso@mit.edu, 
	dmitry.torokhov@gmail.com, Petr Pavlu <petr.pavlu@suse.com>, 
	Anna Schumaker <anna@kernel.org>, yukuai@fygo.io, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH RFC 28/38] scsi: esas2r: bound the lengths of the HBA,
 SMP and firmware ioctls
Message-ID: <20261103-aufmischen-achthundert-reitschule-d97de42062c2@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-28-59422ed3e465@kernel.org>
 <sashiko-outbox-195500@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195500@kernel.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:48:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] scsi: esas2r: TOCTOU race on data_length in handle_hba_ioctl() via read_hw()
> --
> 
> commit 8af21917bc01e9991b2ab872e7a4c38c91a6e388
> Author: Christian Brauner <brauner@kernel.org>
> 
> scsi: esas2r: bound the lengths of the HBA, SMP and firmware ioctls
> 
> This commit adds bounds checks on user-supplied lengths for the HBA, SMP,
> and firmware ioctls in esas2r to prevent out-of-bounds reads and writes past
> the end of struct atto_express_ioctl and a->local_atto_ioctl.
> 
> > diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
> > index 3f7c1d131ec34..f99318f61c934 100644
> > --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> > +++ b/drivers/scsi/esas2r/esas2r_ioctl.c
> 
> [ ... ]
> 
> > @@ -1221,11 +1231,16 @@ static void hba_ioctl_done_callback(struct esas2r_adapter *a,
> >  	}
> >  }
> >  
> > +/* @room is the size of the buffer that starts with @ioctl_hba. */
> >  u8 handle_hba_ioctl(struct esas2r_adapter *a,
> > -		    struct atto_ioctl *ioctl_hba)
> > +		    struct atto_ioctl *ioctl_hba, size_t room)
> >  {
> >  	struct esas2r_buffered_ioctl bi;
> >  
> > +	/* The data follows @ioctl_hba in the same buffer. */
> > +	if (ioctl_hba->data_length > room - sizeof(struct atto_ioctl))
> > +		return IOCTL_INVALID_PARAM;
> > +
> >  	memset(&bi, 0, sizeof(bi));
> >  
> >  	bi.a = a;
> 
> [Severity: High]
> Can a concurrent write_hw() bypass this bounds check when handle_hba_ioctl()
> is called from read_hw()?

This whole codepath as currently implemented is structurally fscked.
So it's not something fixable in this series apart from the glaringly
obvious.

But for the record:

- The ATTONode entry thing is created as a side effect of reading
  another file.

  So esas2r_info() registers a character device and creates
  /proc/scsi/esas2r/ATTONode the first time it runs. That pins a global
  pointer to whichever host triggered it. So the control node only
  exists after someone looked at the host info. So it is bound to the
  first host and not to the adapter it operates on.


  The lifeteime is then tied to the module and not to the host.
  The entry is removed in esas2r_exit() on module exit.

  But the directory it lives in belongs to SCSI. That removes it when
  the last host of the template goes away.

  So unbind or hotunplug of the last adapter removes a non-empty
  directory... the dir is unlinked and the ATTONode leaks and stays
  reachable through a cached dentry.

  And the global host pointer dangles.

  So every ioctl on the node dereferences it.

  It's like non-empty directory removal basically. Fun.


- No privilege check anywhere. The node is created with mode 0 so 0444
  with procfs the the driver never calls capable().

  Hence, any local user can read and write firmware and NVRAM and issue
  VDA commands.

- The ioctl protocol itself (where to begin):
  - Plain-number commands
  - one struct copied in whole
  - unbounded lengths taken straight from userspace (well, that's fixed here)

Sorry, I'm not going to redesign esas2r.
And from what I can tell that ATTO stuff is legacy anyway so good
riddance as far as I'm concerned.

