Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T62Nv-0007vK-FZ
 for kexec@lists.infradead.org; Mon, 27 Aug 2012 16:41:56 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCHv3 0/9] Support Xen versions up to xen-4.1
Date: Mon, 27 Aug 2012 18:41:45 +0200
References: <201208241746.09400.ptesarik@suse.cz>
 <0E9227E8EFCFF54EA493F6C0399C015D39BF96EA84@ABGEX70E.FSC.NET>
In-Reply-To: <0E9227E8EFCFF54EA493F6C0399C015D39BF96EA84@ABGEX70E.FSC.NET>
MIME-Version: 1.0
Message-Id: <201208271841.46022.ptesarik@suse.cz>
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
To: "Trapp, Norbert" <norbert.trapp@ts.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Dne Po 27. srpna 2012 18:19:20 Trapp, Norbert napsal(a):
> Hello Petr,
> 
> > -----Original Message-----
> > From: Petr Tesarik [mailto:ptesarik@suse.cz]
> > Sent: Friday, August 24, 2012 5:46 PM
> > To: kexec@lists.infradead.org
> > Cc: Trapp, Norbert
> > Subject: [PATCHv3 0/9] Support Xen versions up to xen-4.1
> > 
> > Hello everybody,
> > 
> > this is version 3 of my patch set. I'm very much indebted to Norbert
> > Trapp for his extensive testing of my previous patch set, which
> > revealed that Xen hypervisor static data was not kept with the previous
> > version of the patch set.
> 
> Thank you, Petr. I also admire your patches for all sorts of versions.
> 
> > I could also add the performance improvements, but I'm afraid it would
> > make for an incremental patch, so let's wait until the filtering is
> > finally right.
> 
> Alright to abandon the performance improvements for the time being
> but I would vote for adding the 1GB page recognition. That is:
> ...(pgd_entry & _PAGE_PSE)... in kvto_xen_x86_64. I think you would need
> a huge amount of memory to recognize this problem.

It would still be good to get it into the next release. So, if we finally got 
everything right here, I'll be posting the improvements right away.

Petr Tesarik
SUSE Linux

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
