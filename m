Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE449606A339
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GgQQcRP2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blm3Fzks
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6y/QB0A+W+6N3jiXZRGNY1xzzbI4566zJ/BaiNow5YE=; b=GgQQcRP2aCAjQ3PUqmaVgR4Wc7
	oJ7gIJ8qpRrTJWRoJv7DD6cBAXjO/5ONmdXwgv1ShMm995TqN1MYIomE7Iv1bZB6w4pQcrgEGBMgY
	2ckM8trqa01m+zAnjYR7R1gH+2OViMM3Gh36v7WFZ/Ts1/cm8hsw80wWPbRV3WaTifaefbC5XePve
	iFYwhinzVZr8XQX0L0N7cqvBW6SIB1rEfZsH3pEbILrLg551Bm8BiE2onoWLWNerSBkTLIk4fIz1G
	qj8IpuhxwSFYNJkOZMviPsZ1z/5PWkKF2fvqQ/REp8UwJgqpwELNlxRXNPdtHkPHVxE26gFJzh8uE
	esFYZ3nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXFP-00000004sDZ-2sLr;
	Wed, 04 Nov 2026 09:25:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXFP-00000004sDQ-0392
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:25:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9243240257;
	Wed,  4 Nov 2026 09:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF441F00A15;
	Wed,  4 Nov 2026 09:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784334;
	bh=6y/QB0A+W+6N3jiXZRGNY1xzzbI4566zJ/BaiNow5YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=blm3FzksIwmy/gfP+m6bQ3l19t8u+6D7VnMjx0mDrwJfI9yqkrKHuitgS+09MOaFB
	 5IAfK41yIRysnuekyE6n0MoqHw1erKQfYIHd4bcxX9IzwZZwgAZVYki7z4Cj5AIA7/
	 ZPGTgJBvsmIssHVAjO0+bxwX4CubbRT4ywfOYmYyDPmpCbFuRzICtnH6f+UaysQImg
	 q7wpeNs4gNICgefy3SKpkaeX4BbxjIfO+vSSQmRySEd1imrt/h87R+LlDv4MuyR4ux
	 lqn+1ClVwhwp9e3GHxStc7SnGYtfRsRPS5FsY3RelvLgIwBZIwrO2g2A54DZvsL3tG
	 vhwB9M0WME18g==
Date: Wed, 4 Nov 2026 10:25:21 +0100
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
Subject: Re: [PATCH RFC 11/16] proc: let procfs copy in writes before pinning
 the entry
Message-ID: <20261104-ankurbeln-gepflanzt-elegant-896e9dc995a2@brauner>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-11-75df35e4f8b8@kernel.org>
 <sashiko-outbox-195538@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195538@kernel.org>
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

On Tue, Nov 03, 2026 at 03:01:26PM +0000, sashiko-bot@kernel.org wrote:
> - [Low] proc: split __free(kvfree) declaration and initialization in pde_write_buf()

Intentional.

