Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T7Sn1-0003kc-U5
 for kexec@lists.infradead.org; Fri, 31 Aug 2012 15:05:45 +0000
From: "Trapp, Norbert" <norbert.trapp@ts.fujitsu.com>
Date: Fri, 31 Aug 2012 17:05:01 +0200
Subject: Re: [PATCHv3 0/9] Support Xen versions up to xen-4.1
Message-ID: <0E9227E8EFCFF54EA493F6C0399C015D39BFC5A112@ABGEX70E.FSC.NET>
References: <201208241741.27573.petr@tesarici.cz>
In-Reply-To: <201208241741.27573.petr@tesarici.cz>
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>


> -----Original Message-----
> From: Petr Tesa=F8=EDk [mailto:petr@tesarici.cz]
> Sent: Friday, August 24, 2012 5:41 PM
> To: kexec@lists.infradead.org
> Cc: Trapp, Norbert
> Subject: [PATCHv3 0/9] Support Xen versions up to xen-4.1
> =

> Hello everybody,
> =

> this is version 3 of my patch set. I'm very much indebted to Norbert
> Trapp for his extensive testing of my previous patch set, which
> revealed that Xen hypervisor static data was not kept with the previous
> version of the patch set.
> =

> I could also add the performance improvements, but I'm afraid it would
> make for an incremental patch, so let's wait until the filtering is
> finally right.
> =

> I have re-tested this patch set with the same result as v2:
> =

>   - Xen-3.2.3 - WORKS
>   - Xen-4.0.1 - WORKS (only with --xen-syms)
>   - Xen-4.0.2 - WORKS
>   - Xen-4.1.2 - WORKS
> =

> Filtering free pages (-d16 and above) doesn't work (even after I manually
> provided the missing "max_pfn" symbol), but that seems unrelated, so I'm
> going to address it in a subsequent patch set.
> =

> Norbert, if you test these patches, please send your comments to the
> mailing list.

Hello Petr et al.,

after testing Petr's patches PATCHv3 plus "support for x86_64 1GB pages",
"add missing return statement" and "keep dumpfile pages in a cache" on a
machine with Xen 4.0.3 and 1GB pages there is only one comment I have:
It all worked nicely!

With kind regards,

	Norbert

Norbert Trapp
PBG PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstra=DFe 28, D-80807 M=FCnchen, Germany
E-mail: Norbert.Trapp@ts.fujitsu.com
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint
 =

> Atsushi-san, if the patch set passes Norbert's testing, what else do you
> need to accept the changes in upstream?
> =

> Regards,
> Petr Tesarik
> SUSE Linux
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
