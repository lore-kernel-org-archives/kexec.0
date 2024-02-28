Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E84CC54E41
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 09:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jOJrHuADWKLrzkFDHdtAAIVu3wg6cvjzU0aj7YqJH00=; b=W+36K/k89x71B7
	ZRtotDf3vMFaXvLQJk87C1k7u9q4qe2L74J4okFPtwyy4qQzdr5hKdHS7p0dGRGgTXoqxh0kNcFLe
	Cy2c1cKGfTLLiuKQ4r2AjaWR+9hPfZpiMHN8txbnbQuGuY6MDNubOrmEqMEulAP98FEC7MYHiGUMI
	iWdlCpKqCC6w5genAOiyxJxehE/mY328O8OQLIE/xOlauLTMZ5GdvbT33MKCxHbJSk2lCnVIB0/XW
	mR0dH9hYIT4D+0GG3wzv+3fxaV7yv3ehT2O/RicvpPAWtPkoeWgiKK9K3QLmAhPVWEzjRlwXbvuJJ
	NbPnJ2fL9Blo7Mci+qGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfGMc-00000008hpB-3y8T;
	Wed, 28 Feb 2024 09:36:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfGMU-00000008hn7-2ioU
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 09:36:29 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S9WxoN004792;
	Wed, 28 Feb 2024 09:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=6IkTJwP0Km2VnsmkMf/7SXDt0XM9bFnQhCRxHQRLqGQ=;
 b=lDcpRthI/St1hM4Ppj/fSQz34H8AxFgXGm6+lQ3hviFE0UPuO0rKyUeiBzSnw0mA8bIX
 V2T+QWuyJh4eP1zvywlwAiCAZ5vg13XkvVGHSFsQOMlUiYzqmAoG+eAfpsQ+WMpCCBb0
 FuF5ft7sLAgGytHjgmsM2PfnFdCvxgv7ich/I3w2DqvPeCI5vJ7OK+UzEl9HmQ22J90e
 tcaTQa90kcFX6IlNNpTqKNmydruLRZrAah7ZmL7MGANIPR1vApf44R90tCzgm1K2qfPk
 0aBj7irLnG35zpwkktD0zela5Lg01Q89LgFU6WVZ737MYmiVaXmBbZbaBE9kVU5xzZS6 Sw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj29sr3rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:36:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41S99ngk008164;
	Wed, 28 Feb 2024 09:36:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9md9p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:36:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41S9aGvP9306742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 09:36:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E21DE20043;
	Wed, 28 Feb 2024 09:36:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 134AA20040;
	Wed, 28 Feb 2024 09:36:15 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Feb 2024 09:36:14 +0000 (GMT)
Date: Wed, 28 Feb 2024 15:06:12 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: get vmalloc start address from
 vmcoreinfo
Message-ID: <kjitig4jcelchtqria3mmr2jd3h5uptpoeyesif6crnzdtel72@jlit5ntwzdig>
References: <20240223190342.251365-1-adityag@linux.ibm.com>
 <95aef871-94d1-4976-b6bc-c21d7468cdf7@nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95aef871-94d1-4976-b6bc-c21d7468cdf7@nec.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ELXwfkTjLcvso-sJVoHRDL-w-H72Vk5f
X-Proofpoint-ORIG-GUID: ELXwfkTjLcvso-sJVoHRDL-w-H72Vk5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_013627_933185_40094A4B 
X-CRM114-Status: GOOD (  40.94  )
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

SGkgS2F6dSwKCk9uIFdlZCwgRmViIDI4LCAyMDI0IGF0IDA0OjUxOjI4QU0gKzAwMDAsIEhBR0lP
IEtBWlVISVRPKOiQqeWwviDkuIDku4EpIHdyb3RlOgo+IEhpIEFkaXR5YSwKPiAKPiB0aGFua3Mg
Zm9yIHRoZSBwYXRjaC4KPiAKPiBPbiAyMDI0LzAyLzI0IDQ6MDMsIEFkaXR5YSBHdXB0YSB3cm90
ZToKPiA+IEJlbG93IGVycm9yIHdhcyBub3RpY2VkIHdoZW4gcnVubmluZyBtYWtlZHVtcGZpbGUg
b24gbGludXgtbmV4dCBrZXJuZWwKPiA+IGNyYXNoIChsaW51eC1uZXh0IHRhZyBuZXh0LTIwMjQw
MTIxKToKPiA+IAo+ID4gICAgICAuLi4KPiA+ICAgICAgQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xl
cyA6IFsxMDAuMCAlXSB8IHJlYWRwYWdlX2VsZjogQXR0ZW1wdCB0byByZWFkIG5vbi1leGlzdGVu
dCBwYWdlIGF0IDB4YzAwMDAwMDAwMDAwMC4KPiA+ICAgICAgWyAxNy41NTE3MThdIGtkdW1wLnNo
WzQwNF06IHJlYWRtZW06IHR5cGVfYWRkcjogMCwgYWRkcjpjMDBjMDAwMDAwMDAwMDAwLCBzaXpl
OjE2Mzg0Cj4gPiAgICAgIFsgMTcuNTUxNzkzXSBrZHVtcC5zaFs0MDRdOiBfX2V4Y2x1ZGVfdW5u
ZWNlc3NhcnlfcGFnZXM6IENhbid0IHJlYWQgdGhlIGJ1ZmZlciBvZiBzdHJ1Y3QgcGFnZS4KPiA+
ICAgICAgWyAxNy41NTE4NjRdIGtkdW1wLnNoWzQwNF06IGNyZWF0ZV8ybmRfYml0bWFwOiBDYW4n
dCBleGNsdWRlIHVubmVjZXNzYXJ5IHBhZ2VzLgo+ID4gICAgICBbIDE3LjU2MjYzMl0ga2R1bXAu
c2hbNDA0XTogVGhlIGtlcm5lbCB2ZXJzaW9uIGlzIG5vdCBzdXBwb3J0ZWQuCj4gPiAgICAgIFsg
MTcuNTYyNzA4XSBrZHVtcC5zaFs0MDRdOiBUaGUgbWFrZWR1bXBmaWxlIG9wZXJhdGlvbiBtYXkg
YmUgaW5jb21wbGV0ZS4KPiA+ICAgICAgWyAxNy41NjI3NzNdIGtkdW1wLnNoWzQwNF06IG1ha2Vk
dW1wZmlsZSBGYWlsZWQuCj4gPiAgICAgIFsgMTcuNTY0MzM1XSBrZHVtcFs0MDZdOiBzYXZpbmcg
dm1jb3JlIGZhaWxlZCwgX2V4aXRjb2RlOjEKPiA+IAo+ID4gQWJvdmUgZXJyb3Igd2FzIGR1ZSB0
byAndm1hcF9hcmVhX2xpc3QnIGFuZCAndm1saXN0JyBzeW1ib2xzIG1pc3NpbmcKPiA+IGZyb20g
dGhlIHZtY29yZS4KPiA+IAo+ID4gJ3ZtYXBfYXJlYV9saXN0JyB3YXMgcmVtb3ZlZCBpbiB0aGUg
bGludXgga2VybmVsIHdpdGggYmVsb3cgY29tbWl0Ogo+ID4gCj4gPiAgICAgIGNvbW1pdCAzNzhl
YjI0YTA2NThkZDkyMmIyOTUyNGUwY2UzNWM2YzQzZjU2Y2JhCj4gPiAgICAgICAgICAgbW0vdm1h
bGxvYzogcmVtb3ZlIHZtYXBfYXJlYV9saXN0Cj4gPiAKPiA+IFN1YnNlcXVlbnRseSB0aGUgY29t
bWl0IGFsc28gaW50cm9kdWNlZCAnVk1BTExPQ19TVEFSVCcgaW4gdm1jb3JlaW5mbyB0bwo+ID4g
Z2V0IGJhc2UgYWRkcmVzcyBvZiB2bWFsbG9jIGFyZWEsIGluc3RlYWQgb2YgZGVwZW5kaW5nIG9u
ICd2bWFwX2FyZWFfbGlzdCcKPiA+IAo+ID4gSGVuY2UgaWYgJ1ZNQUxMT0NfU1RBUlQnIHN5bWJv
bCBpcyB0aGVyZSBpbiB2bWNvcmVpbmZvOgo+ID4gICAgMS4gU2V0IHZtYWxsb2Nfc3RhcnQgYmFz
ZWQgb24gJ1ZNQUxMT0NfU1RBUlQnCj4gPiAgICAyLiBEb24ndCBlcnJvciBpZiB2bWFwX2FyZWFf
bGlzdC92bWxpc3QgYXJlIG5vdCBkZWZpbmVkCj4gPiAKPiA+IFJlcG9ydGVkLWJ5OiBTYWNoaW4g
U2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEd1
cHRhIDxhZGl0eWFnQGxpbnV4LmlibS5jb20+Cj4gPiAtLS0KPiA+ICAgYXJjaC9wcGM2NC5jICAg
fCAxOSArKysrKysrKysrKysrLS0tLS0tCj4gPiAgIG1ha2VkdW1wZmlsZS5jIHwgIDMgKystCj4g
PiAgIG1ha2VkdW1wZmlsZS5oIHwgIDYgKysrLS0tCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTgg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNo
L3BwYzY0LmMgYi9hcmNoL3BwYzY0LmMKPiA+IGluZGV4IDk2YzM1N2NiMDMzNS4uYmI2MmUyY2Qx
OTlhIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9wcGM2NC5jCj4gPiArKysgYi9hcmNoL3BwYzY0LmMK
PiA+IEBAIC01NjgsNyArNTY4LDkgQEAgZ2V0X21hY2hkZXBfaW5mb19wcGM2NCh2b2lkKQo+ID4g
ICAJLyoKPiA+ICAgCSAqIEdldCB2bWFsbG9jX3N0YXJ0IHZhbHVlIGZyb20gZWl0aGVyIHZtYXBf
YXJlYV9saXN0IG9yIHZtbGlzdC4KPiA+ICAgCSAqLwo+ID4gLQlpZiAoKFNZTUJPTCh2bWFwX2Fy
ZWFfbGlzdCkgIT0gTk9UX0ZPVU5EX1NZTUJPTCkKPiA+ICsJaWYgKE5VTUJFUih2bWFsbG9jX3N0
YXJ0KSAhPSBOT1RfRk9VTkRfU1lNQk9MKSB7Cj4gCj4gSSB3aWxsIGZpeCB0aGlzIE5PVF9GT1VO
RF9TWU1CT0wgdG8gTk9UX0ZPVU5EX05VTUJFUiB3aGVuIGFwcGx5aW5nLCAKPiBvdGhlcndpc2Ug
bWFrZWR1bXBmaWxlIHdpbGwgZmFpbCBmb3IgYSBkdW1wZmlsZSB3aXRob3V0IHRoZSAKPiBjb3Jy
ZXNwb25kaW5nIGtlcm5lbCBwYXRjaCwgY29ycmVjdD8KPiAKPiBUaGUgcGF0Y2ggbG9va3MgZ29v
ZCB0byBtZSBleGNlcHQgZm9yIGl0LiAgSSB3aWxsIGFwcGx5IHRoaXMgd2l0aCB0aGUgCj4ga2Vy
bmVsIHZlcnNpb24gaW4gdGhlIGNvbW1pdCBsb2cgYWZ0ZXIgdGhlIGtlcm5lbCBwYXRjaCBnZXRz
IG1lcmdlZC4KClN1cmUsIHRoYW5rcyBLYXp1LiBJIGp1c3QgcmFuIGl0IG9uIGFuIG9sZGVyIHZl
cnNpb24sIGl0IHN1Y2NlZWRzCmNvbGxlY3RpbmcgZHVtcCBvbiA2LjUuMCBrZXJuZWwgc29tZWhv
dywgdGhvdWdoIEkgYWdyZWUgd2l0aCB5b3VyCnN1Z2dlc3Rpb24sIGl0IHNob3VsZCBoYXZlIGJl
ZW4gTk9UX0ZPVU5EX05VTUJFUi4gSSB3aWxsIGJlIG1vcmUgY2FyZWZ1bAphYm91dCB0aGVzZSB0
aGluZ3MgbGF0ZXIuCgpUaGFua3MsCkFkaXR5YSBHdXB0YQoKPiAKPiBUaGFua3MsCj4gS2F6dQo+
IAo+IAo+ID4gKwkJdm1hbGxvY19zdGFydCA9IE5VTUJFUih2bWFsbG9jX3N0YXJ0KTsKPiA+ICsJ
fSBlbHNlIGlmICgoU1lNQk9MKHZtYXBfYXJlYV9saXN0KSAhPSBOT1RfRk9VTkRfU1lNQk9MKQo+
ID4gICAJICAgICYmIChPRkZTRVQodm1hcF9hcmVhLnZhX3N0YXJ0KSAhPSBOT1RfRk9VTkRfU1RS
VUNUVVJFKQo+ID4gICAJICAgICYmIChPRkZTRVQodm1hcF9hcmVhLmxpc3QpICE9IE5PVF9GT1VO
RF9TVFJVQ1RVUkUpKSB7Cj4gPiAgIAkJaWYgKCFyZWFkbWVtKFZBRERSLCBTWU1CT0wodm1hcF9h
cmVhX2xpc3QpICsgT0ZGU0VUKGxpc3RfaGVhZC5uZXh0KSwKPiA+IEBAIC02ODQsMTEgKzY4Niwx
NiBAQCB2YWRkcl90b19wYWRkcl9wcGM2NCh1bnNpZ25lZCBsb25nIHZhZGRyKQo+ID4gICAJaWYg
KChTWU1CT0wodm1hcF9hcmVhX2xpc3QpID09IE5PVF9GT1VORF9TWU1CT0wpCj4gPiAgIAkgICAg
fHwgKE9GRlNFVCh2bWFwX2FyZWEudmFfc3RhcnQpID09IE5PVF9GT1VORF9TVFJVQ1RVUkUpCj4g
PiAgIAkgICAgfHwgKE9GRlNFVCh2bWFwX2FyZWEubGlzdCkgPT0gTk9UX0ZPVU5EX1NUUlVDVFVS
RSkpIHsKPiA+IC0JCWlmICgoU1lNQk9MKHZtbGlzdCkgPT0gTk9UX0ZPVU5EX1NZTUJPTCkKPiA+
IC0JCSAgICB8fCAoT0ZGU0VUKHZtX3N0cnVjdC5hZGRyKSA9PSBOT1RfRk9VTkRfU1RSVUNUVVJF
KSkgewo+ID4gLQkJCUVSUk1TRygiQ2FuJ3QgZ2V0IGluZm8gZm9yIHZtYWxsb2MgdHJhbnNsYXRp
b24uXG4iKTsKPiA+IC0JCQlyZXR1cm4gTk9UX1BBRERSOwo+ID4gLQkJfQo+ID4gKwkJLyoKPiA+
ICsJCSAqIERvbid0IGRlcGVuZCBvbiB2bWFwX2FyZWFfbGlzdC92bWxpc3QgaWYgdm1hbGxvY19z
dGFydCBpcyBzZXQgaW4KPiA+ICsJCSAqIHZtY29yZWluZm8sIGluIHRoYXQgY2FzZSBwcm9jZWVk
IHdpdGhvdXQgZXJyb3IKPiA+ICsJCSAqLwo+ID4gKwkJaWYgKE5VTUJFUih2bWFsbG9jX3N0YXJ0
KSA9PSBOT1RfRk9VTkRfTlVNQkVSKQo+ID4gKwkJCWlmICgoU1lNQk9MKHZtbGlzdCkgPT0gTk9U
X0ZPVU5EX1NZTUJPTCkKPiA+ICsJCQkJfHwgKE9GRlNFVCh2bV9zdHJ1Y3QuYWRkcikgPT0gTk9U
X0ZPVU5EX1NUUlVDVFVSRSkpIHsKPiA+ICsJCQkJRVJSTVNHKCJDYW4ndCBnZXQgaW5mbyBmb3Ig
dm1hbGxvYyB0cmFuc2xhdGlvbi5cbiIpOwo+ID4gKwkJCQlyZXR1cm4gTk9UX1BBRERSOwo+ID4g
KwkJCX0KPiA+ICAgCX0KPiA+ICAgCj4gPiAgIAlyZXR1cm4gcHBjNjRfdnRvcF9sZXZlbDQodmFk
ZHIpOwo+ID4gZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIvbWFrZWR1bXBmaWxlLmMKPiA+
IGluZGV4IGIwMDRiOTNmZWNiNy4uYjZjNjNmYWQxNWYzIDEwMDY0NAo+ID4gLS0tIGEvbWFrZWR1
bXBmaWxlLmMKPiA+ICsrKyBiL21ha2VkdW1wZmlsZS5jCj4gPiBAQCAtMjk3OCw2ICsyOTc4LDgg
QEAgcmVhZF92bWNvcmVpbmZvKHZvaWQpCj4gPiAgIAlSRUFEX05VTUJFUigiUEFHRV9PRkZMSU5F
X01BUENPVU5UX1ZBTFVFIiwgUEFHRV9PRkZMSU5FX01BUENPVU5UX1ZBTFVFKTsKPiA+ICAgCVJF
QURfTlVNQkVSKCJwaHlzX2Jhc2UiLCBwaHlzX2Jhc2UpOwo+ID4gICAJUkVBRF9OVU1CRVIoIktF
Uk5FTF9JTUFHRV9TSVpFIiwgS0VSTkVMX0lNQUdFX1NJWkUpOwo+ID4gKwo+ID4gKwlSRUFEX05V
TUJFUl9VTlNJR05FRCgiVk1BTExPQ19TVEFSVCIsIHZtYWxsb2Nfc3RhcnQpOwo+ID4gICAjaWZk
ZWYgX19hYXJjaDY0X18KPiA+ICAgCVJFQURfTlVNQkVSKCJWQV9CSVRTIiwgVkFfQklUUyk7Cj4g
PiAgIAlSRUFEX05VTUJFUigiVENSX0VMMV9UMVNaIiwgVENSX0VMMV9UMVNaKTsKPiA+IEBAIC0y
OTg5LDcgKzI5OTEsNiBAQCByZWFkX3ZtY29yZWluZm8odm9pZCkKPiA+ICAgCVJFQURfTlVNQkVS
KCJWQV9CSVRTIiwgdmFfYml0cyk7Cj4gPiAgIAlSRUFEX05VTUJFUl9VTlNJR05FRCgicGh5c19y
YW1fYmFzZSIsIHBoeXNfcmFtX2Jhc2UpOwo+ID4gICAJUkVBRF9OVU1CRVJfVU5TSUdORUQoIlBB
R0VfT0ZGU0VUIiwgcGFnZV9vZmZzZXQpOwo+ID4gLQlSRUFEX05VTUJFUl9VTlNJR05FRCgiVk1B
TExPQ19TVEFSVCIsIHZtYWxsb2Nfc3RhcnQpOwo+ID4gICAJUkVBRF9OVU1CRVJfVU5TSUdORUQo
IlZNQUxMT0NfRU5EIiwgdm1hbGxvY19lbmQpOwo+ID4gICAJUkVBRF9OVU1CRVJfVU5TSUdORUQo
IlZNRU1NQVBfU1RBUlQiLCB2bWVtbWFwX3N0YXJ0KTsKPiA+ICAgCVJFQURfTlVNQkVSX1VOU0lH
TkVEKCJWTUVNTUFQX0VORCIsIHZtZW1tYXBfZW5kKTsKPiA+IGRpZmYgLS1naXQgYS9tYWtlZHVt
cGZpbGUuaCBiL21ha2VkdW1wZmlsZS5oCj4gPiBpbmRleCA1OWM4M2UxZDlkZjMuLjQwMjFjNWFm
MmEzNCAxMDA2NDQKPiA+IC0tLSBhL21ha2VkdW1wZmlsZS5oCj4gPiArKysgYi9tYWtlZHVtcGZp
bGUuaAo+ID4gQEAgLTU0MSw4ICs1NDEsNiBAQCBkbyB7IFwKPiA+ICAgICogVGhlIHZhbHVlIG9m
IGRlcGVuZGVuY2Ugb24gbWFjaGluZQo+ID4gICAgKi8KPiA+ICAgI2RlZmluZSBQQUdFX09GRlNF
VAkJKGluZm8tPnBhZ2Vfb2Zmc2V0KQo+ID4gLSNkZWZpbmUgVk1BTExPQ19TVEFSVAkJKGluZm8t
PnZtYWxsb2Nfc3RhcnQpCj4gPiAtI2RlZmluZSBWTUFMTE9DX0VORAkJKGluZm8tPnZtYWxsb2Nf
ZW5kKQo+ID4gICAjZGVmaW5lIFZNRU1NQVBfU1RBUlQJCShpbmZvLT52bWVtbWFwX3N0YXJ0KQo+
ID4gICAjZGVmaW5lIFZNRU1NQVBfRU5ECQkoaW5mby0+dm1lbW1hcF9lbmQpCj4gPiAgICNkZWZp
bmUgUE1BU0sJCQkoMHg3ZmZmZmZmZmZmZmZmMDAwVUwpCj4gPiBAQCAtMjI2Miw2ICsyMjYwLDkg
QEAgc3RydWN0IG51bWJlcl90YWJsZSB7Cj4gPiAgIAlsb25nICAgIEhVR0VUTEJfUEFHRV9EVE9S
Owo+ID4gICAJbG9uZwlwaHlzX2Jhc2U7Cj4gPiAgIAlsb25nCUtFUk5FTF9JTUFHRV9TSVpFOwo+
ID4gKwo+ID4gKwl1bnNpZ25lZCBsb25nIHZtYWxsb2Nfc3RhcnQ7Cj4gPiArCj4gPiAgICNpZmRl
ZiBfX2FhcmNoNjRfXwo+ID4gICAJbG9uZyAJVkFfQklUUzsKPiA+ICAgCWxvbmcJVENSX0VMMV9U
MVNaOwo+ID4gQEAgLTIyNzIsNyArMjI3Myw2IEBAIHN0cnVjdCBudW1iZXJfdGFibGUgewo+ID4g
ICAJbG9uZyB2YV9iaXRzOwo+ID4gICAJdW5zaWduZWQgbG9uZyBwaHlzX3JhbV9iYXNlOwo+ID4g
ICAJdW5zaWduZWQgbG9uZyBwYWdlX29mZnNldDsKPiA+IC0JdW5zaWduZWQgbG9uZyB2bWFsbG9j
X3N0YXJ0Owo+ID4gICAJdW5zaWduZWQgbG9uZyB2bWFsbG9jX2VuZDsKPiA+ICAgCXVuc2lnbmVk
IGxvbmcgdm1lbW1hcF9zdGFydDsKPiA+ICAgCXVuc2lnbmVkIGxvbmcgdm1lbW1hcF9lbmQ7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
