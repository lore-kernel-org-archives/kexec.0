Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOf8H-0001d6-KK
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 02:47:19 +0000
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Tue, 24 Sep 2013 20:46:55 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EDDC93E4003E
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 20:46:52 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8P2kq3L314300
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 20:46:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8P2koAX032325
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 20:46:51 -0600
Message-ID: <52424E91.6020409@in.ibm.com>
Date: Wed, 25 Sep 2013 08:16:41 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/ppc: Check for a uImage initrd with ELF kernel
References: <20130924052302.4574.87561.stgit@localhost.localdomain>
In-Reply-To: <20130924052302.4574.87561.stgit@localhost.localdomain>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Athira Rajeev <atrajeev@in.ibm.com>

On 09/24/2013 10:53 AM, Athira Rajeev wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> We should check if the initrd is in uImage format, when
> the kernel might be in ELF.
> 
> Signed-off-by : Suzuki K Poulose <suzuki@in.ibm.com>
> Signed-off-by : Athira Rajeev<atrajeev@in.ibm.com>

Simon,

Please pull this one as well. Lets a user choose any combination of
Kernel/Initrd.

Suzuki

> ---
> 
>  kexec/arch/ppc/kexec-elf-ppc.c |    2 +-
>  kexec/arch/ppc/kexec-ppc.h     |    3 +++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
> index 98cae9c..df1b521 100644
> --- a/kexec/arch/ppc/kexec-elf-ppc.c
> +++ b/kexec/arch/ppc/kexec-elf-ppc.c
> @@ -371,7 +371,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>  	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, kernel_addr, &dtb_addr);
> 
>  	if (ramdisk) {
> -		seg_buf = slurp_file(ramdisk, &seg_size);
> +		seg_buf = slurp_ramdisk_ppc(ramdisk, &seg_size);
>  		/* load the ramdisk *above* the device tree */
>  		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
>  				0, dtb_addr + blob_size + 1,  max_addr, -1);
> diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
> index 68728c6..904cf48 100644
> --- a/kexec/arch/ppc/kexec-ppc.h
> +++ b/kexec/arch/ppc/kexec-ppc.h
> @@ -78,4 +78,7 @@ extern int read_memory_region_limits(int fd, unsigned long long *start,
>  #define COMMAND_LINE_SIZE	512 /* from kernel */
>  /*fs2dt*/
>  void reserve(unsigned long long where, unsigned long long length);
> +
> +/* Defined kexec-uImage-ppc.c */
> +extern char* slurp_ramdisk_ppc(const char *filename, off_t *r_size);
>  #endif /* KEXEC_PPC_H */
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
