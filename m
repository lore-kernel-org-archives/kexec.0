Return-path: <kexec-bounces@lists.infradead.org>
Received: from iriserv.iradimed.com ([72.242.190.170] helo=iradimed.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IixuM-00012t-US
	for kexec@lists.infradead.org; Fri, 19 Oct 2007 20:53:25 +0100
Message-ID: <47190B28.6070405@cfl.rr.com>
Date: Fri, 19 Oct 2007 15:53:12 -0400
From: Phillip Susi <psusi@cfl.rr.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
In-Reply-To: <1192068833.27482.13.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Huang, Ying wrote:
> The hibernation procedure with the patch set is as follow:
> 
> 1. Boot a kernel A
> 
> 2. Work under kernel A
> 
> 3. Kexec another kernel B (crash dump enabled) in kernel A.
> 
> 4. Save the memory image of kernel A through crash dump (such as "cp
>    /proc/vmcore ~"). Save the "jump back entry".

Doesn't this also save the memory of kernel B?

> 5. Shutdown or reboot
> 
> 
> The restore process with the patch set is as follow:
> 
> 1. Boot a kernel C (crash dump enabled), the memory area used by
>    kernel C must be a subset of memory area used by kernel B.

Why is a third kernel needed?  Why can't kernel B be used for this as 
well?  In fact, if kernel A has been compiled to be relocatable and 
crash dump enabled, why wouldn't it suffice for all 3 instances?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
