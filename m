Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzRXg-0008Dh-Uw
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 10:31:57 +0000
Received: by wyb28 with SMTP id 28so387650wyb.36
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 03:31:55 -0700 (PDT)
MIME-Version: 1.0
From: Anggriawan Sugianto <anggriawan.sugianto@gmail.com>
Date: Tue, 15 Mar 2011 17:31:34 +0700
Message-ID: <AANLkTikKgVYjO_v0xTHg-H1c0R1Z6QxuyVTDkx8Jy6zg@mail.gmail.com>
Subject: kexec on ARM - oops undefined instruction
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Dear all,

Currently I am learning about how kexec works in ARM kernel. I have
cross-compiled kexec-tools successfully, but when I run kexec, it
gives me kernel oops - undefined instruction.
_______________

#> ./kexec -l zImage --command-line=`cat /proc/cmdline`
#> ./kexec -e
Starting new kernel
Bye!
.
.
Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
Modules linked in:
 wl(P)(0xbf1d8000) kernel version : 0068_262 RELEASE preempt mod_unload ARMv7
 snd_usb_audio(0xbf1c5000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 snd_usb_lib(0xbf1c0000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 snd_seq_midi(0xbf1b6000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 snd_rawmidi(0xbf1ad000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 ftdi_sio(0xbf1a1000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 snd_hwdep(0xbf19a000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 usbhid(0xbf181000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 usbserial(0xbf177000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 sdp_mac(0xbf16e000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 usb_storage(0xbf161000) kernel version : 1005_272 RELEASE preempt
mod_unload ARMv7
 ohci_hcd(0xbf155000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 ehci_hcd(0xbf146000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 usbcore(0xbf127000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 fpi(P)(0xbf120000) kernel version : 0068_262 RELEASE preempt mod_unload ARMv7
 sdp_ahci(0xbf115000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 libata(0xbf0f4000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 sd_mod(0xbf0ea000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 sr_mod(0xbf0e2000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7
 cdrom(0xbf0d5000) kernel version : 1005_272 RELEASE preempt mod_unload ARMv7

CPU: 0    Tainted: P            (2.6.30.9 #48)
pc : [<747e4000>]    lr : [<c002acbc>]    psr: 60000013
sp : c768de58  ip : c6d92fc0  fp : c768de6c
r10: 00000000  r9 : c768c000  r8 : c0025568
r7 : 00000000  r6 : 45584543  r5 : c6ee3000  r4 : 747e3000
r3 : 00000c02  r2 : 000005f8  r1 : 000005f8  r0 : 747e3000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 74690019  DAC: 00000015
Process kexec (pid: 501, stack limit = 0xc768c2e0)
.
.
Backtrace:
Function entered at [<c002abb4>] from [<c008cfe0>]
 r5:28121969 r4:c0477a70
Function entered at [<c008cf90>] from [<c005b4e0>]
 r4:fee1dead r3:45584543
Function entered at [<c005b34c>] from [<c00253c0>]
 r7:00000058 r6:410338d8 r5:41033ac4 r4:0d696914
Code: 00000000 00000000 00000000 00000000 (dc9d7fc2)
_______________

I see the backtrace & lr. It guides me to:

$ cat objdump.txt | grep c002acbc
c002abc8:       e59fc0ec        ldr     ip, [pc, #236]  ; c002acbc
<machine_kexec+0x108>
c002acbc:       c03dc768        .word   0xc03dc768

$ cat objdump.txt | grep c002abb4
c002abb4 <machine_kexec>:
c002abb4:       e1a0c00d        mov     ip, sp
c008cfdc:       ebfe76f4        bl      c002abb4 <machine_kexec>
c008d234:       ebfe765e        bl      c002abb4 <machine_kexec>

$ cat objdump.txt | grep c008cf90
c005b4dc:       eb00c6ab        bl      c008cf90 <kernel_kexec>
c008cf90 <kernel_kexec>:
c008cf90:       e1a0c00d        mov     ip, sp

_______________

Can anyone help me what's wrong with "oops - undefined instruction" ?

Does it mean there is something wrong with machine_kexec() call in
kernel_kexec() function in <kernel_source>/kernel/kexec.c ? Or, is the
problem located in linked modules?

Thank you for your time.


Regards,
Anggriawan Sugianto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
