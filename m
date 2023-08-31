Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18759C83F10
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vIvuJre63+FRQtEeipJcacQSgAsIBLDFipoyVmUekqw=; b=ZKjfpiJZBdjnU5
	Rdy/4T8V6c80ZvLjALIngaBJEXDRVDb7gVR7dgCBDvC98BYm8APWIQa8AlsWVwfYtI1V4Ln5ZluT2
	3UOohgb8sAJUGUrDvOUITwFS9p3QI5/ACn8L2oyaMqfsayUG9raTW/fQMRUb+zpbFY5vEz8h+iFFH
	jofeMQfGNvg5JcblnxkqRejEd9Mnir4Dp7osSNGcb/N6aZTfLop/CyreX5MTlRQOcZgsxyPxnF3js
	HB2703YFve5OCRPPgKA+s1cfdpChEaEcwOSpVT/YRTnXRs+ohwhwmw/mvWRr9VA1e2Pyom0Yo0Ewp
	Y9+WvUvhG6s+thCv8IVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbith-00FS71-0J;
	Thu, 31 Aug 2023 14:43:49 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbite-00FS5R-2J
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 14:43:48 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58df8cab1f2so10674707b3.3
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693493023; x=1694097823; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5MQm3fUOAVIdvuU6wM87p/9n+mW7Iovd0grQUogv/U=;
        b=B35phsuwxzfqYvQ1kjEcV+nt5Lr6DtSxWFS/z4YTydTTuoN7Xu6uPpyamFdYs1wrU8
         ZqYmNHWHPnytK416GHtXyxcFds1DIIONsap+L1d14HRIUXi/3fEjf1OsxdrB4w2+ME9Y
         RgXyZBTCdhHZX+GqpXfy+Ppng7rDhCMVgTvO+vYre5p0e1v/KNUDxeMGa7fUUGyqqmw5
         rvbZoH2x6xXgoTOXuM2matP65gGKbi/NlNYpTWZHIDiTW7/tU4o6sHeDLsPHbrQOpba6
         o8tWnpOS0N55XyLFKGc/2OtqyvCTtXbVn2UuK/TVSX7uE3J9dx8BuRCB0UAVNPmD3QsH
         fmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493023; x=1694097823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5MQm3fUOAVIdvuU6wM87p/9n+mW7Iovd0grQUogv/U=;
        b=RCwQXSfnKNxsTsWKTqFwVe3NASN1JRQ16vSW6Gcw5pO1Mk3uxVGdXnBzc0hWi1uf47
         EGadc82chBK1pud0CDdgytO1jOAZEx2J8UlOYAkep6s/IOY/jqnif2V3/vFH4ZgRY8gc
         lM3+H/MhtdAtWIjs0WsirbHXq9qoNy2hIy1NScaydrHyvq0Mfj/Q3nLruXpCZZqsyM7W
         rpNixPjkr6N8njhgp1THQH3lh3Mot7lKGHL+5pP2n46j8ExR/3SAzvq9XzKd09ljOdCN
         Xb++JRPjrXBntALBc3wglCQFG2AJbJiZviLOAjIrSwLxzlmX/LbDlvrRSgZO4iqYqvDd
         lA1Q==
X-Gm-Message-State: AOJu0YwOX/CIBz5MfdEEfdjFCrNH6PvuTpr/BlZHaSoUi3+v+0aFsKZk
	UogtySMzI8nmkoDKRhD+hpU8Sw19w28DZL51rDMx
X-Google-Smtp-Source: AGHT+IG1r2zoUi/oJ+J5eTJZa1yrr0X+VIYEtApjtpvis+gmqeMjwcAGIlYIWjdi27/ajwxiWrA6b5fgOYrgcYdOdaI=
X-Received: by 2002:a0d:db8d:0:b0:589:a095:76ca with SMTP id
 d135-20020a0ddb8d000000b00589a09576camr5472125ywe.44.1693493022786; Thu, 31
 Aug 2023 07:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
 <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
 <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com> <99ff7c12dec73209a0a20464f3010c4c61d6c5f5.camel@linux.ibm.com>
In-Reply-To: <99ff7c12dec73209a0a20464f3010c4c61d6c5f5.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 31 Aug 2023 10:43:31 -0400
Message-ID: <CAHC9VhQbnyd2nvmL-t=3kXppsm985ps+NPJ5QDvM1WSS-Hd_Ew@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org, AmirGoldstein <amir73il@gmail.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_074346_757743_2135A3F9 
X-CRM114-Status: GOOD (  31.28  )
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

T24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMTA6MDfigK9BTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToKPiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMTk6MjIgLTA0MDAsIFBh
dWwgTW9vcmUgd3JvdGU6Cj4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA3OjA34oCvUE0gTWlt
aSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFdlZCwgMjAyMy0w
OC0zMCBhdCAxODoyMyAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIEF1
ZyAzMCwgMjAyMyBhdCA2OjIx4oCvUE0gUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA1OjUw4oCvUE0gTWltaSBa
b2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFdlZCwgMjAy
My0wOC0zMCBhdCAxNjo0NyAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gPiA+ID4gPiBP
biBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA0OjI14oCvUE0gTWltaSBab2hhciA8em9oYXJAbGludXgu
aWJtLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBZb3VyIGluaXRpYWwgcXVlc3Rpb24gd2Fz
ICJ3aGF0IGhhcHBlbnMgaWYgdGhlIGZpbGUvZmlsZXN5c3RlbSBiZWNvbWVzCj4gPiA+ID4gPiA+
ID4gPiBpbmFjY2Vzc2libGUgYXQgc29tZSBwb2ludCBhbmQgYW4gYXR0ZXN0YXRpb24gY2xpZW50
IGF0dGVtcHRzIHRvIHJlYWQKPiA+ID4gPiA+ID4gPiA+IHRoZSBlbnRpcmUgbG9nPyIuICBGb3Ig
d2hhdCByZWFzb24gd291bGQgaXQgYmUgaW5hY2Nlc3NpYmxlPyAgRm9yIHRoZQo+ID4gPiA+ID4g
PiA+ID4gb3JpZ2luYWwgc2luZ2xlIHRtcGZzIGZpbGUsIHdoYXQgd291bGQgbWFrZSBpdCBpbmFj
Y2Vzc2libGU/Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJbiB5b3VyIHJlcGx5IHRoYXQg
SSBoYWQgcmVzcG9uZGVkIHRvIHlvdSBoYWQgbWVudGlvbmVkIHRoYXQgdGhlCj4gPiA+ID4gPiA+
ID4ga2VybmVsIHdhcyBzaW1wbHkgYmVpbmcgcGFzc2VkIGEgZmQgYW5kIHRha2luZyBvd25lcnNo
aXAgb2YgaXQsIHRoZSBmZAo+ID4gPiA+ID4gPiA+IGNvdWxkIGVpdGhlciBiZSBhIHRtcGZzIGJh
Y2tlZCBmaWxlIG9yIHNvbWUgZm9ybSBvZiBwZXJzaXN0ZW50IHN0b3JhZ2UKPiA+ID4gPiA+ID4g
PiBhcyBib3RoIHdlcmUgZGlzY3Vzc2VkIGluIHRoaXMgdGhyZWFkLiAgSSBpbWFnaW5lIGEgdG1w
ZnMgZmlsZXN5c3RlbQo+ID4gPiA+ID4gPiA+IGNvdWxkIHN0aWxsIGJlIGZvcmNpYmx5IHVubW91
bnRlZCwgcmVzdWx0aW5nIGluIHByb2JsZW1zLCBidXQgSSBjYW4ndAo+ID4gPiA+ID4gPiA+IHNh
eSB0aGF0IGZvciBjZXJ0YWluLiAgSG93ZXZlciwgdGhlcmUgYXJlIGRlZmluaXRlbHkgY2FzZXMg
d2hlcmUgYSBmZAo+ID4gPiA+ID4gPiA+IGJhY2tlZCBhZ2FpbnN0IGFuIGFyYml0cmFyeSBmaWxl
c3lzdGVtIGNvdWxkIHJ1biBpbnRvIHByb2JsZW1zOgo+ID4gPiA+ID4gPiA+IHN0b3JhZ2UgZGV2
aWNlIGlzc3VlcyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMsIG5ldHdvcmtpbmcgaXNzdWVzIGZvcgo+
ID4gPiA+ID4gPiA+IG5ldHdvcmsgZmlsZXN5c3RlbXMsIGFuZCBnb29kIG9sZCBmYXNoaW9uZWQg
dXNlci9hZG1pbiBpbnRlcnZlbnRpb24gaW4KPiA+ID4gPiA+ID4gPiBib3RoIGNhc2VzLgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiAiSSBpbWFnaW5lIHRtcGZzIGZpbGVzeXN0ZW0gY291bGQgc3Rp
bGwgYmUgZm9yY2libHkgdW5tb3VudGVkIiBzb3VuZHMKPiA+ID4gPiA+ID4gbGlrZSBhbiBhdHRh
Y2suIE5vdCBiZWluZyBhYmxlIHRvIHZlcmlmeSB0aGUgbWVhc3VyZW1lbnQgbGlzdCBhZ2FpbnN0
IGEKPiA+ID4gPiA+ID4gcXVvdGUgaXMgcHJvYmFibHkgYSBnb29kIHRoaW5nLgo+ID4gPiA+ID4K
PiA+ID4gPiA+IE9rYXksIGNhbiB5b3UgYW5zd2VyIHRoZSBxdWVzdGlvbiBmb3IgYW4gYXJiaXRy
YXJ5IHBlcnNpc3RlbnQKPiA+ID4gPiA+IGZpbGVzeXN0ZW0/ICBUaGF0IHdhcyBhbHdheXMgdGhl
IG1vcmUgaW1wb3J0YW50IHF1ZXN0aW9uLCAuLi4KPiA+ID4KPiA+ID4gVGhlIG9yaWdpbmFsIHBy
b3Bvc2FsLCBub3QgbWluZSwgc3VnZ2VzdGVkIHVzaW5nIGEgdG1wZnMgZmlsZS4gICBUaGUKPiA+
ID4gaWRlYSBvZiB3cml0aW5nIHRoZSBtZWFzdXJlbWVudHMgdG8gYSBmaWxlIG9uIGEgcGVyc2lz
dGVudCBmaWxlc3lzdGVtCj4gPiA+IHdhc24ndCBtaW5lIGVpdGhlci4gIFN1c2gvVHVzaGFyIHdl
cmUgcHVzaGluZyBmb3Igd3JpdGluZyB0byBhCj4gPiA+IHBlcnNpc3RlbnQgZmlsZShzKS4gIE5v
IGFyZ3VtZW50IGZyb20gbWUgdGhhdCB3cml0aW5nIHRvIGEgZmlsZSBvbiBhbgo+ID4gPiBhcmJp
dHJhcnkgcGVyc2lzdGVudCBmaWxlc3lzdGVtIGlzIG5vdCBhIGdvb2QgaWRlYS4KPiA+Cj4gPiAu
Li4gIE9rYXksIHNvIHdlIGFsbCBub3cgYWdyZWUgdGhhdCB0aGUga2VybmVsIHdyaXRpbmcgdG8g
YW4KPiA+IGFyYml0cmFyeSBmaWxlc3lzdGVtIGlzIG5vdCBhIGdvb2QgaWRlYSwgYW5kIHVzaW5n
IHRtcGZzIGRvZXNuJ3Qgc29sdmUKPiA+IHRoZSBwcm9ibGVtIG9mIGdlbmVyYWwgbWVtb3J5IHBy
ZXNzdXJlIChmcm9tIHByZXZpb3VzbHkgaW4gdGhpcwo+ID4gdGhyZWFkKSwgdGhhdCdzIGFsbCBo
ZWxwZnVsIGFuZCBnb29kIHRvIGNsYXJpZnkuCj4KPiBEbyB3ZSBhbHNvIGFncmVlIHRoYXQgdGhl
ICJ0bXBmcyIgc29sdXRpb24gd291bGQgYWRkcmVzcyB0aGUgZXhpc3RpbmcKPiBkZXNpZ24gbW90
aXZhdGlvbiAtIGtlcm5lbCBtZW1vcnkgcHJlc3N1cmU/CgpJIGhhdmVuJ3QgcmVhbGx5IGxvb2tl
ZCBpbnRvIHRoYXQgc28gSSdtIG5vdCBjb21mb3J0YWJsZSBjb21tZW50aW5nIG9uCnRoYXQuICBJ
IGNhbiBzYXkgdGhhdCBpbiBvZmYtbGlzdCBkaXNjdXNzaW9ucyB3aXRoIFN1c2gsIFR1c2hhciwg
YW5kCm90aGVycyB0aGUgaXNzdWUgd2UgYXJlIGZhY2luZyBpcyBnZW5lcmFsIG1lbW9yeSBwcmVz
c3VyZSBzbyB1c2luZyBhbnkKdHlwZSBvZiBtZW1vcnkgYmFja2VkIGZpbGVzeXN0ZW0gZG9lc24n
dCByZWFsbHkgcmVzb2x2ZSBvdXIgcHJvYmxlbS4KCj4gPiBBc3N1bWluZyBTdXNoIGFuZCBUdXNo
YXIgcmV3b3JrIHRoZSBkb2N1bWVudCB0byBjbGFyaWZ5IHRoZQo+ID4gbW90aXZhdGlvbi9wdXJw
b3NlIGZvciB0aGUgd29yaywgYXMgeW91IHN1Z2dlc3RlZCBlYXJsaWVyLCBJJ20KPiA+IGFzc3Vt
aW5nIHdlIGNhbiByZXZpc2l0IHRoaXMgcHJvYmxlbSBhbmQgc29sdXRpb25zPwo+Cj4gSW4gYWRk
aXRpb24gdG8gdGhlIG1pc21hdGNoIGJldHdlZW4gdGhlIG1vdGl2YXRpb24gYW5kIHRoZSBkZXNp
Z24sIHRoZQo+IGRlc2lnbiBoYXMgc29tZSBtYWpvciBmbGF3cyB0aGF0IGZpcnN0IG5lZWQgdG8g
YmUgYWRkcmVzc2VkLgo+Cj4gQXNzdW1pbmcgdGhlIGRlc2lnbiBpc3N1ZXMgYXJlIGFkZHJlc3Nl
ZCwgcGxlYXNlIG1ha2Ugc3VyZSB0aGUgZG9jdW1lbnQKPiBpcyB3cml0dGVuIGNsZWFybHkgYW5k
IGNvbmNpc2VseS4KClRoYXQgZmVlbHMgbGlrZSBhIG5vcm1hbCBwYXJ0IG9mIHRoZSBkZXNpZ24s
IHJldmlldywgYW5kIGl0ZXJhdGUgY3ljbGUKdG8gbWUuICBTdXNoIGFuZCBUdXNoYXIgYXJlIGZv
bGxvd2luZyBhbG9uZyBhbmQgSSdtIHN1cmUgdGhleSB3aWxsCnRha2UgYWxsIG9mIHRoYXQgaW50
byBhY2NvdW50IGluIHRoZSBuZXh0IHJldmlzaW9uIG9mIHRoZSBkZXNpZ24KZG9jdW1lbnQuCgot
LSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
