Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RPwl9-0001qI-9W
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 13:39:40 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1RPwl2-0007K0-G8
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 14:39:32 +0100
Received: from 180.129.196.69 ([180.129.196.69])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2011 14:39:32 +0100
Received: from xiyou.wangcong by 180.129.196.69 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2011 14:39:32 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: Crash during vmcore_init
Date: Mon, 14 Nov 2011 13:39:17 +0000 (UTC)
Message-ID: <j9r5m5$b18$1@dough.gmane.org>
References: <1318376345.2050.20.camel@boudreau>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Tue, 11 Oct 2011 16:39:05 -0700, Tim Hartrick wrote:

> Kexec,
> 
> I have been experiencing the crash below on Ubuntu 10.04 running
> 2.6.32-34-server and 2.6.38-8-server as the crashkernel on X86_64. The
> tools are:
> 
> kexec-tools	1:2.0.2-1ubuntu3
> makedumpfile	1.3.7-2
> kdump-tools	1.3.7-2
> 
> I would be interested to know if this is a known problem and if so
> whether or not there is a patch in the pipeline to correct the problem.
> 
> I will be happy to provide any other details that are required including
> debug builds if necessary.
....
> 
> [    1.322100] ioremap: invalid physical address db74000000000000 [   
> 1.327919] ------------[ cut here ]------------ [    1.332530] WARNING:
> at /build/buildd/linux-2.6.32/arch/x86/mm/ioremap.c:120 __ioremap_caller
> +0x360/0x3d0()

This probably means that kexec-tools passed some incorrect
kernel parameter to the second kernel.

So, what is the cmdline of your second kernel? And what is your
/proc/iomem of your first kernel?

Cheers.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
