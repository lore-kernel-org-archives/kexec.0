Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aXtlA-0004pE-5B
 for kexec@lists.infradead.org; Mon, 22 Feb 2016 16:54:57 +0000
Date: Tue, 23 Feb 2016 00:58:17 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
Message-ID: <20160222165817.GA20170@dhcp-128-25.nay.redhat.com>
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

On 02/17/16 at 03:05pm, Zhou Wenjian wrote:
> The new implementation won't do the extra work for filtered pages any
> more. So the performance of -d 31 is close to that of serial processing.

Hi, Wenjian.

Command makedumpfile is complied with this patch on version 1.5.9, and
makedumpfile.backup is complied on version 1.5.7.

The compressed file vmcore is 67G filtered out from 4T memory.

kdump:/# time bash -x a.sh makedumpfile vmcore02 1 --num-threads 128
+ makedumpfile --num-threads -l --message-level 1 -d 31 /proc/vmcore /kdumproot/home//var/crash/127.0.0.1-2016-02-22-23:22:36/vmcore02
Copying data                       : [100.0 %] /

real    5m24.378s
user    2m3.572s
sys 0m57.133s
kdump:/# time bash -x a.sh makedumpfile vmcore04 1 --num-threads 0
+ makedumpfile --num-threads -l --message-level 1 -d 31 /proc/vmcore /kdumproot/home//var/crash/127.0.0.1-2016-02-22-23:22:36/vmcore04
Copying data                       : [100.0 %] /

real    5m17.519s
user    2m6.638s
sys 0m57.157s
kdump:/# time bash -x a.sh makedumpfile.backup vmcore05 1
+ makedumpfile.backup -l --message-level 1 -d 31 /proc/vmcore /kdumproot/home//var/crash/127.0.0.1-2016-02-22-23:22:36/vmcore05
Copying data                       : [100.0 %] \

real    5m51.227s
user    3m41.281s
sys 0m14.924s

Seem above test result reaches this goal. 

>  makedumpfile.c | 266 ++++++++++++++++++++++++++++++++++++++-------------------
>  makedumpfile.h |  31 ++++---
>  2 files changed, 200 insertions(+), 97 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index fa0b779..31329b5 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3562,8 +3563,10 @@ initial_for_parallel()
>  		      - MAP_REGION * info->num_threads) * 0.6;
>  
>  	page_data_num = limit_size / page_data_buf_size;

3562         limit_size = (get_free_memory_size()
3563                       - MAP_REGION * info->num_threads) * 0.6;

limit_size will get value from above calculation. It is better
to have a test before getting limit_size's value, since the value
from get_free_memory_size may be smaller than MAP_REGION * info->num_threads.

> +	for (i = 0; i < info->num_threads; i++) {
> +		if ((info->page_flag_buf[i] = calloc(1, sizeof(struct page_flag))) == NULL) {
> +			MSG("Can't allocate memory for page_flag. %s\n",
> +				strerror(errno));
> +			return FALSE;
> +		}
> +		current = info->page_flag_buf[i];
> +
> +		for (j = 1; j < NUM_BUFFERS; j++) {
> +			if ((current->next = calloc(1, sizeof(struct page_flag))) == NULL) {
> +				MSG("Can't allocate memory for page_flag. %s\n",
> +					strerror(errno));
> +				return FALSE;
> +			}
> +			current = current->next;
> +		}

Code will be more elegant and simple, if makedumpfile can
source the list.h.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
