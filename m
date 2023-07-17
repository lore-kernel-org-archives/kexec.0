Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C77C001B0
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/8mY7PEfg/rKRQacLLe80ZByjE1ED9+CauuJfuy9cUI=; b=L4EOqBNkYgoyF7
	y9c7fOaCCS7IWotmlJoruScYlNkK4w3roGyAuAgXRWBh1B9d2RqQ6qV3+PM3FyjfrnP53wYFQ+2fh
	XsDvp7TFdlcdGzoVMlsUtxIOykDbeQ8tTrN61ayzHQqLjjhXC0POfcMVOI/+ZH0nNJISodVe89HRZ
	0KrxMGON8HW42cawIC5+vtOje/Nr3aDIibGVTesyEuuxdQoXvf/ee0B8mUld7uUE85I2pJtb6XR7b
	8Of3jmhCseklnlI+RJ8pfx9c4uaDoozOGtH6cx9gnZPwhGG5EMYsgMP8qo6lzJeSF1xz7Rh8R5aib
	7+kkuJILSqpDSo3w3xTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPAo-004FLI-0V;
	Mon, 17 Jul 2023 14:26:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPA0-004FFt-2D
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 14:25:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689603911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg+GsbYLB4O3WTuuQwregxIHX9P5sA4QNLHVsEdZbKc=;
	b=ab2dzQahp+WSdgYjVlPCB3gd2Wr2cieYk2NlbtLH2dCxtc1iSllWcsXC/8fY8XRM/TL5qs
	4vQZTQujB8nkbdTnMUu9+6dZROZthDeEGJPETigZIFN0G05p/pZhPNG6fbTJPhGoXBhywW
	T3loiawFqRjn9UxsbdyNVl3wDlgF1TA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Ts_Tyo1cM6qcwiS9LEXydg-1; Mon, 17 Jul 2023 10:25:10 -0400
X-MC-Unique: Ts_Tyo1cM6qcwiS9LEXydg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51e10990adfso2863233a12.0
        for <kexec@lists.infradead.org>; Mon, 17 Jul 2023 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603909; x=1692195909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg+GsbYLB4O3WTuuQwregxIHX9P5sA4QNLHVsEdZbKc=;
        b=JxtNLZmNcKsE6mgI+F9v1FK/uw6u6VcVHp6kD+DRoThGoUZ3holtPu7Laf5yF+MUmd
         +jU4kYLvkA4tCL/QyRQSWLXvj/uXMK0su5KuevtE69zwyrrimFmiqzQbFdGCsB/xq2U2
         WEb0EMVh7l2sZ+ng5SK9JNbMCc85Yz2jpFz6RLB/vqV8qQCI5s+ZuNo5ZXGPMtHxZf7N
         m+iYBwL1CPKnjD9Xxt/rOgzRW/RTxXOnadigKc0WEccfVZaReYm9LvzaBc8Kc0HBlYQT
         aZaOC9C7HtvQnhao1xo8VcJz6SaZx4Vypfqu2q+mydTrEGbBZpb8VJQhFcBqbaH0ItPL
         4A6w==
X-Gm-Message-State: ABy/qLa/Xv9KJc4iDs5eXB8RGWOHWS4ei4jOnW4q42cvu+zLLICBfFSu
	9f8v6IJiQ/nudfaQq5d9lfw414w5sUKB3rLNjOP/1FX7bRc9qVRwL8v6p74ZLzG630QVZ5VKZ8/
	98h3z1BAzpacNOBkYMIcvss/AyuDxSodHXaIAQbVxNaSIpIs=
X-Received: by 2002:aa7:cb52:0:b0:516:af22:bcc6 with SMTP id w18-20020aa7cb52000000b00516af22bcc6mr10499337edt.21.1689603908841;
        Mon, 17 Jul 2023 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEeRRv4xnmP1QWzxE9nxS6UxsaMMZ6UGX3WY7lj15U4ppSZ6Je25rTk/Td7DbyXDl4JEeQ0BcOx7tC4qAnbgMY=
X-Received: by 2002:aa7:cb52:0:b0:516:af22:bcc6 with SMTP id
 w18-20020aa7cb52000000b00516af22bcc6mr10499318edt.21.1689603908534; Mon, 17
 Jul 2023 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com> <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
In-Reply-To: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 17 Jul 2023 22:24:32 +0800
Message-ID: <CAO7dBbX4pCO7pd==2P956HFeTVrMfb0oB33EXVxWbFuPFq=Oaw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org, 
	bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_072512_906579_641AB2FD 
X-CRM114-Status: GOOD (  19.85  )
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

T24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgMTA6MTTigK9QTSBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1bCAxNywgMjAyMyBhdCAwOTo1MzowNlBNICsw
ODAwLCBUYW8gTGl1IHdyb3RlOgo+ID4gLi4uc25pcC4uLgo+ID4gWyAgIDIxLjM2MDc2M10gIG52
bWUwbjE6IHAxIHAyIHAzCj4gPiBbICAgMjEuMzY0MjA3XSBpZ2MgMDAwMDowMzowMC4wOiBQVE0g
ZW5hYmxlZCwgNG5zIGdyYW51bGFyaXR5Cj4gPiBbICAgMjEuNDIxMDk3XSBwcHMgcHBzMTogbmV3
IFBQUyBzb3VyY2UgcHRwMQo+ID4gWyAgIDIxLjQyNTM5Nl0gaWdjIDAwMDA6MDM6MDAuMCAodW5u
YW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IFBIQyBhZGRlZAo+ID4gWyAgIDIxLjQ1
NzAwNV0gaWdjIDAwMDA6MDM6MDAuMDogNC4wMDAgR2IvcyBhdmFpbGFibGUgUENJZSBiYW5kd2lk
dGgKPiA+ICg1LjAgR1QvcyBQQ0llIHgxIGxpbmspCj4gPiBbICAgMjEuNDY1MjEwXSBpZ2MgMDAw
MDowMzowMC4wIGV0aDE6IE1BQzogLi4uc25pcC4uLgo+ID4gWyAgIDIxLjQ3MzQyNF0gaWdjIDAw
MDA6MDM6MDAuMCBlbnAzczA6IHJlbmFtZWQgZnJvbSBldGgxCj4gPiBbICAgMjEuNDc5NDQ2XSBC
VUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAw
MDAwMDgKPiA+IFsgICAyMS40ODY0MDVdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBr
ZXJuZWwgbW9kZQo+ID4gWyAgIDIxLjQ5MTUxOV0gbW1jMTogRmFpbGVkIHRvIGluaXRpYWxpemUg
YSBub24tcmVtb3ZhYmxlIGNhcmQKPiA+IFsgICAyMS40OTE1MzhdICNQRjogZXJyb3JfY29kZSgw
eDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQo+ID4gWyAgIDIxLjUwMjIyOV0gUEdEIDAgUDREIDAK
PiA+IFsgICAyMS41MDQ3NzNdIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQo+ID4g
WyAgIDIxLjUwOTEzM10gQ1BVOiAzIFBJRDogNDAyIENvbW06IHN5c3RlbWQtdWRldmQgTm90IHRh
aW50ZWQgNi41LjAtcmMxKyAjMQo+ID4gWyAgIDIxLjUxNTkwNV0gSGFyZHdhcmUgbmFtZTogLi4u
c25pcC4uLgo+ID4gWyAgIDIxLjUyMjg1MV0gUklQOiAwMDEwOmtlcm5mc19kb3BfcmV2YWxpZGF0
ZSsweDJiLzB4MTIwCj4KPiBTbyBzb21ldGhpbmcncyB3ZWlyZCBoZXJlIC0gbXkgcGF0Y2ggc2hv
dWxkIG5vdCBjYXVzZSBhIG51bGwgcHRyIGRlcmVmCj4gaGVyZS4KPgo+ID4gWyAgIDIxLjUyNzk5
NV0gQ29kZTogMWYgNDQgMDAgMDAgODMgZTYgNDAgMGYgODUgMDcgMDEgMDAgMDAgNDEgNTUgNDEK
PiA+IDU0IDU1IDUzIDQ4IDhiIDQ3IDMwIDQ4IDg5IGZiIDQ4IDg1IGMwIDBmIDg0IGEyIDAwIDAw
IDAwIDQ4IDhiIGE4Nwo+Cj4gVGhpcyBsb29rcyB3ZWlyZCB0b28uIFRoZXJlJ3Mgbm8gIjw+IiBi
cmFja2V0cyBkZW5vdGluZyB3aGljaCBieXRlIGl0Cj4gd2FzIGV4YWN0bHkgd2hlcmUgUklQIHBv
aW50ZWQgdG8gd2hlbiB0aGUgTlVMTCBwdHIgaGFwcGVuZWQuCj4KPiBEbwo+Cj4gbWFrZSBmcy9r
ZXJuZnMvZGlyLnMKPgo+IGFuZCB1cGxvYWQgZGlyLnMgYW5kIHRoZSBkaXIubyBmaWxlIHNvbWV3
aGVyZS4KPgo+IEluIGFueSBjYXNlLCBteSBwYXRjaCBzaG91bGRuJ3QgYmUgY2F1c2luZyB0aGlz
LiBBdCBsZWFzdCBJIGRvbid0IHNlZQo+IGl0Lgo+Cj4gSSdtIHRlc3RpbmcgYSBiZXR0ZXIgdmVy
c2lvbiBvZiB0aGUgcGF0Y2ggYW5kIGl0IHNob3VsZCBub3QgY2F1c2UgdGhpcwo+IHRoaW5nIGV2
ZW4gbGVzcy4KPgpPSywgdGhhbmtzIGZvciB0aGUgaGVscC4gSSB3aWxsIHJlLW1ha2UsIHRlc3Qg
YW5kIHVwZGF0ZSB0aGUgaW5mby4KCj4gPiBUaGUgc3RhY2sgdHJhY2UgbWF5IG5vdCBiZSB0aGUg
c2FtZSBhbGwgdGhlIHRpbWUsIEkgZGlkbid0IGRpdmUgZGVlcAo+ID4gaW50byB0aGUgcm9vdCBj
YXVzZSwgYnV0IGl0IGxvb2tzIHRvIG1lIHRoZSBwYXRjaCB3aWxsIGNhdXNlIGFuCj4gPiB1bmtu
b3duIGlzc3VlLiBBbHNvIEkgdGVzdGVkIHRoZSBwYXRjaCBvbiBrZXJuZWwtNS4xNC4wLTMxOC5l
bDksIGl0Cj4KPiBUaGlzIGlzIHRoZSB1cHN0cmVhbSBrZXJuZWwgbWFpbGluZyBsaXN0IHNvIHRo
b3NlIEZyYW5rZW5zdGVpbiBrZXJuZWxzCj4gYXJlIGFsbCBsZWZ0IHRvIHlvdS4KPgo+IEdvb2Qg
bHVjay4gOi0pCj4KT0ssIHRoYW5rcyEKClRoYW5rcywKVGFvIExpdQoKPiAtLQo+IFJlZ2FyZHMv
R3J1c3MsCj4gICAgIEJvcmlzLgo+Cj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25v
dGVzLWFib3V0LW5ldGlxdWV0dGUKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
