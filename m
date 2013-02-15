Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6NDG-0000rS-CE
 for kexec@lists.infradead.org; Fri, 15 Feb 2013 15:28:35 +0000
Date: Fri, 15 Feb 2013 10:28:28 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 04/13] vmcore: introduce types for objects copied in 2nd
 kernel
Message-ID: <20130215152828.GC27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101205.22466.5909.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130214101205.22466.5909.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Thu, Feb 14, 2013 at 07:12:05PM +0900, HATAYAMA Daisuke wrote:
> Some parts of old memory need to be copied in buffers on 2nd kernel to
> be remapped to user-space. To distinguish objects in the buffer on 2nd
> kernel and the ones on old memory, enum vmcore_type is introduced: the
> object in the buffer on 2nd kernel has VMCORE_2ND_KERNEL type, and the
> one on old memory has VMCORE_OLD_MEMORY type.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
> 
>  include/linux/proc_fs.h |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 32676b3..4b153ed 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -97,11 +97,20 @@ struct kcore_list {
>  	int type;
>  };
>  
> +enum vmcore_type {
> +	VMCORE_OLD_MEMORY,
> +	VMCORE_2ND_KERNEL,

This VMCORE_2ND_KERNEL tag looks bad.

How about introducing a "unsigned int flag" element in "struct vmcore"
and set the flag MEM_TYPE_OLDMEM for any contents which come from oldmem.

If MEM_TYPE_OLDMEM is not set, it is assumed that contents are to be
fetched from current kernel using pointer vmcore->buf.

BTW, which elements you need to copy from first kernel?

> +};
> +
>  struct vmcore {
>  	struct list_head list;
> -	unsigned long long paddr;
> +	union {
> +		unsigned long long paddr;
> +		char *buf;
> +	};
>  	unsigned long long size;
>  	loff_t offset;
> +	enum vmcore_type type;
>  };
>  

Thanks
Vivek

>  #ifdef CONFIG_PROC_FS

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
