Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657E6078974
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L/IYqBng;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=cKOYknYY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4+o1zQjd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0kNaDaN7VzGkf9l540YM+342pLPmeRVN7bIHtngSK/k=; b=L/IYqBng51Ofkh
	LBHw29Hwx13jalz16Ri3KB92SPouWEtO4QXk+fucxnHbF3VVXCHorNHxO4T9jwz10f580GfAx9lRt
	QwVu4P+FsbgHGxXooSTreGD1h5WlrMFXZDcbB52h28dEF7BBefkYr1p9DpFc89WXhEFG7XwD0fTam
	kgh1fS7sauix1SvpDMM7wCS0F4mmBZ7B5xQas5OiHECkKqzXwTQ0h4BybPVYtPrp3g9b1Uj/EfgU9
	nDbtSAuXJg/ms+0U8OL2jOnOiPiAAESW5dSjCL9Rs4dzMy8L94jvxw0yapoZKhZUjrjSZCBRnhUNP
	WKmAoOT/ykY0QvYulHSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOi5n-00000006yQD-2ynA;
	Wed, 04 Nov 2026 21:00:23 +0000
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOi5l-00000006yO3-179k
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 21:00:22 +0000
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 874A11400113
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 16:00:19 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 04 Nov 2026 16:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793826015;
	 x=1793912415; bh=0kNaDaN7VzGkf9l540YM+342pLPmeRVN7bIHtngSK/k=; b=
	cKOYknYYKdTNm7gT3ervxg7QOU52Utgs5UOoxtrbubT1te5NsIbZVFPMKvQimH1F
	Ib2iv8RWV6UqdraJhvlS5yd33G4tYwFGshUdIGAdvuU3cFdG8rbWC3+KHemVIdXr
	NUc2JhM2u+Fuhup590pgyYcIA58JTAMOd7A5s6PKYEJ1G0nSYzo1JqwOw8UaY8u5
	i/e5W+IkaQrQVH55p1WK2J1BV0dLB4esSzLf+T0EU8o8dUzyZbsKE9LFW1LDbbbW
	3WekMdVJHEFYWXzfbmA+mnv9lsFDEQ8/WTpzFsEFp8PLVP/iIhwhjwYa5asbRMbg
	mwFkIJvImo19SYtH1YbLFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793826015; x=
	1793912415; bh=0kNaDaN7VzGkf9l540YM+342pLPmeRVN7bIHtngSK/k=; b=4
	+o1zQjd3Z41zn3sTJs2UJJfBufYk9JKTqk39/upRC6nT7pcYjQfD/I3Zc3xUL5rZ
	yuWYIf/gUkcGIG93Az/bYc/7Dc36FemWDLmMf3KdtapwF2oa2w/hKyx55r0w2YUM
	V1EYzS32YyXpJWz9G1QAPLPbcO4Rj1H3ZHMRG+wciXebn7B5UGdXi7RurV8D/iRI
	Mn6GcSLvThSgYji/hJ1bPQnO+PItKOtN0ZsnHfstInXC5rC1hVaZ6YaPEsEdm0yc
	0R36LQL2uTJuSjbl9z/FM5BsolZktLXLkNXGb742PsVtn0O1xFxlsHd+7j9NJrAn
	JhBSW6gy6x+a9LlNZnrYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793826015; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm2:rsa-sha256:O15CxX6+6h5HbEDhs4TZTDMQt4GNfCIHhGc0rm6XSYTD7tw
	iqBj+qn/9ktEuGBL8rZRwQS0EaBLWbzq1Vowguwwxhedc87YwCXM+OK07/EIlmkd
	2WE/o7Xr/7bO6tWki9zPxayaBCRGSaFtWOkslBYaqLUCXIqOhzrs0n8xafWFGQog
	eew8Rgq1+8Ttr3swGA5/XtoQEe+aM+7b8soJOFjZfEmfuY865W7U7kgU7xquNeXC
	qzWvEXKVHUuGL2WtnFto9EeT147IQQ6RfoKEZ/6xRxYL55pQMrvZQgUnEGzgYsHS
	DXZ+fcGSto7ZESX8xeuoIbhVkb6gdKgVXQpeiOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fUmINlirdU2Tk6RCoHByTkIj3YlbxSUxiZjtoAUaQGk=:tYBOb+5dGuOjuQrd6XKBAFeuLK+8HRMkrzwfvErc19o=;
X-ME-Sender: <xms:2pzrapVO1PgXZib1J1FOBsiKZcp-1a2WMaiCzkWr12POCmkiMBllIQ>
    <xme:2pzrakYn6jOelhw810z9h7PtEocyxoQVs5edVa43zi1qGGxRlmYuFXHNs-zWUktAf
    1eaLGQCpfHbNQjIOw-5G3gdFqd4lzB-2-cTc4Rd0zl-ciJQRX21O57K>
X-ME-Proxy-Cause: dmFkZTEmmuOD0DZhwLvQ1jMu+N+9f1/bshj4za9fBQJ9CLi5nyqGXS3WVLocnYlOrqOSIB
    6FfId29nGSaJXnRDBuWEgopsKFsk9kKCdZMlOaAKHZiJOecJXJK5tvhHf4ExHC129SPRTn
    ywDnpmZfc6lQS9TUXA9FcCx2VPLS6+9LolLspxAgWuT9gBQtAauE01L1amFsAnhggz9Thz
    K4Y3OubtvjuJtHSnf7zo7wc1RCs2RvOov96x4Gnlg/5v1Dl92DGS7mO3qjvUBcf5+r+W1w
    M2Ah/4lcKnXI+AD7UM9xPoqDsnA90jhXogV/fJUgnmX/RUCq0OsQxlztOfBV5r2ctGxleQ
    P5q62C7C+Ai5m3jgBR8Ubc00tyJArfAVOnKr/LvHUrlJi8kOqvjG2g82xVHp9aqznRs3V3
    qL03F8W2Hy1HAOhL5fLwctcAInLF+bXJ6DMyIU9W9OVVQKGXo0PkiWCRWrFzYVMWb8g6fV
    eOAXmA93VZa4o3zcfq4qC55WNbV+Uz9zvISGAgRFmjFpNzNLlp+B8xe7yw0wZcaXUiz9CP
    FSjGKKuU4t5zdMcRPV6nUzYzMnaxK1H39SW4qpWKaXsgxT1D4VgfsnklufIjUbsHlO2R9H
    0wX5c25K5kQzHuWxQqT1Z6BAnytUuqd787ITw5dkM92Cg9y6+rLOuyjydRhw
X-ME-Proxy: <xmx:3JzrangpKATqgrFY9U5FKngYXRcRvPlOj3GrvzIj0yk4F1827md9hA>
    <xmx:3JzraqDv_f2Y3-RNnCmohuE0avDMpLZVmJc-xMja_czk7Lxx7RTNoQ>
    <xmx:3Jzrah4wqYWgSCUZ4-OLOKBLl26x6kjGdzjCooKYvcBTxAagK-vDaw>
    <xmx:3JzranGBXgwi1mFDP_mObr_pbEak_8hTCfhVqNcPvwprpGKJxslj8A>
    <xmx:35zralsJWlZ9ZXZAEn7SjmPWpVp6jklZ58NKQFrEjXOYvm9PpdyfvIPu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9380F32A0099; Wed,  4 Nov 2026 16:00:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgP3mv5Dxly7
Date: Wed, 04 Nov 2026 21:59:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Thorsten Blum" <blum@kernel.org>
Cc: "Mike Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Alexander Graf" <graf@amazon.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Changyuan Lyu" <changyuanl@google.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <34a03ed8-5b75-49b5-bfd5-e5cdf48dbfd4@app.fastmail.com>
In-Reply-To: <179382570401.2089669.6201187990672133004.b4-review@b4>
References: <20261104162352.140836-3-blum@kernel.org>
 <179382570401.2089669.6201187990672133004.b4-review@b4>
Subject: Re: [PATCH v2] kho: Remove redundant 0x prefixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_130021_655590_D1D892FA 
X-CRM114-Status: GOOD (  15.60  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026, at 21:55, Pasha Tatashin wrote:
>> The %pa format specifier already includes the 0x prefix. Remove the
>> redundant prefixes to avoid printing 0x0x.
>> 
>> Use phys_addr_t for size to match the expected type.
>> 
>> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
>> Signed-off-by: Thorsten Blum <blum@kernel.org>
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 6f1f55fe3181..6a7600a0a7d5 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -2010,16 +2010,16 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	 */
>>  	for (int i = 0; i < bootmem_cnt; i++) {
>>  		struct kho_bootmem *area = &bootmem[i];
>> -		u64 size = area->size;
>> +		phys_addr_t size = area->size;
>
> I am not sure; having a variable size of type phys_addr_t looks strange 
> to me. Furthermore, KHO only works on 64-bit platforms because of how 
> our radix tree is designed, and we do not plan to add support for 32-bit 
> systems.
>
> I would keep u64, or if using %pa for u64 is still an eyesore, use 
> 0x%llx for the size field.

area->size is also a phys_addr_t, so using a local variable of the
same type makes sense for consistency.

      Arnd

