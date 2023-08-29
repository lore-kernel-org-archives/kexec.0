Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29579C71153
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xXqab4F4spB6TEy8lc8ddM6QMom8MvYqVX0lYu+76Yw=; b=n2aLf3feluHypU
	qgNrjKjB7tTbMWItb6F3x+xVyagoscS14H1+6gOaZzRf5waJlOSWIAdbdEjRqzFnbzKPc9gMAZaoL
	IYgn/Z+z5NHF+ELz3R5DNQ1UFQKK8Ro5b0vper2TkcgsUwZaT5ytTiIjr5zufsysCW4qGoq5FtIzD
	GeNf7Xwp7jmIgESSdmaM8SBiucvsG3XWc29P4iH1uMAG4W7mvdtmDNaIaUSzxwZy+HERHwLw2+k3I
	HzhslxGuIKq8REWK0ypMBfuy9Q3gwshNI+sPC9CeHY7Zbc0IHKL+DOxcencpjlt95aCv6DqskGj0+
	ULcEEydGoKfQ8ler77Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb4Ts-00C9GX-39;
	Tue, 29 Aug 2023 19:34:28 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb4Tp-00C9G5-20
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 19:34:27 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58dfe2d5b9aso1909937b3.1
        for <kexec@lists.infradead.org>; Tue, 29 Aug 2023 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693337662; x=1693942462; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dku1evb9mZQ/UCmFfdo5JZbpZalq24cWTcGsSAzwTxo=;
        b=CF0FJhob63nQbW8otrIQDi1CqzGirvaSMf/ZNjg5kn68NMxJ//RDbkYBG+CDPXi40D
         aox3zJ8J3zB+57nwsLzOVwPnk0W0hEDRF/Nl9yOc1NwHhIXeF8CxkhYJqvwr4/wAkcxc
         yOUS81e2bTTBKm5/w45OgEcJGCRkWE/2bXWDOV3rVfIfZBWd7qmNwdx//2EzgCJAp3Ty
         RHO/XV+DtKM8oi8biz9Wb7ZbSxPgNc6nELiuOpvWx7KgT3mPbMffhSd0qg+6pqj8TvHd
         C8flFn4XGQBNjQtMsqJ54h52lDhm7sFBhDeyyrbEKYdFsDfEWWQQOUzqx1XKa/pFgMO9
         JZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337662; x=1693942462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dku1evb9mZQ/UCmFfdo5JZbpZalq24cWTcGsSAzwTxo=;
        b=LnxmHY744aD9mzJ6Xaj0D5WdlTFB5Zoq0KTLtkNx2/sVkQp4G8UoZ8nSgZ4yfPpzVm
         bla2dX04fAoAD3vRv7+tsCSaJ+EFnq1z+H41FpnotUcbJfeiith1wcJy+vlA2GAI7zBv
         HEbAuVuCy87DGsgJoIbv+oGe6aFtkDGpQTAcpzeutm2PXQ6AVo1yqmlc096O3W+0DiJU
         BdWzvIjJmU/zduWvPA6uPlzRjcz98ZiF5qCd9B59sB1K9wgen3Iukh/wdPdgOnfNw7mZ
         S+qHuz8cev3dZoU4X/3O2rMv7/j3jL/xSOL+RWRQmUU14XVJpikku1EmNbHNuc+Hz66w
         WGKQ==
X-Gm-Message-State: AOJu0Yz/L1IT4Ce7/GzOZzhPDCenY0/xhHJRZKEby6aaiRzxe2awXubT
	sb0zQ3gnmsqrpjDHrAeM4dLvLDSeDsXpE2jFDQgGf4VnufvGpO4=
X-Google-Smtp-Source: AGHT+IFet3rs4lSa6SdyUYuNhduFXChT/c/u2XD2EuWbmN/GXJdqeDdKGD9HS33EBu3hJQ+LAmlIEUXeaAC+annspfI=
X-Received: by 2002:a81:4e10:0:b0:586:a680:250 with SMTP id
 c16-20020a814e10000000b00586a6800250mr179637ywb.5.1693337661845; Tue, 29 Aug
 2023 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com> <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
In-Reply-To: <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Aug 2023 15:34:10 -0400
Message-ID: <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	Tushar Sugandhi <tusharsu@linux.mic>, linux-security-module@vger.kernel.org, 
	AmirGoldstein <amir73il@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_123426_152550_24C1920B 
X-CRM114-Status: GOOD (  24.66  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBBdWcgMjEsIDIwMjMgYXQgNzowOOKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIE1vbiwgMjAyMy0wOC0yMSBhdCAxNTowNSAtMDcwMCwgU3Vz
aCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPiA+IE9uIDgvMTQvMjAyMyAzOjAyIFBNLCBNaW1pIFpv
aGFyIHdyb3RlOgo+ID4gPiBPbiBNb24sIDIwMjMtMDgtMTQgYXQgMTQ6NDIgLTA3MDAsIFN1c2gg
U2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4gPiA+Pj4gVGhpcyBkZXNpZ24gc2VlbXMgb3Zlcmx5IGNv
bXBsZXggYW5kIHJlcXVpcmVzIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuCj4gPiA+Pj4gdGhlICJz
bmFwc2hvdCIgcmVjb3JkIGFuZCBleHBvcnRpbmcgdGhlIHJlY29yZHMgZnJvbSB0aGUgbWVhc3Vy
ZW1lbnQKPiA+ID4+PiBsaXN0LiAgTm9uZSBvZiB0aGlzIHdvdWxkIGJlIG5lY2Vzc2FyeSBpZiB0
aGUgbWVhc3VyZW1lbnRzIHdlcmUgY29waWVkCj4gPiA+Pj4gZnJvbSBrZXJuZWwgbWVtb3J5IHRv
IGEgYmFja2luZyBmaWxlIChlLmcuIHRtcGZzKSwgYXMgZGVzY3JpYmVkIGluIFsxXS4KPiA+IEV2
ZW4gaWYgdGhlIEtlcm5lbCBtYWludGFpbnMgdGhlIGxpbmsgYmV0d2VlbiBhIHRtcGZzIGV4cG9y
dGVkIGFuZCBhbgo+ID4gaW4tbWVtb3J5IElNQSBsb2cgLSBpdCBzdGlsbCBoYXMgdG8gY29weSB0
aGUgdG1wZnMgcG9ydGlvbiB0byB0aGUKPiA+IEtlcm5lbCBtZW1vcnkgZHVyaW5nIGtleGVjIHNv
ZnQgYm9vdC4gIHRtcGZzIGlzIGNsZWFyZWQgZHVyaW5nIGtleGVjLAo+ID4gc28gdGhpcyBjb3B5
aW5nIG9mIHRtcGZzIGJhY2sgdG8ga2VybmVsIG1lbW9yeSBpcyBuZWNlc3NhcnkgdG8gcHJlc2Vy
dmUKPiA+IHRoZSBpbnRlZ3JpdHkgb2YgdGhlIGxvZyBkdXJpbmcga2V4ZWMuICBCdXQgdGhlIGNv
cHlpbmcgd291bGQgYWRkIGJhY2sKPiA+IHRoZSBtZW1vcnkgcHJlc3N1cmUgb24gdGhlIG5vZGUg
ZHVyaW5nIGtleGVjICh3aGljaCBtYXkgcmVzdWx0IGluCj4gPiBvdXQtb2YtbWVtb3J5KSwgZGVm
ZWF0aW5nIHRoZSBwdXJwb3NlIG9mIHRoZSBvdmVyYWxsIGVmZm9ydC9mZWF0dXJlLgo+ID4gQ29w
eWluZyB0byBhIHJlZ3VsYXIgKnBlcnNpc3RlbnQqIHByb3RlY3RlZCBmaWxlIHNlZW1zIGEgY2xl
YW5lcgo+ID4gYXBwcm9hY2gsIGNvbXBhcmVkIHRvIHRtcGZzLgo+Cj4gRnJvbSBhIGtlcm5lbCBw
ZXJzcGVjdGl2ZSwgaXQgZG9lc24ndCBtYWtlIGEgZGlmZmVyZW5jZSBpZiB1c2Vyc3BhY2UKPiBw
cm92aWRlcyBhIHRtcGZzIG9yIHBlcnNpc3RlbnQgZmlsZS4gIEFzIHBlciB0aGUgZGlzY3Vzc2lv
bgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWludGVncml0eS9DQU9RNHV4ajRQdjJX
cjF3Z3ZCQ0RSLXRuQTVkc1pUM3J2ZER6S2dBSDFhRVZfLXI5UWdAbWFpbC5nbWFpbC5jb20vI3QK
PiAsIHVzZXJzcGFjZSBwcm92aWRlcyB0aGUga2VybmVsIHdpdGggdGhlIGZpbGUgZGVzY3JpcHRv
ciBvZiB0aGUgb3BlbmVkCj4gZmlsZS4KPgo+ID4gV2UgcHJvdG90eXBlZCB0aGlzIHNvbHV0aW9u
LCBob3dldmVyIGl0Cj4gPiBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgY29tbW9uIHBhdHRlcm4gd2l0
aGluIHRoZSBLZXJuZWwgdG8gd3JpdGUgc3RhdGUKPiA+IGRpcmVjdGx5IHRvIGZpbGVzIG9uIGRp
c2sgZmlsZSBzeXN0ZW1zLiAgV2UgY29uc2lkZXJlZCB0d28gcG90ZW50aWFsCj4gPiBvcHRpb25z
Ogo+Cj4gSWYgbm8gZmlsZSBkZXNjcmlwdG9yIGlzIHByb3ZpZGVkLCB0aGVuIHRoZSBtZWFzdXJl
bWVudHMgYXJlbid0IGNvcGllZAo+IGFuZCByZW1vdmVkIGZyb20gdGhlIHNlY3VyaXR5ZnMgZmls
ZS4gIElmIHRoZXJlIGFyZSB3cml0ZSBlcnJvcnMsIHRoZQo+IG1lYXN1cmVtZW50cyBhcmVuJ3Qg
cmVtb3ZlZCBmcm9tIHRoZSBzZWN1cml0eWZzIGZpbGUgdW50aWwgdGhlIHdyaXRlCj4gZXJyb3Jz
IGFyZSByZXNvbHZlZC4KCkl0IHNvdW5kcyBsaWtlIHRoaXMgYXBwcm9hY2ggd291bGQgcmVxdWly
ZSB0aGUgZmlsZS9maWxlc3lzdGVtIHRvIGJlCmNvbnRpbnVvdXNseSBhdmFpbGFibGUgZm9yIHRo
ZSBsaWZlIG9mIHRoZSBzeXN0ZW0gb25jZSB0aGUgbG9nIHdhcwpzbmFwc2hvdHRlZC9vdmVyZmxv
d2VkIHRvIHBlcnNpc3RlbnQgc3RvcmFnZSwgeWVzPyAgQXNzdW1pbmcgdGhhdCBpcwp0aGUgY2Fz
ZSwgd2hhdCBoYXBwZW5zIGlmIHRoZSBmaWxlL2ZpbGVzeXN0ZW0gYmVjb21lcyBpbmFjY2Vzc2li
bGUgYXQKc29tZSBwb2ludCBhbmQgYW4gYXR0ZXN0YXRpb24gY2xpZW50IGF0dGVtcHRzIHRvIHJl
YWQgdGhlIGVudGlyZSBsb2c/CgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
