Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZc0s-0004Pg-SO
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 08:13:11 +0000
Date: Mon, 14 Apr 2014 16:11:28 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140414081128.GB8084@dhcp-16-105.nay.redhat.com>
References: <20140410214433.GF18808@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
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
To: Arthur Zou <zzou@redhat.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, d hatayama <d.hatayama@jp.fujitsu.com>, kexec@lists.infradead.org, vgoyal@redhat.com

Hi Atsushi,

Since both of our test machines where this bug was reproduced are
reserved, I haven't tested this patch. But after several times of the
code flow of elf dump, finally this only this suspect is found.

Could you also help check this?

Also below change is OK too, and its meaning is more obvious. But my
previous patch is more readable for code.

int
calculate_cyclic_buffer_size(void) {
        unsigned long long free_size, needed_size;
 
        if (info->max_mapnr <= 0) {
                ERRMSG("Invalid max_mapnr(%llu).\n", info->max_mapnr);
                return FALSE;
        }
 
        /*
         * free_size will be used to allocate 1st and 2nd bitmap, so it
         * should be 40% of free memory to keep the size of cyclic
         * buffer
         * within 80% of free memory.
         */
        if (info->flag_elf_dumpfile) {
                free_size = get_free_memory_size() * 0.4 * 2;
                needed_size = (info->max_mapnr * 2) / BITPERBYTE;
        } else {
                free_size = get_free_memory_size() * 0.8;
                needed_size = info->max_mapnr / BITPERBYTE;
        }
 
        /* if --split was specified cyclic buffer allocated per dump
 * file */
        if (info->num_dumpfile > 1)                                                                                                                                                     
                needed_size /= info->num_dumpfile;
 
        info->bufsize_cyclic = (free_size <= needed_size) ? free_size/2 :
needed_size/2;
 
        return TRUE;
}

Thanks
Baoquan


On 04/14/14 at 04:02pm, Baoquan He wrote:
> In case elf dump, the code to calculate the cyclic buffer size is
> not correct. Since elf need bitmap1/2, so the needed memory for
> bufsize_cyclic need be double. Hence free size should be 40% of
> free memory, however the needed_size which free_size is compared
> with should be info->max_mapnr / BITPERBYTE, but not 2 times of it.
> 
> Because of this, in case of free memory in 2nd kernel is not too much,
> OOM will happen very often.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  makedumpfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 75092a8..01ec516 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -9010,7 +9010,7 @@ calculate_cyclic_buffer_size(void) {
>  	 */
>  	if (info->flag_elf_dumpfile) {
>  		free_size = get_free_memory_size() * 0.4;
> -		needed_size = (info->max_mapnr * 2) / BITPERBYTE;
> +		needed_size = info->max_mapnr / BITPERBYTE;
>  	} else {
>  		free_size = get_free_memory_size() * 0.8;
>  		needed_size = info->max_mapnr / BITPERBYTE;
> -- 
> 1.8.5.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
