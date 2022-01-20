From: Baoquan He <bhe@redhat.com>
Date: Thu, 20 Jan 2022 17:50:19 +0800
Subject: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
References: <20211206160514.2000-1-jszhang@kernel.org>
Message-ID: <20220120095019.GA4579@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> and increase compile coverage.

Only checked the x86 patch, but the whole patchset looks good to me,
thanks, Jisheng.

Acked-by: Baoquan He <bhe@redhat.com>

Maybe Andrew can help pick this whole series lest each patch need be taken
care of by its own ARCH maintainer.

> 
> I only modify x86, arm, arm64 and riscv, other architectures such as
> sh, powerpc and s390 are better to be kept kexec code as-is so they
> are not touched.
> 
> Since v1:
>  - collect Reviewed-by tag
>  - fix misleading commit msg.
> 
> Jisheng Zhang (5):
>   kexec: make crashk_res, crashk_low_res and crash_notes symbols always
>     visible
>   riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
>   x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
>   arm64: mm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
>   arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
> 
>  arch/arm/kernel/setup.c |  7 +++----
>  arch/arm64/mm/init.c    |  9 +++------
>  arch/riscv/mm/init.c    |  6 ++----
>  arch/x86/kernel/setup.c | 10 +++-------
>  include/linux/kexec.h   | 12 ++++++------
>  5 files changed, 17 insertions(+), 27 deletions(-)
> 
> -- 
> 2.34.1
> 


