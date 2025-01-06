Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5EBE77199
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRA2mT1FDJLw9rDAL19zAy8V1ZZTmoCMlSJNj6lQNi4=; b=lVfhg01QXSyqnFHY6AMgM/TBx1
	HE1G5dsjp7ozVZIvmCfuWuICP+Xn7UAHmQxahPcIB4CzgGJE6ewqYCZknZe7YQVw0T5wUXC6EVNRC
	zfwGzJoDVn6Dovhu3foGO9GuDI93SLWWoWM+rOp4VkGgdMp6uKsnpkP8JxUiv3cpWD+bxBuoTtYps
	58dD6D7ZLs4H5ZjhqOLOeuw3qoz1eWyNVdD0a0nT/hboEwAEp6tSgoJpsNMsuwrQu0Dns2gpOWw+L
	Bj7DaGiKwB0Y93+DrDEY3PaUG5+SlpiWIJXwLSOFmAVq05EEO09dlB/ZJZYwJpR7663LVeSdTyRrJ
	tYcwlFPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqpp-000000026mO-2mtq;
	Mon, 06 Jan 2025 17:24:13 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqpm-000000026ku-2yNj
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 17:24:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A32143D;
	Mon,  6 Jan 2025 09:24:37 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F35C43F673;
	Mon,  6 Jan 2025 09:24:06 -0800 (PST)
Date: Mon, 6 Jan 2025 17:23:50 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
Message-ID: <Z3wRnX4RHg7KDYDT@e133380.arm.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
 <202501060830.B735C3A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501060830.B735C3A@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_092410_841467_D421B2E6 
X-CRM114-Status: GOOD (  35.24  )
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

Hi all,

On Mon, Jan 06, 2025 at 08:48:05AM -0800, Kees Cook wrote:
> On Sat, Jan 04, 2025 at 11:38:34PM +0900, Akihiko Odaki wrote:
> > elf.h had a comment saying:
> > > Notes used in ET_CORE. Architectures export some of the arch register
> > > sets using the corresponding note types via the PTRACE_GETREGSET and
> > > PTRACE_SETREGSET requests.
> > > The note name for these types is "LINUX", except NT_PRFPREG that is
> > > named "CORE".
> > 
> > However, NT_PRSTATUS is also named "CORE". It is also unclear what
> > "these types" refers to.
> > 
> > To fix these problems, define a name for each note type. The added
> > definitions are macros so the kernel and userspace can directly refer to
> > them.
> 
> While ELF is specified in the Tool Interface Standard[1], the core dump
> format doesn't have an official specification. It does follow a lot of
> agreed rules, though, and the "note name" is intended to help coredump
> consumers distinguish between "common" things ("CORE") and Linux-specific
> things ("LINUX").
> 
> I think this should be explicitly spelled out in the UAPI header,
> even if we have "mistakes" for this mapping.

This seems reasonable.

> I'm not convinced we need these macros, though: everything is "LINUX"
> expect the common types. And the GNU types are "GNU". There are only 7
> types under the "CORE" name. :)

My starting point for suggesting the new macros was that the current
usage seems to be a historical accident; there doesn't seem to be an
underlying logic to it, except that arch-independent core note types
defined by Linux are named "CORE" ... except when they aren't.

Although the number of exceptional cases is small today, this doesn't
make for a robust rule -- nothing really prevents more unintentional
anomalies being added in future, so it seems prone to bitrot.

If the names are arbitrary, having a table rather than trying to
describe a rule seems the best way to avoid confusion.

Documenting these in a regular way may also encourage people to treat
the name as a formal part of the identifier, rather than a sort of
"comment" that nobody is quite sure what to do with (even if [1] makes
it clear).

That said, software does cope with the situation today; it's just a bit
gross.

> 
> For the macros, I'd much prefer NN_CORE, NN_LINUX, and NN_GNU.

What would be the point of these?

#define NN_CORE "CORE" doesn't convey any information at all, though I
suppose it does provide a layer of typo-resistance.

> If you really want to be able to examine the name from the type, then
> yeah, I guess we need something like the macros you have, but I'd much
> prefer also adding a macro like Dave suggested[2], and then replace the
> fill_note() with a macro that can unwrap it:
> 
> 	fill_note(note, NT_SIGINFO, size..., data...);
> 
> The repetition of NN_type, NT_type doesn't feel robust if we have a
> programmatic mapping: only the "type" is needed to determine both, so
> why supply both?
> 
> -Kees
> 
> [1] https://refspecs.linuxfoundation.org/elf/elf.pdf
> [2] https://lore.kernel.org/lkml/Z3vuBTiQvnRvv9DQ@e133380.arm.com/

Although not "robust", it should at least be obvious to the eye of
anyone pasting and repurposing an existing snippet of code that the
"type" is probably supposed to match in a single call.

I suppose we could have a kernel helper function containing a big
switch that gives you the name for each recognised note type though.
At the source code level, that would avoid specifying the "NN_"
arguments explicitly.  But if we still want a canonical way to describe
this mapping in elf.h, the "NN_" macros still serve a purpose.


With a literal string instead, I would expect then when adapting

	fill_note(note, NT_SIGINFO, "CORE", ...)

to

	fill_note(note, NT_WIZZFOO, ???, ...)

it's not clear what ??? should be.  I think people have tended to shrug
and just leave it unchanged -- so, it depends on which bit of code was
randomly chosen to serve as a template.  I could be guessing wrongly
about that, but if that's how the name gets chosen for new notes then
it doesn't feel ideal.

Cheers
---Dave

