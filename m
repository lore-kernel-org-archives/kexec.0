Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24] helo=imx2.toshiba.co.jp)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JoT37-0004mp-Mb
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 00:41:26 +0000
From: "gib" <suchada.pitchayasamanya@toshiba.co.jp>
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
In-Reply-To: <480D790D.7080403@in.ibm.com>
Subject: RE: Question about forcing kernel panic on PowerMac G5 by kexec
	command
Date: Wed, 23 Apr 2008 09:41:17 +0900
Message-Id: <200804230041.m3N0fIQD013543@toshiba.co.jp>
MIME-Version: 1.0
Content-Language: ja
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Mohan Kumar M' <mohan@in.ibm.com>
Cc: kexec@lists.infradead.org

Hi Mohan,

Thank you very much for your reply.

> What kernel version you are trying? Also what level of kexec-tools you
use?
I've tried kernel 2.6.24 and 2.6.25 with the kexec-tools-testing 20080324,
the both of them gave me the same result.

> I hope you are aware that you need two different kernels for kdump, 
> first one is meant for normal use and another one is kdump kernel. Did 
> you compile the kdump kernel with CONFIG_CRASH_DUMP?

Yes, I built 2 kernels the first one as the system kernel and the second one
as the dump-capture kernel(with CONFIG_CRASH_DUMP).

Another notice is when I pre-loaded the dump-capture kernel(kexec -p
/boot/vmlinux...), I got
	Modified cmdline: elfcorehdr=41188K savemaxmem=0M ...
	segment[0].mem:0x2000000 memsz:8269624
	segment[1].mem:0x27e3000 memsz:65536
	segment[2].mem:0x27f3000 memsz:4096
	segment[3].mem:0x27f4000 memsz:36864
	segment[5].mem:0x9fbf000 memsz:266240

Why the savemaxmem=0M? since it should be some value else.
Do you have any idea about this?

Regards,
Suchada

-----Original Message-----
From: Mohan Kumar M [mailto:mohan@in.ibm.com] 
Sent: Tuesday, April 22, 2008 2:35 PM
To: gib
Cc: kexec@lists.infradead.org
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
command

gib wrote:
> Hello all,
> 
>  
> 
> I'm working on PowerMac G5 complied with CONFIG_KEXEC = y.
> 
> It's work fine with Kexec command option l ( kexec -l /boot/vmlinux. ) 
> but after the capture kernel pre-loading ( by kexec -p /boot/vmlinux. ),
> 
Hi Suchada,

What kernel version you are trying? Also what level of kexec-tools you use?

I hope you are aware that you need two different kernels for kdump, 
first one is meant for normal use and another one is kdump kernel. Did 
you compile the kdump kernel with CONFIG_CRASH_DUMP?

> when I forced kernel panic by "echo c > /proc/sysrq-trigger" the console 
> kept showing "Sending IPI to other CPU" and did not go to the next step.
> 
>  
> 
> According to this list there was some problem about kdump in ppc970 based
CPU which PowerMac's CPU are.

There was a interrupt routing problem with specific ppc970 cpu type, but 
that problem is fixed now.

Regards,
Mohan.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
