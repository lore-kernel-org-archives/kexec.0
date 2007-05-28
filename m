Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HsmpL-0001EQ-FO
	for kexec@lists.infradead.org; Mon, 28 May 2007 17:32:33 -0400
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <465ABFC9.9020502@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com> <20070524142133.GA13191@lixom.net>
	<4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
Date: Tue, 29 May 2007 07:31:34 +1000
Message-Id: <1180387894.19517.99.camel@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: sachinp@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org, Milton Miller II <miltonm@us.ibm.com>

On Mon, 2007-05-28 at 17:10 +0530, Sachin P. Sant wrote:
> 
> +#define HPTE_V_1TB_SEG         ASM_CONST(0x4000000000000000)
> +#define HPTE_V_VRMA_MASK       ASM_CONST(0x4001ffffff)

Move those to mmu-hash64.h along with the other ones. Also, keep the
mask aligned to the top bits

>  static void pSeries_lpar_hptab_clear(void)
>  {
>         unsigned long size_bytes = 1UL << ppc64_pft_size;
>         unsigned long hpte_count = size_bytes >> 4;
> -       unsigned long dummy1, dummy2;
> +       unsigned long dummy1, dummy2, dword0;
> +       long lpar_rc;
>         int i;
>  
>         /* TODO: Use bulk call */
> -       for (i = 0; i < hpte_count; i++)
> -               plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +       for (i = 0; i < hpte_count; i++) {
> +               /* dont remove HPTEs with VRMA mappings */
> +               lpar_rc = plpar_pte_remove_raw(H_ANDCOND, i, HPTE_V_1TB_SEG,
> +                                               &dummy1, &dummy2);
> +               if (lpar_rc == H_NOT_FOUND) {
> +                       lpar_rc = plpar_pte_read_raw(0, i, &dword0, &dummy1);
> +                       if (!lpar_rc && (((dword0 >> 24) & HPTE_V_VRMA_MASK) 
> +                               != HPTE_V_VRMA_MASK))

No need to shift >> 24, just have the mask left justified in the first
place. No need to have a "magic" shift value in there.

> +                               /* Can be hpte for 1TB Seg. So remove it */
> +                               plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +               }
> +       }
>  }

Appart from that, looks good. Does it actually work ? :-)

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
