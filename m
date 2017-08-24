Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170824081811.19299-8-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-8-takahiro.akashi@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 24 Aug 2017 12:53:26 +0200
Message-ID: <CAK8P3a3gieZhSS5Qz4UeEP2TENV8j0897qYC3Dbn6jR8h7SUNQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] asm-generic: add kexec_file_load system call to
 unistd.h
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, bauerman@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, David Miller <davem@davemloft.net>, vgoyal@redhat.com

On Thu, Aug 24, 2017 at 10:18 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> The initial user of this system call number is arm64.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by:Arnd Bergmann <arnd@arndb.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
