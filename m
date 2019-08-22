Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i0ipN-0002he-2g
 for kexec@lists.infradead.org; Thu, 22 Aug 2019 08:52:19 +0000
Date: Thu, 22 Aug 2019 10:52:11 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] Limit the size of vmcore-dmesg.txt to 2G
Message-ID: <20190822085211.j2y736chwesxga4l@verge.net.au>
References: <20190815033756.15587-1-lijiang@redhat.com>
 <20190815033756.15587-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190815033756.15587-3-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: kasong@redhat.com, piliu@redhat.com, bhsharma@redhat.com, kexec@lists.infradead.org, junw99@yahoo.com, bhe@redhat.com, dyoung@redhat.com

On Thu, Aug 15, 2019 at 11:37:56AM +0800, Lianbo Jiang wrote:
> With some corrupted vmcore files, the vmcore-dmesg.txt file may grow
> forever till the kdump disk becomes full, and also probably causes
> the disk error messages as follow:
> ...
> sd 0:0:0:0: [sda] tag#6 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 0:0:0:0: [sda] tag#6 CDB: Read(10) 28 00 08 06 4c 98 00 00 08 00
> blk_update_request: I/O error, dev sda, sector 134630552
> sd 0:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 0:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 08 06 4c 98 00 00 08 00
> blk_update_request: I/O error, dev sda, sector 134630552
> ...
> 
> If vmcore-dmesg.txt occupies the whole disk, the vmcore can not be
> saved, this is also a problem.
> 
> Lets limit the size of vmcore-dmesg.txt to avoid such problems.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>

Thanks, this looks good to me.

Please repost this patch with an updated version of Patch 1/2.

> ---
>  vmcore-dmesg/vmcore-dmesg.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index ff0d540c9130..5ada3566972b 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -1,8 +1,18 @@
>  #include <elf_info.h>
>  
> +/* stole this macro from kernel printk.c */
> +#define LOG_BUF_LEN_MAX (uint32_t)(1 << 31)
> +
>  static void write_to_stdout(char *buf, unsigned int nr)
>  {
>  	ssize_t ret;
> +	static uint32_t n_bytes = 0;
> +
> +	n_bytes += nr;
> +	if (n_bytes > LOG_BUF_LEN_MAX) {
> +		fprintf(stderr, "The vmcore-dmesg.txt over 2G in size is not supported.\n");
> +		exit(55);
> +	}
>  
>  	ret = write(STDOUT_FILENO, buf, nr);
>  	if (ret != nr) {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
