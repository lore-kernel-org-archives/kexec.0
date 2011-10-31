Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RKocO-00015S-2x
	for kexec@lists.infradead.org; Mon, 31 Oct 2011 09:57:25 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9V9vIVU000896
	for <kexec@lists.infradead.org>; Mon, 31 Oct 2011 09:57:18 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9V9vHvq2281486
	for <kexec@lists.infradead.org>; Mon, 31 Oct 2011 09:57:17 GMT
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9V9vG0b015504
	for <kexec@lists.infradead.org>; Mon, 31 Oct 2011 03:57:17 -0600
Message-ID: <1320055036.2796.8.camel@br98xy6r>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Mon, 31 Oct 2011 10:57:16 +0100
In-Reply-To: <20111028161143.e5ebf617.akpm@linux-foundation.org>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

Hello Andrew,

On Fri, 2011-10-28 at 16:11 -0700, Andrew Morton wrote:

[snip]

> Should this be done earlier in the function?  As it stands we'll have
> multiple CPUs scribbling on buf[] at the same time and all trying to
> print the same thing at the same time, dumping their stacks, etc. 
> Perhaps it would be better to single-thread all that stuff

My fist patch took the spinlock at the beginning of panic(). But then
Eric asked, if it wouldn't be better to get both panic printk's and I
agreed.

> Also...  this patch affects all CPU architectures, all configs, etc. 
> So we're expecting that every architecture's smp_send_stop() is able to
> stop a CPU which is spinning in spin_lock(), possibly with local
> interrupts disabled.  Will this work?

At least on s390 it will work. If there are architectures that can't
stop disabled CPUs then this problem is already there without this
patch.

Example:

1. 1st CPU gets lock X and panics
2. 2nd CPU is disabled and gets lock X
3. 1st CPU calls smp_send_stop()
   -> 2nd CPU loops disabled and can't be stopped

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
