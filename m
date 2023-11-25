Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79E2C61D97
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 01:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7PvVPMdCJ6kz0to5KL/ZbIMkpeDUQCIZPQwp50jwzfU=; b=J56q8asgxqIq3Q
	9ipe0sPj7rrcq76Vj6Lemi4jgpFUrhbH9omWaq/hAjhqJEHvaABzbyZ8lv/zJbYn87sJD+JNu/hM7
	AbEH+2EMi1k8RfF/YgCog57SPmcN6zixirtTZuNGCv04tcWlpsdFfbSgbERMj1w5rs9Sn8N0qd1oM
	/wjVXc2sT6CqO7DLiBVMG9MXQEE9GD5xNIcN7Ej8VWgns8uJ33rxO8a2Kputukk0lt9TY4F9UIUCP
	ml/mz1x+rQz9YBMif8DWyPu3LvBpUXzCqR9MTFtLwy3b/a7W0yZ025lkmd7E6rpNUeBSjQbU8HgQP
	3bs8XQ6erulqmDV/o48w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6hqa-008OV6-1V;
	Sat, 25 Nov 2023 01:52:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6hqW-008OUg-1b
	for kexec@lists.infradead.org;
	Sat, 25 Nov 2023 01:52:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700877153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhfO96FpBSwc0gssKbBJzT8GzmdBygFpNFQZ/ti3+ds=;
	b=IIkHw+MhOzEFLTYe0XRYlUQtkX3Ev0aUBHez7cngvFvJNqq96DGuxLuoJ+1TIcIWXiTwn7
	wKvnUbAE0LBCqm2SoBW+vjcjMPlOLD+bPo+k5OFf2F6kgi61VtZ+Qmv4WXRnyc2VjjTkBK
	WF8iZe5taEqskJBXPo3FEzkBV8KhBKo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-BdY1IInSMgGxKtJcJQdVBg-1; Fri, 24 Nov 2023 20:52:32 -0500
X-MC-Unique: BdY1IInSMgGxKtJcJQdVBg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9fa63374410so194991866b.1
        for <kexec@lists.infradead.org>; Fri, 24 Nov 2023 17:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700877151; x=1701481951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhfO96FpBSwc0gssKbBJzT8GzmdBygFpNFQZ/ti3+ds=;
        b=HpGZmWwZ8Xj6IIhEWQbLRehKVIVWqUfPJ/++U6cqctTUBM3TvkSlhaeeyMvVkRZH4E
         28a6jjuKiGiYzK/Eam1+7XbPmuZ6RKK3O8RSGqsK4F1ypFcVZIfUkbdeq9/kQcSmBXOH
         cMeDDAv9zwa4nSeAGa8+SAPOIeh6NhpqNCQ/Bd32OlsIvsImS7pzgNwVJLub55kRPNQe
         crChIy7F4AAifectjhDZyANJysm9BDEPwZiz68TX38wpF9Nl3OuOyebSTknOJhw0y2ql
         dXq9mKLTYVaqpmDZGq7XfR9WbeSsiKH/B8GtNH9Oqmfa34ybftGJNYHH4JxmntzhNfoS
         Tizw==
X-Gm-Message-State: AOJu0YxHBo2+7YRjzulYqMInmtvIrgRrg491uvIMEW5NlsfvKMQB5/PR
	yQP50Dd8IThqO/8/YFDS/8FEejkwRh+xn06Y3+3HgBpD45koX5Mcs3Kikbx6udFewFuXQuxcekq
	bgrQgN86k90nP/0bllxGmPWNXlsFjF33BPTo6
X-Received: by 2002:a17:906:1d2:b0:a08:e229:5659 with SMTP id 18-20020a17090601d200b00a08e2295659mr2884177ejj.17.1700877150900;
        Fri, 24 Nov 2023 17:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpaumkiVhGjy6q5Lg+IAR3YB6YC/o9RAyzGvDIOF4RxVoQfB0mk7GhCn0E8GqU1ws0gjXF2jPSd0lm4zyMSq8=
X-Received: by 2002:a17:906:1d2:b0:a08:e229:5659 with SMTP id
 18-20020a17090601d200b00a08e2295659mr2884167ejj.17.1700877150590; Fri, 24 Nov
 2023 17:52:30 -0800 (PST)
MIME-Version: 1.0
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
From: Tao Liu <ltao@redhat.com>
Date: Sat, 25 Nov 2023 09:51:54 +0800
Message-ID: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mhocko@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_175236_637407_19670736 
X-CRM114-Status: GOOD (  34.18  )
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

SGkgSmlyaSwKCk9uIFNhdCwgTm92IDI1LCAyMDIzIGF0IDM6NTXigK9BTSBKaXJpIEJvaGFjIDxq
Ym9oYWNAc3VzZS5jej4gd3JvdGU6Cj4KPiBIaSwKPgo+IHRoaXMgc2VyaWVzIGltcGxlbWVudHMg
YSBuZXcgd2F5IHRvIHJlc2VydmUgYWRkaXRpb25hbCBjcmFzaCBrZXJuZWwKPiBtZW1vcnkgdXNp
bmcgQ01BLgo+Cj4gQ3VycmVudGx5LCBhbGwgdGhlIG1lbW9yeSBmb3IgdGhlIGNyYXNoIGtlcm5l
bCBpcyBub3QgdXNhYmxlIGJ5Cj4gdGhlIDFzdCAocHJvZHVjdGlvbikga2VybmVsLiBJdCBpcyBh
bHNvIHVubWFwcGVkIHNvIHRoYXQgaXQgY2FuJ3QKPiBiZSBjb3JydXB0ZWQgYnkgdGhlIGZhdWx0
IHRoYXQgd2lsbCBldmVudHVhbGx5IHRyaWdnZXIgdGhlIGNyYXNoLgo+IFRoaXMgbWFrZXMgc2Vu
c2UgZm9yIHRoZSBtZW1vcnkgYWN0dWFsbHkgdXNlZCBieSB0aGUga2V4ZWMtbG9hZGVkCj4gY3Jh
c2gga2VybmVsIGltYWdlIGFuZCBpbml0cmQgYW5kIHRoZSBkYXRhIHByZXBhcmVkIGR1cmluZyB0
aGUKPiBsb2FkICh2bWNvcmVpbmZvLCAuLi4pLiBIb3dldmVyLCB0aGUgcmVzZXJ2ZWQgc3BhY2Ug
bmVlZHMgdG8gYmUKPiBtdWNoIGxhcmdlciB0aGFuIHRoYXQgdG8gcHJvdmlkZSBlbm91Z2ggcnVu
LXRpbWUgbWVtb3J5IGZvciB0aGUKPiBjcmFzaCBrZXJuZWwgYW5kIHRoZSBrZHVtcCB1c2Vyc3Bh
Y2UuIEVzdGltYXRpbmcgdGhlIGFtb3VudCBvZgo+IG1lbW9yeSB0byByZXNlcnZlIGlzIGRpZmZp
Y3VsdC4gQmVpbmcgdG9vIGNhcmVmdWwgbWFrZXMga2R1bXAKPiBsaWtlbHkgdG8gZW5kIGluIE9P
TSwgYmVpbmcgdG9vIGdlbmVyb3VzIHRha2VzIGV2ZW4gbW9yZSBtZW1vcnkKPiBmcm9tIHRoZSBw
cm9kdWN0aW9uIHN5c3RlbS4gQWxzbywgdGhlIHJlc2VydmF0aW9uIG9ubHkgYWxsb3dzCj4gcmVz
ZXJ2aW5nIGEgc2luZ2xlIGNvbnRpZ3VvdXMgYmxvY2sgKG9yIHR3byB3aXRoIHRoZSAibG93Igo+
IHN1ZmZpeCkuIEkndmUgc2VlbiBzeXN0ZW1zIHdoZXJlIHRoaXMgZmFpbHMgYmVjYXVzZSB0aGUg
cGh5c2ljYWwKPiBtZW1vcnkgaXMgZnJhZ21lbnRlZC4KPgo+IEJ5IHJlc2VydmluZyBhZGRpdGlv
bmFsIGNyYXNoa2VybmVsIG1lbW9yeSBmcm9tIENNQSwgdGhlIG1haW4KPiBjcmFzaGtlcm5lbCBy
ZXNlcnZhdGlvbiBjYW4gYmUganVzdCBzbWFsbCBlbm91Z2ggdG8gZml0IHRoZQo+IGtlcm5lbCBh
bmQgaW5pdHJkIGltYWdlLCBtaW5pbWl6aW5nIHRoZSBtZW1vcnkgdGFrZW4gYXdheSBmcm9tCj4g
dGhlIHByb2R1Y3Rpb24gc3lzdGVtLiBNb3N0IG9mIHRoZSBydW4tdGltZSBtZW1vcnkgZm9yIHRo
ZSBjcmFzaAo+IGtlcm5lbCB3aWxsIGJlIG1lbW9yeSBwcmV2aW91c2x5IGF2YWlsYWJsZSB0byB1
c2Vyc3BhY2UgaW4gdGhlCj4gcHJvZHVjdGlvbiBzeXN0ZW0uIEFzIHRoaXMgbWVtb3J5IGlzIG5v
IGxvbmdlciB3YXN0ZWQsIHRoZQo+IHJlc2VydmF0aW9uIGNhbiBiZSBkb25lIHdpdGggYSBnZW5l
cm91cyBtYXJnaW4sIG1ha2luZyBrZHVtcCBtb3JlCj4gcmVsaWFibGUuIEtlcm5lbCBtZW1vcnkg
dGhhdCB3ZSBuZWVkIHRvIHByZXNlcnZlIGZvciBkdW1waW5nIGlzCj4gbmV2ZXIgYWxsb2NhdGVk
IGZyb20gQ01BLiBVc2VyIGRhdGEgaXMgdHlwaWNhbGx5IG5vdCBkdW1wZWQgYnkKPiBtYWtlZHVt
cGZpbGUuIFdoZW4gZHVtcGluZyBvZiB1c2VyIGRhdGEgaXMgaW50ZW5kZWQgdGhpcyBuZXcgQ01B
Cj4gcmVzZXJ2YXRpb24gY2Fubm90IGJlIHVzZWQuCj4KClRoYW5rcyBmb3IgdGhlIGlkZWEgb2Yg
dXNpbmcgQ01BIGFzIHBhcnQgb2YgbWVtb3J5IGZvciB0aGUgMm5kIGtlcm5lbC4KSG93ZXZlciBJ
IGhhdmUgYSBxdWVzdGlvbjoKCldoYXQgaWYgdGhlcmUgaXMgb24tZ29pbmcgRE1BL1JETUEgYWNj
ZXNzIG9uIHRoZSBDTUEgcmFuZ2Ugd2hlbiAxc3QKa2VybmVsIGNyYXNoPyBUaGVyZSBtaWdodCBi
ZSBkYXRhIGNvcnJ1cHRpb24gd2hlbiAybmQga2VybmVsIGFuZApETUEvUkRNQSB3cml0ZSB0byB0
aGUgc2FtZSBwbGFjZSwgaG93IHRvIGFkZHJlc3Mgc3VjaCBhbiBpc3N1ZT8KClRoYW5rcywKVGFv
IExpdQoKPiBUaGVyZSBhcmUgZm91ciBwYXRjaGVzIGluIHRoaXMgc2VyaWVzOgo+Cj4gVGhlIGZp
cnN0IGFkZHMgYSBuZXcgIixjbWEiIHN1ZmZpeCB0byB0aGUgcmVjZW5seSBpbnRyb2R1Y2VkIGdl
bmVyaWMKPiBjcmFzaGtlcm5lbCBwYXJzaW5nIGNvZGUuIHBhcnNlX2NyYXNoa2VybmVsKCkgdGFr
ZXMgb25lIG1vcmUKPiBhcmd1bWVudCB0byBzdG9yZSB0aGUgY21hIHJlc2VydmF0aW9uIHNpemUu
Cj4KPiBUaGUgc2Vjb25kIHBhdGNoIGltcGxlbWVudHMgcmVzZXJ2ZV9jcmFzaGtlcm5lbF9jbWEo
KSB3aGljaAo+IHBlcmZvcm1zIHRoZSByZXNlcnZhdGlvbi4gSWYgdGhlIHJlcXVlc3RlZCBzaXpl
IGlzIG5vdCBhdmFpbGFibGUKPiBpbiBhIHNpbmdsZSByYW5nZSwgbXVsdGlwbGUgc21hbGxlciBy
YW5nZXMgd2lsbCBiZSByZXNlcnZlZC4KPgo+IFRoZSB0aGlyZCBwYXRjaCBlbmFibGVzIHRoZSBm
dW5jdGlvbmFsaXR5IGZvciB4ODYgYXMgYSBwcm9vZiBvZgo+IGNvbmNlcHQuIFRoZXJlIGFyZSBq
dXN0IHRocmVlIHRoaW5ncyBldmVyeSBhcmNoIG5lZWRzIHRvIGRvOgo+IC0gY2FsbCByZXNlcnZl
X2NyYXNoa2VybmVsX2NtYSgpCj4gLSBpbmNsdWRlIHRoZSBDTUEtcmVzZXJ2ZWQgcmFuZ2VzIGlu
IHRoZSBwaHlzaWNhbCBtZW1vcnkgbWFwCj4gLSBleGNsdWRlIHRoZSBDTUEtcmVzZXJ2ZWQgcmFu
Z2VzIGZyb20gdGhlIG1lbW9yeSBhdmFpbGFibGUKPiAgIHRocm91Z2ggL3Byb2Mvdm1jb3JlIGJ5
IGV4Y2x1ZGluZyB0aGVtIGZyb20gdGhlIHZtY29yZWluZm8KPiAgIFBUX0xPQUQgcmFuZ2VzLgo+
IEFkZGluZyBvdGhlciBhcmNoaXRlY3R1cmVzIGlzIGVhc3kgYW5kIEkgY2FuIGRvIHRoYXQgYXMg
c29vbiBhcwo+IHRoaXMgc2VyaWVzIGlzIG1lcmdlZC4KPgo+IFRoZSBmb3VydGggcGF0Y2gganVz
dCB1cGRhdGVzIERvY3VtZW50YXRpb24vCj4KPiBOb3csIHNwZWNpZnlpbmcKPiAgICAgICAgIGNy
YXNoa2VybmVsPTEwME0gY3Jhc2toZXJuZWw9MUcsY21hCj4gb24gdGhlIGNvbW1hbmQgbGluZSB3
aWxsIG1ha2UgYSBzdGFuZGFyZCBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbgo+IG9mIDEwME0sIHdo
ZXJlIGtleGVjIHdpbGwgbG9hZCB0aGUga2VybmVsIGFuZCBpbml0cmQuCj4KPiBBbiBhZGRpdGlv
bmFsIDFHIHdpbGwgYmUgcmVzZXJ2ZWQgZnJvbSBDTUEsIHN0aWxsIHVzYWJsZSBieSB0aGUKPiBw
cm9kdWN0aW9uIHN5c3RlbS4gVGhlIGNyYXNoIGtlcm5lbCB3aWxsIGhhdmUgMS4xRyBtZW1vcnkK
PiBhdmFpbGFibGUuIFRoZSAxMDBNIGNhbiBiZSByZWxpYWJseSBwcmVkaWN0ZWQgYmFzZWQgb24g
dGhlIHNpemUKPiBvZiB0aGUga2VybmVsIGFuZCBpbml0cmQuCj4KPiBXaGVuIG5vIGNyYXNoa2Vy
bmVsPXNpemUsY21hIGlzIHNwZWNpZmllZCwgZXZlcnl0aGluZyB3b3JrcyBhcwo+IGJlZm9yZS4K
Pgo+IC0tCj4gSmlyaSBCb2hhYyA8amJvaGFjQHN1c2UuY3o+Cj4gU1VTRSBMYWJzLCBQcmFndWUs
IEN6ZWNoaWEKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
