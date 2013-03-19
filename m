Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI2Jt-0001yF-4I
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 19:35:37 +0000
Date: Tue, 19 Mar 2013 12:35:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 07/21] vmcore, procfs: introduce a flag to
 distinguish objects copied in 2nd kernel
Message-Id: <20130319123531.9777a366ff0e1611727405cd@linux-foundation.org>
In-Reply-To: <20130316040126.15064.67305.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040126.15064.67305.stgit@localhost6.localdomain6>
Mime-Version: 1.0
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
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, cpw@sgi.com, vgoyal@redhat.com

On Sat, 16 Mar 2013 13:01:26 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> The part of dump target memory is copied into the 2nd kernel if it
> doesn't satisfy mmap()'s page-size boundary requirement. To
> distinguish such copied object from usual old memory, a flag
> MEM_TYPE_CURRENT_KERNEL is introduced. If this flag is set, the object
> is considered being copied into buffer on the 2nd kernel.
> 

I don't understand this description at all :( Perhaps we can have a
lengthier version which expands on the concepts a bit further?

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -97,11 +97,17 @@ struct kcore_list {
>  	int type;
>  };
>  
> +#define MEM_TYPE_CURRENT_KERNEL 0x1

A comment describing this would be useful.

>  struct vmcore {
>  	struct list_head list;
> -	unsigned long long paddr;
> +	union {
> +		unsigned long long paddr;
> +		char *buf;
> +	};

This change wasn't described in the changelog?

>  	unsigned long long size;
>  	loff_t offset;
> +	unsigned int flag;

Presumably this is the place where we put MEM_TYPE_CURRENT_KERNEL? 
That's unobvious from reading the code.  Add the text "vmcore.flag
fields:" above the MEM_TYPE_CURRENT_KERNEL definition.


>  };
>  
>  #ifdef CONFIG_PROC_FS

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
