Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZGCq-0002Bl-0O
 for kexec@lists.infradead.org; Mon, 15 Aug 2016 11:37:24 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with
 kdump friendly version in panic path
Date: Mon, 15 Aug 2016 11:35:59 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
 <57ADD55D.1050003@mvista.com>
In-Reply-To: <57ADD55D.1050003@mvista.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Corey Minyard' <cminyard@mvista.com>, Dave Young <dyoung@redhat.com>
Cc: Daniel Walker <dwalker@fifo99.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Baoquan He <bhe@redhat.com>, David Daney <david.daney@cavium.com>, Xunlei Pang <xpang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Steven J. Hill" <steven.hill@cavium.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>

Hi Corey,

> From: Corey Minyard [mailto:cminyard@mvista.com]
> Sent: Friday, August 12, 2016 10:56 PM
> I'll try to test this, but I have one comment inline...

Thank you very much!

> On 08/11/2016 10:17 PM, Dave Young wrote:
> > On 08/10/16 at 05:09pm, Hidehiro Kawai wrote:
[snip]
> >> diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
> >> index 610f0f3..1723b17 100644
> >> --- a/arch/mips/kernel/crash.c
> >> +++ b/arch/mips/kernel/crash.c
> >> @@ -47,9 +47,14 @@ static void crash_shutdown_secondary(void *passed_regs)
> >>
> >>   static void crash_kexec_prepare_cpus(void)
> >>   {
> >> +	static int cpus_stopped;
> >>   	unsigned int msecs;
> >> +	unsigned int ncpus;
> >>
> >> -	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> >> +	if (cpus_stopped)
> >> +		return;
> 
> Wouldn't you want an atomic operation and some special handling here to
> ensure that only one CPU does this?  So if a CPU comes in here and
> another CPU is already in the process stopping the CPUs it won't result in a
> deadlock.

Because this function can be called only one panicking CPU,
there is no problem.

There are two paths which crash_kexec_prepare_cpus is called.

Path 1 (panic path):
panic()
  crash_smp_send_stop()
    crash_kexec_prepare_cpus()

Path 2 (oops path):
crash_kexec()
  __crash_kexec()
    machine_crash_shutdown()
      default_machine_crash_shutdown() // for MIPS
        crash_kexec_prepare_cpus()

Here, panic() and crash_kexec() run exclusively via
panic_cpu atomic variable.  So we can use cpus_stopped as
normal variable.

Best regards,

Hidehiro Kawai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
