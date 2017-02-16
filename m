Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ceEim-0005qc-6u
 for kexec@lists.infradead.org; Thu, 16 Feb 2017 05:35:13 +0000
From: Xunlei Pang <xpang@redhat.com>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic> <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic> <5886AD91.10803@redhat.com>
 <20170124122212.3dpdex5wjallypis@pd.tnic> <5889976A.9020802@redhat.com>
 <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic>
Message-ID: <58A53A65.3000405@redhat.com>
Date: Thu, 16 Feb 2017 13:36:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic>
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

On 01/26/2017 at 02:44 PM, Borislav Petkov wrote:
> On Thu, Jan 26, 2017 at 02:30:02PM +0800, Xunlei Pang wrote:
>> The hardware machine check is hard to reproduce, but the mce code of
>> RHEL7 is quite the same as that of tip/master, anyway we are able to
>> inject software mce to reproduce it.
> Please give me your exact steps so that I can try to reproduce it here
> too.
>

Hi Borislav,

I tried to use qemu to inject SRAO("mce -b 0 0 0xb100000000000000 0x5 0x0 0x0"),
it works well in 1st kernel, but it doesn't work for 1st kernel after kdump boots(seems
the cpus remain in 1st kernel don't respond to the simulated broadcasting mce).

But in theory, we know cpus belong to kdump kernel can't respond to the
old mce handler, so a single SRAO injection in 1st kernel should be similar.
For example, I used "... -smp 2 -cpu Haswell" to launch a simulation with broadcast
mce supported, and inject SRAO to cpu0 only through qemu monitor
"mce 0 0 0xb100000000000000 0x5 0x0 0x0", cpu0 will timeout/panic and reboot
the machine as follows(running on linux-4.9):
  Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
  Kernel Offset: disabled
  Rebooting in 30 seconds..

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
