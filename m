Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE60C6FA8F
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 23:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zi3PHBGOrsKXtky1TB8C/Kzv3aYTCKJ6lyAXkaCEoMo=; b=YiEHLR+pBTYoCJ
	2eWxSit/2ZU9/zHxPpJol1qlT7LKnH9fjldR8PF+Ssc5Bt9GCVEByuuogBDumxq+Mv+fVRuUBvpNM
	iL4KSWk0fKY6SOEDRdYCC+01Fnzl/GNDHJ6aWdmLfNjm30AgMdcbyUEuiRNPg2Nl/Q3AaY1ktoQ3X
	ypoKB60VnnYSas1IdeII46WRBDe4VaRX0T1mMT1vSIr6rYyXxnDgtrzq8VUV1ijpxpTnWkQsArg0H
	gyiai0Bd+SAxNxC4nC3wychR2kzIiW76oNIlNgHIfyPka+051K2MvdK5Uy2KZaT8jGVsN0fdDTVYd
	T15R9KsyyrY+tg7SPKTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb7vn-00CRDD-2o;
	Tue, 29 Aug 2023 23:15:31 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb7vk-00CRCb-27
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 23:15:30 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-594ebdf7bceso39424737b3.2
        for <kexec@lists.infradead.org>; Tue, 29 Aug 2023 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693350927; x=1693955727; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vTa4PdCZfjFG5lHc4dNqG+0XSK9QBpqhYShWqlnoIo=;
        b=fRtytNAyFe7UXyvGZ0UmRsgK05CXO4cweMXuvaahmSGSI5d59cLj5Joc0HzxOKQ0nS
         PgXtwllIYXgUpZfSfMTNMrcXaZUT12uaw2waUMVbdVfKVFCryakGvsXO0XOH0IrAa/Wf
         UaFpkxVQqVtBJtGfQb+q9VkHeea06pgpxBdCPrt76JCdu88MYWae3g8d4waFIroQfpmO
         KJMonyYeecwclP+1gUdI0FH9C7oeVNnDqCJJwWYKKWb7l2oJjX9N2Bw6ZJdRr9vHWXVF
         T7lLPqk3yQIBVprquT/XS+CZGWsTr2lMFhRlD74Wo/I857r5cCVSHKrG3Gkl/A29F3ZW
         +JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693350927; x=1693955727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vTa4PdCZfjFG5lHc4dNqG+0XSK9QBpqhYShWqlnoIo=;
        b=Cbwe5M47PAuGZ89BEkkIlA6bzi7TAoKHYrbjoSa8v0tjsH41dzX/OtEDomY/I7KRds
         3YbuvJvPMMTwgfzLMomH/8pokV7khUZWgIO2zNOSLXTZqVrVqJwGoj3uV+auUVFu8HM/
         2KEH7zpURkqMMgUBzey8PUlkpT94xyKbgJ0L/I7YcpinhuQzfOPQlTojnOhXE8YBfoPn
         3KeSCEABFXhkadtzKdaN1B/MtGlRNE5gBW1wZYUoc8PIp9CN2ln5KW7vx2dIXCuwtNo/
         XOXq8pGUINWhLy3ZxJpxbhlkOn1C5C3aaT5v98wZwL/b8t31bbJGFW//brWQW5/4UN6Y
         2OrA==
X-Gm-Message-State: AOJu0Yz8VUpEMmEpHumW3i/J5t0FF6tQtEY0sw718uyTK268PZFZrD2g
	0JMWCbytXR5e9E519ItfiSp2x65mdHAibFHbOwmM
X-Google-Smtp-Source: AGHT+IEfAIghQaOyFnhkOGghnSvmH8Q49mVxjPxt1pfkRStK7iBX7xSiHCbitdTjS+woAotcGaHR8STcdKo5RHy6JPA=
X-Received: by 2002:a81:9204:0:b0:569:479f:6d7f with SMTP id
 j4-20020a819204000000b00569479f6d7fmr407224ywg.43.1693350926827; Tue, 29 Aug
 2023 16:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com> <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
In-Reply-To: <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Aug 2023 19:15:15 -0400
Message-ID: <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230829_161528_691124_A2B2BEF5 
X-CRM114-Status: GOOD (  40.59  )
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

T24gVHVlLCBBdWcgMjksIDIwMjMgYXQgNTo1NOKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgMjAyMy0wOC0yOSBhdCAxNzozMCAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIFR1ZSwgQXVnIDI5LCAyMDIzIGF0IDU6MDXigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gT24gVHVlLCAyMDIzLTA4
LTI5IGF0IDE1OjM0IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgQXVn
IDIxLCAyMDIzIGF0IDc6MDjigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgMjAyMy0wOC0yMSBhdCAxNTowNSAtMDcwMCwgU3VzaCBT
aHJpbmdhcnB1dGFsZSB3cm90ZToKPiA+ID4gPiA+ID4gT24gOC8xNC8yMDIzIDM6MDIgUE0sIE1p
bWkgWm9oYXIgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCAyMDIzLTA4LTE0IGF0IDE0OjQy
IC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID4gPiA+ID4gPiA+Pj4gVGhpcyBk
ZXNpZ24gc2VlbXMgb3Zlcmx5IGNvbXBsZXggYW5kIHJlcXVpcmVzIHN5bmNocm9uaXphdGlvbiBi
ZXR3ZWVuCj4gPiA+ID4gPiA+ID4+PiB0aGUgInNuYXBzaG90IiByZWNvcmQgYW5kIGV4cG9ydGlu
ZyB0aGUgcmVjb3JkcyBmcm9tIHRoZSBtZWFzdXJlbWVudAo+ID4gPiA+ID4gPiA+Pj4gbGlzdC4g
IE5vbmUgb2YgdGhpcyB3b3VsZCBiZSBuZWNlc3NhcnkgaWYgdGhlIG1lYXN1cmVtZW50cyB3ZXJl
IGNvcGllZAo+ID4gPiA+ID4gPiA+Pj4gZnJvbSBrZXJuZWwgbWVtb3J5IHRvIGEgYmFja2luZyBm
aWxlIChlLmcuIHRtcGZzKSwgYXMgZGVzY3JpYmVkIGluIFsxXS4KPiA+ID4gPiA+ID4gRXZlbiBp
ZiB0aGUgS2VybmVsIG1haW50YWlucyB0aGUgbGluayBiZXR3ZWVuIGEgdG1wZnMgZXhwb3J0ZWQg
YW5kIGFuCj4gPiA+ID4gPiA+IGluLW1lbW9yeSBJTUEgbG9nIC0gaXQgc3RpbGwgaGFzIHRvIGNv
cHkgdGhlIHRtcGZzIHBvcnRpb24gdG8gdGhlCj4gPiA+ID4gPiA+IEtlcm5lbCBtZW1vcnkgZHVy
aW5nIGtleGVjIHNvZnQgYm9vdC4gIHRtcGZzIGlzIGNsZWFyZWQgZHVyaW5nIGtleGVjLAo+ID4g
PiA+ID4gPiBzbyB0aGlzIGNvcHlpbmcgb2YgdG1wZnMgYmFjayB0byBrZXJuZWwgbWVtb3J5IGlz
IG5lY2Vzc2FyeSB0byBwcmVzZXJ2ZQo+ID4gPiA+ID4gPiB0aGUgaW50ZWdyaXR5IG9mIHRoZSBs
b2cgZHVyaW5nIGtleGVjLiAgQnV0IHRoZSBjb3B5aW5nIHdvdWxkIGFkZCBiYWNrCj4gPiA+ID4g
PiA+IHRoZSBtZW1vcnkgcHJlc3N1cmUgb24gdGhlIG5vZGUgZHVyaW5nIGtleGVjICh3aGljaCBt
YXkgcmVzdWx0IGluCj4gPiA+ID4gPiA+IG91dC1vZi1tZW1vcnkpLCBkZWZlYXRpbmcgdGhlIHB1
cnBvc2Ugb2YgdGhlIG92ZXJhbGwgZWZmb3J0L2ZlYXR1cmUuCj4gPiA+ID4gPiA+IENvcHlpbmcg
dG8gYSByZWd1bGFyICpwZXJzaXN0ZW50KiBwcm90ZWN0ZWQgZmlsZSBzZWVtcyBhIGNsZWFuZXIK
PiA+ID4gPiA+ID4gYXBwcm9hY2gsIGNvbXBhcmVkIHRvIHRtcGZzLgo+ID4gPiA+ID4KPiA+ID4g
PiA+IEZyb20gYSBrZXJuZWwgcGVyc3BlY3RpdmUsIGl0IGRvZXNuJ3QgbWFrZSBhIGRpZmZlcmVu
Y2UgaWYgdXNlcnNwYWNlCj4gPiA+ID4gPiBwcm92aWRlcyBhIHRtcGZzIG9yIHBlcnNpc3RlbnQg
ZmlsZS4gIEFzIHBlciB0aGUgZGlzY3Vzc2lvbgo+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtaW50ZWdyaXR5L0NBT1E0dXhqNFB2MldyMXdndkJDRFItdG5BNWRzWlQzcnZk
RHpLZ0FIMWFFVl8tcjlRZ0BtYWlsLmdtYWlsLmNvbS8jdAo+ID4gPiA+ID4gLCB1c2Vyc3BhY2Ug
cHJvdmlkZXMgdGhlIGtlcm5lbCB3aXRoIHRoZSBmaWxlIGRlc2NyaXB0b3Igb2YgdGhlIG9wZW5l
ZAo+ID4gPiA+ID4gZmlsZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFdlIHByb3RvdHlwZWQgdGhp
cyBzb2x1dGlvbiwgaG93ZXZlciBpdAo+ID4gPiA+ID4gPiBkb2VzIG5vdCBzZWVtIHRvIGJlIGEg
Y29tbW9uIHBhdHRlcm4gd2l0aGluIHRoZSBLZXJuZWwgdG8gd3JpdGUgc3RhdGUKPiA+ID4gPiA+
ID4gZGlyZWN0bHkgdG8gZmlsZXMgb24gZGlzayBmaWxlIHN5c3RlbXMuICBXZSBjb25zaWRlcmVk
IHR3byBwb3RlbnRpYWwKPiA+ID4gPiA+ID4gb3B0aW9uczoKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJ
ZiBubyBmaWxlIGRlc2NyaXB0b3IgaXMgcHJvdmlkZWQsIHRoZW4gdGhlIG1lYXN1cmVtZW50cyBh
cmVuJ3QgY29waWVkCj4gPiA+ID4gPiBhbmQgcmVtb3ZlZCBmcm9tIHRoZSBzZWN1cml0eWZzIGZp
bGUuICBJZiB0aGVyZSBhcmUgd3JpdGUgZXJyb3JzLCB0aGUKPiA+ID4gPiA+IG1lYXN1cmVtZW50
cyBhcmVuJ3QgcmVtb3ZlZCBmcm9tIHRoZSBzZWN1cml0eWZzIGZpbGUgdW50aWwgdGhlIHdyaXRl
Cj4gPiA+ID4gPiBlcnJvcnMgYXJlIHJlc29sdmVkLgo+ID4gPiA+Cj4gPiA+ID4gSXQgc291bmRz
IGxpa2UgdGhpcyBhcHByb2FjaCB3b3VsZCByZXF1aXJlIHRoZSBmaWxlL2ZpbGVzeXN0ZW0gdG8g
YmUKPiA+ID4gPiBjb250aW51b3VzbHkgYXZhaWxhYmxlIGZvciB0aGUgbGlmZSBvZiB0aGUgc3lz
dGVtIG9uY2UgdGhlIGxvZyB3YXMKPiA+ID4gPiBzbmFwc2hvdHRlZC9vdmVyZmxvd2VkIHRvIHBl
cnNpc3RlbnQgc3RvcmFnZSwgeWVzPyAgQXNzdW1pbmcgdGhhdCBpcwo+ID4gPiA+IHRoZSBjYXNl
LCB3aGF0IGhhcHBlbnMgaWYgdGhlIGZpbGUvZmlsZXN5c3RlbSBiZWNvbWVzIGluYWNjZXNzaWJs
ZSBhdAo+ID4gPiA+IHNvbWUgcG9pbnQgYW5kIGFuIGF0dGVzdGF0aW9uIGNsaWVudCBhdHRlbXB0
cyB0byByZWFkIHRoZSBlbnRpcmUgbG9nPwo+ID4gPgo+ID4gPiBUaGUgbWFpbiBwdXJwb3NlIG9m
IHRoZSBjaGFuZ2UgaXMgdG8gYWRkcmVzIGtlcm5lbCBtZW1vcnkgcHJlc3N1cmUuCj4gPiA+IFR3
byBkZXNpZ25zIGFyZSBiZWluZyBkaXNjdXNzZWQ6IFN1c2gncyAic25hcHNob3R0aW5nIiBkZXNp
Z24gYW5kCj4gPiA+IEFtaXIncyBvcmlnaW5hbCBzdWdnZXN0aW9uIG9mIGNvbnRpbm91c2x5IGV4
cG9ydGluZyB0aGUgbWVhc3VyZW1lbnQKPiA+ID4gcmVjb3JkcyB0byBhIHRtcGZzIG9yIHJlZ3Vs
YXIgZmlsZS4gIEJvdGggZGVzaWducyByZXF1aXJlIHZlcmlmeWluZyB0aGUKPiA+ID4gaW5pdGlh
bCBhdHRlc3RhdGlvbiBxdW90ZSBieSB3YWxraW5nIHRoZSBlbnRpcmUgbWVhc3VyZW1lbnQgbGlz
dCwKPiA+ID4gY2FsY3VsYXRpbmcgdGhlIGV4cGVjdGVkIFRQTSBQQ1IgdmFsdWUocykuICBUaGF0
IGRvZXNuJ3QgY2hhbmdlLgo+ID4KPiA+IFN1cmUsIGJ1dCBteSBxdWVzdGlvbiBpcyBhYm91dCB3
aGF0IGhhcHBlbnMgaWYgcG9ydGlvbnMgb2YgdGhlCj4gPiBtZWFzdXJlbWVudCBsaXN0IGRpc2Fw
cGVhciBkdWUgdG8gZmlsZS9maWxlc3lzdGVtIHByb2JsZW1zPyAgSG93IGlzCj4gPiB0aGF0IGhh
bmRsZWQ/Cj4KPiBXaXRoIHRoZSAic25hcHNob3R0aW5nIiBzb2x1dGlvbiB0aGVyZSBjb3VsZCBi
ZSBtdWx0aXBsZSBmaWxlcywgc28KPiBwb3J0aW9ucyBjb3VsZCBiZSBtaXNzaW5nLiAgVGhlIG90
aGVyIHNvbHV0aW9uLCB0aGUgcHJlZmVycmVkIHNvbHV0aW9uLAo+IHdvdWxkIGJlIG9uZSBmaWxl
LgoKV2l0aCB0aGUgc25hcHNob3R0aW5nIGFwcHJvYWNoIHRoZSBrZXJuZWwgZG9lc24ndCBuZWVk
IHRvIG1haW50YWluCm9uZ29pbmcgYWNjZXNzIHRvIGEgZmlsZSwgdGhhdCBpcyBsZWZ0IHVwIHRv
IHRoZSB1c2VyIHByb2Nlc3MKcGVyZm9ybWluZyB0aGUgYXR0ZXN0YXRpb24gKG9yIHNpbXBseSBp
bnNwZWN0aW5nIHRoZSBsb2dzKS4gIEkgaGF2ZSB0bwphc2ssIGZvciB0aGUgdGhpcmQgdGltZSBu
b3cgaW4gYXMgbWFueSBob3VycywgaG93IGRvZXMgdGhlIHByb3Bvc2VkCmtlcm5lbC1ob2xkcy1h
bi1mZC1vcGVuIHNvbHV0aW9uIGhhbmRsZSB0aGUgY2FzZSB3aGVyZSB0aGUKZmlsZS9maWxlc3lz
dGVtIGlzIG5vIGxvbmdlciBhY2Nlc3NpYmxlPyAgVGhlIHNuYXBzaG90dGluZyBhcHByb2FjaApz
aG91bGQgYmUgbXVjaCBtb3JlIHJlc2lsaWVudCBoZXJlIGFzIHRoZSBlcnJvciByZWNvdmVyeSBw
YXRocyBjYW4gYmUKbXVjaCBtb3JlIGludm9sdmVkIHRoYW4gd2hhdCB3ZSB3b3VsZCBoYXZlIGF2
YWlsYWJsZSBpbiB0aGUga2VybmVsLApub3QgdG8gbWVudGlvbiB0aGUgZmxleGliaWxpdHkgb2Yg
YWxsb3dpbmcgYSB1c2VyIHByb2Nlc3MgdG8gZGV0ZXJtaW5lCmhvdyB0byBzdG9yZSBhbmQgbWFu
YWdlIHRoZSBzbmFwc2hvdHRlZCBsb2cuCgpDb25zaWRlcmluZyB0aGF0IHRoZSBzbmFwc2hvdHRp
bmcgYXBwcm9hY2ggaXMgb3B0LWluICh1c2Vyc3BhY2UgaGFzIHRvCmluaXRpYXRlIHRoZSBzbmFw
c2hvdCksIEknbSBub3Qgc3VyZSB0aGUgY29uY2VybiBvdmVyIGxvZyBvZmZzZXRzIGlzIGEKc2ln
bmlmaWNhbnQgb2JqZWN0aW9uOiBleGlzdGluZyB1c2Vyc3BhY2Ugd2lsbCBuZXZlciB0cmlnZ2Vy
IGEKc25hcHNob3QsIGFuZCBuZXcgdXNlcnNwYWNlIHRoYXQgY291bGQgcG90ZW50aWFsbHkgdHJp
Z2dlciBhIHNuYXBzaG90CnNob3VsZCBiZSB3cml0dGVuIHRvIHRha2UgdGhhdCBpbnRvIGFjY291
bnQuCgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
