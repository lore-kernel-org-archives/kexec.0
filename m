Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E650C54E64
	for <kexec@archiver.kernel.org>; Tue, 26 Mar 2024 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u8JZgLTmv1G/w/a9Vi9sR2UYE624gKFjda5xUR7GKSk=; b=4fLzcH2qvXAG6s
	NWf8aGtKQ+KysdkfcYDxnr2dkc8zHW2WD1yxq2lzMxEHv6sw9vwM9VsJ5qOEucSUJ0V6zc3YyR9Qg
	WX7ucFdY7kebHo5sHZIi1N05I5IncSfcvthQJWO8sd8GFplv8XbIIQPZAZ25GnpezprIp9Oby5F5r
	yuumew1T91HkGp7bsyJ4hmCb8G+u5dijbXAUftOs0fSW44QawEV4HqKD+tiLKGoB3mAuCjI3Pftq2
	fatONHia2TWFA2m+Y6Wq//SGeq4WEAI2FrYKvhktjSBBBha8uF1TZc8En364ljEhJEkZYSC+RAcDw
	1rFjdYI5W+rNiG8uONqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rovma-00000002fV2-0QnN;
	Tue, 26 Mar 2024 01:39:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rovmW-00000002fUK-0rNi
	for kexec@lists.infradead.org;
	Tue, 26 Mar 2024 01:39:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711417153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTaD6mudg7VhN+d5uv+mspRcpmC/ctCIgx4dGqOcYps=;
	b=eeLR3mjNt/8vZD/op0V2xrWfeyHNBoAdyc19DhJvqEMY9+YKNkGhYaWNwNTop33JzO/4zl
	JO5kr8w7yPr6lkSx8g2c83bBdUCdfsDNA8iyJ0zKUHyq6prQmy1oZ1cnVLBrnzP+SYO3sM
	4wO27W2lgdk3FRKTEPdxaORubQ8aJdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-tubJ1ArWPP-UWynZwFCWDw-1; Mon, 25 Mar 2024 21:39:11 -0400
X-MC-Unique: tubJ1ArWPP-UWynZwFCWDw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ecf15c037so3932997f8f.3
        for <kexec@lists.infradead.org>; Mon, 25 Mar 2024 18:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711417150; x=1712021950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTaD6mudg7VhN+d5uv+mspRcpmC/ctCIgx4dGqOcYps=;
        b=VGAiQ6IRqPD6Bd7hG3KZjS5OyXze3NF1pSSD/qvagqxBIX9GC00qheGXredBvx56Sj
         lxHem8CTArJQMVvqwCPPc7yXpPoLlZ9qBvWAf2o8c4P/E23QgSxtkvGgtO7dDAhbCZKR
         zaB1s35n+2GDV50KeYsh5VTf7vbMYLOoGE5qxu8DlnudQSBAlzOFoVJ44bTD+ETXHPAN
         bGwrAiNo4TYzKMuIdP5jdLD8gpXW5zaoGA4Bb6zmA4/U4FeoF9s3o2yGAS8mZZFPZeBV
         KpQ2itYR2R/3XU8E7wH1ukXttndEVttxvIKCrRdyjdRC/OZ1iwn5xn+OAZWMw8pspfCd
         5Z8g==
X-Forwarded-Encrypted: i=1; AJvYcCX0EINtZkVnkRC0vZYGrVhAkj4oUrpc3RPSPuzQemn6+QF4B7XQe1NRc7avZohS/IO1BhCOiTf0+hjxAN9qM+AcFG8n6eacpEql
X-Gm-Message-State: AOJu0YxO6p0WH++IJyHFSJFrqiLx6w66sqTloYsmtJcOuZwkREJ5D2yn
	LfQvCfOBMm/avUTVQxumyvCXD68iCp0IksMFVTfwDQ/y6dq5n1mpQRp1HMtctfoiFfVGiYInAs4
	ULrsZaFJujn8D8K2f0TCc7TXBc7wM0gvsF9K+79wVcTJ0C5YSmVxtB4gaCMw68cygSF23Kbx8vb
	9iQsxUxNDv+r8ECUsAZwGHGGwDDiWVIGlD
X-Received: by 2002:a5d:60c9:0:b0:341:865b:65c9 with SMTP id x9-20020a5d60c9000000b00341865b65c9mr7571757wrt.22.1711417150411;
        Mon, 25 Mar 2024 18:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGAVRQvSolwKhN9lxaw7HUOTpaQxkO72OCZv+7YVENFG33vSWYVqDPTA5Pq/1JgP4Gbiom3nqQHbE/DxEgqA8=
X-Received: by 2002:a5d:60c9:0:b0:341:865b:65c9 with SMTP id
 x9-20020a5d60c9000000b00341865b65c9mr7571746wrt.22.1711417150064; Mon, 25 Mar
 2024 18:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
In-Reply-To: <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 26 Mar 2024 09:38:33 +0800
Message-ID: <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
Subject: Re: Implementing .shutdown method for efa module
To: Gal Pressman <gal.pressman@linux.dev>
Cc: mrgolin@amazon.com, sleybo@amazon.com, jgg@ziepe.ca, leon@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_183916_349991_A5CAF75D 
X-CRM114-Status: GOOD (  26.06  )
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

SGkgR2FsLAoKT24gTW9uLCBNYXIgMjUsIDIwMjQgYXQgNDowNuKAr1BNIEdhbCBQcmVzc21hbiA8
Z2FsLnByZXNzbWFuQGxpbnV4LmRldj4gd3JvdGU6Cj4KPiBPbiAyNS8wMy8yMDI0IDQ6MTAsIFRh
byBMaXUgd3JvdGU6Cj4gPiBIaSwKPiA+Cj4gPiBSZWNlbnRseSBJIGV4cGVyaWVuY2VkIGEga2Vy
bmVsIHBhbmljIHdoaWNoIGlzIHJlbGF0ZWQgdG8gZWZhIG1vZHVsZQo+ID4gd2hlbiB0ZXN0aW5n
IGtleGVjIC1sICYmIGtleGVjIC1lIHRvIHN3aXRjaCB0byBhIG5ldyBrZXJuZWwgb24gQVdTCj4g
PiBpNGcuMTZ4bGFyZ2UgaW5zdGFuY2UuCj4gPgo+ID4gSGVyZSBpcyB0aGUgZG1lc2cgbG9nOgo+
ID4KPiA+IFsgICAgNi4zNzk5MThdIHN5c3RlbWRbMV06IE1vdW50aW5nIEZVU0UgQ29udHJvbCBG
aWxlIFN5c3RlbS4uLgo+ID4gWyAgICA2LjM4MTk4NF0gc3lzdGVtZFsxXTogTW91bnRpbmcgS2Vy
bmVsIENvbmZpZ3VyYXRpb24gRmlsZSBTeXN0ZW0uLi4KPiA+IFsgICAgNi4zODM5MThdIHN5c3Rl
bWRbMV06IFN0YXJ0aW5nIEFwcGx5IEtlcm5lbCBWYXJpYWJsZXMuLi4KPiA+IFsgICAgNi4zODU0
MzBdIHN5c3RlbWRbMV06IFN0YXJ0ZWQgSm91cm5hbCBTZXJ2aWNlLgo+ID4gWyAgICA2LjM5NDIy
MV0gQUNQSTogYnVzIHR5cGUgZHJtX2Nvbm5lY3RvciByZWdpc3RlcmVkCj4gPiBbICAgIDYuNDIx
NDA4XSBzeXN0ZW1kLWpvdXJuYWxkWzEyNjNdOiBSZWNlaXZlZCBjbGllbnQgcmVxdWVzdCB0bwo+
ID4gZmx1c2ggcnVudGltZSBqb3VybmFsLgo+ID4gWyAgICA3LjI2MjU0M10gZWZhIDAwMDA6MDA6
MWIuMDogZW5hYmxpbmcgZGV2aWNlICgwMDEwIC0+IDAwMTIpCj4gPiBbICAgIDcuNDMyNDIwXSBl
ZmEgMDAwMDowMDoxYi4wOiBTZXR1cCBpcnE6MTkxIG5hbWU6ZWZhLW1nbW50QHBjaTowMDAwOjAw
OjFiLjAKPiA+IFsgICAgNy40MzU1ODFdIGVmYSAwMDAwOjAwOjFiLjAgZWZhXzA6IElCIGRldmlj
ZSByZWdpc3RlcmVkCj4gPiBbICAgIDcuODg1NTY0XSByYW5kb206IGNybmcgaW5pdCBkb25lCj4g
PiBbICAgIDguMTM5ODU3XSBYRlMgKG52bWUwbjFwMik6IE1vdW50aW5nIFY1IEZpbGVzeXN0ZW0K
PiA+IGQ3MDAzZWNjLWRiNmYtNGJmYi1iZjkyLTYwMzc2YjZhNjU2Mwo+ID4gWyAgICA4LjI2NTIz
M10gWEZTIChudm1lMG4xcDIpOiBFbmRpbmcgY2xlYW4gbW91bnQKPiA+IFsgICAxMC41NTU2MTJd
IElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBldGgwOiBsaW5rIGJlY29tZXMgcmVhZHkK
PiA+Cj4gPiBSZWQgSGF0IEVudGVycHJpc2UgTGludXggOS40IEJldGEgKFBsb3cpCj4gPiBLZXJu
ZWwgNS4xNC4wLTQyNS5lbDkuYWFyY2g2NCBvbiBhbiBhYXJjaDY0Cj4gPgo+ID4gaXAtMTAtMC0y
Ny0yMjYgbG9naW46IFsgICAyOS45NDAzODFdIGtleGVjX2NvcmU6IFN0YXJ0aW5nIG5ldyBrZXJu
ZWwKPiA+IFsgICAzMC4wNzkyNzldIHBzY2k6IENQVTEga2lsbGVkIChwb2xsZWQgMCBtcykKPiA+
IFsgICAzMC4xMTkyMjJdIHBzY2k6IENQVTIga2lsbGVkIChwb2xsZWQgMCBtcykKPiA+IFsgICAz
MC4xOTkyOTNdIHBzY2k6IENQVTMga2lsbGVkIChwb2xsZWQgMCBtcykKPiA+IFsgICAzMC4zMDky
MTRdIHBzY2k6IENQVTQga2lsbGVkIChwb2xsZWQgMCBtcykKPiA+IFsgICAzMC4zNzkyMjFdIHBz
Y2k6IENQVTUga2lsbGVkIChwb2xsZWQgMCBtcykKPiA+IFsgICAzMC40MTkyMTBdIHBzY2k6IENQ
VTYga2lsbGVkIChwb2xsZWQgMCBtcykKPiA+IFsgICAzMC40ODkyMDddIElSUSAxOTE6IG5vIGxv
bmdlciBhZmZpbmUgdG8gQ1BVNwo+ID4gWyAgIDMwLjQ4OTY2N10gcHNjaTogQ1BVNyBraWxsZWQg
KHBvbGxlZCAwIG1zKQo+ID4gLi5zbmlwLi4uCj4gPiBbICAgMzMuODQ5MTIzXSBwc2NpOiBDUFU2
MyBraWxsZWQgKHBvbGxlZCAwIG1zKQo+ID4gWyAgIDMzLjg0OTk0M10gQnllIQo+ID4gWyAgICAw
LjAwMDAwMF0gQm9vdGluZyBMaW51eCBvbiBwaHlzaWNhbCBDUFUgMHgwMDAwMDAwMDAwIFsweDQx
M2ZkMGMxXQo+ID4gWyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA1LjE0LjAtNDE3LmVsOS5h
YXJjaDY0Cj4gPiAobW9ja2J1aWxkQGFybTY0LTAyNS5idWlsZC5lbmcuYm9zLnJlZGhhdC5jb20p
IChnY2MgKEdDQykgMTEuNC4xCj4gPiAyMDIzMTIxOCAoUmVkIEhhdCAxMS40LjEtMyksIEdOVSBs
ZCB2ZXJzaW9uIDIuMzUuMi00Mi5lbDkpICMxIFNNUAo+ID4gUFJFRU1QVF9EWU5BTUlDIFRodSBG
ZWIgMSAyMToyMzowMyBFU1QgMjAyNAo+ID4gLi4uc25pcC4uLgo+ID4gWyAgICAxLjAxMjY5Ml0g
RnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogNjAxNksKPiA+IFsgICAgMi4zNzA5NDddIENo
ZWNrZWQgVytYIG1hcHBpbmdzOiBwYXNzZWQsIG5vIFcrWCBwYWdlcyBmb3VuZAo+ID4gWyAgICAy
LjM3MDk4MF0gUnVuIC9pbml0IGFzIGluaXQgcHJvY2Vzcwo+ID4gWyAgICAyLjM3MDk4Ml0gICB3
aXRoIGFyZ3VtZW50czoKPiA+IFsgICAgMi4zNzA5ODNdICAgICAvaW5pdAo+ID4gWyAgICAyLjM3
MDk4NF0gICB3aXRoIGVudmlyb25tZW50Ogo+ID4gWyAgICAyLjM3MDk4NF0gICAgIEhPTUU9Lwo+
ID4gWyAgICAyLjM3MDk4NV0gICAgIFRFUk09bGludXgKPiA+IFsgICAgMi4zNzMyNTddIEtlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0IQo+ID4gZXhpdGNv
ZGU9MHgwMDAwMDAwYgo+ID4gWyAgICAyLjM3MzI1OV0gQ1BVOiAxIFBJRDogMSBDb21tOiBpbml0
IE5vdCB0YWludGVkIDUuMTQuMC00MTcuZWw5LmFhcmNoNjQgIzEKPiA+IFsgICAgMi4zODIyNDBd
IEhhcmR3YXJlIG5hbWU6IEFtYXpvbiBFQzIgaTRnLjE2eGxhcmdlLywgQklPUyAxLjAgMTEvMS8y
MDE4Cj4gPiBbICAgIDIuMzgzODE0XSBDYWxsIHRyYWNlOgo+ID4gWyAgICAyLjM4NDQxMF0gIGR1
bXBfYmFja3RyYWNlKzB4YTgvMHgxMjAKPiA+IFsgICAgMi4zODUzMThdICBzaG93X3N0YWNrKzB4
MWMvMHgzMAo+ID4gWyAgICAyLjM4NjEyNF0gIGR1bXBfc3RhY2tfbHZsKzB4NzQvMHg4Ywo+ID4g
WyAgICAyLjM4NzAxMV0gIGR1bXBfc3RhY2srMHgxNC8weDI0Cj4gPiBbICAgIDIuMzg3ODEwXSAg
cGFuaWMrMHgxNTgvMHgzNjgKPiA+IFsgICAgMi4zODg1NTNdICBkb19leGl0KzB4M2E4LzB4M2Iw
Cj4gPiBbICAgIDIuMzg5MzMzXSAgZG9fZ3JvdXBfZXhpdCsweDM4LzB4YTQKPiA+IFsgICAgMi4z
OTAxOTVdICBnZXRfc2lnbmFsKzB4N2E0LzB4ODEwCj4gPiBbICAgIDIuMzkxMDQ0XSAgZG9fc2ln
bmFsKzB4MWJjLzB4MjYwCj4gPiBbICAgIDIuMzkxODcwXSAgZG9fbm90aWZ5X3Jlc3VtZSsweDEw
OC8weDIxMAo+ID4gWyAgICAyLjM5MjgzOV0gIGVsMF9kYSsweDE1NC8weDE2MAo+ID4gWyAgICAy
LjM5MzYwM10gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4ZGMvMHgxNTAKPiA+IFsgICAgMi4zOTQ2
MjhdICBlbDB0XzY0X3N5bmMrMHgxN2MvMHgxODAKPiA+IFsgICAgMi4zOTU1MTNdIFNNUDogc3Rv
cHBpbmcgc2Vjb25kYXJ5IENQVXMKPiA+IFsgICAgMi4zOTY0ODNdIEtlcm5lbCBPZmZzZXQ6IDB4
NTg2ZjA0ZTAwMDAwIGZyb20gMHhmZmZmODAwMDA4MDAwMDAwCj4gPiBbICAgIDIuMzk3OTM0XSBQ
SFlTX09GRlNFVDogMHg0MDAwMDAwMAo+ID4gWyAgICAyLjM5ODc3NF0gQ1BVIGZlYXR1cmVzOiAw
eDAsMDAwMDAxMDEsNzAwMjAxNDMsMTA0MTdhMGIKPiA+IFsgICAgMi40MDAwNDJdIE1lbW9yeSBM
aW1pdDogbm9uZQo+ID4gWyAgICAyLjQwMDc4M10gLS0tWyBlbmQgS2VybmVsIHBhbmljIC0gbm90
IHN5bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsCj4gPiBpbml0ISBleGl0Y29kZT0weDAwMDAwMDBi
IF0tLS0KPiA+Cj4gPiBJbiB0aGUgZG1lc2cgbG9nLCBJIGZvdW5kICJbICAgMzAuNDg5MjA3XSBJ
UlEgMTkxOiBubyBsb25nZXIgYWZmaW5lIHRvCj4gPiBDUFU3IiBpcyBzdXNwaWNpb3VzLCB3aGlj
aCBpcyByZWxhdGVkIHRvIGVmYSBtb2R1bGUuIEFmdGVyIGJsYWNrbGlzdAo+ID4gZWZhIG1vZHVs
ZSBmcm9tIGF1dG9tYXRpYyBsb2FkaW5nIHdoZW4gYm9vdHVwLCB0aGUga2VybmVsIHBhbmljIGlz
c3VlCj4gPiBkb2Vzbid0IGFwcGVhciBhZ2Fpbi4KPiA+Cj4gPiBJdCBsb29rcyB0byBtZSBpdCBp
cyBkdWUgdG8gdGhlIGVmYSBiZWluZyBub3QgcHJvcGVybHkgc2h1dGRvd24gZHVyaW5nCj4gPiBr
ZXhlYywgc28gdGhlIG9uZ29pbmcgRE1BL2ludGVycnVwdHMgZXRjIG92ZXJ3cml0ZSB0aGUgbWVt
b3J5IHJhbmdlLgo+ID4KPiA+IFRob3VnaCB0aGUgaXNzdWUgaXMgcmVwcm9kdWNlZCBvbiByaGVs
J3Mga2VybmVsLCB0aGUgdXBzdHJlYW0ga2VybmVsCj4gPiBbMV0gZG9lc24ndCBoYXZlIHRoZSAu
c2h1dGRvd24gbWV0aG9kIGltcGxlbWVudGVkIGVpdGhlci4gU2luY2UgSSdtCj4gPiBub3QgdmVy
eSBmYW1pbGlhciB3aXRoIHRoZSBlZmEgZHJpdmVyLCBjb3VsZCB5b3UgcGxlYXNlIGltcGxlbWVu
dCB0aGUKPiA+IC5zaHV0ZG93biBtZXRob2QgaW4gZHJpdmVycy9pbmZpbmliYW5kL2h3L2VmYS9l
ZmFfbWFpbi5jPyBUaGFua3MgaW4KPiA+IGFkdmFuY2UhCj4KPiBEaWQgeW91IHRyeSB0byByZXBy
b2R1Y2UgaXQgb24gdXBzdHJlYW0ga2VybmVsPwo+ClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyEg
Tm8gSSBoYXZlbid0LCBJIHdpbGwgZ2l2ZSBpdCBhIHRyeS4KPiA+Cj4gPiBbMV06IGh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL2luZmluaWJhbmQv
aHcvZWZhL2VmYV9tYWluLmMjTDY3NAo+ID4KPiA+IFRoYW5rcywKPiA+IFRhbyBMaXUKPiA+Cj4K
PiBUcnkgYXNzaWduaW5nIGVmYV9yZW1vdmUgYXMgdGhlIHNodXRkb3duIGNhbGxiYWNrOgo+ICAg
ICAuc2h1dGRvd24gPSBlZmFfcmVtb3ZlLAo+Cj4gRG9lcyBpdCBmaXggaXQ/CgpUaGFua3MsIEkg
d2lsbCBhbHNvIHRyeSB0aGUgY29kZSwgYW5kIEkgd2lsbCBwb3N0IHRoZSB0ZXN0aW5nIHJlc3Vs
dHMuCgpUaGFua3MsClRhbyBMaXUKCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
