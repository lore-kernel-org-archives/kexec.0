Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVFDu-0002X1-Fu
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 09:45:55 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
In-Reply-To: <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
Date: Thu, 04 Aug 2016 19:45:28 +1000
Message-ID: <87h9b0g953.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, rusty@rustcorp.com.au, ebiederm@xmission.com, vgoyal@redhat.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
...
>  /**
>   * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
>   *
> @@ -212,12 +262,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>  {
>  	unsigned long size;
>  
> +	/* sets fw_dump.reserve_bootvar */
> +	parse_fadump_reserve_mem();
> +
>  	/*
>  	 * Check if the size is specified through fadump_reserve_mem= cmdline
>  	 * option. If yes, then use that.
>  	 */
>  	if (fw_dump.reserve_bootvar)
>  		return fw_dump.reserve_bootvar;
> +	else
> +		printk(KERN_INFO "fadump: calculating default boot size\n");
>  
>  	/* divide by 20 to get 5% of value */
>  	size = memblock_end_of_DRAM() / 20;

The code already knows how to reserve 5% based on the size of the machine's
memory, as long as no commandline parameter is passed. So why can't we
just use that logic?

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
