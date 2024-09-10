Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9616DEDE9A1
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-id:Cc:Date:
	In-reply-to:From:Subject:MIME-version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0uMSJ5k8OsVd10bdnJWyf0ny+gNrrmr5lZjKnL3pAGE=; b=Lj3dmlGGYPIcYu
	RyBs/6W1303ZLUOgrUMBs0FrLCFiN/d8FA4XIdUL4ZURIpzriW8NL77UJjxaIb5YtZBwA4qoTEKC6
	+DKA2HPLM8L0NGftOuyAzZJ/UmIhP6QMkrxLPNroC69fLfE9tTReVHcEyu4s+2lJYx+tfLnOxhike
	cpRhRpeZ5dZtci3qm0fzF5F6/kz8CWLnCCGqdxbD7nrbEuaHjnN3WlYb3VZpwLivKSTNK9r0et2Nv
	wzDAibcg5YFIcBqMTmSZBvVmbsHiGjq8syDFf07dMW2aBx1mQJ3Z8tdxhjETT1GPSEPJa8RRdEpWI
	YcngbPNE1ZC9xWsW9UYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so38f-00000006E3H-1HkL;
	Tue, 10 Sep 2024 15:50:45 +0000
Received: from ma-mailsvcp-mx-lapp03.apple.com ([17.32.222.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so33J-00000006CWQ-2ctq
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 15:45:16 +0000
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SJL00RFST2PN430@ma-mailsvcp-mx-lapp03.apple.com> for
 kexec@lists.infradead.org; Tue, 10 Sep 2024 08:44:54 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=kUOJZ7tUncMAJzkdVFaOCPtKthzEaNpQ7rDNkyZ+1Wc=;
 b=frhRX/RuST2AmW2DzT6mZuezJf/y9aGo3gTGB3mIdaIKjLug8HOZ2PkfQDuZ/q9a+w3R
 Zw49iuTowacbVsj8Cz1Gp6kpI25YR2FeE11z9QyHDitpje5wwvaeaCRtMopl42fLRmr6
 Ba6lC14fQVSCSuc9Dx5QmPNJXFKYcPkeqaloXlvzhiQ9I+/3OFZtHSORh5BguQMhZbeZ
 INw8/XIAJY/qdMu10ISiixB7PIsIrr186qa52PdrP1T0BeiZSWxHJfYJ9RcgLNRppRGP
 3uFTxdlI3i6opRhMVPc53jYb6BFMQ2soALt/CKymktcMqaV8A9cF7h82leD2tEj2Gl9N gA==
Received: from mr55p01nt-mmpp01.apple.com
 (mr55p01nt-mmpp01.apple.com [10.170.185.219])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SJL00RP2T2R82P0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Tue, 10 Sep 2024 08:44:52 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp01.apple.com by
 mr55p01nt-mmpp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SJL0VP00T1AQK00@mr55p01nt-mmpp01.apple.com>; Tue,
 10 Sep 2024 15:44:51 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 4c3984f1f823aa50c40fcb2a43cca4c1
X-Va-E-CD: c40cdd13cd530915072e8c6f5b81c115
X-Va-R-CD: cb226b3d113575e0c7ead9a62b61fc48
X-Va-ID: 90868364-5703-4c93-92da-456d47eec033
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 4c3984f1f823aa50c40fcb2a43cca4c1
X-V-E-CD: c40cdd13cd530915072e8c6f5b81c115
X-V-R-CD: cb226b3d113575e0c7ead9a62b61fc48
X-V-ID: 923be45a-1c50-47dd-afa8-a23aa1b228b2
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
Received: from smtpclient.apple (unknown [17.11.88.207])
 by mr55p01nt-mmpp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SJL0V0AXT2QG900@mr55p01nt-mmpp01.apple.com>; Tue,
 10 Sep 2024 15:44:51 +0000 (GMT)
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [edk2-devel] EFI table being corrupted during Kexec
From: "Andrew (EFI) Fish" <afish@apple.com>
In-reply-to: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
Date: Tue, 10 Sep 2024 08:44:40 -0700
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com, rppt@kernel.org,
 usamaarif642@gmail.com, gourry@gourry.net, rmikey@meta.com
Message-id: <BABE4F07-DF49-48C5-BAB7-B5986C035C8E@apple.com>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
To: devel@edk2.groups.io, leitao@debian.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_084513_804860_24BD436A 
X-CRM114-Status: GOOD (  22.62  )
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

Cgo+IE9uIFNlcCAxMCwgMjAyNCwgYXQgNjo1OOKAr0FNLCBCcmVubyBMZWl0YW8gPGxlaXRhb0Bk
ZWJpYW4ub3JnPiB3cm90ZToKPiAKPiAKPiBXZSd2ZSBzZWVuIGEgcHJvYmxlbSBpbiB1cHN0cmVh
bSBrZXJuZWwga2V4ZWMsIHdoZXJlIGEgRUZJIFRQTSBsb2cgZXZlbnQgdGFibGUKPiBpcyBiZWlu
ZyBvdmVyd3JpdHRlbi4gIFRoaXMgcHJvYmxlbSBoYXBwZW4gb24gcmVhbCBtYWNoaW5lLCBhcyB3
ZWxsIGFzIGluIGEKPiByZWNlbnQgRURLMiBxZW11IFZNLgo+IAo+IERpZ2dpbmcgZGVlcCwgdGhl
IHRhYmxlIGlzIGJlaW5nIG92ZXJ3cml0dGVuIGR1cmluZyBrZXhlYywgbW9yZSBwcmVjaXNlbHkg
d2hlbgo+IHJlbG9jYXRpbmcga2VybmVsIChyZWxvY2F0ZV9rZXJuZWwoKSBmdW5jdGlvbikuCj4g
Cj4gSSd2ZSBhbHNvIGZvdW5kIHRoYXQgdGhlIHRhYmxlIGlzIGJlaW5nIHByb3Blcmx5IHJlc2Vy
dmVkIHVzaW5nCj4gbWVtYmxvY2tfcmVzZXJ2ZSgpIGVhcmx5IGluIHRoZSBib290LCBhbmQgdGhh
dCByYW5nZSBnZXRzIG92ZXJ3cml0dGVuIGxhdGVyIGluCj4gYnkgcmVsb2NhdGVfa2VybmVsKCku
IEluIG90aGVyIHdvcmRzLCBrZXhlYyBpcyBvdmVyd3JpdGluZyBhIG1lbW9yeSB0aGF0IHdhcwo+
IHByZXZpb3VzbHkgcmVzZXJ2ZWQgKGFzIG1lbWJsb2NrX3Jlc2VydmUoKSkuCj4gCj4gVXNhbWEg
Zm91bmQgdGhhdCBrZXhlYyBvbmx5IGhvbm91cnMgbWVtb3J5IHJlc2VydmF0aW9ucyBmcm9tIC9z
eXMvZmlybXdhcmUvbWVtbWFwCj4gd2hpY2ggY29tZXMgZnJvbSBlODIwX3RhYmxlX2Zpcm13YXJl
IHRhYmxlLgo+IAoKVGhlIEU4MjAgdGFibGUgaXMgbm90IHBhcnQgb2YgdGhlIFVFRkkgc3RhbmRh
cmQgYW5kIGl0IGlzIHByb2R1Y2VkIGJ5IGEgbGlicmFyeSBpbiB0aGUgT3ZtZlBrZyBmb3Ig4oCc
c3BlY2lhbCBjYXNlc+KAnSBzbyBJIGd1ZXNzIHRoYXQgbGliIGNvdWxkIGhhdmUgYSBidWc/Cgo+
IExvb2tpbmcgYXQgdGhlIFRQTSBzcGVjLCBJIGZvdW5kIHRoZSBmb2xsb3dpbmcgcGFydDoKPiAK
PiAJSWYgdGhlIEFDUEkgVFBNMiB0YWJsZSBjb250YWlucyB0aGUgYWRkcmVzcyBhbmQgc2l6ZSBv
ZiB0aGUgUGxhdGZvcm0gRmlybXdhcmUgVENHIGxvZywKPiAJZmlybXdhcmUg4oCccGluc+KAnSB0
aGUgbWVtb3J5IGFzc29jaWF0ZWQgd2l0aCB0aGUgUGxhdGZvcm0gRmlybXdhcmUgVENHIGxvZywg
YW5kIHJlcG9ydHMKPiAJdGhpcyBtZW1vcnkgYXMg4oCcUmVzZXJ2ZWTigJ0gbWVtb3J5IHZpYSB0
aGUgSU5UIDE1aC9FODIwIGludGVyZmFjZS4KPiAKCklOVCAxNWggaXMgTGVnYWN5IEJJT1Mgbm90
IFVFRkkuIEZvciBVRUZJIHRoZXJlIGlzIGp1c3QgdGhlIFVFRkkgbWVtb3J5IG1hcCBhbmQgQUNQ
SS4gCgpUaGFua3MsCgpBbmRyZXcgRmlzaAoKCj4gCj4gRnJvbTogaHR0cHM6Ly90cnVzdGVkY29t
cHV0aW5nZ3JvdXAub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9QQy1DbGllbnRQbGF0Zm9ybV9Qcm9m
aWxlX2Zvcl9UUE1fMnAwX1N5c3RlbXNfdjQ5XzE2MTExNF9wdWJsaWMtcmV2aWV3LnBkZgo+IAo+
IEkgYW0gd29uZGVyaW5nIGlmIHRoYXQgbWVtb3J5IHJlZ2lvbi9yYW5nZSBzaG91bGQgYmUgcGFy
dCBvZiBlODIwIHRhYmxlIHRoYXQgaXMKPiBwYXNzZWQgYnkgRUZJIGZpcm13YXJlIHRvIGtlcm5l
bCwgYW5kIGlmIGl0IGlzIG5vdCBwYXNzZWQgKGFzIGl0IGlzIG5vdCBiZWluZwo+IHBhc3NlZCB0
b2RheSksIHRoZW4gdGhlIGtlcm5lbCBkb2Vzbid0IG5lZWQgdG8gcmVzcGVjdCBpdCwgYW5kIGl0
IGlzIGZyZWUgdG8KPiBvdmVyd3JpdGUgKGFzIGl0IGRvZXMgdG9kYXkpLiBJbiBvdGhlciB3b3Jk
cywgdGhpcyBpcyBhIGZpcm13YXJlIGJ1ZyBhbmQgbm90IGEKPiBrZXJuZWwgYnVnLgo+IAo+IEFt
IEkgbWlzc2luZyBzb21ldGhpbmc/Cj4gCj4gVGhhbmtzCj4gLS1icmVubwo+IAo+IAo+IC09LT0t
PS09LT0tPS09LT0tPS09LT0tCj4gR3JvdXBzLmlvIExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVz
c2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLgo+IFZpZXcvUmVwbHkgT25saW5lICgjMTIwNTQxKTog
aHR0cHM6Ly9lZGsyLmdyb3Vwcy5pby9nL2RldmVsL21lc3NhZ2UvMTIwNTQxCj4gTXV0ZSBUaGlz
IFRvcGljOiBodHRwczovL2dyb3Vwcy5pby9tdC8xMDgzNzY2NzEvMTc1NTA4NAo+IEdyb3VwIE93
bmVyOiBkZXZlbCtvd25lckBlZGsyLmdyb3Vwcy5pbwo+IFVuc3Vic2NyaWJlOiBodHRwczovL2Vk
azIuZ3JvdXBzLmlvL2cvZGV2ZWwvdW5zdWIgW2FmaXNoQGFwcGxlLmNvbV0KPiAtPS09LT0tPS09
LT0tPS09LT0tPS09LQo+IAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
