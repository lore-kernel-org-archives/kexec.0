Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VhR0H-0000Ms-3P
 for kexec@lists.infradead.org; Fri, 15 Nov 2013 21:32:37 +0000
Date: Fri, 15 Nov 2013 22:30:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH] xen/kexec: Clear unused registers before jumping into an
 image
Message-ID: <20131115213054.GA3506@olila.local.net-space.pl>
References: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
 <52867EE6.7080205@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52867EE6.7080205@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: keir@xen.org, george.dunlap@eu.citrix.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, xen-devel@lists.xen.org, ebiederm@xmission.com, jbeulich@suse.com

On Fri, Nov 15, 2013 at 08:07:02PM +0000, David Vrabel wrote:
> On 15/11/13 15:56, Daniel Kiper wrote:
> > Clear unused registers before jumping into an image. This way
> > loaded image could not assume that any register has an specific
> > info about earlier running Xen hypervisor. However, it also
> > does not mean that the image may expect that a given register
> > is zeroed. The image MUST assume that every register has a random
> > value or in other words it is uninitialized or has undefined state.
>
> I think this, where the specification (registers undefined) differs from
> the implementation (registers zeroed), is the worst option.
>
> I also think it is more likely for an image to inadvertently rely on a
> zero value that whatever junk Xen has left behind.

I do not agree with you but respect your opinion. So could you provide
a patch with a comment why our implementation deviate from our reference
implementation (I think about Linux one) and even we use kexec-tools
designed for Linux implementation which does things mentioned above?
I hope that this solve this last, widely discussed issue.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
