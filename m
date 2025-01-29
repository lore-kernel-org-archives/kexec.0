Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A938C02190
	for <kexec@archiver.kernel.org>; Wed, 29 Jan 2025 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nURhNL5CXDCG5u+sGjTuuMwgP9Va2BW312i7D9feyB4=; b=zC7gcIKnZjupe2/nLMm0RVINhj
	LSg1Nrficod6rDNz+xHaObFGesK+/3+5SFatzWi8NzdtAQo0daO+H6py8nvSfotFFBC5s3Z5vO2T7
	dcrK12bzzkFRnMfbPm0quSAt6MEX1RjbbOnqu3D61SpmueQCAJ/vRTfQERNeA0UOhnLlgwhTb3a0w
	mBJwQEDwN8+Mm32LmQTt+xHUoKee4uRfan8Le6Zk2q3/J8u9JQxl4Ga5lix5D7HEBzZwXMFo8KiM0
	yJ3ObEqaFd6Y3ROWj3TI/wqCB2ehV4Q7KdL8tNX+wx1C2CX6LRxhrkZNr3QO+QnWmIIV5ez8cG0Fi
	KrESPdHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td8V5-000000073As-0yDe;
	Wed, 29 Jan 2025 13:53:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td3l9-00000006a6N-2Cow;
	Wed, 29 Jan 2025 08:49:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 631165C027D;
	Wed, 29 Jan 2025 08:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFA1C4CED3;
	Wed, 29 Jan 2025 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738140558;
	bh=bkecGghn49Q0kcBr4/Q4RAYEqTU2lzStxg+kMBkUviM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+6QRnebTmdCsTn/fBIyawZ8F2h5FOi1VkBceKjrJE9gQqYhsE4MpI+DUnmOyvn9r
	 jy2STn2XFJrPEPFrh+vO/ZWYbctxdvY6UR3Ry6YZK+y8a1MhcK6ynlBs1p1BMMkJ1P
	 w6gLTDQPv35AYJJgnh4TzBlS6e9ascDPFne+p1YDjEpGVHG5PR2AxRH9J1o9Q9BPKi
	 anvTB+Oa86UvplOCcaBDT4qhHCCSJO/P11ip4o+2DBjUNcnkNIz/KxsEnezLq+wofc
	 pmlKCTkKHhEdUE5jBQ13DTAnVV4ZlV/QW5dr1RzqeBZB57C+fkYnuuFh6jqnxMpijz
	 QxNX1fm0X2YKQ==
Date: Wed, 29 Jan 2025 09:49:13 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Jani Nikula <jani.nikula@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
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
	"Darrick J. Wong" <djwong@kernel.org>, Corey Minyard <cminyard@mvista.com>
Subject: Re: Re: Re: Re: Re: [PATCH v2] treewide: const qualify ctl_tables
 where applicable
Message-ID: <umk5gfo7iq7krppvqsal57hlzds26bdqd3g7kccjzuudjikdws@k2oknd6zx6g7>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
 <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <nslqrapp4v3rknjgtfk4cg64ha7rewrrg24aslo2e5jmxfwce5@t4chrpuk632k>
 <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
 <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
 <87jzag9ugx.fsf@intel.com>
 <Z5epb86xkHQ3BLhp@casper.infradead.org>
 <u2fwibsnbfvulxj6adigla6geiafh2vuve4hcyo4vmeytwjl7p@oz6xonrq5225>
 <CAHC9VhQnB_bsQaezBfAcA0bE7Zoc99QXrvO1qjpHA-J8+_doYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQnB_bsQaezBfAcA0bE7Zoc99QXrvO1qjpHA-J8+_doYg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_004919_756110_0C2A956E 
X-CRM114-Status: GOOD (  25.41  )
X-Mailman-Approved-At: Wed, 29 Jan 2025 05:53:00 -0800
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

On Tue, Jan 28, 2025 at 10:43:10AM -0500, Paul Moore wrote:
> On Tue, Jan 28, 2025 at 6:22 AM Joel Granados <joel.granados@kernel.org> wrote:
> > On Mon, Jan 27, 2025 at 03:42:39PM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 27, 2025 at 04:55:58PM +0200, Jani Nikula wrote:
> > > > You could have static const within functions too. You get the rodata
> > > > protection and function local scope, best of both worlds?
> > >
> > > timer_active is on the stack, so it can't be static const.
> > >
> > > Does this really need to be cc'd to such a wide distribution list?
> > That is a very good question. I removed 160 people from the original
> > e-mail and left the ones that where previously involved with this patch
> > and left all the lists for good measure. But it seems I can reduce it
> > even more.
> >
> > How about this: For these treewide efforts I just leave the people that
> > are/were involved in the series and add two lists: linux-kernel and
> > linux-hardening.
> >
> > Unless someone screams, I'll try this out on my next treewide.
> 
> I'm not screaming about it :) but anything that touches the LSM,
I'll consider it as a scream :) So I'll keep my previous approach of
leaving only personal mails that are involved, but leaving all the lists
that b4 suggests.

> SELinux, or audit code (or matches the regex in MAINTAINERS) I would
> prefer to see on the associated mailing list.

General comment sent to the void:
It is tricky to know exactly who wants to be informed of all this and
who thinks its useless. I think that if we want more focus it should
come from automated tools like b4. Maybe some string in MAINTAINERS
stating that the list should not be used in cases of tree-wide commits?

Best

-- 

Joel Granados

