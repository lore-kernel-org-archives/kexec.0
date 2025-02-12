Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7834BC02198
	for <kexec@archiver.kernel.org>; Wed, 12 Feb 2025 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TvPbFPdhs4rsZAIf9ArjWz0MAEl7abAALU3gmrYlJXw=; b=pjKEefO9zsdsdPA6Byc9UUGdsE
	z2f0PzkVUX3en83Mp+fJxZ1+D2hHirVSPaWp2nWMjYLVCdEdwDvn/O/Ykz5/EJt6kOD8qsHTzHp/q
	NUI9qJmRN2AsE3tCu8/1/nrv0DATjezdZfydwP3lU0opS/Pqo1ljyLMlnN3eu2eiMdaljcuyiWNeo
	f0BlpfzzglUwv5W43nqlIDLoHoEjQNBnUT0jDEGBX//NjZmjDdBQSWmR1dS7VYpUc5d6WFF5wBRPS
	UcF/14rYpeSAOiYxLujQVBOWFzc8Kiv3MKjfmDw6oEqv9TFtGUSc4EELM4gmC3Y5mJjwYdNVPuBrD
	IimuxOYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiBvV-00000007MTZ-2bIs;
	Wed, 12 Feb 2025 12:33:13 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiBrX-00000007Lsh-0x62;
	Wed, 12 Feb 2025 12:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739363341;
	bh=CQ3SUXjx0/f8m1n41c4a7SuLTF0PmDTDTSkoGsVR/Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPqGCMmKw9maDfoACsq5XCW1kNFM6USyJeTgaD0ZKnBDjJTzkCAXYBi0J0p/zs+gW
	 CqjmKFSFDdJ1G1DqeLIdoAIUzFk59nzTIK1L5fU/sV+967mEPcUqwhoHA45Q4Y6o++
	 DEc57IMn3o42I47CfAucVGa1HdoUC+cRjFDTaZ2E=
Date: Wed, 12 Feb 2025 13:29:00 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Pratyush Yadav <ptyadav@amazon.de>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Usama Arif <usama.arif@bytedance.com>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <ae80c1b9-bafb-401c-9789-37a774c702c0@t-8ch.de>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-6-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_042907_732754_A043A925 
X-CRM114-Status: GOOD (  25.44  )
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

On 2025-02-06 15:27:45+0200, Mike Rapoport wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> This patch adds the core infrastructure to generate Kexec HandOver
> metadata. Kexec HandOver is a mechanism that allows Linux to preserve
> state - arbitrary properties as well as memory locations - across kexec.
> 
> It does so using 2 concepts:
> 
>   1) Device Tree - Every KHO kexec carries a KHO specific flattened
>      device tree blob that describes the state of the system. Device
>      drivers can register to KHO to serialize their state before kexec.
> 
>   2) Scratch Regions - CMA regions that we allocate in the first kernel.
>      CMA gives us the guarantee that no handover pages land in those
>      regions, because handover pages must be at a static physical memory
>      location. We use these regions as the place to load future kexec
>      images so that they won't collide with any handover data.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-kernel-kho    |  53 +++
>  .../admin-guide/kernel-parameters.txt         |  24 +
>  MAINTAINERS                                   |   1 +
>  include/linux/cma.h                           |   2 +
>  include/linux/kexec.h                         |  18 +
>  include/linux/kexec_handover.h                |  10 +
>  kernel/Makefile                               |   1 +
>  kernel/kexec_handover.c                       | 450 ++++++++++++++++++
>  mm/internal.h                                 |   3 -
>  mm/mm_init.c                                  |   8 +
>  10 files changed, 567 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
>  create mode 100644 include/linux/kexec_handover.h
>  create mode 100644 kernel/kexec_handover.c

<snip>

> --- /dev/null
> +++ b/include/linux/kexec_handover.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_KEXEC_HANDOVER_H
> +#define LINUX_KEXEC_HANDOVER_H

#include <linux/types.h>

> +
> +struct kho_mem {
> +	phys_addr_t addr;
> +	phys_addr_t size;
> +};
> +
> +#endif /* LINUX_KEXEC_HANDOVER_H */

<snip>

> +static ssize_t dt_read(struct file *file, struct kobject *kobj,
> +		       struct bin_attribute *attr, char *buf,

Please make the bin_attribute argument const. Currently both work, but
the non-const variant will go away.
This way I can test my stuff on linux-next.

> +		       loff_t pos, size_t count)
> +{
> +	mutex_lock(&kho_out.lock);
> +	memcpy(buf, attr->private + pos, count);
> +	mutex_unlock(&kho_out.lock);
> +
> +	return count;
> +}
> +
> +struct bin_attribute bin_attr_dt_kern = __BIN_ATTR(dt, 0400, dt_read, NULL, 0);

The new __BIN_ATTR_ADMIN_RO() could make this slightly shorter.

<snip>

