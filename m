Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07260C636D3
	for <kexec@archiver.kernel.org>; Thu,  9 Feb 2023 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jn9F9etc7AheF8qWy5S1m8XulRcfQYH5PBvlIKkOkq0=; b=t5jwTYllzzVC60
	Fvuw9xugloQXrHvUWz0od1y++7M5oML2Z/tFunvzTjbC/yCgPkUOCqvBcEKuGzC2x2gr/7bsbb1yr
	wV27FQjnXX0saGU04tHJsQ7LWnPpgIiiEdxYuf8QumiPMX4SIXdyVKjH5nP0RtA6O1csEFXMaelsp
	aTVk/49pqSTjpcDhb7DB70IWPdP+qBDScN34LNVSPbBrN+shmja9B/X02IDCruaumeXgRjA8rW3Ou
	2xkGl9akyHFgPSSd60hW71sx1Zh0x2hbPLlJCCjXKmQ6WIg5GIA9b6BoSxjYl9Usc+XCHgbqVKqUK
	vLDEsnD+zH5iSl9WTpKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQBtf-002spO-LD; Thu, 09 Feb 2023 18:43:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQBtc-002snp-DM
	for kexec@lists.infradead.org; Thu, 09 Feb 2023 18:43:49 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319IFItu027092;
	Thu, 9 Feb 2023 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CbeDSGRGITgYPWKV/a/L7ZMG0+7RL3Ck2IccPPZsZB4=;
 b=bl5FUS17HBdsEsdeZDfCVoBMpOGH9rqS3EtjN0bEmFVHqPsqXhh8iZ0uLIzZNACCmqve
 czuXlKLp987Um0DR4CeKvJKPW8eS9zKhEDjo0qF451ccV317VLzg3kh/Or37hvtzDu90
 zaFGb8RFzSDgul+SA4LGoRycEplJNMuwHDsYADGzPJ4rnyCDBUfnbVYryVu+Yb+2OBGk
 IbfwY9GylJockHQctgIObPn/LTQw4VCj8qjeN/v7sDmQd6hYXaytEmB42OEG5BClMRLo
 uGv3p0ECEyKJSMhPhtg6x60ut9IZsZO4suPobqcjNmwKyqU2FJcfvLm8rLwuMxZkBzFq sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5xtruxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Feb 2023 18:43:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319INVHl027357;
	Thu, 9 Feb 2023 18:43:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5xtrux4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Feb 2023 18:43:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319Hoe8U011173;
	Thu, 9 Feb 2023 18:43:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06vns1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Feb 2023 18:43:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319Ih7NW49938688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Feb 2023 18:43:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6259D20040;
	Thu,  9 Feb 2023 18:43:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F16620043;
	Thu,  9 Feb 2023 18:43:02 +0000 (GMT)
Received: from [9.43.118.216] (unknown [9.43.118.216])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Feb 2023 18:43:01 +0000 (GMT)
Message-ID: <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
Date: Fri, 10 Feb 2023 00:13:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
To: Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
        efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qdDpszezIS5EbmhA72goeZYtIaqtY0Q0
X-Proofpoint-ORIG-GUID: IDLYTDlY6iOI64r9nJQL2lJoyqID8yCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090174
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_104348_487038_FEF85B1B 
X-CRM114-Status: GOOD (  45.12  )
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

SGVsbG8gRXJpYywKCk9uIDA5LzAyLzIzIDIzOjAxLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4K
PiBPbiAyLzgvMjMgMDc6NDQsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4gRXJpYyEKPj4KPj4g
T24gVHVlLCBGZWIgMDcgMjAyMyBhdCAxMToyMywgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4+IE9u
IDIvMS8yMyAwNTozMywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4KPj4+IFNvIG15IGxhdGVz
dCBzb2x1dGlvbiBpcyBpbnRyb2R1Y2UgdHdvIG5ldyBDUFVIUCBzdGF0ZXMsIAo+Pj4gQ1BVSFBf
QVBfRUxGQ09SRUhEUl9PTkxJTkUKPj4+IGZvciBvbmxpbmluZyBhbmQgQ1BVSFBfQlBfRUxGQ09S
RUhEUl9PRkZMSU5FIGZvciBvZmZsaW5pbmcuIEknbSBvcGVuIAo+Pj4gdG8gYmV0dGVyIG5hbWVz
Lgo+Pj4KPj4+IFRoZSBDUFVIUF9BUF9FTEZDT1JFSERSX09OTElORSBuZWVkcyB0byBiZSBwbGFj
ZWQgYWZ0ZXIgCj4+PiBDUFVIUF9CUklOR1VQX0NQVS4gTXkKPj4+IGF0dGVtcHRzIGF0IGxvY2F0
aW5nIHRoaXMgc3RhdGUgZmFpbGVkIHdoZW4gaW5zaWRlIHRoZSBTVEFSVElORyAKPj4+IHNlY3Rp
b24sIHNvIEkgbG9jYXRlZAo+Pj4gdGhpcyBqdXN0IGluc2lkZSB0aGUgT05MSU5FIHNlY3RvaW4u
IFRoZSBjcmFzaCBob3RwbHVnIGhhbmRsZXIgaXMgCj4+PiByZWdpc3RlcmVkIG9uCj4+PiB0aGlz
IHN0YXRlIGFzIHRoZSBjYWxsYmFjayBmb3IgdGhlIC5zdGFydHVwIG1ldGhvZC4KPj4+Cj4+PiBU
aGUgQ1BVSFBfQlBfRUxGQ09SRUhEUl9PRkZMSU5FIG5lZWRzIHRvIGJlIHBsYWNlZCBiZWZvcmUg
Cj4+PiBDUFVIUF9URUFSRE9XTl9DUFUsIGFuZCBJCj4+PiBwbGFjZWQgaXQgYXQgdGhlIGVuZCBv
ZiB0aGUgUFJFUEFSRSBzZWN0aW9uLiBUaGlzIGNyYXNoIGhvdHBsdWcgCj4+PiBoYW5kbGVyIGlz
IGFsc28KPj4+IHJlZ2lzdGVyZWQgb24gdGhpcyBzdGF0ZSBhcyB0aGUgY2FsbGJhY2sgZm9yIHRo
ZSAudGVhcmRvd24gbWV0aG9kLgo+Pgo+PiBUQkgsIHRoYXQncyBzdGlsbCBvdmVyZW5naW5lZXJl
ZC4gU29tZXRoaW5nIGxpa2UgdGhpczoKPj4KPj4gYm9vbCBjcHVfaXNfYWxpdmUodW5zaWduZWQg
aW50IGNwdSkKPj4gewo+PiDCoMKgwqDCoHN0cnVjdCBjcHVocF9jcHVfc3RhdGUgKnN0ID0gcGVy
X2NwdV9wdHIoJmNwdWhwX3N0YXRlLCBjcHUpOwo+Pgo+PiDCoMKgwqDCoHJldHVybiBkYXRhX3Jh
Y2Uoc3QtPnN0YXRlKSA8PSBDUFVIUF9BUF9JRExFX0RFQUQ7Cj4+IH0KPj4KPj4gYW5kIHVzZSB0
aGlzIHRvIHF1ZXJ5IHRoZSBhY3R1YWwgc3RhdGUgYXQgY3Jhc2ggdGltZS4gVGhhdCBzcGFyZXMg
YWxsCj4+IHRob3NlIGNhbGxiYWNrIGhldXJpc3RpY3MuCj4+Cj4+PiBJJ20gbWFraW5nIG15IHdh
eSB0aG91Z2ggcGVyY3B1IGNyYXNoX25vdGVzLCBlbGZjb3JlaGRyLCB2bWNvcmVpbmZvLAo+Pj4g
bWFrZWR1bXBmaWxlIGFuZCAodGhlIGNvbnN1bWVyIG9mIGl0IGFsbCkgdGhlIHVzZXJzcGFjZSBj
cmFzaCB1dGlsaXR5LAo+Pj4gaW4gb3JkZXIgdG8gdW5kZXJzdGFuZCB0aGUgaW1wYWN0IG9mIG1v
dmluZyBmcm9tIGZvcl9lYWNoX3ByZXNlbnRfY3B1KCkKPj4+IHRvIGZvcl9lYWNoX29ubGluZV9j
cHUoKS4KPj4KPj4gSXMgdGhlIHBhY2tpbmcgYWN0dWFsbHkgd29ydGggdGhlIHRyb3VibGU/IFdo
YXQncyB0aGUgYWN0dWFsIHdpbj8KPj4KPj4gVGhhbmtzLAo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKg
IHRnbHgKPj4KPj4KPgo+IFRob21hcywKPiBJJ3ZlIGludmVzdGlnYXRlZCB0aGUgcGFzc2luZyBv
ZiBjcmFzaCBub3RlcyB0aHJvdWdoIHRoZSB2bWNvcmUuIFdoYXQgCj4gSSd2ZSBsZWFybmVkIGlz
IHRoYXQ6Cj4KPiAtIGxpbnV4L2ZzL3Byb2Mvdm1jb3JlLmMgKHdoaWNoIG1ha2VkdW1wZmlsZSBy
ZWZlcmVuY2VzIHRvIGRvIGl0cyBqb2IpIAo+IGRvZXMKPiDCoCBub3QgY2FyZSB3aGF0IHRoZSBj
b250ZW50cyBvZiBjcHUgUFRfTk9URVMgYXJlLCBidXQgaXQgZG9lcyBjb2FsZXNjZSAKPiB0aGVt
IHRvZ2V0aGVyLgo+Cj4gLSBtYWtlZHVtcGZpbGUgd2lsbCBjb3VudCB0aGUgbnVtYmVyIG9mIGNw
dSBQVF9OT1RFUyBpbiBvcmRlciB0byAKPiBkZXRlcm1pbmUgaXRzCj4gwqAgbnJfY3B1cyB2YXJp
YWJsZSwgd2hpY2ggaXMgcmVwb3J0ZWQgaW4gYSBoZWFkZXIsIGJ1dCBvdGhlcndpc2UgCj4gdW51
c2VkIChleGNlcHQKPiDCoCBmb3Igc2FkdW1wIG1ldGhvZCkuCj4KPiAtIHRoZSBjcmFzaCB1dGls
aXR5LCBmb3IgdGhlIHB1cnBvc2VzIG9mIGRldGVybWluaW5nIHRoZSBjcHVzLCBkb2VzIAo+IG5v
dCBhcHBlYXIgdG8KPiDCoCByZWZlcmVuY2UgdGhlIGVsZmNvcmVoZHIgUFRfTk9URXMuIEluc3Rl
YWQgaXQgbG9jYXRlcyB0aGUgdmFyaW91cwo+IMKgIGNwdV9bcG9zc2libGV8cHJlc2VudHxvbmxp
bmVdX21hc2sgYW5kIGNvbXB1dGVzIG5yX2NwdXMgZnJvbSB0aGF0LCAKPiBhbmQgYWxzbyBvZgo+
IMKgIGNvdXJzZSB3aGljaCBhcmUgb25saW5lLiBJbiBhZGRpdGlvbiwgd2hlbiBjcmFzaCBkb2Vz
IHJlZmVyZW5jZSB0aGUgCj4gY3B1IFBUX05PVEUsCj4gwqAgdG8gZ2V0IGl0cyBwcnN0YXR1cywg
aXQgZG9lcyBzbyBieSB1c2luZyBhIHBlcmNwdSB0ZWNobmlxdWUgZGlyZWN0bHkgCj4gaW4gdGhl
IHZtY29yZQo+IMKgIGltYWdlIG1lbW9yeSwgbm90IHZpYSB0aGUgRUxGIHN0cnVjdHVyZS4gU2Fp
ZCBkaWZmZXJlbnRseSwgaXQgCj4gYXBwZWFycyB0byBtZSB0aGF0Cj4gwqAgY3Jhc2ggdXRpbGl0
eSBkb2Vzbid0IHJlbHkgb24gdGhlIEVMRiBQVF9OT1RFcyBmb3IgY3B1czsgcmF0aGVyIGl0IAo+
IG9idGFpbnMgdGhlbQo+IMKgIHZpYSBrZXJuZWwgY3B1bWFza3MgYW5kIHRoZSBtZW1vcnkgd2l0
aGluIHRoZSB2bWNvcmUuCj4KPiBXaXRoIHRoaXMgdW5kZXJzdGFuZGluZywgSSBkaWQgc29tZSB0
ZXN0aW5nLiBQZXJoYXBzIHRoZSBtb3N0IHRlbGxpbmcgCj4gdGVzdCB3YXMgdGhhdCBJCj4gY2hh
bmdlZCB0aGUgbnVtYmVyIG9mIGNwdSBQVF9OT1RFcyBlbWl0dGVkIGluIHRoZSAKPiBjcmFzaF9w
cmVwYXJlX2VsZjY0X2hlYWRlcnMoKSB0byBqdXN0IDEsCj4gaG90IHBsdWdnZWQgc29tZSBjcHVz
LCB0aGVuIGFsc28gdG9vayBhIGZldyBvZmZsaW5lIHNwYXJzZWx5IHZpYSAKPiBjaGNwdSwgdGhl
biBnZW5lcmF0ZWQgYQo+IHZtY29yZS4gVGhlIGNyYXNoIHV0aWxpdHkgaGFkIG5vIHByb2JsZW0g
bG9hZGluZyB0aGUgdm1jb3JlLCBpdCAKPiByZXBvcnRlZCB0aGUgcHJvcGVyIG51bWJlcgo+IG9m
IGNwdXMgYW5kIHRoZSBudW1iZXIgb2ZmbGluZSAoZGVzcGl0ZSBvbmx5IG9uZSBjcHUgUFRfTk9U
RSksIGFuZCAKPiBjaGFuZ2luZyB0byBhIGRpZmZlcmVudAo+IGNwdSB2aWEgJ3NldCAtYyAzMCcg
YW5kIHRoZSBiYWNrdHJhY2Ugd2FzIGNvbXBsZXRlbHkgdmFsaWQuCj4KPiBNeSB0YWtlIGF3YXkg
aXMgdGhhdCBjcmFzaCB1dGlsaXR5IGRvZXMgbm90IHJlbHkgdXBvbiBFTEYgY3B1IAo+IFBUX05P
VEVzLCBpdCBvYnRhaW5zIHRoZQo+IGNwdSBpbmZvcm1hdGlvbiBkaXJlY3RseSBmcm9tIGtlcm5l
bCBkYXRhIHN0cnVjdHVyZXMuIFBlcmhhcHMgYXQgb25lIAo+IHRpbWUgY3Jhc2ggcmVsaWVkCj4g
dXBvbiB0aGUgRUxGIGluZm9ybWF0aW9uLCBidXQgbm8gbW9yZS4gKFBlcmhhcHMgdGhlcmUgYXJl
IG90aGVyIGNyYXNoIAo+IGR1bXAgYW5hbHl6ZXJzCj4gdGhhdCBtaWdodCByZWx5IG9uIHRoZSBF
TEYgaW5mbz8pCj4KPiBTbywgYWxsIHRoaXMgdG8gc2F5IHRoYXQgSSBzZWUgbm8gbmVlZCB0byBj
aGFuZ2UgCj4gY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKCkuIFRoZXJlCj4gaXMgbm8gY29t
cGVsbGluZyByZWFzb24gdG8gbW92ZSBhd2F5IGZyb20gZm9yX2VhY2hfcHJlc2VudF9jcHUoKSwg
b3IgCj4gbW9kaWZ5IHRoZSBsaXN0IGZvcgo+IG9ubGluZS9vZmZsaW5lLgo+Cj4gV2hpY2ggdGhl
biBsZWF2ZXMgdGhlIHRvcGljIG9mIHRoZSBjcHVocCBzdGF0ZSBvbiB3aGljaCB0byByZWdpc3Rl
ci4gCj4gUGVyaGFwcyByZXZlcnRpbmcKPiBiYWNrIHRvIHRoZSB1c2Ugb2YgQ1BVSFBfQlBfUFJF
UEFSRV9EWU4gaXMgdGhlIHJpZ2h0IGFuc3dlci4gVGhlcmUgCj4gZG9lcyBub3QgYXBwZWFyIHRv
Cj4gYmUgYSBjb21wZWxsaW5nIG5lZWQgdG8gYWNjdXJhdGVseSB0cmFjayB3aGV0aGVyIHRoZSBj
cHUgd2VudCAKPiBvbmxpbmUvb2ZmbGluZSBmb3IgdGhlCj4gcHVycG9zZXMgb2YgY3JlYXRpbmcg
dGhlIGVsZmNvcmVoZHIsIGFzIHVsdGltYXRlbHkgdGhlIGNyYXNoIHV0aWxpdHkgCj4gcHVsbHMg
dGhhdCBmcm9tCj4ga2VybmVsIGRhdGEgc3RydWN0dXJlcywgbm90IHRoZSBlbGZjb3JlaGRyLgo+
Cj4gSSB0aGluayB0aGlzIGlzIHdoYXQgU291cmFiaCBoYXMga25vd24gYW5kIGhhcyBiZWVuIGFk
dm9jYXRpbmcgZm9yIGFuIAo+IG9wdGltaXphdGlvbgo+IHBhdGggdGhhdCBhbGxvd3Mgbm90IHJl
Z2VuZXJhdGluZyB0aGUgZWxmY29yZWhkciBvbiBjcHUgY2hhbmdlcyAKPiAoYmVjYXVzZSBhbGwg
dGhlIHBlcmNwdQo+IHN0cnVjdHMgYXJlIGFsbCBsYWlkIG91dCkuIEkgZG8gdGhpbmsgaXQgYmVz
dCB0byBsZWF2ZSB0aGF0IGFzIGFuIGFyY2ggCj4gY2hvaWNlLgoKU2luY2UgdGhpbmdzIGFyZSBj
bGVhciBvbiBob3cgdGhlIFBUX05PVEVTIGFyZSBjb25zdW1lZCBpbiBrZHVtcCBrZXJuZWwgCltm
cy9wcm9jL3ZtY29yZS5jXSwKbWFrZWR1bXBmaWxlLCBhbmQgY3Jhc2ggdG9vbCBJIG5lZWQgeW91
ciBvcGluaW9uIG9uIHRoaXM6CgpEbyB3ZSByZWFsbHkgbmVlZCB0byByZWdlbmVyYXRlIGVsZmNv
cmVoZHIgZm9yIENQVSBob3RwbHVnIGV2ZW50cz8KSWYgeWVzLCBjYW4geW91IHBsZWFzZSBsaXN0
IHRoZSBlbGZjb3JlaGRyIGNvbXBvbmVudHMgdGhhdCBjaGFuZ2VzIGR1ZSAKdG8gQ1BVIGhvdHBs
dWcuCgogRnJvbSB3aGF0IEkgdW5kZXJzdG9vZCwgY3Jhc2ggbm90ZXMgYXJlIHByZXBhcmVkIGZv
ciBwb3NzaWJsZSBDUFVzIGFzIApzeXN0ZW0gYm9vdHMgYW5kCmNvdWxkIGJlIHVzZWQgdG8gY3Jl
YXRlIGEgUFRfTk9URSBzZWN0aW9uIGZvciBlYWNoIHBvc3NpYmxlIENQVSB3aGlsZSAKZ2VuZXJh
dGluZyB0aGUgZWxmY29yZWhkcgpkdXJpbmcgdGhlIGtkdW1wIGtlcm5lbCBsb2FkLgoKTm93IG9u
Y2UgdGhlIGVsZmNvcmVoZHIgaXMgbG9hZGVkIHdpdGggUFRfTk9URXMgZm9yIGV2ZXJ5IHBvc3Np
YmxlIENQVSAKdGhlcmUgaXMgbm8gbmVlZCB0bwpyZWdlbmVyYXRlIGl0IGZvciBDUFUgaG90cGx1
ZyBldmVudHMuIE9yIGRvIHdlPwoKVGhhbmtzLApTb3VyYWJoIEphaW4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
