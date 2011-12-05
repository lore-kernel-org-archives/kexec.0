Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXdGy-0004XX-29
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 18:28:17 +0000
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 5 Dec 2011 23:58:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB5IS7wv2281662
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 23:58:07 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB5IS6t8023745
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 23:58:07 +0530
Message-ID: <4EDD0D35.1020907@linux.vnet.ibm.com>
Date: Mon, 05 Dec 2011 23:58:05 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111205171443.GB627@google.com> <4EDCFE9F.9050605@linux.vnet.ibm.com>
 <20111205173057.GE627@google.com> <4EDD0254.10408@linux.vnet.ibm.com>
In-Reply-To: <4EDD0254.10408@linux.vnet.ibm.com>
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

On 12/05/2011 11:11 PM, Srivatsa S. Bhat wrote:

> On 12/05/2011 11:00 PM, Tejun Heo wrote:
> 
>> (cc'ing Oleg)
>>
>> On Mon, Dec 05, 2011 at 10:55:51PM +0530, Srivatsa S. Bhat wrote:
>>> I wanted these APIs to be generic, not restricted to work only for userspace
>>> processes. Both freezer_do_not_count() and freezer_count() are effective only
>>> when current->mm is non-NULL (ie., only for userspace ones).
>>> I think I have documented this in the patch which added these things to the
>>> 2 APIs. See commit 6a76b7a in linux-pm/linux-next.
>>
>> I see.  Oleg was curious about the ->mm condition too and IIRC there's
>> no reason for that restriction.  Maybe removing that in another patch
>> and using the count functions is better?
>>
> 
> 
> Oh well, then yes, that sounds like a better idea. Will send patches for
> that. Thank you.
> 


I looked up in git and found that commit ba96a0c by Rafael introduced the
count functions, to handle the vfork case. But now, we seem to have more
uses than that. So I think we can remove that userspace restriction in the
count functions, and in kernel/fork.c, do something like:

if (current->mm)
	freezer_do_not_count();
...
if (current->mm)
	freezer_count();

This way, it wouldn't break anything, since functionality-wise it is equivalent
to the existing code; And we get what we want: ability to directly use the
count functions elsewhere.

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
