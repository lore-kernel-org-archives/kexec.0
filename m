Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109CC7EE22
	for <kexec@archiver.kernel.org>; Thu, 11 May 2023 03:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=i/KqCnWQrwGNOvnbgbG9Pu1yTZvLCZdF16sKePTWj7w=; b=gvxz6mMIuTVTFT
	+6CjiPI+M5uN7PX1htCSAsUR6muHZ5nqKU7lMgORfJmM2q7zetQXjOtrmDyxmgdyfFw55MF+VPook
	DcyQOJdzSAV6N4POSXn0r1j+hFMtE5Tu20//IuBhMoicu0n5M2hPFO4/BGX750AMQcuCLiiiZyyw9
	J5HMgNAAa94SuJawTGhoPSJQ4mITqZknljEO0pgygP9+RRZHhotd/O8TkWQkzY+2SKBotkrZ967JB
	bbRqKiH90ce8lrR42CQwXm0h/PbtzRcJCY7XQzoSHY/ABin/ODQoAnMEoihOWraJVpNb0mkLXdlvp
	Dm/zlGX8cq0ZwGhDY3lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwx4R-007epi-28;
	Thu, 11 May 2023 03:34:23 +0000
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net ([167.179.156.38])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwx4N-007eo5-2r
	for kexec@lists.infradead.org;
	Thu, 11 May 2023 03:34:22 +0000
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1pwx3z-007Ytd-Ii; Thu, 11 May 2023 11:33:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 May 2023 11:33:56 +0800
Date: Thu, 11 May 2023 11:33:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <ZFxiJF373HCwZLKE@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-7-ross.philipson@oracle.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.doc,apana.lists.os.linux.kernel
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_203419_945777_54FDA152 
X-CRM114-Status: GOOD (  10.56  )
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

Ross Philipson <ross.philipson@oracle.com> wrote:
>
> +static void __sha_transform(u32 *digest, const char *data)
> +{
> +       u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +       sha1_transform(digest, data, ws);
> +
> +       memzero_explicit(ws, sizeof(ws));
> +}
> +
> +void early_sha1_init(struct sha1_state *sctx)
> +{
> +       sha1_init(sctx->state);
> +       sctx->count = 0;
> +}
> +
> +void early_sha1_update(struct sha1_state *sctx,
> +                      const u8 *data,
> +                      unsigned int len)
> +{
> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +
> +       sctx->count += len;
> +
> +       if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
> +               int blocks;
> +
> +               if (partial) {
> +                       int p = SHA1_BLOCK_SIZE - partial;
> +
> +                       memcpy(sctx->buffer + partial, data, p);
> +                       data += p;
> +                       len -= p;
> +
> +                       __sha_transform(sctx->state, sctx->buffer);
> +               }
> +
> +               blocks = len / SHA1_BLOCK_SIZE;
> +               len %= SHA1_BLOCK_SIZE;
> +
> +               if (blocks) {
> +                       while (blocks--) {
> +                               __sha_transform(sctx->state, data);
> +                               data += SHA1_BLOCK_SIZE;
> +                       }
> +               }
> +               partial = 0;
> +       }
> +
> +       if (len)
> +               memcpy(sctx->buffer + partial, data, len);
> +}
> +
> +void early_sha1_final(struct sha1_state *sctx, u8 *out)
> +{
> +       const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +       __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> +       __be32 *digest = (__be32 *)out;
> +       int i;
> +
> +       sctx->buffer[partial++] = 0x80;
> +       if (partial > bit_offset) {
> +               memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +               partial = 0;
> +
> +               __sha_transform(sctx->state, sctx->buffer);
> +       }
> +
> +       memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +       *bits = cpu_to_be64(sctx->count << 3);
> +       __sha_transform(sctx->state, sctx->buffer);
> +
> +       for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> +               put_unaligned_be32(sctx->state[i], digest++);
> +
> +       *sctx = (struct sha1_state){};
> +}

If we're going to add SHA1 then this should go into lib/crypto
just like SHA2.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
