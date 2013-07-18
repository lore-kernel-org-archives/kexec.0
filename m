Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzpFG-0003cL-4M
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 14:31:50 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 18 Jul 2013 15:26:25 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1EFCF1B0805F
 for <kexec@lists.infradead.org>; Thu, 18 Jul 2013 15:31:25 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6IEVDxl52363386
 for <kexec@lists.infradead.org>; Thu, 18 Jul 2013 14:31:13 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6IEVN46029113
 for <kexec@lists.infradead.org>; Thu, 18 Jul 2013 08:31:24 -0600
Date: Thu, 18 Jul 2013 16:31:21 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130718163121.0b7fdcba@holzheu>
In-Reply-To: <20130718132757.GA785@redhat.com>
References: <OF6010D9F0.5A45F2CF-ONC1257BAB.002B1F3E-C1257BAB.002B2812@de.ibm.com>
 <20130717180049.3b9c6ec8@holzheu>
 <20130717214207.GB27633@redhat.com>
 <20130718124004.098b85f4@holzheu> <20130718132757.GA785@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 18 Jul 2013 09:27:57 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Thu, Jul 18, 2013 at 12:40:04PM +0200, Michael Holzheu wrote:
> > On Wed, 17 Jul 2013 17:42:07 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > > On Wed, Jul 17, 2013 at 06:00:49PM +0200, Michael Holzheu wrote:
> > 
> > [snip]
> > 
> > > > But this is all additional effort now and would not be necessary if we
> > > > integrate this patch series in 3.11.
> > > > 
> > > > Perhaps we should let Andrew decide here.
> > > 
> > > Hi Michael,
> > > 
> > > Given the fact that andrew too prefers a fix to get s390 working at this
> > > stage can we modify s390 copy_from_oldmem() to be able to copy to 
> > > vmalloc() memory area.
> > > 
> > > For mmap(), let us disable it on s390. And rest of the cleanups w.r.t
> > > ELF header swap etc, let us now target that for 3.12.
> > > 
> > > Sounds reasonable?
> > 
> > Hi Vivek,
> > 
> > Ok this is not our preferred solution but we can't expect that life is
> > always easy ;-)
> > 
> > Our s390 kernel maintainer Martin Schwidefsky agreed to send the following
> > two patches upstream for 3.11:
> > 
> >  * s390/kdump: Disable mmap for s390
> >  * s390/kdump: Allow copy_oldmem_page() copy to virtual memory
> > 
> > @Andrew:
> > 
> > Would you then take the "ELF header in new memory" patch series for 3.12?
> 
> Hi Michael,
> 
> Once this patch series gets merged for 3.12, can we first do some cleanup
> of s390 code before we do further development there. Basically there is
> no reason that s390 kdump should be any different than x86. So all the
> logic of OLD base can go away. 

Hello Vivek,

You mean that we first integrate the agreed "ELF header in new memory"
patch series, then do the cleanup, and after that we discuss the further
development (storage keys)?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
