Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732C4C00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 06:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sTxtlQFNBigT77FiLpcLuLEiTE30XzzMnnD6lWrAwDg=; b=fUCFrhtqUZ8ByY
	oO3fpYVzpbwxA35/VMGrtR7IWTrfPYYj0twM77D94CsKkr5SMC+5eO4bagqWBId9Yv2hzfWITgk6A
	BynolXd3WQMywIOXmAA5jwTQGTjpDYMklSGRxLnWqDzMzp0eCWveATA6B+SsSbDH7tsI2mmUYhwwK
	roLuguSfGAi8raINN3ciajrFEa8O1FneC/z+CbjA96UuZ4kIDdfO7DoIzyPEacfA/vgliAkI3T/ew
	4GdyNKTXf+MJ9nrviLbiPsAursvqXDpyQN7Z7h3eGEHK1J5DGNnqFDrHCMPavAeoJ3u81n9v1MhLh
	Qg3UwhQwf5G6DUkFiOUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIlHF-00AugE-Sy; Tue, 02 Aug 2022 06:21:14 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIlH6-00AucP-Ni
	for kexec@lists.infradead.org; Tue, 02 Aug 2022 06:21:08 +0000
Received: by mail-wr1-x434.google.com with SMTP id j15so8476652wrr.2
        for <kexec@lists.infradead.org>; Mon, 01 Aug 2022 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSse5FKWL5kgJ+ejLrneA4q2v7qyL79FOUMp7CrCCXs=;
        b=BcjRUF9h+NwxPb28S85WIalzQC2VbdN+D8R/grvLJn86rcmyW+Pht6z84HK+GRJHyW
         Fj/VSfr8Qq9UDP1Amzvd6Av6ynuA5xRB9Cs3MTlz6/wRiP6VChiR5sNpwRHKX7KpOKU4
         vfdGGOEQclsTz7QS+LSeYZhT3MNIkX6Yp+D3c9ldqWqX9sR8YhH5ZA01XcG5M6LEeQph
         X9jSmnbQWcnXwVA54GY3KHHHkQYvDgBnTfDgiDSfnREniDa1fEmmPTZ2kfEZDQA6fI/v
         aAXjoUrmhAJSYk0y1PmX10wLhIzxqOROqRv0vIPzWn9CsDIQg21UbDXztj6DeFQjACEh
         U7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSse5FKWL5kgJ+ejLrneA4q2v7qyL79FOUMp7CrCCXs=;
        b=2RuQ89PWiwsBhWSy7iQNHNK9gsBeAgn7PGPTlI3UweHjNJzwpdeRny1ToSs95Hmbuc
         29/kdtZWfLax7nuL/a5PlKr4rNX2VhAFsGlh2+hhs8EP/dEOsKbptLmjSq6Zk5Z6NJyk
         joRzlMiH9Ve9B7GD2cAIk/4huCNqFS15h7X1oph7Js1j8nNK3hYMkUMF9olgo0KCFEg8
         8e5KnsyveLaiGhqm0D+kR3wzp3xEXGO87KAzsYWvwyoPalGjg6zW9e6Q3cwYql/V2o8D
         RexziV4KbE8U8dNjV79mS8qg4MaCSCTcJhU8gOmisj9ymyYUm1yffFQdaBi+vlzfQmsc
         YiUg==
X-Gm-Message-State: ACgBeo31kuS2mbYeWey2RiLnC7e1C67SfgobkvycgqT36zrf3EN3/dOn
	Pv05zmDUMoT15IwEktCK2lM=
X-Google-Smtp-Source: AA6agR4T3FIeyScX994uVLbWgpN5xhMLL0YKTgi3q9YLQTHazQmN2/yWlyOy9rpBthuuQT0yBTWrAQ==
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id x7-20020a5d4907000000b0021fbc420989mr8729711wrq.375.1659421260272;
        Mon, 01 Aug 2022 23:21:00 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id a1-20020adfe5c1000000b0021e491fd250sm7768696wrn.89.2022.08.01.23.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 23:20:58 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Date: Tue, 02 Aug 2022 08:20:57 +0200
Message-ID: <1923146.PYKUYFuaPT@opensuse>
In-Reply-To: <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com> <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_232104_818257_D0937F9F 
X-CRM114-Status: GOOD (  32.65  )
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

T24gbWFydGVkw6wgMiBhZ29zdG8gMjAyMiAwNTowNjo1NCBDRVNUIEJhb3F1YW4gSGUgd3JvdGU6
Cj4gT24gMDcvMDgvMjIgYXQgMDE6MTVhbSwgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdyb3RlOgo+
ID4gVGhlIHVzZSBvZiBrbWFwKCkgYW5kIGttYXBfYXRvbWljKCkgYXJlIGJlaW5nIGRlcHJlY2F0
ZWQgaW4gZmF2b3Igb2YKPiA+IGttYXBfbG9jYWxfcGFnZSgpLgo+ID4gCj4gPiBXaXRoIGttYXBf
bG9jYWxfcGFnZSgpLCB0aGUgbWFwcGluZ3MgYXJlIHBlciB0aHJlYWQsIENQVSBsb2NhbCBhbmQg
bm90Cj4gPiBnbG9iYWxseSB2aXNpYmxlLiBGdXJ0aGVybW9yZSwgdGhlIG1hcHBpbmdzIGNhbiBi
ZSBhY3F1aXJlZCBmcm9tIGFueQo+ID4gY29udGV4dCAoaW5jbHVkaW5nIGludGVycnVwdHMpLgo+
ID4gCj4gPiBUaGVyZWZvcmUsIHVzZSBrbWFwX2xvY2FsX3BhZ2UoKSBpbiBrZXhlY19jb3JlLmMg
YmVjYXVzZSB0aGVzZSBtYXBwaW5ncyAKYXJlCj4gPiBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGFu
ZCBub3QgZ2xvYmFsbHkgdmlzaWJsZS4KPiA+IAo+ID4gVGVzdGVkIG9uIGEgUUVNVSArIEtWTSAz
Mi1iaXRzIFZNIGJvb3RpbmcgYSBrZXJuZWwgd2l0aCBISUdITUVNNjRHQgo+ID4gZW5hYmxlZC4K
PiAKPiBXb25kZXJpbmcgd2hhdCBhcmNoIHlvdSB0ZXN0ZWQgd2l0aC4KCkknbSBzb3JyeSwgSSBm
b3Jnb3QgdG8gc2F5IHRoYXQgSSB1c2UgeDg2XzMyIHdpdGggNEdCIHRvIDZHQiBSQU0uClRoaXMg
aXMgdXN1YWxseSBhbiBpbmZvcm1hdGlvbiB0aGF0IEkgYWRkIGluIHRoZSBjb21taXQgbWVzc2Fn
ZXMgb2YgYWxsIHRoZSAKcmVjZW50IGNvbnZlcnNpb25zIEknbSB3b3JraW5nIG9uIGFjcm9zcyB0
aGUgZW50aXJlIGtlcm5lbC4KCkFub3RoZXIgaW1wb3J0YW50IGluZm9ybWF0aW9uIChvdmVybG9v
a2VkIGFnYWluIHRoaXMgdGltZSkgaXMgdGhhdCAoMSkgCmttYXAoKSBjb21lcyB3aXRoIGFuIG92
ZXJoZWFkIGFzIG1hcHBpbmcgc3BhY2UgaXMgcmVzdHJpY3RlZCBhbmQgcHJvdGVjdGVkIApieSBh
IGdsb2JhbCBsb2NrIGZvciBzeW5jaHJvbml6YXRpb24gYW5kICgyKSBpdCBhbHNvIHJlcXVpcmVz
IGdsb2JhbCBUTEIgCmludmFsaWRhdGlvbiB3aGVuIHRoZSBrbWFw4oCZcyBwb29sIHdyYXBzIGFu
ZCBpdCBtaWdodCBibG9jayB3aGVuIHRoZSBtYXBwaW5nIApzcGFjZSBpcyBmdWxseSB1dGlsaXpl
ZCB1bnRpbCBhIHNsb3QgYmVjb21lcyBhdmFpbGFibGUuCgpNb3JlIGluZm9ybWF0aW9uIGFib3V0
IHdoeSB0aGVzZSBrbWFwKCkgdG8ga21hcF9sb2NhbF9wYWdlKCkgY29udmVyc2lvbnMgCmFyZSBu
ZWVkZWQgLyBwcmVmZXJyZWQgY2FuIGJlIGZvdW5kIGluIHRoZSByZWNlbnQgY2hhbmdlcyBJIG1h
ZGUgdG8gCmhpZ2htZW0ucnN0LiBUaGV5IGFyZSBhbHJlYWR5IGluIG1haW5saW5lIHNpbmNlIGFi
b3V0IHR3byBtb250aHMuCgpBIHNlY29uZCByb3VuZCBvZiBhZGRpdGlvbmFsIGNoYW5nZXMgaGFz
IGJlZW4gdGFrZW4gYnkgQW5kcmV3IE0uIGp1c3QgZmV3IApkYXlzIGFnby4KCk15IGdvYWwgaXMg
dG8gY29udmVydCB0aGUgbW9zdCBvZiB0aGUga21hcCgpIGNhbGwgc2l0ZXMgdGhhdCBhcmUgc3Rp
bGwgbGVmdCAKYWNyb3NzIHRoZSB3aG9sZSBrZXJuZWwuIEknbSBub3QgeWV0IHN1cmUgdGhhdCB0
aGVzZSBraW5kcyBvZiBjb252ZXJzaW9ucyAKY2FuIGJlIGRvbmUgZXZlcnl3aGVyZSwgZXNwZWNp
YWxseSBpZiB0aGUga2VybmVsIHZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgCm1hcHBpbmcgaXMgaGFu
ZGVkIHRvIG90aGVyIGNvbnRleHRzLCBiZWNhdXNlIHRoaXMgd291bGQgaW52YWxpZGF0ZSB0aGUg
CnBvaW50ZXIgcmV0dXJuZWQgYnkga21hcF9sb2NhbF9wYWdlKCkuICAKCj4gVGhpcyBsb29rcyBn
b29kLCBidXQgbWF5IG5vdCBiZW5lZml0IG11Y2guIFNheSBzbyBiZWNhdXNlIEkgZG91YnQKPiBo
b3cgbWFueSAzMmJpdCBzeXN0ZW1zIGFyZSB1c2luZyBrZXhlYy9rZHVtcCBtZWNoYW5pc20uCgpJ
IHJlYWxseSBjYW5ub3Qgc2F5IG5vdGhpbmcgYWJvdXQgaG93IG1hbnkgMzIgYml0cyBzeXN0ZW1z
IGFyZSB1c2luZyBrZXhlYy8Ka2R1bXAgbWVjaGFuaXNtLCBob3dldmVyIEkgc3RpbGwgdGhpbmsg
dGhhdCB0aGUgY29udmVyc2lvbnMgYXJlIHdvcnRoIApldmVyeXdoZXJlLiAKCj4gQW55d2F5LCAK
PiAKPiBBY2tlZC1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gCgpUaGFuayB5b3Ug
c28gbXVjaCEKCkZhYmlvCgo+ID4gCj4gPiBTdWdnZXN0ZWQtYnk6IElyYSBXZWlueSA8aXJhLndl
aW55QGludGVsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIE0uIERlIEZyYW5jZXNjbyA8
Zm1kZWZyYW5jZXNjb0BnbWFpbC5jb20+Cj4gPiAtLS0KPiA+IAo+ID4gdjEtPnYyOiBBIHNlbnRl
bmNlIG9mIHRoZSBjb21taXQgbWVzc2FnZSBjb250YWluZWQgYW4gZXJyb3IgZHVlIHRvIGEKPiA+
IG1pc3Rha2UgaW4gY29weS1wYXN0aW5nIGZyb20gYSBwcmV2aW91cyBwYXRjaC4gUmVwbGFjZSAi
YWlvLmMiIHdpdGgKPiA+ICJrZXhlY19jb3JlLmMiLgo+ID4gCj4gPiAga2VybmVsL2tleGVjX2Nv
cmUuYyB8IDggKysrKy0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2tleGVjX2NvcmUuYyBi
L2tlcm5lbC9rZXhlY19jb3JlLmMKPiA+IGluZGV4IDRkMzRjNzgzMzRjZS4uNmY5ODI3NDc2NWQ0
IDEwMDY0NAo+ID4gLS0tIGEva2VybmVsL2tleGVjX2NvcmUuYwo+ID4gKysrIGIva2VybmVsL2tl
eGVjX2NvcmUuYwo+ID4gQEAgLTgxNCw3ICs4MTQsNyBAQCBzdGF0aWMgaW50IGtpbWFnZV9sb2Fk
X25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgCippbWFnZSwKPiA+ICAJCWlmIChyZXN1bHQg
PCAwKQo+ID4gIAkJCWdvdG8gb3V0Owo+ID4gIAo+ID4gLQkJcHRyID0ga21hcChwYWdlKTsKPiA+
ICsJCXB0ciA9IGttYXBfbG9jYWxfcGFnZShwYWdlKTsKPiA+ICAJCS8qIFN0YXJ0IHdpdGggYSBj
bGVhciBwYWdlICovCj4gPiAgCQljbGVhcl9wYWdlKHB0cik7Cj4gPiAgCQlwdHIgKz0gbWFkZHIg
JiB+UEFHRV9NQVNLOwo+ID4gQEAgLTgyNyw3ICs4MjcsNyBAQCBzdGF0aWMgaW50IGtpbWFnZV9s
b2FkX25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgCippbWFnZSwKPiA+ICAJCQltZW1jcHko
cHRyLCBrYnVmLCB1Y2h1bmspOwo+ID4gIAkJZWxzZQo+ID4gIAkJCXJlc3VsdCA9IGNvcHlfZnJv
bV91c2VyKHB0ciwgYnVmLCB1Y2h1bmspOwo+ID4gLQkJa3VubWFwKHBhZ2UpOwo+ID4gKwkJa3Vu
bWFwX2xvY2FsKHB0cik7Cj4gPiAgCQlpZiAocmVzdWx0KSB7Cj4gPiAgCQkJcmVzdWx0ID0gLUVG
QVVMVDsKPiA+ICAJCQlnb3RvIG91dDsKPiA+IEBAIC04NzgsNyArODc4LDcgQEAgc3RhdGljIGlu
dCBraW1hZ2VfbG9hZF9jcmFzaF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgCippbWFnZSwKPiA+ICAJ
CQlnb3RvIG91dDsKPiA+ICAJCX0KPiA+ICAJCWFyY2hfa2V4ZWNfcG9zdF9hbGxvY19wYWdlcyhw
YWdlX2FkZHJlc3MocGFnZSksIDEsIDApOwo+ID4gLQkJcHRyID0ga21hcChwYWdlKTsKPiA+ICsJ
CXB0ciA9IGttYXBfbG9jYWxfcGFnZShwYWdlKTsKPiA+ICAJCXB0ciArPSBtYWRkciAmIH5QQUdF
X01BU0s7Cj4gPiAgCQltY2h1bmsgPSBtaW5fdChzaXplX3QsIG1ieXRlcywKPiA+ICAJCQkJUEFH
RV9TSVpFIC0gKG1hZGRyICYgflBBR0VfTUFTSykpOwo+ID4gQEAgLTg5NCw3ICs4OTQsNyBAQCBz
dGF0aWMgaW50IGtpbWFnZV9sb2FkX2NyYXNoX3NlZ21lbnQoc3RydWN0IGtpbWFnZSAKKmltYWdl
LAo+ID4gIAkJZWxzZQo+ID4gIAkJCXJlc3VsdCA9IGNvcHlfZnJvbV91c2VyKHB0ciwgYnVmLCB1
Y2h1bmspOwo+ID4gIAkJa2V4ZWNfZmx1c2hfaWNhY2hlX3BhZ2UocGFnZSk7Cj4gPiAtCQlrdW5t
YXAocGFnZSk7Cj4gPiArCQlrdW5tYXBfbG9jYWwocHRyKTsKPiA+ICAJCWFyY2hfa2V4ZWNfcHJl
X2ZyZWVfcGFnZXMocGFnZV9hZGRyZXNzKHBhZ2UpLCAxKTsKPiA+ICAJCWlmIChyZXN1bHQpIHsK
PiA+ICAJCQlyZXN1bHQgPSAtRUZBVUxUOwo+ID4gLS0gCj4gPiAyLjM2LjEKPiA+IAo+ID4gCj4g
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4ga2V4
ZWMgbWFpbGluZyBsaXN0Cj4gPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4gPiAKPiAKPiAKCgoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
