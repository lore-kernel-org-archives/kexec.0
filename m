Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFs8Q-0005Lz-W5
 for kexec@lists.infradead.org; Tue, 08 May 2018 02:13:48 +0000
Received: by mail-pg0-x243.google.com with SMTP id i29-v6so20448935pgn.12
 for <kexec@lists.infradead.org>; Mon, 07 May 2018 19:13:35 -0700 (PDT)
Date: Tue, 8 May 2018 11:14:25 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-ops: Add helper API to dump fdt blob
Message-ID: <20180508021420.GH11326@linaro.org>
References: <1525036956-7440-1-git-send-email-bhsharma@redhat.com>
 <1525036956-7440-2-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1525036956-7440-2-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: dyoung@redhat.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, james.morse@arm.com, horms@verge.net.au

Bhupesh,

On Mon, Apr 30, 2018 at 02:52:35AM +0530, Bhupesh Sharma wrote:
> At several occasions it would be useful to dump the fdt
> blob being passed to the second (kexec/kdump) kernel
> when '-d' flag is specified while invoking kexec/kdump.
> 
> This allows one to look at the device-tree fields that
> is being passed to the secondary kernel and accordingly
> debug issues.
> 
> This can be specially useful for the arm64 case, where
> kexec_load() or kdump passes important information like
> 'linux,usable-memory' ranges to the second kernel, and
> the correctness of the ranges can be verified by
> looking at the device-tree dump with '-d' flag specified.
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kexec/dt-ops.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  kexec/dt-ops.h |   1 +
>  2 files changed, 144 insertions(+)
> 
> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
> index 915dbf55afd2..cb95920e5c3e 100644
> --- a/kexec/dt-ops.c
> +++ b/kexec/dt-ops.c
> @@ -8,6 +8,10 @@
>  #include "kexec.h"
>  #include "dt-ops.h"
>  
> +#define ALIGN(x, a)	(((x) + ((a) - 1)) & ~((a) - 1))
> +#define PALIGN(p, a)	((void *)(ALIGN((unsigned long)(p), (a))))

Pointer doesn't always fit to unsigned long.

> +#define GET_CELL(p)	(p += 4, *((const uint32_t *)(p-4)))

Tricky :) Inline function would be better.

> +
>  static const char n_chosen[] = "/chosen";
>  
>  static const char p_bootargs[] = "bootargs";
> @@ -143,3 +147,142 @@ int dtb_delete_property(char *dtb, const char *node, const char *prop)
>  
>  	return result;
>  }
> +
> +static uint64_t is_printable_string(const void* data, uint64_t len)
> +{
> +	const char *s = data;
> +	const char *ss;
> +
> +	/* Check for zero length strings */
> +	if (len == 0)
> +		return 0;
> +
> +	/* String must be terminated with a '\0' */
> +	if (s[len - 1] != '\0')
> +		return 0;

This (== '\0') can hit even if the data is numeric.

> +
> +	ss = s;
> +	while (*s)
> +		s++;

You don't check for the length, so

> +	/* Traverse till we hit a '\0' or reach 'len' */
> +	if (*s != '\0')
> +		return 0;

This will never hit.

> +	if ((s + 1 - ss) < len) {
> +		/* Handle special cases such as 'bootargs' properties
> +		 * in dtb which are actually strings, but they may have
> +		 * a format where (s + 1 - ss) < len remains true.
> +		 *
> +		 * We can catch such cases by checking if (s + 1 - ss)
> +		 * is greater than 1

What does this actually mean? Elaborate, please.

> +		 */
> +		if ((s + 1 - ss) > 1)
> +			return 1;
> +
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static void print_data(const char* data, uint64_t len)
> +{
> +	uint64_t i;
> +	const char *p = data;
> +
> +	/* Check for non-zero length */
> +	if (len == 0)
> +		return;
> +
> +	if (is_printable_string(data, len)) {
> +		dbgprintf(" = \"%s\"", (const char *)data);
> +	} else if ((len % 4) == 0) {
> +		dbgprintf(" = <");
> +		for (i = 0; i < len; i += 4) {
> +			dbgprintf("0x%08x%s",
> +					fdt32_to_cpu(GET_CELL(p)),
> +					i < (len - 4) ? " " : "");
> +		}
> +		dbgprintf(">");
> +	} else {
> +		dbgprintf(" = [");
> +		for (i = 0; i < len; i++)
> +			dbgprintf("%02x%s", *p++,
> +					i < len - 1 ? " " : "");
> +		dbgprintf("]");
> +	}
> +}
> +
> +void dump_fdt(void* fdt)
> +{
> +	struct fdt_header *bph;
> +	const char* p_struct;
> +	const char* p_strings;
> +	const char* p;
> +	const char* s;
> +	const char* t;

I prefer more meaningful names.

> +	uint32_t off_dt;
> +	uint32_t off_str;
> +	uint32_t tag;
> +	uint64_t sz;
> +	uint64_t depth;
> +	uint64_t shift;
> +	uint32_t version;
> +
> +	depth = 0;
> +	shift = 4;
> +
> +	bph = fdt;
> +	off_dt = fdt32_to_cpu(bph->off_dt_struct);
> +	off_str = fdt32_to_cpu(bph->off_dt_strings);
> +	p_struct = (const char*)fdt + off_dt;
> +	p_strings = (const char*)fdt + off_str;
> +	version = fdt32_to_cpu(bph->version);
> +
> +	p = p_struct;
> +	while ((tag = fdt32_to_cpu(GET_CELL(p))) != FDT_END) {
> +
> +		if (tag == FDT_BEGIN_NODE) {
> +			s = p;
> +			p = PALIGN(p + strlen(s) + 1, 4);
> +
> +			if (*s == '\0')
> +				s = "/";
> +
> +			dbgprintf("%*s%s {\n", (int)(depth * shift), " ", s);
> +
> +			depth++;
> +			continue;
> +		}
> +
> +		if (tag == FDT_END_NODE) {
> +			depth--;
> +
> +			dbgprintf("%*s};\n", (int)(depth * shift), " ");
> +			continue;
> +		}
> +
> +		if (tag == FDT_NOP) {
> +			dbgprintf("%*s// [NOP]\n", (int)(depth * shift), " ");
> +			continue;
> +		}
> +
> +		if (tag != FDT_PROP) {
> +			dbgprintf("%*s ** Unknown tag 0x%08x\n",
> +					(int)(depth * shift), " ", tag);
> +			break;
> +		}
> +		sz = fdt32_to_cpu(GET_CELL(p));
> +		s = p_strings + fdt32_to_cpu(GET_CELL(p));
> +		if (version < 16 && sz >= 8)
> +			p = PALIGN(p, 8);
> +		t = p;

't' is used only here, so
> +
> +		p = PALIGN(p + sz, 4);
> +
> +		dbgprintf("%*s%s", (int)(depth * shift), " ", s);
> +		print_data(t, sz);
> +		dbgprintf(";\n");


		dbgprintf("%*s%s", (int)(depth * shift), " ", s);
		print_data(p, sz);
		dbgprintf(";\n");

		p = PALIGN(p + sz, 4);

This will work.

Thanks,
-Takahiro AKASHI


> +	}
> +}
> diff --git a/kexec/dt-ops.h b/kexec/dt-ops.h
> index e70d15d8ffbf..25b9b569f2b7 100644
> --- a/kexec/dt-ops.h
> +++ b/kexec/dt-ops.h
> @@ -9,5 +9,6 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
>  	const char *prop, const void *value, int value_len);
>  
>  int dtb_delete_property(char *dtb, const char *node, const char *prop);
> +void dump_fdt(void *fdt) ;
>  
>  #endif
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
