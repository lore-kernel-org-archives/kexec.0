Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6295606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZHgrocJZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtCghqTk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gRXRlKwKxN+fSCr/T6i8djt87uv7sYA7hvMrxndI77U=; b=ZHgrocJZiDQr2qDkxyzL2pkh6Z
	15ec/rvk6LXdBx2x/publUdg8St9rHfz54oTUmB8Orr+apbExQOeqBwOC/KvoNrVTC5Ynp6J5Fikl
	4ZrKOkoVVMWz+f+ydMeRIu1q8VWhD9Ecy+6lVlKLNMjeHgEVI3/g05x7QT5PjebKJLZDZi4K9u94n
	tFsWlissU7FR3O3lRnAmEnnLjLM92xIGAZcQcA1MIVFmxQ3g5VmJ0D/lxlowLHwkb1DXKW1mwVONY
	y4Nhfzo3b2BCtJHC3xnqXBWxoWsMBdNB0poXFwG+UDYOiOorbeOIPmBvLjX126bFyxdfXCCBOQ29J
	nRwsDJuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXED-00000004s22-0xWi;
	Wed, 04 Nov 2026 09:24:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXEB-00000004s1l-3utD
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:24:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AAC8241A8A;
	Wed,  4 Nov 2026 09:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00EB1F000C1;
	Wed,  4 Nov 2026 09:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784259;
	bh=gRXRlKwKxN+fSCr/T6i8djt87uv7sYA7hvMrxndI77U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtCghqTk4F1EE9ZiaGiOl/CLyemjVYDJ+E2iTwlEuHko0AF2WQqNB2tyP1et6JQZd
	 /s/kPoz0A0zF+b5fFAIFD3ImxnjD/VWhr5VSKRweQqln4RDl4AQZ0FVMn/i/yt7O88
	 Ps9wlo2Fnfedf7faqa4SwwEANP4Q/4diwjkTX3mMumkt7VPx2Dq0vxvGBgDryWLmiO
	 5lerAYpepz4/m8aYVA7ag928SM+ijqD5yy+IBJRJI2YPtpIITX1SvmPZzKqLhu/h1W
	 WugE4uZByige6JL65yaTwMSDm+rRPo4EHgbghVb7x5+GS84YvD8WL3izKpfkYLWK0G
	 hw+mR5o35+RDA==
Date: Wed, 4 Nov 2026 10:24:07 +0100
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
Subject: Re: [PATCH RFC 04/16] proc: let procfs own the seq_file of seq_file
 entries
Message-ID: <20261104-hiebe-ausmachen-express-e9c87b962865@brauner>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-4-75df35e4f8b8@kernel.org>
 <sashiko-outbox-195531@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195531@kernel.org>
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

On Tue, Nov 03, 2026 at 03:01:06PM +0000, sashiko-bot@kernel.org wrote:
> - [High] proc: unpinned dereference of pde->seq_ops->next in pde_seq_next()

Nothing in the tree returns ERR_PTR(-EIO) from ->next but moving the
check up would remove that possibility so yes.

