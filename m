Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397CEC77B75
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=96gfcbAHsb9KgJOu0adijkq0KUyIGZYm69NBkCJ65Es=; b=jqF54ieEBNnLUP
	1IJSLdUiS7aPj9eSV3GNF1GuuNuviemeV7VBGJOn/qAXk12g9v0GLkdcntZSH86LhrK1j/8vmMEEi
	AY2GkfU1PIGvRn02a49UktdN+7f08JpefoFPuJCun2GqjxMiVIWHMXFyoL3/1AutEGzevdERDs5vX
	QMiu1WtJc/taF8V01+2VTF3KEcQApA8vMmRLScyIMfyvpW6r7Iwt5Co2UlFEVnwcOOXkIGXnlhEAB
	O7nItlp+9bl8VoRaI0M1czfId6aS1KNEg7V5erFfnsdKnaVh1myx/39zV1DEjh3/X1DrrC9dOGF0I
	qROZ7J1Z8EzLTbIRpvFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyiuP-003yxj-1p;
	Tue, 16 May 2023 00:51:21 +0000
Received: from sender3-of-o59.zoho.com ([136.143.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyiuM-003yw3-1v
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 00:51:19 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1684198218; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hphAUb1s8tX8hoJbMUmmfcNUb1PoPVaYFfxM1JcuwOqJSMqAu3Cf9GuDL8sH8Ph4Iku5EaEMXegCiyxsIjiAqkc9RLNsR0E3F/R6AciymiJeo1/qrueHuZc9Nuu8ZLL9sBKs66AP5MZ1u32G3ILl+r4EkO6GvDwJCt2LKiMb9xU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1684198218; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=/IA3SYIOXiJVvtltmF1oS40g7D1vsHlc33a3m3c4dYE=; 
	b=BEws52Pr7aOM51bDXrUNU3+uq47fmQbwtrJ2v0F+Vf7EUmqMpM8eIQF/IpE62pi9ima+zsHSd/5nB5+fecpHfVxoFlYQRxzmGJaldb3eaHk9PabfWDbXrotuNZ4tWSa2OjG7cSC9MCgLlFNQ5RvsupXyN6m/vBI0yDaencX9QK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684198218;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/IA3SYIOXiJVvtltmF1oS40g7D1vsHlc33a3m3c4dYE=;
	b=rU+BidODcYu9UNy/1pm+b1nnzJ0hj6vpNb7jQlv+rDxqdC7EzYlS8M3rLTrLEOfm
	VGrXKkPT/jpUVQC5CYE7uwIdDdIoMVbveYRvaZniBHVVodkknwdb2qtUs8QY/P31t9l
	tWHXSzcpyiWBcclgUYyP2o8wyujG/JSm7knPq3dc=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1684198216755684.180617738419; Mon, 15 May 2023 17:50:16 -0700 (PDT)
Message-ID: <890440e0-5da3-84f1-26c1-6b7d856ba7c7@apertussolutions.com>
Date: Mon, 15 May 2023 20:50:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-US
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <ZFxiJF373HCwZLKE@gondor.apana.org.au>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <ZFxiJF373HCwZLKE@gondor.apana.org.au>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_175118_683852_601033E8 
X-CRM114-Status: GOOD (  13.69  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 5/10/23 23:33, Herbert Xu wrote:
> Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> +static void __sha_transform(u32 *digest, const char *data)
>> +{
>> +       u32 ws[SHA1_WORKSPACE_WORDS];
>> +
>> +       sha1_transform(digest, data, ws);
>> +
>> +       memzero_explicit(ws, sizeof(ws));
>> +}
>> +
>> +void early_sha1_init(struct sha1_state *sctx)
>> +{
>> +       sha1_init(sctx->state);
>> +       sctx->count = 0;
>> +}
>> +
>> +void early_sha1_update(struct sha1_state *sctx,
>> +                      const u8 *data,
>> +                      unsigned int len)
>> +{
>> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
>> +
>> +       sctx->count += len;
>> +
>> +       if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
>> +               int blocks;
>> +
>> +               if (partial) {
>> +                       int p = SHA1_BLOCK_SIZE - partial;
>> +
>> +                       memcpy(sctx->buffer + partial, data, p);
>> +                       data += p;
>> +                       len -= p;
>> +
>> +                       __sha_transform(sctx->state, sctx->buffer);
>> +               }
>> +
>> +               blocks = len / SHA1_BLOCK_SIZE;
>> +               len %= SHA1_BLOCK_SIZE;
>> +
>> +               if (blocks) {
>> +                       while (blocks--) {
>> +                               __sha_transform(sctx->state, data);
>> +                               data += SHA1_BLOCK_SIZE;
>> +                       }
>> +               }
>> +               partial = 0;
>> +       }
>> +
>> +       if (len)
>> +               memcpy(sctx->buffer + partial, data, len);
>> +}
>> +
>> +void early_sha1_final(struct sha1_state *sctx, u8 *out)
>> +{
>> +       const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
>> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
>> +       __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
>> +       __be32 *digest = (__be32 *)out;
>> +       int i;
>> +
>> +       sctx->buffer[partial++] = 0x80;
>> +       if (partial > bit_offset) {
>> +               memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
>> +               partial = 0;
>> +
>> +               __sha_transform(sctx->state, sctx->buffer);
>> +       }
>> +
>> +       memset(sctx->buffer + partial, 0x0, bit_offset - partial);
>> +       *bits = cpu_to_be64(sctx->count << 3);
>> +       __sha_transform(sctx->state, sctx->buffer);
>> +
>> +       for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
>> +               put_unaligned_be32(sctx->state[i], digest++);
>> +
>> +       *sctx = (struct sha1_state){};
>> +}
> 
> If we're going to add SHA1 then this should go into lib/crypto
> just like SHA2.

As mentioned before, this patch mimicked an early version for SHA2. We 
were remiss in not keeping it aligned with how the SHA2 evolved. I will 
take a closer look, but these wrappers may be able to go away and be 
reduced to just an include as SHA2 does these days.

v/r,
dps

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
