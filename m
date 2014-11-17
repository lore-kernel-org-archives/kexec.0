Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XqOUg-0006cJ-2A
 for kexec@lists.infradead.org; Mon, 17 Nov 2014 15:45:35 +0000
Date: Mon, 17 Nov 2014 16:30:11 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] scripts/coccinelle: catch freeing cryptographic
 structures via kfree
In-Reply-To: <20141117151420.10739.16342.stgit@buzz>
Message-ID: <alpine.DEB.2.10.1411171628230.2532@hadrien>
References: <20141117151420.10739.16342.stgit@buzz>
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
To: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Cc: Michal Marek <mmarek@suse.cz>, Herbert Xu <herbert@gondor.apana.org.au>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org



On Mon, 17 Nov 2014, Konstantin Khlebnikov wrote:

> Structures allocated by crypto_alloc_* must be freed using crypto_free_*.
>
> Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
> ---
>  scripts/coccinelle/free/crypto_free.cocci |   45 +++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 scripts/coccinelle/free/crypto_free.cocci
>
> diff --git a/scripts/coccinelle/free/crypto_free.cocci b/scripts/coccinelle/free/crypto_free.cocci
> new file mode 100644
> index 0000000..0799b70
> --- /dev/null
> +++ b/scripts/coccinelle/free/crypto_free.cocci
> @@ -0,0 +1,45 @@
> +///
> +/// Structures allocated by crypto_alloc_* must be freed using crypto_free_*.
> +/// This finds freeing them by kfree.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2014 Konstantin Khlebnikov,  GPLv2.
> +// Comments: There are false positives in crypto/ where they are actually freed.
> +// Keywords: crypto, kfree
> +// Options: --no-includes --include-headers
> +
> +virtual org
> +virtual report
> +virtual context
> +
> +@r depends on context || org || report@
> +expression x;
> +identifier crypto_alloc =~ "^crypto_alloc_";
> +@@
> +
> +(
> + x = crypto_alloc(...)
> +)

You can drop the outer parentheses, in this case and in the kfree case.

Are there many of these crypto_alloc_ functions?  It would be nicer to
avoid the regular expression.  For one thing, you don't have much control
over what it matches, and for another thing Coccinelle will not be able to
optimize the selection of files.  With the regular expression it will have
to parse every file and analyze every function, which will be slow.

julia

> +
> +@pb@
> +expression r.x;
> +position p;
> +@@
> +
> +(
> +* kfree@p(x)
> +)
> +
> +@script:python depends on org@
> +p << pb.p;
> +@@
> +
> +msg="WARNING: invalid free of crypto_alloc_* allocated data"
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script:python depends on report@
> +p << pb.p;
> +@@
> +
> +msg="WARNING: invalid free of crypto_alloc_* allocated data"
> +coccilib.report.print_report(p[0], msg)
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
