Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 6 Dec 2018 15:54:24 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
Message-ID: <20181206155424.GA4422@arm.com>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
 <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
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
To: Rob Herring <robh+dt@kernel.org>
Cc: prudo@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, Frank Rowand <frowand.list@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, James Morse <james.morse@arm.com>, dyoung@redhat.com, David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

Hi Rob,

Thanks for reviewing this.

On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Added function, fdt_setprop_reg(), will be used later to handle
> > kexec-specific property in arm64's kexec_file implementation.
> > It will possibly be merged into libfdt in the future.
> 
> You generally can't modify libfdt files. Any changes will be blown
> away with the next dtc sync (there's one in -next now). Though here
> you are creating a new location with fdt code. lib/ is just a shim to
> the actual libfdt code. Don't put any implementation there. You can
> add this to drivers/of/fdt_address.c for the short term, but it still
> needs to go upstream.
> 
> Otherwise, the implementation looks fine to me.

I agree, but I don't think there's a real need for us to hack
drivers/of/fdt_address.c in the meantime -- let's just target upstream
and not carry this in the kernel.

Akashi -- for now, I'll drop the kdump parts of this series which rely
on this helper. The majority of the series is actually independent and
can go in as-is.

I've pushed out a kexec branch to the arm64 tree for you to take a look
at:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec

Thanks,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
