Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFJ7W-0006kj-9u
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 09:36:54 +0000
Date: Wed, 15 Jul 2015 17:36:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3] kexec: refactor CONFIG_KEXEC/CONFIG_KEXEC_FILE Kconfig
Message-ID: <20150715093623.GC5424@dhcp-128-92.nay.redhat.com>
References: <20150713021353.282890552@redhat.com>
 <20150715091607.GB5424@dhcp-128-92.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150715091607.GB5424@dhcp-128-92.nay.redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: jwboyer@fedoraproject.org, tytso@mit.edu, ptesarik@suse.cz, dhowells@redhat.com, ebiederm@xmission.com, vgoyal@redhat.com

On 07/15/15 at 05:16pm, Dave Young wrote:
> On 07/13/15 at 10:13am, Dave Young wrote:
> > Previously Theodore Ts'o brought up an issue about kexec_load syscall bypassing
> > signature verification:
> > https://lkml.org/lkml/2015/6/14/280
> > 
> > Because we have two kexec load syscall, one kexec_load, another kexec_file_load,
> > the latter one was introduced by Vivek Goyal, it is mainly for supporting UEFI
> > secure boot. kexec_file_load verifies kernel signature, but even if with
> > CONFIG_KEXEC_VERIFY_SIG=y and CONFIG_KEXEC_FILE=y, kexec-tools still can use
> > old syscall and bypass signature verification.
> > 
> > KEXEC_FILE can also be used without UEFI, so kexec can always verify kernel
> > signature for security purpose. 
> > 
> > The suggestion in above thread is add a new Kconfig option for kexec common
> > code, here I use KEXEC_CORE, KEXEC and KEXEC_FILE select KEXEC_CORE so one can
> > compile only KEXEC_FILE without old kexec_load syscall.
> > 
> > There's checkpatch warnings and errors, I would like to send furthuer cleanup
> > patches after this series. Please let me know if you have other suggestions.
> > checkpatch errors are for cases such as assign a value to static variables.
> > 
> > PATCH 3/3 can be sort out from the series if people do not like. It is a
> > cleanup for a macro.
> 
> Since it is not related to the Kconfig cleanup thus I will drop it in
> next update, will send out as a standalone patch later.
> 
> Also there's a kexec-tools patch needed for testing KEXEC_FILE only, I forgot
> to mention, will take it in cover letter when I repost:

BTW, it is the case below:
kernel: CONFIG_KEXEC_FILE only,
kexec-tools: do not use '-s' option, it should check kexec_load(2) earlier
and fail out. but below code is still a fix to a code problem. 

kexec -s -p work ok without the fix.

> 
> ---
>  kexec/crashdump-elf.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- kexec-tools.orig/kexec/crashdump-elf.c
> +++ kexec-tools/kexec/crashdump-elf.c
> @@ -145,11 +145,12 @@ int FUNC(struct kexec_info *info,
>  
>  	count_cpu = nr_cpus;
>  	for (i = 0; count_cpu > 0; i++) {
> -		if (get_note_info(i, &notes_addr, &notes_len) < 0) {
> -			/* This cpu is not present. Skip it. */
> -			continue;
> -		}
> +		int ret;
> +
> +		ret = get_note_info(i, &notes_addr, &notes_len);
>  		count_cpu--;
> +		if (ret < 0) /* This cpu is not present. Skip it. */
> +			continue;
>  
>  		phdr = (PHDR *) bufp;
>  		bufp += sizeof(PHDR);
> 
> Thanks
> Dave
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
