Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcY5-0003nr-16
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:41:54 +0000
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 5 Dec 2011 23:11:50 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB5HfhNP4481046
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 23:11:43 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB5HfgdR024091
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 04:41:43 +1100
Message-ID: <4EDD0254.10408@linux.vnet.ibm.com>
Date: Mon, 05 Dec 2011 23:11:40 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111205171443.GB627@google.com> <4EDCFE9F.9050605@linux.vnet.ibm.com>
 <20111205173057.GE627@google.com>
In-Reply-To: <20111205173057.GE627@google.com>
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
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rjw@sisk.pl, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz

On 12/05/2011 11:00 PM, Tejun Heo wrote:

> (cc'ing Oleg)
> 
> On Mon, Dec 05, 2011 at 10:55:51PM +0530, Srivatsa S. Bhat wrote:
>> I wanted these APIs to be generic, not restricted to work only for userspace
>> processes. Both freezer_do_not_count() and freezer_count() are effective only
>> when current->mm is non-NULL (ie., only for userspace ones).
>> I think I have documented this in the patch which added these things to the
>> 2 APIs. See commit 6a76b7a in linux-pm/linux-next.
> 
> I see.  Oleg was curious about the ->mm condition too and IIRC there's
> no reason for that restriction.  Maybe removing that in another patch
> and using the count functions is better?
> 


Oh well, then yes, that sounds like a better idea. Will send patches for
that. Thank you.

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
