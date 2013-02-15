Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6N9u-0000c2-E6
 for kexec@lists.infradead.org; Fri, 15 Feb 2013 15:25:06 +0000
Date: Fri, 15 Feb 2013 10:01:25 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/13] vmcore: allocate buffer for ELF headers on
 page-size alignment
Message-ID: <20130215150125.GA27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101148.22466.97735.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130214101148.22466.97735.stgit@localhost6.localdomain6>
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

On Thu, Feb 14, 2013 at 07:11:48PM +0900, HATAYAMA Daisuke wrote:

[..]

I think it is a good idea to copy andrew morton for this patch series.
Generally he is the one who pulls in all the kexec/kdump related patches.

> ---
> 
>  fs/proc/vmcore.c |   30 +++++++++++++++++++++---------
>  1 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 0d5071d..85714c3 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -30,6 +30,7 @@ static LIST_HEAD(vmcore_list);
>  /* Stores the pointer to the buffer containing kernel elf core headers. */
>  static char *elfcorebuf;
>  static size_t elfcorebuf_sz;
> +static size_t elfcorebuf_sz_orig;
>  
>  /* Total size of vmcore file. */
>  static u64 vmcore_size;
> @@ -560,26 +561,31 @@ static int __init parse_crash_elf64_headers(void)
>  
>  	/* Read in all elf headers. */
>  	elfcorebuf_sz = sizeof(Elf64_Ehdr) + ehdr.e_phnum * sizeof(Elf64_Phdr);
> -	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
> +	elfcorebuf_sz_orig = elfcorebuf_sz;
> +	elfcorebuf = (void *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +					       get_order(elfcorebuf_sz));
							    ^^^
Just a minor nit. Can you use elfcorebuf_sz_orig instead of elfcorebuf_sz
for allocation. This just makes it inline with free_pages() later.
elfcorebuf_sz_orig size pages are allocated and same size is freed.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
