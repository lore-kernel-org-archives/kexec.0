Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fazrl-0007HZ-Us
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 08:43:59 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w658e6wO125734
 for <kexec@lists.infradead.org>; Thu, 5 Jul 2018 04:43:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k1en0uaxr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 05 Jul 2018 04:43:40 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Thu, 5 Jul 2018 09:43:38 +0100
Date: Thu, 5 Jul 2018 10:43:32 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH 0/1] x86/purgatory: Fix Makefile bug
In-Reply-To: <20180705064620.GA24455@dhcp-128-65.nay.redhat.com>
References: <20180704110044.29279-1-prudo@linux.ibm.com>
 <20180705064620.GA24455@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <20180705104332.0ba5c9ab@ThinkPad>
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

Hi Dave,

On Thu, 5 Jul 2018 14:46:20 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 07/04/18 at 01:00pm, Philipp Rudo wrote:
> > Hi everybody,
> > 
> > when i moved the purgatories sha256 implementation to common code, i forgot
> > to add FORCE to the new Makefile target. This patch fixes it.  
> 
> Hi Philipp,
> 
> Do you have the exact steps of how to reproduce your problem?

I only tested it on s390, but on x86 it should work the same way.

- Build the kernel without the fix
- Add some flag to the purgatories KBUILD_CFLAGS,I used
  -fno-asynchronous-unwind-tables
- Re-build the kernel

When you look at make's output you see that sha256.o is not re-build in the
last step. Also readelf -S still shows the .eh_frame section for sha256.o.

With the fix sha256.o is re-build in the last step.

Hope that helps.

Thanks
Philipp

> > 
> > Note: There is an equivalent bug in the s390 purgatory. The fix for that
> > will go upstream via Martin.
> > 
> > Thanks
> > Philipp
> > 
> > Philipp Rudo (1):
> >   x86/purgatory: Add missing FORCE to Makefile target
> > 
> >  arch/x86/purgatory/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > -- 
> > 2.16.4
> >   
> 
> Thanks
> Dave
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
