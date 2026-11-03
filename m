Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D850A606EE9A
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BaSwZcs8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcCk3E9D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3/pwRZodtv5H9vRDvB09UF4TkDVIqcbW+/AB21sxSLI=; b=BaSwZcs80oo+SLnZ4os5DhsFIj
	YTibnlYc3QsnEOEDp4TMgweTJsXHPF7FiEIqltzOykmgBWPATnOE48l81ZFzFgL/IDxOOE1P9AK5V
	isUy2FGAzHrPf/LKOuM3xhCZ8LjSWm8DDkJQpRlqgbZ98O1A0ILd3yTh9Q1LSCfQUTjMkv2D9Rwyw
	Ye/cN9bxIJcnfWvmOe36n/iPuyKupyWBhJX3AQ1Lx8Lyb4XkE+IhvKRvXG8Tu/rJ2PhgbVPZp18JG
	DpUaFztrifAD+nRzPSnuH1dOgFisyo8wo1jxIM5gvvWQrNcXNrHOPRfbrDHd4iOQp/oQHy9ZwyBD3
	kUh7216w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHZ3-00000003Bid-2BWm;
	Tue, 03 Nov 2026 16:40:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHZ2-00000003BiI-1Y5z
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 16:40:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFCE34400B;
	Tue,  3 Nov 2026 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5F1F00919;
	Tue,  3 Nov 2026 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724047;
	bh=3/pwRZodtv5H9vRDvB09UF4TkDVIqcbW+/AB21sxSLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kcCk3E9DDzqb581VxJ5reyHZgYV3mxqJrzazBrWKk/8awLxY14WY1qQjIrfNtyW9+
	 +fgInAFIOA8pbj4OnlZMuT+n3NlUcuq2yEYeXQNrWe8ebUqvrivCfRVtWDr/3yvXbz
	 /BWBSYNXk+FF83ZDTD4OKx7IKTkClzRWexwwPPed/RG1Xv+LYlKNqShYqAnmueVcHC
	 gTpUG+UUL6OOUv1NGnTCJgrYlEvrsdp0yuuXL06dDPAQlPxzRqYs0ah3iWC0gI9/Bt
	 TyO0WuPIBe1MXUewf/anvSyELn8SkDADqP4mdxifTwWZEneQ2Nc7h/8SBuhSMroZc5
	 ZN0fxv3D5A0Jw==
Date: Tue, 3 Nov 2026 17:40:36 +0100
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
Subject: Re: [PATCH RFC 32/38] selftests/proc: check a sysctl listing while
 entries come and go
Message-ID: <20261103-unwichtig-puten-tauglich-389f0d95257d@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-32-59422ed3e465@kernel.org>
 <sashiko-outbox-195504@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195504@kernel.org>
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

On Tue, Nov 03, 2026 at 02:48:31PM +0000, sashiko-bot@kernel.org wrote:
> - [Low] selftests/proc: proc-sysctl-readdir-churn duplicates proc-readdir-churn

My appetite for churn due to "low" issues in tests is low.

