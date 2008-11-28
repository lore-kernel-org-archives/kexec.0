Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5xwJ-0002qh-3v
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 07:38:59 +0000
Date: Fri, 28 Nov 2008 08:38:52 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
Message-ID: <20081128083852.330bd44a@kopernikus.site>
In-Reply-To: <492F465D.6000609@mxs.nes.nec.co.jp>
References: <20081127160034.121f5911@hale.suse.de>
	<492F465D.6000609@mxs.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Hi Ken'ichi,

* Ken'ichi Ohmichi [2008-11-28 10:16]:
> Bernhard Walle wrote:
> > This bug fixes the problem that on a 32 bit userland makedumpfile (as common
> > on the PPC platform) the parsing of the 64 bit VMCOREINFO fails with:
> > 
> >    # makedumpfile -c /home/sachin/dump/vmcore vmcore.filtered
> >    read_vmcoreinfo_symbol: Invalid data in /tmp/vmcoreinfowVoyJK:
> >    SYMBOL(mem_section)=c000000000bb4400
> > 
> > We just need to assume that the symbols are always 'unsigned long long' (64 bit)
> > instead of 'unsigned long' (native pointer size on Linux platforms).
> 
> I agree with this patch basically. But I have not tested kdump on PPC64
> platform (PPC32 also) and I don't know it well. So may I ask a question ?
> 
> For PPC64 kdump, is it common thing that makedumpfile runs on PPC32 ?
> In other words, do you use PPC32 kernel as 2nd-kernel for PPC64 kdump ?

No. Both kernels are 64 bit. The system does not boot with a 32 bit
kernel (it's not like x86-64 where the system is entirely i386
compatible from the beginning).

But for openSUSE and SLES 9/SLES 10 at least -- that are the only
distributions I know on PPC [1] --, the userland is 90 % ppc32 and only
some small stuff is ppc64 (like an additional 64 bit C library and stuff
that is absolutely needed to be 64 bit like crash since that's not yet
capable of debugging 64 bit dumps on 32 bit).

Having that said, every tool that not needs to be 64 bit is a plus. 
Some month ago I already sent patches to 'fix' makedumpfile for 64 bit
kernels and you accepted them.


Regards,
Bernhard


[1] I'm not in the PPC team, so I don't know that platform very well,
    either. And I personally don't like that approach (64 bit kernel,
    32 bit userland) very much because it does cause trouble, but I
    cannot make decisions. ;-)
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
