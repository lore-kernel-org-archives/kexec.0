Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FCEC87FCA
	for <kexec@archiver.kernel.org>; Fri,  1 Aug 2025 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WsDgkSlSbKqTEWkOFRwKv1Ixb+2FwAIaetGOoFz4OCY=; b=E10s1rQS3aeZZf6Tehk5/7ZPAl
	/7YMWEW9oQaXCiSUm1fL3dHULR6+sE46BSBimph140fvkg9Uqes/JQyfPI+E66aLw8+LkBfbZFedB
	XWUxyLttIOuS4C/ErRWABLAGyZE6zaCcn88yjvE0wcp7xP4yHYaFFhC86IC/BHeU3BgWN5CmioJXT
	OF27z49d1xCvfFp/akbnyctdrnx2tkFPi3e7ZV9vMcZOG8Y1bhbCdeJ7oHdM/jkfnuYGsgo3gMLSt
	suknXs2uFuXf1GkY5Pe+lpmYfH1H8MYfcpr74C6c26P9qZQ+wU2Zm+IDY6taU02LGoNUGqJhC5c4N
	W2qUAN3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhqeX-00000006DXN-40IO;
	Fri, 01 Aug 2025 14:22:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhqVt-00000006CTe-2czX
	for kexec@lists.infradead.org;
	Fri, 01 Aug 2025 14:13:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A44EC44C91;
	Fri,  1 Aug 2025 14:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE5DC4CEF6;
	Fri,  1 Aug 2025 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754057615;
	bh=gsmM1hlpa9ZTykeARSywzNo3kKIbp5DEz7gzKeF6uak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cIPDeZgwK4SYF7yWAXbPhD60yge2cS6B7a0EUK3SX5psD+jOSs90ScbGS1VumwZC4
	 nNYptv+zIczG3GNxk20cRU3usdeDj6nvIYJc5sUjYBSLhzFZUaqwFpcwTG13qAAZAd
	 trJ3MwiCd4mL26DkN94j29fayTTA+XVJb4S+X1YH2IVsVp2+4cpD0D+2cJ8s86RRdi
	 5IDlP4iIssX1+7XLB/ngKt8VcYNkr8WcwhBj9fn6OTkFcS0e3sbXV8kJyECiD8M0Lm
	 4B2BpID1xq2EFEXIXRJ3OnzoTh6Rq9arI09MdbU+vKZISWOwGYs7SYiYh6GEicY1YR
	 ZVxRNojV3VJBA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,  Shuah
 Khan <shuah@kernel.org>,  Thomas Weischuh <linux@weissschuh.net>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2] kho: add test for kexec handover
In-Reply-To: <20250801100630.3473918-1-rppt@kernel.org>
References: <20250801100630.3473918-1-rppt@kernel.org>
Date: Fri, 01 Aug 2025 16:13:32 +0200
Message-ID: <mafs0zfcjcepf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250801_071337_711366_CF5A0C01 
X-CRM114-Status: GOOD (  34.54  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Mike,

On Fri, Aug 01 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Testing kexec handover requires a kernel driver that will generate some
> data and preserve it with KHO on the first boot and then restore that
> data and verify it was preserved properly after kexec.
>
> To facilitate such test, along with the kernel driver responsible for
> data generation, preservation and restoration add a script that runs a
> kernel in a VM with a minimal /init. The /init enables KHO, loads a
> kernel image for kexec and runs kexec reboot. After the boot of the
> kexeced kernel, the driver verifies that the data was properly
> preserved.

Nice! Thanks for working on this.

I see that a lot of the driver assumes KHO cleans everything up on free.
That stops being true with Pasha' proposed LUO patches. The series also
gets rid of the notifier chain. So this test would need a bit of a
refactor once those patches land.

Other than this, I only have some minor comments below.

>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> v2 changes:
> * fix section mismatch warning in lib/test_kho.c
> * address Thomas' comments about nolibc and initrd generation
>
> v1: https://lore.kernel.org/all/20250727083733.2590139-1-rppt@kernel.org
>
[...
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> new file mode 100644
> index 000000000000..c2eb899c3b45
> --- /dev/null
> +++ b/lib/test_kho.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Test module for KHO
> + * Copyright (c) 2025 Microsoft Corporation.
> + *
> + * Authors:
> + *   Saurabh Sengar <ssengar@microsoft.com>
> + *   Mike Rapoport <rppt@kernel.org>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/mm.h>
> +#include <linux/gfp.h>
> +#include <linux/slab.h>
> +#include <linux/kexec.h>
> +#include <linux/libfdt.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kexec_handover.h>
> +
> +#include <net/checksum.h>
> +
> +#define KHO_TEST_MAGIC	0x4b484f21	/* KHO! */
> +#define KHO_TEST_FDT	"kho_test"
> +#define KHO_TEST_COMPAT "kho-test-v1"
> +
> +static long max_mem = (PAGE_SIZE << MAX_PAGE_ORDER) * 2;
> +module_param(max_mem, long, 0644);
> +
> +struct kho_test_state {
> +	unsigned int nr_folios;
> +	struct folio **folios;
> +	struct folio *fdt;
> +	__wsum csum;
> +};
> +
> +static struct kho_test_state kho_test_state;
> +
> +static int kho_test_notifier(struct notifier_block *self, unsigned long cmd,
> +			     void *v)
> +{
> +	struct kho_test_state *state = &kho_test_state;
> +	struct kho_serialization *ser = v;
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case KEXEC_KHO_ABORT:
> +		return NOTIFY_DONE;
> +	case KEXEC_KHO_FINALIZE:
> +		/* Handled below */
> +		break;
> +	default:
> +		return NOTIFY_BAD;
> +	}
> +
> +	err |= kho_preserve_folio(state->fdt);
> +	err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
> +
> +	return err ? NOTIFY_BAD : NOTIFY_DONE;
> +}
> +
> +static struct notifier_block kho_test_nb = {
> +	.notifier_call = kho_test_notifier,
> +};
> +
> +static int kho_test_save_data(struct kho_test_state *state, void *fdt)
> +{
> +	phys_addr_t *folios_info __free(kvfree) = NULL;
> +	int err = 0;
> +
> +	folios_info = kvmalloc_array(state->nr_folios, sizeof(*folios_info),
> +				     GFP_KERNEL);

Since you copy this data into the FDT anyway, why not use
fdt_property_placeholder() instead? You can just build the list directly
in the FDT then and avoid the memcpy().

> +	if (!folios_info)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < state->nr_folios; i++) {
> +		struct folio *folio = state->folios[i];
> +		unsigned int order = folio_order(folio);
> +
> +		folios_info[i] = virt_to_phys(folio_address(folio)) | order;

I did something similar for memfd preservation -- stashed some extra
data into the unused bits in the physical address. Perhaps we should
come up with a neat abstraction to do it more cleanly?

Not needed for this patch, just thinking out loud.

> +
> +		err = kho_preserve_folio(folio);
> +		if (err)
> +			return err;
> +	}
> +
> +	err |= fdt_begin_node(fdt, "data");
> +	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
> +			    sizeof(state->nr_folios));
> +	err |= fdt_property(fdt, "folios_info", folios_info,
> +			    state->nr_folios * sizeof(*folios_info));
> +	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
> +	err |= fdt_end_node(fdt);
> +
> +	return err;
> +}
> +
> +static int kho_test_prepare_fdt(struct kho_test_state *state)
> +{
> +	const char compatible[] = KHO_TEST_COMPAT;
> +	unsigned int magic = KHO_TEST_MAGIC;
> +	ssize_t fdt_size;
> +	int err = 0;
> +	void *fdt;
> +
> +	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
> +	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
> +	if (!state->fdt)
> +		return -ENOMEM;
> +
> +	fdt = folio_address(state->fdt);
> +
> +	err |= fdt_create(fdt, fdt_size);
> +	err |= fdt_finish_reservemap(fdt);
> +
> +	err |= fdt_begin_node(fdt, "");
> +	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
> +	err |= fdt_property(fdt, "magic", &magic, sizeof(magic));

Doesn't the compatible pretty much do what magic does? Instead of a
magic number, it is a "magic" string, no?

> +	err |= kho_test_save_data(state, fdt);
> +	err |= fdt_end_node(fdt);
> +
> +	err |= fdt_finish(fdt);
> +
> +	if (err)
> +		folio_put(state->fdt);
> +
> +	return err;
> +}
> +
> +static int kho_test_generate_data(struct kho_test_state *state)
> +{
> +	size_t alloc_size = 0;
> +	__wsum csum = 0;
> +
> +	while (alloc_size < max_mem) {
> +		int order = get_random_u32() % NR_PAGE_ORDERS;
> +		struct folio *folio;
> +		unsigned int size;
> +		void *addr;
> +
> +		/* cap allocation so that we won't exceed max_mem */
> +		if (alloc_size + (PAGE_SIZE << order) > max_mem) {
> +			order = get_order(max_mem - alloc_size);
> +			if (order)
> +				order--;

I'm guessing this is because get_order() rounds up, so you want to make
sure you don't exceed max_mem due to the rounding up. If so, a comment
would be nice here.

> +		}
> +		size = PAGE_SIZE << order;
> +
> +		folio = folio_alloc(GFP_KERNEL | __GFP_NORETRY, order);
> +		if (!folio)
> +			goto err_free_folios;
> +
> +		state->folios[state->nr_folios++] = folio;
> +		addr = folio_address(folio);
> +		get_random_bytes(addr, size);
> +		csum = csum_partial(addr, size, csum);
> +		alloc_size += size;
> +	}
> +
> +	state->csum = csum;
> +	return 0;
> +
> +err_free_folios:
> +	for (int i = 0; i < state->nr_folios; i++)
> +		folio_put(state->folios[i]);

Reset state->nr_folios as well? kho_test_cleanup() reads it.

> +	return -ENOMEM;
> +}
> +
> +static int kho_test_save(void)
> +{
> +	struct kho_test_state *state = &kho_test_state;
> +	struct folio **folios __free(kvfree) = NULL;

The __free causes a use-after-free and double-free in
kho_test_cleanup().

> +	unsigned long max_nr;
> +	int err;
> +
> +	max_mem = PAGE_ALIGN(max_mem);
> +	max_nr = max_mem >> PAGE_SHIFT;
> +
> +	folios = kvmalloc_array(max_nr, sizeof(*state->folios), GFP_KERNEL);
> +	if (!folios)
> +		return -ENOMEM;
> +	state->folios = folios;
> +
> +	err = kho_test_generate_data(state);
> +	if (err)
> +		return err;
> +
> +	err = kho_test_prepare_fdt(state);
> +	if (err)
> +		return err;
> +
> +	return register_kho_notifier(&kho_test_nb);
> +}
> +
> +static int kho_test_restore_data(const void *fdt, int node)
> +{
> +	const unsigned int *nr_folios;
> +	const phys_addr_t *folios_info;
> +	const __wsum *old_csum;
> +	__wsum csum = 0;
> +	int len;
> +
> +	node = fdt_path_offset(fdt, "/data");
> +
> +	nr_folios = fdt_getprop(fdt, node, "nr_folios", &len);
> +	if (!nr_folios || len != sizeof(*nr_folios))

Thinking out loud, this kind of pattern is repeated throughout the memfd
preservation code, and likely will be used by other users of KHO as
well. I suppose something like the proposed KSTATE mechanism would let
us abstract these away. Something for later down the line...

> +		return -EINVAL;
> +
> +	old_csum = fdt_getprop(fdt, node, "csum", &len);
> +	if (!old_csum || len != sizeof(*old_csum))
> +		return -EINVAL;
> +
> +	folios_info = fdt_getprop(fdt, node, "folios_info", &len);
> +	if (!folios_info || len != sizeof(*folios_info) * *nr_folios)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < *nr_folios; i++) {
> +		unsigned int order = folios_info[i] & ~PAGE_MASK;
> +		phys_addr_t phys = folios_info[i] & PAGE_MASK;
> +		unsigned int size = PAGE_SIZE << order;
> +		struct folio *folio;
> +
> +		folio = kho_restore_folio(phys);
> +		if (!folio)
> +			break;
> +
> +		if (folio_order(folio) != order)

Restore and put the rest of the folios as well so they aren't leaked?

> +			break;
> +
> +		csum = csum_partial(folio_address(folio), size, csum);
> +		folio_put(folio);
> +	}
> +
> +	if (csum != *old_csum)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int kho_test_restore(phys_addr_t fdt_phys)
> +{
> +	void *fdt = phys_to_virt(fdt_phys);
> +	const unsigned int *magic;
> +	int node, len, err;
> +
> +	node = fdt_path_offset(fdt, "/");
> +	if (node < 0)
> +		return -EINVAL;
> +
> +	if (fdt_node_check_compatible(fdt, node, KHO_TEST_COMPAT))
> +		return -EINVAL;
> +
> +	magic = fdt_getprop(fdt, node, "magic", &len);
> +	if (!magic || len != sizeof(*magic))
> +		return -EINVAL;
> +
> +	if (*magic != KHO_TEST_MAGIC)
> +		return -EINVAL;
> +
> +	err = kho_test_restore_data(fdt, node);
> +	if (err)
> +		return err;
> +
> +	pr_info("KHO restore succeeded\n");
> +	return 0;
> +}
> +
> +static int __init kho_test_init(void)
> +{
> +	phys_addr_t fdt_phys;
> +	int err;
> +
> +	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
> +	if (!err)
> +		return kho_test_restore(fdt_phys);
> +
> +	if (err != -ENOENT) {
> +		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);
> +		return err;
> +	}
> +
> +	return kho_test_save();
> +}
> +module_init(kho_test_init);
> +
> +static void kho_test_cleanup(void)
> +{
> +	for (int i = 0; i < kho_test_state.nr_folios; i++)
> +		folio_put(kho_test_state.folios[i]);
> +
> +	kvfree(kho_test_state.folios);

Free state->fdt as well?

> +}
> +
> +static void __exit kho_test_exit(void)
> +{
> +	unregister_kho_notifier(&kho_test_nb);
> +	kho_test_cleanup();
> +}
> +module_exit(kho_test_exit);
> +
> +MODULE_AUTHOR("Mike Rapoport <rppt@kernel.org>");
> +MODULE_DESCRIPTION("KHO test module");
[...]

-- 
Regards,
Pratyush Yadav

