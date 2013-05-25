Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgEID-0000W1-PM
 for kexec@lists.infradead.org; Sat, 25 May 2013 13:13:54 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Sat, 25 May 2013 14:09:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id EB53A17D8025
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 14:14:40 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4PDDI3d52822066
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 13:13:18 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4PDDRTa001038
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 07:13:28 -0600
Date: Sat, 25 May 2013 15:13:24 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130525151324.637d6b70@holzheu>
In-Reply-To: <20130524170507.GG18218@redhat.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com>
 <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com>
 <20130524184653.52d75b5f@holzheu>
 <20130524170507.GG18218@redhat.com>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric
 W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 24 May 2013 13:05:07 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, May 24, 2013 at 06:46:53PM +0200, Michael Holzheu wrote:
> > On Fri, 24 May 2013 11:28:49 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Fri, May 24, 2013 at 05:06:26PM +0200, Michael Holzheu wrote:
> > 
> > [snip] 
> > 
> > > As /proc/vmcore is the most used and useful interface, I prefer
> > > that we swap memory and put that info in elf headers.
> > > For /dev/oldme, I don't mind if we leave it as it is. If somebody
> > > really cares, then I guess we need to write a new command line
> > > option which /dev/mem can parse and which tells it about swaps so
> > > that /dev/oldmem can map things correctly. (This is better than
> > > hardcoding things).
> > 
> > Besides of the potential /dev/oldmem issue, I still do not
> > understand the option of doing the swap in the elf header. Looks
> > like I missed here a fundamental design point of kdump :(
> > 
> > Is that done by specifying different virtual and physical addresses
> > in the ELF header?
> 
> Nope. We keep the virtual to physical address mapping same. We just
> modify the p_offset in PT_LOAD elf header to represent where actually
> the memory is present physically. And when /proc/vmcore reads the
> data, it reads it from p_offset.
> 
> IOW, p_offset and p_paddr will be different for swapped memory but 
> should be same for memory which has not been swapped.

Hello Vivek,

Ok, now I got it :)

It worked for me by specifying a PT_LOAD with:

  phdr->p_offset = OLDMEM_BASE;
  phdr->p_vaddr = phdr->p_paddr = 0;
  phdr->p_filesz = phdr->p_memsz = OLDMEM_SIZE;

Best Regards,
Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
