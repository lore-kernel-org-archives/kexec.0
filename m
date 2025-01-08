Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47977E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dp4YiVyk7VgThiWRacmuSQVvTMLuSAHIMMx/x3SLL+k=; b=LBFFyOKxsKmD1SVj00SL3zBaEe
	CrRYRmRgdE3x2qYdb/oybORZALPGL99fhpZEp6v+hwm2CB7L4r4x/45etPKFzK29IF7wa0CLtXLU0
	xphQwe8mlwfXAi3Qnnxtb6nXg/+O7cYzT31rx0HsbzqknOs0HXvPdmUcB6zZIQMpfFLucVTgT+Yi3
	/BCZa25FeBOI5m3WBdPMO4EStLRwVqxynj51GLW5U7ce8+bRrTK92lPfgW3Vt+TzWqxJXPpXByoKr
	MGcySgoMft+FjKu2NXN1qGoGXBOC22NVojFGniW2FlJGdpY0FgXbqTV0JpH2v4rYU5D2MqA3HKx7m
	oZLW5NuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVWNS-00000008eqo-3EEp;
	Wed, 08 Jan 2025 13:45:42 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVWN3-00000008edl-3Haz
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 13:45:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DC2C13D5;
	Wed,  8 Jan 2025 05:45:44 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3294C3F673;
	Wed,  8 Jan 2025 05:45:14 -0800 (PST)
Date: Wed, 8 Jan 2025 13:45:11 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v3 2/6] binfmt_elf: Use note name macros
Message-ID: <Z36BZ8LytWJS9bFT@e133380.arm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-2-99cb505b1ab2@daynix.com>
 <Z31T0dMgMucke5KS@e133380.arm.com>
 <2c6f2c95-b2fc-46e0-91ce-1b9f14b28d3d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6f2c95-b2fc-46e0-91ce-1b9f14b28d3d@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_054517_913365_F83333F1 
X-CRM114-Status: GOOD (  34.58  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Jan 08, 2025 at 01:34:24PM +0900, Akihiko Odaki wrote:
> On 2025/01/08 1:18, Dave Martin wrote:
> > On Tue, Jan 07, 2025 at 09:45:53PM +0900, Akihiko Odaki wrote:
> > > Use note name macros to match with the userspace's expectation.
> > 
> > Also (and more importantly) get rid of duplicated knowledge about the
> > mapping of note types to note names, so that elf.h is the authoritative
> > source of this information?
> > 
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Acked-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >   fs/binfmt_elf.c       | 21 ++++++++++-----------
> > >   fs/binfmt_elf_fdpic.c |  8 ++++----
> > >   2 files changed, 14 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index 106f0e8af177..5b4a92e5e508 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > 
> > [...]
> > 
> > > @@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
> > >   	do
> > >   		i += 2;
> > >   	while (auxv[i - 2] != AT_NULL);
> > > -	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
> > > +	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
> > >   	thread_status_size += notesize(&auxv_note);
> > >   	offset = sizeof(*elf);				/* ELF header */
> > 
> > Looking at this code, it appears that the right name is explicitly
> > taken from elf.h for a few specific notes, but for those that are
> > specified by the arch code (e.g., in struct user_regset entries) the
> > name is still guessed locally:
> > 
> > static int fill_thread_core_info(...) {
> > 
> > ...
> > 
> > 	fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
> > 		note_type, ret, data);
> > 
> > 
> > It would be preferable to clean this up if we want elf.h to be the
> > authoritative source for the names.
> 
> If we want elf.h to be the authoritative source, yes, but I like the current
> form as it ensures nobody adds a note with a name different from "LINUX" and
> it is also simpler. There is a trade-off so I'd like to keep the current
> form unless anyone has a strong preference for one option.
> 
> Regards,
> Akihiko Odaki

I can see where you're coming from here.

It would be nice to at least be able to check that elf.h is consistent
with the behaviour here, but you're right -- there is a tradeoff.

Maybe add a comment in elf.h at the end of the block of #defines saying
that new Linux-specific entries should use the name "LINUX"?

Either way, I don't think it's a huge deal.  If people are happy with
this code as-is, then I don't have an issue with it.


I might follow up with a separate patch if this series is merged, and
people can consider it on its own merits (or lack thereof).

Cheers
---Dave

