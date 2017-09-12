Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 12 Sep 2017 13:55:21 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 3/9] kexec_file: factor out crashdump elf header function
 from x86
Message-ID: <20170912055521.GA8787@dhcp-128-65.nay.redhat.com>
References: <20170908031616.17916-1-takahiro.akashi@linaro.org>
 <20170908031616.17916-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170908031616.17916-4-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

Hi,
On 09/08/17 at 12:16pm, AKASHI Takahiro wrote:
[snip]
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -162,6 +162,25 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(u64, u64, void *));
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
> +#ifdef CONFIG_CRASH_CORE
> +extern int prepare_elf_headers(struct kimage *image, void **addr,
> +				unsigned long *sz);
> +
> +/* This primarily represents number of split ranges due to exclusion */
> +#define CRASH_MAX_RANGES        16
> +
> +struct crash_mem_range {
> +	u64 start, end;
> +};
> +
> +struct crash_mem {
> +	unsigned int nr_ranges;
> +	struct crash_mem_range ranges[CRASH_MAX_RANGES];
> +};
> +
> +extern int exclude_mem_range(struct crash_mem *mem,
> +		unsigned long long mstart, unsigned long long mend);
> +#endif /* CONFIG_CRASH_CORE */

Maybe I did not say it clear when reviewing the v1.

I suggested to move the code from to kexec_file.c because the
CONFIG_CRASH_CORE originally was introduced for the common code for
vmcoreinfo stuff when Hari worked on sharing code between powerpc
fadump and kdump.

I'm not sure we need the #ifdef CONFIG_CRASH_CORE here for these
kexec file load functions. Since they are already in kexec_file.c
so I think no need to add the #ifdef

>  #endif /* CONFIG_KEXEC_FILE */
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
