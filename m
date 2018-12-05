Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUEy-0002Ht-FT
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 10:17:13 +0000
Date: Wed, 5 Dec 2018 18:16:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Message-ID: <20181205101653.GA6940@dhcp-128-65.nay.redhat.com>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com>
 <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, linux-doc@vger.kernel.org, bhe@redhat.com, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, akpm@linux-foundation.org

> >> +init_uts_ns
> >> +===========
> >> +This is the UTS namespace, which is used to isolate two specific elements
> >> +of the system that relate to the uname system call. The UTS namespace is
> >> +named after the data structure used to store information returned by the
> >> +uname system call.
> > 
> > Those non-obvious exports should also have a short explanation why
> > they're part of VMCOREINFO.
> > 
> >> +
> >> +node_online_map
> >> +===============
> >> +It is a macro definition, actually it is an arrary node_states[N_ONLINE],
> >> +and it represents the set of online node in a system, one bit position
> >> +per node number.
> > 
> > Ditto.
> > 
> > So yeah, people can find out what those things are but I think it is
> > more important to state here *why* they're part of VMCOREINFO and how
> > they're used and why they're exported.
> > 
> 
> This is a good question.
> 
> For these two *why*, it should be easy to understand. Because user-space tools
> need to know basic information, such as the symbol values, field offset, structure
> size, etc. Otherwise, these tools won't know how to analyze the memory of the crash
> kernel.
> 
> For the second question 'how they are used', we can get the answer from user-space
> tools, such as makedumpfile, crash tools. Therefore, it may not need to explain any
> more in kernel document. On the other hand, if we must put these contents into kernel
> document, i have to say, that would be a hard task.

It should be a good chance to learn how makedumpfile works :),  Maybe it is
hard to get *all* of them, but it would be good to dig and find the
thing you can find then explain it.  And leave those *unknown* part as
FIXME or TODO, people can add description later. 

Added Kazu in cc as well..

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
