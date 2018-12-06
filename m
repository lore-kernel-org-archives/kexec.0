Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
In-Reply-To: <20181115055254.2812-7-takahiro.akashi@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 6 Dec 2018 08:47:04 -0600
Message-ID: <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
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
To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Cc: prudo@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, Frank Rowand <frowand.list@gmail.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, James Morse <james.morse@arm.com>, dyoung@redhat.com, David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Added function, fdt_setprop_reg(), will be used later to handle
> kexec-specific property in arm64's kexec_file implementation.
> It will possibly be merged into libfdt in the future.

You generally can't modify libfdt files. Any changes will be blown
away with the next dtc sync (there's one in -next now). Though here
you are creating a new location with fdt code. lib/ is just a shim to
the actual libfdt code. Don't put any implementation there. You can
add this to drivers/of/fdt_address.c for the short term, but it still
needs to go upstream.

Otherwise, the implementation looks fine to me.

> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  include/linux/libfdt.h | 26 ++++++++++++++++++++
>  lib/Makefile           |  2 +-
>  lib/fdt_addresses.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 lib/fdt_addresses.c

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
