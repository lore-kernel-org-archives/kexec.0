Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csSAZ-0003uD-7X
 for kexec@lists.infradead.org; Mon, 27 Mar 2017 10:46:40 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH v4 3/5] powerpc/fadump: remove dependency with
 CONFIG_KEXEC
In-Reply-To: <149035343956.6881.1536459326017709354.stgit@hbathini.in.ibm.com>
References: <149035332237.6881.9486330442785822384.stgit@hbathini.in.ibm.com>
 <149035343956.6881.1536459326017709354.stgit@hbathini.in.ibm.com>
Date: Mon, 27 Mar 2017 21:46:12 +1100
Message-ID: <87shlzdmkr.fsf@concordia.ellerman.id.au>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> Now that crashkernel parameter parsing and vmcoreinfo related code is
> moved under CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE, remove
> dependency with CONFIG_KEXEC for CONFIG_FA_DUMP. While here, get rid
> of definitions of fadump_append_elf_note() & fadump_final_note()
> functions to reuse similar functions compiled under CONFIG_CRASH_CORE.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig               |   10 ++++++----
>  arch/powerpc/include/asm/fadump.h  |    2 ++
>  arch/powerpc/kernel/crash.c        |    2 --
>  arch/powerpc/kernel/fadump.c       |   34 +++-------------------------------
>  arch/powerpc/kernel/setup-common.c |    5 +++++
>  5 files changed, 16 insertions(+), 37 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
