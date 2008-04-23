Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JobaV-00089m-21
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 09:48:27 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3N9mQQY027769
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2008 05:48:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3N9mQeV242794
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2008 05:48:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3N9mGSn012251
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2008 05:48:16 -0400
Message-ID: <480F05D7.1060402@in.ibm.com>
Date: Wed, 23 Apr 2008 15:18:07 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
	command
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
	<200804230041.m3N0fIQD013543@toshiba.co.jp>
In-Reply-To: <200804230041.m3N0fIQD013543@toshiba.co.jp>
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
To: gib <suchada.pitchayasamanya@toshiba.co.jp>, kexec@lists.infradead.org

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
> Yes, I built 2 kernels the first one as the system kernel and the second one
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
> What kernel version you are trying? Also what level of kexec-tools you use?
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
