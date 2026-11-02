Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7E606EE82
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nxjF7dNP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4XS/+Qp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IboT5prE1F2zgLUjN3M8JJkwTsSKYt9w9Q1ZY5Lm5jE=; b=nxjF7dNPQm2Oxi
	zVCWJzYDoV9vbMe/mMFfry0nekJrABnSVvWAeFX9kYGd75UqnRUjiqS1u5U3/a0ip9NP6LMEvn4Oh
	MunJKWNwNUN6X1MLUOHD9ESyFw7UrTJFy0wEwUr5HMyuKujV8FxK3Ix1uq3fYxxmBQ1ZAPTZwgaYO
	2qQ9753aL640WzGohGfQTOmI2DFaKSiLpJ7I3ywfZ8MwbU06WrBh7knMj3da3MJQSGDRz1gsHFiu3
	yMpaLX/CJP9SOacCgad1rth08F1pq8tNYGqSjaZVnPIozFtR5NEvrGRIJdFXAaJUWZpQPI78sR4Ii
	l5MVEMQF4xkLHBKoFMWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNzMt-00000000RqE-3Gkm;
	Mon, 02 Nov 2026 21:15:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNzMs-00000000Rpv-1UEC
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 21:15:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4E0042A5F;
	Mon,  2 Nov 2026 21:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19181F00A1A;
	Mon,  2 Nov 2026 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654101;
	bh=IboT5prE1F2zgLUjN3M8JJkwTsSKYt9w9Q1ZY5Lm5jE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=i4XS/+Qp/XJpkpHyhLatkkxrTnb76H0AyrbluP9UrYsSjjvFvYed65zWeP+n5bDMR
	 T4jrppxwRxmsiUoLJtpEDBZOQUgSEb2I7JAqNJICoUtmRZqGDSr+AkbMY5KraB9hcp
	 LJSetra0CCoguNvIXys8kMbF38qG79C7rZIljzi9OxsucTBr2qJtAKy2hNxphivV7X
	 SqR7z4TvF6OS2jxQo3eWdNU0GD2TA876qUhcb25obxs7Qa0hq+gMR1c2AKZ0TYfXxl
	 /PRnwvUkfYbroZLwoik/xUkslivJlp+q60cSPVqp80BDXlYt0jmnPbIlU0+2JbsucT
	 rjIixFbj3/TrQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3FB84F4006B;
	Mon,  2 Nov 2026 16:14:59 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:14:59 -0500
X-ME-Sender: <xms:U_3oagUAPKL0KahIhejOYJwKEPfYb6twqYG_HHugM7_eLn8Er-TgPg>
    <xme:U_3oavZTuzGHMfK0qXbinG0nc7CYskrIhJQ5eHOz_Ha7XvQtwnXU_T7hJPsGo9qg4
    BhXiwA3Pdzj3QiIOE4JzHYJnc55BkwZtZcinLkFBcrDsA6sylLxQvo7>
X-ME-Proxy-Cause: dmFkZTGSCWblgfsMhzNjEIN00ph1bmXztXGhYrK6FQCSJysx8m5mqsCTJHkCuZD0tpZuBG
    pYnx6qST1krVMCyjpYhoMBo2TltjSYVP2LKGOkZnOBb4t//k/nGoJ/SIXKKJyIATQl84il
    BuXRlRV3aPeB88TAd/llIDq/9PMZ1EzorVjUV4ox06mXS/IOKUqdbOTFcr2gFtJFq3Gx7F
    Zq0nEujwlkDiPcDOX28riG6oQW7iLTgD6BaMnfnV9H0ADvTknFe8adm4EFa+o6I1mSuG3K
    LJ3epAVfTBg3DuzNRu88aZuYWYeuI7KoVJah/eioVIkx6sAoHZjqyTVRvcNhYqHYgvNdOh
    F7RoapMXPpPy7fnRDGp1EnOzRafp7mYLbQvUWevKonPpL0zVugnrni/xwOB0ZUdq15K6LL
    U4eIWAyGEDjfaCYO/Dppo1HoBBuP1Ugp4Zki+kXZHcTkA1gjEQVaV70KrwrPcut26vPd/h
    q5yJSVyn3x/Ch0xklWbVCXPbWoaIS17brwWPL/guaVzJxizQ0P/jgX0plm53NXTsLd+70V
    110yVl467ZsRMKGBWdC4JnWQHbcxAMHjeZkhkyAsfOuCVSLebxwzvInrQKLcoImyb5UwHY
    pO0Oc+d4/j2oJCRnrCOkOe51eLIclfMVgyBLq7y/6qqZiV8XA97NvuTzr1lg
X-ME-Proxy: <xmx:U_3oatxqYhX0hWpcSGJgdTO64UmbQLn1zkSvkgmn2QN3P9YNu5WJ0w>
    <xmx:U_3oav5HgW2k6KeJbHXAdQUNPTjXcBKAkESvLUwa5JME7gNZc5c0tQ>
    <xmx:U_3oasSgNqIt2BaGeBZ12VcERyFoy0lpk1cdl0eiT57vWKlvWpphXg>
    <xmx:U_3oaifZ0cTDaYHT72Jch7KjTqrgvVpyqwgckwFzCeMt7Uwl9HyKaw>
    <xmx:U_3oapwU7EvPML2sBaImLYgTk9SsDSGibfYemkcHEOBIYG1GVrkdWT-b>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 181AE78273B; Mon,  2 Nov 2026 16:14:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlKaHQIBeldV
Date: Mon, 02 Nov 2026 16:14:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <961e7e3d-2117-48ee-8a7e-a7a851ec8ef8@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 06/27] nfsd: let procfs own the seq_file of
 /proc/fs/nfs/exports
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Declare the seq_operations and let procfs open and free the seq_file.
> ->proc_open() and ->proc_release() only set up ->private and take and
> drop the reference to the network namespace now. Reading the file then
> no longer holds up its removal.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

