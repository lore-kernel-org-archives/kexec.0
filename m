Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcNw-0000Az-2Z
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:31:24 +0000
Received: by ggki1 with SMTP id i1so6438897ggk.36
 for <kexec@lists.infradead.org>; Mon, 05 Dec 2011 09:31:22 -0800 (PST)
Date: Mon, 5 Dec 2011 09:30:57 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] PM / Sleep: Make [un]lock_system_sleep() generic
Message-ID: <20111205173057.GE627@google.com>
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111205171443.GB627@google.com>
 <4EDCFE9F.9050605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EDCFE9F.9050605@linux.vnet.ibm.com>
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
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rjw@sisk.pl, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz

(cc'ing Oleg)

On Mon, Dec 05, 2011 at 10:55:51PM +0530, Srivatsa S. Bhat wrote:
> I wanted these APIs to be generic, not restricted to work only for userspace
> processes. Both freezer_do_not_count() and freezer_count() are effective only
> when current->mm is non-NULL (ie., only for userspace ones).
> I think I have documented this in the patch which added these things to the
> 2 APIs. See commit 6a76b7a in linux-pm/linux-next.

I see.  Oleg was curious about the ->mm condition too and IIRC there's
no reason for that restriction.  Maybe removing that in another patch
and using the count functions is better?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
