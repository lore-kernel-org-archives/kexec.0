Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E8606A890
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NDWf9y13;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=R5XxGFbM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6+DIIko/jddTALojzUdCwqYFD7qAVSieeB13vaTbTZ4=; b=NDWf9y13bCF0zMMuzG4kGSYayx
	iAXGLO4+FlMHuKb2fvJbUDoyxI/lCcOhQyWLAZ8mbCUMsKLnECRc3EUmP/Nnj8257TC8ZKBw7o3Xf
	A8LgWMMdDmSf/ZZWzp0UU0nqHifCv2WpfZcJ0KQIlJhd3OqCht+eP+W+JwmbVYo7pIxeJTWa+EIpm
	SRO6h95nc8Svzd20GXd2ORY3Lq5EfYvd1L1ds6skaSZ9wJra6yeA453Qt09nYBYpgFtNxaKeI1T7g
	xR5iHLJDUJxkPkD126ThKkK/TP7CvXex+rrH4V1Taky8YNrrP72DKb7D95n+lqqPRw5F9J5qWrWu9
	ljSu8vWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6yv-00000006aYd-01OT;
	Wed, 11 Nov 2026 11:59:13 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6ys-00000006aY3-15Pe;
	Wed, 11 Nov 2026 11:59:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6+DIIko/jddTALojzUdCwqYFD7qAVSieeB13vaTbTZ4=; b=R5XxGFbM6TZRqhT0SXxuzcMt1x
	LUNRh7V8lAnKwChToktKXZ/BvtFiWDBfAUJ9dLKtb2UHW2064KOlAZ6KUeSJJgWg/hPASfykHm9lb
	dvvgSD9ejQiiI+LIrAd6gbPGs/9xZWqr0yWBdHoCClUgJD2Bg1YMupaoC/QOZRmfVPSCT6MpDMhbS
	246KM0GzqcBbc4E2580QxhluNnyoa2vW19Sk2kqFlCkeQ6ViS/yest6rZWy5lPKlR+T/Ay7hDfWGq
	IJLMSEFD0EmRJ6D4dVOiq+0BkJb7lfNarlib+MyMxjNYvepLWzR3xSOakoCQkMgy3TimUB70/p52t
	iE2dAMXA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xR6yh-00DAF9-2o;
	Wed, 11 Nov 2026 11:59:00 +0000
Date: Wed, 11 Nov 2026 03:58:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
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
	Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2 39/51] powerpc/crash_dump: recover from a
 machine check in copy_oldmem_page()
Message-ID: <avRXzzCSzT9Qj2FC@gmail.com>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-39-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-work-procfs-bugfixes-v2-39-021c84d852e0@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_035910_683300_6662D60E 
X-CRM114-Status: GOOD (  18.66  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:25:32PM +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel, and that memory
> may well have uncorrectable errors. On powerpc a machine check in the
> kernel is only recovered from if the instruction that took it has an
> exception table entry (cf. mce_common_process_ue()). copy_oldmem_page()
> copies with copy_to_iter(). For a read() of /proc/vmcore that is a user
> copy, all of whose loads have exception table entries, so the machine
> check turns into a short copy and read_from_oldmem() returns -EFAULT.
> 
> But since commit 4a22fd20379c ("vmcore: convert __read_vmcore to use an
> iov_iter") /proc/vmcore can be spliced too, and splice(), sendfile()
> and copy_file_range() copy into kernel pages with memcpy(), which has
> no exception table entries. A machine check there panics the capture
> kernel. The same goes for the reads of the ELF headers and notes that
> vmcore does itself, and those have been memcpy() for as long as
> copy_oldmem_page() has had its kernel buffer branch, since commit
> 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page").
> 
> Copy with _copy_mc_to_iter() instead. PPC64 selects ARCH_HAS_COPY_MC
> and there it uses copy_mc_generic() for kernel and user destinations
> alike, which has the exception table entries. Everywhere else it is
> _copy_to_iter().
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an iov_iter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

The change is the right direction, and x86_64 has the same gap.

arch/x86/kernel/crash_dump_64.c:__copy_oldmem_page() copies with
copy_to_iter(), the same as the powerpc code this patch changes. x86_64
selects ARCH_HAS_COPY_MC, and _copy_mc_to_iter() is already available,
with the _copy_to_iter() fallback in include/linux/uio.h for arches
without it. The plain and encrypted paths share __copy_oldmem_page(), so
one conversion there covers both.

PS: I found this because I am looking at x856 production fleet  kdump
success rate , where first kernel died of an MCE very often produce no
usable vmcore at all, and makedumpfile never finishes due to this type
of problem.

