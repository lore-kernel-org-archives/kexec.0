Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvYRX-0000nz-82
 for kexec@lists.infradead.org; Wed, 15 Jul 2020 03:50:52 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466090332.24747.9255471295044653085.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 05/12] powerpc/drmem: make lmb walk a bit more flexible
In-reply-to: <159466090332.24747.9255471295044653085.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 00:50:35 -0300
Message-ID: <871rld8mic.fsf@morokweng.localdomain>
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> @@ -534,7 +537,7 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
>  #ifdef CONFIG_PPC_PSERIES
>  	if (depth == 1 &&
>  	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
> -		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
> +		walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);

walk_drmem_lmbs_early() can now fail. Should this failure be propagated
as a return value of early_init_dt_scan_memory_ppc()?

>  		return 0;
>  	}
>  #endif
<snip>

> @@ -787,7 +790,7 @@ static int __init parse_numa_properties(void)
>  	 */
>  	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>  	if (memory) {
> -		walk_drmem_lmbs(memory, numa_setup_drmem_lmb);
> +		walk_drmem_lmbs(memory, NULL, numa_setup_drmem_lmb);

Similarly here. Now that this call can fail, should
parse_numa_properties() handle or propagate the failure?

>  		of_node_put(memory);
>  	}
>


--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
