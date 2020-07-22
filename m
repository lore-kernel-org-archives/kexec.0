Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2] helo=ozlabs.org)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy6Jw-0001N0-NB
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 04:25:33 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 07/12] ppc64/kexec_file: add support to relocate
 purgatory
In-Reply-To: <159524956457.20855.12480643681198700190.stgit@hbathini.in.ibm.com>
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524956457.20855.12480643681198700190.stgit@hbathini.in.ibm.com>
Date: Wed, 22 Jul 2020 14:25:19 +1000
Message-ID: <871rl4rxao.fsf@mpe.ellerman.id.au>
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
To: Hari Bathini <hbathini@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

Hari Bathini <hbathini@linux.ibm.com> writes:
> Right now purgatory implementation is only minimal. But if purgatory
> code is to be enhanced to copy memory to the backup region and verify
> sha256 digest, relocations may have to be applied to the purgatory.
> So, add support to relocate purgatory in kexec_file_load system call
> by setting up TOC pointer and applying RELA relocations as needed.
>
> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, 'struct mem_sym' was declared in parameter list]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> * Michael, can you share your opinion on the below:
>     - https://lore.kernel.org/patchwork/patch/1272027/
>     - My intention in cover note.

It seems like a lot of complexity for little benefit.

AFAICS your final purgatory_64.c is only 36 lines, and all it does is a
single (open coded) memcpy().

It seems like we could write that in not many more lines of assembler
and avoid all this code.

What am I missing?

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
