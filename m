Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZmWl-00E7Fl-JS
 for kexec@lists.infradead.org; Fri, 23 Apr 2021 03:30:48 +0000
Received: by mail-pg1-x52e.google.com with SMTP id d10so34273322pgf.12
 for <kexec@lists.infradead.org>; Thu, 22 Apr 2021 20:30:46 -0700 (PDT)
Date: Thu, 22 Apr 2021 20:30:45 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] RISC-V: Add EM_RISCV to kexec UAPI header
In-Reply-To: <20210405085712.1953848-2-mick@ics.forth.gr>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-891ba63b-523a-470d-9e50-a881b9e3dde1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, kexec@lists.infradead.org
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, mick@ics.forth.gr

On Mon, 05 Apr 2021 01:57:08 PDT (-0700), mick@ics.forth.gr wrote:
> Add RISC-V to the list of supported kexec architecturs, we need to
> add the definition early-on so that later patches can use it.
>
> EM_RISCV is 243 as per ELF psABI specification here:
> https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md
>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>  include/uapi/linux/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 05669c87a..778dc191c 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -42,6 +42,7 @@
>  #define KEXEC_ARCH_MIPS_LE (10 << 16)
>  #define KEXEC_ARCH_MIPS    ( 8 << 16)
>  #define KEXEC_ARCH_AARCH64 (183 << 16)
> +#define KEXEC_ARCH_RISCV   (243 << 16)
>
>  /* The artificial cap on the number of segments passed to kexec_load. */
>  #define KEXEC_SEGMENT_MAX 16

This is missing the kexec maintainers, who I've added.  I'm happy to 
just take this along with the rest of the patch set, as that's probably 
easiest.  I usually like to get an Ack on this sort of thing, but I'm 
just going to speculate that this isn't controversial and put this on 
riscv/for-next.  LMK if you want me to do something more complicated 
like a shared tag, but I see the arm64 stuff went in via the arm64 tree 
so I'm assuming this is fine.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
