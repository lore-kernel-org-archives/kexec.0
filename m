Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WrwuX-0002dk-6p
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 22:10:27 +0000
Message-ID: <1401833365.3247.36.camel@pasglop>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Jun 2014 08:09:25 +1000
In-Reply-To: <538E2FF8.8060707@linux.vnet.ibm.com>
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
Mime-Version: 1.0
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
Cc: ego@linux.vnet.ibm.com, ananth@in.ibm.com, matt@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com, ebiederm@xmission.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, 2014-06-04 at 01:58 +0530, Srivatsa S. Bhat wrote:
> Yep, that makes sense. But unfortunately I don't have enough insight into
> why exactly powerpc has to online the CPUs before doing a kexec. I just
> know from the commit log and the comment mentioned above (and from my own
> experiments) that the CPUs will get stuck if they were offline. Perhaps
> somebody more knowledgeable can explain this in detail and suggest a proper
> long-term solution.
> 
> Matt, Ben, any thoughts on this?

The problem is with our "soft offline" which we do on some platforms. When we
offline we don't actually send the CPUs back to firmware or anything like that.

We put them into a very low low power loop inside Linux.

The new kernel has no way to extract them from that loop. So we must re-"online"
them before we kexec so they can be passed to the new kernel normally (or returned
to firmware like we do on powernv).

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
