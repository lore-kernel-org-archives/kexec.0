Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x234.google.com ([2a00:1450:400c:c05::234])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDGhJ-0004jD-5g
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 15:56:05 +0000
Received: by mail-wi0-f180.google.com with SMTP id hi8so364079wib.7
 for <kexec@lists.infradead.org>; Wed, 06 Mar 2013 07:56:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130302083622.31252.38843.stgit@localhost6.localdomain6>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083622.31252.38843.stgit@localhost6.localdomain6>
Date: Wed, 6 Mar 2013 23:55:58 +0800
Message-ID: <CANBD6kF=B7UqxaoxY_Uhua2m7nQnXf2Xk_hWMCZcP6_0vcLpsQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] vmcore, procfs: introduce a flag to distinguish
 objects copied in 2nd kernel
From: Yanfei Zhang <zhangyanfei.yes@gmail.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

2013/3/2 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>:
> The part of dump target memory is copied into the 2nd kernel if it
> doesn't satisfy mmap()'s page-size boundary requirement. To
> distinguish such copied object from usual old memory, a flag
> MEM_TYPE_CURRENT_KERNEL is introduced. If this flag is set, the object
> is considered being copied into buffer on the 2nd kernel.

Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>
>  include/linux/proc_fs.h |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 8307f2f..11dd592 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -97,11 +97,17 @@ struct kcore_list {
>         int type;
>  };
>
> +#define MEM_TYPE_CURRENT_KERNEL 0x1
> +
>  struct vmcore {
>         struct list_head list;
> -       unsigned long long paddr;
> +       union {
> +               unsigned long long paddr;
> +               char *buf;
> +       };
>         unsigned long long size;
>         loff_t offset;
> +       unsigned int flag;
>  };
>
>  #ifdef CONFIG_PROC_FS
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
