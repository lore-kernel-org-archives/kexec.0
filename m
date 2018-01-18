Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ec0NB-0003f9-Td
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 02:56:15 +0000
Received: by mail-it0-x233.google.com with SMTP id 68so11808625ite.4
 for <kexec@lists.infradead.org>; Wed, 17 Jan 2018 18:56:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118024741.GA1831@dhcp-128-65.nay.redhat.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
 <20180118014705.GA1812@dhcp-128-65.nay.redhat.com>
 <CA+55aFzc9eXKOdhS-ygQPbr0_N84d8iE8WbSGOWmpJXr1rvDjQ@mail.gmail.com>
 <20180118024741.GA1831@dhcp-128-65.nay.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2018 18:56:01 -0800
Message-ID: <CA+55aFxWXOCo2DqjB_W6fM7Y6tX01mT1QT9rdoh7_X3-BH8eTQ@mail.gmail.com>
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
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
To: Dave Young <dyoung@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On Wed, Jan 17, 2018 at 6:47 PM, Dave Young <dyoung@redhat.com> wrote:
> Did several quick tests, probably need more tests, but till now the
> results are:
>
> void stop_this_cpu(void *dummy)
> {
> =====> add wbinvd here: kexec works
>         local_irq_disable();
> =====> add wbinvd here: kexec works
>         /*
>          * Remove this CPU:
>          */
>         set_cpu_online(smp_processor_id(), false);
> =====> add wbinvd here: kexec does not work

Funky.

> So it seems that it will not work after cpu offined..

Well, that set_cpu_online() call really just clears a bit in our
'__cpu_online_mask' CPU mask. It doesn't really do anything to the
*hardware*.

But I do wonder if the wbinvd causes an SMI or something on your
system. I _think_ wbinvd causes some external pin to be wiggled just
to tell possible external cache hardware to flush too, and on a system
level that could be tied to some random thing.

And then if we get an SMI/NMI when we've marked the system offline,
maybe we do something odd.

Very odd. But maybe this makes somebody go "Duh, that's because of xyz.."

                Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
