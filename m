Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51833C0218C
	for <kexec@archiver.kernel.org>; Mon, 27 Jan 2025 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=epQcBRbikRChnEcLD7GohI/p/yPUxTUqgScFKmNVdcQ=; b=G6PC+W2wH53ZR+jUUcgFZ4C3+E
	pwLe2WR9ojt6N4x5Gmr2C9jXSvrMSpsf/rd1152v/ahTQ9KFGwUKH/bNwLsJT0XVmwBI1VZpZP8bi
	wurKAWLxQFU0O8761GpmcFw6B5EM5iMz0a2JvhPv+EbLrWDg04ohmxS7YqnqqOZsiUs/ZP0P+ERvc
	o6ftNMfLgbpdpXqRRxH8nq2c+KUD6+/NAcyjOVAee30TEUnqndnaK661ay6KvFScGblBa7fw8ZJbi
	xAovX0WCmv+UnYNHrAMMwDH4I8EfoFtqqKLFnnHlVk9+j0lK2dA2v+H1p0DsSInUl5HvOdM0Pwhlf
	I65g8TAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRfu-00000002j3a-1oUE;
	Mon, 27 Jan 2025 16:09:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcPV3-00000002Pe3-0nX3;
	Mon, 27 Jan 2025 13:50:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 554B0A4154E;
	Mon, 27 Jan 2025 13:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881ACC4CED2;
	Mon, 27 Jan 2025 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737985800;
	bh=laZX1iWKmTFe6EBXe6dQ6V5dBHky9feUPubV8bbHYy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITreSYYkYqJo0yzT/NmeCNaU8ylN9fF82uixbVQhbAMNhn/x1ksvsdeN2BZIjx7Av
	 6jRzLOfnz1KOiZ8BN/+a6yzSKjX86nOzP6ewnKK12LbyYoLRgr6MitIVZMs+Q9nRjt
	 1O56sOuQWf9/oW9JBeL1K1Ep9SPnbGRY0gAqf1BfWdrmsV6P6rbrAzrEzJaWATIpCg
	 PxgyGHOSh+1Dp+na/sGNdWcGsgzNCRs4/nnMHS16Kt8UOkwJO9cYsDiIOKruHAZkDs
	 tuJVwo0MPlNeiRHuQkLVgJEWRQ8mSboCfx8PwGZonQ0+bdJkEjI8BLPDWS5oZchNDY
	 iBi9Q4ViZ4cfA==
Date: Mon, 27 Jan 2025 14:49:55 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, codalist@coda.cs.cmu.edu, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org, 
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, Song Liu <song@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Corey Minyard <cminyard@mvista.com>
Subject: Re: Re: Re: [PATCH v2] treewide: const qualify ctl_tables where
 applicable
Message-ID: <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
 <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <nslqrapp4v3rknjgtfk4cg64ha7rewrrg24aslo2e5jmxfwce5@t4chrpuk632k>
 <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_055001_385228_4A289846 
X-CRM114-Status: GOOD (  32.41  )
X-Mailman-Approved-At: Mon, 27 Jan 2025 08:09:21 -0800
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

On Wed, Jan 22, 2025 at 01:41:35PM +0100, Ard Biesheuvel wrote:
> On Wed, 22 Jan 2025 at 13:25, Joel Granados <joel.granados@kernel.org> wrote:
> >
> > On Tue, Jan 21, 2025 at 02:40:16PM +0100, Alexander Gordeev wrote:
> > > On Fri, Jan 10, 2025 at 03:16:08PM +0100, Joel Granados wrote:
> > >
> > > Hi Joel,
> > >
> > > > Add the const qualifier to all the ctl_tables in the tree except for
> > > > watchdog_hardlockup_sysctl, memory_allocation_profiling_sysctls,
> > > > loadpin_sysctl_table and the ones calling register_net_sysctl (./net,
> > > > drivers/inifiniband dirs). These are special cases as they use a
> > > > registration function with a non-const qualified ctl_table argument or
> > > > modify the arrays before passing them on to the registration function.
> > > >
> > > > Constifying ctl_table structs will prevent the modification of
> > > > proc_handler function pointers as the arrays would reside in .rodata.
> > > > This is made possible after commit 78eb4ea25cd5 ("sysctl: treewide:
> > > > constify the ctl_table argument of proc_handlers") constified all the
> > > > proc_handlers.
> > >
> > > I could identify at least these occurences in s390 code as well:
> > Hey Alexander
> >
> > Thx for bringing these to my attention. I had completely missed them as
> > the spatch only deals with ctl_tables outside functions.
> >
> > Short answer:
> > These should not be included in the current patch because they are a
> > different pattern from how sysctl tables are usually used. So I will not
> > include them.
> >
> > With that said, I think it might be interesting to look closer at them
> > as they seem to be complicating the proc_handler (I have to look at them
> > closer).
> >
> > I see that they are defining a ctl_table struct within the functions and
> > just using the data (from the incoming ctl_table) to forward things down
> > to proc_do{u,}intvec_* functions. This is very odd and I have only seen
> > it done in order to change the incoming ctl_table (which is not what is
> > being done here).
> >
> > I will take a closer look after the merge window and circle back with
> > more info. Might take me a while as I'm not very familiar with s390
> > code; any additional information on why those are being used inside the
> > functions would be helpfull.
> >
> 
> Using const data on the stack is not as useful, because the stack is
> always mapped writable.
> 
> Global data structures marked 'const' will be moved into an ELF
> section that is typically mapped read-only in its entirely, and so the
> data cannot be modified by writing to it directly. No such protection
> is possible for the stack, and so the constness there is only enforced
> at compile time.
I completely agree with you. No reason to use const within those
functions. But why define those ctl_tables in function to begin with.
Can't you just use the ones that are defined outside the functions?

Best


-- 

Joel Granados

