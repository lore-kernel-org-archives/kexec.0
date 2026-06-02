Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61FCD6E55
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 00:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abiQ97Q4kdYgiZXk1+OAIFyPyAY9W/ef1YTGHQCDaQE=; b=tuM9a+DuHiTXVF35ghdao9W7mL
	tbZsXkQAe9sjgtXFqKFUSPpVsnqDfrpgF9MMhATWe+18R45ipFeGb5+/vwPh+Kxm5jm0AHW3IvpCG
	yHcmzhKCfhL7wF7cZQaWnHHhCUV8H6OsVPIPQUR7uFbFPWLrRvct3CNt6qIw8l2NFJ9vM4QyN3hPe
	eT9k0D1CbabMfXoFoMl/ficOPPt6rhpyv63pJbJ3yPQTM5CmR3UFggaiQZ5buKWs1v459pkGgqxfT
	Nf2SPmUBUPbWb2aPyLAnJ9cKc5THHvewI1ibhr55Byz7KefSxavUcqHtftw0xnvFcwjjy12WtICNI
	t/feZBsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUDID-0000000C7ZK-1IlS;
	Tue, 02 Jun 2026 00:47:41 +0000
Received: from out-182.mta1.migadu.com ([2001:41d0:203:375::b6])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUDIA-0000000C7YZ-0RWq
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 00:47:40 +0000
Date: Mon, 1 Jun 2026 17:47:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1780361255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abiQ97Q4kdYgiZXk1+OAIFyPyAY9W/ef1YTGHQCDaQE=;
	b=fN8y82Ejy5lDEC4uwQ8tobqfWmfWO/fA/UiV63QXquePsXLq+VGyf7xKLlxWHqnhgsn5UN
	4ZZZMJnKa+InpjnktsTj2bhzFj1lgB3QvhQtqSAtmfyd4QIdmUgScXtRMIR8fHOlGu/qbo
	PmeMOlAFb4cZbS+K+qJVja+CNFRDHG1HpmgFECTsoBYGgwuO2CChAFcI2y6nORoWQzCd/G
	ykT5R6X0ZNEr19g0jfc2o6l/eL89VkPyE9LsIOsUtzWtRoFiDRjhAaQW4UtTuMBYCe+c6c
	ltHEexk1/cL44IJyMx6zngfrGXpHZlRqhkg/XyyW8uLO5uOdlYUP40yRZ+g/Ng==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Tao Liu <ltao@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>, yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com, kexec@lists.infradead.org,
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
Message-ID: <ah4oINLOlhxpQuFR@templeofstupid.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <ahoA_5MfC7FuC8CQ@templeofstupid.com>
 <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_174738_826147_C7DAC43D 
X-CRM114-Status: GOOD (  53.27  )
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

Hi Tao,
Thanks for the response! I've put the followups below.

On Tue, Jun 02, 2026 at 11:12:05AM +1200, Tao Liu wrote:
> On Sat, May 30, 2026 at 9:11 AM Krister Johansen
> <kjlx@templeofstupid.com> wrote:
> >
> > I love this idea.  Do you have time to take it further, and if not are
> > you open to making the extension framework more modular so that we could
> > add others in the future?
> 
> The purpose of extension is to make the framework modular. My original
> thought is, we can implement several makedumpfile extensions, each
> restricted to one specific function. Like one extension deals with AMD
> gpu mm filtering only, one deals with Intel gpu only etc. For distros
> we can ship all extensions along with makedumpfile once, but the
> respective extensions will only take effect if the machine has AMD /
> Intel gpu. This is the same case if you'd like to add other customized
> functions while the makedumpfile core remains unchanged.

Makes sense.

> > Could the btf lookups be extended to cover the symbol lookups used by
> > eppic and the erase filters so that the -x option is unnecessary for
> > kernels that have BTF support?
> 
> Yes, from my view it is doable and not difficult to implement.

In some environments, the size of the vmlinux + modules can be fairly
substantial to leave on disk.  It's attractive to have the option to
omit it and still filter dumps.

> > The current extension implementation is focused just on skipping pages,
> > but it would be great to be able to use this to erase data in structures
> > like the config filters and eppic, but without having to provide a
> > vmlinux at dump time.  What do you think about adding the ability to
> > use the extensions to also erase parts of data structures, in addition
> > to filtering whole pages?
> 
> That's the step 2 for the BTF/kallsyms work of makedumpfile, and I
> have planed to work on this once the patchset(step 1) is accepted. The
> reason for the task dividing is, the GPU mm page filtering is more
> urgent than data erasing from my view. For data erasing, at least we
> can do the erasing in 1st kernel with the help of dwarf, cumbersome
> but working; For GPU mm filtering, as far as I know, there are no
> handy tools in 2nd kernel.

Excited to hear that you have something already planned for erasing.  My
apologies if I missed a more comprehensive write-up about the longer
term goals for the work.

> I think erasing the data is doable upon the current page filtering code.

I wondered about this, but for data-structures that are smaller than a
page, wouldn't that mean that we're erasing other content?  The "erase"
plugins memset the output data to a chosen value (or 0), whereas the
filtering just drops the page.  Couldn't this also lead to a situation
where the debugger can't find the page at all, versus giving us one
that's sanitized?  (I do understand why you want to drop the pages for
the GPU cases)

> > Would you be willing to modify the extension registration options to
> > allow an extension to specify what kind it is? That way, in the future
> 
> I'm not sure what you mean by "what kind". Do you mean an extension
> needs to tell makedumpfile what purpose it is for when loading?

Yes, sorry I wasn't clear in writing the question.  Stating this
differently, if we want to allow the ability for different extensions to
do different things, how do the extensions declare to makedumpfile what
they can do, so that it knows where to invoke their callbacks, and what
callbacks of theirs to invoke.

Looking at patch 6/9, right now run_extension_callback() is involved
from __exclude_unncessary_pages and always calls the
"extension_callback" symbol in the module.  This makes sense for a
single extension type that's focused on filtering pages.  However, if we
wanted to have multiple different extensions, this might be more
difficult.

If we could determine what type of functionality the module implements
in load_extensions, then we could tell if this is a page filtering
extension, an erase extension, or some other kind of extension.

For example, for an erase filter, perhaps we would want two callbacks:
one to set up the ranges to filter "extension_gather_callback" and
another to actuallyf check the address range to see if it is filtered,
"extension_filter_data_callback"

I'm not sure about the names.  "extension_callback" seems generic, but
this has a specific purpose.  It's a "extension_filter_page_callback"

I may be overengineering this a bit, but having makedumpfile pass an ops
vector to the extension in a load function could help here.  Then the
module's load function fills out the vector with the functions it
supports.  Depending on what's implemented, these can be placed into
different callback lists to get invoked at different points in the
program (e.g. one at pfn filter time, another in filter_data_buffer,
etc).

It sounds like you had a plan here, though.  Were you thinking of adding
new extension types a different way?

> > we could register multiple different kinds without breaking existing
> > ones.  One for filtering pages, one for erasing / modifying dump
> > content, and others based upon whatever additional use cases develop.
> 
> That's the goal of extensions, each extension deals with its own
> business. Could you point out the code that doesn't match the goal?
> I'm happy to correct it in v6.

Yes, I attempted to elaborate on this in the preceding paragraphs.
Basically wondering how we can add new extension functionality without
breaking existing extensions, and then get the code to invoke the right
if there are multiple types that need to be used at different times.

Thanks,

-K

