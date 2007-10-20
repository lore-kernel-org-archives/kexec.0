Return-path: <kexec-bounces@lists.infradead.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]
	helo=bifrost.lang.hm)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ij3Sn-0008SP-Ad
	for kexec@lists.infradead.org; Sat, 20 Oct 2007 02:49:19 +0100
Date: Fri, 19 Oct 2007 18:53:55 -0700 (PDT)
From: david@lang.hm
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
In-Reply-To: <47190B28.6070405@cfl.rr.com>
Message-ID: <Pine.LNX.4.64.0710191852560.1538@asgard.lang.hm>
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
	<47190B28.6070405@cfl.rr.com>
MIME-Version: 1.0
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
To: Phillip Susi <psusi@cfl.rr.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Fri, 19 Oct 2007, Phillip Susi wrote:

> Huang, Ying wrote:
>> 
>> 
>> The restore process with the patch set is as follow:
>> 
>> 1. Boot a kernel C (crash dump enabled), the memory area used by
>>    kernel C must be a subset of memory area used by kernel B.
>
> Why is a third kernel needed?  Why can't kernel B be used for this as well? 
> In fact, if kernel A has been compiled to be relocatable and crash dump 
> enabled, why wouldn't it suffice for all 3 instances?

you could use one kernel for all three, or you could use three different 
kernels, and three different sets of userspace if it's appropriate.

David Lang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
