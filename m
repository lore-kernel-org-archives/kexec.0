Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC7C0015E
	for <kexec@archiver.kernel.org>; Thu, 27 Jul 2023 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iqa+5i/8/QVHm3OgS1Y4FKFIJW+u9DDM1WY1BBL6Utg=; b=s2b+tvYD0DXw9M
	HBBoKRojb3MQgfyG84nc1+gxaw6WPjOQ/psSJqeyKfdGjFoumPL+DPcmW07ouRUH8i4AWVfj1kbt8
	W0VOHyQGSNEskZOl1j9qirx15jkKfM8w/XxXZ0XVrkwy8xPRmN3nCVFNCtaEOVfD9kbj6ug/7dxJB
	mgKqIkKM0jJtb87aeSA66A1IjtXWA0re7lB+qC9DtPD0cqZxoTvm80vVlbLoQ5Pg6NJeevcPbwSmt
	Big1IJDZC9eTK2LosfjSOVmU7Kll5/WpGCTqGuNzCHv0IMJ2r/h9auIhzEtJ0H2C2SfHf9lGg+QF2
	LnDQcfkL8yjjrej1wt4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOyum-00DGlC-0M;
	Thu, 27 Jul 2023 11:12:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOyuh-00DGil-1x
	for kexec@lists.infradead.org;
	Thu, 27 Jul 2023 11:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690456329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzR/29ssKHTlIDAdd/Fjb9KFzV0w37Bkt3676oqfegA=;
	b=jLuIgblHITgzhYHQhZ8PFQovOuOfzn1EwRKTqHvzB8evfudCnhgl9TOldi1PTjs2Kq1E1r
	qWx0bKPa/nDrEjmmLDXzhr5Jw7kkYY4xqtQR6aZsGrcil9l6dvdaMb0rccn+LZXm8U5RqF
	8/OwuQzfjIGMps9XXaXfqMHxVzVgHtE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-1s9UzCGdMdCHwLq5IKQMmg-1; Thu, 27 Jul 2023 07:12:07 -0400
X-MC-Unique: 1s9UzCGdMdCHwLq5IKQMmg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9525b64d2so7545001fa.3
        for <kexec@lists.infradead.org>; Thu, 27 Jul 2023 04:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456326; x=1691061126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzR/29ssKHTlIDAdd/Fjb9KFzV0w37Bkt3676oqfegA=;
        b=XQfp/PskCGzR16ty6lOLm0syuYXiJsZ2GbCsxWj/zKH1xhaDcgcnBUKvlcc+9BqLYk
         lhsQjNQmaGQ4Kg5wtoiyBEzHbCeUcwZCrHz1nSKGI9WViGssCe/hSWIBxRWUJEOGiS75
         HjJOVYNiXevX1qcu6ouk9IXCR5WFvDPISs/i+pu76m/gueZzMgDM8zuc0qgtwYhdDF33
         TujGpQORTNKZM96zKKVBQwSN67yw/5Xs4p7R/D8q57iMu+E6MDLfgfJ+k6zplfeScb6f
         IWnf36yYO8odN0wRRAJSLxM26/CDvOn0U3hsCMzfaTwRQDWRrccTHB4lc+6HpjE8D085
         l63w==
X-Gm-Message-State: ABy/qLbwqfn7LOTdf+qt0foKFZwz43tamV+ASJwOEhwhT99FPXi7vcZe
	fffXoQav8eDKE9vferXLracbPnFmZEWiDKW44T4C6SNTIVZ9l2JJiS0LmKhydz7+22pDDZWxu1F
	+4wb+f1lBe02PBFMUYSaSdo1UeyN1RMcgPMR2
X-Received: by 2002:a05:6512:2386:b0:4fb:821e:2241 with SMTP id c6-20020a056512238600b004fb821e2241mr2053312lfv.23.1690456325984;
        Thu, 27 Jul 2023 04:12:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVcSXFbTNHvChrljnKmKfUt/IbSL9KtTtcftDFpfX3hleE49JbqtNOhURn54n+68XPYFw909b0goEvLHGOH5s=
X-Received: by 2002:a05:6512:2386:b0:4fb:821e:2241 with SMTP id
 c6-20020a056512238600b004fb821e2241mr2053291lfv.23.1690456325651; Thu, 27 Jul
 2023 04:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com> <CAO7dBbXhF36vCgVMOM2H83H34OqsA6J3KmsBMvYcs_p9_5pa4Q@mail.gmail.com>
In-Reply-To: <CAO7dBbXhF36vCgVMOM2H83H34OqsA6J3KmsBMvYcs_p9_5pa4Q@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 27 Jul 2023 19:11:29 +0800
Message-ID: <CAO7dBbXN6hTbJVH8V5UCAxcOM4+-f0qACbd9n9HaP19F4mPEqw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_041212_210843_586D575B 
X-CRM114-Status: GOOD (  31.88  )
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

SGkgQXJkLAoKT24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgMTE6MTHigK9QTSBUYW8gTGl1IDxsdGFv
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgMTA6NTfigK9Q
TSBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24s
IDE3IEp1bCAyMDIzIGF0IDE1OjUzLCBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPgo+ID4gPiBIaSBCb3Jpc2xhdiwKPiA+ID4KPiA+ID4gT24gVGh1LCBKdWwgMTMsIDIwMjMg
YXQgNjowNeKAr1BNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToKPiA+ID4g
Pgo+ID4gPiA+IE9uIFRodSwgSnVuIDAxLCAyMDIzIGF0IDAzOjIwOjQ0UE0gKzA4MDAsIFRhbyBM
aXUgd3JvdGU6Cj4gPiA+ID4gPiAgYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyB8
IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4gPiA+Cj4gPiA+ID4gT2ss
IHBscyB0cnkgdGhpcyB0b3RhbGx5IHVudGVzdGVkIHRoaW5nLgo+ID4gPiA+Cj4gPiA+ID4gVGh4
Lgo+ID4gPiA+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3Qv
Y29tcHJlc3NlZC9zZXYuYyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9zZXYuYwo+ID4gPiA+
IGluZGV4IDA5ZGM4YzE4N2IzYy4uZmVmZTI3YjJhZjg1IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2Fy
Y2gveDg2L2Jvb3QvY29tcHJlc3NlZC9zZXYuYwo+ID4gPiA+ICsrKyBiL2FyY2gveDg2L2Jvb3Qv
Y29tcHJlc3NlZC9zZXYuYwo+ID4gPiA+IEBAIC00MDQsMTMgKzQwNCwyMCBAQCB2b2lkIHNldl9l
bmFibGUoc3RydWN0IGJvb3RfcGFyYW1zICpicCkKPiA+ID4gPiAgICAgICAgIGlmIChicCkKPiA+
ID4gPiAgICAgICAgICAgICAgICAgYnAtPmNjX2Jsb2JfYWRkcmVzcyA9IDA7Cj4gPiA+ID4KPiA+
ID4gPiArICAgICAgIC8qIENoZWNrIGZvciB0aGUgU01FL1NFViBzdXBwb3J0IGxlYWYgKi8KPiA+
ID4gPiArICAgICAgIGVheCA9IDB4ODAwMDAwMDA7Cj4gPiA+ID4gKyAgICAgICBlY3ggPSAwOwo+
ID4gPiA+ICsgICAgICAgbmF0aXZlX2NwdWlkKCZlYXgsICZlYngsICZlY3gsICZlZHgpOwo+ID4g
PiA+ICsgICAgICAgaWYgKGVheCA8IDB4ODAwMDAwMWYpCj4gPiA+ID4gKyAgICAgICAgICAgICAg
IHJldHVybjsKPiA+ID4gPiArCj4gPiA+ID4gICAgICAgICAvKgo+ID4gPiA+ICAgICAgICAgICog
U2V0dXAvcHJlbGltaW5hcnkgZGV0ZWN0aW9uIG9mIFNOUC4gVGhpcyB3aWxsIGJlIHNhbml0eS1j
aGVja2VkCj4gPiA+ID4gICAgICAgICAgKiBhZ2FpbnN0IENQVUlEL01TUiB2YWx1ZXMgbGF0ZXIu
Cj4gPiA+ID4gICAgICAgICAgKi8KPiA+ID4gPiAgICAgICAgIHNucCA9IHNucF9pbml0KGJwKTsK
PiA+ID4gPgo+ID4gPiA+IC0gICAgICAgLyogQ2hlY2sgZm9yIHRoZSBTTUUvU0VWIHN1cHBvcnQg
bGVhZiAqLwo+ID4gPiA+ICsgICAgICAgLyogUmVjaGVjayB0aGUgU01FL1NFViBzdXBwb3J0IGxl
YWYgKi8KPiA+ID4gPiAgICAgICAgIGVheCA9IDB4ODAwMDAwMDA7Cj4gPiA+ID4gICAgICAgICBl
Y3ggPSAwOwo+ID4gPiA+ICAgICAgICAgbmF0aXZlX2NwdWlkKCZlYXgsICZlYngsICZlY3gsICZl
ZHgpOwo+ID4gPiA+Cj4gPiA+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIHBhdGNoIGFib3ZlISBTb3Jy
eSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuIEkgaGF2ZQo+ID4gPiBjb21waWxlZCBhbmQgdGVzdGVk
IGl0IGxvY2FsbHkgYWdhaW5zdCA2LjUuMC1yYzEsIHRob3VnaCBpdCBjYW4gcGFzcwo+ID4gPiB0
aGUgZWFybHkgc3RhZ2Ugb2Yga2V4ZWMga2VybmVsIGJvb3R1cCwKPiA+Cj4gPiBPSywgc28gdGhh
dCBwcm92ZXMgdGhhdCB0aGUgY2NfYmxvYiB0YWJsZSBhY2Nlc3MgaXMgdGhlIGN1bHByaXQgaGVy
ZS4KPiA+IFRoYXQgc3RpbGwgbWVhbnMgdGhhdCBrZXhlYyBvbiBTRVYgaXMgbGlrZWx5IHRvIGV4
cGxvZGUgaW4gdGhlIGV4YWN0Cj4gPiBzYW1lIHdheSBzaG91bGQgYW55b25lIGF0dGVtcHQgdGhh
dC4KPiA+Cj4gPgo+ID4gPiBob3dldmVyIHRoZSBrZXJuZWwgd2lsbCBwYW5pYwo+ID4gPiBvY2Nh
c2lvbmFsbHkgbGF0ZXIuIFRoZSB0ZXN0IG1hY2hpbmUgaXMgdGhlIG9uZSB3aXRoIEludGVsIEF0
b20KPiA+ID4geDY0MjVSRSBjcHUgd2hpY2ggZW5jb3VudGVyZWQgdGhlIHBhZ2UgZmF1bHQgaXNz
dWUgb2YgbWlzc2luZyBlZmkKPiA+ID4gY29uZmlnIHRhYmxlLgo+ID4gPgo+ID4KPiA+IEFncmVl
IHdpdGggQm9yaXMgdGhhdCB0aGlzIHNlZW1zIGVudGlyZWx5IHVucmVsYXRlZC4KPgo+IEFncmVl
LCBJIHdpbGwgaGF2ZSBhIHJldGVzdCBiYXNlZCBvbiBCb3JpcydzIHN1Z2dlc3Rpb25zLgo+Cj4g
Pgo+ID4gPiAuLi5zbmlwLi4uCj4gPiA+IFsgICAyMS4zNjA3NjNdICBudm1lMG4xOiBwMSBwMiBw
Mwo+ID4gPiBbICAgMjEuMzY0MjA3XSBpZ2MgMDAwMDowMzowMC4wOiBQVE0gZW5hYmxlZCwgNG5z
IGdyYW51bGFyaXR5Cj4gPiA+IFsgICAyMS40MjEwOTddIHBwcyBwcHMxOiBuZXcgUFBTIHNvdXJj
ZSBwdHAxCj4gPiA+IFsgICAyMS40MjUzOTZdIGlnYyAwMDAwOjAzOjAwLjAgKHVubmFtZWQgbmV0
X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBQSEMgYWRkZWQKPiA+ID4gWyAgIDIxLjQ1NzAwNV0g
aWdjIDAwMDA6MDM6MDAuMDogNC4wMDAgR2IvcyBhdmFpbGFibGUgUENJZSBiYW5kd2lkdGgKPiA+
ID4gKDUuMCBHVC9zIFBDSWUgeDEgbGluaykKPiA+ID4gWyAgIDIxLjQ2NTIxMF0gaWdjIDAwMDA6
MDM6MDAuMCBldGgxOiBNQUM6IC4uLnNuaXAuLi4KPiA+ID4gWyAgIDIxLjQ3MzQyNF0gaWdjIDAw
MDA6MDM6MDAuMCBlbnAzczA6IHJlbmFtZWQgZnJvbSBldGgxCj4gPiA+IFsgICAyMS40Nzk0NDZd
IEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAw
MDAwMDAwOAo+ID4gPiBbICAgMjEuNDg2NDA1XSAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3Mg
aW4ga2VybmVsIG1vZGUKPiA+ID4gWyAgIDIxLjQ5MTUxOV0gbW1jMTogRmFpbGVkIHRvIGluaXRp
YWxpemUgYSBub24tcmVtb3ZhYmxlIGNhcmQKPiA+ID4gWyAgIDIxLjQ5MTUzOF0gI1BGOiBlcnJv
cl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4gPiA+IFsgICAyMS41MDIyMjldIFBH
RCAwIFA0RCAwCj4gPiA+IFsgICAyMS41MDQ3NzNdIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNN
UCBOT1BUSQo+ID4gPiBbICAgMjEuNTA5MTMzXSBDUFU6IDMgUElEOiA0MDIgQ29tbTogc3lzdGVt
ZC11ZGV2ZCBOb3QgdGFpbnRlZCA2LjUuMC1yYzErICMxCj4gPiA+IFsgICAyMS41MTU5MDVdIEhh
cmR3YXJlIG5hbWU6IC4uLnNuaXAuLi4KPiA+Cj4gPgo+ID4gV2h5IGFyZSB5b3Ugc25pcHBpbmcg
dGhlIGhhcmR3YXJlIG5hbWU/Cj4KCk91ciBwYXJ0bmVyIHNhaWQgaXQgaXMgT0sgdG8gZGlzY3Vz
cyBpbiBwdWJsaWMsIHNvIHRoZSBoYXJkd2FyZSBpczoKSGFyZHdhcmUgbmFtZTogTEVOT1ZPIDEx
S0wwRlZUMDYvMzMzNCwgQklPUyBNNFhLVDE0QSAwNS8xNy8yMDIzCgpUaGUgbWFjaGluZSBpcyBM
ZW5vdm8gVGhpbmtFZGdlIFNFMTAuCgpUaGFua3MsClRhbyBMaXUKCj4gU29ycnkgZm9yIHRoZSBp
bmNvbnZlbmllbmNlIGhlcmUuLi4gVGhlIG1hY2hpbmUgaXMgYm9ycm93ZWQgZnJvbSBvdXIKPiBw
YXJ0bmVyLCB3aGljaCBtYXkgbm90IGJlIG9mZmljaWFsbHkgcmVsZWFzZWQgdG8gdGhlIG1hcmtl
dC4gSSBoYXZlbid0Cj4gZGlzY3Vzc2VkIHRoZSBsZWdhbCBpc3N1ZSB3aXRoIHRoZW0uIEluIGFk
ZGl0aW9uLCBJIHRoaW5rIHRoZSBzdGFjawo+IHRyYWNlIGlzIG1vcmUgdXNlZnVsLCBzbyBJIHNu
aXBwZWQgdGhlIGhhcmR3YXJlIG5hbWUuIFNvcnJ5IGFib3V0Cj4gdGhhdC4uLgo+Cj4gPgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
