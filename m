Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AD1C52D7C
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uPwXEk6VB+lrIMIjnKOOyBYsl86TawbQWwM+kQ8LbUQ=; b=wFN527LKtvXdvA
	UfNadHXpF1Q7h+4khgfwHpiQwdkVFDj2Wr8LTZ8UEbHEnal0akjIFx0K8wlpJppdqS5lwR/CwLJmo
	v3ui7vWrC4TbDIWH/LQqpOOdCbrTJ+5r81D7ccEFCSzkcK7juD/lam2lNap5RXAXA3393+/4kH/JZ
	TZgzYUUTsDj/LL4zVnN2I1tHd3csWhKPy7uZ2tbw/8UVXGAOooKBnHpXuyYH3EXqr1Eos4wIOpGpa
	wtRPIl+TqOWmnn3RSDyZPw8CSoMakdehTOhW+uRkXzrml3O8EOLQ4MmrZBhWBwSoqEr4wGvwxK5nH
	UBK8bqNPDI/trm8xBdyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh8oz-0000000D9oJ-3WDe;
	Thu, 22 Aug 2024 14:29:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh8ow-0000000D9nZ-2yPO
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 14:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724336989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/6AxOb6WsbLr7G2jGoOD1ehnx93Ji/pJCnzGUX2sbo=;
	b=VvEQETAZI9f4MwJYhM+DezTjgy5kE9PktbrmnUWpAnsEfAmgPjI9QPpA84N/7knsp1ltQR
	URfwCgw20VuOWSAfNZuhTZct5Y+lGinmt11jUP060AHWlqgMrhPgsne5GY01WT7LpgUthR
	X6v6LE81Pua/WM+e5MHLpRTa5RYuins=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-GTvloPiGNUm_iKdy7_2HSw-1; Thu, 22 Aug 2024 10:29:43 -0400
X-MC-Unique: GTvloPiGNUm_iKdy7_2HSw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5daa71823e0so968524eaf.2
        for <kexec@lists.infradead.org>; Thu, 22 Aug 2024 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336983; x=1724941783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/6AxOb6WsbLr7G2jGoOD1ehnx93Ji/pJCnzGUX2sbo=;
        b=XiBibgCgKkKuYqKx0IgktdYkUF/dVmtw01+vjjbIB8S+10oL1rNvQv6htYNcT/b83g
         RG4bn3LKvJbyGg4YNbfY6UAxXGP+uh91pNVNpzVLbSpcaZeFt7uNNLszwr25Avz8htav
         xWtL34znqfZjDXlRtenNrlojfFCRAr2coYq+mWay95dg8FPEWPs76I1hS3gWUZIAD1gL
         OAM9YIC1TggaoJe2hjqCzlhydYVwLrY4UShh9cjtj6H6M83DkkZylzvcpzWEyZXgXRnw
         WAG81lRorcVzwRzffVtlnTcYDFGTWZOorAEVqy4rw5gy04BXHmF5ZWCKfSortzoVajkN
         000A==
X-Forwarded-Encrypted: i=1; AJvYcCWoxy3yKLALjtn1rCSkFXqZjmbiuWwy2+Ppdc3XAj8jcBzqVI7F8jL+BcR+GKmmJyQNLVFZ1w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwOEoK/f2f1Ql9b8xJK5ySb8ig0FFQDd0GXt/2GRPUEgnVNCOTA
	qPjFH31uKpyhLw73xCqhnVfIlm2cyvwVNyC5ugeoH2NO/KzGobOT6DjaZJomBVgWFgGowotNmU7
	kzcZx9HSDYs29HFP+3aWhGuvkMf8EfiOGOV3iv2UdQ3NWhgKlTfyyUkUWg9CmNefooHgiWQV+hE
	lQ3mtW8J6k4ZVA5QEAy0U64M4EkOKY6X/L
X-Received: by 2002:a05:6358:980d:b0:1b5:a037:f238 with SMTP id e5c5f4694b2df-1b5a037f311mr612518055d.0.1724336982759;
        Thu, 22 Aug 2024 07:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+brQfGyYU0BpsvYX3In5ntxKlxV2usDwSemakngx24acx/det+Wm07KEOH4KNbGPDEw/r7dG0Fhsa3BZCjPg=
X-Received: by 2002:a05:6358:980d:b0:1b5:a037:f238 with SMTP id
 e5c5f4694b2df-1b5a037f311mr612515255d.0.1724336982430; Thu, 22 Aug 2024
 07:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <Zsb1isJ2cYRp2jpj@gardel-login>
In-Reply-To: <Zsb1isJ2cYRp2jpj@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 22:29:31 +0800
Message-ID: <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_072950_971094_2B6BD82F 
X-CRM114-Status: GOOD (  40.55  )
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

T24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgNDoyM+KAr1BNIExlbm5hcnQgUG9ldHRlcmluZyA8bXp4
cmVhcnlAMHBvaW50ZXIuZGU+IHdyb3RlOgo+Cj4gT24gRG8sIDIyLjA4LjI0IDEzOjQyLCBQaW5n
ZmFuIExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3JvdGU6Cj4KPiAgPiBPbiBXZWQsIEF1ZyAyMSwg
MjAyNCBhdCAxMDoyN+KAr1BNIExlbm5hcnQgUG9ldHRlcmluZwo+ID4gPG16eHJlYXJ5QDBwb2lu
dGVyLmRlPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW8sIDE5LjA4LjI0IDIyOjUzLCBQaW5nZmFu
IExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3JvdGU6Cj4gPiA+Cj4gPiA+ID4gKioqIEJhY2tncm91
bmQgKioqCj4gPiA+ID4KPiA+ID4gPiBBcyBtb3JlIFBFIGZvcm1hdCBrZXJuZWwgaW1hZ2VzIGFy
ZSBpbnRyb2R1Y2VkLCBpdCBwb3N0IGNoYWxsZW5nZSB0byBrZXhlYyB0bwo+ID4gPiA+IGNvcGUg
d2l0aCB0aGUgbmV3IGZvcm1hdC4KPiA+ID4gPgo+ID4gPiA+IEluIG15IGF0dGVtcHQgdG8gYWRk
IHN1cHBvcnQgZm9yIGFybTY0IHpib290IGltYWdlIGluIHRoZSBrZXJuZWwgWzFdLAo+ID4gPiA+
IEFyZCBzdWdnZXN0ZWQgdXNpbmcgYW4gZW11bGF0b3IgdG8gdGFja2xlIHRoaXMgaXNzdWUuICBM
YXN0IHllYXIsIHdoZW4KPiA+ID4gPiBKYW4gdHJpZWQgdG8gaW50cm9kdWNlIFVLSSBzdXBwb3J0
IGluIHRoZSBrZXJuZWwgWzJdLCBBcmQgbWVudGlvbmVkIHRoZQo+ID4gPiA+IGVtdWxhdG9yIGFw
cHJvYWNoIGFnYWluIFszXQo+ID4gPgo+ID4gPiBIbW0sIHN5c3RlbWQncyBzeXN0ZW1kLXN0dWIg
Y29kZSB0cmllcyB0byBsb2FkIGNlcnRhaW4gInNpZGUtY2FyIgo+ID4gPiBmaWxlcyBwbGFjZWQg
bmV4dCB0byB0aGUgVUtJLCB2aWEgdGhlIFVFRkkgZmlsZSBzeXN0ZW0gQVBJcy4gV2hhdCdzCj4g
PiA+IHlvdXIgaW50ZW50aW9uIHdpdGggdGhlIFVFRkkgZW11bGF0b3IgcmVnYXJkaW5nIHRoYXQ/
IFRoZSBzaWRlY2FycyBhcmUKPiA+ID4gc29tZXdoYXQgaW1wb3J0YW50LCBiZWNhdXNlIHRoYXQn
cyBob3cgd2UgcGFyYW1ldGVyaXplIG90aGVyd2lzZQo+ID4gPiBzdHJpY3RseSBzZWFsZWQsIGlt
bXV0YWJsZSBVS0lzLgo+ID4gPgo+ID4gSUlVQywgeW91IGFyZSByZWZlcnJpbmcgdG8gVUtJIGFk
ZG9ucy4KPgo+IFllYWgsIFVLSSBhZGRvbnMsIGFzIHdlbGwgYXMgY3JlZGVudGlhbCBmaWxlcywg
YW5kIHN5c2V4dC9jb25mZXh0Cj4gRERJcy4KPgo+IFRoZSBhZGRvbnMgYXJlIHRoZSBtb3N0IGlu
dGVyZXN0aW5nIGJ0dywgYmVjYXVzZSB3ZSBsb2FkIHRoZW0gaW50bwo+IG1lbW9yeSBhcyBQRSBm
aWxlcywgYW5kIGFzayB0aGUgVUVGSSB0byBhdXRoZW50aWNhdGUgdGhlbS4KPgo+ID4gPiBIZW5j
ZSwgd2hhdCdzIHRoZSBzdG9yeSB0aGVyZT8gaW1wbGVtZW50IHNvbWUgZm9ybSBvZiBmcyBkcml2
ZXIgKGZvcgo+ID4gPiB3aGF0IGZzIHByZWNpc2VseT8pIGluIHRoZSBlbXVsYXRvciB0b28/Cj4g
PiA+Cj4gPiBBcyBmb3IgYWRkb24sIHRoYXQgaXMgYSBtaXNzaW5nIHBhcnQgaW4gdGhpcyBzZXJp
ZXMuIEkgaGF2ZSBvdmVybG9va2VkCj4gPiB0aGlzIGlzc3VlLiBPcmlnaW5hbGx5LCBJIHRob3Vn
aHQgdGhhdCB0aGVyZSB3YXMgbm8gbmVlZCB0byBpbXBsZW1lbnQKPiA+IGEgZGlzayBkcml2ZXIg
YW5kIHZmYXQgZmlsZSBzeXN0ZW0sIGp1c3QgcHJlbG9hZCB0aGVtIGludG8gbWVtb3J5LCBhbmQK
PiA+IGZpbmFsbHkgcHJlc2VudCB0aGVtIHRocm91Z2ggdGhlIHVlZmkgQVBJLiBJIHdpbGwgdGFr
ZSBhIGNsb3NlciBsb29rCj4gPiBhdCBpdCBhbmQgY2hldyBvbiBpdC4KPgo+IEl0IGRvZXNuJ3Qg
aGF2ZSB0byBiZSBWRkFUIGJ0dy4gSXQganVzdCBoYXMgdG8gYmUgc29tZXRoaW5nLiBGb3IKPiBl
eGFtcGxlLCBpdCBtaWdodCBzdWZmaWNlIHRvIHRha2UgdGhlc2UgZmlsZXMsIHBhY2sgdGhlbSB1
cCBhcyBjcGlvIG9yCj4gc28gYW5kIHBhc3MgdGhlbSBhbG9uZyB3aXRoIHRoZSBVRUZJIGV4ZWN1
dGlvbi4gVGhlIFVFRkkgZW11bGF0b3IKPiB3b3VsZCB0aGVuIGhhdmUgdG8gZXhwb3NlIHRoZW0g
YXMgYSBmaWxlIHN5c3RlbSB0aGVuLgo+Cj4gV2UgYXJlIG5vdCB0YWxraW5nIG9mIGEgYmF6aWxs
aW9uIG9mIGZpbGVzIGhlcmUsIGl0J3MgbW9zdGx5IGEKPiBzbWFsbGlzaCBudW1iZXIgb2Ygc2lk
ZWNhciBmaWxlcyBJJ2QgZXhwZWN0Lgo+Cj4gPiA+IEFuZCByZWdhcmRpbmcgdHBtPyB0cG1zIHJl
cXVpcmUgZHJpdmVycyBhbmQgaSBndWVzcyBhdCB0aGUgbW9tZW50IHVlZmkKPiA+ID4gZW11bGF0
b3Igd291bGQgcnVuIHRob3NlIGFyZW4ndCBhdmFpbGFibGUgYW55bW9yZT8gYnV0IHdlIHJlYWxs
eQo+ID4gPiBzaG91bGQgZG8gYSBzZXBhcmF0b3IgbWVhc3VyZW1lbnQgdGhlbi4gKGFsc28gdGhl
cmUgbmVlZHMgdG8gYmUgc29tZQo+ID4gPiB3YXkgdG8gcGFzcyBvdmVyIG1lYXN1cmVtZW50IGxv
ZyBvZiB0aGF0IG1lYXN1cmVtZW50PykKPiA+Cj4gPiBJdCBpcyBhIHBpdHkgdGhhdCBpdCBpcyBh
IGNvbW1vbiBpc3N1ZSBwZXJzaXN0ZW50IHdpdGgga2V4ZWMtcmVib290Cj4gPiBrZXJuZWwgbm93
YWRheXMuCj4gPiBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIFRQTSBhbmQgaGF2ZSBubyBjbGVhciBp
ZGVhIGZvciB0aGUgdGltZSBiZWluZy4KPiA+IChlbXVsYXRpbmcgUGxhdGZvcm0gQ29uZmlndXJh
dGlvbiBSZWdpc3RlcnMgPykuICBCdXQgc2luY2UgdGhpcwo+ID4gZW11bGF0b3IgaXMgaGVsZCBp
bnNpZGUgYSBsaW51eCBrZXJuZWwgaW1hZ2UsIGFuZCB0aGUgVUtJJ3Mgc2lnbmF0dXJlCj4gPiBp
cyBjaGVja2VkIGR1cmluZyBrZXhlY19maWxlX2xvYWQuIEFsbCBvZiB0aGVtIGFyZSBzYWZlIGZy
b20KPiA+IG1vZGlmaWNhdGlvbiwgdGhpcyBzZWN1cml0eSBpcyBub3QgYW4gdXJnZW50IGlzc3Vl
Lgo+Cj4gSG1tLCBJJ2QgcmVhbGx5IHRoaW5rIGFib3V0IHRoaXMgd2l0aCBzb21lIHByaW9yaXR5
LiBUaGUgbWVhc3VyZW1lbnQKPiBzdHVmZiBzaG91bGQgbm90IGJlIGFuIGFmdGVydGhvdWdodCwg
aXQgdHlwaWNhbGx5IGhhcyBtYWpvcgo+IGltcGxpY2F0aW9ucyBvbiBob3cgeW91IGRlc2lnbiB5
b3VyIHRyYW5zaXRpb25zLCBiZWNhdXNlIG1lYXN1cmVtZW50cwo+IG9mIHNvbWUgY29tcG9uZW50
IGFsd2F5cyBuZWVkIHRvIGhhcHBlbiAqYmVmb3JlKiB5b3UgcGFzcyBjb250cm9sIHRvCj4gaXQs
IG90aGVyd2lzZSB0aGV5IGFyZSBwb2ludGxlc3MuCj4KCkF0IHByZXNlbnQsIG15IGVtdWxhdG9y
IHJldHVybnMgZmFsc2UgdG8gaXNfZWZpX3NlY3VyZV9ib290KCksIHNvCnN5c3RlbWQtc3R1YiBk
b2VzIG5vdCBjYXJlIGFib3V0IHRoZSBtZWFzdXJlbWVudCwgYW5kIG1vdmVzIG9uLgoKQ291bGQg
eW91IGVubGlnaHRlbiBtZSBhYm91dCBob3cgc3lzdGVtZCB1dGlsaXplcyB0aGUgbWVhc3VyZW1l
bnQ/IEkKZ3JlcHBlZCAnVFBNMl9QQ1JfS0VSTkVMX0NPTkZJRycsIGFuZCBzYXcgdGhlIHN5c3Rl
bWQtc3R1YiBhc2tzIHRvCmV4dGVuZCBQQ1IuIEJ1dCB3aGVyZSBpcyB0aGUgdmFsdWUgY2hlY2tl
ZD8gSSBndWVzcyB0aGUgc3lzdGVtZCB3aWxsCmhhbmcgaWYgdGhlIGNoZWNrIGZhaWxzLgoKVGhh
bmtzLAoKUGluZ2ZhbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
