Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZijb-0004gu-EV
 for kexec@lists.infradead.org; Tue, 07 May 2013 14:19:16 +0000
Date: Tue, 7 May 2013 10:18:51 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1785236816.7828370.1367936331637.JavaMail.root@redhat.com>
In-Reply-To: <CAEyr1FSxmTW2st4BSzWa3K6AJpBLj-PqJh6-zmA_K6f5C8r7ng@mail.gmail.com>
References: <CAEyr1FSxmTW2st4BSzWa3K6AJpBLj-PqJh6-zmA_K6f5C8r7ng@mail.gmail.com>
Subject: Re: [Crash-utility] crash read error: kernel virtual address /
 vmcore	address mismatch ?
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> Hi ,
> Sorry about re posting this as i did not find solution ...
> 
> I m facing a issue where on
> 
> #crash /data/linux-2.6.30.8/vmlinux /proc/vmcore

Do yourself a favor and copy /proc/vmcore to somewhere on disk.  Then
reboot the system into the original kernel, and run crash on the saved
vmcore.  I've never seen crash run on a /proc/vmcore file from the
secondary kernel.  

Also, after rebooting the the original kernel, please confirm that
crash runs OK on the live system.
 
> crash 6.1.6
> Copyright (C) 2002-2013  Red Hat, Inc.
> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
> Copyright (C) 1999-2006  Hewlett-Packard Co
> Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
> Copyright (C) 2005, 2011  NEC Corporation
> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
> This program is free software, covered by the GNU General Public License,
> and you are welcome to change it and/or distribute copies of it under
> certain conditions.  Enter "help copying" to see the conditions.
> This program has absolutely no warranty.  Enter "help warranty" for details.
> 
> GNU gdb (GDB) 7.3.1
> Copyright (C) 2011 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "i686-pc-linux-gnu"...
> 
> crash: read error: kernel virtual address: c127a9c8  type: "cpu_possible_mask"

Please show the full output of "crash -d8 vmlinux vmcore".
 
> 
> I did follow few threads around , I have a case similar to
> https://www.redhat.com/archives/crash-utility/2010-August/msg00029.html
> 
> Both the System Kernel and the Debug Kernel are the same.

I don't know what you mean by "System Kernel" and "Debug Kernel". 

With respect to kdump and the crash utility, the only kernel that is
of interest is the vmlinux that was running when the primary system
crashed.

> 
> My current config for
> 
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_PHYSICAL_ALIGN=0x400000
> 
> The /proc/kallsyms is diffrent between the System Kernel and Debug Kernel.
> On the System Kernel it starts from 0x400000 .On the Debug kernel it
> starts from 0x1000000.

Again, the "Debug" kernel is irrelevant -- presuming by "Debug" you mean
the relocated "secondary" kernel that was kexec'd after the primary kernel
crashed.

> 
> if  i change the CONFIG_PHYSICAL_START=0x400000 . It does NOT core dump.
> 
> my crashkernel=128M is the setting on grub.
> Let me know if you need more info
> 

What "core dumps", the crash utility?  Again, trying to run the crash utility
while running on a 128MB secondary kernel is definitely not advisable.  

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
