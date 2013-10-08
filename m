Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242])
 by merlin.infradead.org with smtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VTb6J-0007Mw-Bz
 for kexec@lists.infradead.org; Tue, 08 Oct 2013 17:29:40 +0000
Received: by mail-la0-f46.google.com with SMTP id eh20so7093246lab.5
 for <kexec@lists.infradead.org>; Tue, 08 Oct 2013 10:29:15 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Oct 2013 13:29:15 -0400
Message-ID: <CANM=TA-o50pK0pVP+b1ensOLtkOurhomUa9uEO_r6+8mH5MUYw@mail.gmail.com>
Subject: Intermittent problem launching the backup kernel
From: Patrick Lengel <plengel@sourcefire.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello Kexec community,

I am writing to see if it is possible to receive some
assistance to figure out why the kexec program is not
working properly on one of my system types.  While I have
successfully added the kexec technology to many of our
systems running various processors and kernel versions
there is one system in particular that has intermittent
problems.  The errant system type fails less than 5% of the
time because it freezes when attempting to begin running
the backup crash kernel stored in memory.  I believe that the
basic framework is correct but something is going amiss
when trying to start the backup crash kernel.

My system is running:

kexec-tools version 2.0.4
Linux kernel 2.6.35.14
Xeon X3450 processor
16G of memory

To gather more information I placed some debug printk
statements into the kexec kernel code to determine the
code path following a memory exception OOPS event.
I verified following code path:

no_context()        - arch/x86/mm/fault.c
oops_end()          - arch/x86/kernel/dumpstack.c
crash_kexec()       - kernel/kexec.c
machine_kexec()  - arch/x86/kernel/machine_kexec_64.c
load_segments()   - Assembly module

I have been able to get the kexec and kdump functionality
to work properly on a nearly identical platform using the
exact same 2.6.35.14 kernel file but running upon Intel
X3430 processor.

My Linux startup command line is:
auto BOOT_IMAGE=3D3D-5.3.0 ro root=3D805 console=3Dtty0 \
console=3DttyS0,9600 memmap=3D1G$4G \
crashkernel=3D128M@32M oops=3Dpanic

And my kexec command is:
/usr/sbin/kexec -p /boot/bzImage-2.6.35.14-sf.westmere-37 \
--append=3D" root=3D/dev/sda5 1 irqpoll maxcpus=3D1 \
reset_devices console=3Dtty0 console=3DttyS0,9600 \
memmap=3D1G$4G  oops=3Dpanic"

We have a customer network interface card that uses the
memory segment =93memmap=3D1G$4G=94 and can be
performing a DMA into main memory over the PCI bus
when the intentional memory exception event occurs.
I tried to place the backup kernel far away from this at an
offset of just 32M in the kernel OS space.  The other
systems that do not fail have these cards as well so this
card would not be the sole reason for the failure.

If there is anyone that can provide any suggestions or
advice on how to proceed that would be very much
appreciated.

Kind regards,
Patrick Lengel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
