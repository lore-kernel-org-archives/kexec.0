Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWwJU-0002hv-Td
 for kexec@lists.infradead.org; Wed, 12 Dec 2018 04:40:02 +0000
Received: by mail-qt1-x843.google.com with SMTP id v11so19164774qtc.2
 for <kexec@lists.infradead.org>; Tue, 11 Dec 2018 20:39:50 -0800 (PST)
Subject: Re: arm64: kdump broken on a large CPU system
References: <113776f1-5633-e397-96eb-c533ea79671d@lca.pw>
 <29f74c6d-dd21-dcee-6c62-914f018c4e4e@arm.com>
 <7f467952-342b-71e2-c553-ff53ecc1812e@arm.com>
 <20181212025131.GL21466@linaro.org>
From: Qian Cai <cai@lca.pw>
Message-ID: <e4a3456b-6a75-4564-a49f-0532d0b35726@lca.pw>
Date: Tue, 11 Dec 2018 23:39:47 -0500
MIME-Version: 1.0
In-Reply-To: <20181212025131.GL21466@linaro.org>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

[+ kexec@lists.infradead.org]

The debugging progress so far...

Wait up to 5 minutes for other CPUs to stop in crash_smp_send_stop() made no
difference.

With "dev" branch of this tree [1], it is possible to print out messages from
purgatory when passing something like "--port=0x602B0000
--port-lsr=0x602B0000,0x80" to kexec. However, even enable_dcache() in
setup_arch() will hung like forever on this machine (working fine on another
arm64 server - Cortex-A72). After removed only enable_dcache() /
disable_dcache() from setup_arch() etc without removing printf() lines, it did
print out,

I'm in purgatory
purgatory: entry=0000000090080000
purgatory: dtb=0000000092d50000
purgatory: D-cache Enabled before SHA verification
purgatory: D-cache Disabled after SHA verification

So, it confirmed that it must hung somewhere in arm64/kernel/head.S (.stext) or
the early part of start_kernel() before earlycon was initialized.

Also confirmed that passing nr_cpus=64 in the first kernel would again make
everything work fine with this new kexec.

Since enable_dcache() would hung as well, I suspect this has something to do
with enabling MMU (i.e, .stext -> __primary_switch -> __enable_mmu) coupling
with some sort of per-CPU data where the number of CPUs matters.

Right now, I think I need to find a way to print directly to pl011 serial
console while debugging those assembly code like CONFIG_DEBUG_LL for arm64, so
it can be used to locate where exactly it hung. Otherwise, I am shooting in the
dark.

[1] https://github.com/pratyushanand/kexec-tools

=== original email ===

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash dump just
hung (4.20-rc6 as well as 4.18). It was confirmed that the executing went as far
as entering __cpu_soft_restart(),

__crash_kexec
  machine_kexec
    cpu_soft_restart
      restart
        __cpu_soft_restart

The earlycon was enabled but had no output from the 2nd kernel, so it was pretty
much stuck in all those assembly code in arm64/kernel/head.S or the early part
of start_kernel() before earlycon was initialized.

It turned out this has something to do with nr_cpus in the 1st kernel, although
the 2nd kernel always has nr_cpus=1 [1]. It was tested with both
crashkernel=512M or 768M.

nr_cpus <= 96  GOOD (2nd kernel was up in 2-3 mins.)
nr_cpus=256    BAD  (2nd kernel was NOT up after 1 hour.)
nr_cpus=127    BAD  (2nd kernel was NOT up after 10 mins.)

I did also test with and without CONFIG_ARM64_VHE (i.e., el2_switch) made no
difference.

[1] KDUMP_COMMANDLINE_APPEND="irqpoll nr_cpus=1 swiotlb=noforce reset_devices"

I am still figuring out a way to debug those assembly code to where it actually
hung, but the server was hooked up with a conserver that was not able to
generate any sysrq and I have no shell access to the conserver, so seems a bit
difficult to use kgdb or kdb in this case.

CPU information,

# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  4
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        2
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
BogoMIPS:            400.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            32768K
NUMA node0 CPU(s):   0-127
NUMA node1 CPU(s):   128-255
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics cpuid
asimdrdm

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
