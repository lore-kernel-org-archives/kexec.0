Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzZUc-0000nc-IM
 for kexec@lists.infradead.org; Wed, 17 Jul 2013 21:42:40 +0000
Date: Wed, 17 Jul 2013 17:42:07 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130717214207.GB27633@redhat.com>
References: <OF6010D9F0.5A45F2CF-ONC1257BAB.002B1F3E-C1257BAB.002B2812@de.ibm.com>
 <20130717180049.3b9c6ec8@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130717180049.3b9c6ec8@holzheu>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jul 17, 2013 at 06:00:49PM +0200, Michael Holzheu wrote:
> > On Tue, Jul 16, 2013 at 06:18:10PM +0200, Michael Holzheu wrote:
> > > Hello Andrew,
> > >
> > > Here a new kdump patch series that we have discussed with Vivek and
> > > Hatayama during the last months.
> > >
> > > Besides of the feature described below, this patch series also fixes a
> > > regression on s390 that was introduced with the mmap patches for
> > > /proc/vmcore (git commit 83086978c63afd7c73e1c).
> > >
> > > See also:
> > > http://lists.infradead.org/pipermail/kexec/2013-July/009287.html
> > >
> > > Is it somehow possible to integrate this patch series into 3.11?
> > 
> > Hi Andrew,
> > 
> > Now /proc/vmcore mmap() patches are in but looks like they will break
> > s390 kdump. mmap() patches use vmalloc() to allocate memory for elf
> > notes and then use read_from_oldmem() to copy notes data from old
> > memory to this newly allocated buffer. read_from_oldmem() in turn
> > uses arch dependent copy_from_oldmem() function.
> > 
> > Look like on s390, copy_from_oldmem() can not copy data to vmalloc()
> > space as they drop to real mode.
> > 
> > As allocating elf notes code is common both for mmap() and read() path,
> > it will break kdump on s390.
> > 
> > Michael has done some cleanups to cope with that but in the process
> > he has also stuffed in the support for zfcpdump and how to deal with
> > HSA region etc. (I am not very happy about it though now. s390 seems
> > to be having so may special case modes and swap logic etc that it
> > is becoming hard to keep track what they are doing. I wished s390
> > first did some cleanup w.r.t swap logic and deal with mmap() in pure
> > kdump mode and then worry about taking care of zfcpdump).
> > 
> > Is it possible to push this series in 3.11 now? I suspect it is late now.
> > Otherwise we might have to revert mmap() patches as in current form
> > they will break s390 kdump.
> > 
> > Michael, Hatayama, in case this series can't go in 3.11, do you have other
> > ideas where a small hack fix will allow kdump to work on s390 and we
> > don't have to revert the mmap() patches.
> 
> Sure, we can somehow change the copy_from_oldmem() function that it
> can copy to virtual memory. We have already discussed some options
> on how to do that. Not nice but probably doable.
> 
> And we could either disable mmap for s390 by removing mmap_vmcore()
> from the proc_vmcore_operations or push the also already discussed
> ELF header swap trick in 3.11.
> 
> But this is all additional effort now and would not be necessary if we
> integrate this patch series in 3.11.
> 
> Perhaps we should let Andrew decide here.

Hi Michael,

Given the fact that andrew too prefers a fix to get s390 working at this
stage can we modify s390 copy_from_oldmem() to be able to copy to 
vmalloc() memory area.

For mmap(), let us disable it on s390. And rest of the cleanups w.r.t
ELF header swap etc, let us now target that for 3.12.

Sounds reasonable?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
