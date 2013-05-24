Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uftvy-0001fw-7h
 for kexec@lists.infradead.org; Fri, 24 May 2013 15:29:35 +0000
Date: Fri, 24 May 2013 11:28:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130524152849.GF18218@redhat.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com>
 <20130524170626.2ac06efe@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130524170626.2ac06efe@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, May 24, 2013 at 05:06:26PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Fri, 24 May 2013 10:36:44 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> [snip]
> 
> > Sorry, I don't understand the problem. If we swapped low memory and
> > crash reserved memory, that should have been taken care by prepared
> > ELF headers so that we map the right pfns. In x86 we swap 640K of low
> > memory with 640K of memory in reserved and we take care of this by
> > preparing elf headers accordingly.
> > 
> > So why s390 can't do the same thing?
> 
> I am not sure if I understand this. Currently we create the ELF
> header in a way that we have virtual=real. In the copy_oldmem_page() we
> do the swap so that for the /proc/vmcore code it looks like contiguous
> non-swapped memory.
> 
> One reason why I thought this was necessary was that /dev/oldmem
> also uses the function and it should provide linear memory access like
> it is on the live system with /dev/mem.
> 
> Is that implementation incorrect?

[ CC Andrew. Keep him in loop for all kernel kdump patches as all kdump
  patches are routed through him ].

[ CC Eric Biederman ]

Looking at the code, looks like /dev/oldmem is broken. It does not know
anything about swap of any of the memory areas and it will simply
return the contents of page frame asked. And this has been like this
since the beginning.

I have always questioned the utility of /dev/oldmem. Atleast I am not
aware of any tool making use of it.

If we want to fix it, then somebow all the swapped memory region info
needs to be communicated to second kernel so that read_oldmem() can
do the mapping correctly and we really don't have any mechanism for
that. (I am assuming that in s390 you must have hardcoded the regions
of memory which are always swapped).

As /proc/vmcore is the most used and useful interface, I prefer that
we swap memory and put that info in elf headers. For /dev/oldme, I
don't mind if we leave it as it is. If somebody really cares, then
I guess we need to write a new command line option which /dev/mem
can parse and which tells it about swaps so that /dev/oldmem can
map things correctly. (This is better than hardcoding things).

Eric, do you have any thoughts on this.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
