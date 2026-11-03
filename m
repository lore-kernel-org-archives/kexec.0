Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6986071C11
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CJKVjnH9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB9ymstx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1VZl7qidssi1ktD3Tb5xCqeZKKhCHxpcCGjwzNwohWM=; b=CJKVjnH9ZYtGUsXR1G6WdKxU/Y
	7LJf6iKlKpy9GaCQz28XScfbpBp4xyQnXrEbNAnwMKbpqF/nVn03YZ7rPXpQ44x7j9D3hxSeOLSvu
	doHngAeZMnTu4b26b56vXHb0eeF5f9Z4oPt92wdh09KAuPhpAMKbs/G3przuyyKprlbv27wneYync
	RjTR0XrQetLvvxpuPoa77/DSex0nztCeWWR0ItLOzD5ivstW5+Ln+EP/QnLp1onrbSU+nCLClKoAH
	dRJJIU5YurN/na9dEBWtuvXjfuHg4DlnD/mkU2dIbvNLabxRLtV0b2i8+Wdn+9JxmnAibXCDnTAyz
	LT53zYgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG13-00000002pu8-2KNn;
	Tue, 03 Nov 2026 15:01:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG12-00000002psE-15Mf
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09A2943C62;
	Tue,  3 Nov 2026 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A97D1F00A15;
	Tue,  3 Nov 2026 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718095;
	bh=1VZl7qidssi1ktD3Tb5xCqeZKKhCHxpcCGjwzNwohWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lB9ymstxD2jW9FJnjd7yfwgHQCygouVuaUNrPu/PoynIqBUhwdCZzT2zz6hDyMWfw
	 YcZohJmiuou7CXmFeQkBbobxsY7W3rz8baS8GVRJO0kQ8rp7jqpzXBDOF20ZwRkSnG
	 nErT+ShqWAVZWSSCrWbcFrcMc6bjV6OhjCsDbsHj6dNwDTLta4HQXunuCYdd8pGy5N
	 QM0q3S+koNafy+7N3iP/fwwlIqk3Bi1Wb1hFNC1OOvd3tT4xgM2trp03tV1cyoUKB+
	 JSxbtARnxikJyDqg4WFDJfKyHT4r+mahZr7saUIEqSOy07BNqSd/NKBk4ATzIkxAz4
	 zi3pQsJaFbcxw==
Message-ID: <sashiko-outbox-195541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/16] fs/proc/vmcore: let procfs copy out reads
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-ext4@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, tytso@mit.edu, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102-work-procfs-core-v1-14-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-14-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:33 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry. __read_vmcore() fills procfs' buffer
> through a kvec iov_iter. So a read goes through that buffer now instead
> of straight from the old memory into the reader's, which is what
> splice() did already. mmap() isn't affected. On ppc64 a machine check
> while reading the old memory used to be recovered through the exception
> table of copy_to_user(), by accident. copy_oldmem_page() copies with
> _copy_mc_to_iter() now, so a read through procfs' buffer recovers from
> it as well.
>=20
> The buffer is 128k, which keeps the entry pinned for one such piece at
> a time, and /proc/vmcore asks for PROC_ENTRY_FULL_READS so that a
> larger read is filled in pieces. kexec-tools treats a short read of it
> as fatal. A read that faults on its buffer in a later piece returns the
> pieces before it now instead of failing with -EFAULT. fadump removes
> /proc/vmcore when its memory is released and that no longer waits for a
> reader that faults on its buffer.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D14


