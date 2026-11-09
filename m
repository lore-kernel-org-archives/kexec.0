Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B6606A323
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FsI2yWqS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iU5O51DC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GTe3rVqqBFubJwfvXPNDDRZX+sidHXepwnZzWomDy5A=; b=FsI2yWqSUKC3NOz6MvKuVCjyxF
	kVpSC3n20ec2oAnLyxNygLlHuomPKRUvdQn8Kf9MClUBGJEHG1nh0gGxj4MMtz1xpo3vbBuJfeeJD
	RFhsO790Cx7klPX1z/nLDwNmqpz/Wz9MGhLjTipN9TtB2yY/vS+geNpQmQFDivObLP/tKB5YSMC7d
	lLW7CYbag4htdrfvqqxOaKUBJAZ9O00WNaW12/VSpOe93PFj4BiAxf0kfBcqEPknvOOVefUnOoDht
	NyGfZ+/pOev3Ha3PCJjVdBZJ0ZofW/teU/1nloyKHTD8QHXtNcmmtDojG92SlNa8ZRxy8lo1CJYRb
	WbujjboA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNXG-00000000WHM-2sS4;
	Mon, 09 Nov 2026 11:27:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNXF-00000000WHA-2z8h;
	Mon, 09 Nov 2026 11:27:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CF2E9630DB;
	Mon,  9 Nov 2026 11:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EA41F0089F;
	Mon,  9 Nov 2026 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223656;
	bh=GTe3rVqqBFubJwfvXPNDDRZX+sidHXepwnZzWomDy5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iU5O51DC6zVVQKzDHuys9tIxjfbSOhYw8z0UcE86pb//wkXavh32S2N8S2PUurU2A
	 o1E3RopKG7W94xtmWo25LA834OkIsoplK5Zc5sWRxNqoMBKXFQxzncUeAVAHVqzYUN
	 x0xzl99BebTVjgItzYyFM18S+rvSgi3xMyTZJ/jJZ69X0Gf56Vq2vszIAP9EEsAUq5
	 YP1A5SHoyPmQVAQUq/DaV61yYmuj4yVaaeC+HIcZMJhadQiWUxN4AW86j7fp4xdZK/
	 SKtdAofdOgM6AVAC0cEZ3+8Z/6By8LpM/kvwzBv9E4RtCHAt3TdDxZIlKuxADBPb0I
	 863RWmyUQ6DWA==
Date: Mon, 9 Nov 2026 12:27:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
	Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 07/23] proc: let procfs own the seq_file of
 seq_file entries
Message-ID: <20261109-atemberaubend-begabung-bedienen-85aade0f99b4@brauner>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-7-76ace653a773@kernel.org>
 <8A21EE2A-F392-40B7-9152-CBC440FDDA70@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8A21EE2A-F392-40B7-9152-CBC440FDDA70@kernel.org>
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

On Sat, Nov 07, 2026 at 08:10:28AM -0800, Kees Cook wrote:
> Please use the new style typed allocation calls for objects:
> 
> ops = kmalloc_obj(*ops);
> 
> (This happened to jump out at me, but please check the other patches for this pattern.)

Done, there are 5 of them in total:

proc: resume readdir after the last name it returned
-		cursor = kmalloc(sizeof(*cursor), GFP_KERNEL_ACCOUNT);
+		cursor = kmalloc_obj(*cursor, GFP_KERNEL_ACCOUNT);

proc: sysctl: resume readdir after the last name it returned
-		cursor = kmalloc(sizeof(*cursor), GFP_KERNEL_ACCOUNT);
+		cursor = kmalloc_obj(*cursor, GFP_KERNEL_ACCOUNT);

proc: keep the open files of an entry in an open node
-		dp->open = kzalloc(sizeof(*dp->open), GFP_KERNEL);
+		dp->open = kzalloc_obj(*dp->open);

proc: own the wait queue of an entry with a ->proc_poll()
-	on = kzalloc(sizeof(*on), GFP_KERNEL);
+	on = kzalloc_obj(*on);

proc: let procfs own the seq_file of seq_file entries
-	ops = kmalloc(sizeof(*ops), GFP_KERNEL);
+	ops = kmalloc_obj(*ops);

-- 

