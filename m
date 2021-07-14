Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 14 Jul 2021 07:46:32 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 01/10] crash_dump: Make elfcorehdr_{addr,size} always
 visible
Message-ID: <20210714134632.GA2441138@robh.at.kernel.org>
References: <cover.1626266516.git.geert+renesas@glider.be>
 <0721f629d5e75b7b7e655458a63cbd767baaa409.1626266516.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0721f629d5e75b7b7e655458a63cbd767baaa409.1626266516.git.geert+renesas@glider.be>
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
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-mm@kvack.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 02:50:11PM +0200, Geert Uytterhoeven wrote:
> Make the forward declarations of elfcorehdr_addr and elfcorehdr_size
> always available, like is done for phys_initrd_start and
> phys_initrd_size.  Code referring to these symbols can then just check
> for IS_ENABLED(CONFIG_CRASH_DUMP), instead of requiring conditional
> compilation using an #ifdef, thus preparing to increase compile
> coverage.
> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
> ---
>  include/linux/crash_dump.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index a5192b718dbe4f9a..ad31893d13d634de 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -10,13 +10,14 @@
>  
>  #include <linux/pgtable.h> /* for pgprot_t */
>  
> +/* For IS_ENABLED(CONFIG_CRASH_DUMP) */
> +extern unsigned long long elfcorehdr_addr;
> +extern unsigned long long elfcorehdr_size;
> +
>  #ifdef CONFIG_CRASH_DUMP
>  #define ELFCORE_ADDR_MAX	(-1ULL)
>  #define ELFCORE_ADDR_ERR	(-2ULL)

Seems like these could be needed and no need to hide them, so perhaps 
just move the #ifdef down.

>  
> -extern unsigned long long elfcorehdr_addr;
> -extern unsigned long long elfcorehdr_size;
> -
>  extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
>  extern void elfcorehdr_free(unsigned long long addr);
>  extern ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos);
> -- 
> 2.25.1
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
