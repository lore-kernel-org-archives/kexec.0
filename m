Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbMW4-0000Ys-VT
 for kexec@lists.infradead.org; Fri, 06 Jul 2018 08:55:04 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w668nN6x021417
 for <kexec@lists.infradead.org>; Fri, 6 Jul 2018 04:54:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k23fs4d7x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 06 Jul 2018 04:54:44 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Fri, 6 Jul 2018 09:54:42 +0100
Date: Fri, 6 Jul 2018 10:54:29 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH 0/1] x86/purgatory: Fix Makefile bug
In-Reply-To: <20180706083029.GB32538@dhcp-128-65.nay.redhat.com>
References: <20180704110044.29279-1-prudo@linux.ibm.com>
 <20180705064620.GA24455@dhcp-128-65.nay.redhat.com>
 <20180705104332.0ba5c9ab@ThinkPad>
 <20180706083029.GB32538@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <20180706105429.07991cae@ThinkPad>
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
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>

Hi Andrew,

can you send this fix to Linus like the original patch?

Can you also tell me if the bug is severe enough to go to stable? For
productive systems the bug shouldn't cause any problem because they are usually
build from scratch. For developers however, it can cause quite a pain while
debugging.

@Dave: Thanks for looking into this.

Thanks
Philipp


On Fri, 6 Jul 2018 16:30:29 +0800
Dave Young <dyoung@redhat.com> wrote:

> Hi Philipp,
> 
> On 07/05/18 at 10:43am, Philipp Rudo wrote:
> > Hi Dave,
> > 
> > On Thu, 5 Jul 2018 14:46:20 +0800
> > Dave Young <dyoung@redhat.com> wrote:
> >   
> > > On 07/04/18 at 01:00pm, Philipp Rudo wrote:  
> > > > Hi everybody,
> > > > 
> > > > when i moved the purgatories sha256 implementation to common code, i forgot
> > > > to add FORCE to the new Makefile target. This patch fixes it.    
> > > 
> > > Hi Philipp,
> > > 
> > > Do you have the exact steps of how to reproduce your problem?  
> > 
> > I only tested it on s390, but on x86 it should work the same way.
> > 
> > - Build the kernel without the fix
> > - Add some flag to the purgatories KBUILD_CFLAGS,I used
> >   -fno-asynchronous-unwind-tables
> > - Re-build the kernel
> > 
> > When you look at make's output you see that sha256.o is not re-build in the
> > last step. Also readelf -S still shows the .eh_frame section for sha256.o.
> > 
> > With the fix sha256.o is re-build in the last step.
> > 
> > Hope that helps.  
> 
> Thanks for explanation.
> 
> For the patch:
> Acked-by: Dave Young <dyoung@redhat.com>
> 
> Thanks
> Dave
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
