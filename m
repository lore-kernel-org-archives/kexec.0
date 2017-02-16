Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ceKZi-00020H-Jc
 for kexec@lists.infradead.org; Thu, 16 Feb 2017 11:50:16 +0000
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic> <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic> <5886AD91.10803@redhat.com>
 <20170124122212.3dpdex5wjallypis@pd.tnic> <5889976A.9020802@redhat.com>
 <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic> <58A53A65.3000405@redhat.com>
 <20170216101845.vkmnde4v6v72dgzx@pd.tnic>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58A59269.3050706@redhat.com>
Date: Thu, 16 Feb 2017 19:52:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170216101845.vkmnde4v6v72dgzx@pd.tnic>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, xlpang@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 02/16/2017 at 06:18 PM, Borislav Petkov wrote:
> On Thu, Feb 16, 2017 at 01:36:37PM +0800, Xunlei Pang wrote:
>> I tried to use qemu to inject SRAO("mce -b 0 0 0xb100000000000000 0x5 0x0 0x0"),
>> it works well in 1st kernel, but it doesn't work for 1st kernel after kdump boots(seems
>> the cpus remain in 1st kernel don't respond to the simulated broadcasting mce).
>>
>> But in theory, we know cpus belong to kdump kernel can't respond to the
>> old mce handler, so a single SRAO injection in 1st kernel should be similar.
>> For example, I used "... -smp 2 -cpu Haswell" to launch a simulation with broadcast
>> mce supported, and inject SRAO to cpu0 only through qemu monitor
>> "mce 0 0 0xb100000000000000 0x5 0x0 0x0", cpu0 will timeout/panic and reboot
>> the machine as follows(running on linux-4.9):
>>   Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> Sounds to me like you're trying hard to prove some point of yours which
> doesn't make much sense to me. And when you say "in theory", that makes
> it even less believable. So I remember asking you for exact steps. That
> above doesn't read like steps but like some babbling and I've actually
> tried to make sense of it for a couple of minutes but failed.
>
> So lemme spell it out for ya. I'd like for you to give me this:
>
> 1. Build kernel with this config
> 2. Boot it in kvm with this settings
> 3. Do this in the guest
> 4. Do that in the guest
> 5. ...
> 6. ...
>
>
> And all should be exact commands so that I can do them here on my machine.
>

Sorry, missed your point.

The steps should be as follows:
1. Prepare a multi-core intel machine with broadcasted mce support.
    Enable kdump(crashkernel=256M) and configure kdump kernel to boot with "nr_cpus=1".
2. Activate kdump, and crash the first kernel on some cpu, say cpu1
    (taskset -c 1 echo 0 > /proc/sysrq-trigger), then kdump will boot on cpu1.
3. After kdump boots up(let it enter shell), trigger a SRAO on cpu1
   (QEMU monitor cmd: mce -b 1 0 0xb100000000000000 0x5 0x0 0x0),
    then mce will be broadcast to the other cpus which are still running
    in the first kernel(i.e. looping in crash_nmi_callback).
    If you own some hardware to inject mce, it would be great, as QEMU does not work correctly for me.
4. Then something like below is expected to happen:

[    1.468556] tsc: Refined TSC clocksource calibration: 2933.437 MHz
         Starting Kdump Vmcore Save Service...
kdump: saving to /sysroot//var/crash/127.0.0.1-2015-09-01-05:07:03/
kdump: saving vmcore-dmesg.txt
[   39.000010] mce: [Hardware Error]: CPU 0: Machine Check Exception: 0 Bank 2: bd0000000000017a
[   39.000010] mce: [Hardware Error]: TSC 0 ADDR 61600000 MISC 8c 
[   39.000010] mce: [Hardware Error]: PROCESSOR 0:106a3 TIME 1441083980 SOCKET 0 APIC 0 microcode 1
[   39.000010] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[   39.000010] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
[   39.000010] Shutting down cpus with NMI
[    1.758463] Uhhuh. NMI received for unknown reason 20 on CPU 0.
[    1.758463] Do you have a strange power saving mode enabled?
[    1.758463] Dazed and confused, but trying to continue
[   39.000010] Rebooting in 30 seconds..

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
