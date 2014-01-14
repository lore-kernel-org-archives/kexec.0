Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W32Gu-0000zq-QK
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 11:35:06 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A445B3EE0AE
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:34:39 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 932CC45DE52
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:34:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7838745DE4D
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:34:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 691F31DB803B
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:34:39 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0A7DF1DB8037
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:34:39 +0900 (JST)
Message-ID: <52D52094.3050301@jp.fujitsu.com>
Date: Tue, 14 Jan 2014 20:33:40 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] makedumpfile: for large memories
References: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
In-Reply-To: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
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
To: cpw <cpw@sgi.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

(2014/01/01 8:30), cpw wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> Gentlemen of kexec,
> 
> I have been working on enabling kdump on some very large systems, and
> have found some solutions that I hope you will consider.
> 
> The first issue is to work within the restricted size of crashkernel memory
> under 2.6.32-based kernels, such as sles11 and rhel6.
> 
> The second issue is to reduce the very large size of a dump of a big memory
> system, even on an idle system.
> 
> These are my propositions:
> 
> Size of crashkernel memory
>    1) raw i/o for writing the dump
>    2) use root device for the bitmap file (not tmpfs)
>    3) raw i/o for reading/writing the bitmaps
>    
> Size of dump (and hence the duration of dumping)
>    4) exclude page structures for unused pages
> 
> 
> 1) Is quite easy.  The cache of pages needs to be aligned on a block
>    boundary and written in block multiples, as required by O_DIRECT files.
> 
>    The use of raw i/o prevents the growing of the crash kernel's page
>    cache.
> 
> 2) Is also quite easy.  My patch finds the path to the crash
>    kernel's root device by examining the dump pathname. Storing the bitmaps
>    to a file is otherwise not conserving memory, as they are being written
>    to tmpfs.
> 
> 3) Raw i/o for the bitmaps, is accomplished by caching the
>    bitmap file in a similar way to that of the dump file.
> 
>    I find that the use of direct i/o is not significantly slower than
>    writing through the kernel's page cache.
> 
> 4) The excluding of unused kernel page structures is very
>    important for a large memory system.  The kernel otherwise includes
>    3.67 million pages of page structures per TB of memory. By contrast
>    the rest of the kernel is only about 1 million pages.
> 
> Test results are below, for systems of 1TB, 2TB, 8.8TB and 16TB.
> (There are no 'old' numbers for 16TB as time and space requirements
>   made those effectively useless.)
> 
> Run times were generally reduced 2-3x, and dump size reduced about 8x.
> 
> All timings were done using 512M of crashkernel memory.
> 
>     System memory size
>     1TB                     unpatched    patched
>       OS: rhel6.4 (does a free pages pass)
>       page scan time           1.6min    1.6min
>       dump copy time           2.4min     .4min
>       total time               4.1min    2.0min
>       dump size                 3014M      364M
> 
>       OS: rhel6.5
>       page scan time            .6min     .6min
>       dump copy time           2.3min     .5min
>       total time               2.9min    1.1min
>       dump size                 3011M      423M
> 
>       OS: sles11sp3 (3.0.93)
>       page scan time            .5min     .5min
>       dump copy time           2.3min     .5min
>       total time               2.8min    1.0min
>       dump size                 2950M      350M
> 
>     2TB
>       OS: rhel6.5           (cyclicx3)
>       page scan time           2.0min    1.8min
>       dump copy time           8.0min    1.5min
>       total time              10.0min    3.3min
>       dump size                 6141M      835M
> 
>     8.8TB
>       OS: rhel6.5           (cyclicx5)
>       page scan time           6.6min    5.5min
>       dump copy time          67.8min    6.2min
>       total time              74.4min   11.7min
>       dump size                 15.8G      2.7G
> 
>     16TB
>       OS: rhel6.4
>       page scan time                   125.3min
>       dump copy time                    13.2min
>       total time                       138.5min
>       dump size                            4.0G
> 
>       OS: rhel6.5
>       page scan time                    27.8min
>       dump copy time                    13.3min
>       total time                        41.1min
>       dump size                            4.1G
> 

Also, could you please show us results in more detail?
That is, this benchmark is relevant to 3 parameters below

- cyclic mode or non-cyclic mode
- cached I/O or direct I/O
- with or without page structure object array

Please describe results of each parameter separately, and we can easily
understand how each parameter affects without confusion.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
