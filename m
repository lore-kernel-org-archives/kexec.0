Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RvN6D-0007YE-Lm
 for kexec@lists.infradead.org; Thu, 09 Feb 2012 06:03:18 +0000
Received: by iafj26 with SMTP id j26so2350497iaf.36
 for <kexec@lists.infradead.org>; Wed, 08 Feb 2012 22:03:14 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 9 Feb 2012 11:33:14 +0530
Message-ID: <CANBXnM=7eJVwCOoA-AoNPPf0A8OWyeQ=tG-W6ZiONG3WOb+EoQ@mail.gmail.com>
Subject: kdump / Kexec not working
From: Adil Mujeeb <mujeeb.adil@gmail.com>
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

Hi List,

I am new to crash / kdump tool and facing some problem as mentioned below.

I have SLES11 based system. I am building kernel source (SLES11 based
2.6.32 version) and added my
modules (for study purpose) in it. Building, installing and booting
with this kernel is successful. I have enabled the options for kdump
as mentioned below:

Enable Kexec system call:
CONFIG_KEXEC=y

Enable kernel crash dumps:
CONFIG_CRASH_DUMP=y

Optional: Disable Symmetric Multi-Processing (SMP) support
CONFIG_SMP=y

Enable sysfs file system support:
CONFIG_SYSFS=y

Enable /proc/vmcore support:
CONFIG_PROC_VMCORE=y

Configure the kernel with debug info:
CONFIG_DEBUG_INFO=y

Configure the start section for reserved RAM for the crash kernel:
CONFIG_PHYSICAL_START=0x200000             (2MB)

Configure kdump kernel so it can be identified:
CONFIG_LOCALVERSION="-crash"


Kdump configuration /etc/sysconfig/kdump:
KDUMP_KERNELVER=""

KDUMP_COMMANDLINE=""

KDUMP_COMMANDLINE_APPEND="maxcpus=1 "

KEXEC_OPTIONS=""

KDUMP_IMMEDIATE_REBOOT="yes"

KDUMP_TRANSFER=""

KDUMP_SAVEDIR="file:///var/crash"

KDUMP_KEEP_OLD_DUMPS="5"

KDUMP_FREE_DISK_SIZE="64"

KDUMP_VERBOSE="3"

KDUMP_DUMPLEVEL="0"

KDUMP_DUMPFORMAT="compressed"

There is no option KDUMP_DUMPDEV option
There is no option KDUMP_RUNLEVEL

I booted successfully with this kernel and tried to crash it by
kernel module. The system freezes and did not reboot as I expected the
kexec and kdump to do it. After rebooting manually there is no dump
file generated.

What could be the issue here?

Another observation is boot.kdump seems to on but manually start
giving me error:

linux:/home/adil # chkconfig boot.kdump
boot.kdump  on
linux:/home/adil #

hltncra110731:/home/adil # /etc/init.d/boot.kdump status
kdump kernel not loaded

                                                    dead
hltncra110731:/home/adil # /etc/init.d/boot.kdump start
Loading kdump
Can't find kernel text map area from kcore
Cannot load /boot/vmlinuz-2.6.32.12-crash

                                                    failed
hltncra110731:/home/adil #

Please help how to correctly setup and use crash on my machine.

Thank you,
Adil

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
