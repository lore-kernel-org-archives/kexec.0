Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvrdo-0001kt-1a
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 00:20:49 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466093748.24747.4655547403463921814.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 07/12] ppc64/kexec_file: add support to relocate
 purgatory
In-reply-to: <159466093748.24747.4655547403463921814.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 21:20:31 -0300
Message-ID: <871rlc9upc.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> Right now purgatory implementation is only minimal. But if purgatory
> code is to be enhanced to copy memory to the backup region and verify

Can't the memcpy be done in asm? We have arch/powerpc/lib/memcpy_64.S
for example, perhaps it could be linked in with the purgatory?

> sha256 digest, relocations may have to be applied to the purgatory.

Do we want to do the sha256 verification? My original patch series for
kexec_file_load() had a purgatory in C from kexec-tools which did the
sha256 verification but Michael Ellerman thought it was unnecessary and
decided to use the simpler purgatory in asm from kexec-lite.

As a result, this relocation processing became unnecessary.

> So, add support to relocate purgatory in kexec_file_load system call
> by setting up TOC pointer and applying RELA relocations as needed.

If we do want to use a C purgatory, Michael Ellerman had suggested
building it as a Position Independent Executable, which greatly reduces
the number and types of relocations that are needed. See patches 4 and 9
here:

https://lore.kernel.org/linuxppc-dev/1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com/

In the series above I hadn't converted x86 to PIE. If I had done that,
possibly Dave Young's opinion would have been different. :-)

If that's still not desirable, he suggested in that discussion lifting
some code from x86 to generic code, which I implemented and would
simplify this patch as well:

https://lore.kernel.org/linuxppc-dev/5009580.5GxAkTrMYA@morokweng/

> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, 'struct mem_sym' was declared in parameter list]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> v2 -> v3:
> * Fixed get_toc_section() to return the section info that had relocations
>   applied, to calculate the correct toc pointer.
> * Fixed how relocation value is converted to relative while applying
>   R_PPC64_REL64 & R_PPC64_REL32 relocations.
>
> v1 -> v2:
> * Fixed wrong use of 'struct mem_sym' in local_entry_offset() as
>   reported by lkp. lkp report for reference:
>     - https://lore.kernel.org/patchwork/patch/1264421/
>
>
>  arch/powerpc/kexec/file_load_64.c      |  337 ++++++++++++++++++++++++++++++++
>  arch/powerpc/purgatory/trampoline_64.S |    8 +
>  2 files changed, 345 insertions(+)

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
