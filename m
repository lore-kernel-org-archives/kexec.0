Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lObuq-00EF9h-9g
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 07:57:30 +0000
Date: Tue, 23 Mar 2021 15:57:15 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] include: linux: Remove duplicate include of pgtable.h
Message-ID: <20210323075715.GA13786@MiWiFi-R3L-srv>
References: <20210323031352.258587-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323031352.258587-1-wanjiabing@vivo.com>
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
To: Wan Jiabing <wanjiabing@vivo.com>
Cc: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kael_w@yeah.net

On 03/23/21 at 11:13am, Wan Jiabing wrote:
> linux/pgtable.h has been included at line 11 with annotation.
> So we remove the duplicate one at line 8.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks for your posting. But this resend is still not good. I have
pasted the suggested log, wondering why you just ignore it and send v2
without updating, and also not marking this is v2. Please read
Documentation/process/submitting-patches.rst before you post next time.
Anyway, I have ack-ed Tian Tao's patch since his patch log is good
enough.

Thanks
Baoquan

> ---
>  include/linux/crash_dump.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index a5192b718dbe..be79a45d7aa3 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -5,7 +5,6 @@
>  #include <linux/kexec.h>
>  #include <linux/proc_fs.h>
>  #include <linux/elf.h>
> -#include <linux/pgtable.h>
>  #include <uapi/linux/vmcore.h>
>  
>  #include <linux/pgtable.h> /* for pgprot_t */
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
