Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V04Wf-0007DB-TL
 for kexec@lists.infradead.org; Fri, 19 Jul 2013 06:50:50 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <schwidefsky@de.ibm.com>;
 Fri, 19 Jul 2013 07:42:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7DAD617D805A
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 07:52:01 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6J6oB6864749748
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 06:50:11 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6J6oMtK023801
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 00:50:22 -0600
Date: Fri, 19 Jul 2013 08:50:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130719085020.28daef68@mschwide>
In-Reply-To: <20130718133541.GB785@redhat.com>
References: <OF6010D9F0.5A45F2CF-ONC1257BAB.002B1F3E-C1257BAB.002B2812@de.ibm.com>
 <20130717180049.3b9c6ec8@holzheu>
 <20130717214207.GB27633@redhat.com>
 <20130718124004.098b85f4@holzheu>
 <20130718124754.7453756e@mschwide>
 <20130718133541.GB785@redhat.com>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Thu, 18 Jul 2013 09:35:41 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Thu, Jul 18, 2013 at 12:47:54PM +0200, Martin Schwidefsky wrote:
> > On Thu, 18 Jul 2013 12:40:04 +0200
> > Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> > 
> > > On Wed, 17 Jul 2013 17:42:07 -0400
> > > Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > On Wed, Jul 17, 2013 at 06:00:49PM +0200, Michael Holzheu wrote:
> > > 
> > > [snip]
> > > 
> > > > > But this is all additional effort now and would not be necessary if we
> > > > > integrate this patch series in 3.11.
> > > > > 
> > > > > Perhaps we should let Andrew decide here.
> > > > 
> > > > Hi Michael,
> > > > 
> > > > Given the fact that andrew too prefers a fix to get s390 working at this
> > > > stage can we modify s390 copy_from_oldmem() to be able to copy to 
> > > > vmalloc() memory area.
> > > > 
> > > > For mmap(), let us disable it on s390. And rest of the cleanups w.r.t
> > > > ELF header swap etc, let us now target that for 3.12.
> > > > 
> > > > Sounds reasonable?
> > > 
> > > Hi Vivek,
> > > 
> > > Ok this is not our preferred solution but we can't expect that life is
> > > always easy ;-)
> > > 
> > > Our s390 kernel maintainer Martin Schwidefsky agreed to send the following
> > > two patches upstream for 3.11:
> > > 
> > >  * s390/kdump: Disable mmap for s390
> > >  * s390/kdump: Allow copy_oldmem_page() copy to virtual memory
> > 
> > Patches have been added to 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> > 
> > They will go upstream with my next pull request.
> > 
> 
> If everything related to crash dump is going through Andrew, wouldn't
> it make sense that even these fixes go through him?
> 
> https://git.kernel.org/cgit/linux/kernel/git/s390/linux.git/commit/?h=features&id=5a74953ff56aa870d6913ef4d81934f5c620c59d
> 
> https://git.kernel.org/cgit/linux/kernel/git/s390/linux.git/commit/?h=features&id=191a2fa0a8d2bbb64c98f9b1976fcb37ee5eae6b

Most of the architecture specific kdump patches for s390 have gone through me,
and these two fall into that category. If you insist we can route them over
Andrew, it just seems easier to me via the s390 tree.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
