Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LSfMj-0001iO-Ep
	for kexec@lists.infradead.org; Thu, 29 Jan 2009 22:28:08 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0TMSVQH029897
	for <kexec@lists.infradead.org>; Thu, 29 Jan 2009 17:28:31 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0TMS2S2168698
	for <kexec@lists.infradead.org>; Thu, 29 Jan 2009 17:28:04 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0TMS17r031120
	for <kexec@lists.infradead.org>; Thu, 29 Jan 2009 17:28:01 -0500
Subject: Re: boot hang: async vs. kexec
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <49821C68.4000502@oracle.com>
References: <49821C68.4000502@oracle.com>
Date: Thu, 29 Jan 2009 16:28:00 -0600
Message-Id: <1233268080.9299.135.camel@norville.austin.ibm.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "arjan@infradead.org" <arjan@infradead.org>

On Thu, 2009-01-29 at 13:15 -0800, Randy Dunlap wrote:
> I (try to) do daily build/boot testing.  The newly built kernel
> is booted via kexec.  This was working until sometime between
> 2.6.28 and 2.6.29-rc1, so I bisected it.*
> 
> git bisect blames this commit:
> 
> 96777fe7b042e5a5d0fe5fb861fcd6cd80ef9634 is first bad commit
> commit 96777fe7b042e5a5d0fe5fb861fcd6cd80ef9634
> Author: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Date:   Thu Jan 8 09:46:31 2009 -0600
> 
>     async: Don't call async_synchronize_full_special() while holding sb_lock
>     
>     sync_filesystems() shouldn't be calling async_synchronize_full_special
>     while holding a spinlock.  The second while loop in that function is the
>     right place for this anyway.
> 
> 
> The new/kexec-loaded kernel hangs during initcalls.  The last one that
> I can see (via netconsole, might miss a few of the very last lines) is:
> 
> calling  net_ns_init+0x0/0x14d @ 1
> net_namespace: 1008 bytes
> initcall net_ns_init+0x0/0x14d returned 0 after 0 usecs
> 
> 
> 
> Any ideas/suggestions?

I'm not sure about any limitations of git bisect, but it seems unlikely
to me that sync_filesystems() would be getting called this early.  Are
any filesystems even mounted at this point?

Does reverting that commit fix the problem?  (I would be surprised, but
stranger things have happened.)

> Thanks.
> 
> 
> 
> *caveat: This was all done with the "don't use gcc 4.1.[01]
> because it miscompiles __weak" patch reverted.  Could that
> be an issue/problem here?  (I'm using gcc 4.1.1.)

I have no idea.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
