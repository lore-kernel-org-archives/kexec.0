Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz8zZ-0003Dc-L7
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 17:24:50 +0000
Date: Tue, 16 Jul 2013 13:24:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130716172421.GA7982@redhat.com>
References: <1373991495-47411-1-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373991495-47411-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, Jul 16, 2013 at 06:18:10PM +0200, Michael Holzheu wrote:
> Hello Andrew,
> 
> Here a new kdump patch series that we have discussed with Vivek and
> Hatayama during the last months.
> 
> Besides of the feature described below, this patch series also fixes a
> regression on s390 that was introduced with the mmap patches for
> /proc/vmcore (git commit 83086978c63afd7c73e1c).
> 
> See also:
> http://lists.infradead.org/pipermail/kexec/2013-July/009287.html
> 
> Is it somehow possible to integrate this patch series into 3.11?

Hi Andrew,

Now /proc/vmcore mmap() patches are in but looks like they will break
s390 kdump. mmap() patches use vmalloc() to allocate memory for elf
notes and then use read_from_oldmem() to copy notes data from old
memory to this newly allocated buffer. read_from_oldmem() in turn
uses arch dependent copy_from_oldmem() function.

Look like on s390, copy_from_oldmem() can not copy data to vmalloc()
space as they drop to real mode.

As allocating elf notes code is common both for mmap() and read() path,
it will break kdump on s390.

Michael has done some cleanups to cope with that but in the process
he has also stuffed in the support for zfcpdump and how to deal with
HSA region etc. (I am not very happy about it though now. s390 seems
to be having so may special case modes and swap logic etc that it
is becoming hard to keep track what they are doing. I wished s390
first did some cleanup w.r.t swap logic and deal with mmap() in pure
kdump mode and then worry about taking care of zfcpdump).

Is it possible to push this series in 3.11 now? I suspect it is late now.
Otherwise we might have to revert mmap() patches as in current form
they will break s390 kdump.

Michael, Hatayama, in case this series can't go in 3.11, do you have other
ideas where a small hack fix will allow kdump to work on s390 and we
don't have to revert the mmap() patches.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
