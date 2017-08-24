Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dko4B-0001v2-J9
 for kexec@lists.infradead.org; Thu, 24 Aug 2017 09:04:46 +0000
Received: by mail-io0-x234.google.com with SMTP id h205so70445ioa.2
 for <kexec@lists.infradead.org>; Thu, 24 Aug 2017 02:04:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824081811.19299-3-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-3-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 10:04:20 +0100
Message-ID: <CAKv+Gu-o=3jgw9eMuS2crK6ftQ2iBiyA3iuy6dmLgg9BUPeLQQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] include: pe.h: remove message[] from mz header
 definition
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On 24 August 2017 at 09:17, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> message[] field won't be part of the definition of mz header.
>
> This change is crucial for enabling kexec_file_load on arm64 because
> arm64's "Image" binary, as in PE format, doesn't have any data for it and
> accordingly the following check in pefile_parse_binary() will fail:
>
>         chkaddr(cursor, mz->peaddr, sizeof(*pe));
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> ---
>  include/linux/pe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 143ce75be5f0..3482b18a48b5 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -166,7 +166,7 @@ struct mz_hdr {
>         uint16_t oem_info;      /* oem specific */
>         uint16_t reserved1[10]; /* reserved */
>         uint32_t peaddr;        /* address of pe header */
> -       char     message[64];   /* message to print */
> +       char     message[];     /* message to print */
>  };
>
>  struct mz_reloc {

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
