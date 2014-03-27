Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSz0M-0000YR-GN
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 01:21:15 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 5D1F83EE0B6
 for <kexec@lists.infradead.org>; Thu, 27 Mar 2014 10:20:45 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4B56F45DED0
 for <kexec@lists.infradead.org>; Thu, 27 Mar 2014 10:20:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 307A345DECD
 for <kexec@lists.infradead.org>; Thu, 27 Mar 2014 10:20:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 020171DB8037
 for <kexec@lists.infradead.org>; Thu, 27 Mar 2014 10:20:45 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C42F1DB8032
 for <kexec@lists.infradead.org>; Thu, 27 Mar 2014 10:20:44 +0900 (JST)
Date: Thu, 27 Mar 2014 02:20:32 +0100 (a/T)
Message-Id: <20140327.022032.54368351.d.hatayama@jp.fujitsu.com>
Subject: Re: [BUG] makedumpfile v1.5.5
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <5332B587.3030407@hp.com>
References: <5332B587.3030407@hp.com>
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
To: jingbai.ma@hp.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

From: Jingbai Ma <jingbai.ma@hp.com>
Subject: [BUG] makedumpfile v1.5.5
Date: Wed, 26 Mar 2014 19:09:59 +0800

> Hi Daisuke,
> 
> I found a problem with the latest makedumpfile v1.5.5.
> I have narrowed down the bug to your patch set:
> 
> 72d9d063 [PATCH v2 1/2] Use memset() to improve the 1st bitmap
> initialization performance.
> 
> 363d53fc [PATCH v2 2/2] Write out a whole part of the 1st bitmap
> before entering cyclic process.
> 
> After reversed this patch set out, this problem was gone.
> Could you check this problem?
> 
> I got a segmentation fault during dump kernel. I have copied the
> vmcore to my system to debug it.
> 
> makedumpfile -l --message-level 23 -d 31 -f /vmcores/vmcore /dev/null
> cyclic buffer size has been changed: 1060863 => 1060736
> Excluding unnecessary pages : [100.0 %] |STEP [Excluding unnecessary
> pages] : 0.280002 seconds
> Excluding unnecessary pages : [100.0 %] \STEP [Excluding unnecessary
> pages] : 0.000194 seconds
> Excluding unnecessary pages : [100.0 %] -STEP [Excluding unnecessary
> pages] : 0.276371 seconds
> Excluding unnecessary pages : [100.0 %] /STEP [Excluding unnecessary
> pages] : 0.000205 seconds
> Excluding unnecessary pages : [100.0 %] \STEP [Excluding unnecessary
> pages] : 0.279320 seconds
> Segmentation fault (core dumped)
> 
> gdb --args ./makedumpfile -l --message-level 23 -d 31 -f
> /vmcores/vmcore /dev/null
> 
> (gdb) run
> Starting program: /home/majingb/work/source/makedumpfile/makedumpfile
> -l --message-level 23 -d 31 -f /vmcores/vmcore /dev/null
> [Thread debugging using libthread_db enabled]
> cyclic buffer size has been changed: 1060863 => 1060736
> Excluding unnecessary pages : [100.0 %] |STEP [Excluding unnecessary
> pages] : 0.306783 seconds
> Excluding unnecessary pages : [100.0 %] \STEP [Excluding unnecessary
> pages] : 0.000197 seconds
> Excluding unnecessary pages : [100.0 %] /STEP [Excluding unnecessary
> pages] : 0.274979 seconds
> Excluding unnecessary pages : [100.0 %] |STEP [Excluding unnecessary
> pages] : 0.000177 seconds
> Excluding unnecessary pages : [100.0 %] \STEP [Excluding unnecessary
> pages] : 0.274816 seconds
> Copying data                       : [  7.0 %] -
> Program received signal SIGSEGV, Segmentation fault.
> __memset_sse2 () at ../sysdeps/x86_64/memset.S:65
> 65		movswq (%rcx,%r8,2),%rcx
> (gdb) bt
> #0  __memset_sse2 () at ../sysdeps/x86_64/memset.S:65
> #1 0x000000000042ea73 in readpage_elf (type_addr=1, addr=3881992192,
> #bufptr=0x7fffffffbc90, size=4096) at makedumpfile.c:402
> #2 readmem (type_addr=1, addr=3881992192, bufptr=0x7fffffffbc90,
> #size=4096) at makedumpfile.c:594
> #3 0x000000000042fe0f in read_pfn (pfn=<value optimized out>,
> #buf=<value optimized out>) at makedumpfile.c:5798
> #4 0x0000000000430089 in write_kdump_pages_cyclic
> #(cd_header=0x7fffffffde00, cd_page=0x7fffffffddd0,
> #pd_zero=0x7fffffffdd50, offset_data=0x7fffffffdd88) at
> #makedumpfile.c:6402
> #5 0x0000000000437073 in write_kdump_pages_and_bitmap_cyclic
> #(cd_header=0x7fffffffde00, cd_page=0x7fffffffddd0) at
> #makedumpfile.c:6880
> #6  0x000000000043827b in writeout_dumpfile () at makedumpfile.c:7835
> #7  0x00000000004386a5 in create_dumpfile () at makedumpfile.c:8038
> #8 0x000000000043944e in main (argc=<value optimized out>, argv=<value
> #optimized out>) at makedumpfile.c:9214
> 
> In makedumpfile line 402:
>                      memset(bufptr, 0, frac_head);
> I have printed out the value of frac_head:
> p	frac_head
> $2 = 18446744069827559424
> It seems something wrong here.
> 
> Here is the paddr in this context.
> (gdb) p	paddr
> $3 = 3881992192
> 
> I also have printed out the pt_loads for your reference:
> (gdb) p *pt_loads@num_pt_loads
> $3 = {{file_offset = 12288, phys_start = 16777216, phys_end =
> 33579008, virt_start = 18446744071578845184, virt_end =
> 18446744071595646976}, {file_offset = 16814080, phys_start = 65536,
> phys_end = 621568,
>     virt_start = 18446612132314284032, virt_end = 18446612132314840064},
>     {file_offset = 17371136, phys_start = 1048576, phys_end = 637534208,
>     virt_start = 18446612132315267072, virt_end = 18446612132951752704}, {
>     file_offset = 653856768, phys_start = 905969664, phys_end =
>     3881955328, virt_start = 18446612133220188160, virt_end =
>     18446612136196173824}, {file_offset = 3629842432, phys_start =
>     3882008576, phys_end = 3882012672,
>     virt_start = 18446612136196227072, virt_end = 18446612136196231168},
>     {file_offset = 3629846528, phys_start = 4294967296, phys_end =
>     34762387456, virt_start = 18446612136609185792, virt_end =
>     18446612167076605952}}
> 

Sorry. This was fixed by the following patch.

commit 4404368a0860e3b6c845eb41782e97a9bf7593b8
Author: WANG Chao <chaowang@redhat.com>
Date:   Wed Dec 18 22:34:43 2013 +0900

    [PATCH] memset() in cyclic bitmap initialization introduce segment fault.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
