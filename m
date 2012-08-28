Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6Icu-0002pE-KU
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 10:02:29 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCHv3 0/9] Support Xen versions up to xen-4.1
Date: Tue, 28 Aug 2012 12:02:20 +0200
References: <201208241746.09400.ptesarik@suse.cz>
 <0E9227E8EFCFF54EA493F6C0399C015D39BF96EA84@ABGEX70E.FSC.NET>
In-Reply-To: <0E9227E8EFCFF54EA493F6C0399C015D39BF96EA84@ABGEX70E.FSC.NET>
MIME-Version: 1.0
Message-Id: <201208281202.21176.ptesarik@suse.cz>
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
>[...]
> > I could also add the performance improvements, but I'm afraid it would
> > make for an incremental patch, so let's wait until the filtering is
> > finally right.
> 
> Alright to abandon the performance improvements for the time being
> but I would vote for adding the 1GB page recognition. That is:
> ...(pgd_entry & _PAGE_PSE)... in kvto_xen_x86_64. I think you would need
> a huge amount of memory to recognize this problem.

Oh! I missed the part that adds support for 1G pages. This is not merely 
performance improvement, but a bugfix - the routine is not able to translate 
1G mappings without the change.

The thing with 1G pages is that they are not available on all platforms (AFAIK 
only AMD has them).

Anyway, it should be two patches, in fact. Please stay tuned.

Petr Tesarik
SUSE Linux

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
