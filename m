Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mndAt-007GC0-Hv
 for kexec@lists.infradead.org; Thu, 18 Nov 2021 08:53:46 +0000
Date: Thu, 18 Nov 2021 09:53:31 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] s390/kexec: fix kmemleak
Message-ID: <YZYUi9XMyjtpGmAQ@osiris>
References: <20211116032557.14075-2-bhe@redhat.com>
 <202111180539.e7kmpOSP-lkp@intel.com>
 <20211118071327.GF21646@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211118071327.GF21646@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, kbuild-all@lists.01.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, prudo@redhat.com

On Thu, Nov 18, 2021 at 03:13:27PM +0800, Baoquan He wrote:
> On 11/18/21 at 05:46am, kernel test robot wrote:
> >    arch/s390/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
> > >> arch/s390/kernel/machine_kexec_file.c:332:9: error: implicit declaration of function 'kvfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
> >      332 |         kvfree(image->arch.ipl_buf);
> >          |         ^~~~~~
> >          |         vfree
> 
> OK, kvfree is not wrong, seems vfree is more appropriate since it's
> clear the ipl_buf is allocated with zvalloc() in ipl_report_finish().
> 
> Hi Heiko,
> 
> Could you help modify the code in your tree or append below patch to
> mute the lkp complaint? Sorry for the inconvenience.
...
>  arch/s390/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 7f51837e9bc2..351a7ff69a43 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -329,7 +329,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  
>  int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  {
> -	kvfree(image->arch.ipl_buf);
> +	vfree(image->arch.ipl_buf);

The problem reported above indicates that slab.h was not
included. With your patch, while it fixes the problem for this
particular configuration, this requires vmalloc.h to be included.

I'll merge your patch and add the missing include as well.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
