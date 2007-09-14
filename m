Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out.google.com ([216.239.45.13])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IW1zM-0002T4-8N
	for kexec@lists.infradead.org; Thu, 13 Sep 2007 23:37:07 -0400
Date: Thu, 13 Sep 2007 20:36:42 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 2/4] [-mm patch] Add nodemask_t's size and NR_FREE_PAGES's
	value to vmcoreinfo_data.
In-Reply-To: <46E9F854.9030804@mxs.nes.nec.co.jp>
Message-ID: <alpine.DEB.0.9999.0709132034540.30494@chino.kir.corp.google.com>
References: <46E9F6A9.8060500@mxs.nes.nec.co.jp>
	<46E9F854.9030804@mxs.nes.nec.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec-ml <kexec@lists.infradead.org>, Adrian Bunk <bunk@kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, 14 Sep 2007, Ken'ichi Ohmichi wrote:

> diff -rpuN a/include/linux/kexec.h b/include/linux/kexec.h
> --- a/include/linux/kexec.h	2007-09-10 23:28:42.000000000 +0900
> +++ b/include/linux/kexec.h	2007-09-10 23:29:52.000000000 +0900
> @@ -132,11 +132,16 @@ unsigned long paddr_vmcoreinfo_note(void
>  #define SIZE(name) \
>  	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
>  			      (unsigned long)sizeof(struct name))
> +#define TYPEDEF_SIZE(name) \
> +	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
> +			      (unsigned long)sizeof(name))
>   #define OFFSET(name, field) \
>  	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
>  			      (unsigned long)&(((struct name *)0)->field))
>  #define LENGTH(name, value) \
>  	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
> +#define NUMBER(name) \
> +	vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>  #define CONFIG(name) \
>  	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
> 

The #define SIZE() should be renamed STRUCT_SIZE() since it's always 
returning the size of the struct with a given name.  This would allow 
TYPEDEF_SIZE() to simply become SIZE() since it need not be used 
exclusively for typedefs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
