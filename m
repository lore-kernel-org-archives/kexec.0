Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B5AC25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 22:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XqhziOKg0qwQR9xxvoS+Uk0ft9/x4FOuer32xTMVqtE=; b=H/Vvh1I5h1HV+S
	G3L2N4uJAJYn5F0T8VUh/VMVupHL1C5nkFvhXnwgp9GoKFPgJuVPz3Db4L1dRIewevDbFEejoVPMS
	CmUW5vm/d3afAQVYyjRC7FrNvkgqEbFp5xcxp04nf7A6YDk1afAIJCEgkjkQLDpNBvCN70wxNapEH
	73THxIbjpb612Qp4ecndMq7I69Oru6Nnx5sP80s253WEqxmWv8q9hfV2fzNWStQJlMb/PPZxnaP2r
	HO8zdXVXjWX7DL8DiMR0kj6XCbfsi1XPbmlizNkKyytshKA6gbu+kDj5+HoBx+SbBL6d3S0VGDCuV
	rzHsDq3JVYo+pgk1r5SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcq3-0000000455Z-3dbw;
	Tue, 04 Jun 2024 22:41:07 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcq0-0000000454U-3Ooh
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 22:41:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3E6B3CE0E93;
	Tue,  4 Jun 2024 22:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6950C2BBFC;
	Tue,  4 Jun 2024 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540861;
	bh=vw7d1yN78M9RgQ9Uv/CxeAyqib+2y0nfRQmhm1r8tqg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=klTHSVF5uRzpHx0R6uJcsWmiMp9IKQD/4SkJAJDw/ofx6Cd2DzcvyynuoVLq3zTwL
	 nfkpqjpJPPEQ36BKsH62/kUx8PuufC4egjJ6oTuUaReS88puer4ItAu4vFWTGeJ47+
	 8iQ73F6rxAryaoNS09/a/Y6018ZToX+8aeEDfOyZETxvvk1UTkY/BfCmfdlKgRV5Ed
	 tKXASYMpf4brgs+87MU8cCg9h1eRIBtzJimDZdnwgs+rxuN5EBvkXIsNjsa7cz9EpD
	 Gtlk4JVMt1bG60GPRpOkIbuA3bxpweRhRmUY9otDYQFyRe5ACGqTeSSqlqGakkI67v
	 KyEXa4igXHQaw==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 01:40:54 +0300
Message-Id: <D1RLF3R9YVB0.3LGEH553O8HEL@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <D1RGK44SJ477.3BQ82NMUKH2Z8@kernel.org>
 <0ed3cdf6-2e4a-41f2-b2f6-363899405298@oracle.com>
In-Reply-To: <0ed3cdf6-2e4a-41f2-b2f6-363899405298@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_154105_332189_CAF651EF 
X-CRM114-Status: GOOD (  43.01  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed Jun 5, 2024 at 12:02 AM EEST,  wrote:
> On 6/4/24 11:52 AM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >>
> >> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> >> choice of hashes used lie with the platform firmware, not with
> >> software, and is often outside of the users control.
> >>
> >> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> >> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> >> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> >> to safely use SHA-256 for everything else.
> >>
> >> The SHA-1 code here has its origins in the code from the main kernel:
> >>
> >> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> >>
> >> A modified version of this code was introduced to the lib/crypto/sha1.c
> >> to bring it in line with the SHA-256 code and allow it to be pulled into the
> >> setup kernel in the same manner as SHA-256 is.
> >>
> >> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   arch/x86/boot/compressed/Makefile     |  2 +
> >>   arch/x86/boot/compressed/early_sha1.c | 12 ++++
> >>   include/crypto/sha1.h                 |  1 +
> >>   lib/crypto/sha1.c                     | 81 +++++++++++++++++++++++++++
> >>   4 files changed, 96 insertions(+)
> >>   create mode 100644 arch/x86/boot/compressed/early_sha1.c
> >>
> >> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> >> index e9522c6893be..3307ebef4e1b 100644
> >> --- a/arch/x86/boot/compressed/Makefile
> >> +++ b/arch/x86/boot/compressed/Makefile
> >> @@ -118,6 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> >>   vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >>   
> >> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
> >> +
> >>   $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> >>   	$(call if_changed,ld)
> >>   
> >> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
> >> new file mode 100644
> >> index 000000000000..8a9b904a73ab
> >> --- /dev/null
> >> +++ b/arch/x86/boot/compressed/early_sha1.c
> >> @@ -0,0 +1,12 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2024 Apertus Solutions, LLC.
> >> + */
> >> +
> >> +#include <linux/init.h>
> >> +#include <linux/linkage.h>
> >> +#include <linux/string.h>
> >> +#include <asm/boot.h>
> >> +#include <asm/unaligned.h>
> >> +
> >> +#include "../../../../lib/crypto/sha1.c"
> > }
> > 
> > Yep, make sense. Thinking only that should this be just sha1.c.
> > 
> > Comparing this to mainly drivers/firmware/efi/tpm.c, which is not
> > early_tpm.c where the early actually probably would make more sense
> > than here. Here sha1 primitive is just needed.
> > 
> > This is definitely a nitpick but why carry a prefix that is not
> > that useful, right?
>
> I am not 100% sure what you mean here, sorry. Could you clarify about 
> the prefix? Do you mean why did we choose early_*? There was precedent 
> for doing that like early_serial_console.c.

Yep, that exactly. I'd just name as sha1.c.

>
> > 
> >> diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
> >> index 044ecea60ac8..d715dd5332e1 100644
> >> --- a/include/crypto/sha1.h
> >> +++ b/include/crypto/sha1.h
> >> @@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
> >>   #define SHA1_WORKSPACE_WORDS	16
> >>   void sha1_init(__u32 *buf);
> >>   void sha1_transform(__u32 *digest, const char *data, __u32 *W);
> >> +void sha1(const u8 *data, unsigned int len, u8 *out);
> >>   
> >>   #endif /* _CRYPTO_SHA1_H */
> >> diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> >> index 1aebe7be9401..10152125b338 100644
> >> --- a/lib/crypto/sha1.c
> >> +++ b/lib/crypto/sha1.c
> >> @@ -137,4 +137,85 @@ void sha1_init(__u32 *buf)
> >>   }
> >>   EXPORT_SYMBOL(sha1_init);
> >>   
> >> +static void __sha1_transform(u32 *digest, const char *data)
> >> +{
> >> +       u32 ws[SHA1_WORKSPACE_WORDS];
> >> +
> >> +       sha1_transform(digest, data, ws);
> >> +
> >> +       memzero_explicit(ws, sizeof(ws));
> > 
> > For the sake of future reference I'd carry always some inline comment
> > with any memzero_explicit() call site.
>
> We can do that.
>
> > 
> >> +}
> >> +
> >> +static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
> >> +{
> >> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> >> +
> >> +	sctx->count += len;
> >> +
> >> +	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
> > 
> > 
> > 	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
> > 		goto out;
> > 
> > ?
>
> We could do it that way. I guess it would cut down in indenting. I defer 
> to Daniel Smith on this...

Yep, that's why I requested this.

>
> > 
> >> +		int blocks;
> >> +
> >> +		if (partial) {
> >> +			int p = SHA1_BLOCK_SIZE - partial;
> >> +
> >> +			memcpy(sctx->buffer + partial, data, p);
> >> +			data += p;
> >> +			len -= p;
> >> +
> >> +			__sha1_transform(sctx->state, sctx->buffer);
> >> +		}
> >> +
> >> +		blocks = len / SHA1_BLOCK_SIZE;
> >> +		len %= SHA1_BLOCK_SIZE;
> >> +
> >> +		if (blocks) {
> >> +			while (blocks--) {
> >> +				__sha1_transform(sctx->state, data);
> >> +				data += SHA1_BLOCK_SIZE;
> >> +			}
> >> +		}
> >> +		partial = 0;
> >> +	}
> >> +
> > 
> > out:
> > 
> >> +	if (len)
> >> +		memcpy(sctx->buffer + partial, data, len);
> > 
> > Why not just memcpy() unconditionally?
> > 
>
> ... and this.

It only adds complexity with no gain.

>
> >> +}
> >> +
> >> +static void sha1_final(struct sha1_state *sctx, u8 *out)
> >> +{
> >> +	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> >> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> >> +	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> >> +	__be32 *digest = (__be32 *)out;
> >> +	int i;
> >> +
> >> +	sctx->buffer[partial++] = 0x80;
> >> +	if (partial > bit_offset) {
> >> +		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> >> +		partial = 0;
> >> +
> >> +		__sha1_transform(sctx->state, sctx->buffer);
> >> +	}
> >> +
> >> +	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> >> +	*bits = cpu_to_be64(sctx->count << 3);
> >> +	__sha1_transform(sctx->state, sctx->buffer);
> >> +
> >> +	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> >> +		put_unaligned_be32(sctx->state[i], digest++);
> >> +
> >> +	*sctx = (struct sha1_state){};
> >> +}
> >> +
> >> +void sha1(const u8 *data, unsigned int len, u8 *out)
> >> +{
> >> +	struct sha1_state sctx = {0};
> >> +
> >> +	sha1_init(sctx.state);
> >> +	sctx.count = 0;
> > 
> > Hmm... so shouldn't C99 take care of this given the initialization
> > above? I'm not 100% sure here. I.e. given "= {0}", shouldn't this
> > already be zero?
>
> Yes it seems so. We will look at changing that.

Yeah, AFAIK C99 should zero out anything remaining.

>
> > 
> >> +	sha1_update(&sctx, data, len);
> >> +	sha1_final(&sctx, out);
> >> +}
> >> +EXPORT_SYMBOL(sha1);
> >> +
> >>   MODULE_LICENSE("GPL");
> > 
> > BR, Jarkko
>
> Thanks
> Ross

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
