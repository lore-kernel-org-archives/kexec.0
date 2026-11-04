Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8B606A335
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=onK5N0D2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1jgy3lG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Gr7svhS/YSc9d7laFr7PXJQ2SsJ994DEnu6A9NyzDrI=; b=onK5N0D2tbIGL/XAyOgIQgh07F
	DpIPylLXOXOOmT/npoa46iAFBssOxHayeH5HUv7QEbY4ANRXmlRwIG3kCs1DxhYDRs1QcpT706MVv
	1Z3IhD0AZlPkh6tAGxn0/UAXgJkqIJRtwqFcX0rskZQYbwdHjGx4g73/odowq/R9GFGlpKD0iHA2k
	2LXdZRfNal5OD3GHT35jU1x0BRGjZgHdzFlkOXWfQ7PsTYbp822MCHUK59EyF0BVo2oQi22VfiUPw
	GdwnsnBG1I1q02KP5S4E7Vi+HqyXicWADwSOsvWZV4Q0vYVRPYHGEcnYMLNJkyBHxu/Wqlq0u5YLb
	bvDK19iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXHu-00000004sfG-0WbQ;
	Wed, 04 Nov 2026 09:28:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXHs-00000004sey-2b3d
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:28:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C108060098;
	Wed,  4 Nov 2026 09:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4001F00A17;
	Wed,  4 Nov 2026 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784487;
	bh=Gr7svhS/YSc9d7laFr7PXJQ2SsJ994DEnu6A9NyzDrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X1jgy3lGK+B8wHnMJmPUlW00+DythG+u8ZdEslw9l+mYGsCluF0yALGaeLj7ksrDg
	 EcNjCUMoKMdxcyD0WsxPb4Cp4iKUAxNR9okqjQhF+09x5q+3kuYpexwXQlXsHIw+os
	 TkFeMF2FhQ5UjzAqNfBp6xMNGmn825VDWt1gtK+nxiDDItHSDAD0XUEkYDsawNyiA7
	 /4Xh7LGcOgeD7u3hApqggi+GDOh8nhBNcBO0pFhjuZykmUExXJEtisP76hRDnMqyNT
	 NxfQEUBzADkSfaq0PsDOx4woXNhrClwQtQmsRawkfviLN+SXF+cZMarB1vamQDxvXp
	 LI66cNBmM2ktw==
Date: Wed, 4 Nov 2026 10:27:55 +0100
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
Subject: Re: [PATCH RFC 15/16] proc: let procfs copy ioctl arguments in and
 out
Message-ID: <20261104-muskel-filmabend-parklandschaft-f02c910a4fb4@brauner>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-15-75df35e4f8b8@kernel.org>
 <sashiko-outbox-195542@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195542@kernel.org>
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

On Tue, Nov 03, 2026 at 03:01:36PM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] proc: unguarded zero-length user copies in pde_ioctl_buf()

Hm, a zero-length copy isn't a nop on every arch. Adventurous. It's
skipped now.

> - [Low] proc: split declaration and initialization of __free() variable in pde_ioctl_buf()

Intentional.

-- 

