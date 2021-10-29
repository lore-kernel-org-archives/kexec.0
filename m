Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usb-smtp-delivery-124.mimecast.com ([170.10.153.124]
 helo=us-smtp-delivery-124.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgOER-00AUbZ-EM
 for kexec@lists.infradead.org; Fri, 29 Oct 2021 09:31:28 +0000
Date: Fri, 29 Oct 2021 17:31:07 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_dump: fix boolreturn.cocci warning
Message-ID: <20211029093107.GK27625@MiWiFi-R3L-srv>
References: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
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
To: cgel.zte@gmail.com
Cc: dyoung@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Changcheng Deng <deng.changcheng@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>

On 10/20/21 at 08:39am, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> ./include/linux/crash_dump.h: 119: 50-51: WARNING: return of 0/1 in
> function 'is_kdump_kernel' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  include/linux/crash_dump.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0c547d866f1e..979c26176c1d 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -116,7 +116,7 @@ extern void register_vmcore_cb(struct vmcore_cb *cb);
>  extern void unregister_vmcore_cb(struct vmcore_cb *cb);
>  
>  #else /* !CONFIG_CRASH_DUMP */
> -static inline bool is_kdump_kernel(void) { return 0; }
> +static inline bool is_kdump_kernel(void) { return false; }
>  #endif /* CONFIG_CRASH_DUMP */
>  
>  /* Device Dump information to be filled by drivers */
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
