Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-px0-f194.google.com ([209.85.216.194])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ng4t3-0005W7-An
	for kexec@lists.infradead.org; Fri, 12 Feb 2010 23:25:29 +0000
Received: by pxi32 with SMTP id 32so1999586pxi.15
	for <kexec@lists.infradead.org>; Fri, 12 Feb 2010 15:25:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F5FD1B18-ECCA-49E6-B720-D41D33C8E991@bwalle.de>
References: <74ae4f6a1002051845i6a2787deve82963c5d258eda4@mail.gmail.com>
	<4B6D393A.7060103@bwalle.de>
	<74ae4f6a1002101046y5faeacebxdf822eac8ccf6c98@mail.gmail.com>
	<F5FD1B18-ECCA-49E6-B720-D41D33C8E991@bwalle.de>
Date: Fri, 12 Feb 2010 15:25:24 -0800
Message-ID: <74ae4f6a1002121525p4f4b001xbdcf8f356098e2b2@mail.gmail.com>
Subject: Re: kdump cp /proc/vmcore exiting with "Invalid Argument" Error
From: Sujit V <sujit.linux@gmail.com>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: kexec@lists.infradead.org

I used the system with a 2GB memory so that /proc/vmcore would be less
than 4G. (and I would use the readelf I had from the binutils)

Enter shell command >ls -l /proc/vmcore
-r--------    1 0        0        2006283756 Apr  5 02:15 /proc/vmcore

 cp /proc/vmcore /local/local1/crash/vmcore-incomplete


Enter shell command >ls -l /local/local1/crash/
total 1810340
-r--------    1 0        0        1989877760 Apr  4 05:01 vmcore-incomplete


The cp on vmcore failed at file size was 1989877760 bytes. (i.e 0x769B2000 ).
From the readelf -l /proc/vmcore. we see that this file offset belongs
to a segment which starts at 0x000000007699f5ec.
From this informatin I calculated that 0x769B2000 has the physical
address. 0x7EC44A14


The kdump kernel boot param
root=/dev/ram0 nmi_watchdog=0 irqpoll maxcpus=1 reset_devices
 memmap=exactmap memmap=640K@0K memmap=130412K@16384K elfcorehdr=146796K

With the information  that cp fails at file offset 1989877760 bytes
which maps to physical address  0x7EC44A14 how do I further analyze
the issue.?

Any pointers ?


---------------------- snippet of readelf -l /proc/vmcore output
-------------------------------
Enter shell command >/sbin/readelf -l /proc/vmcore

Elf file type is CORE (Core file)
Entry point 0x0
There are 23 program headers, starting at offset 64

Program Headers:
  Type           Offset                              PhysAddr
               FileSiz                        MemSiz
   Flags      Align
 LOAD           0x000000007699f5ec       0x000000007ec32000
0x0000000000013000     0x0000000000013000      RWE    0
 LOAD           0x00000000769b25ec      0x000000007ec46000
0x0000000000002000

On Wed, Feb 10, 2010 at 11:53 PM, Bernhard Walle <bernhard@bwalle.de> wrote:
>
> Am 10.02.2010 um 19:46 schrieb Sujit V:
>
>> Tried readelf on the /proc/vmcore but gave the below error. The
>> readelf worked correctly on another binary.
>>
>> kdump shell>/sbin/readelf -l /proc/vmcore
>> readelf: Error: Cannot stat input file /proc/vmcore.
>
> My only guess is that readelf has no large file support (see http://sourceware.org/ml/binutils/2007-07/msg00087.html). Could you please execute "strace readelf -l /proc/vmcore"?
>
>
> Regards,
> Bernhard
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
