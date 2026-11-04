Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFD606D801
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CT5u0qBx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsZRN4mS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DU2HnGr13UrjNFDLaLn3EdWjpZutHhABvL9XsGqx5jQ=; b=CT5u0qBxAEyQxxQHXW4phSNS9g
	2mDapMDiAYqCcX89IJkCrSldKyspFxy+ZXGHrzIqVeGfTEQ9EeVL7LlSTF5NFlsnRbD+CgwibAnRg
	Fp5W6GEfT8VOkfvbqYKJ3uQv9oo7e3eocGYjjHp6XTMUWPGbark/C0O4fYk85iXBm0Z7SEZlIpVdu
	6XoYNmpOkuiuZbaM5FvVblwepwvWDtf55MWZrBvSknGzG6SZT4LGgoLjXoEWvoFykAKzTSiN6sRGg
	PLi5aSu7RCksg3+/OkbVQuqTz0JnSD1+hWShk/mGotbwZBtTxnG/WRPHRdi3/7Pg7jiVkeB9aetNf
	+JJnBI0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXEg-00000004s7H-1Lp5;
	Wed, 04 Nov 2026 09:24:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXEf-00000004s77-2NT5
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:24:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D056360611;
	Wed,  4 Nov 2026 09:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6391F000C1;
	Wed,  4 Nov 2026 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784288;
	bh=DU2HnGr13UrjNFDLaLn3EdWjpZutHhABvL9XsGqx5jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WsZRN4mSiXyNqyPQ2abkla1s08ffMgQM7KLDjLi06P+TT7ab4JbGTgUVRFTqM57p4
	 KtZN+GZbXH5rHBUm61AhQwhDhVpBREBAZXFUjjZwHt8GkhBIFsti2bgsNX4+XQ7hjQ
	 cXpndaUS1eroH/oJVNBJ+Sg56kvdzoMsNnB1THlx9+UhoGdloEsTqTqtrrUok0Vt/q
	 ruKuPDXwVqcZXMIny8nZN4Uca5yxXlYGPJItgjFJ5wO+ybOGurlQmQ1RBi6ccxL0qZ
	 AEyV8CG8Z7QBzwnTCkd8HDyv1seLZcOyLurYeXFpg9fCMOjPk9E0UUS16THupapVJJ
	 /V41KUFcG1/jw==
Date: Wed, 4 Nov 2026 10:24:36 +0100
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
Subject: Re: [PATCH RFC 08/16] selftests/proc: check that a faulting reader
 doesn't hold up removal
Message-ID: <20261104-aufsagen-unermesslich-kehrt-9fbdcf7932fe@brauner>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-8-75df35e4f8b8@kernel.org>
 <sashiko-outbox-195535@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195535@kernel.org>
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

On Tue, Nov 03, 2026 at 03:01:17PM +0000, sashiko-bot@kernel.org wrote:
> - [Low] selftests/proc: Makefile and .gitignore entries in wrong commit

Fixed.

