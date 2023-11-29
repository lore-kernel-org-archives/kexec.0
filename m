Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2895CC4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iIPLjHDe+GLEf/Q/VWXx7NojYTrTEQh46Dms616Awec=; b=MiCU6n7Ouc7Xo1
	Q/WqbSJYz5JUsnZNGdeIFeKKVvqBhfkabI7V0FuAq/4KtgD0PPSQxewJtEn7UL03ZrxwAn/FsaURn
	ZrpbBx/CNgre6IuebzBIf7TP9vI61SqZh1S/l6CzZKrR1U7cntKGlae1A9puB82vxxCkZ79dymD2b
	8k1MdeGFqXmm1XEd5A21s93CeUXB1MV3w2lLPFshDGHlxMH2q2b09LdxQBlW+xL+YN1MlBilwSH28
	aVKJqAXW0DRgbDlXVRMS1EZXlB+YePq5G9MNoVaZT1xZe3kjGZ4dzokpPeZksos5c3eEiopTHx2F9
	2bfYHcONdFYA+hhs1syA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r892n-006kSx-32;
	Wed, 29 Nov 2023 01:07:13 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r892k-006kSF-1D
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 01:07:12 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-daf26d84100so5756699276.3
        for <kexec@lists.infradead.org>; Tue, 28 Nov 2023 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701220027; x=1701824827; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkt95eq+DL2Z8DFZ7ILb1n1z4A0zFQ9JGPcyVYsIM9c=;
        b=MMxPpqiAebGjwgwaOl/gN4ZU1Hu/w1t/PoUslZNSsf23tRASBPqC8rgh4PHBoEumAP
         /SqHwbVcWlWKrbzMcI3yj/rEeRmvfKotR4BVc/JG00m0hwx+aCS4gRFVJzCszRdOThXe
         XRDh5Gfgn+vT5vylg5ORYAHeW2TiS317uIDeVIsxwXizP39GMnwXAZp+sCkLFzgG6nrM
         AYWOqTA2Bw3zQzaAEafBY75TcS+hK01afY2fS5KDHbn2UfToSA0LDLXhEJxiYLwZwpMX
         NdAfVsy/I5ZRI+I6B+tkrAS9tKtumEEGHGQ3V8f2Ikwdmau7vAANlIcQcNwSU9mBtDkA
         M23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701220027; x=1701824827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkt95eq+DL2Z8DFZ7ILb1n1z4A0zFQ9JGPcyVYsIM9c=;
        b=c4eYXjolS5neXFx+saHLd6uAQFgUV4qM6AuR5bMJpQrzpTCxfMQUY0+WtFOKwstBhJ
         znaXJLzNRhjZm0pVOC/atfKuDGEW3YxSff9R4o/Ia7y239YDDAVZjPqZBS0XuW4PWf55
         P8GyK3ZnXQ375oLos+iYNeKkWe6F2Dv27u48M1wrjFvrfDqmuELVM0ZPbV5DIrEH+rEA
         X/OAuNjfXUciYWlpSDfT2lvfTU1YIMDBZCF+r8S5Lv/YN40/96SDtqUlFSy4EqHZzsop
         IRv7Dat7WtvpyRVVqtPCHVe2z5Wv8mwdhuzigOZRt/M+li1GJycLlDcMsW8Yqz92Emzv
         fAfw==
X-Gm-Message-State: AOJu0YzNXvaEyYOIS5VPTgs+PTYejsZhDducM4r2MV2dqB6BdynNaUcz
	c3bnuEjQP0lyqd/fQHBn0u8P1keSY5RsXurYtzzS
X-Google-Smtp-Source: AGHT+IHrFUwjcNVag5pJZmje3+cQULqNQmC5OGUeW1j6G1Cih5a/XEsyDtGSL2dYDowlJ5/Nt6bZHxk+vLu+BQ5qDoY=
X-Received: by 2002:a25:ab8b:0:b0:d9a:c4cf:a066 with SMTP id
 v11-20020a25ab8b000000b00d9ac4cfa066mr17983616ybi.34.1701220027096; Tue, 28
 Nov 2023 17:07:07 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com> <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
In-Reply-To: <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Nov 2023 20:06:56 -0500
Message-ID: <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_170710_748145_D14F4B7F 
X-CRM114-Status: GOOD (  36.81  )
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgNzowOeKAr0FNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIE1vbiwgMjAyMy0xMS0yNyBhdCAxNzoxNiAtMDUwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIE1vbiwgTm92IDI3LCAyMDIzIGF0IDEyOjA44oCvUE0gTWlt
aSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFdlZCwgMjAyMy0x
MS0yMiBhdCAwOToyMiAtMDUwMCwgUGF1bCBNb29yZSB3cm90ZToKCi4uLgoKPiA+IElmIHdlIGFy
ZSBnb2luZyB0byBoYXZlIGEgcmVjb3JkIGNvdW50LCBJIGltYWdpbmUgaXQgd291bGQgYWxzbyBi
ZQo+ID4gaGVscGZ1bCB0byBtYWludGFpbiBhIHNlY3VyaXR5ZnMgZmlsZSB3aXRoIHRoZSB0b3Rh
bCBzaXplIChpbiBieXRlcykKPiA+IG9mIHRoZSBpbi1tZW1vcnkgbWVhc3VyZW1lbnQgbG9nLiAg
SW4gZmFjdCwgSSBzdXNwZWN0IHRoaXMgd2lsbAo+ID4gcHJvYmFibHkgYmUgbW9yZSB1c2VmdWwg
Zm9yIHRob3NlIHdobyB3aXNoIHRvIG1hbmFnZSB0aGUgc2l6ZSBvZiB0aGUKPiA+IG1lYXN1cmVt
ZW50IGxvZy4KPgo+IEEgcnVubmluZyBudW1iZXIgb2YgYnl0ZXMgbmVlZGVkIGZvciBjYXJyeWlu
ZyB0aGUgbWVhc3VyZW1lbnQgbGlzdAo+IGFjcm9zcyBrZXhlYyBhbHJlYWR5IGV4aXN0cy4gIFRo
aXMgdmFsdWUgd291bGQgYmUgYWZmZWN0ZWQgd2hlbiB0aGUKPiBtZWFzdXJlbWVudCBsaXN0IGlz
IHRyaW1tZWQuCgpUaGVyZSB3ZSBnbywgaXQgc2hvdWxkIGJlIHRyaXZpYWwgdG8gZXhwb3J0IHRo
YXQgaW5mb3JtYXRpb24gdmlhIHNlY3VyaXR5ZnMuCgo+ID4gPiBEZWZpbmluZyBvdGhlciBJTUEg
c2VjdXJpdHlmcyBmaWxlcyBsaWtlCj4gPiA+IGhvdyBtYW55IHRpbWVzIHRoZSBtZWFzdXJlbWVu
dCBsaXN0IGhhcyBiZWVuIHRyaW1tZWQgbWlnaHQgYmUKPiA+ID4gYmVuZWZpY2lhbCBhcyB3ZWxs
Lgo+ID4KPiA+IEkgaGF2ZSBubyBvYmplY3Rpb24gdG8gdGhhdC4gIFdvdWxkIGEgdG90YWwgcmVj
b3JkIGNvdW50LCBpLmUuIGEgdmFsdWUKPiA+IHRoYXQgZG9lc24ndCByZXNldCBvbiBhIHNuYXBz
aG90IGV2ZW50LCBiZSBtb3JlIHVzZWZ1bCBoZXJlPwo+Cj4gPHNlY3VyaXR5ZnM+L2ltYS9ydW50
aW1lX21lYXN1cmVtZW50c19jb3VudCBhbHJlYWR5IGV4cG9ydHMgdGhlIHRvdGFsCj4gbnVtYmVy
IG9mIG1lYXN1cmVtZW50IHJlY29yZHMuCgpJIGd1ZXNzIHRoZSBxdWVzdGlvbiBpcyB3b3VsZCB5
b3Ugd2FudCAncnVudGltZV9tZWFzdXJlbWVudHNfY291bnQnIHRvCnJlZmxlY3QgdGhlIGN1cnJl
bnQvdHJpbW1lZCBsb2cgc2l6ZSBvciB3b3VsZCB5b3Ugd2FudCBpdCB0byByZWZsZWN0CnRoZSBt
ZWFzdXJlbWVudHMgc2luY2UgdGhlIGluaXRpYWwgY29sZCBib290PyAgUHJlc3VtYWJseSB3ZSB3
b3VsZAp3YW50IHRvIGFkZCBhbm90aGVyIHNlY3VyaXR5ZnMgZmlsZSB0byBoYW5kbGUgdGhlIGNh
c2Ugbm90IGNvdmVyZWQgYnkKJ3J1bnRpbWVfbWVhc3VyZW1lbnRzX2NvdW50Jy4KCj4gPiA+IEJl
Zm9yZSBkZWZpbmluZyBhIG5ldyBjcml0aWNhbC1kYXRhIHJlY29yZCwgd2UgbmVlZCB0byBkZWNp
ZGUgd2hldGhlcgo+ID4gPiBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5IG9yIGlmIGl0IGlzIHJlZHVu
ZGFudC4gIElmIHdlIGRlZmluZSBhIG5ldwo+ID4gPiAiY3JpdGljYWwtZGF0YSIgcmVjb3JkLCBj
YW4gaXQgYmUgZGVmaW5lZCBzdWNoIHRoYXQgaXQgZG9lc24ndCByZXF1aXJlCj4gPiA+IHBhdXNp
bmcgZXh0ZW5kaW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0PyAgRm9yIGV4YW1wbGUsIGEgbmV3IHNp
bXBsZQo+ID4gPiB2aXN1YWwgY3JpdGljYWwtZGF0YSByZWNvcmQgY291bGQgY29udGFpbiB0aGUg
bnVtYmVyIG9mIHJlY29yZHMgKGUuZy4KPiA+ID4gPHNlY3VyaXR5ZnM+L2ltYS9ydW50aW1lX21l
YXN1cmVtZW50c19jb3VudCkgdXAgdG8gdGhhdCBwb2ludC4KPiA+Cj4gPiBXaGF0IGlmIHRoZSBz
bmFwc2hvdF9hZ2dyZWdhdGUgd2FzIGEgaGFzaCBvZiB0aGUgbWVhc3VyZW1lbnQgbG9nCj4gPiBz
dGFydGluZyB3aXRoIGVpdGhlciB0aGUgYm9vdF9hZ2dyZWdhdGUgb3IgdGhlIGxhdGVzdAo+ID4g
c25hcHNob3RfYWdncmVnYXRlIGFuZCBlbmRpbmcgb24gdGhlIHJlY29yZCBiZWZvcmUgdGhlIG5l
dwo+ID4gc25hcHNob3RfYWdncmVnYXRlPyAgVGhlIHBlcmZvcm1hbmNlIGltcGFjdCBhdCBzbmFw
c2hvdCB0aW1lIHNob3VsZCBiZQo+ID4gbWluaW1hbCBhcyB0aGUgaGFzaCBjYW4gYmUgaW5jcmVt
ZW50YWxseSB1cGRhdGVkIGFzIG5ldyByZWNvcmRzIGFyZQo+ID4gYWRkZWQgdG8gdGhlIG1lYXN1
cmVtZW50IGxpc3QuICBXaGlsZSB0aGUgaGFzaCB3b3VsZG4ndCBjYXB0dXJlIHRoZQo+ID4gVFBN
IHN0YXRlLCBpdCB3b3VsZCBhbGxvdyBzb21lIGNydWRlIHZlcmlmaWNhdGlvbiB3aGVuIHJlYXNz
ZW1ibGluZwo+ID4gdGhlIGxvZy4gIElmIG9uZSBjb3VsZCBiZWFyIHRoZSBjb3N0IG9mIGEgVFBN
IHNpZ25pbmcgb3BlcmF0aW9uLCB0aGUKPiA+IGxvZyBkaWdlc3QgY291bGQgYmUgc2lnbmVkIGJ5
IHRoZSBUUE0uCj4KPiBPdGhlciBjcml0aWNhbCBkYXRhIGlzIGNhbGN1bGF0ZWQsIGJlZm9yZSBj
YWxsaW5nCj4gaW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YSgpLCB3aGljaCBhZGRzIHRoZSByZWNv
cmQgdG8gdGhlIG1lYXN1cmVtZW50Cj4gbGlzdCBhbmQgZXh0ZW5kcyB0aGUgVFBNIFBDUi4KPgo+
IFNpZ25pbmcgdGhlIGhhc2ggc2hvdWxkbid0IGJlIGFuIGlzc3VlIGlmIGl0IGJlaGF2ZXMgbGlr
ZSBvdGhlcgo+IGNyaXRpY2FsIGRhdGEuCj4KPiBJbiBhZGRpdGlvbiB0byB0aGUgaGFzaCwgY29u
c2lkZXIgaW5jbHVkaW5nIG90aGVyIGluZm9ybWF0aW9uIGluIHRoZQo+IG5ldyBjcml0aWNhbCBk
YXRhIHJlY29yZCAoZS5nLiB0b3RhbCBudW1iZXIgb2YgbWVhc3VyZW1lbnQgcmVjb3JkcywgdGhl
Cj4gbnVtYmVyIG9mIG1lYXN1cmVtZW50cyBpbmNsdWRlZCBpbiB0aGUgaGFzaCwgdGhlIG51bWJl
ciBvZiB0aW1lcyB0aGUKPiBtZWFzdXJlbWVudCBsaXN0IHdhcyB0cmltbWVkLCBldGMpLgoKSXQg
d291bGQgYmUgbmljZSBpZiB5b3UgY291bGQgcHJvdmlkZSBhbiBleHBsaWNpdCBsaXN0IG9mIHdo
YXQgeW91CndvdWxkIHdhbnQgaGFzaGVkIGludG8gYSBzbmFwc2hvdF9hZ2dyZWdhdGUgcmVjb3Jk
OyB0aGUgYWJvdmUgaXMKY2xvc2UsIGJ1dCBpdCBpcyBzdGlsbCBhIGxpdHRsZSBoYW5kLXdhdnku
ICBJJ20ganVzdCB0cnlpbmcgdG8gcmVkdWNlCnRoZSBiYWNrLW4tZm9ydGggOikKCi0tIApwYXVs
LW1vb3JlLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
