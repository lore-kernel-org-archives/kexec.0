Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bl2lp0204.outbound.protection.outlook.com
 ([207.46.163.204] helo=na01-bl2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V7oXa-0000Yd-DF
 for kexec@lists.infradead.org; Fri, 09 Aug 2013 15:23:47 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH] kexec: Disable at runtime if the kernel enforces module
 signing
Date: Fri, 9 Aug 2013 15:07:13 +0000
Message-ID: <1376060830.2021.12.camel@x230>
References: <1376033797-24970-1-git-send-email-matthew.garrett@nebula.com>
 <20130809110200.GA9631@redhat.com>
In-Reply-To: <20130809110200.GA9631@redhat.com>
Content-Language: en-US
Content-ID: <8568498441B3B64CA6F2BCDCB2F07B15@namprd05.prod.outlook.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2013-08-09 at 07:02 -0400, Vivek Goyal wrote:
> On Fri, Aug 09, 2013 at 03:36:37AM -0400, Matthew Garrett wrote:
> > kexec permits the loading and execution of arbitrary code in ring 0, which
> > is something that module signing enforcement is meant to prevent. It makes
> > sense to disable kexec in this situation.
> > 
> 
> But in the process we wipe out running kernel's context and boot into a new
> kernel. So how different it is than root booting a new kernel through BIOS
> which does not enforce module signing.

What wipes the current kernel's context? KEXEC_JUMP is explicitly
designed to allow you to hop back and forth, but even without it you
should be able to reconstruct the original context. And there's no need
to boot a new kernel, either. All the attacker needs is the physical
address of the sig_enforce boolean, and then they launch a simple kexec
payload that simply flips that back and returns to the original kernel -
it's not like kexec limits you to booting Linux.

> Also it would be nice if we introduce new features, then we make other
> features work with those new features instead of disabling existing
> features and leave it to other people to make them work.

Sure, it'd be nice if security features got introduced with
consideration to other kernel features that allow them to be
circumvented, but this approach seems better than making them
incompatible at the Kconfig level.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
