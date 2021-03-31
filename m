Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [RFC v2 01/43] mm: add PKRAM API stubs and Kconfig
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
 <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b7c635e2-e607-03bb-30f4-66bd00bff69e@infradead.org>
Date: Wed, 31 Mar 2021 11:43:52 -0700
MIME-Version: 1.0
In-Reply-To: <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
Content-Language: en-US
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
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

On 3/30/21 2:35 PM, Anthony Yznaga wrote:
> Preserved-across-kexec memory or PKRAM is a method for saving memory
> pages of the currently executing kernel and restoring them after kexec
> boot into a new one. This can be utilized for preserving guest VM state,
> large in-memory databases, process memory, etc. across reboot. While
> DRAM-as-PMEM or actual persistent memory could be used to accomplish
> these things, PKRAM provides the latency of DRAM with the flexibility
> of dynamically determining the amount of memory to preserve.
> 
...

> 
> Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/pkram.h |  47 +++++++++++++
>  mm/Kconfig            |   9 +++
>  mm/Makefile           |   1 +
>  mm/pkram.c            | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 include/linux/pkram.h
>  create mode 100644 mm/pkram.c
> 
> diff --git a/mm/pkram.c b/mm/pkram.c
> new file mode 100644
> index 000000000000..59e4661b2fb7
> --- /dev/null
> +++ b/mm/pkram.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/err.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/pkram.h>
> +#include <linux/types.h>
> +

Hi,

There are several doc blocks that begin with "/**" but that are not
in kernel-doc format (/** means kernel-doc format when inside the kernel
source tree).

Please either change those to "/*" or convert them to kernel-doc format.
The latter is preferable for exported interfaces.

> +/**
> + * Create a preserved memory node with name @name and initialize stream @ps
> + * for saving data to it.
> + *
> + * @gfp_mask specifies the memory allocation mask to be used when saving data.
> + *
> + * Returns 0 on success, -errno on failure.
> + *
> + * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
> + * case of failure) is to be called.
> + */


b) from patch 00/43:

 documentation/core-api/xarray.rst       |    8 +

How did "documentation" become lower case (instead of Documentation)?


thanks.
-- 
~Randy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
