Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf9cd-00018Q-3h
 for kexec@lists.infradead.org; Wed, 22 May 2013 14:02:32 +0000
Date: Wed, 22 May 2013 10:01:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v7 2/8] vmcore: allocate buffer for ELF headers on
 page-size alignment
Message-ID: <20130522140142.GD5332@redhat.com>
References: <20130522025410.12215.16793.stgit@localhost6.localdomain6>
 <20130522025543.12215.27624.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130522025543.12215.27624.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

On Wed, May 22, 2013 at 11:55:43AM +0900, HATAYAMA Daisuke wrote:

[..]
>  /* Sets offset fields of vmcore elements. */
> -static void __init set_vmcore_list_offsets_elf64(char *elfptr,
> +static void __init set_vmcore_list_offsets_elf64(char *elfptr, size_t elfsz,
>  						struct list_head *vc_list)
>  {
>  	loff_t vmcore_off;
> @@ -469,8 +472,7 @@ static void __init set_vmcore_list_offsets_elf64(char *elfptr,
>  	ehdr_ptr = (Elf64_Ehdr *)elfptr;
>  
>  	/* Skip Elf header and program headers. */
> -	vmcore_off = sizeof(Elf64_Ehdr) +
> -			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr);
> +	vmcore_off = elfsz;

As you are passing in size of elf headers, I think some of the code
has become redundant in this function. (ehdr_ptr = (Elf64_Ehdr *)elfptr;).
We can remove it and now we should be able to merge
set_vmcore_list_offsets_elf32() and set_vmcore_list_offsets_elf64()
functions.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
