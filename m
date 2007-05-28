Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hsd6q-0003Ce-4A
	for kexec@lists.infradead.org; Mon, 28 May 2007 07:09:57 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4SB9sgN013310
	for <kexec@lists.infradead.org>; Mon, 28 May 2007 07:09:54 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4SB9sp4532238
	for <kexec@lists.infradead.org>; Mon, 28 May 2007 07:09:54 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4SB9slw014531
	for <kexec@lists.infradead.org>; Mon, 28 May 2007 07:09:54 -0400
Date: Mon, 28 May 2007 16:39:44 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Message-ID: <20070528110944.GE32045@in.ibm.com>
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de> <20070501035539.GA15472@in.ibm.com>
	<m14pmx18ey.fsf@ebiederm.dsl.xmission.com>
	<20070501050657.GA23111@in.ibm.com>
	<20070528105442.GA25599@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070528105442.GA25599@suse.de>
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
To: Andi Kleen <ak@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Mon, May 28, 2007 at 12:54:42PM +0200, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@in.ibm.com> [2007-05-01 07:06]:
> > This seems to be a problem with gdb 6.5. I transferred the dump to a
> > different machine having GNU gdb 6.4, and it works fine there.
> 
> What's the state of it? Andy, was the GDB breakage the reason why you
> didn't merge it? Did someone file a GDB bug?
> 

I had sent a mail to gdb mailing list but no response. Did not raise
a bug though.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
