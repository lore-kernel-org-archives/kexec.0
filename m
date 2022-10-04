Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E8C433FE
	for <kexec@archiver.kernel.org>; Tue,  4 Oct 2022 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8R75Q3Jk0OEyToisDrebQd1VpqnEfrlxnlW4oeZN08o=; b=NmRVL01+OOu/N0
	2lxCZtgl1STzpEpDOPp1/XgTXoFk0Kew9pQt0qwmx4D05ehMYO7wgyNdhrRpzAHHKb6hP1tvfVGRQ
	FXbgj0ePPKZ69JyAb0ux3Y4xSgI0NG5U1XTHioFdX8tgI27hI9QKeqVnQSvVq/Horb43bIA/OHDYf
	7zERF/NO2ZbqltzpwEaKXhXOngekN0uK79LCECWr9v7obkYsScPgzAujWfJijVKR5O0hGsZfYfQcF
	1t4Z52k61rJwArBdBGS5ymPQafeu1NBj31exs2ex8zsKMvdJiG0NfbEbf3g6zm0xzSZTJ0hI+1tZb
	x2oTEYX3XJyUOvC4bTVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofbZy-008f7z-7Z; Tue, 04 Oct 2022 06:38:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofbZv-008f6M-OP
	for kexec@lists.infradead.org; Tue, 04 Oct 2022 06:38:57 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2946PVB4010931;
	Tue, 4 Oct 2022 06:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4eQdKxYv6CFPpwGd2E6nDue75ks9Qq+xsAsqlVfZibM=;
 b=ZAKoQILNOOUEFAV75yyb2fxl1vqEQimqUzFnHL+7dB3+6mI7iKVB3a7qXfAQrfvgBGFJ
 meAjFKy+pr4tUgHeLfUKKLH1uWxAjN2cRcSSzQZC/vj3NZCecjA5wp2CpnuG7zEKJBuK
 aLSiJoa7nmWcuh7amXn27bdVnduBvLubx6mHvtCTUbSLtRNrgskH21GguIUEVQBAARBz
 5Zgi7AiVM+SqFHnxfl2gsoplU1YGy4dHcUmY36+vo/S2WNM11KmASbwGMF5WbVYHHmzc
 fe0ZzP9/UB5jMyXRf+sKXdQ4mLK/HJOu9HPGMJjian0sbandvp3rFqMNRuVptTMTUDd/ ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fj5rb38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 06:38:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2946PUgi010923;
	Tue, 4 Oct 2022 06:38:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fj5rb2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 06:38:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2946a86w029260;
	Tue, 4 Oct 2022 06:38:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 3jxd693pxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 06:38:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2946ckiR50659762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Oct 2022 06:38:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AD75A4054;
	Tue,  4 Oct 2022 06:38:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6C9A405B;
	Tue,  4 Oct 2022 06:38:12 +0000 (GMT)
Received: from [9.43.62.42] (unknown [9.43.62.42])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  4 Oct 2022 06:38:12 +0000 (GMT)
Message-ID: <1a07c461-67e8-8f0d-756d-ef96fa4a9b91@linux.ibm.com>
Date: Tue, 4 Oct 2022 12:08:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220909210509.6286-4-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wipsn-qfOuJvUfOSXojz_Qlfaq5bzFti
X-Proofpoint-GUID: q5K-hzptsQMrEM76xtVuh2S2JGYW5TFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_233855_926738_CF1DD1A8 
X-CRM114-Status: GOOD (  29.90  )
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

Ck9uIDEwLzA5LzIyIDAyOjM1LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+IENQVSBhbmQgbWVtb3J5
IGNoYW5nZSBub3RpZmljYXRpb25zIGFyZSByZWNlaXZlZCBpbiBvcmRlciB0bwo+IHJlZ2VuZXJh
dGUgdGhlIGVsZmNvcmVoZHIuCj4KPiBUbyBzdXBwb3J0IGNwdSBob3RwbHVnLCBhIGNhbGxiYWNr
IGlzIHJlZ2lzdGVyZWQgdG8gY2FwdHVyZSB0aGUKPiBDUFVIUF9BUF9PTkxJTkVfRFlOIG9ubGlu
ZSBhbmQgb2ZmbGluZSBldmVudHMgdmlhCj4gY3B1aHBfc2V0dXBfc3RhdGVfbm9jYWxscygpLgo+
Cj4gVG8gc3VwcG9ydCBtZW1vcnkgaG90cGx1ZywgYSBub3RpZmllciBpcyByZWdpc3RlcmVkIHRv
IGNhcHR1cmUgdGhlCj4gTUVNX09OTElORSBhbmQgTUVNX09GRkxJTkUgZXZlbnRzIHZpYSByZWdp
c3Rlcl9tZW1vcnlfbm90aWZpZXIoKS4KPgo+IFRoZSBjcHUgY2FsbGJhY2sgYW5kIG1lbW9yeSBu
b3RpZmllcnMgY2FsbCBoYW5kbGVfaG90cGx1Z19ldmVudCgpCj4gd2hpY2ggcGVyZm9ybXMgbmVl
ZGVkIHRhc2tzIGFuZCB0aGVuIGRpc3BhdGNoZXMgdGhlIGV2ZW50IHRvIHRoZQo+IGFyY2hpdGVj
dHVyZSBzcGVjaWZpYyBhcmNoX2NyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KCkuIER1cmluZyB0
aGUKPiBwcm9jZXNzLCB0aGUga2V4ZWNfbXV0ZXggaXMgaGVsZC4KPgo+IFNpZ25lZC1vZmYtYnk6
IEVyaWMgRGVWb2xkZXIgPGVyaWMuZGV2b2xkZXJAb3JhY2xlLmNvbT4KPiBBY2tlZC1ieTogQmFv
cXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L2NyYXNoX2Nv
cmUuaCB8ICAgOCArKysKPiAgIGluY2x1ZGUvbGludXgva2V4ZWMuaCAgICAgIHwgIDI2ICsrKysr
KysKPiAgIGtlcm5lbC9jcmFzaF9jb3JlLmMgICAgICAgIHwgMTM0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTY4IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NyYXNoX2NvcmUuaCBiL2luY2x1ZGUv
bGludXgvY3Jhc2hfY29yZS5oCj4gaW5kZXggZGU2MmE3MjI0MzFlLi5hMjcwZjg2NjA1MzggMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9jcmFzaF9jb3JlLmgKPiArKysgYi9pbmNsdWRlL2xp
bnV4L2NyYXNoX2NvcmUuaAo+IEBAIC04NCw0ICs4NCwxMiBAQCBpbnQgcGFyc2VfY3Jhc2hrZXJu
ZWxfaGlnaChjaGFyICpjbWRsaW5lLCB1bnNpZ25lZCBsb25nIGxvbmcgc3lzdGVtX3JhbSwKPiAg
IGludCBwYXJzZV9jcmFzaGtlcm5lbF9sb3coY2hhciAqY21kbGluZSwgdW5zaWduZWQgbG9uZyBs
b25nIHN5c3RlbV9yYW0sCj4gICAJCXVuc2lnbmVkIGxvbmcgbG9uZyAqY3Jhc2hfc2l6ZSwgdW5z
aWduZWQgbG9uZyBsb25nICpjcmFzaF9iYXNlKTsKPiAgIAo+ICsjZGVmaW5lIEtFWEVDX0NSQVNI
X0hQX1JFTU9WRV9DUFUJCTAKPiArI2RlZmluZSBLRVhFQ19DUkFTSF9IUF9BRERfQ1BVCQkJMQo+
ICsjZGVmaW5lIEtFWEVDX0NSQVNIX0hQX1JFTU9WRV9NRU1PUlkJCTIKPiArI2RlZmluZSBLRVhF
Q19DUkFTSF9IUF9BRERfTUVNT1JZCQkzCj4gKyNkZWZpbmUgS0VYRUNfQ1JBU0hfSFBfSU5WQUxJ
RF9DUFUJCS0xVQo+ICsKPiArc3RydWN0IGtpbWFnZTsKPiArCj4gICAjZW5kaWYgLyogTElOVVhf
Q1JBU0hfQ09SRV9IICovCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva2V4ZWMuaCBiL2lu
Y2x1ZGUvbGludXgva2V4ZWMuaAo+IGluZGV4IDRlZWZhNjMxZTBhZS4uOTU5N2I0MTEzNmVjIDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgva2V4ZWMuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgv
a2V4ZWMuaAo+IEBAIC0zNzQsNiArMzc0LDEzIEBAIHN0cnVjdCBraW1hZ2Ugewo+ICAgCXN0cnVj
dCBwdXJnYXRvcnlfaW5mbyBwdXJnYXRvcnlfaW5mbzsKPiAgICNlbmRpZgo+ICAgCj4gKyNpZiBk
ZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwgZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBM
VUcpCj4gKwlib29sIGhvdHBsdWdfZXZlbnQ7Cj4gKwl1bnNpZ25lZCBpbnQgb2ZmbGluZWNwdTsK
PiArCWJvb2wgZWxmY29yZWhkcl9pbmRleF92YWxpZDsKPiArCWludCBlbGZjb3JlaGRyX2luZGV4
OwoKRG8gd2UgcmVhbGx5IG5lZWQgZWxmY29yZWhkcl9pbmRleF92YWxpZCB0byBkZWNpZGUgZWxm
Y29yZWhkcl9pbmRleCAKaG9sZHMgYSB2YWxpZCBpbmRleD8KCkhvdyBhYm91dCBpbml0aWFsaXpp
bmcgZWxmY29yZWhkcl9pbmRleCB0byBhIG5lZ2F0aXZlIG51bWJlciB3aGlsZSAKbG9hZGluZyBr
ZHVtcCBrZXJuZWwgKG9yIGtleGVjIGtlcm5lbCBpZiBuZWVkZWQpCmZvciBib3RoIGtleGVjX2xv
YWQgYW5kIGtleGVjX2ZpbGVfbG9hZCBjYXNlIGFuZCBjb25zaWRlciB0aGF0IGFzIAppbnZhbGlk
IGluZGV4IHRvIGZpbmQgdGhlIGNvcnJlY3Qgb25lLgoKU29tZSB0aGluZyBsaWtlIHRoaXM6Cgpk
aWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKaW5k
ZXggNWJjNTE1OWQ5Y2IxLi4wY2NjZGIyZjdmMjYgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9jcmFzaF9j
b3JlLmMKKysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwpAQCAtNjU2LDcgKzY1Niw3IEBAIHN0YXRp
YyB2b2lkIGhhbmRsZV9ob3RwbHVnX2V2ZW50KHVuc2lnbmVkIGludCAKaHBfYWN0aW9uLCB1bnNp
Z25lZCBpbnQgY3B1KQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBzZWdtZW50
IGNvbnRhaW5pbmcgdGhlIGVsZmNvcmVoZHIsIGlmIG5vdCBhbHJlYWR5IGZvdW5kLgogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGlzIHdvcmtzIGZvciBib3RoIHRoZSBrZXhl
Y19sb2FkIGFuZCAKa2V4ZWNfZmlsZV9sb2FkIHBhdGhzLgogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKi8KLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFpbWFnZS0+
ZWxmY29yZWhkcl9pbmRleF92YWxpZCkgeworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoaW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXggPCAwKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGNoYXIgKnB0cjsKIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBtZW0sIG1l
bXN6OwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNp
Z25lZCBpbnQgbjsKZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlYy5jIGIva2VybmVsL2tleGVjLmMK
aW5kZXggYjVlNDBmMDY5NzY4Li5lZDFjNmE4ODg3OWIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9rZXhl
Yy5jCisrKyBiL2tlcm5lbC9rZXhlYy5jCkBAIC0xNTYsNiArMTU2LDEwIEBAIHN0YXRpYyBpbnQg
ZG9fa2V4ZWNfbG9hZCh1bnNpZ25lZCBsb25nIGVudHJ5LCAKdW5zaWduZWQgbG9uZyBucl9zZWdt
ZW50cywKIMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXQ7CgorwqDCoMKgwqDCoMKgIC8qIEJlbG93IGNoZWNrIGlzIG5vdCBuZWNl
c3NhcnkgKi8KK8KgwqDCoMKgwqDCoCBpZiAoZmxhZ3MgJiBLRVhFQ19GSUxFX09OX0NSQVNIKQor
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbWFnZS0+ZWxmY29yZWhkcl9pbmRleCA9IC0x
OworCiDCoMKgwqDCoMKgwqDCoCAvKiBJbnN0YWxsIHRoZSBuZXcga2VybmVsIGFuZCB1bmluc3Rh
bGwgdGhlIG9sZCAqLwogwqDCoMKgwqDCoMKgwqAgaW1hZ2UgPSB4Y2hnKGRlc3RfaW1hZ2UsIGlt
YWdlKTsKCmRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWNfZmlsZS5jIGIva2VybmVsL2tleGVjX2Zp
bGUuYwppbmRleCBkMGMyNjYxYjM1MDkuLjUzNWRiYzI2OTMwYSAxMDA2NDQKLS0tIGEva2VybmVs
L2tleGVjX2ZpbGUuYworKysgYi9rZXJuZWwva2V4ZWNfZmlsZS5jCkBAIC00MDAsNiArNDAwLDEw
IEBAIFNZU0NBTExfREVGSU5FNShrZXhlY19maWxlX2xvYWQsIGludCwga2VybmVsX2ZkLCAKaW50
LCBpbml0cmRfZmQsCiDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gb3V0OwoKK8KgwqDCoMKgwqDCoCAvKiBCZWxvdyBjaGVjayBpcyBu
b3QgbmVjZXNzYXJ5ICovCivCoMKgwqDCoMKgwqAgaWYgKGZsYWdzICYgS0VYRUNfRklMRV9PTl9D
UkFTSCkKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW1hZ2UtPmVsZmNvcmVoZHJfaW5k
ZXggPSAtMTsKKwogwqDCoMKgwqDCoMKgwqAgLyoKIMKgwqDCoMKgwqDCoMKgwqAgKiBGcmVlIHVw
IGFueSB0ZW1wb3JhcnkgYnVmZmVycyBhbGxvY2F0ZWQgd2hpY2ggYXJlIG5vdCBuZWVkZWQKIMKg
wqDCoMKgwqDCoMKgwqAgKiBhZnRlciBpbWFnZSBoYXMgYmVlbiBsb2FkZWQKClRoYW5rcywKU291
cmFiaCBKYWluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
