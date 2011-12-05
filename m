Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcmM-0000Yd-4K
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:56:39 +0000
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 5 Dec 2011 23:26:33 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB5HuPFX2298092
 for <kexec@lists.infradead.org>; Mon, 5 Dec 2011 23:26:25 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB5HuOOc024812
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 04:56:25 +1100
Message-ID: <4EDD05C6.8080809@linux.vnet.ibm.com>
Date: Mon, 05 Dec 2011 23:26:22 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] PM / Docs: Recommend the use of
 [un]lock_system_sleep() over mutex_[un]lock(&pm_mutex)
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111204200332.25620.53610.stgit@srivatsabhat.in.ibm.com>
 <20111205171508.GC627@google.com> <4EDD019E.9010009@linux.vnet.ibm.com>
 <20111205174349.GG627@google.com>
In-Reply-To: <20111205174349.GG627@google.com>
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

On 12/05/2011 11:13 PM, Tejun Heo wrote:

> Hello,
> 
> On Mon, Dec 05, 2011 at 11:08:38PM +0530, Srivatsa S. Bhat wrote:
>> Sorry, I didn't get what you meant here. Are you talking about what
>> needs to be added/changed in the documentation or, are you referring
>> to the code itself and are saying that we must make these APIs
>> internal to the PM alone?
> 
> Ooh, sorry about not being clear.  I meant pm_mutex itself.  There's
> no reason to expose that outside of pm, right?  And in the
> documentation, we can just require use of the APIs instead of pm_mutex
> itself.
> 


Yes, that sounds good. No need for giving unnecessary choices :-)
But I had worded the documentation that way with the intention of
explaining why calling mutex_lock() over pm_mutex can be disastrous (which
I mentioned in the commit message as one of the goals of the patch).
I didn't mean it to give the user 2 choices and say please use
[un]lock_system_sleep() preferably.

Although, we have to notice that unless somebody is acquainted with
these APIs, the first instinct would probably be to directly use
mutex_lock(), until they look up the documentation (hopefully).
So, IMHO, it would do good to keep the explanation in the docs as
it is, in this patch. What do you think?

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
