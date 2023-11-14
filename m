Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A0C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8tnu7auiiGoBaZ8zcyP1DsAkbhMOGqS4PWJaLNctnkI=; b=sZrKQTTXaTBNmS
	DQUZOYofvlyrE3p9gdrDwOVCiuKYBEIVER0uJ/Sn+5T0kNQihqJlJFvyOsJfLnbpYqz5yf9/OId+2
	pGiQ+jzrAjcckRvv3Ji0JHGS2Gt1Q6/VDNpeJr8qEFHCduZY2SY1mXOjHgvBsxM61Ft6AhYAsDZwM
	vHMxW/BPPHIaRY2YIBMPGD/zCWs3q7WXe2MNqBYPWkg9zD1RGR3tGR3pTjGbGpRd4sGJsRTBmFAgL
	3yLWbojTAqKQNpybI/W7aLuEmDcA2leMO0yUMCVmb1bHYsuFbh0eirr7PDAtsgslmnBDiruC2llRo
	zNpQQelI2BtO1EHGMBuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2uDB-00GAWA-0d;
	Tue, 14 Nov 2023 14:16:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2uD8-00GATT-10
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 14:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699971371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKVLJOgm4tyS8bx4YwBGzuXwyrL/SHecWOOFNbyUgkI=;
	b=I9RCjr4zttBVhbU1md6bxDhEH5aThLGL89ZitbedBg1KRKiIkrccQAqyd9Gt1+ohw1RkIf
	lYetTfs/m4I/OeQok1R/JqyzvqLhjnJdV90qARB94e2LSIE6SKD3ht4IVZIIuN/AA04qAC
	nMTGvCVeEl4HdU8iSup/ZQXFcWxoWCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Bt0mks0TOoiq4CGlL5-bsw-1; Tue, 14 Nov 2023 09:16:06 -0500
X-MC-Unique: Bt0mks0TOoiq4CGlL5-bsw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0CE8821BC5;
	Tue, 14 Nov 2023 14:16:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.231])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F027492BE0;
	Tue, 14 Nov 2023 14:16:04 +0000 (UTC)
Date: Tue, 14 Nov 2023 22:16:01 +0800
From: Baoquan He <bhe@redhat.com>
To: John Sperbeck <jsperbeck@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	kexec@lists.infradead.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Zac Tang <zactang@google.com>, Cloud Hsu <cloudhsu@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
Message-ID: <ZVOBIfIpuTIO+E8M@MiWiFi-R3L-srv>
References: <20231023023121.1464544-1-jsperbeck@google.com>
 <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
 <CAFNjLiVAdcPEc+UK_5Z+uutqAVki5geWgpWewzu9iyJsYyiRjw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFNjLiVAdcPEc+UK_5Z+uutqAVki5geWgpWewzu9iyJsYyiRjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_061614_421105_3B46F47E 
X-CRM114-Status: GOOD (  27.15  )
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

SGkgSm9obiwKCk9uIDEwLzIzLzIzIGF0IDAyOjU0cG0sIEpvaG4gU3BlcmJlY2sgd3JvdGU6Cj4g
T24gU3VuLCBPY3QgMjIsIDIwMjMgYXQgNzo0MuKAr1BNIEguIFBldGVyIEFudmluIDxocGFAenl0
b3IuY29tPiB3cm90ZToKLi4uLi4uCj4gPiA+LS0tCj4gPiA+IGFyY2gveDg2L2tlcm5lbC9rZXhl
Yy1iemltYWdlNjQuYyB8IDIgKy0KPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4gPiA+Cj4gPiA+ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9r
ZXhlYy1iemltYWdlNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9rZXhlYy1iemltYWdlNjQuYwo+ID4g
PmluZGV4IGE2MWMxMmMwMTI3MC4uZDZiZjZjMTNkYWIxIDEwMDY0NAo+ID4gPi0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9rZXhlYy1iemltYWdlNjQuYwo+ID4gPisrKyBiL2FyY2gveDg2L2tlcm5lbC9r
ZXhlYy1iemltYWdlNjQuYwo+ID4gPkBAIC0zNiw3ICszNiw3IEBACj4gPiA+ICAqLwo+ID4gPiAj
ZGVmaW5lIE1JTl9QVVJHQVRPUllfQUREUiAgICAweDMwMDAKPiA+ID4gI2RlZmluZSBNSU5fQk9P
VFBBUkFNX0FERFIgICAgMHgzMDAwCj4gPiA+LSNkZWZpbmUgTUlOX0tFUk5FTF9MT0FEX0FERFIg
IDB4MTAwMDAwCj4gPiA+KyNkZWZpbmUgTUlOX0tFUk5FTF9MT0FEX0FERFIgIDB4MTAwMDAwMAo+
ID4gPiAjZGVmaW5lIE1JTl9JTklUUkRfTE9BRF9BRERSICAweDEwMDAwMDAKPiA+ID4KPiA+ID4g
LyoKPiA+Cj4gPiBUaGlzIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UgdG8gbWUuIFRoZXJlIGlzIGFs
cmVhZHkgYSBoaWdoIHdhdGVyIG1hcmsgZm9yIGhpcyBtdWNoIG1lbW9yeSB0aGUga2VybmVsIG5l
ZWRzIHVudGlsIGFuIGluaXRyZCBvciBzZXR1cF9kYXRhIGl0ZW0gY2FuIGFwcGVhci4gVGhpcyBp
cyBqdXN0IGEgaGFjaywgcGxlYXNlIGZpeCBpdCBwcm9wZXJseS4KPiAKPiBUaGUgc3RhcnR1cF82
NCgpIGNvZGUgaW4gaGVhZF82NC5TIGNoYW5nZXMgYmVoYXZpb3IgYmFzZWQgb24gd2hldGhlcgo+
IGl0J3MgcnVubmluZyBiZWxvdyBvciBhYm92ZSBMT0FEX1BIWVNJQ0FMX0FERFI6Cj4gCj4gI2lm
ZGVmIENPTkZJR19SRUxPQ0FUQUJMRQo+ICAgICAgICAgbGVhcSAgICBzdGFydHVwXzMyKCVyaXAp
IC8qIC0gJHN0YXJ0dXBfMzIgKi8sICVyYnAKPiAgICAgICAgIG1vdmwgICAgQlBfa2VybmVsX2Fs
aWdubWVudCglcnNpKSwgJWVheAo+ICAgICAgICAgZGVjbCAgICAlZWF4Cj4gICAgICAgICBhZGRx
ICAgICVyYXgsICVyYnAKPiAgICAgICAgIG5vdHEgICAgJXJheAo+ICAgICAgICAgYW5kcSAgICAl
cmF4LCAlcmJwCj4gICAgICAgICBjbXBxICAgICRMT0FEX1BIWVNJQ0FMX0FERFIsICVyYnAKPiAg
ICAgICAgIGphZSAgICAgMWYKPiAjZW5kaWYKPiAgICAgICAgIG1vdnEgICAgJExPQURfUEhZU0lD
QUxfQUREUiwgJXJicAo+IDE6Cj4gCj4gSW4gbXkgZXhhbXBsZSwgd2Ugd2VyZSBydW5uaW5nIGZy
b20gYWRkcmVzcyAweDAwNDAwMDAwLiAgVGhlICVyYnAKPiByZWdpc3RlciB3aWxsIHN0YXJ0IHdp
dGggMHgwMDQwMDAwMCwgYnV0IHdpbGwgYmUgY2hhbmdlZCB0byAweDAxMDAwMDAwCj4gYWZ0ZXIg
dGhlIGNoZWNrIGFnYWluc3QgTE9BRF9QSFlTSUNBTF9BRERSIGZhaWxzLgo+IAo+IFRoZSAweDAx
MDAwMDAwIHZhbHVlIGluICVyYnAgaXMgcGFzc2VkIHRvIGV4dHJhY3Rfa2VybmVsIGFzIHRoZQo+
ICdvdXRwdXQnIGFyZ3VtZW50LiAgVW5sZXNzIGNob29zZV9yYW5kb21fbG9jYXRpb24oKSBkZWNp
ZGVzCj4gZGlmZmVyZW50bHksIHRoaXMgd2lsbCBiZSB3aGVyZSB0aGUga2VybmVsIGlzIGRlY29t
cHJlc3NlZCB0by4gIFRoZQo+IHNpemUgb2YgdGhlIGtlcm5lbCBpcyBsYXJnZSBlbm91Z2ggaW4g
bXkgZXhhbXBsZSB0aGF0IHRoZQo+IGRlY29tcHJlc3Npb24gb3ZlcnJ1bnMgdGhlIGluaXRyZC4K
PiAKPiBJZiB0aGUgc3RhcnR1cF82NCgpIGNvZGUgZGlkbid0IGhhdmUgdGhlIExPQURfUEhZU0lD
QUxfQUREUiBjaGVjayBhbmQKPiB1c2VkICVycGIgYXMgaXMsIHRoZW4gdGhlcmUgd291bGQgYmUg
bm8gaXNzdWUuICBUaGUgZGVjb21wcmVzc2lvbgo+IHdvdWxkIGhhdmUgYmVlbiB0byAweDAwNDAw
MDAwIGFuZCB3b3VsZCBoYXZlIGNvbXBsZXRlZCBiZWZvcmUgcmVhY2hpbmcKPiB0aGUgaW5pdHJk
IG1lbW9yeS4KPiAKPiBUaGF0IGlzLCB0aGUga2V4ZWMgY29kZSBpcyBiZWluZyBjYXJlZnVsIHRv
IGVuc3VyZSB0aGF0IHRoZSBrZXJuZWwgYW5kCj4gaW5pdHJkIG1lbW9yeSBkb2Vzbid0IG92ZXJs
YXAsIGJ1dCBpc24ndCBwYXlpbmcgYXR0ZW50aW9uIHRvIHdoYXQKPiBoYXBwZW5zIGlmIHRoZSBr
ZXJuZWwgbWVtb3J5IGlzIGJlbG93IExPQURfUEhZU0lDQUxfQUREUiAodGhlIGtlcm5lbAo+IGFk
ZHJlc3MgaXMgZWZmZWN0aXZlbHkgY2hhbmdlZCB0byBhIGRpZmZlcmVudCBsb2NhdGlvbikuICBN
eSBwcm9wb3NlZAo+IGNoYW5nZSBtYWtlcyBpdCBhd2FyZSwgYW5kIGF2b2lkcyBzdWNoIGFkZHJl
c3Nlcy4KCldvbmRlcmluZyB3aHkga2V4ZWMtZWQga2VybmVsIGlzIGxvY2F0ZWQgdW5kZXIgMHgx
MDAwMDAwLiBUaGUgbG9hZGluZwpjb2RlIHdpbGwgc2VhcmNoIHBoeXNpY2FsIG1lbW9yeSByZWdp
b25zIGJvdHRvbSB1cCBmb3IgYW4gYXZhaWxhYmxlIG9uZS4KVXN1YWxseSwga2V4ZWMga2VybmVs
IHdpbGwgYmUgbG9hZGVkIGFib3ZlIDE2TS4KCkkgaGF2ZSBwb3N0ZWQgYSBwYXRjaHNldCB0byBs
b2FkIGtlcm5lbCBhdCB0b3Agb2Ygc3lzdGVtIFJBTSBmb3Iga2V4ZWNfZmlsZQpsb2FkIGp1c3Qg
YXMga2V4ZWNfbG9hZCBoYXMgYmVlbiBkb2luZy4gRG8geW91IHRoaW5rIGl0J3MgaGVscGZ1bD8K
CltQQVRDSCAwLzJdIGtleGVjX2ZpbGU6IExvYWQga2VybmVsIGF0IHRvcCBvZiBzeXN0ZW0gUkFN
IGlmIHJlcXVpcmVkCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTExNDA5MTY1OC4y
MjgwMzAtMS1iaGVAcmVkaGF0LmNvbS9ULyN1CgpUaGFua3MKQmFvcXVhbgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
