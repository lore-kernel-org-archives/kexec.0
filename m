Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXe4E-00016k-Pt
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 19:19:11 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 5 Dec 2011 20:12:47 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB5JFMeU3457114
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 06:15:22 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB5JIvYT011893
 for <kexec@lists.infradead.org>; Tue, 6 Dec 2011 06:18:58 +1100
Message-ID: <4EDD191D.2030409@linux.vnet.ibm.com>
Date: Tue, 06 Dec 2011 00:48:53 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111205171443.GB627@google.com> <4EDCFE9F.9050605@linux.vnet.ibm.com>
 <20111205173057.GE627@google.com> <4EDD0254.10408@linux.vnet.ibm.com>
 <4EDD0D35.1020907@linux.vnet.ibm.com> <20111205183502.GA30482@redhat.com>
In-Reply-To: <20111205183502.GA30482@redhat.com>
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
To: Oleg Nesterov <oleg@redhat.com>
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz, Tejun Heo <tj@kernel.org>

Hi Oleg,

On 12/06/2011 12:05 AM, Oleg Nesterov wrote:

> On 12/05, Srivatsa S. Bhat wrote:
>>
>> I looked up in git and found that commit ba96a0c by Rafael introduced the
>> count functions, to handle the vfork case. But now, we seem to have more
>> uses than that. So I think we can remove that userspace restriction in the
>> count functions,
> 
> Agreed.
> 
>> and in kernel/fork.c, do something like:
>>
>> if (current->mm)
>> 	freezer_do_not_count();
>> ...
>> if (current->mm)
>> 	freezer_count();
> 
> see http://marc.info/?l=linux-kernel&m=132033335507261
> 
> I think this is not needed, we can just remove the ->mm check.
> CLONE_VFORK is not used by a freezable kthread.
> 


Great! Thanks for the pointer. I'll send a patch to remove that check.

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
