Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HijT4-0000Qu-HO
	for kexec@lists.infradead.org; Tue, 01 May 2007 04:55:59 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l413tqvv008920
	for <kexec@lists.infradead.org>; Mon, 30 Apr 2007 23:55:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l413tpkq179752
	for <kexec@lists.infradead.org>; Mon, 30 Apr 2007 21:55:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l413tpOc020179
	for <kexec@lists.infradead.org>; Mon, 30 Apr 2007 21:55:51 -0600
Date: Tue, 1 May 2007 09:25:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Message-ID: <20070501035539.GA15472@in.ibm.com>
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200704301717.08230.ak@suse.de>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andi Kleen <ak@suse.de>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Jurriaan <thunder7@xs4all.nl>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 30, 2007 at 05:17:07PM +0200, Andi Kleen wrote:
> On Monday 30 April 2007 17:12:39 Eric W. Biederman wrote:
> > 
> > Currently because vmlinux does not reflect that the kernel is relocatable
> > we still have to support CONFIG_PHYSICAL_START.  So this patch adds a small
> > c program to do what we cannot do with a linker script set the elf header
> > type to ET_DYN.
> > 
> > Since last time I have fixed the type to be in my code ET_DYN (oops),
> > and verified this works with kexec.  I realized while testing that we
> > don't have anyway of identifying a kernel vmlinux as linux so we
> > probably want to add an ELF note but that will be another patch.
> 
> The patch is ok for me, but does it pass Vivek's usual testing?

I am facing one issue with this patch. gdb can not analyze the
resulting kernel core file. Looks like gdb treats vmlinux differently if
ELF header type is "ET_DYN". It reads the symbol values incorrectly.

For example, symbol value of "panic_timeout" is 0xffffffff808a1fa8 but
gdb somehow things that it is 0xffffffff008aaebf. Looks like it is
performing some relocation.

I am using GNU gdb Red Hat Linux (6.5-5.fc6rh).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
