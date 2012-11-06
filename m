Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TVa19-0004yB-5e
 for kexec@lists.infradead.org; Tue, 06 Nov 2012 03:40:01 +0000
Date: Tue, 6 Nov 2012 12:37:16 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Message-Id: <20121106123716.32db9f6881b26bc984db15c0@mxc.nes.nec.co.jp>
In-Reply-To: <1351163384.13097.116.camel@lisamlinux.fc.hp.com>
References: <1350912018.13097.54.camel@lisamlinux.fc.hp.com>
 <20121024164508.a2707a96b532a6766228bec5@mxc.nes.nec.co.jp>
 <1351163384.13097.116.camel@lisamlinux.fc.hp.com>
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
To: lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, jerry.hoemann@hp.com

Hello Lisa,

On Thu, 25 Oct 2012 05:09:44 -0600
Lisa Mitchell <lisa.mitchell@hp.com> wrote:

> Thanks, Atsushi!  
> 
> I tried the dump on the 4 TB system with --cyclic-buffer 131072, and the
> dump completed overnight, and I collected a complete vmcore for dump
> level 31.  It looks like from the console log the system "cycled" twice
> with this setting, two passes of excluding and copying, before the dump
> was completed. I am in the process of making a more precise timing
> measurement of the dump time today.  Looks like each cycle takes about 1
> hour for this system, with the majority of this time spent in "Excluding
> unnecessary pages" phase of each cycle.  

Sorry for my lack of description, the excluding phase will be run twice at
a cycle. So in your case, the number of cycle is 1.

> However if I understand what you are doing with the cyclic-buffer
> parameter, it seems we are taking up 128 MB  of the crash kernel memory
> space for this buffer, and it may have to scale larger to get decent
> performance on larger memory. 
> 
> Is that conclusion correct?

Yes, but to increase cyclic-buffer is just workaround for v1.5.0.
(Additionally, the enhancement of v1.5.1 is just automation of this.)

I think that the dump time should be constant regardless of the buffer size
ideally, because the purpose of cyclic process is to work on constant
memory, so to increase cyclic-buffer is putting the cart before the horse.

> I was only successful with the new makedumpfile with cyclic-buffer set
> to 128 MB when I set crashkernel=384 MB, but ran out of memory trying to
> start dump  (Out of memory killer killed makedumpfile) when
> crashkernel=256 MB, on this system. 
> 
> Will we be able to dump larger memory systems, up to 12 TB for instance,
> with any kind of reasonable performance, with a crashkernel size limited
> to 384 MB, as I understand all current upstream kernels are now?  

I think v1.5.2 can do it because the most of overhead of cyclic process 
will be removed with the optimization of the logic of excluding free pages
in v1.5.2. I expect v1.5.2 to work in constant time regardless of the
number of cycle.

> If the ratio of memory size to total bitmap space is assumed linear,
> this would predict a 12 TB system would take about 6 cycles to dump. And
> larger memory will need even more cycles, etc. I can see where
> performance improvements in getting through each cycle will make this
> better, so more cycles will not mean that much increase in dump time
> over the copy time, but I am concerned for crashkernel size being able
> to stay at 384MB, and still be able to accommodate a large enough
> cyclic-buffer size to maintain a reasonable dump time on future large
> memory systems.  
> 
> What other things on a large system will effect usable crashkernel size,
> that will make it insufficient to support a 128 MB cyclic-buffer size? 
> 
> Or will the cycle performance fixes proposed for the future makedumpfile
> versions improve things enough that performance penalties for having a
> large number of cycles to dump will be small enough not to matter?

I hope so, but some overhead of cyclic process may be unavoidable and 
I can't assume how much time will be spent in them now.
So we need to see the measurement of v1.5.2.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
