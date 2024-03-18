Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96ADC54E5D
	for <kexec@archiver.kernel.org>; Mon, 18 Mar 2024 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A0OILE4pygi5h7EWF/VsyqGfak9oTiWd1TFb5TWOw38=; b=yVCuNYK2mkoaY+
	izR228aYErUC2OagpSwXCO8W8sk76DGX3IRIyvG9/vMRgw/QS3MFjsrhd8d+Yl5UfoBA+q75dEw2n
	IB8LcgXhG/jVPqAu+U62ekcR0wHqIX0fDfkV4Oezkh2J+Y/XBIlWGt5EABYIOOktykauDw5ww5iq5
	XlL9wmEt2ZTlenBkFz6Mi1sZlMKIvulpRtMDCzLMXXNHGY/IFIYHQjh0EkTxvuCljqAgUo27aTUdy
	VhLLWh8kALcCHE9UnfEwVZ6MuioA8hLdd0KoR96pvq64g4001SpZs6T2ghUsgpOIHc9yFfxM2mUy2
	Afo4bGE3dyLIXMwhLChQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm8K7-00000007kQN-0WOI;
	Mon, 18 Mar 2024 08:26:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm8K3-00000007kOf-2tOD
	for kexec@lists.infradead.org;
	Mon, 18 Mar 2024 08:26:21 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I7nEk7021855;
	Mon, 18 Mar 2024 08:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mn3gFT3MEhnjtpRUGFom/nt9fAWIwih/Ucoy9kUtXN4=;
 b=nvEC+iGq0i6bOLAnO9AhUKxuv7Npk113SAm2RBRLGomlaJ3R0F0I7EYEkL92+boy+VOb
 90evej1rf00f43NTYJsFt3QE9LxW90FKkImXHTQuorh98v3040MTB6ZfjKwHJBPDqZvX
 l/fJTsV0ieH8N8bqHBEDgersm3JyABbNsyya1aTla0PGj2efScvAbEITZXlfWP7EhfV/
 k2tMhdTaq11gUtPnM2b0fben9Nwzdr/LTlzrtE1G37oLpmN6OCHky9S06zf3U8LEXfdC
 bn4/AwITDgzCyLd6FRfxAJLAUh80j+MKNrZQYLfrvDvQgW2OCnpwoJzkkIoeBV7+MTDl cg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ww9s07b6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 08:26:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42I5SeJf015801;
	Mon, 18 Mar 2024 08:26:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp4yqs92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 08:26:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42I8Q9dt46858662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 08:26:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A422920063;
	Mon, 18 Mar 2024 08:26:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829432004E;
	Mon, 18 Mar 2024 08:26:08 +0000 (GMT)
Received: from [9.171.31.164] (unknown [9.171.31.164])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 08:26:08 +0000 (GMT)
Message-ID: <87254a9a-1c39-454c-b93f-f22d7f2aa8a8@linux.ibm.com>
Date: Mon, 18 Mar 2024 13:56:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] makedumpfile: ppc64: get vmalloc start address from
 vmcoreinfo
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
To: kexec@lists.infradead.org,
        =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IA==?=
 =?UTF-8?B?5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Sachin Sant <sachinp@linux.ibm.com>
References: <20240223190342.251365-1-adityag@linux.ibm.com>
In-Reply-To: <20240223190342.251365-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CAV_8an2BTzQ3LmKYqCs0K74j0oo3XJy
X-Proofpoint-GUID: CAV_8an2BTzQ3LmKYqCs0K74j0oo3XJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_012620_443261_B1EB0173 
X-CRM114-Status: GOOD (  32.46  )
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

SGksClRoZSBjb21taXQgcmVtb3ZpbmcgJ3ZtYXBfYXJlYV9saXN0JyBpcyBub3cgbWVyZ2VkIGlu
IExpbnV4IG1haW5saW5lIHRyZWUuCiDCoMKgwqAgY29tbWl0OiDCoMKgwqAgNTVjNDlmZWU1N2Fm
OTlmM2M2NjNlNjlkZWRjNWI4NWU2OTFiYmU1MAogwqDCoMKgIG1tL3ZtYWxsb2M6IHJlbW92ZSB2
bWFwX2FyZWFfbGlzdAoKQW55IGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2ggPwoKVGhhbmtzLAoKQWRp
dHlhIEd1cHRhCgpPbiAyNC8wMi8yNCAwMDozMywgQWRpdHlhIEd1cHRhIHdyb3RlOgo+IEJlbG93
IGVycm9yIHdhcyBub3RpY2VkIHdoZW4gcnVubmluZyBtYWtlZHVtcGZpbGUgb24gbGludXgtbmV4
dCBrZXJuZWwKPiBjcmFzaCAobGludXgtbmV4dCB0YWcgbmV4dC0yMDI0MDEyMSk6Cj4KPiAgICAg
IC4uLgo+ICAgICAgQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyA6IFsxMDAuMCAlXSB8IHJlYWRw
YWdlX2VsZjogQXR0ZW1wdCB0byByZWFkIG5vbi1leGlzdGVudCBwYWdlIGF0IDB4YzAwMDAwMDAw
MDAwMC4KPiAgICAgIFsgMTcuNTUxNzE4XSBrZHVtcC5zaFs0MDRdOiByZWFkbWVtOiB0eXBlX2Fk
ZHI6IDAsIGFkZHI6YzAwYzAwMDAwMDAwMDAwMCwgc2l6ZToxNjM4NAo+ICAgICAgWyAxNy41NTE3
OTNdIGtkdW1wLnNoWzQwNF06IF9fZXhjbHVkZV91bm5lY2Vzc2FyeV9wYWdlczogQ2FuJ3QgcmVh
ZCB0aGUgYnVmZmVyIG9mIHN0cnVjdCBwYWdlLgo+ICAgICAgWyAxNy41NTE4NjRdIGtkdW1wLnNo
WzQwNF06IGNyZWF0ZV8ybmRfYml0bWFwOiBDYW4ndCBleGNsdWRlIHVubmVjZXNzYXJ5IHBhZ2Vz
Lgo+ICAgICAgWyAxNy41NjI2MzJdIGtkdW1wLnNoWzQwNF06IFRoZSBrZXJuZWwgdmVyc2lvbiBp
cyBub3Qgc3VwcG9ydGVkLgo+ICAgICAgWyAxNy41NjI3MDhdIGtkdW1wLnNoWzQwNF06IFRoZSBt
YWtlZHVtcGZpbGUgb3BlcmF0aW9uIG1heSBiZSBpbmNvbXBsZXRlLgo+ICAgICAgWyAxNy41NjI3
NzNdIGtkdW1wLnNoWzQwNF06IG1ha2VkdW1wZmlsZSBGYWlsZWQuCj4gICAgICBbIDE3LjU2NDMz
NV0ga2R1bXBbNDA2XTogc2F2aW5nIHZtY29yZSBmYWlsZWQsIF9leGl0Y29kZToxCj4KPiBBYm92
ZSBlcnJvciB3YXMgZHVlIHRvICd2bWFwX2FyZWFfbGlzdCcgYW5kICd2bWxpc3QnIHN5bWJvbHMg
bWlzc2luZwo+IGZyb20gdGhlIHZtY29yZS4KPgo+ICd2bWFwX2FyZWFfbGlzdCcgd2FzIHJlbW92
ZWQgaW4gdGhlIGxpbnV4IGtlcm5lbCB3aXRoIGJlbG93IGNvbW1pdDoKPgo+ICAgICAgY29tbWl0
IDM3OGViMjRhMDY1OGRkOTIyYjI5NTI0ZTBjZTM1YzZjNDNmNTZjYmEKPiAgICAgICAgICAgbW0v
dm1hbGxvYzogcmVtb3ZlIHZtYXBfYXJlYV9saXN0Cj4KPiBTdWJzZXF1ZW50bHkgdGhlIGNvbW1p
dCBhbHNvIGludHJvZHVjZWQgJ1ZNQUxMT0NfU1RBUlQnIGluIHZtY29yZWluZm8gdG8KPiBnZXQg
YmFzZSBhZGRyZXNzIG9mIHZtYWxsb2MgYXJlYSwgaW5zdGVhZCBvZiBkZXBlbmRpbmcgb24gJ3Zt
YXBfYXJlYV9saXN0Jwo+Cj4gSGVuY2UgaWYgJ1ZNQUxMT0NfU1RBUlQnIHN5bWJvbCBpcyB0aGVy
ZSBpbiB2bWNvcmVpbmZvOgo+ICAgIDEuIFNldCB2bWFsbG9jX3N0YXJ0IGJhc2VkIG9uICdWTUFM
TE9DX1NUQVJUJwo+ICAgIDIuIERvbid0IGVycm9yIGlmIHZtYXBfYXJlYV9saXN0L3ZtbGlzdCBh
cmUgbm90IGRlZmluZWQKPgo+IFJlcG9ydGVkLWJ5OiBTYWNoaW4gU2FudCA8c2FjaGlucEBsaW51
eC5pYm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBHdXB0YSA8YWRpdHlhZ0BsaW51eC5p
Ym0uY29tPgo+IC0tLQo+ICAgYXJjaC9wcGM2NC5jICAgfCAxOSArKysrKysrKysrKysrLS0tLS0t
Cj4gICBtYWtlZHVtcGZpbGUuYyB8ICAzICsrLQo+ICAgbWFrZWR1bXBmaWxlLmggfCAgNiArKyst
LS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wcGM2NC5jIGIvYXJjaC9wcGM2NC5jCj4gaW5kZXggOTZj
MzU3Y2IwMzM1Li5iYjYyZTJjZDE5OWEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wcGM2NC5jCj4gKysr
IGIvYXJjaC9wcGM2NC5jCj4gQEAgLTU2OCw3ICs1NjgsOSBAQCBnZXRfbWFjaGRlcF9pbmZvX3Bw
YzY0KHZvaWQpCj4gICAJLyoKPiAgIAkgKiBHZXQgdm1hbGxvY19zdGFydCB2YWx1ZSBmcm9tIGVp
dGhlciB2bWFwX2FyZWFfbGlzdCBvciB2bWxpc3QuCj4gICAJICovCj4gLQlpZiAoKFNZTUJPTCh2
bWFwX2FyZWFfbGlzdCkgIT0gTk9UX0ZPVU5EX1NZTUJPTCkKPiArCWlmIChOVU1CRVIodm1hbGxv
Y19zdGFydCkgIT0gTk9UX0ZPVU5EX1NZTUJPTCkgewo+ICsJCXZtYWxsb2Nfc3RhcnQgPSBOVU1C
RVIodm1hbGxvY19zdGFydCk7Cj4gKwl9IGVsc2UgaWYgKChTWU1CT0wodm1hcF9hcmVhX2xpc3Qp
ICE9IE5PVF9GT1VORF9TWU1CT0wpCj4gICAJICAgICYmIChPRkZTRVQodm1hcF9hcmVhLnZhX3N0
YXJ0KSAhPSBOT1RfRk9VTkRfU1RSVUNUVVJFKQo+ICAgCSAgICAmJiAoT0ZGU0VUKHZtYXBfYXJl
YS5saXN0KSAhPSBOT1RfRk9VTkRfU1RSVUNUVVJFKSkgewo+ICAgCQlpZiAoIXJlYWRtZW0oVkFE
RFIsIFNZTUJPTCh2bWFwX2FyZWFfbGlzdCkgKyBPRkZTRVQobGlzdF9oZWFkLm5leHQpLAo+IEBA
IC02ODQsMTEgKzY4NiwxNiBAQCB2YWRkcl90b19wYWRkcl9wcGM2NCh1bnNpZ25lZCBsb25nIHZh
ZGRyKQo+ICAgCWlmICgoU1lNQk9MKHZtYXBfYXJlYV9saXN0KSA9PSBOT1RfRk9VTkRfU1lNQk9M
KQo+ICAgCSAgICB8fCAoT0ZGU0VUKHZtYXBfYXJlYS52YV9zdGFydCkgPT0gTk9UX0ZPVU5EX1NU
UlVDVFVSRSkKPiAgIAkgICAgfHwgKE9GRlNFVCh2bWFwX2FyZWEubGlzdCkgPT0gTk9UX0ZPVU5E
X1NUUlVDVFVSRSkpIHsKPiAtCQlpZiAoKFNZTUJPTCh2bWxpc3QpID09IE5PVF9GT1VORF9TWU1C
T0wpCj4gLQkJICAgIHx8IChPRkZTRVQodm1fc3RydWN0LmFkZHIpID09IE5PVF9GT1VORF9TVFJV
Q1RVUkUpKSB7Cj4gLQkJCUVSUk1TRygiQ2FuJ3QgZ2V0IGluZm8gZm9yIHZtYWxsb2MgdHJhbnNs
YXRpb24uXG4iKTsKPiAtCQkJcmV0dXJuIE5PVF9QQUREUjsKPiAtCQl9Cj4gKwkJLyoKPiArCQkg
KiBEb24ndCBkZXBlbmQgb24gdm1hcF9hcmVhX2xpc3Qvdm1saXN0IGlmIHZtYWxsb2Nfc3RhcnQg
aXMgc2V0IGluCj4gKwkJICogdm1jb3JlaW5mbywgaW4gdGhhdCBjYXNlIHByb2NlZWQgd2l0aG91
dCBlcnJvcgo+ICsJCSAqLwo+ICsJCWlmIChOVU1CRVIodm1hbGxvY19zdGFydCkgPT0gTk9UX0ZP
VU5EX05VTUJFUikKPiArCQkJaWYgKChTWU1CT0wodm1saXN0KSA9PSBOT1RfRk9VTkRfU1lNQk9M
KQo+ICsJCQkJfHwgKE9GRlNFVCh2bV9zdHJ1Y3QuYWRkcikgPT0gTk9UX0ZPVU5EX1NUUlVDVFVS
RSkpIHsKPiArCQkJCUVSUk1TRygiQ2FuJ3QgZ2V0IGluZm8gZm9yIHZtYWxsb2MgdHJhbnNsYXRp
b24uXG4iKTsKPiArCQkJCXJldHVybiBOT1RfUEFERFI7Cj4gKwkJCX0KPiAgIAl9Cj4gICAKPiAg
IAlyZXR1cm4gcHBjNjRfdnRvcF9sZXZlbDQodmFkZHIpOwo+IGRpZmYgLS1naXQgYS9tYWtlZHVt
cGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jCj4gaW5kZXggYjAwNGI5M2ZlY2I3Li5iNmM2M2ZhZDE1
ZjMgMTAwNjQ0Cj4gLS0tIGEvbWFrZWR1bXBmaWxlLmMKPiArKysgYi9tYWtlZHVtcGZpbGUuYwo+
IEBAIC0yOTc4LDYgKzI5NzgsOCBAQCByZWFkX3ZtY29yZWluZm8odm9pZCkKPiAgIAlSRUFEX05V
TUJFUigiUEFHRV9PRkZMSU5FX01BUENPVU5UX1ZBTFVFIiwgUEFHRV9PRkZMSU5FX01BUENPVU5U
X1ZBTFVFKTsKPiAgIAlSRUFEX05VTUJFUigicGh5c19iYXNlIiwgcGh5c19iYXNlKTsKPiAgIAlS
RUFEX05VTUJFUigiS0VSTkVMX0lNQUdFX1NJWkUiLCBLRVJORUxfSU1BR0VfU0laRSk7Cj4gKwo+
ICsJUkVBRF9OVU1CRVJfVU5TSUdORUQoIlZNQUxMT0NfU1RBUlQiLCB2bWFsbG9jX3N0YXJ0KTsK
PiAgICNpZmRlZiBfX2FhcmNoNjRfXwo+ICAgCVJFQURfTlVNQkVSKCJWQV9CSVRTIiwgVkFfQklU
Uyk7Cj4gICAJUkVBRF9OVU1CRVIoIlRDUl9FTDFfVDFTWiIsIFRDUl9FTDFfVDFTWik7Cj4gQEAg
LTI5ODksNyArMjk5MSw2IEBAIHJlYWRfdm1jb3JlaW5mbyh2b2lkKQo+ICAgCVJFQURfTlVNQkVS
KCJWQV9CSVRTIiwgdmFfYml0cyk7Cj4gICAJUkVBRF9OVU1CRVJfVU5TSUdORUQoInBoeXNfcmFt
X2Jhc2UiLCBwaHlzX3JhbV9iYXNlKTsKPiAgIAlSRUFEX05VTUJFUl9VTlNJR05FRCgiUEFHRV9P
RkZTRVQiLCBwYWdlX29mZnNldCk7Cj4gLQlSRUFEX05VTUJFUl9VTlNJR05FRCgiVk1BTExPQ19T
VEFSVCIsIHZtYWxsb2Nfc3RhcnQpOwo+ICAgCVJFQURfTlVNQkVSX1VOU0lHTkVEKCJWTUFMTE9D
X0VORCIsIHZtYWxsb2NfZW5kKTsKPiAgIAlSRUFEX05VTUJFUl9VTlNJR05FRCgiVk1FTU1BUF9T
VEFSVCIsIHZtZW1tYXBfc3RhcnQpOwo+ICAgCVJFQURfTlVNQkVSX1VOU0lHTkVEKCJWTUVNTUFQ
X0VORCIsIHZtZW1tYXBfZW5kKTsKPiBkaWZmIC0tZ2l0IGEvbWFrZWR1bXBmaWxlLmggYi9tYWtl
ZHVtcGZpbGUuaAo+IGluZGV4IDU5YzgzZTFkOWRmMy4uNDAyMWM1YWYyYTM0IDEwMDY0NAo+IC0t
LSBhL21ha2VkdW1wZmlsZS5oCj4gKysrIGIvbWFrZWR1bXBmaWxlLmgKPiBAQCAtNTQxLDggKzU0
MSw2IEBAIGRvIHsgXAo+ICAgICogVGhlIHZhbHVlIG9mIGRlcGVuZGVuY2Ugb24gbWFjaGluZQo+
ICAgICovCj4gICAjZGVmaW5lIFBBR0VfT0ZGU0VUCQkoaW5mby0+cGFnZV9vZmZzZXQpCj4gLSNk
ZWZpbmUgVk1BTExPQ19TVEFSVAkJKGluZm8tPnZtYWxsb2Nfc3RhcnQpCj4gLSNkZWZpbmUgVk1B
TExPQ19FTkQJCShpbmZvLT52bWFsbG9jX2VuZCkKPiAgICNkZWZpbmUgVk1FTU1BUF9TVEFSVAkJ
KGluZm8tPnZtZW1tYXBfc3RhcnQpCj4gICAjZGVmaW5lIFZNRU1NQVBfRU5ECQkoaW5mby0+dm1l
bW1hcF9lbmQpCj4gICAjZGVmaW5lIFBNQVNLCQkJKDB4N2ZmZmZmZmZmZmZmZjAwMFVMKQo+IEBA
IC0yMjYyLDYgKzIyNjAsOSBAQCBzdHJ1Y3QgbnVtYmVyX3RhYmxlIHsKPiAgIAlsb25nICAgIEhV
R0VUTEJfUEFHRV9EVE9SOwo+ICAgCWxvbmcJcGh5c19iYXNlOwo+ICAgCWxvbmcJS0VSTkVMX0lN
QUdFX1NJWkU7Cj4gKwo+ICsJdW5zaWduZWQgbG9uZyB2bWFsbG9jX3N0YXJ0Owo+ICsKPiAgICNp
ZmRlZiBfX2FhcmNoNjRfXwo+ICAgCWxvbmcgCVZBX0JJVFM7Cj4gICAJbG9uZwlUQ1JfRUwxX1Qx
U1o7Cj4gQEAgLTIyNzIsNyArMjI3Myw2IEBAIHN0cnVjdCBudW1iZXJfdGFibGUgewo+ICAgCWxv
bmcgdmFfYml0czsKPiAgIAl1bnNpZ25lZCBsb25nIHBoeXNfcmFtX2Jhc2U7Cj4gICAJdW5zaWdu
ZWQgbG9uZyBwYWdlX29mZnNldDsKPiAtCXVuc2lnbmVkIGxvbmcgdm1hbGxvY19zdGFydDsKPiAg
IAl1bnNpZ25lZCBsb25nIHZtYWxsb2NfZW5kOwo+ICAgCXVuc2lnbmVkIGxvbmcgdm1lbW1hcF9z
dGFydDsKPiAgIAl1bnNpZ25lZCBsb25nIHZtZW1tYXBfZW5kOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
