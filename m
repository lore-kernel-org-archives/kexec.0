Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hfsgd-0004f7-H6
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 08:10:13 +0100
Date: Mon, 23 Apr 2007 16:09:43 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix memory type detection
Message-ID: <20070423070941.GA3689@verge.net.au>
References: <462B726C.6020803@m3y3r.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <462B726C.6020803@m3y3r.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Sun, Apr 22, 2007 at 04:34:20PM +0200, Thomas Meyer wrote:
> Kexec should fall back to RANGE_RESERVED for unknown memory types in
> /proc/iomem:
> 
> cat /proc/iomem
> 00000000-0008efff : System RAM
>   00000000-00000000 : Crash kernel
> 0008f000-0008ffff : ACPI NVS
> 00090000-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 00100000-002fffff : Loader Data
> 00300000-3cc8cfff : System RAM
> 3cc8d000-3ccd4fff : BootServices Data
> 3ccd5000-3d84efff : System RAM
> 3d84f000-3d85dfff : Loader Data
> 3d85e000-3d88ffff : Loader Code
> 3d890000-3d8f6fff : Loader Data
> 3d8f7000-3d8f7fff : System RAM
> 3d8f8000-3d90bfff : Loader Data
> 3d90c000-3d91cfff : Loader Code
> 3d91d000-3e19ffff : System RAM
> 3e1a0000-3ecddfff : BootServices Data
> 3ecde000-3edeefff : System RAM
> 3edef000-3f0bcfff : BootServices Data
> 3f0bd000-3f2bdfff : ACPI NVS
> 3f2be000-3fcdffff : BootServices Data
> 3fce0000-3fd23fff : System RAM
> 3fd24000-3fe36fff : BootServices Code
> 3fe37000-3fe3ffff : System RAM
> 3fe40000-3fe63fff : Runtime Service Code
> 3fe64000-3fe7efff : System RAM
> 3fe7f000-3feaafff : Runtime Service Data
> 3feab000-3feb1fff : System RAM
> 3feb2000-3feb6fff : ACPI Reclaim
> 3feb7000-3feb8fff : System RAM
> 3feb9000-3feeefff : ACPI NVS
> 3feef000-3fefefff : ACPI Reclaim
> 3feff000-3fefffff : Runtime Service Data
> 3ff00000-3fffffff : PCI Bus #02
>   3ff00000-3ff1ffff : 0000:02:00.0
> 80000000-87ffffff : PCI Bus #01
>   80000000-87ffffff : 0000:01:00.0
>     80010000-8100ffff : imacfb
> 88000000-8bffffff : PCI Bus #04
> 8c000000-8c0fffff : PCI Bus #0c
>   8c000000-8c000fff : 0000:0c:03.0
>     8c000000-8c0007ff : ohci1394
> 8c100000-900fffff : PCI Bus #04
> 90100000-901fffff : PCI Bus #03
>   90100000-9010ffff : 0000:03:00.0
>     90100000-9010ffff : ath
> 90200000-902fffff : PCI Bus #02
>   90200000-90203fff : 0000:02:00.0
>     90200000-90203fff : sky2
> 90300000-903fffff : PCI Bus #01
>   90300000-9030ffff : 0000:01:00.0
>   90320000-9033ffff : 0000:01:00.0
> 90400000-90403fff : 0000:00:1b.0
>   90400000-90403fff : ICH HD audio
> 90404000-90404fff : 0000:00:07.0
> 90405000-904053ff : 0000:00:1f.2
>   90405000-904053ff : ahci
> 90405400-904057ff : 0000:00:1d.7
>   90405400-904057ff : ehci_hcd
> e00f8000-e00f8fff : Memory Mapped IO
> fed00000-fed003ff : HPET 0
> fed14000-fed17fff : pnp 00:01
> fed18000-fed18fff : pnp 00:01
> fed19000-fed19fff : pnp 00:01
> fed1c000-fed1ffff : Memory Mapped IO
> fffb0000-fffdffff : Memory Mapped IO
> 
> Without this patch all areas after a "System RAM" area also gets
> definied as RANGE_RAM. I think this error exists also in the remaining
> arch parser code like ppc. But i didn't care.

Hi Thomas,

I don't really see how this change works, as type is declared inside the
while loop (I'm not sure how happy I am about that...) and continue is
called immediately after you set it to RANGE_RESERVED.  In other words,
I don't think the value you assign to type can ever be used. 

Futhermore, it seems that all the if clauses either set type or call
continue. So I am not sure that I understand the problem that you are
seeing.

> 
> diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
> index 1c8d188..2b20071 100644
> --- a/kexec/arch/i386/kexec-x86.c
> +++ b/kexec/arch/i386/kexec-x86.c
> @@ -94,6 +94,7 @@ int get_memory_ranges(struct memory_range **range, int
> *ranges,
>              continue;
>          }
>          else {
> +                type = RANGE_RESERVED;
>              continue;
>          }
>          /* Don't report the interrupt table as ram */

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
