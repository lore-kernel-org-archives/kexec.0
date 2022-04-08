From: Michal =?unknown-8bit?q?Such=C3=A1nek?= <msuchanek@suse.de>
Date: Fri, 8 Apr 2022 10:51:20 +0200
Subject: [PATCH 0/4] Unifrom keyring support across architectures and
 functions
In-Reply-To: <20220408074704.wkyyv2qnx66iinzo@Rk>
References: <cover.1644953683.git.msuchanek@suse.de>
 <20220408074704.wkyyv2qnx66iinzo@Rk>
Message-ID: <20220408085120.GV163591@kunlun.suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 08, 2022 at 03:47:04PM +0800, Coiby Xu wrote:
> Hi Michal,
> 
> As mentioned by Baoquan, I have a patch set "[PATCH v5 0/3] use more
> system keyrings to verify arm64 kdump kernel image signature" [1]. The
> differences between your patch set and mine are as follows,  - my patch set
> only adds support for arm64 while yours also extends to
>    s390
>  - I made the code for verifying signed kernel image as PE file in x86
>    public so arm64 can reuse the code as well which seems to be better
>    approach
>  - I also cleaned up clean up arch_kexec_kernel_verify_sig
> 
> Would you mind if I integrate your first 3 patches with mine as follows
>  - for arm64, I'll use my version
>  - for s390, I'll use your version

Great

less code duplication is always good.

Thanks

Michal

> 
> For your last patch which allows to use of platform keyring for
> signature verification of kernel module, I'll leave it to yourself. How
> do you think about it?
> 
> 
> [1] https://lore.kernel.org/all/20220401013118.348084-1-coxu at redhat.com/
> 
> On Tue, Feb 15, 2022 at 08:39:37PM +0100, Michal Suchanek wrote:
> > While testing KEXEC_SIG on powerpc I noticed discrepancy in support for
> > different keyrings across architectures and between KEXEC_SIG and
> > MODULE_SIG. Fix this by enabling suport for the missing keyrings.
> > 
> > The latter two patches obviously conflict with the ongoing module code
> > cleanup. If they turn out desirable I will add them to the other series
> > dealing with KEXEC_SIG.
> > 
> > The arm patches can be merged independently.
> > 
> > Thanks
> > 
> > Michal
> > 
> > Michal Suchanek (4):
> >  Fix arm64 kexec forbidding kernels signed with keys in the secondary
> >    keyring to boot
> >  kexec, KEYS, arm64: Make use of platform keyring for signature
> >    verification
> >  kexec, KEYS, s390: Make use of built-in and secondary keyring for
> >    signature verification
> >  module, KEYS: Make use of platform keyring for signature verification
> > 
> > arch/arm64/kernel/kexec_image.c       | 13 +++++++++++--
> > arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> > kernel/module_signing.c               | 14 ++++++++++----
> > 3 files changed, 34 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Best regards,
> Coiby
> 

