Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f2H7Q-00071x-Lm
 for kexec@lists.infradead.org; Sat, 31 Mar 2018 14:04:34 +0000
In-Reply-To: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: kexec_file: Fix error code when trying to load kdump
 kernel
Message-Id: <40D0bL6Ncvz9s3v@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:14 +1100 (AEDT)
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, =?utf-8?q?Michal_Such=C3=A1n?= =?utf-8?q?ek?= <msuchanek@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 19:05:43 UTC, Thiago Jung Bauermann wrote:
> kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
> returns -ENOTSUPP in that case.
> 
> I've recently learned that this errno is internal to the kernel and isn't
> supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
> is defined in an uapi header.
> 
> This does indeed make kexec-tools happier. Before the patch, on ppc64le:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Unknown error 524
> 
> After the patch:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Operation not supported
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Reported-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Reviewed-by: Simon Horman <horms@verge.net.au>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bf8a1abc3ddbd6e9a8312ea7d96e5d

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
