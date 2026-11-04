Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABD606A329
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CQCn/K1z;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI03ExhV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BqLsI51xXE9XvqQwrewS8kVZYOVybuvhFSYA9nKiQ5w=; b=CQCn/K1zZWBiTx7NIpSyQHnWYE
	a15CvFo/nzjYW7i6NiohvIO+LP2N0imvs7r71QXkaaKyudcli0aWo9/dwNmVBS9LcITYkDh7xXNQS
	QCx+Ci4rGLoLOe3373KhBENksUvPCx5siz/apuy9nwBq98/V9chiZsqVoi2LFo7Pyl8hkr5v1sDtT
	pKqUYIw6dBn35Is4IlyaP/3669d4X+x+JRsK5HtPB3U78ouQa6MlCIjLm8chDN8IhSOAyXFCzsnXE
	GVwQN/5wkhQLStg7/sWXskyy4ccbV/apAaIJ8IK42WIftWq39v1lWWqDMVOl+kEkYPY6uK4friHqi
	0dNYh8xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXAL-00000004r55-0qjp;
	Wed, 04 Nov 2026 09:20:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXAK-00000004r4x-0bDl
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 09:20:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BEECD4022E;
	Wed,  4 Nov 2026 09:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14201F000C1;
	Wed,  4 Nov 2026 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784019;
	bh=BqLsI51xXE9XvqQwrewS8kVZYOVybuvhFSYA9nKiQ5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RI03ExhVHW+vXW50GI/z1t5fOv/JldWAfo3PTbpnjtH9ZHo58Lc2AcPxXJ5PtbXAX
	 8g4KSTO5fOZQCtpyjjL/bJvrwiezCM9YEtZIA/HFUZUjXdYaQqcpF0TeHFBMUlhQKU
	 cwV4vnKJXipMsVWc69bizj8nAauOCKTGcIiZij9G7eWxZ3rmj4e0CBFYHzcKtXnQSl
	 AJB/iwP2dB6oj6qGqoWsBFGeMkJxlpj4mX3YlYJ3ZSSJ9f+IEjQkqzGNq+iWXf8V9P
	 ITxx8RHhN/lsRkk2i0dJRQVWI5FBwtmizQ/MBQbxSu+48ni+gfhGCNjOwQDZHYMP7B
	 rmF7LwmTvp1Aw==
Date: Wed, 4 Nov 2026 10:20:07 +0100
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
Subject: Re: [PATCH RFC 35/38] proc: sysctl: don't hold the tables while
 readdir copies to userspace
Message-ID: <20261104-getreide-fallpauschalen-uralt-d366f2bf03b0@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-35-59422ed3e465@kernel.org>
 <sashiko-outbox-195507@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195507@kernel.org>
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

On Tue, Nov 03, 2026 at 02:48:38PM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] proc: sysctl: premature EOF and lost errors in proc_sys_readdir()

This is pre-existing. proc_sys_make_inode() refuses a table that is
being unregistered since ace0c791e6c3 ("proc/sysctl: Don't grab i_lock
under sysctl_lock."). The old proc_sys_readdir() stops at an entry the
same way.

We can fix this by skpping the entry.

> - [Low] proc: sysctl: unused mode field in struct sysctl_dirent

Dropped.

-- 

