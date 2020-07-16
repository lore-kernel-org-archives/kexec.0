Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvtcf-00048p-3W
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 02:27:45 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466100206.24747.3782313430191321863.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 11/12] ppc64/kexec_file: add appropriate regions for
 memory reserve map
In-reply-to: <159466100206.24747.3782313430191321863.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 23:27:30 -0300
Message-ID: <87sgds8a99.fsf@morokweng.localdomain>
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

> While initrd, elfcorehdr and backup regions are already added to the
> reserve map, there are a few missing regions that need to be added to
> the memory reserve map. Add them here. And now that all the changes
> to load panic kernel are in place, claim likewise.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Just one oinor nit below.

> ---
>
> v2 -> v3:
> * Unchanged. Added Tested-by tag from Pingfan.
>
> v1 -> v2:
> * Updated add_rtas_mem_range() & add_opal_mem_range() callsites based on
>   the new prototype for these functions.
>
>
>  arch/powerpc/kexec/file_load_64.c |   58 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 2531bb5..29e5d11 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -193,6 +193,34 @@ static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>  }
>  
>  /**
> + * get_reserved_memory_ranges - Get reserve memory ranges. This list includes
> + *                              memory regions that should be added to the
> + *                              memory reserve map to ensure the region is
> + *                              protected from any mischeif.

s/mischeif/mischief/

> + * @mem_ranges:                 Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
> +{
> +	int ret;
> +
> +	ret = add_rtas_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_tce_mem_ranges(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_reserved_ranges(mem_ranges);
> +out:
> +	if (ret)
> +		pr_err("Failed to setup reserved memory ranges\n");
> +	return ret;
> +}

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
