Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGOKI-00084n-WA
 for kexec@lists.infradead.org; Mon, 02 Sep 2013 07:13:32 +0000
Date: Mon, 2 Sep 2013 09:13:18 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86, apic: Disable BSP if boot cpu is AP
Message-ID: <20130902071318.GA3406@x1.alien8.de>
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <20130829092804.5476.95588.stgit@localhost6.localdomain6>
 <20130831052252.GC12617@x1.alien8.de>
 <5223F8DB.3040506@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5223F8DB.3040506@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

On Mon, Sep 02, 2013 at 11:32:59AM +0900, HATAYAMA Daisuke wrote:
> As you suggest, boot_cpu seems more understandable also to me. BTW,
> please notice that it doesn't denote that the CPU we're booting on
> currently, but that the CPU with BSP flag set.

Hmm, by "BSP flag set" you mean it is the first LAPIC entry in the MADT,
correct? At least this is the case when you set isbsp to true. Because,
there's also the BSC flag in APIC_BAR (MSR 0x1b) which denotes the
bootstrapping core on node 0.

> In general, current code uses many terms to denote the cpu that is run
> at kernel boot-up processing such as boot cpu, bsp, cpu0 and possibly
> others since in usual situation, boot cpu is always BSP and assigned
> to cpu0. But it is not the case in case of kexec. I'm using the word
> bsp purposely in the isbsp to mean the CPU with BSP flag set.
>
> So I think it's better to use bsp_cpu here to denote the CPU with BSP
> flag set.

Right.

> For the comment, how about the following one?
> 
>         /*
>          * In this case, boot cpu is AP. This can happen on
>          * kexec/kdump. Consider the case that crash happens on some
>          * AP and enters kdump 2nd kernel with the AP.
>          *
>          * Then, there's issue that if we send INIT to BSP, due to x86
>          * hardware specification, it is forced to jump at BIOS init
>          * code and system hangs or resets immediately.
>          *
>          * To avoid the issue, we disable BSP. Then, there's no longer
>          * possbility to send INIT to BSP.
>          */

Yes, much better. Especially when looking down the road and people have
forgotten what the whole fuss was about, a nice detailed comment is
priceless.

Thanks.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
