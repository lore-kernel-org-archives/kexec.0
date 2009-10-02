Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MthsW-0002ig-MN
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 13:09:01 +0000
Date: Fri, 2 Oct 2009 09:08:54 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <125250177.1274091254488934453.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <95087251.1272891254488040278.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: CAI Qian <caiqian@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, nhorman@redhat.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp


----- "CAI Qian" <caiqian@redhat.com> wrote:

> From: CAI Qian <caiqian@redhat.com>
> Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
> Date: Fri, 02 Oct 2009 19:26:44 +0800 (CST)
> 
> > Cced the crash utility maintainer.
> > 
> > BZ filed -- https://bugzilla.redhat.com/show_bug.cgi?id=526749
> > 
> >> It does make -d 16 works without errors. However, the crash utility
> >> failed to read it (the log attached), but the full VMCore is working
> >> fine there.
> >> 
> >> crash: page excluded: kernel virtual address: ffffffff819f1764 type:
> >>        "tss_struct ist array"
> 
> Not sure if it is related, but kmem -z fails with the full VMCore.
> 
> crash> kmem -z
> 
> kmem: invalid (optional) structure member offsets: zone_pages_min or
>       zone_struct_pages_min FILE: memory.c
>       LINE: 12217 FUNCTION: dump_zone_stats()
> 
> [/usr/bin/crash] error trace: 44bb25 => 4701fc => 46efa6 => 4d4c57
> 
>   4d4c57: OFFSET_option+167
>   46efa6: (undetermined)
>   4701fc: cmd_kmem+3212
>   44bb25: exec_command+613
> 
> kmem: invalid (optional) structure member offsets: zone_pages_min or
>       zone_struct_pages_min
>       FILE: memory.c LINE: 12217 FUNCTION: dump_zone_stats()
> 
> > 
> > Thanks!
> > CAI Qian
> > 

I believe that the "tss_struct" issue is a crash bug if in fact it works
OK with a full vmcore.  I'll look at the vmlinux/vmcores from the BZ.

As far as the "kmem -z" issue, that's also a crash issue where the zone
struct in 2.6.31 kernels no longer contain pages_min, pages_low and
pages_high.

Thanks,
  Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
