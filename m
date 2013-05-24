Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ufta4-0001HT-DW
 for kexec@lists.infradead.org; Fri, 24 May 2013 15:06:57 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 24 May 2013 16:01:58 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1503117D8025
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 16:07:41 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4OF6I8A52232262
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 15:06:18 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4OF6SrF012861
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 09:06:28 -0600
Date: Fri, 24 May 2013 17:06:26 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130524170626.2ac06efe@holzheu>
In-Reply-To: <20130524143644.GD18218@redhat.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Hello Vivek,

On Fri, 24 May 2013 10:36:44 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

[snip]

> Sorry, I don't understand the problem. If we swapped low memory and
> crash reserved memory, that should have been taken care by prepared
> ELF headers so that we map the right pfns. In x86 we swap 640K of low
> memory with 640K of memory in reserved and we take care of this by
> preparing elf headers accordingly.
> 
> So why s390 can't do the same thing?

I am not sure if I understand this. Currently we create the ELF
header in a way that we have virtual=real. In the copy_oldmem_page() we
do the swap so that for the /proc/vmcore code it looks like contiguous
non-swapped memory.

One reason why I thought this was necessary was that /dev/oldmem
also uses the function and it should provide linear memory access like
it is on the live system with /dev/mem.

Is that implementation incorrect?

Best Regards,
Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
