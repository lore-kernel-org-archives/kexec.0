Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3DtE-00071H-7a
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 05:22:05 +0000
Received: by mail-lf1-f68.google.com with SMTP id r4-v6so10355392lff.12
 for <kexec@lists.infradead.org>; Thu, 20 Sep 2018 22:21:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
References: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 21 Sep 2018 10:51:49 +0530
Message-ID: <CACi5LpMPZiv7zgZLR9SD=2SPPT8W3RuP6=NHD4rzqVnpB4xkaA@mail.gmail.com>
Subject: Re: [PATCHv2] kernel: kexec_file: remove some duplicated include file
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
To: zhong jiang <zhongjiang@huawei.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

On Fri, Sep 21, 2018 at 8:18 AM, zhong jiang <zhongjiang@huawei.com> wrote:
> We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
> hence just remove them.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index c6a3b68..35cf0ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,8 +25,6 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
> -#include <linux/kexec.h>
> -#include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> --
> 1.7.12.4
>

Nice catch.
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

BTW while we are at it, can you also send out a separate patch to list the
include files in this file (i.e. kexec_file.c) alphabetically (similar
to other linux source files - see
<https://patchwork.kernel.org/patch/10258279/> for example). Something
like:

#include <crypto/hash.h>
#include <crypto/sha.h>
#include <linux/capability.h>
#include <linux/elf.h>
#include <linux/elfcore.h>
#include <linux/file.h>
#include <linux/fs.h>
#include <linux/ima.h>
#include <linux/kernel.h>
#include <linux/kexec.h>
#include <linux/list.h>
#include <linux/mm.h>
#include <linux/mutex.h>
#include <linux/slab.h>
#include <linux/syscalls.h>
#include <linux/vmalloc.h>
#include "kexec_internal.h"

This will improve readability and also reduce similar instances of
include files being added twice in this source file in future.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
