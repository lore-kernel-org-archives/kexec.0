Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcIl-0007eR-NH
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:26:05 +0000
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 5 Dec 2011 17:12:03 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB5HMKHb3108924
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 04:22:20 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB5HPtgu021580
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 04:25:55 +1100
Message-ID: <4EDCFE9F.9050605@linux.vnet.ibm.com>
Date: Mon, 05 Dec 2011 22:55:51 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111205171443.GB627@google.com>
In-Reply-To: <20111205171443.GB627@google.com>
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

On 12/05/2011 10:44 PM, Tejun Heo wrote:

> Hello,
> 
> On Mon, Dec 05, 2011 at 01:32:38AM +0530, Srivatsa S. Bhat wrote:
>> +static inline void lock_system_sleep(void)
>> +{
>> +	/* simplified freezer_do_not_count() */
>> +	current->flags |= PF_FREEZER_SKIP;
>> +	mutex_lock(&pm_mutex);
>> +}
>> +
>> +static inline void unlock_system_sleep(void)
>> +{
>> +	mutex_unlock(&pm_mutex);
>> +	/* simplified freezer_count() */
>> +	current->flags &= ~PF_FREEZER_SKIP;
>> +}
> 
> BTW, don't we want try_to_freeze() there?  What's the reason for not
> using freezer_count()?
> 


I wanted these APIs to be generic, not restricted to work only for userspace
processes. Both freezer_do_not_count() and freezer_count() are effective only
when current->mm is non-NULL (ie., only for userspace ones).
I think I have documented this in the patch which added these things to the
2 APIs. See commit 6a76b7a in linux-pm/linux-next.

As for try_to_freeze(), we can surely add that. I think I missed it while
open-coding the relevant part of freezer_count(). I'll send it as a separate
patch. Thank you very much.

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
