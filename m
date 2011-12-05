Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcV8-0001Rd-8y
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:38:52 +0000
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 5 Dec 2011 23:08:45 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB5HceI51532060
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 23:08:40 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB5HceaY011527
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 04:38:40 +1100
Message-ID: <4EDD019E.9010009@linux.vnet.ibm.com>
Date: Mon, 05 Dec 2011 23:08:38 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] PM / Docs: Recommend the use of
 [un]lock_system_sleep() over mutex_[un]lock(&pm_mutex)
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111204200332.25620.53610.stgit@srivatsabhat.in.ibm.com>
 <20111205171508.GC627@google.com>
In-Reply-To: <20111205171508.GC627@google.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz

On 12/05/2011 10:45 PM, Tejun Heo wrote:

> Hello,
> 
> On Mon, Dec 05, 2011 at 01:33:42AM +0530, Srivatsa S. Bhat wrote:
>> Update the documentation to explain the perils of directly using
>> mutex_[un]lock(&pm_mutex) and recommend the usage of the safe
>> APIs [un]lock_system_sleep() instead.
> 
> Maybe just make it pm internal?
> 


Sorry, I didn't get what you meant here. Are you talking about what
needs to be added/changed in the documentation or, are you referring
to the code itself and are saying that we must make these APIs
internal to the PM alone?

If it is the latter, please note that memory hotplug is one of the
outside-of-PM user of these APIs, and hence we really can't make
these APIs internal to the PM alone without substantially needing to
change the memory hotplug code to mutually exclude itself from PM
somehow without using these APIs.
And moreover, since these APIs avoid task freezing failures when
some out-of-PM user like memory hotplug code uses them, I don't see
much benefit by making them internal to the PM. IOW, I don't see
much use left of them, if we do that.

IMHO, we should leave these APIs as they are, until we have a better
solution for out-of-PM users to mutex themselves from PM. (For one,
currently it is not always possible to hook onto PM notifiers to
achieve that, in which case these APIs will come in handy, and these
aren't that ugly anyway, so no harm using them when necessary.)

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
