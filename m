Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdzkZ-0001C4-MI
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 09:50:13 +0000
Date: Wed, 6 Nov 2013 17:48:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86: make reboot task only run on the appropriate
 processor
Message-ID: <20131106094848.GB2425@dhcp-16-105.nay.redhat.com>
References: <1383642967-12595-1-git-send-email-bhe@redhat.com>
 <20131105202855.GD4598@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131105202855.GD4598@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mwhitehe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, davej@fedoraproject.org, mingo@redhat.com, holt@sgi.com, hpa@zytor.com, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, akpm@linux-foundation.org, chaowang@redhat.com

On 11/05/13 at 03:28pm, Vivek Goyal wrote:
> On Tue, Nov 05, 2013 at 05:16:07PM +0800, Baoquan He wrote:
> > Currently system always reboot after below message when execute "kexec -e".
> > 
> > [    0.572119] smpboot: Booting Node   0, Processors  #   1 OK
> > 
> 
> So is it same problem were we reboot on non-boot cpu and sending INIT
> to boot cpu in second kernel brings down the machine?

They are different. Kdump hang when crash didn't happen on bsp, then
multiple CPUs are brought up, the bsp will go through the boot strap
code after INIT IPI message received. However in this case, executing
"kexec -e" will make system reboot and bring up only 1 CPU, then go back
to BIOS and reboot. 

In kdump, nmi is sent to shutdown other CPUs. In this shutdown, cleanup
is done and finally processor is halt. And if crash didn't happen on
bsp, during system startup INIT sent to bsp will cause system hang.

However, in kexec reboot, a REBOOT_VECTOR interrupt is sent to all other
CPUs. In commit 4ef702c10b5df18ab04921fc252c26421d4d6c75, Andi imported
this IPI interrupt vector. Andi said it has been given the highest
priority.

It's still not very clear why this happened without that code block.
Seems interrupt disable is very doubtful.

> 
> I think for x86, it makes sense to reboot on boot cpu.
> 
> Thanks
> Vivek
> 

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
