Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HiXcz-0006rs-DU
	for kexec@lists.infradead.org; Mon, 30 Apr 2007 11:17:27 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Date: Mon, 30 Apr 2007 17:17:07 +0200
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704301717.08230.ak@suse.de>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>

On Monday 30 April 2007 17:12:39 Eric W. Biederman wrote:
> 
> Currently because vmlinux does not reflect that the kernel is relocatable
> we still have to support CONFIG_PHYSICAL_START.  So this patch adds a small
> c program to do what we cannot do with a linker script set the elf header
> type to ET_DYN.
> 
> Since last time I have fixed the type to be in my code ET_DYN (oops),
> and verified this works with kexec.  I realized while testing that we
> don't have anyway of identifying a kernel vmlinux as linux so we
> probably want to add an ELF note but that will be another patch.

The patch is ok for me, but does it pass Vivek's usual testing?

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
