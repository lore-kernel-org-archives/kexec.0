Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1ceJ9u-00035K-0b
 for kexec@lists.infradead.org; Thu, 16 Feb 2017 10:19:34 +0000
Date: Thu, 16 Feb 2017 11:18:45 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170216101845.vkmnde4v6v72dgzx@pd.tnic>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <5886AD91.10803@redhat.com>
 <20170124122212.3dpdex5wjallypis@pd.tnic>
 <5889976A.9020802@redhat.com>
 <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic>
 <58A53A65.3000405@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58A53A65.3000405@redhat.com>
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
To: xlpang@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Thu, Feb 16, 2017 at 01:36:37PM +0800, Xunlei Pang wrote:
> I tried to use qemu to inject SRAO("mce -b 0 0 0xb100000000000000 0x5 0x0 0x0"),
> it works well in 1st kernel, but it doesn't work for 1st kernel after kdump boots(seems
> the cpus remain in 1st kernel don't respond to the simulated broadcasting mce).
> 
> But in theory, we know cpus belong to kdump kernel can't respond to the
> old mce handler, so a single SRAO injection in 1st kernel should be similar.
> For example, I used "... -smp 2 -cpu Haswell" to launch a simulation with broadcast
> mce supported, and inject SRAO to cpu0 only through qemu monitor
> "mce 0 0 0xb100000000000000 0x5 0x0 0x0", cpu0 will timeout/panic and reboot
> the machine as follows(running on linux-4.9):
>   Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler

Sounds to me like you're trying hard to prove some point of yours which
doesn't make much sense to me. And when you say "in theory", that makes
it even less believable. So I remember asking you for exact steps. That
above doesn't read like steps but like some babbling and I've actually
tried to make sense of it for a couple of minutes but failed.

So lemme spell it out for ya. I'd like for you to give me this:

1. Build kernel with this config
2. Boot it in kvm with this settings
3. Do this in the guest
4. Do that in the guest
5. ...
6. ...


And all should be exact commands so that I can do them here on my machine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
