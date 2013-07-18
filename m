Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzldR-00079J-29
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 10:40:34 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 18 Jul 2013 11:34:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 535A92190023
 for <kexec@lists.infradead.org>; Thu, 18 Jul 2013 11:44:09 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6IAduPw41681140
 for <kexec@lists.infradead.org>; Thu, 18 Jul 2013 10:39:56 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6IAe671032550
 for <kexec@lists.infradead.org>; Thu, 18 Jul 2013 04:40:07 -0600
Date: Thu, 18 Jul 2013 12:40:04 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130718124004.098b85f4@holzheu>
In-Reply-To: <20130717214207.GB27633@redhat.com>
References: <OF6010D9F0.5A45F2CF-ONC1257BAB.002B1F3E-C1257BAB.002B2812@de.ibm.com>
 <20130717180049.3b9c6ec8@holzheu>
 <20130717214207.GB27633@redhat.com>
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

On Wed, 17 Jul 2013 17:42:07 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:
> On Wed, Jul 17, 2013 at 06:00:49PM +0200, Michael Holzheu wrote:

[snip]

> > But this is all additional effort now and would not be necessary if we
> > integrate this patch series in 3.11.
> > 
> > Perhaps we should let Andrew decide here.
> 
> Hi Michael,
> 
> Given the fact that andrew too prefers a fix to get s390 working at this
> stage can we modify s390 copy_from_oldmem() to be able to copy to 
> vmalloc() memory area.
> 
> For mmap(), let us disable it on s390. And rest of the cleanups w.r.t
> ELF header swap etc, let us now target that for 3.12.
> 
> Sounds reasonable?

Hi Vivek,

Ok this is not our preferred solution but we can't expect that life is
always easy ;-)

Our s390 kernel maintainer Martin Schwidefsky agreed to send the following
two patches upstream for 3.11:

 * s390/kdump: Disable mmap for s390
 * s390/kdump: Allow copy_oldmem_page() copy to virtual memory

@Andrew:

Would you then take the "ELF header in new memory" patch series for 3.12?

Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
