Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1csSAy-0003wQ-15
 for kexec@lists.infradead.org; Mon, 27 Mar 2017 10:47:05 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH v4 5/5] powerpc/fadump: update documentation about
 crashkernel parameter reuse
In-Reply-To: <149035347559.6881.14224829694291758581.stgit@hbathini.in.ibm.com>
References: <149035332237.6881.9486330442785822384.stgit@hbathini.in.ibm.com>
 <149035347559.6881.14224829694291758581.stgit@hbathini.in.ibm.com>
Date: Mon, 27 Mar 2017 21:46:40 +1100
Message-ID: <87mvc7dmjz.fsf@concordia.ellerman.id.au>
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

> As we are reusing crashkernel parameter instead of fadump_reserve_mem
> parameter to specify the memory to reserve for fadump's crash kernel,
> update the documentation accordingly.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  Documentation/powerpc/firmware-assisted-dump.txt |   23 ++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
