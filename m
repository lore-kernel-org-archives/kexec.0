Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T72mb-0000tb-21
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 11:19:34 +0000
From: "Trapp, Norbert" <norbert.trapp@ts.fujitsu.com>
Date: Thu, 30 Aug 2012 13:19:04 +0200
Subject: Re: [PATCH] makedumpfile: Support for x86_64 1G pages
Message-ID: <0E9227E8EFCFF54EA493F6C0399C015D39BFC59830@ABGEX70E.FSC.NET>
References: <201208281710.51166.ptesarik@suse.cz>
In-Reply-To: <201208281710.51166.ptesarik@suse.cz>
Content-Language: de-DE
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.cz>


> -----Original Message-----
> From: Petr Tesarik [mailto:ptesarik@suse.cz]
> Sent: Tuesday, August 28, 2012 5:11 PM
> To: kexec@lists.infradead.org
> Cc: Trapp, Norbert
> Subject: [PATCH] makedumpfile: Support for x86_64 1G pages
> =

> The PS bit is not recognized in the Page-Directory-Pointer Table (pgdir
> in Linux terms), so virtual addresses that map to a 1G page will be
> translated incorrectly.
> =

> This bug affects both Xen and bare metal. I don't think it can be easily
> triggered in practice, because 1G mappings are created only for:
> =

> 1. direct 1:1 mapping of physical memory, for which we don't walk the page
>    tables, but instead subtract the corresponding virtual offset, and
> 2. 1G hugepages, which are only used for userspace data.
...

Hello again,

With Xen not only the Linux kernel has to be considered, but the Xen
hypervisor, too.  The usage of 1 GB pages by the hypervisor is
relevant for machines with recent types of processors and more
than a small amount of memory.

With kind reagards

	Norbert

Norbert Trapp
PBG PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstra=DFe 28, D-80807 M=FCnchen, Germany
E-mail: Norbert.Trapp@ts.fujitsu.com
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
