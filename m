Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbM8g-0006xo-27
 for kexec@lists.infradead.org; Fri, 06 Jul 2018 08:30:51 +0000
Date: Fri, 6 Jul 2018 16:30:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/1] x86/purgatory: Fix Makefile bug
Message-ID: <20180706083029.GB32538@dhcp-128-65.nay.redhat.com>
References: <20180704110044.29279-1-prudo@linux.ibm.com>
 <20180705064620.GA24455@dhcp-128-65.nay.redhat.com>
 <20180705104332.0ba5c9ab@ThinkPad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180705104332.0ba5c9ab@ThinkPad>
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
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>

Hi Philipp,

On 07/05/18 at 10:43am, Philipp Rudo wrote:
> Hi Dave,
> 
> On Thu, 5 Jul 2018 14:46:20 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > On 07/04/18 at 01:00pm, Philipp Rudo wrote:
> > > Hi everybody,
> > > 
> > > when i moved the purgatories sha256 implementation to common code, i forgot
> > > to add FORCE to the new Makefile target. This patch fixes it.  
> > 
> > Hi Philipp,
> > 
> > Do you have the exact steps of how to reproduce your problem?
> 
> I only tested it on s390, but on x86 it should work the same way.
> 
> - Build the kernel without the fix
> - Add some flag to the purgatories KBUILD_CFLAGS,I used
>   -fno-asynchronous-unwind-tables
> - Re-build the kernel
> 
> When you look at make's output you see that sha256.o is not re-build in the
> last step. Also readelf -S still shows the .eh_frame section for sha256.o.
> 
> With the fix sha256.o is re-build in the last step.
> 
> Hope that helps.

Thanks for explanation.

For the patch:
Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
