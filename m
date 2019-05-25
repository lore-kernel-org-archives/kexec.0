Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2] helo=ozlabs.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hUKxe-0005jE-BB
 for kexec@lists.infradead.org; Sat, 25 May 2019 00:55:00 +0000
In-Reply-To: <20190522220158.18479-1-bauerman@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix loading of kernel + initramfs with
 kexec_file_load()
Message-Id: <459lBd53mCz9sBr@ozlabs.org>
Date: Sat, 25 May 2019 10:54:49 +1000 (AEST)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>

On Wed, 2019-05-22 at 22:01:58 UTC, Thiago Jung Bauermann wrote:
> Commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> changed kexec_add_buffer() to skip searching for a memory location if
> kexec_buf.mem is already set, and use the address that is there.
> 
> In powerpc code we reuse a kexec_buf variable for loading both the kernel
> and the initramfs by resetting some of the fields between those uses, but
> not mem. This causes kexec_add_buffer() to try to load the kernel at the
> same address where initramfs will be loaded, which is naturally rejected:
> 
>   # kexec -s -l --initrd initramfs vmlinuz
>   kexec_file_load failed: Invalid argument
> 
> Setting the mem field before every call to kexec_add_buffer() fixes this
> regression.
> 
> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8b909e3548706cbebc0a676067b81aad

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
