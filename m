Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DD6E77199
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FyJ5AfCFZjEgs/ThYKbNaUoqxERTMbozAAc583jmNxY=; b=RqAFeNLW/QjfoPR65P+O75GX5t
	tbbyXYD23JFeqncGvMiuc991cqPPfKxDQuJ9XLqv/f5IhmfUtuyfdxaFci2PycFQLfzUeXDY27V8g
	vy1dgOXsCzY71HVMudHS3biRXdMTFqaOrcCkDg6xRNj06IXRajDT1gIbFeC2vOt1uSQB7xDaXBcv/
	X0KRg2I8P56xWFkS+CfcLiILXOw6VGa4BgKjtsN/RGCY5LFAu/p8BSdoo4BW5mR/SsmOq7ZXmlDf6
	EWr7rmaf8Ekud+XSSK+aD0avXYVaOGgVjJUaJGx/QOCXcSIR98K0gXvqcfLDZzVbuG/G25j3MOaYz
	TtQKnSRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqGz-000000020nv-1pc8;
	Mon, 06 Jan 2025 16:48:13 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqGw-000000020nN-191h
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 16:48:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6FB71A41B22;
	Mon,  6 Jan 2025 16:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDD3C4CED2;
	Mon,  6 Jan 2025 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182089;
	bh=HEO2MLf1VHgRzbREgQgzMwKlNqe5Agqt4kRQTnCkfOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsijK6UWM2KPMQJBfvl+vFx8bFrxXhTGRtzqTu1U2GAZFVUO1R/FJBcV18ZANjRcC
	 79g4z7UqwfAkLa7S41BW2+teSCP+ZIYOvvDEzSZxcH+vLnCV/J2IoXM4jk3IvKDLBf
	 zu++zuSzxQgAhJ0KmjLlPp2Vi/5h2VIe3LtNVEImtJ8t3KXkVu4FqE/Z27xA7sS2et
	 CYtIgvEMF2tm20TeugiUA6L8m3n4Lsfuo/Hdenv4NP7hoLTCSys9LUdUKAACMYF4iP
	 CfYhKGTpqBSWtli/1njZ/oNSHQS6ghcSospxSMXFD/xqHxEc/H/I31p0f17xEtsQsT
	 SCLecFPd/gdgA==
Date: Mon, 6 Jan 2025 08:48:05 -0800
From: Kees Cook <kees@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, kexec@lists.infradead.org,
	devel@daynix.com
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
Message-ID: <202501060830.B735C3A@keescook>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084810_382288_5EA7F508 
X-CRM114-Status: GOOD (  17.07  )
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

On Sat, Jan 04, 2025 at 11:38:34PM +0900, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> However, NT_PRSTATUS is also named "CORE". It is also unclear what
> "these types" refers to.
> 
> To fix these problems, define a name for each note type. The added
> definitions are macros so the kernel and userspace can directly refer to
> them.

While ELF is specified in the Tool Interface Standard[1], the core dump
format doesn't have an official specification. It does follow a lot of
agreed rules, though, and the "note name" is intended to help coredump
consumers distinguish between "common" things ("CORE") and Linux-specific
things ("LINUX").

I think this should be explicitly spelled out in the UAPI header,
even if we have "mistakes" for this mapping.

I'm not convinced we need these macros, though: everything is "LINUX"
expect the common types. And the GNU types are "GNU". There are only 7
types under the "CORE" name. :)

For the macros, I'd much prefer NN_CORE, NN_LINUX, and NN_GNU.

If you really want to be able to examine the name from the type, then
yeah, I guess we need something like the macros you have, but I'd much
prefer also adding a macro like Dave suggested[2], and then replace the
fill_note() with a macro that can unwrap it:

	fill_note(note, NT_SIGINFO, size..., data...);

The repetition of NN_type, NT_type doesn't feel robust if we have a
programmatic mapping: only the "type" is needed to determine both, so
why supply both?

-Kees

[1] https://refspecs.linuxfoundation.org/elf/elf.pdf
[2] https://lore.kernel.org/lkml/Z3vuBTiQvnRvv9DQ@e133380.arm.com/

-- 
Kees Cook

