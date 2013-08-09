Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V7ogK-0000qZ-3r
 for kexec@lists.infradead.org; Fri, 09 Aug 2013 15:32:48 +0000
Date: Fri, 9 Aug 2013 11:32:26 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: Disable at runtime if the kernel enforces module
 signing
Message-ID: <20130809153225.GH12688@redhat.com>
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
> 
> > Also it would be nice if we introduce new features, then we make other
> > features work with those new features instead of disabling existing
> > features and leave it to other people to make them work.
> 
> Sure, it'd be nice if security features got introduced with
> consideration to other kernel features that allow them to be
> circumvented, but this approach seems better than making them
> incompatible at the Kconfig level.

So how would one go about making kexec work when module signature
enforcement is on?

I guess same solution which is required to make it work with secureboot.
Sign /sbin/kexec and let /sbin/kexec very signature of kernel. IOW, any
code which runs at priviliged level should be signature verified with
keys in system_keyring.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
