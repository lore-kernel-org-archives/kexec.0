Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R4Gxe-0002TP-PT
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 18:46:59 +0000
Date: Thu, 15 Sep 2011 14:46:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
Message-ID: <20110915184637.GF32658@redhat.com>
References: <20110909102659.320220628@linux.vnet.ibm.com>
	<20110909102732.497569031@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110909102732.497569031@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Fri, Sep 09, 2011 at 12:27:00PM +0200, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> Currently the vmcoreinfo note is only initialized in case of kdump. On s390
> it is possible to create kernel dumps with other dump mechanisms than kdump
> (e.g. via hypervisor dump or stand-alone dump tools).

Both of these will be invoked through panic notifiers because kdump kernel
is not loaded?

>For those dumps it
> would also be desirable to include the vmcoreinfo data.

Curious that how these two dump schemes make use vmcoreinfo data?

> To accomplish this,
> with this patch the vmcoreinfo ELF note is always initialized, not only in
> case of a (kdump) crash. On s390 we will add an ABI defined pointer at
> a well known address to vmcoreinfo so that dump analysis tools are able to
> find this information.

Instead of this, why don't you initialize the notes in your arch specific
call. IOW, why don't you give a call to crash_save_vmcoreinfo() in stand
alone dump path to prepare the note and then continue with stand alone
dump.

Thanks
Vivek

> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  kernel/kexec.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1392,24 +1392,23 @@ int __init parse_crashkernel(char 		 *cm
>  }
>  
>  
> -
> -void crash_save_vmcoreinfo(void)
> +static void update_vmcoreinfo_note(void)
>  {
> -	u32 *buf;
> +	u32 *buf = (u32 *) vmcoreinfo_note;
>  
>  	if (!vmcoreinfo_size)
>  		return;
> -
> -	vmcoreinfo_append_str("CRASHTIME=%ld", get_seconds());
> -
> -	buf = (u32 *)vmcoreinfo_note;
> -
>  	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
>  			      vmcoreinfo_size);
> -
>  	final_note(buf);
>  }
>  
> +void crash_save_vmcoreinfo(void)
> +{
> +	vmcoreinfo_append_str("CRASHTIME=%ld", get_seconds());
> +	update_vmcoreinfo_note();
> +}
> +
>  void vmcoreinfo_append_str(const char *fmt, ...)
>  {
>  	va_list args;
> @@ -1495,6 +1494,7 @@ static int __init crash_save_vmcoreinfo_
>  	VMCOREINFO_NUMBER(PG_swapcache);
>  
>  	arch_crash_save_vmcoreinfo();
> +	update_vmcoreinfo_note();
>  
>  	return 0;
>  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
