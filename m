Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 25 Aug 2017 13:47:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 05/14] kexec_file: factor out crashdump elf header
 function from x86
Message-ID: <20170825054749.GA8604@dhcp-128-65.nay.redhat.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-6-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170824081811.19299-6-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

On 08/24/17 at 05:18pm, AKASHI Takahiro wrote:
> prepare_elf_headers() can also be useful for other architectures,
> including arm64. So let it factored out.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/kernel/crash.c | 324 ----------------------------------------------
>  include/linux/kexec.h   |  19 +++
>  kernel/crash_core.c     | 333 ++++++++++++++++++++++++++++++++++++++++++++++++

It looks better to add these to kexec_file.c instead.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
