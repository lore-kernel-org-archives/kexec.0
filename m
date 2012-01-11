Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 11 Jan 2012 11:03:20 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: ARM kexec SMP problem using exynos4210
Message-ID: <20120111110319.GB27887@mudshark.cambridge.arm.com>
References: <4F0D49DD.80305@samsung.com>
 <20120111100623.GA27887@mudshark.cambridge.arm.com>
 <4F0D6316.4090800@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F0D6316.4090800@samsung.com>
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
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 11, 2012 at 10:23:18AM +0000, Joonyoung Shim wrote:
> One more question, generally boot cpu is first cpu(cpu0). If current
> cpu is secondary cpu(cpu1), smp_send_stop of machine_shutdown will stop
> first cpu and next kernel will try to boot on secondary cpu. Is it
> possible?

I added the cpu_logical_map stuff for this, so the kernel can handle it.
That said, your platform may have restrictions about the boot CPU so if it
doesn't work, you'll need to taskset the kexec command to CPU 0.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
