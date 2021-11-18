Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnbc4-0072MF-Vk
 for kexec@lists.infradead.org; Thu, 18 Nov 2021 07:13:43 +0000
Date: Thu, 18 Nov 2021 15:13:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 2/2] s390/kexec: fix kmemleak
Message-ID: <20211118071327.GF21646@MiWiFi-R3L-srv>
References: <20211116032557.14075-2-bhe@redhat.com>
 <202111180539.e7kmpOSP-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202111180539.e7kmpOSP-lkp@intel.com>
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
To: hca@linux.ibm.com, kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, kbuild-all@lists.01.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, prudo@redhat.com

On 11/18/21 at 05:46am, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on s390/features]
> [also build test ERROR on linux/master linus/master v5.16-rc1 next-20211117]
> [cannot apply to kvms390/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/s390-kexec-check-the-return-value-of-ipl_report_finish/20211116-112827
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: s390-allmodconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/d5463ab680d37f95b493b71c487a51c039dfe845
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Baoquan-He/s390-kexec-check-the-return-value-of-ipl_report_finish/20211116-112827
>         git checkout d5463ab680d37f95b493b71c487a51c039dfe845
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/s390/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
> >> arch/s390/kernel/machine_kexec_file.c:332:9: error: implicit declaration of function 'kvfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
>      332 |         kvfree(image->arch.ipl_buf);
>          |         ^~~~~~
>          |         vfree

OK, kvfree is not wrong, seems vfree is more appropriate since it's
clear the ipl_buf is allocated with zvalloc() in ipl_report_finish().

Hi Heiko,

Could you help modify the code in your tree or append below patch to
mute the lkp complaint? Sorry for the inconvenience.


From 8ff5547d0b31093bb361328bc9df8bf19e96155a Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Thu, 18 Nov 2021 14:37:53 +0800
Subject: [PATCH] s390/kexec: use vfree to free memory from vmalloc

Since it's clear that memory is allocated with vzalloc in ipl_report_finish(),
let's use vfree to free the memory instead since it's more efficient than
kvfree.

This fixes the warning reported by lkp.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 7f51837e9bc2..351a7ff69a43 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -329,7 +329,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	kvfree(image->arch.ipl_buf);
+	vfree(image->arch.ipl_buf);
 	image->arch.ipl_buf = NULL;
 
 	return kexec_image_post_load_cleanup_default(image);
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
