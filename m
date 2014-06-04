Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsBXG-0005aM-QV
 for kexec@lists.infradead.org; Wed, 04 Jun 2014 13:47:25 +0000
Date: Wed, 4 Jun 2014 09:46:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
Message-ID: <20140604134649.GB27557@redhat.com>
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com>
 <538E2FF8.8060707@linux.vnet.ibm.com>
 <1401833365.3247.36.camel@pasglop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401833365.3247.36.camel@pasglop>
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
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, ananth@in.ibm.com, matt@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com, ebiederm@xmission.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, linuxppc-dev@lists.ozlabs.org

On Wed, Jun 04, 2014 at 08:09:25AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2014-06-04 at 01:58 +0530, Srivatsa S. Bhat wrote:
> > Yep, that makes sense. But unfortunately I don't have enough insight into
> > why exactly powerpc has to online the CPUs before doing a kexec. I just
> > know from the commit log and the comment mentioned above (and from my own
> > experiments) that the CPUs will get stuck if they were offline. Perhaps
> > somebody more knowledgeable can explain this in detail and suggest a proper
> > long-term solution.
> > 
> > Matt, Ben, any thoughts on this?
> 
> The problem is with our "soft offline" which we do on some platforms. When we
> offline we don't actually send the CPUs back to firmware or anything like that.
> 
> We put them into a very low low power loop inside Linux.
> 
> The new kernel has no way to extract them from that loop. So we must re-"online"
> them before we kexec so they can be passed to the new kernel normally (or returned
> to firmware like we do on powernv).

Srivatsa,

Looks like your patch has been merged.

I don't like the following change in arch independent code.

/*
 * migrate_to_reboot_cpu() disables CPU hotplug assuming  that
 * no further code needs to use CPU hotplug (which is true in
 * the reboot case). However, the kexec path depends on  using
 * CPU hotplug again; so re-enable it here. 
 */
               cpu_hotplug_enable();

As it is very powerpc specific requirement, can you enable hotplug in powerpc
arch dependent code as a short term solution.

Ideally one needs to fix the requirement of online all cpus in powerpc
as a long term solution and then get rid of hotplug enable call.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
