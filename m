Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55534606D827
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WW+tbSvw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkGIp68v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vFLCfIpQzvj87maXuJncKjZMHxfbMjkVEErOwSrEMzQ=; b=WW+tbSvwmiE3C+d/d2rdwAhRT+
	wGdVSZglseNNRdw5vniNEFh/1sa/ooWb166nfBDI1TZVkrVIaa9bJ/1Dfo0GRgr+7E1z1z6lkxWFc
	X23mSMIFZC69CXh7WOa/x0EHcoRK9h6SfJLPo8oC59Y/jENlP5mBbb3s/6QM5B9fg+iXChSYbu4jC
	O1fyCNKSWgQa1cvPCKEuN5nk/SPqknogMO6QC6poiQGAmLjZl/nbIoTzUpRE98OQy0/bjValaB4Lo
	QYefFEeFCCpp9VwuQqetAaMdyn8FZ0ET5lMRwRGYKe3OlF3EaS6eXyit/tFkbWRlZzAacp7dACqU4
	/edZoy1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOX7o-00000004qmx-3Qks;
	Wed, 04 Nov 2026 09:17:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOX7n-00000004qmk-3CVf;
	Wed, 04 Nov 2026 09:17:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33B61600CB;
	Wed,  4 Nov 2026 09:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9461A1F000C1;
	Wed,  4 Nov 2026 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783862;
	bh=vFLCfIpQzvj87maXuJncKjZMHxfbMjkVEErOwSrEMzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkGIp68vobiZwB2XixXdCJHgtF8bS2InhigVuwsdqp6n5/W+M82eXJQmgMDIXncGQ
	 ZsgLev6upKoTph4wRGMw/6Rt8tdd4yiEe0QTNTPemQ626tgZDkM1GcZGQlIINcGmX1
	 rweyg/M+elK322suBIlSSUF7Ca/phJp24NGzpraEYkCKjrptZL+chTq0rR5ps9q2f2
	 buSjg3t9Zzbjt9a55NJ2t3tMIsF7dtK6fdeAh04poa02hll2Rco50kbc8I+oEfsxAS
	 NzUPxVvIxDSaOzz7ERaAm3QpoNHvfOUNEKEQothQH0rTaYd4IAl0SGRh52pJdJDENe
	 eaiECSjcPGAaQ==
Date: Wed, 4 Nov 2026 10:17:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
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
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of
 config space accesses
Message-ID: <20261104-beugt-kapern-geehrt-19e2e2dd58f6@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
 <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
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

On Mon, Nov 02, 2026 at 09:58:51AM -0800, Linus Torvalds wrote:
> I think this would actually be better with rw_verify_area() just
> checking a per-file maxbytes.
>
> We already have that logic for lseek and friends - using that fairly
> hacky combination of s_maxbytes and !unsigned_offsets().
>
> We should combine s_maxbytes and unsigned_offsets() at file open time
> into f_maxbytes and check that not just at lseek but in
> rw_verify_area.
>
> And then things like proc_bus_pci could set it's size limit in one single place.

Yeah, I like that.

Hm, maybe we should keep this and the isapnp thing small and do that
change on top.

This also might mean a change in behavior. Because a read past the end
returns 0 for proc_bus_pci and for a regular file past s_maxbytes. So
that would potentially need some more changes.

