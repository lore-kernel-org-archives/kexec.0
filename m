Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F62C678D4
	for <kexec@archiver.kernel.org>; Thu,  2 Mar 2023 05:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rEgv4b9jEmN8QnVD9JDsdb3iG0N+mJLR3cgsEjdJDZ4=; b=aFhAqGFd9kTup8
	9MVxEiEF3JKUsiz845IioPptGeXeriN50IvdSNvuXr7f1GfR1x827nNDgjsFeS+cY/DXteDJcA8EX
	r6MdtASv+oT0+Vt5Q6VpLOLKO3l6Jw7poQZXCd3UScCAMXQZkA8evyPWQ7AXtGC80XBUhfqbcu0L2
	1+Vb8Z9wWOcmU6tQXwWhLtiK25KThLMC9rlXX/0+yIPsgYdelDbK3yoiz+8SVRaIbAu6WixCsTiTw
	LDzYoIiGjd3G+4nSH4w2mqVLsIntBdNvgSPJhkdlkBTqbf0h+bf9HLTHvv4lwXwul/N1BGtdhhj+J
	lUNR+OHIqykKtQALDN6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXbQI-000t04-If; Thu, 02 Mar 2023 05:24:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXbQE-000szW-Bj
	for kexec@lists.infradead.org; Thu, 02 Mar 2023 05:24:08 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32241b5F012380;
	Thu, 2 Mar 2023 05:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DDss4AABd1yZ0Nt3OBzhl1Efc38Wgk54oWDp7fd84a0=;
 b=abRO++Om6HHjD/Qia/tPg8AqUysZschEMRoJcbB6QT7JOgjG0S1efG7Aog++Pqvz+cC2
 wZfG2VNiyLPPTGvXAjpGK1GuUaZK0EbpM/YKwFiMA3/qKeMi5pQzI4ycM3NC16vVjkoj
 cw3fcisdFOF1Kj/Z68iJ6e/cqfhH137Q87u0HMR3XGeO/gnZquYGI93gE9EKw7qy+0Sc
 zRM6RgOT9zFQ/Syiv1y8AgbmWQ5Yj5ffLBEKTxYzGbCOzaC1gfsQhT5PSlE9AzM00EVd
 1tw/ttNA4bIaLsR4O6NLDnhnZXoc1B5Jip1aRPH5RrzWks/pONu1WbY2zQkMPzu9GDvj BA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2mdp1n65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Mar 2023 05:23:39 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3225JZJ8027462;
	Thu, 2 Mar 2023 05:23:38 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2mdp1n5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Mar 2023 05:23:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 321KJFXq019799;
	Thu, 2 Mar 2023 05:23:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nybdfuvrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Mar 2023 05:23:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3225NX3w65339840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Mar 2023 05:23:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7055820043;
	Thu,  2 Mar 2023 05:23:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62C1320040;
	Thu,  2 Mar 2023 05:23:28 +0000 (GMT)
Received: from [9.43.92.152] (unknown [9.43.92.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Mar 2023 05:23:28 +0000 (GMT)
Message-ID: <c91066ed-07b9-4e29-6fd0-683c788564be@linux.ibm.com>
Date: Thu, 2 Mar 2023 10:53:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230131224236.122805-6-eric.devolder@oracle.com>
 <87sffpzkle.ffs@tglx> <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
 <87h6vw2rwf.ffs@tglx> <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
 <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
 <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4G2WpP5NIdcQQtw_zFuwaa_520pYs7QF
X-Proofpoint-ORIG-GUID: 3bpKXH2b05hUL5M8l4_Wv_5RuDVj3JSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_212406_438907_C764463E 
X-CRM114-Status: GOOD (  45.43  )
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

Ck9uIDAxLzAzLzIzIDAwOjIyLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAyLzI4LzIz
IDA2OjQ0LCBCYW9xdWFuIEhlIHdyb3RlOgo+PiBPbiAwMi8xMy8yMyBhdCAxMDoxMGFtLCBTb3Vy
YWJoIEphaW4gd3JvdGU6Cj4+Pgo+Pj4gT24gMTEvMDIvMjMgMDY6MDUsIEVyaWMgRGVWb2xkZXIg
d3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDIvMTAvMjMgMDA6MjksIFNvdXJhYmggSmFpbiB3cm90
ZToKPj4+Pj4KPj4+Pj4gT24gMTAvMDIvMjMgMDE6MDksIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+
Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IE9uIDIvOS8yMyAxMjo0MywgU291cmFiaCBKYWluIHdyb3RlOgo+
Pj4+Pj4+IEhlbGxvIEVyaWMsCj4+Pj4+Pj4KPj4+Pj4+PiBPbiAwOS8wMi8yMyAyMzowMSwgRXJp
YyBEZVZvbGRlciB3cm90ZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gT24gMi84LzIzIDA3
OjQ0LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+Pj4+Pj4+PiBFcmljIQo+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+IE9uIFR1ZSwgRmViIDA3IDIwMjMgYXQgMTE6MjMsIEVyaWMgRGVWb2xkZXIgd3JvdGU6
Cj4+Pj4+Pj4+Pj4gT24gMi8xLzIzIDA1OjMzLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+PiBTbyBteSBsYXRlc3Qgc29sdXRpb24gaXMgaW50cm9kdWNlIHR3byBu
ZXcgQ1BVSFAKPj4+Pj4+Pj4+PiBzdGF0ZXMsIENQVUhQX0FQX0VMRkNPUkVIRFJfT05MSU5FCj4+
Pj4+Pj4+Pj4gZm9yIG9ubGluaW5nIGFuZCBDUFVIUF9CUF9FTEZDT1JFSERSX09GRkxJTkUgZm9y
Cj4+Pj4+Pj4+Pj4gb2ZmbGluaW5nLiBJJ20gb3BlbiB0byBiZXR0ZXIgbmFtZXMuCj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+PiBUaGUgQ1BVSFBfQVBfRUxGQ09SRUhEUl9PTkxJTkUgbmVlZHMgdG8gYmUK
Pj4+Pj4+Pj4+PiBwbGFjZWQgYWZ0ZXIgQ1BVSFBfQlJJTkdVUF9DUFUuIE15Cj4+Pj4+Pj4+Pj4g
YXR0ZW1wdHMgYXQgbG9jYXRpbmcgdGhpcyBzdGF0ZSBmYWlsZWQgd2hlbgo+Pj4+Pj4+Pj4+IGlu
c2lkZSB0aGUgU1RBUlRJTkcgc2VjdGlvbiwgc28gSSBsb2NhdGVkCj4+Pj4+Pj4+Pj4gdGhpcyBq
dXN0IGluc2lkZSB0aGUgT05MSU5FIHNlY3RvaW4uIFRoZSBjcmFzaAo+Pj4+Pj4+Pj4+IGhvdHBs
dWcgaGFuZGxlciBpcyByZWdpc3RlcmVkIG9uCj4+Pj4+Pj4+Pj4gdGhpcyBzdGF0ZSBhcyB0aGUg
Y2FsbGJhY2sgZm9yIHRoZSAuc3RhcnR1cCBtZXRob2QuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBU
aGUgQ1BVSFBfQlBfRUxGQ09SRUhEUl9PRkZMSU5FIG5lZWRzIHRvIGJlCj4+Pj4+Pj4+Pj4gcGxh
Y2VkIGJlZm9yZSBDUFVIUF9URUFSRE9XTl9DUFUsIGFuZCBJCj4+Pj4+Pj4+Pj4gcGxhY2VkIGl0
IGF0IHRoZSBlbmQgb2YgdGhlIFBSRVBBUkUgc2VjdGlvbi4KPj4+Pj4+Pj4+PiBUaGlzIGNyYXNo
IGhvdHBsdWcgaGFuZGxlciBpcyBhbHNvCj4+Pj4+Pj4+Pj4gcmVnaXN0ZXJlZCBvbiB0aGlzIHN0
YXRlIGFzIHRoZSBjYWxsYmFjayBmb3IgdGhlIC50ZWFyZG93biAKPj4+Pj4+Pj4+PiBtZXRob2Qu
Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gVEJILCB0aGF0J3Mgc3RpbGwgb3ZlcmVuZ2luZWVyZWQuIFNv
bWV0aGluZyBsaWtlIHRoaXM6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gYm9vbCBjcHVfaXNfYWxpdmUo
dW5zaWduZWQgaW50IGNwdSkKPj4+Pj4+Pj4+IHsKPj4+Pj4+Pj4+IMKgwqDCoMKgwqBzdHJ1Y3Qg
Y3B1aHBfY3B1X3N0YXRlICpzdCA9IHBlcl9jcHVfcHRyKCZjcHVocF9zdGF0ZSwgY3B1KTsKPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+PiDCoMKgwqDCoMKgcmV0dXJuIGRhdGFfcmFjZShzdC0+c3RhdGUpIDw9
IENQVUhQX0FQX0lETEVfREVBRDsKPj4+Pj4+Pj4+IH0KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBhbmQg
dXNlIHRoaXMgdG8gcXVlcnkgdGhlIGFjdHVhbCBzdGF0ZSBhdCBjcmFzaAo+Pj4+Pj4+Pj4gdGlt
ZS4gVGhhdCBzcGFyZXMgYWxsCj4+Pj4+Pj4+PiB0aG9zZSBjYWxsYmFjayBoZXVyaXN0aWNzLgo+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBJJ20gbWFraW5nIG15IHdheSB0aG91Z2ggcGVyY3B1IGNyYXNo
X25vdGVzLAo+Pj4+Pj4+Pj4+IGVsZmNvcmVoZHIsIHZtY29yZWluZm8sCj4+Pj4+Pj4+Pj4gbWFr
ZWR1bXBmaWxlIGFuZCAodGhlIGNvbnN1bWVyIG9mIGl0IGFsbCkgdGhlCj4+Pj4+Pj4+Pj4gdXNl
cnNwYWNlIGNyYXNoIHV0aWxpdHksCj4+Pj4+Pj4+Pj4gaW4gb3JkZXIgdG8gdW5kZXJzdGFuZCB0
aGUgaW1wYWN0IG9mIG1vdmluZyBmcm9tCj4+Pj4+Pj4+Pj4gZm9yX2VhY2hfcHJlc2VudF9jcHUo
KQo+Pj4+Pj4+Pj4+IHRvIGZvcl9lYWNoX29ubGluZV9jcHUoKS4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+
PiBJcyB0aGUgcGFja2luZyBhY3R1YWxseSB3b3J0aCB0aGUgdHJvdWJsZT8gV2hhdCdzIHRoZSBh
Y3R1YWwgd2luPwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRoYW5rcywKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgdGdseAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IFRob21hcywKPj4+Pj4+Pj4gSSd2ZSBpbnZlc3RpZ2F0ZWQgdGhlIHBhc3Npbmcgb2Yg
Y3Jhc2ggbm90ZXMgdGhyb3VnaCB0aGUKPj4+Pj4+Pj4gdm1jb3JlLiBXaGF0IEkndmUgbGVhcm5l
ZCBpcyB0aGF0Ogo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAtIGxpbnV4L2ZzL3Byb2Mvdm1jb3JlLmMgKHdo
aWNoIG1ha2VkdW1wZmlsZSByZWZlcmVuY2VzCj4+Pj4+Pj4+IHRvIGRvIGl0cyBqb2IpIGRvZXMK
Pj4+Pj4+Pj4gwqDCoCBub3QgY2FyZSB3aGF0IHRoZSBjb250ZW50cyBvZiBjcHUgUFRfTk9URVMg
YXJlLCBidXQgaXQKPj4+Pj4+Pj4gZG9lcyBjb2FsZXNjZSB0aGVtIHRvZ2V0aGVyLgo+Pj4+Pj4+
Pgo+Pj4+Pj4+PiAtIG1ha2VkdW1wZmlsZSB3aWxsIGNvdW50IHRoZSBudW1iZXIgb2YgY3B1IFBU
X05PVEVTIGluCj4+Pj4+Pj4+IG9yZGVyIHRvIGRldGVybWluZSBpdHMKPj4+Pj4+Pj4gwqDCoCBu
cl9jcHVzIHZhcmlhYmxlLCB3aGljaCBpcyByZXBvcnRlZCBpbiBhIGhlYWRlciwgYnV0Cj4+Pj4+
Pj4+IG90aGVyd2lzZSB1bnVzZWQgKGV4Y2VwdAo+Pj4+Pj4+PiDCoMKgIGZvciBzYWR1bXAgbWV0
aG9kKS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gLSB0aGUgY3Jhc2ggdXRpbGl0eSwgZm9yIHRoZSBwdXJw
b3NlcyBvZiBkZXRlcm1pbmluZyB0aGUKPj4+Pj4+Pj4gY3B1cywgZG9lcyBub3QgYXBwZWFyIHRv
Cj4+Pj4+Pj4+IMKgwqAgcmVmZXJlbmNlIHRoZSBlbGZjb3JlaGRyIFBUX05PVEVzLiBJbnN0ZWFk
IGl0IGxvY2F0ZXMgdGhlIAo+Pj4+Pj4+PiB2YXJpb3VzCj4+Pj4+Pj4+IMKgwqAgY3B1X1twb3Nz
aWJsZXxwcmVzZW50fG9ubGluZV1fbWFzayBhbmQgY29tcHV0ZXMKPj4+Pj4+Pj4gbnJfY3B1cyBm
cm9tIHRoYXQsIGFuZCBhbHNvIG9mCj4+Pj4+Pj4+IMKgwqAgY291cnNlIHdoaWNoIGFyZSBvbmxp
bmUuIEluIGFkZGl0aW9uLCB3aGVuIGNyYXNoIGRvZXMKPj4+Pj4+Pj4gcmVmZXJlbmNlIHRoZSBj
cHUgUFRfTk9URSwKPj4+Pj4+Pj4gwqDCoCB0byBnZXQgaXRzIHByc3RhdHVzLCBpdCBkb2VzIHNv
IGJ5IHVzaW5nIGEgcGVyY3B1Cj4+Pj4+Pj4+IHRlY2huaXF1ZSBkaXJlY3RseSBpbiB0aGUgdm1j
b3JlCj4+Pj4+Pj4+IMKgwqAgaW1hZ2UgbWVtb3J5LCBub3QgdmlhIHRoZSBFTEYgc3RydWN0dXJl
LiBTYWlkCj4+Pj4+Pj4+IGRpZmZlcmVudGx5LCBpdCBhcHBlYXJzIHRvIG1lIHRoYXQKPj4+Pj4+
Pj4gwqDCoCBjcmFzaCB1dGlsaXR5IGRvZXNuJ3QgcmVseSBvbiB0aGUgRUxGIFBUX05PVEVzIGZv
cgo+Pj4+Pj4+PiBjcHVzOyByYXRoZXIgaXQgb2J0YWlucyB0aGVtCj4+Pj4+Pj4+IMKgwqAgdmlh
IGtlcm5lbCBjcHVtYXNrcyBhbmQgdGhlIG1lbW9yeSB3aXRoaW4gdGhlIHZtY29yZS4KPj4+Pj4+
Pj4KPj4+Pj4+Pj4gV2l0aCB0aGlzIHVuZGVyc3RhbmRpbmcsIEkgZGlkIHNvbWUgdGVzdGluZy4g
UGVyaGFwcyB0aGUKPj4+Pj4+Pj4gbW9zdCB0ZWxsaW5nIHRlc3Qgd2FzIHRoYXQgSQo+Pj4+Pj4+
PiBjaGFuZ2VkIHRoZSBudW1iZXIgb2YgY3B1IFBUX05PVEVzIGVtaXR0ZWQgaW4gdGhlCj4+Pj4+
Pj4+IGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycygpIHRvIGp1c3QgMSwKPj4+Pj4+Pj4gaG90
IHBsdWdnZWQgc29tZSBjcHVzLCB0aGVuIGFsc28gdG9vayBhIGZldyBvZmZsaW5lCj4+Pj4+Pj4+
IHNwYXJzZWx5IHZpYSBjaGNwdSwgdGhlbiBnZW5lcmF0ZWQgYQo+Pj4+Pj4+PiB2bWNvcmUuIFRo
ZSBjcmFzaCB1dGlsaXR5IGhhZCBubyBwcm9ibGVtIGxvYWRpbmcgdGhlCj4+Pj4+Pj4+IHZtY29y
ZSwgaXQgcmVwb3J0ZWQgdGhlIHByb3BlciBudW1iZXIKPj4+Pj4+Pj4gb2YgY3B1cyBhbmQgdGhl
IG51bWJlciBvZmZsaW5lIChkZXNwaXRlIG9ubHkgb25lIGNwdQo+Pj4+Pj4+PiBQVF9OT1RFKSwg
YW5kIGNoYW5naW5nIHRvIGEgZGlmZmVyZW50Cj4+Pj4+Pj4+IGNwdSB2aWEgJ3NldCAtYyAzMCcg
YW5kIHRoZSBiYWNrdHJhY2Ugd2FzIGNvbXBsZXRlbHkgdmFsaWQuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IE15IHRha2UgYXdheSBpcyB0aGF0IGNyYXNoIHV0aWxpdHkgZG9lcyBub3QgcmVseSB1cG9uCj4+
Pj4+Pj4+IEVMRiBjcHUgUFRfTk9URXMsIGl0IG9idGFpbnMgdGhlCj4+Pj4+Pj4+IGNwdSBpbmZv
cm1hdGlvbiBkaXJlY3RseSBmcm9tIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMuCj4+Pj4+Pj4+IFBl
cmhhcHMgYXQgb25lIHRpbWUgY3Jhc2ggcmVsaWVkCj4+Pj4+Pj4+IHVwb24gdGhlIEVMRiBpbmZv
cm1hdGlvbiwgYnV0IG5vIG1vcmUuIChQZXJoYXBzIHRoZXJlCj4+Pj4+Pj4+IGFyZSBvdGhlciBj
cmFzaCBkdW1wIGFuYWx5emVycwo+Pj4+Pj4+PiB0aGF0IG1pZ2h0IHJlbHkgb24gdGhlIEVMRiBp
bmZvPykKPj4+Pj4+Pj4KPj4+Pj4+Pj4gU28sIGFsbCB0aGlzIHRvIHNheSB0aGF0IEkgc2VlIG5v
IG5lZWQgdG8gY2hhbmdlCj4+Pj4+Pj4+IGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycygpLiBU
aGVyZQo+Pj4+Pj4+PiBpcyBubyBjb21wZWxsaW5nIHJlYXNvbiB0byBtb3ZlIGF3YXkgZnJvbQo+
Pj4+Pj4+PiBmb3JfZWFjaF9wcmVzZW50X2NwdSgpLCBvciBtb2RpZnkgdGhlIGxpc3QgZm9yCj4+
Pj4+Pj4+IG9ubGluZS9vZmZsaW5lLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBXaGljaCB0aGVuIGxlYXZl
cyB0aGUgdG9waWMgb2YgdGhlIGNwdWhwIHN0YXRlIG9uIHdoaWNoCj4+Pj4+Pj4+IHRvIHJlZ2lz
dGVyLiBQZXJoYXBzIHJldmVydGluZwo+Pj4+Pj4+PiBiYWNrIHRvIHRoZSB1c2Ugb2YgQ1BVSFBf
QlBfUFJFUEFSRV9EWU4gaXMgdGhlIHJpZ2h0Cj4+Pj4+Pj4+IGFuc3dlci4gVGhlcmUgZG9lcyBu
b3QgYXBwZWFyIHRvCj4+Pj4+Pj4+IGJlIGEgY29tcGVsbGluZyBuZWVkIHRvIGFjY3VyYXRlbHkg
dHJhY2sgd2hldGhlciB0aGUgY3B1Cj4+Pj4+Pj4+IHdlbnQgb25saW5lL29mZmxpbmUgZm9yIHRo
ZQo+Pj4+Pj4+PiBwdXJwb3NlcyBvZiBjcmVhdGluZyB0aGUgZWxmY29yZWhkciwgYXMgdWx0aW1h
dGVseSB0aGUKPj4+Pj4+Pj4gY3Jhc2ggdXRpbGl0eSBwdWxscyB0aGF0IGZyb20KPj4+Pj4+Pj4g
a2VybmVsIGRhdGEgc3RydWN0dXJlcywgbm90IHRoZSBlbGZjb3JlaGRyLgo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiBJIHRoaW5rIHRoaXMgaXMgd2hhdCBTb3VyYWJoIGhhcyBrbm93biBhbmQgaGFzIGJlZW4K
Pj4+Pj4+Pj4gYWR2b2NhdGluZyBmb3IgYW4gb3B0aW1pemF0aW9uCj4+Pj4+Pj4+IHBhdGggdGhh
dCBhbGxvd3Mgbm90IHJlZ2VuZXJhdGluZyB0aGUgZWxmY29yZWhkciBvbiBjcHUKPj4+Pj4+Pj4g
Y2hhbmdlcyAoYmVjYXVzZSBhbGwgdGhlIHBlcmNwdQo+Pj4+Pj4+PiBzdHJ1Y3RzIGFyZSBhbGwg
bGFpZCBvdXQpLiBJIGRvIHRoaW5rIGl0IGJlc3QgdG8gbGVhdmUKPj4+Pj4+Pj4gdGhhdCBhcyBh
biBhcmNoIGNob2ljZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpbmNlIHRoaW5ncyBhcmUgY2xlYXIgb24g
aG93IHRoZSBQVF9OT1RFUyBhcmUgY29uc3VtZWQgaW4KPj4+Pj4+PiBrZHVtcCBrZXJuZWwgW2Zz
L3Byb2Mvdm1jb3JlLmNdLAo+Pj4+Pj4+IG1ha2VkdW1wZmlsZSwgYW5kIGNyYXNoIHRvb2wgSSBu
ZWVkIHlvdXIgb3BpbmlvbiBvbiB0aGlzOgo+Pj4+Pj4+Cj4+Pj4+Pj4gRG8gd2UgcmVhbGx5IG5l
ZWQgdG8gcmVnZW5lcmF0ZSBlbGZjb3JlaGRyIGZvciBDUFUgaG90cGx1ZyBldmVudHM/Cj4+Pj4+
Pj4gSWYgeWVzLCBjYW4geW91IHBsZWFzZSBsaXN0IHRoZSBlbGZjb3JlaGRyIGNvbXBvbmVudHMg
dGhhdAo+Pj4+Pj4+IGNoYW5nZXMgZHVlIHRvIENQVSBob3RwbHVnLgo+Pj4+Pj4gRHVlIHRvIHRo
ZSB1c2Ugb2YgZm9yX2VhY2hfcHJlc2VudF9jcHUoKSwgaXQgaXMgcG9zc2libGUgZm9yIHRoZQo+
Pj4+Pj4gbnVtYmVyIG9mIGNwdSBQVF9OT1RFcwo+Pj4+Pj4gdG8gZmx1Y3R1YXRlIGFzIGNwdXMg
YXJlIHVuL3BsdWdnZWQuIE9ubGluaW5nL29mZmxpbmluZyBvZiBjcHVzCj4+Pj4+PiBkb2VzIG5v
dCBpbXBhY3QgdGhlCj4+Pj4+PiBudW1iZXIgb2YgY3B1IFBUX05PVEVzIChhcyB0aGUgY3B1cyBh
cmUgc3RpbGwgcHJlc2VudCkuCj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoEZyb20gd2hhdCBJ
IHVuZGVyc3Rvb2QsIGNyYXNoIG5vdGVzIGFyZSBwcmVwYXJlZCBmb3IKPj4+Pj4+PiBwb3NzaWJs
ZSBDUFVzIGFzIHN5c3RlbSBib290cyBhbmQKPj4+Pj4+PiBjb3VsZCBiZSB1c2VkIHRvIGNyZWF0
ZSBhIFBUX05PVEUgc2VjdGlvbiBmb3IgZWFjaCBwb3NzaWJsZQo+Pj4+Pj4+IENQVSB3aGlsZSBn
ZW5lcmF0aW5nIHRoZSBlbGZjb3JlaGRyCj4+Pj4+Pj4gZHVyaW5nIHRoZSBrZHVtcCBrZXJuZWwg
bG9hZC4KPj4+Pj4+Pgo+Pj4+Pj4+IE5vdyBvbmNlIHRoZSBlbGZjb3JlaGRyIGlzIGxvYWRlZCB3
aXRoIFBUX05PVEVzIGZvciBldmVyeQo+Pj4+Pj4+IHBvc3NpYmxlIENQVSB0aGVyZSBpcyBubyBu
ZWVkIHRvCj4+Pj4+Pj4gcmVnZW5lcmF0ZSBpdCBmb3IgQ1BVIGhvdHBsdWcgZXZlbnRzLiBPciBk
byB3ZT8KPj4+Pj4+Cj4+Pj4+PiBGb3Igb25saW5pbmcvb2ZmbGluaW5nIG9mIGNwdXMsIHRoZXJl
IGlzIG5vIG5lZWQgdG8gcmVnZW5lcmF0ZQo+Pj4+Pj4gdGhlIGVsZmNvcmVoZHIuIEhvd2V2ZXIs
Cj4+Pj4+PiBmb3IgYWN0dWFsIGhvdCB1bi9wbHVnIG9mIGNwdXMsIHRoZSBhbnN3ZXIgaXMgeWVz
IGR1ZSB0bwo+Pj4+Pj4gZm9yX2VhY2hfcHJlc2VudF9jcHUoKS4gVGhlCj4+Pj4+PiBjYXZlYXQg
aGVyZSBvZiBjb3Vyc2UgaXMgdGhhdCBpZiBjcmFzaCB1dGlsaXR5IGlzIHRoZSBvbmx5Cj4+Pj4+
PiBjb3JlZHVtcCBhbmFseXplciBvZiBjb25jZXJuLAo+Pj4+Pj4gdGhlbiBpdCBkb2Vzbid0IGNh
cmUgYWJvdXQgdGhlc2UgY3B1IFBUX05PVEVzIGFuZCB0aGVyZSB3b3VsZCBiZQo+Pj4+Pj4gbm8g
bmVlZCB0byByZS1nZW5lcmF0ZSB0aGVtLgo+Pj4+Pj4KPj4+Pj4+IEFsc28sIEknbSBub3Qgc3Vy
ZSBpZiBBUk0gY3B1IGhvdHBsdWcsIHdoaWNoIGlzIGp1c3Qgbm93IGNvbWluZwo+Pj4+Pj4gaW50
byBtYWluc3RyZWFtLCBpbXBhY3RzCj4+Pj4+PiBhbnkgb2YgdGhpcy4KPj4+Pj4+Cj4+Pj4+PiBQ
ZXJoYXBzIHRoZSBvbmUgaXRlbSB0aGF0IG1pZ2h0IGhlbHAgaGVyZSBpcyB0byBkaXN0aW5ndWlz
aAo+Pj4+Pj4gYmV0d2VlbiBhY3R1YWwgaG90IHVuL3BsdWcgb2YKPj4+Pj4+IGNwdXMsIHZlcnN1
cyBvbmxpbmluZy9vZmZsaW5pbmcuIEF0IHRoZSBtb21lbnQsIEkgY2FuIG5vdAo+Pj4+Pj4gZGlz
dGluZ3Vpc2ggYmV0d2VlbiBhIGhvdCBwbHVnCj4+Pj4+PiBldmVudCBhbmQgYW4gb25saW5lIGV2
ZW50IChhbmQgdW5wbHVnL29mZmxpbmUpLiBJZiB0aG9zZSB3ZXJlCj4+Pj4+PiBkaXN0aW5ndWlz
aGFibGUsIHRoZW4gd2UKPj4+Pj4+IGNvdWxkIG9ubHkgcmVnZW5lcmF0ZSBvbiB1bi9wbHVnIGV2
ZW50cy4KPj4+Pj4+Cj4+Pj4+PiBPciBwZXJoYXBzIG1vdmluZyB0byBmb3JfZWFjaF9wb3NzaWJs
ZV9jcHUoKSBpcyB0aGUgYmV0dGVyIGNob2ljZT8KPj4+Pj4KPj4+Pj4gWWVzLCBiZWNhdXNlIG9u
Y2UgZWxmY29yZWhkciBpcyBidWlsdCB3aXRoIHBvc3NpYmxlIENQVXMgd2UgZG9uJ3QKPj4+Pj4g
aGF2ZSB0byB3b3JyeSBhYm91dAo+Pj4+PiBob3RbdW5dcGx1ZyBjYXNlLgo+Pj4+Pgo+Pj4+PiBI
ZXJlIGlzIG15IHZpZXcgb24gaG93IHRoaW5ncyBzaG91bGQgYmUgaGFuZGxlZCBpZiBhIGNvcmUt
ZHVtcAo+Pj4+PiBhbmFseXplciBpcyBkZXBlbmRlbnQgb24KPj4+Pj4gZWxmY29yZWhkciBQVF9O
T1RFcyB0byBmaW5kIG9ubGluZS9vZmZsaW5lIENQVXMuCj4+Pj4+Cj4+Pj4+IEEgUFRfTk9URSBp
biBlbGZjb3JlaGRyIGhvbGRzIHRoZSBhZGRyZXNzIG9mIHRoZSBjb3JyZXNwb25kaW5nIGNyYXNo
Cj4+Pj4+IG5vdGVzIChrZXJuZWwgaGFzCj4+Pj4+IG9uZSBjcmFzaCBub3RlIHBlciBDUFUgZm9y
IGV2ZXJ5IHBvc3NpYmxlIENQVSkuIFRob3VnaCB0aGUgY3Jhc2gKPj4+Pj4gbm90ZXMgYXJlIGFs
bG9jYXRlZAo+Pj4+PiBkdXJpbmcgdGhlIGJvb3QgdGltZSB0aGV5IGFyZSBwb3B1bGF0ZWQgd2hl
biB0aGUgc3lzdGVtIGlzIG9uIHRoZQo+Pj4+PiBjcmFzaCBwYXRoLgo+Pj4+Pgo+Pj4+PiBUaGlz
IGlzIGhvdyBjcmFzaCBub3RlcyBhcmUgcG9wdWxhdGVkIG9uIFBvd2VyUEMgYW5kIEkgYW0gZXhw
ZWN0aW5nCj4+Pj4+IGl0IHdvdWxkIGJlIHNvbWV0aGluZwo+Pj4+PiBzaW1pbGFyIG9uIG90aGVy
IGFyY2hpdGVjdHVyZXMgdG9vLgo+Pj4+Pgo+Pj4+PiBUaGUgY3Jhc2hpbmcgQ1BVIHNlbmRzIElQ
SSB0byBldmVyeSBvdGhlciBvbmxpbmUgQ1BVIHdpdGggYSBjYWxsYmFjawo+Pj4+PiBmdW5jdGlv
biB0aGF0IHVwZGF0ZXMgdGhlCj4+Pj4+IGNyYXNoIG5vdGVzIG9mIHRoYXQgc3BlY2lmaWMgQ1BV
LiBPbmNlIHRoZSBJUEkgY29tcGxldGVzIHRoZQo+Pj4+PiBjcmFzaGluZyBDUFUgdXBkYXRlcyBp
dHMgb3duIGNyYXNoCj4+Pj4+IG5vdGUgYW5kIHByb2NlZWRzIGZ1cnRoZXIuCj4+Pj4+Cj4+Pj4+
IFRoZSBjcmFzaCBub3RlcyBvZiBDUFVzIHJlbWFpbiB1bmluaXRpYWxpemVkIGlmIHRoZSBDUFVz
IHdlcmUKPj4+Pj4gb2ZmbGluZSBvciBob3QgdW5wbHVnZ2VkIGF0IHRoZSB0aW1lCj4+Pj4+IHN5
c3RlbSBjcmFzaC4gVGhlIGNvcmUtZHVtcCBhbmFseXplciBzaG91bGQgYmUgYWJsZSB0byBpZGVu
dGlmeQo+Pj4+PiBbdW5dL2luaXRpYWxpemVkIGNyYXNoIG5vdGVzCj4+Pj4+IGFuZCBkaXNwbGF5
IHRoZSBpbmZvcm1hdGlvbiBhY2NvcmRpbmdseS4KPj4+Pj4KPj4+Pj4gVGhvdWdodHM/Cj4+Pj4+
Cj4+Pj4+IC0gU291cmFiaAo+Pj4+Cj4+Pj4gSW4gZ2VuZXJhbCwgSSBhZ3JlZSB3aXRoIHlvdXIg
cG9pbnRzLiBZb3UndmUgcHJlc2VudGVkIGEgc3Ryb25nIAo+Pj4+IGNhc2UgdG8KPj4+PiBnbyB3
aXRoIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSgpIGluIGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVy
cygpIGFuZAo+Pj4+IHRob3NlIGNyYXNoIG5vdGVzIHdvdWxkIGFsd2F5cyBiZSBwcmVzZW50LCBh
bmQgd2UgY2FuIGlnbm9yZSAKPj4+PiBjaGFuZ2VzIHRvCj4+Pj4gY3B1cyB3cnQvIGVsZmNvcmVo
ZHIgdXBkYXRlcy4KPj4+Pgo+Pj4+IEJ1dCB3aGF0IGRvIHdlIGRvIGFib3V0IGtleGVjX2xvYWQo
KSBzeXNjYWxsPyBUaGUgd2F5IHRoZSB1c2Vyc3BhY2UKPj4+PiB1dGlsaXR5IHdvcmtzIGlzIGl0
IGRldGVybWluZXMgY3B1cyBieToKPj4+PiDCoMKgbnJfY3B1cyA9IHN5c2NvbmYoX1NDX05QUk9D
RVNTT1JTX0NPTkYpOwo+Pj4+IHdoaWNoIGlzIG5vdCB0aGUgZXF1aXZhbGVudCBvZiBwb3NzaWJs
ZV9jcHVzLiBTbyB0aGUgY29tcGxldGUgbGlzdCBvZgo+Pj4+IGNwdSBQVF9OT1RFcyBpcyBub3Qg
Z2VuZXJhdGVkIHVwIGZyb250LiBXZSB3b3VsZCBuZWVkIGEgc29sdXRpb24gZm9yCj4+Pj4gdGhh
dD8KPj4+IEhlbGxvIEVyaWMsCj4+Pgo+Pj4gVGhlIHN5c2NvbmYgZG9jdW1lbnQgc2F5cyBfU0Nf
TlBST0NFU1NPUlNfQ09ORiBpcyBwcm9jZXNzb3JzIAo+Pj4gY29uZmlndXJlZCwKPj4+IGlzbid0
IHRoYXQgZXF1aXZhbGVudCB0byBwb3NzaWJsZSBDUFVzPwo+Pj4KPj4+IFdoYXQgZXhhY3RseSBz
eXNjb25mKF9TQ19OUFJPQ0VTU09SU19DT05GKSByZXR1cm5zIG9uIHg4Nj8gSUlVQywgb24gCj4+
PiBwb3dlclBDCj4+PiBpdCBpcyBwb3NzaWJsZSBDUFVzLgo+Pgo+IEJhb3F1YW4sCj4KPj4gwqBG
cm9tIHN5c2NvbmYgbWFuIHBhZ2UsIHdpdGggbXkgdW5kZXJzdGFuZGluZywgX1NDX05QUk9DRVNT
T1JTX0NPTkYgaXMKPj4gcmV0dXJuaW5nIHRoZSBwb3NzaWJsZSBjcHVzLCB3aGlsZSBfU0NfTlBS
T0NFU1NPUlNfT05MTiByZXR1cm5zIHByZXNlbnQKPj4gY3B1cy4gSWYgdGhlc2UgYXJlIHRydWUs
IHdlIGNhbiB1c2UgdGhlbS4KPgo+IFRob21hcyBHbGVpeG5lciBoYXMgcG9pbnRlZCBvdXQgdGhh
dDoKPgo+IMKgZ2xpYmMgdHJpZXMgdG8gZXZhbHVhdGUgdGhhdCBpbiB0aGUgZm9sbG93aW5nIG9y
ZGVyOgo+IMKgIDEpIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSoKPiDCoMKgwqDCoCBUaGF0
J3MgcHJlc2VudCBDUFVzIG5vdCBwb3NzaWJsZSBDUFVzCj4gwqAgMikgL3Byb2Mvc3RhdAo+IMKg
wqDCoMKgIFRoYXQncyBvbmxpbmUgQ1BVcwo+IMKgIDMpIHNjaGVkX2dldGFmZmluaXR5KCkKPiDC
oMKgwqDCoCBUaGF0J3Mgb25saW5lIENQVXMgYXQgYmVzdC4gSW4gdGhlIHdvcnN0IGNhc2UgaXQn
cyBhbiBhZmZpbml0eSBtYXNrCj4gwqDCoMKgwqAgd2hpY2ggaXMgc2V0IG9uIGEgcHJvY2VzcyBn
cm91cAo+Cj4gbWVhbmluZyB0aGF0IF9TQ19OUFJPQ0VTU09SU19DT05GIGlzIG5vdCBlcXVpdmFs
ZW50IHRvIAo+IHBvc3NpYmxlX2NwdXMoKS4gRnVydGhlcm1vcmUsIHRoZSAvc3lzL3N5c3RlbS9k
ZXZpY2VzL2NwdXMvY3B1WFggCj4gZW50cmllcyBhcmUgbm90IGF2YWlsYWJsZSBmb3Igbm90LXBy
ZXNlbnQtYnV0LXBvc3NpYmxlIGNwdXM7IHRodXMgCj4gdXNlcnNwYWNlIGtleGVjIHV0aWxpdHkg
Y2FuIG5vdCB3cml0ZSBvdXQgdGhlIGVsZmNvcmVoZHIgd2l0aCBhbGwgCj4gcG9zc2libGUgY3B1
cyBsaXN0ZWQuCj4KPj4KPj4gQnV0IEkgYW0gd29uZGVyaW5nIHdoeSB0aGUgZXhpc3RpbmcgcHJl
c2VudCBjcHUgd2F5IGlzIGdvaW5nIHRvIGJlCj4+IGRpc2NhcmRlZC4gU29ycnksIEkgdHJpZWQg
dG8gZ28gdGhyb3VnaCB0aGlzIHRocmVhZCwgaXQncyB0b28gbG9uZywgY2FuCj4+IGFueW9uZSBz
dW1tYXJpemUgdGhlIHJlYXNvbiB3aXRoIHNob3J0ZXIgYW5kIGNsZWFyIHNlbnRlbmNlcy4gU29y
cnkKPj4gYWdhaW4gZm9yIHRoYXQuCj4KSGVsbG8gRXJpYywKCj4gQnkgdXRpbGl6aW5nIGZvcl9l
YWNoX3Bvc3NpYmxlX2NwdSgpIGluIGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycygpLCAKPiBp
biB0aGUgY2FzZSBvZiB0aGUga2V4ZWNfZmlsZV9sb2FkKCksIHRoaXMgY2hhbmdlIHdvdWxkIHNp
bXBsaWZ5IHNvbWUgCj4gaXNzdWVzIFNvdXJhYmggaGFzIGVuY291bnRlcmVkIGZvciBQUEMgc3Vw
cG9ydC4KClRoaW5ncyBhcmUgZmluZSBldmVuIHdpdGggZm9yX2VhY2hfcHJlc2VudF9jcHUgb24g
UFBDLiBJdCBpcyBqdXN0IHRoYXQgSSAKd2FudCB0byBhdm9pZAp0aGUgcmVnZW5lcmF0aW9uIG9m
IGVsZmNvcmVoZHIgZm9yIGV2ZXJ5IENQVSBjaGFuZ2UgYnkgcGFja2luZyBwb3NzaWJsZSAKQ1BV
cyBhdCBvbmNlLgoKClRoYW5rcywKU291cmFiaCBKYWluCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
