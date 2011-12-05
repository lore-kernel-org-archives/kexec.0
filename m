Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RXdpO-0007l0-EM
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 19:03:52 +0000
Date: Mon, 5 Dec 2011 19:35:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
Message-ID: <20111205183502.GA30482@redhat.com>
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111205171443.GB627@google.com> <4EDCFE9F.9050605@linux.vnet.ibm.com>
 <20111205173057.GE627@google.com> <4EDD0254.10408@linux.vnet.ibm.com>
 <4EDD0D35.1020907@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EDD0D35.1020907@linux.vnet.ibm.com>
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
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz, Tejun Heo <tj@kernel.org>

On 12/05, Srivatsa S. Bhat wrote:
>
> I looked up in git and found that commit ba96a0c by Rafael introduced the
> count functions, to handle the vfork case. But now, we seem to have more
> uses than that. So I think we can remove that userspace restriction in the
> count functions,

Agreed.

> and in kernel/fork.c, do something like:
>
> if (current->mm)
> 	freezer_do_not_count();
> ...
> if (current->mm)
> 	freezer_count();

see http://marc.info/?l=linux-kernel&m=132033335507261

I think this is not needed, we can just remove the ->mm check.
CLONE_VFORK is not used by a freezable kthread.

Oleg.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
