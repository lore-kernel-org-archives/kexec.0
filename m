Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V7oj7-0000xp-9Q
 for kexec@lists.infradead.org; Fri, 09 Aug 2013 15:35:42 +0000
Date: Fri, 9 Aug 2013 11:35:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: Disable at runtime if the kernel enforces module
 signing
Message-ID: <20130809153519.GI12688@redhat.com>
References: <1376033797-24970-1-git-send-email-matthew.garrett@nebula.com>
 <20130809110200.GA9631@redhat.com> <1376060830.2021.12.camel@x230>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376060830.2021.12.camel@x230>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Aug 09, 2013 at 03:07:13PM +0000, Matthew Garrett wrote:
> On Fri, 2013-08-09 at 07:02 -0400, Vivek Goyal wrote:
> > On Fri, Aug 09, 2013 at 03:36:37AM -0400, Matthew Garrett wrote:
> > > kexec permits the loading and execution of arbitrary code in ring 0, which
> > > is something that module signing enforcement is meant to prevent. It makes
> > > sense to disable kexec in this situation.
> > > 
> > 
> > But in the process we wipe out running kernel's context and boot into a new
> > kernel. So how different it is than root booting a new kernel through BIOS
> > which does not enforce module signing.
> 
> What wipes the current kernel's context? KEXEC_JUMP is explicitly
> designed to allow you to hop back and forth, but even without it you
> should be able to reconstruct the original context. And there's no need
> to boot a new kernel, either. All the attacker needs is the physical
> address of the sig_enforce boolean, and then they launch a simple kexec
> payload that simply flips that back and returns to the original kernel -
> it's not like kexec limits you to booting Linux.

Also what about all the other patches you had for secureboot where you
closed down all the paths where root could write to kernel memory. So
if you want to protect sig_enforce boolean, then you need to close down
all these paths irrespective of secureboot?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
