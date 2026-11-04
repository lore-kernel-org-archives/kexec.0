Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D33606A334
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1fL++pHQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlGTCzi8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TLWmGN3SfRKJzJtFGqy9xXljoZdTMIGgQAZ0U5pRqZ0=; b=1fL++pHQOsCWNWruo/09uuHmjT
	5TKO7j9yoHgzT/6POl4FWPfKNS3cKxUWihqsOaC1/eOCbY9NkV1mFnMCcR9vlJ50smqTIO9aq1eAi
	O5whv5r+aXCKTXdHJ1kp2TMNQ8+rRkGd6sGWKjdNQLfeQ2gPk6ofV7JyBGgVYDzebCw4TbuEDh1zM
	030IRIAkqyeDx0Zw+DhTv0AQ58ml7qe1w8Ph6MnoGFaWRSoxXvAOL1acJsTrbF4/0crnMuw8e98GS
	zFWrxOv7ZTAXYel0a5iyBLrPvoWmyXIFuTtOKNw8qQ42D8FHg2KgCz0k3eIgqfQC31+06dO93ODnm
	r7KzTMXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXBQ-00000004rKf-2Ds9;
	Wed, 04 Nov 2026 09:21:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXBP-00000004rKS-3wJe
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:21:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 43B4360142;
	Wed,  4 Nov 2026 09:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC751F00A1B;
	Wed,  4 Nov 2026 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784087;
	bh=TLWmGN3SfRKJzJtFGqy9xXljoZdTMIGgQAZ0U5pRqZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RlGTCzi8pu88TVAb0kwn4joxUiR7mlBDOdPpezl4XmsvQd8kAh4iDFU4pQONkMHIu
	 eliic42rAIpabkq9bUb6HqnW9ZOmOC+nO6hIz58hrOaEoVJAOD6f1NccFejHSUbQEg
	 UcTtVvMVrKX8rkKsqChfbeyKOblU3iUz404/VcCwAESFTSpzfmuSYLv6tIXqWgvwx4
	 JsaFcHO4jSLDa+WNzQE5ZJzqGGlwKjwInimlKuIR6uaQtqBJZavxLJ41GnGzP1qeFj
	 IB/K6cI148TQ1ND1SEtNwA24wzZ0dXL4wMxQ/4D3P3yQeU5Lj8YAihYUT5N5BdD20o
	 LKB+GT+o55caw==
Date: Wed, 4 Nov 2026 10:21:13 +0100
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
Subject: Re: [PATCH RFC 38/38] selftests/proc: check that a faulting
 readlink() doesn't hold up removal
Message-ID: <20261104-erwecken-pulsieren-anarchie-9a5a7582621e@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-38-59422ed3e465@kernel.org>
 <sashiko-outbox-195510@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195510@kernel.org>
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

On Tue, Nov 03, 2026 at 02:48:45PM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] selftests/proc: Makefile adds nonexistent proc-remove-slow-reader target

Fixed.

