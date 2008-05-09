Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JuJsH-0002tK-EZ
	for kexec@lists.infradead.org; Fri, 09 May 2008 04:06:26 +0000
From: "gib" <suchada.pitchayasamanya@toshiba.co.jp>
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
	<200804230041.m3N0fIQD013543@toshiba.co.jp>
	<480F05D7.1060402@in.ibm.com>
In-Reply-To: <480F05D7.1060402@in.ibm.com>
Subject: RE: Question about forcing kernel panic on PowerMac G5 by kexec
	command
Date: Fri, 9 May 2008 13:06:14 +0900
Message-Id: <200805090406.m4946FxB003919@toshiba.co.jp>
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

Sorry for the late reply.

> I am not sure about the latest kexec tools. Is it possible to test with 
> the kexec-tools shipped with the distro?

I tried to test with the kexec-tools shipped with the distro before and it
gave me the same result as the latest kexec-tools (kexec-tools-testing
20080324).

> Can you give us the contents of the reg property in the last memory node 
> in device tree?

With the command # hexdump /proc/device-tree/memory@0,0/reg I got
0000000 0000 0000 0000 0000 2000 0000 0000 0000
0000010 0000 0000 0000 0000 0000 0000 2000 0000
0000020 2000 0000 0000 0000 4000 0000 2000 0000
0000030 0000 0000 0000 0000 0000 0000 0000 0000
*
0000060

Is it because of this problem that cause the system did not go the next step
and kept showing "Sending IPI to other CPU" message?

Thanks for your help,
Suchada

-----Original Message-----
From: Mohan Kumar M [mailto:mohan@in.ibm.com] 
Sent: Wednesday, April 23, 2008 6:48 PM
To: gib; kexec@lists.infradead.org
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
command

gib wrote:
> Hi Mohan,
> 
> Thank you very much for your reply.
> 
>> What kernel version you are trying? Also what level of kexec-tools you
> use?
> I've tried kernel 2.6.24 and 2.6.25 with the kexec-tools-testing 20080324,
> the both of them gave me the same result.
> 

Hi Gib,

I am not sure about the latest kexec tools. Is it possible to test with 
the kexec-tools shipped with the distro?

>> I hope you are aware that you need two different kernels for kdump, 
>> first one is meant for normal use and another one is kdump kernel. Did 
>> you compile the kdump kernel with CONFIG_CRASH_DUMP?
> 
> Yes, I built 2 kernels the first one as the system kernel and the second
one
> as the dump-capture kernel(with CONFIG_CRASH_DUMP).
> 
> Another notice is when I pre-loaded the dump-capture kernel(kexec -p
> /boot/vmlinux...), I got
> 	Modified cmdline: elfcorehdr=41188K savemaxmem=0M ...
> 	segment[0].mem:0x2000000 memsz:8269624
> 	segment[1].mem:0x27e3000 memsz:65536
> 	segment[2].mem:0x27f3000 memsz:4096
> 	segment[3].mem:0x27f4000 memsz:36864
> 	segment[5].mem:0x9fbf000 memsz:266240
> 
> Why the savemaxmem=0M? since it should be some value else.
> Do you have any idea about this?

savemaxmem should give current memory.

Can you give us the contents of the reg property in the last memory node 
in device tree?

For eg, in my POWER5 system,

# hexdump /proc/device-tree/memory@d8000000/reg
0000000 0000 0000 d800 0000 0000 0000 0200 0000
0000010

Regards,
Mohan.

> -----Original Message-----
> From: Mohan Kumar M [mailto:mohan@in.ibm.com] 
> Sent: Tuesday, April 22, 2008 2:35 PM
> To: gib
> Cc: kexec@lists.infradead.org
> Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
> command
> 
> gib wrote:
>> Hello all,
>>
>>  
>>
>> I'm working on PowerMac G5 complied with CONFIG_KEXEC = y.
>>
>> It's work fine with Kexec command option l ( kexec -l /boot/vmlinux. ) 
>> but after the capture kernel pre-loading ( by kexec -p /boot/vmlinux. ),
>>
> Hi Suchada,
> 
> What kernel version you are trying? Also what level of kexec-tools you
use?
> 
> I hope you are aware that you need two different kernels for kdump, 
> first one is meant for normal use and another one is kdump kernel. Did 
> you compile the kdump kernel with CONFIG_CRASH_DUMP?
> 
>> when I forced kernel panic by "echo c > /proc/sysrq-trigger" the console 
>> kept showing "Sending IPI to other CPU" and did not go to the next step.
>>
>>  
>>
>> According to this list there was some problem about kdump in ppc970 based
> CPU which PowerMac's CPU are.
> 
> There was a interrupt routing problem with specific ppc970 cpu type, but
> that problem is fixed now.
> 
> Regards,
> Mohan.
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
