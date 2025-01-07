Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742BBE77199
	for <kexec@archiver.kernel.org>; Tue,  7 Jan 2025 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJSphBGIariLO7Kt8bB27/WK7gPxbh/RSwAS9mn80rs=; b=0EEAlZ0SlvwvMoG9H+06IHMFGR
	521ofXbx/oInWGBjaQh998BneNS7xRwRPMZjlGr4LwrdxAhxjSfyUyBgN0871pj5meOfiT/dxtwgB
	L8ArbeohGVDrOB9RHzPJpZ+yZ3WzRdUdIxypuYFU5tJuwkfeiZuW8N/Pvb0tR8OOLFbKekT4dDCKJ
	XpbwnUFsXsdYDzto9lV86P0QGOzKg4Qp6YhqCT8mqbRjJgJvEd+ykZcZWT/x7HyfFhI3KSC16xyZu
	61+3HozbMTs/IMNjHTkPZPcy+bdh5y7gu8TEiFuzg4LSBFDn3ZcJ9b0cCQfV/ShmL78h/6C/bve98
	mlnggmXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCIu-00000005b8G-0qWO;
	Tue, 07 Jan 2025 16:19:40 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCHq-00000005aqY-184e
	for kexec@lists.infradead.org;
	Tue, 07 Jan 2025 16:18:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30929143D;
	Tue,  7 Jan 2025 08:18:58 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3AA3F59E;
	Tue,  7 Jan 2025 08:18:27 -0800 (PST)
Date: Tue, 7 Jan 2025 16:18:25 +0000
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
Message-ID: <Z31T0dMgMucke5KS@e133380.arm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-2-99cb505b1ab2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-elf-v3-2-99cb505b1ab2@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_081834_421587_4C06F131 
X-CRM114-Status: GOOD (  21.83  )
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

On Tue, Jan 07, 2025 at 09:45:53PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.

Also (and more importantly) get rid of duplicated knowledge about the
mapping of note types to note names, so that elf.h is the authoritative
source of this information?

> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  fs/binfmt_elf.c       | 21 ++++++++++-----------
>  fs/binfmt_elf_fdpic.c |  8 ++++----
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 106f0e8af177..5b4a92e5e508 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c

[...]

> @@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>  	do
>  		i += 2;
>  	while (auxv[i - 2] != AT_NULL);
> -	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
> +	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
>  	thread_status_size += notesize(&auxv_note);
>  
>  	offset = sizeof(*elf);				/* ELF header */

Looking at this code, it appears that the right name is explicitly
taken from elf.h for a few specific notes, but for those that are
specified by the arch code (e.g., in struct user_regset entries) the
name is still guessed locally:

static int fill_thread_core_info(...) {

...

	fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
		note_type, ret, data);


It would be preferable to clean this up if we want elf.h to be the
authoritative source for the names.

It would be possible to add a .core_note_name entry in struct
user_regset, and define a helper macro to populate the note type and
name, something like the following:

struct user_regset {
	...
	unsigned int core_note_type;
+	unsigned int core_note_name;
};

#define USER_REGSET_NOTE_TYPE(type) \
	.core_note_type = NT_ ## type, \
	.core_note_name = NN_ ## name,

...and then replace every .core_note_type assignment with an invocation
of this macro.  A quick git grep should easily find all the affected
cases.


Alternatively, as discussed in the last review round, a helper could
be defined to get the name for a note type:

const char *elf_note_name(int Elf32_Word n_type)
{
	switch (n_type) {
	case NT_PRSTATUS:	return NN_PRSTATUS;
	case NT_PRFPREG:	return NN_PRFPREG;
	/* ...and all the rest..., then: */

	default:
		WARN();
		return "LINUX";
	}
}

This avoids the caller having to specify the name explicitly, but only
works if all the n_type values are unique for the note types that Linux
knows about (currently true).

Experimenting with this shows that GCC 11.4.0 (for example) doesn't do
a very good job with this switch, though, and it requires building
knowledge about irrelevant arch-specific note types into every kernel.
I think that extending struct user_regset is probably the better
approach -- though other people may disagree.

Cheers
---Dave

