Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C01C072A2
	for <kexec@archiver.kernel.org>; Fri, 17 Nov 2023 22:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r+n9QX1FrfSN5SplDjdwS5o+KvH5ZqJgaUYntsyddW4=; b=dTsoiMSrpuirx1
	sjseukTbF62bzsa6gDWLnax+AdEcpN0H36RD+JGeXRVQoThdqDGPCWqCJ4OG85A1wghfioTqGol7Z
	D9FqhAZ+8cDJ6Y0u6ZIlXHYG+DZjt6QbJG9VsH/iFctrZIGl+kEZ2H3U7pFPLS6+YmtN8/6kSBXH1
	nehIiYLfzsjujYngqGqIE5IQFLGxPVuK6bzhAZdDfjK4h6zCuFX1K9I1W8EPDigeE2Iay3OUUYYI/
	xkgoPK8oQgZGER+Q5to3N2RZkT39QB46V2Lxv77cV27usizK8DEkZnxwJ1FVoxPjQVAKyHojyMo6u
	aO29A42YlBhHII4xZQjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r47X8-007UQO-1L;
	Fri, 17 Nov 2023 22:41:54 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r47X3-007UPh-1U
	for kexec@lists.infradead.org;
	Fri, 17 Nov 2023 22:41:51 +0000
Received: from [10.137.114.52] (unknown [131.107.159.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2826D20B74C0;
	Fri, 17 Nov 2023 14:41:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2826D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700260905;
	bh=orjxgtrNLgPOQYG1EeIPZWuhMWqqoJLBesmwg7RvjbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iHpPlaOpfAkoYFJ9FqFRdX/pHVe8xCZE8w8oVWmMG88896yM9zTc8B1BuplNYqk5M
	 R6zcotzAuweQaE1G9dRdSGvhJeD85n3dHOhPPX0ExZ1ipbMtlGHLgXBt+31Tx1SNzk
	 lzn994NmMM6WScrqGcblyY3A10vKN0CLyKz6MvXY=
Message-ID: <9e60ad72-fa7a-4a2f-b980-700e98818537@linux.microsoft.com>
Date: Fri, 17 Nov 2023 14:41:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Paul Moore <paul@paul-moore.com>, Stefan Berger <stefanb@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
 Dave Young <dyoung@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org,
 serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-security-module@vger.kernel.org,
 Tyler Hicks <tyhicks@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
 <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
 <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
 <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
Content-Language: en-US
From: Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_144149_720112_C39FE115 
X-CRM114-Status: GOOD (  21.82  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8xNi8yMDIzIDI6NTYgUE0sIFBhdWwgTW9vcmUgd3JvdGU6Cj4gT24gVGh1LCBOb3Yg
MTYsIDIwMjMgYXQgNTo0MeKAr1BNIFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNv
bT4gd3JvdGU6Cj4+IE9uIDExLzE2LzIzIDE3OjA3LCBQYXVsIE1vb3JlIHdyb3RlOgo+Pj4gT24g
VHVlLCBOb3YgMTQsIDIwMjMgYXQgMTo1OOKAr1BNIFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6Cj4+Pj4gT24gMTEvMTQvMjMgMTM6MzYsIFN1c2ggU2hyaW5nYXJw
dXRhbGUgd3JvdGU6Cj4+Pj4+IE9uIDExLzEzLzIwMjMgMTA6NTkgQU0sIFN0ZWZhbiBCZXJnZXIg
d3JvdGU6Cj4+Pj4+PiBPbiAxMC8xOS8yMyAxNDo0OSwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+
Pj4+Pj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Cj4+Pj4+Pj4gfCBJbnRyb2R1Y3Rpb24gfAo+Pj4+Pj4+ID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Cj4+Pj4+Pj4gVGhpcyBkb2N1bWVudCBwcm92aWRlcyBhIGRldGFpbGVkIG92
ZXJ2aWV3IG9mIHRoZSBwcm9wb3NlZCBLZXJuZWwKPj4+Pj4+PiBmZWF0dXJlIElNQSBsb2cgc25h
cHNob3R0aW5nLiAgSXQgZGVzY3JpYmVzIHRoZSBtb3RpdmF0aW9uIGJlaGluZCB0aGUKPj4+Pj4+
PiBwcm9wb3NhbCwgdGhlIHByb2JsZW0gdG8gYmUgc29sdmVkLCBhIGRldGFpbGVkIHNvbHV0aW9u
IGRlc2lnbiB3aXRoCj4+Pj4+Pj4gZXhhbXBsZXMsIGFuZCBkZXNjcmliZXMgdGhlIGNoYW5nZXMg
dG8gYmUgbWFkZSBpbiB0aGUgY2xpZW50cy9zZXJ2aWNlcwo+Pj4+Pj4+IHdoaWNoIGFyZSBwYXJ0
IG9mIHJlbW90ZS1hdHRlc3RhdGlvbiBzeXN0ZW0uICBUaGlzIGlzIHRoZSAybmQgdmVyc2lvbgo+
Pj4+Pj4+IG9mIHRoZSBwcm9wb3NhbC4gIFRoZSBmaXJzdCB2ZXJzaW9uIGlzIHByZXNlbnQgaGVy
ZVsxXS4KPj4+Pj4+Pgo+Pj4+Pj4+IFRhYmxlIG9mIENvbnRlbnRzOgo+Pj4+Pj4+IC0tLS0tLS0t
LS0tLS0tLS0tLQo+Pj4+Pj4+IEEuIE1vdGl2YXRpb24gYW5kIEJhY2tncm91bmQKPj4+Pj4+PiBC
LiBHb2FscyBhbmQgTm9uLUdvYWxzCj4+Pj4+Pj4gICAgICAgIEIuMSBHb2Fscwo+Pj4+Pj4+ICAg
ICAgICBCLjIgTm9uLUdvYWxzCj4+Pj4+Pj4gQy4gUHJvcG9zZWQgU29sdXRpb24KPj4+Pj4+PiAg
ICAgICAgQy4xIFNvbHV0aW9uIFN1bW1hcnkKPj4+Pj4+PiAgICAgICAgQy4yIEhpZ2gtbGV2ZWwg
V29yay1mbG93Cj4+Pj4+Pj4gRC4gRGV0YWlsZWQgRGVzaWduCj4+Pj4+Pj4gICAgICAgIEQuMSBT
bmFwc2hvdCBBZ2dyZWdhdGUgRXZlbnQKPj4+Pj4+PiAgICAgICAgRC4yIFNuYXBzaG90IFRyaWdn
ZXJpbmcgTWVjaGFuaXNtCj4+Pj4+Pj4gICAgICAgIEQuMyBDaG9vc2luZyBBIFBlcnNpc3RlbnQg
U3RvcmFnZSBMb2NhdGlvbiBGb3IgU25hcHNob3RzCj4+Pj4+Pj4gICAgICAgIEQuNCBSZW1vdGUt
QXR0ZXN0YXRpb24gQ2xpZW50L1NlcnZpY2Utc2lkZSBDaGFuZ2VzCj4+Pj4+Pj4gICAgICAgICAg
ICBELjQuYSBDbGllbnQtc2lkZSBDaGFuZ2VzCj4+Pj4+Pj4gICAgICAgICAgICBELjQuYiBTZXJ2
aWNlLXNpZGUgQ2hhbmdlcwo+Pj4+Pj4+IEUuIEV4YW1wbGUgV2Fsay10aHJvdWdoCj4+Pj4+Pj4g
Ri4gT3RoZXIgRGVzaWduIENvbnNpZGVyYXRpb25zCj4+Pj4+Pj4gRy4gUmVmZXJlbmNlcwo+Pj4+
Pj4+Cj4+Pj4+PiBVc2Vyc3BhY2UgYXBwbGljYXRpb25zIHdpbGwgaGF2ZSB0byBrbm93Cj4+Pj4+
PiBhKSB3aGVyZSBhcmUgdGhlIHNoYXJkIGZpbGVzPwo+Pj4+PiBXZSBkZXNjcmliZSB0aGUgZmls
ZSBzdG9yYWdlIGxvY2F0aW9uIGNob2ljZXMgaW4gc2VjdGlvbiBELjMsIGJ1dCB1c2VyCj4+Pj4+
IGFwcGxpY2F0aW9ucyB3aWxsIGhhdmUgdG8gcXVlcnkgdGhlIHdlbGwta25vd24gbG9jYXRpb24g
ZGVzY3JpYmVkIHRoZXJlLgo+Pj4+Pj4gYikgaG93IGRvIEkgcmVhZCB0aGUgc2hhcmQgZmlsZXMg
d2hpbGUgbG9ja2luZyBvdXQgdGhlIHByb2R1Y2VyIG9mIHRoZQo+Pj4+Pj4gc2hhcmQgZmlsZXM/
Cj4+Pj4+Pgo+Pj4+Pj4gSU1PLCB0aGlzIHdpbGwgcmVxdWlyZSBhIHdlbGwga25vd24gY29uZmln
IGZpbGUgYW5kIGEgbG9ja2luZyBtZXRob2QKPj4+Pj4+IChmbG9jaykgc28gdGhhdCB1c2VyIHNw
YWNlIGFwcGxpY2F0aW9ucyBjYW4gd29yayB0b2dldGhlciBpbiB0aGlzIG5ldwo+Pj4+Pj4gZW52
aXJvbm1lbnQuIFRoZSBsb2NrIGNvdWxkIGJlIGRlZmluZWQgaW4gdGhlIGNvbmZpZyBmaWxlIG9y
IGp1c3QgYmUKPj4+Pj4+IHRoZSBjb25maWcgZmlsZSBpdHNlbGYuCj4+Pj4+IFRoZSBmbG9jayBp
cyBhIGdvb2QgaWRlYSBmb3IgY28tb3JkaW5hdGlvbiBiZXR3ZWVuIFVNIGNsaWVudHMuIFdoaWxl
Cj4+Pj4+IHRoZSBLZXJuZWwgY2Fubm90IGVuZm9yY2UgYW55IGFjY2VzcyBpbiB0aGlzIHdheSwg
YW55IFVNIHByb2Nlc3MgdGhhdAo+Pj4+PiBpcyBwbGFubmluZyBvbiB0cmlnZ2VyaW5nIHRoZSBz
bmFwc2hvdCBtZWNoYW5pc20gc2hvdWxkIGZvbGxvdyB0aGF0Cj4+Pj4+IHByb3RvY29sLiAgV2Ug
d2lsbCBlbnN1cmUgd2UgZG9jdW1lbnQgdGhhdCBhcyB0aGUgYmVzdC1wcmFjdGljZXMgaW4KPj4+
Pj4gdGhlIHBhdGNoIHNlcmllcy4KPj4+PiBJdCdzIG1vcmUgdGhhbiAnYmVzdCBwcmFjdGljZXMn
LiBZb3UgbmVlZCBhIHdlbGwta25vd24gY29uZmlnIGZpbGUgd2l0aAo+Pj4+IHdlbGwta25vd24g
Y29uZmlnIG9wdGlvbnMgaW4gaXQuCj4+Pj4KPj4+PiBBbGwgY2xpZW50cyB0aGF0IHdlcmUgcHJl
dmlvdXNseSBqdXN0IHRyeWluZyB0byByZWFkIG5ldyBieXRlcyBmcm9tIHRoZQo+Pj4+IElNQSBs
b2cgY2Fubm90IGRvIHRoaXMgYW55bW9yZSBpbiB0aGUgcHJlc2VuY2Ugb2YgYSBsb2cgc2hhcmQg
cHJvZHVjZXIKPj4+PiBidXQgaGF2ZSB0byBhbHNvIGxlYXJuIHRoYXQgYSBuZXcgbG9nIHNoYXJk
IGhhcyBiZWVuIHByb2R1Y2VkIHNvIHRoZXkKPj4+PiBuZWVkIHRvIGZpZ3VyZSBvdXQgdGhlIG5l
dyBwb3NpdGlvbiBpbiB0aGUgbG9nIHdoZXJlIHRvIHJlYWQgZnJvbS4gU28KPj4+PiBtYXliZSBh
IGNvdW50ZXIgaW4gYSBjb25maWcgZmlsZSBzaG91bGQgaW5kaWNhdGUgdG8gdGhlIGxvZyByZWFk
ZXJzIHRoYXQKPj4+PiBhIG5ldyBsb2cgaGFzIGJlZW4gcHJvZHVjZWQgLS0gb3RoZXJ3aXNlIHRo
ZXkgd291bGQgaGF2ZSB0byBtb25pdG9yIGFsbAo+Pj4+IHRoZSBsb2cgc2hhcmQgZmlsZXMgb3Ig
dGhlIGxvZyBzaGFyZCBmaWxlJ3Mgc2l6ZS4KPj4+IElmIGEgY291bnRlciBpcyBuZWVkZWQsIEkg
d291bGQgc3VnZ2VzdCBwbGFjaW5nIGl0IHNvbWV3aGVyZSBvdGhlcgo+Pj4gdGhhbiB0aGUgY29u
ZmlnIGZpbGUgc28gdGhhdCB3ZSBjYW4gZW5mb3JjZSBsaW1pdGVkIHdyaXRlIGFjY2VzcyB0bwo+
Pj4gdGhlIGNvbmZpZyBmaWxlLgo+Pj4KPj4+IFJlZ2FyZGxlc3MsIEkgaW1hZ2luZSB0aGVyZSBh
cmUgYSBmZXcgd2F5cyBvbmUgY291bGQgc3luY2hyb25pemUKPj4+IHZhcmlvdXMgdXNlcnNwYWNl
IGFwcGxpY2F0aW9ucyBzdWNoIHRoYXQgdGhleSBzZWUgYSBjb25zaXN0ZW50IHZpZXcgb2YKPj4+
IHRoZSBkZWNvbXBvc2VkIGxvZyBzdGF0ZSwgYW5kIHRoZSBnb29kIG5ld3MgaXMgdGhhdCB0aGUg
YXBwcm9hY2gKPj4+IGRlc2NyaWJlZCBoZXJlIGlzIG9wdC1pbiBmcm9tIGEgdXNlcnNwYWNlIHBl
cnNwZWN0aXZlLiAgSWYgdGhlCj4+IEEgRlVTRSBmaWxlc3lzdGVtIHRoYXQgc3RpdGNoZXMgdG9n
ZXRoZXIgdGhlIGxvZyBzaGFyZHMgZnJvbSBvbmUgb3IKPj4gbXVsdGlwbGUgZmlsZXMgKyBJTUEg
bG9nIGZpbGUocykgY291bGQgbWFrZSB0aGlzIGFwcHJvYWNoIHRyYW5zcGFyZW50Cj4+IGZvciBh
cyBsb25nIGFzIGxvZyBzaGFyZHMgYXJlIG5vdCB0aHJvd24gYXdheS4gUHJlc3VtYWJseSBpdCAo
b3Igcm9vdCkKPj4gY291bGQgYmluZC1tb3VudCBpdHMgZmlsZXMgb3ZlciB0aGUgdHdvIElNQSBs
b2cgZmlsZXMuCj4+Cj4+PiB1c2Vyc3BhY2UgZG9lcyBub3QgZnVsbHkgc3VwcG9ydCBJTUEgbG9n
IHNuYXBzaG90dGluZyB0aGVuIGl0IG5ldmVyCj4+PiBuZWVkcyB0byB0cmlnZ2VyIGl0IGFuZCB0
aGUgc3lzdGVtIGJlaGF2ZXMgYXMgaXQgZG9lcyB0b2RheTsgb24gdGhlCj4+IEkgZG9uJ3QgdGhp
bmsgaW5kaXZpZHVhbCBhcHBsaWNhdGlvbnMgc2hvdWxkIHRyaWdnZXIgaXQgLCBpbnN0ZWFkIHNv
bWUKPj4gZGVkaWNhdGVkIGJhY2tncm91bmQgcHJvY2VzcyBydW5uaW5nIG9uIGEgbWFjaGluZSB3
b3VsZCBkbyB0aGF0IGV2ZXJ5IG4KPj4gbG9nIGVudHJpZXMgb3Igc28gYW5kIHBvc3NpYmx5IG9m
ZmVyIHRoZSBGVVNFIGZpbGVzeXN0ZW0gYXQgdGhlIHNhbWUKPj4gdGltZS4gSW4gZWl0aGVyIGNh
c2UsIG9uY2UgYW55IGFwcGxpY2F0aW9uIHRyaWdnZXJzIGl0LCBhbGwgZWl0aGVyIGhhdmUKPj4g
dG8ga25vdyBob3cgdG8gZGVhbCB3aXRoIHRoZSBzaGFyZHMgb3IgRlVTRSB3b3VsZCBtYWtlIGl0
IGNvbXBsZXRlbHkKPj4gdHJhbnNwYXJlbnQuCkZVU0Ugd291bGQgYmUgYSByZWFzb25hYmxlIHVz
ZXIgc3BhY2UgY28tb3JkaW5hdGlvbiBpbXBsZW1lbnRhdGlvbi7CoCBBCnByaXZpbGVnZWQgcHJv
Y2VzcyB3b3VsZCB0cmlnZ2VyIHRoZSBzbmFwc2hvdCBnZW5lcmF0aW9uIGFuZCBwcm92aWRlIHRo
ZQptb3VudHBvaW50IHRvIHJlYWQgdGhlIGZ1bGwgSU1BIGxvZyBiYWNrZWQgYnkgc2hhcmRzIGFz
IG5lZWRlZCBieSByZWx5aW5nCnBhcnRpZXMuCgpXaGV0aGVyIGl0IGlzIGEgcHJpdmlsZWdlZCBk
YWVtb24gb3Igc29tZSBvdGhlciBhZ2VudCB0aGF0IHRyaWdnZXJzIHRoZQpzbmFwc2hvdCwgaXQg
c2hvdWxkbid0IGltcGFjdCB0aGUgS2VybmVsLXNpZGUgaW1wbGVtZW50YXRpb24uCgotIFN1c2gK
PiBZZXMsIHBlcmZvcm1pbmcgYSBzbmFwc2hvdCBpcyBhIHByaXZpbGVnZWQgb3BlcmF0aW9uIHdo
aWNoIEkgZXhwZWN0Cj4gd291bGQgYmUgZG9uZSBhbmQgbWFuYWdlZCBieSBhIGRlZGljYXRlZCBk
YWVtb24gcnVubmluZyBvbiB0aGUgc3lzdGVtLgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
