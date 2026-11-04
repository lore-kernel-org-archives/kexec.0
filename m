Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F12606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WIUG8KBZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcEaKSaA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O/cNspokMh0UNXOA6wOkvv54jlnPVAhKOKNo3zScL80=; b=WIUG8KBZW0j3M6c+eGexe2EsnA
	Hqy75L1rivpfJKE9TqwmgiWdr1W9ZiJVU28R8hl0l/z8LLUJITTDQhDc6RiQA3GzpEejZSpH7IoMy
	stIQCsIMt3qs39pVH9cCawdGw50vWyFUBaRRk8XTrYSMYzvVChqnjE+RHJndTBoOa1FN3RuEVt93w
	lXLJurzsAEsM5eooOM4U+gAAIGjJJXrdnMwCtBKK9kqIgZ8uGT7GxFyJLug8CVTPRIu9m/NFiUk3R
	OOKtfF9zq8Owedijp867coPJG8Scv6LxuGF2I8Sap3D4giI7OhPw9E+tUw+CPBP/af7DisR49GG6n
	4nlITTWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXAt-00000004rCp-1cCq;
	Wed, 04 Nov 2026 09:20:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXAm-00000004rBg-428Y
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:20:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B40B54344C;
	Wed,  4 Nov 2026 09:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BF1F000C1;
	Wed,  4 Nov 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784048;
	bh=O/cNspokMh0UNXOA6wOkvv54jlnPVAhKOKNo3zScL80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BcEaKSaAGlv24CwtAidx4vgcs6qvpVaJft+GsrdUwgsUzcXrxh3uKvNOUoNaojM0u
	 zeaAufJdghxwNsRVYbDAL/xLeKpNsJ3Qayq8R/yEjD/hXG6tybWAoeeY/Tcg+J2REY
	 2VHx7FHMLCTTzYzu20RNN6+W/eGKH3XQSxBPLu21a3FQK4L4xV10mVduwGQuGwRq6Y
	 1A0ZHeMOGLNd3RiETXNw1XPlv0+sn3aHbmYt6VyuIs0KUjdL9KaF/E0tjXUuJZvvKv
	 OzKIqB04C/jh70SwJGTPrT4CcqF9fgN0yPVMCzRgZsEpdaIpp/2cLp+CNRnZLAYstK
	 OnLeMUpNmqPkw==
Date: Wed, 4 Nov 2026 10:20:35 +0100
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
Subject: Re: [PATCH RFC 36/38] selftests/proc: check that faulting sysctl
 accesses don't hold up removal
Message-ID: <20261104-aktionen-endlich-ruhmreich-92f35a0ee397@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-36-59422ed3e465@kernel.org>
 <sashiko-outbox-195508@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195508@kernel.org>
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

On Tue, Nov 03, 2026 at 02:48:40PM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] selftests/proc: getdents test faults in dir_emit_dots() before entry lookup

Fixed.

