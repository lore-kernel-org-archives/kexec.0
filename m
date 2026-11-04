Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907E606EE93
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SijdIoSQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+guEyix
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XBOw8umZc0PSygGL6ZhSsNEhyMPfzoczgqWFX+5YDNY=; b=SijdIoSQNUg30RBr7BavZUeJfO
	O61/JSR5YcuHYW48S9PlKZQDcBKdJkMaGG9riWKcH+2k3t8Jpg9xLuMzafmUND2fPMByh7PunXCp+
	r/JmsyS7TNMTCeBoqV6+JQtesUiCzFZjPPGG6potwNd24RTdMoww9cn0zabZAmv+xmgiu/ftnnvsf
	iols8E0liz4JUP+qO93utHmr8m75vmM3W8i7WcPZEbfB9XlT8TqrbZ9qZbYmdPsZ1VXDjfTK/Qr7+
	Dqi2yCa030zj52A8fe3vIlda+DVGCSNi/CwiNo8vIYkwtsDb/i1IiT7eUYClbEH/tHYOTpM4+sLKG
	CaI+o5zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjkD-00000007B46-3ta3;
	Wed, 04 Nov 2026 22:46:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjkA-00000007B3u-2NkT;
	Wed, 04 Nov 2026 22:46:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E931605D5;
	Wed,  4 Nov 2026 22:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C1B1F000C1;
	Wed,  4 Nov 2026 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832369;
	bh=XBOw8umZc0PSygGL6ZhSsNEhyMPfzoczgqWFX+5YDNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+guEyixDVYqpS8g3d4FmlRYq/qp1tQeGL16K2BSxNthPOaRsDL0VFTK+tjHByNf5
	 UG3G3TR4IbDk5BaZwlgwVySr0HiRvL1WeYdDEujyS+zzG35LMJqu1Pm8BzfQ5Z+w4F
	 3DGZwBGiTOYlKSVRIgaBstWj6LtjUlnMrGUfTY6AgB7LPx3pVl/0nxTfWzl1eRWVeu
	 9SzZPPQ7yLUIbBzvzOD5olkzaVc7Od6fJQ93jvoDvEvbyLIezG28vK5PJuGqQJ/Zu+
	 C/TFnkMniWMHftytXgdebgJiyvQu099dnGFvQXlwnwRKY6VGKt0bkFzVDUexAPr+Sm
	 GvRbuyQmKti0Q==
Date: Wed, 4 Nov 2026 23:45:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	netdev@vger.kernel.org, ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
	coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner>
 <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
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

On Wed, Nov 04, 2026 at 12:05:08PM -0800, Linus Torvalds wrote:
> On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2
> 
> Christian - way too many patches, re-sent much too often, cc'd to way
> too many people.
> 
> Nobody is going to read these repeated resends, and all you are doing
> is clogging up peoples mailboxes.

I resent once after I cleaned things up post RFC and I don't plan on
resending (one failed attempt due to my network dropping).

