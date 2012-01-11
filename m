Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: ARM kexec SMP problem using exynos4210
Date: Wed, 11 Jan 2012 17:20:43 +0000
Message-ID: <CAEsOVNfWdHfy3XinAd836RqUpj6hF+7B8Af-3+vX14XuDV1niQ@mail.gmail.com>
References: <4F0D49DD.80305@samsung.com>
 <20120111100623.GA27887@mudshark.cambridge.arm.com>
 <4F0D6316.4090800@samsung.com>
 <20120111110319.GB27887@mudshark.cambridge.arm.com>
In-Reply-To: <20120111110319.GB27887@mudshark.cambridge.arm.com>
Content-Language: en-US
Content-ID: <1156A0697237AE4C9A582DEAB734525B@freescale.net>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 11, 2012 at 5:03 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jan 11, 2012 at 10:23:18AM +0000, Joonyoung Shim wrote:
>> One more question, generally boot cpu is first cpu(cpu0). If current
>> cpu is secondary cpu(cpu1), smp_send_stop of machine_shutdown will stop
>> first cpu and next kernel will try to boot on secondary cpu. Is it
>> possible?
>
> I added the cpu_logical_map stuff for this, so the kernel can handle it.
> That said, your platform may have restrictions about the boot CPU so if it
> doesn't work, you'll need to taskset the kexec command to CPU 0.

Would this negatively effect kdump though where you might not be able
to switch back to cpu0? I think It's best to be able to boot on any
core.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
