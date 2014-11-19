Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xr1mI-0002by-LZ
 for kexec@lists.infradead.org; Wed, 19 Nov 2014 09:42:24 +0000
Date: Wed, 19 Nov 2014 10:41:37 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2 v2] scripts/coccinelle: catch freeing cryptographic
 structures via kfree
In-Reply-To: <20141118114920.13498.73584.stgit@buzz>
Message-ID: <alpine.DEB.2.10.1411191040020.2363@hadrien>
References: <20141117151420.10739.16342.stgit@buzz>
 <20141118114920.13498.73584.stgit@buzz>
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
Cc: Michal Marek <mmarek@suse.cz>, Herbert Xu <herbert@gondor.apana.org.au>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Eric Biederman <ebiederm@xmission.com>, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org

> +// Comments: There are false positives in crypto/ where they are
> actually freed.

I didn't really understand this comment.  I ran the semantic patch and got
around 10 results, but it wasn't clear to me how to see which were false
positives.

I would suggest to extend the rule a little bit to include information
about where the allocation call is:

///
/// Structures allocated by crypto_alloc_* must be freed using crypto_free_*.
/// This finds freeing them by kfree.
///
// Confidence: Moderate
// Copyright: (C) 2014 Konstantin Khlebnikov,  GPLv2.
// Comments: There are false positives in crypto/ where they are actually freed.
// Keywords: crypto, kfree
// Options: --no-includes --include-headers

virtual org
virtual report
virtual context

@r depends on context || org || report@
expression x;
position p1;
@@

(
 x = crypto_alloc_base@p1(...)
|
 x = crypto_alloc_cipher@p1(...)
|
 x = crypto_alloc_ablkcipher@p1(...)
|
 x = crypto_alloc_aead@p1(...)
|
 x = crypto_alloc_instance@p1(...)
|
 x = crypto_alloc_instance2@p1(...)
|
 x = crypto_alloc_comp@p1(...)
|
 x = crypto_alloc_pcomp@p1(...)
|
 x = crypto_alloc_hash@p1(...)
|
 x = crypto_alloc_ahash@p1(...)
|
 x = crypto_alloc_shash@p1(...)
|
 x = crypto_alloc_rng@p1(...)
)

@pb@
expression r.x;
position p;
@@

* kfree@p(x)

@script:python depends on org@
p << pb.p;
p1 << r.p1;
@@

msg="WARNING: invalid free of crypto_alloc_* allocated data"
coccilib.org.print_todo(p[0], msg)
coccilib.org.print_link(p1[0], "allocation")

@script:python depends on report@
p << pb.p;
p1 << r.p1;
@@

msg="WARNING: invalid free of crypto_alloc_* allocated data, allocated on line %s" % (p1[0].line)
coccilib.report.print_report(p[0], msg)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
