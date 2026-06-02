Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D067CD6E4A
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 04:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wIQ55KKhG2naj18Kp9jOr/iIgcjF/MYnZCwgeJV7AVY=; b=KWhF9TieshpCW1yeQLV40fKqRJ
	eKbif9fnTq0x4ttTToHokmIrCiju3vOkRzu6+a17AhGhRZgdUbZ1qxMhgfjhehLF2mz/et8/1/8o/
	fqs2Etjz3+AG5b0rJ+GpE4rp8qrz5E4ktYPImdUdcWzQNzqQpssSPno9kRejbfng6Y2yKaYTEPlrq
	pIbZIqBCmtKGBB2s1qdAnFiMC8pYNRc6pkuUG7fRBUxxpSW+22us17kyrNLTHIiDpEktLqQXxhYdG
	dIDrYkZsuyPQSpMHxkQKhs9ekkO8u/9yI6CAmz3fvubkEwfwSeflsAXCIdIisEbx2rNi4wu3Bs0tx
	kN1XVQqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUH4J-0000000CIej-2oIn;
	Tue, 02 Jun 2026 04:49:35 +0000
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUH4H-0000000CIeG-1ZJx
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 04:49:34 +0000
Date: Mon, 1 Jun 2026 21:49:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1780375770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIQ55KKhG2naj18Kp9jOr/iIgcjF/MYnZCwgeJV7AVY=;
	b=bFWiWjpiTklmlRoJ3ZVJI/j+XaIKXnOuwXmjezkhE3ZunZbvysSrlv3El5eW0QKqi2yMIR
	35nSBRkjjqfmVjXkjRugD0KsrUb0cXwQXsLa80Zca/3WVvWp7pbPAa1c5spDhXhqWjAlG4
	dM/Ay6X7klUY8YK91Dz4nmcBGok8UkJP4xOsWNwa9eZFHhllrWwcnNBIr3EVmFjXd7HUpj
	4n4YTb9jh501lZZS15VNSXY4FkjqXX6wGOXaYR8dYBwytHx1X80v4UfDakm9xblLo9GCv1
	zVpeoi0ByNxtv+xIvjs/jxQiTY7qKVXldlIVWVvC1bfRMq3L9KjOY3QRBzyJig==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Tao Liu <ltao@redhat.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org,
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
Message-ID: <ah5gyh2RfLg-JzDF@templeofstupid.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <ahoA_5MfC7FuC8CQ@templeofstupid.com>
 <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
 <ah4oINLOlhxpQuFR@templeofstupid.com>
 <CAO7dBbWZ8V_33MnXfgd_DfAwOVEBYtjwwm2DQxy8OrbipYBuBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7dBbWZ8V_33MnXfgd_DfAwOVEBYtjwwm2DQxy8OrbipYBuBQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_214933_754878_B595CE09 
X-CRM114-Status: GOOD (  52.12  )
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

On Tue, Jun 02, 2026 at 03:04:12PM +1200, Tao Liu wrote:
> On Tue, Jun 2, 2026 at 12:47 PM Krister Johansen
> <kjlx@templeofstupid.com> wrote:
> Thanks for your in-depth explanation, it's very helpful to me for
> designing the data erasing function.

Thanks for the great discussion.

> > On Tue, Jun 02, 2026 at 11:12:05AM +1200, Tao Liu wrote:
> > > On Sat, May 30, 2026 at 9:11 AM Krister Johansen
> > I wondered about this, but for data-structures that are smaller than a
> > page, wouldn't that mean that we're erasing other content?  The "erase"
> > plugins memset the output data to a chosen value (or 0), whereas the
> > filtering just drops the page.  Couldn't this also lead to a situation
> > where the debugger can't find the page at all, versus giving us one
> > that's sanitized?  (I do understand why you want to drop the pages for
> > the GPU cases)
> 
> Frankly I didn't consider the data erasing as in-depth as you did. I
> think you are right, makedumpfile needs to know which extensions
> handle data erasing and which handle mm page filtering. I guess the mm
> page filtering extensions will need to perform a "dry-run" filter
> first, in case the "data erasing" extensions break any useful data
> structure. In this step, "dry-run" will only record pfn numbers of the
> pages that will be filtered. Then "data erasing" extensions are
> called, so all the sensitive data is memset to 0. Finally, all desired
> pages are filtered out based on the previous recording.
> 
> With this, "data erase" and "page filtering" will not interfere with
> each other. What do you think?

This is a great point.  It's probably worth documenting the precedence
order in which these callbacks are expected to be applied.  Naively, I
might expect filtering pages to take precedence over erasing data
structures.  For the GPU cases, these are orthogonal.  However, for
something where a user might be both trying to filter the page and erase
matching content, we don't have any rules defined.  It's probably less
surprising to allow pages to be filtered first.  (I think it is this way
in the code.) It also prevents the page filtering from completely
filtering a page.

> > > > Would you be willing to modify the extension registration options to
> > > > allow an extension to specify what kind it is? That way, in the future
> > >
> > > I'm not sure what you mean by "what kind". Do you mean an extension
> > > needs to tell makedumpfile what purpose it is for when loading?
> >
> > Yes, sorry I wasn't clear in writing the question.  Stating this
> > differently, if we want to allow the ability for different extensions to
> > do different things, how do the extensions declare to makedumpfile what
> > they can do, so that it knows where to invoke their callbacks, and what
> > callbacks of theirs to invoke.
> >
> > Looking at patch 6/9, right now run_extension_callback() is involved
> > from __exclude_unncessary_pages and always calls the
> > "extension_callback" symbol in the module.  This makes sense for a
> > single extension type that's focused on filtering pages.  However, if we
> > wanted to have multiple different extensions, this might be more
> > difficult.
> >
> > If we could determine what type of functionality the module implements
> > in load_extensions, then we could tell if this is a page filtering
> > extension, an erase extension, or some other kind of extension.
> >
> > For example, for an erase filter, perhaps we would want two callbacks:
> > one to set up the ranges to filter "extension_gather_callback" and
> > another to actuallyf check the address range to see if it is filtered,
> > "extension_filter_data_callback"
> >
> > I'm not sure about the names.  "extension_callback" seems generic, but
> > this has a specific purpose.  It's a "extension_filter_page_callback"
> >
> > I may be overengineering this a bit, but having makedumpfile pass an ops
> > vector to the extension in a load function could help here.  Then the
> > module's load function fills out the vector with the functions it
> > supports.  Depending on what's implemented, these can be placed into
> > different callback lists to get invoked at different points in the
> > program (e.g. one at pfn filter time, another in filter_data_buffer,
> > etc).
> >
> > It sounds like you had a plan here, though.  Were you thinking of adding
> > new extension types a different way?
> 
> I see your idea: makedumpfile predefines a few hook points at
> different stages, and extensions can register their callbacks to these
> hook points. For now I think 2 hook points are enough, one for page
> filtering and other one for resiger the data erasing, which definitely
> shouldn't be within __exclude_unnecessary_pages().
> 
> I'm willing to modify the code. Such as implementing a hooking point
> registration/management. But since I haven't work on the data erasing
> functions so far, the design might be superficial, personally I'd
> prefer to do this along with the data erasing functions in the next
> independent patchset, considering current patchset we already includes
> plenty of code/function implementations. @maintainers, What's your
> opinion?

Just to clarify, I'm not asking that you implement any erase
functionality in the current patchset.  Rather, asking if there's a way
to implement the current functionality such that the extension modules
won't need recompilation when a new extension type is introduced. I
think there are a number of different ways to do this, but I didn't want
to be overly prescriptive in my feedback.

Thanks again,

-K

