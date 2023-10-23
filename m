Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9CCC25B46
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BKu5LS5kkadwxG4PM5woHIKEFt8I9rrV6qbW2Y2Kwlg=; b=bRUJg+CUASLLXA
	+grVlmME886I1Y59vw41k4bqZsltJy7wznqH9u/5aEh0NPz6p00P+N7YMU/Zbd+xkODD4RXx4OHUG
	LttyC6M/uXi0OnNDpXOV490rtRNH5ZNA8PRXPfF/aB2OEuGbDTtOpAX9otGLhAoMN+EQxW4EYTb+M
	/1UFnqwtIGk8rQjgd5wTq7m8N6pmyRJ5msI/0dNhHYzB3SVU4loeYmXXjtPs8vmf9E/NnLgVkzS5t
	wsJyUS1dIdbJ5pAOTO4bYUbZJox92Sf/GTMAbPQL52Hzrf6ngppRsohQGkjR8N2YrhwO7i1pjX9lD
	z/XWGkQQ9NGzGgvgUbQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qv2t5-008L1W-36;
	Mon, 23 Oct 2023 21:55:03 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qv2t0-008L0c-30
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 21:55:00 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cdc669c5eso44851cf.1
        for <kexec@lists.infradead.org>; Mon, 23 Oct 2023 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698098096; x=1698702896; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5LWS4K5/4iKfNn5YiAzdNMefXt8v/R2dnYlMsD5khk=;
        b=slqkvSYd7OUQVSM64J21q4Iexf8Pu5E7GZxivelsU4FQGQTjvqpCMviHkgLefE7Y6q
         d8NPepouyH9yAc3IRf7SBcR9N1fYmk/W4Ya+SBp/h20m3SOo4PnrI32wi4CjEg3x4Q5/
         8BmDMzXZul6yPVb9qoITQS9QBU2O21c1os5m9XXyJ3Bgxwb9NIYySHP4nUciQO2JyWHF
         y+ZlTIrb39BJU/TmyJ6Feosd0PP8K5rNz1y0JlFH5SRxbo4vdoER1p9wStPnMqiIrRZM
         WZ/uhqg01J5NMLH0K9cgJCh7GF0EazqOxEqRbKtulJZ6BRa5BLGrAACo2An30/szYF4f
         jYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698098096; x=1698702896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5LWS4K5/4iKfNn5YiAzdNMefXt8v/R2dnYlMsD5khk=;
        b=KWLxpd4l88aMzPAdMesHD12q7ihhCfex5qtRvRDxuQQtMCBUO931bRYIUQJXKIX7kB
         8l+6h846Gguypt34h1wc+MmkOfGxS2j5JWozuI3t4qca9LtbjfBRTtet4h3oqB/lremB
         PUv/ieIXsQAszxktGx7dJ11Uiy5EQQX0tkNJQ1GqYKy+xeyNnMr/XMF6Jieq3MCGbD6+
         pMc+RebsDEIf2ZCY4D3kKpXpCA1c1hC5YZ5/utDwgdjLbPGN7CkZb633k+w8m0WoKbv4
         SyRAoKcSNfhT3xfUVM7jSekq8Fr0WZpHvbgfTyxC6sB2IwHeVgjfbpzU7jN78C4nbTOU
         DReQ==
X-Gm-Message-State: AOJu0YwxDtExH4DTRxoPjCuHNMUD9qUwuD8UXjfoS8lR5y7BIMwNfcZm
	MpfdWg1BwmmvTcvqDxoxtbG2QNmj855OEQbSPhS7yg==
X-Google-Smtp-Source: AGHT+IE2D+QLdS8YjjqB+PJOwtagyXlMsmDom9XQlRavmOeQBvXuC7m/nzHYgfableqs7DnMwXJVVHEPALVV0vUc6AU=
X-Received: by 2002:a05:622a:2282:b0:41e:29ad:8b8b with SMTP id
 ay2-20020a05622a228200b0041e29ad8b8bmr15969qtb.10.1698098095867; Mon, 23 Oct
 2023 14:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231023023121.1464544-1-jsperbeck@google.com> <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
In-Reply-To: <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
From: John Sperbeck <jsperbeck@google.com>
Date: Mon, 23 Oct 2023 14:54:43 -0700
Message-ID: <CAFNjLiVAdcPEc+UK_5Z+uutqAVki5geWgpWewzu9iyJsYyiRjw@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Zac Tang <zactang@google.com>, Cloud Hsu <cloudhsu@google.com>, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_145459_011294_5A3987B8 
X-CRM114-Status: GOOD (  30.94  )
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

T24gU3VuLCBPY3QgMjIsIDIwMjMgYXQgNzo0MuKAr1BNIEguIFBldGVyIEFudmluIDxocGFAenl0
b3IuY29tPiB3cm90ZToKPgo+IE9uIE9jdG9iZXIgMjIsIDIwMjMgNzozMToyMSBQTSBQRFQsIEpv
aG4gU3BlcmJlY2sgPGpzcGVyYmVja0Bnb29nbGUuY29tPiB3cm90ZToKPiA+VGhlIHBoeXNpY2Fs
IG1lbW9yeSByYW5nZSB0aGF0IGtleGVjIHNlbGVjdHMgZm9yIHRoZSBjb21wcmVzc2VkCj4gPmJ6
aW1hZ2UgdGFyZ2V0IGtlcm5lbCwgbWlnaHQgbm90IGJlIHdoZXJlIGl0IHJ1bnMgZnJvbS4gIFRo
ZQo+ID5zdGFydHVwXzY0KCkgY29kZSBpbiBoZWFkXzY0LlMgY29waWVzIGl0c2VsZiBvdXQgb2Yg
dGhlIHdheQo+ID5iZWZvcmUgdGhlIGRlY29tcHJlc3Npb24gc28gaXQgZG9lc24ndCBjbG9iYmVy
IGl0c2VsZi4KPiA+Cj4gPklmIHRoZSBzdGFydCBvZiB0aGUgbWVtb3J5IHJhbmdlIHNlbGVjdGVk
IGJ5IGtleGVjIGlzIGFib3ZlCj4gPkxPQURfUEhZU0lDQUxfQUREUiAoMHgwMTAwMDAwMCBieSBk
ZWZhdWx0KSwgdGhlbiB0aGUgY29weSByZW1haW5zCj4gPndpdGhpbiB0aGUgbWVtb3J5IGFyZWEu
ICBCdXQgaWYgdGhlIHN0YXJ0IGlzIGJlbG93IHRoaXMgcmFuZ2UsCj4gPnRoZW4gdGhlIGNvcHkg
d2lsbCBsaWtlbHkgZW5kIHVwIG91dHNpZGUgdGhlIHJhbmdlLgo+ID4KPiA+VXN1YWxseSwgdGhp
cyB3aWxsIGJlIGhhcm1sZXNzIGJlY2F1c2Ugbm90IG11Y2ggbWVtb3J5IGlzIGluIHVzZQo+ID5h
dCB0aGUgdGltZSBvZiB0aGUgcHJlLWRlY29tcHJlc3Npb24gY29weSwgc28gdGhlcmUgaXMgbGl0
dGxlCj4gPnRvIGFjY2lkZW50YWxseSBjbG9iYmVyLiAgSG93ZXZlciwgYW4gdW5sdWNreSBjaG9p
Y2UgZm9yIHRoZQo+ID5hZHJlc3Mgb2YgdGhlIGtlcm5lbCBhbmQgdGhlIGluaXRyZCBjb3VsZCBw
dXQgdGhlIGluaXRyZCBpbiBoYXJtJ3MKPiA+d2F5LiAgRm9yIGV4YW1wbGU6Cj4gPgo+ID4gICAg
MHgwMDQwMDAwMCAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIHRhcmdldCBrZXJuZWwKPiA+ICAgIDB4
MDNmZjgwMDAgLSBwaHlzaWNhbCBhZGRyZXNzIG9mIHNldmVuLXBhZ2UgaW5pdHJkCj4gPiAgICAw
eDAzMDJjMDAwIC0gc2l6ZSBvZiB1bmNvbXByZXNzZWQga2VybmVsIChhYm91dCA1MCBNYnl0ZXMp
Cj4gPgo+ID5UaGUgZGVjb21wcmVzc2VkIGtlcm5lbCB3aWxsIHNwYW4gMHgwMTAwMDAwMCB0aHJv
dWdoIDB4MDQwMmMwMDAsCj4gPndoaWNoIHdpbGwgb3ZlcndyaXRlIHRoZSBpbml0cmQuCj4gPgo+
ID5JZiB0aGUga2V4ZWMgY29kZSByZXN0cmljdHMgaXRzZWxmIHRvIHBoeXNpY2FsIGFkZHJlc3Nl
cyBhYm92ZQo+ID4weDAxMDAwMDAwLCB0aGVuIHRoZSBwcmUtZGVjb21wcmVzc2lvbiBjb3B5IGFu
ZCB0aGUgZGVjb21wcmVzc2lvbgo+ID5pdHNlbGYgd2lsbCBzdGF5IHdpdGhpbiB0aGUgYm91bmRz
IG9mIHRoZSBtZW1vcnkga2V4ZWMgc2VsZWN0ZWQKPiA+KHVubGVzcyBhIG5vbi1kZWZhdWx0IHZh
bHVlIGlzIHVzZWQgaW4gdGhlIHRhcmdldCBrZXJuZWwgZm9yCj4gPkNPTkZJR19QSFlTSUNBTF9T
VEFSVCwgd2hpY2ggd2lsbCBjaGFuZ2UgTE9BRF9QSFlTSUNBTF9BRERSLAo+ID5idXQgdGhhdCdz
IHByb2JhYmx5IHVuc29sdmFibGUgdW5sZXNzIHRoZSB0YXJnZXQga2VybmVsIHdlcmUgdG8KPiA+
c29tZWhvdyBjb21tdW5pY2F0ZSB0aGlzIHRvIGtleGVjKS4KPiA+Cj4gPlNpZ25lZC1vZmYtYnk6
IEpvaG4gU3BlcmJlY2sgPGpzcGVyYmVja0Bnb29nbGUuY29tPgo+ID4tLS0KPiA+IGFyY2gveDg2
L2tlcm5lbC9rZXhlYy1iemltYWdlNjQuYyB8IDIgKy0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9rZXhlYy1iemltYWdlNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9rZXhlYy1iemltYWdlNjQu
Ywo+ID5pbmRleCBhNjFjMTJjMDEyNzAuLmQ2YmY2YzEzZGFiMSAxMDA2NDQKPiA+LS0tIGEvYXJj
aC94ODYva2VybmVsL2tleGVjLWJ6aW1hZ2U2NC5jCj4gPisrKyBiL2FyY2gveDg2L2tlcm5lbC9r
ZXhlYy1iemltYWdlNjQuYwo+ID5AQCAtMzYsNyArMzYsNyBAQAo+ID4gICovCj4gPiAjZGVmaW5l
IE1JTl9QVVJHQVRPUllfQUREUiAgICAweDMwMDAKPiA+ICNkZWZpbmUgTUlOX0JPT1RQQVJBTV9B
RERSICAgIDB4MzAwMAo+ID4tI2RlZmluZSBNSU5fS0VSTkVMX0xPQURfQUREUiAgMHgxMDAwMDAK
PiA+KyNkZWZpbmUgTUlOX0tFUk5FTF9MT0FEX0FERFIgIDB4MTAwMDAwMAo+ID4gI2RlZmluZSBN
SU5fSU5JVFJEX0xPQURfQUREUiAgMHgxMDAwMDAwCj4gPgo+ID4gLyoKPgo+IFRoaXMgZG9lc24n
dCBtYWtlIGFueSBzZW5zZSB0byBtZS4gVGhlcmUgaXMgYWxyZWFkeSBhIGhpZ2ggd2F0ZXIgbWFy
ayBmb3IgaGlzIG11Y2ggbWVtb3J5IHRoZSBrZXJuZWwgbmVlZHMgdW50aWwgYW4gaW5pdHJkIG9y
IHNldHVwX2RhdGEgaXRlbSBjYW4gYXBwZWFyLiBUaGlzIGlzIGp1c3QgYSBoYWNrLCBwbGVhc2Ug
Zml4IGl0IHByb3Blcmx5LgoKVGhlIHN0YXJ0dXBfNjQoKSBjb2RlIGluIGhlYWRfNjQuUyBjaGFu
Z2VzIGJlaGF2aW9yIGJhc2VkIG9uIHdoZXRoZXIKaXQncyBydW5uaW5nIGJlbG93IG9yIGFib3Zl
IExPQURfUEhZU0lDQUxfQUREUjoKCiNpZmRlZiBDT05GSUdfUkVMT0NBVEFCTEUKICAgICAgICBs
ZWFxICAgIHN0YXJ0dXBfMzIoJXJpcCkgLyogLSAkc3RhcnR1cF8zMiAqLywgJXJicAogICAgICAg
IG1vdmwgICAgQlBfa2VybmVsX2FsaWdubWVudCglcnNpKSwgJWVheAogICAgICAgIGRlY2wgICAg
JWVheAogICAgICAgIGFkZHEgICAgJXJheCwgJXJicAogICAgICAgIG5vdHEgICAgJXJheAogICAg
ICAgIGFuZHEgICAgJXJheCwgJXJicAogICAgICAgIGNtcHEgICAgJExPQURfUEhZU0lDQUxfQURE
UiwgJXJicAogICAgICAgIGphZSAgICAgMWYKI2VuZGlmCiAgICAgICAgbW92cSAgICAkTE9BRF9Q
SFlTSUNBTF9BRERSLCAlcmJwCjE6CgpJbiBteSBleGFtcGxlLCB3ZSB3ZXJlIHJ1bm5pbmcgZnJv
bSBhZGRyZXNzIDB4MDA0MDAwMDAuICBUaGUgJXJicApyZWdpc3RlciB3aWxsIHN0YXJ0IHdpdGgg
MHgwMDQwMDAwMCwgYnV0IHdpbGwgYmUgY2hhbmdlZCB0byAweDAxMDAwMDAwCmFmdGVyIHRoZSBj
aGVjayBhZ2FpbnN0IExPQURfUEhZU0lDQUxfQUREUiBmYWlscy4KClRoZSAweDAxMDAwMDAwIHZh
bHVlIGluICVyYnAgaXMgcGFzc2VkIHRvIGV4dHJhY3Rfa2VybmVsIGFzIHRoZQonb3V0cHV0JyBh
cmd1bWVudC4gIFVubGVzcyBjaG9vc2VfcmFuZG9tX2xvY2F0aW9uKCkgZGVjaWRlcwpkaWZmZXJl
bnRseSwgdGhpcyB3aWxsIGJlIHdoZXJlIHRoZSBrZXJuZWwgaXMgZGVjb21wcmVzc2VkIHRvLiAg
VGhlCnNpemUgb2YgdGhlIGtlcm5lbCBpcyBsYXJnZSBlbm91Z2ggaW4gbXkgZXhhbXBsZSB0aGF0
IHRoZQpkZWNvbXByZXNzaW9uIG92ZXJydW5zIHRoZSBpbml0cmQuCgpJZiB0aGUgc3RhcnR1cF82
NCgpIGNvZGUgZGlkbid0IGhhdmUgdGhlIExPQURfUEhZU0lDQUxfQUREUiBjaGVjayBhbmQKdXNl
ZCAlcnBiIGFzIGlzLCB0aGVuIHRoZXJlIHdvdWxkIGJlIG5vIGlzc3VlLiAgVGhlIGRlY29tcHJl
c3Npb24Kd291bGQgaGF2ZSBiZWVuIHRvIDB4MDA0MDAwMDAgYW5kIHdvdWxkIGhhdmUgY29tcGxl
dGVkIGJlZm9yZSByZWFjaGluZwp0aGUgaW5pdHJkIG1lbW9yeS4KClRoYXQgaXMsIHRoZSBrZXhl
YyBjb2RlIGlzIGJlaW5nIGNhcmVmdWwgdG8gZW5zdXJlIHRoYXQgdGhlIGtlcm5lbCBhbmQKaW5p
dHJkIG1lbW9yeSBkb2Vzbid0IG92ZXJsYXAsIGJ1dCBpc24ndCBwYXlpbmcgYXR0ZW50aW9uIHRv
IHdoYXQKaGFwcGVucyBpZiB0aGUga2VybmVsIG1lbW9yeSBpcyBiZWxvdyBMT0FEX1BIWVNJQ0FM
X0FERFIgKHRoZSBrZXJuZWwKYWRkcmVzcyBpcyBlZmZlY3RpdmVseSBjaGFuZ2VkIHRvIGEgZGlm
ZmVyZW50IGxvY2F0aW9uKS4gIE15IHByb3Bvc2VkCmNoYW5nZSBtYWtlcyBpdCBhd2FyZSwgYW5k
IGF2b2lkcyBzdWNoIGFkZHJlc3Nlcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
