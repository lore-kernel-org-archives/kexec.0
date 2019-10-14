Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK14k-0000F6-KD
 for kexec@lists.infradead.org; Mon, 14 Oct 2019 14:11:56 +0000
Received: by mail-qt1-x841.google.com with SMTP id u40so25558195qth.11
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2019 07:11:53 -0700 (PDT)
Date: Mon, 14 Oct 2019 14:11:50 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v6 02/17] arm64: hibernate: pass the allocated pgdp to
 ttbr0
Message-ID: <20191014141150.xt6z3gs3cu3rl3go@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-3-pasha.tatashin@soleen.com>
 <bb937db3-f23a-809b-4ad8-ca86f689554d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bb937db3-f23a-809b-4ad8-ca86f689554d@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

On 19-10-11 19:17:22, James Morse wrote:
> > Fixes: 0194e760f7d2 ("arm64: hibernate: avoid potential TLB conflict")
> 
> (That was a 'break before make' fix, the affected code comes from:
>  82869ac57b5d (""arm64: kernel: Add support for hibernate/suspend-to-disk))
> 
> But, it works in all one circumstances its used: we know all the top bits will be zero.
> I agree its by accident and we should fix it.
> 
> I don't think we should send it to stable.
> Please drop the fixes tag, with that:

OK

> Reviewed-by: James Morse <james.morse@arm.com>
Thank you!

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
