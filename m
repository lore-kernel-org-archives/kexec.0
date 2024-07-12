Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4993BC2BD09
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rXgftcTfqeWgo5GTHCd2nMd62TlbvRn+L2NkN45tev4=; b=i1KfgZlkZ7Nfpr
	lM6QAHWX4wQGUnCi8yV6PBJ/EL+gbGeN2IMBh/aVWxV0S94TueLqLsglLYGrs1XJFlY6eUBSI7TTe
	2qrtozIka4W67GK3sXjVimm+ZU4N551JfjYY6u9yCLof4VtthQ9ETAkUdGaCLhelZ+M/N7evmh9WP
	9l0o+bQ9bnrhF1XfAj0uydSjhUsNlaOhZzUw5PEV59CY6k+lZEwzoHjfMKMAOgqoOypbRLsTe3rgZ
	lw43WbxVg8puBKN2FM82ZSzDu3uR+GcFHJm82C2+NtedOvkdLxSvCasd46IaaCD3KF4WOLu0gJwUf
	hOFtiu1z3PoaIgJKUU4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSAEB-0000000GhGx-3aA0;
	Fri, 12 Jul 2024 06:57:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSAE7-0000000GhGQ-0DnI
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 06:57:58 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C6vopL024405;
	Fri, 12 Jul 2024 06:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	M7gzbLnnGVnh80CAsF+l/k3aXOGnGr5FYMa/ZtXw5w=; b=oHk5bmR03qPGeYP+L
	B9/GDEejbz0/Dh8fxLQ9OdNyFFDDcdjCvzlPGq1sfLb34p32KRrIV3PtD40bDutu
	tEs1aKy8XT0ub6R6H39opkfqnR9P5jsqR6oFFND54T2i09jfobksZ7qZYIe71eiK
	pjEcvz8oIQt/Bk/JbmMgw2ChH2fH+Yf7tgLUy1Wb3LuDABpn15WuiWdrls/hp95w
	ipCcUS9KBRQGwQj5MLCjRL+Rbuc5Snj8Q53y5CpGCjE1ITv26BeCXZ6Biz2xKtPl
	PkTY68ne8UJ3qfQwGSxjG6heE/BaJv9LHOvgWMcTo+nvzz/k1wsVrdrA7cUrBz+4
	+Fexg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40avm00h7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:57:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C6Wkou024599;
	Fri, 12 Jul 2024 06:54:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrn52k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:54:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46C6sKg156361314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 06:54:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 697EC20049;
	Fri, 12 Jul 2024 06:54:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC1C20040;
	Fri, 12 Jul 2024 06:54:18 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 06:54:18 +0000 (GMT)
Message-ID: <68d0328d-531a-4a2b-ab26-c97fd8a12e8b@linux.ibm.com>
Date: Fri, 12 Jul 2024 12:24:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <petr@tesarici.cz>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
 <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
 <20240712082124.272e079f@meshulam.tesarici.cz>
 <06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
 <20240712084826.3128cba2@mordecai.tesarici.cz>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240712084826.3128cba2@mordecai.tesarici.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iqj4ZjiX9l0jMc1WGu3CVHFw32yDLriF
X-Proofpoint-GUID: Iqj4ZjiX9l0jMc1WGu3CVHFw32yDLriF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_04,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=682
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_235757_161790_F2FECBFA 
X-CRM114-Status: GOOD (  16.38  )
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

CgpPbiAxMi8wNy8yNCAxMjoxOCwgUGV0ciBUZXNhcmlrIHdyb3RlOgo+IE9uIEZyaSwgMTIgSnVs
IDIwMjQgMTI6MDE6MjkgKzA1MzAKPiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4Lmli
bS5jb20+IHdyb3RlOgo+Cj4+IEhlbGxvIFBldHIsCj4+Cj4+IE9uIDEyLzA3LzI0IDExOjUxLCBQ
ZXRyIFRlc2HFmcOtayB3cm90ZToKPj4+IE9uIEZyaSwgMTIgSnVsIDIwMjQgMTA6MDA6MDkgKzA1
MzAKPj4+IFNvdXJhYmggSmFpbiA8c291cmFiaGphaW5AbGludXguaWJtLmNvbT4gd3JvdGU6Cj4+
PiAgIAo+Pj4+IEhlbGxvIFBldHIsCj4+Pj4KPj4+PiBKdXN0IHdhbnQgdG8gbWVudGlvbmVkIGZl
dyBwb2ludHMgYWJvdXQgdGhlIGNvbW1pdCBtZXNzYWdlLiBObyBzdHJvbmcKPj4+PiBvcGluaW9u
IG9uIGNoYW5naW5nIHRoZSBjb21taXQgbWVzc2FnZS4KPj4+Pgo+Pj4+IE9uIDExLzA3LzI0IDE2
OjA0LCBQZXRyIFRlc2FyaWsgd3JvdGU6Cj4+Pj4+IEZyb206IFBldHIgVGVzYXJpayA8cHRlc2Fy
aWtAc3VzZS5jb20+Cj4+Pj4+Cj4+Pj4+IFRoZXJlIGlzIG5vIHJlYXNvbiB0byByZXN0cmljdCBh
Y2Nlc3MgdG8gdGhpcyBhdHRyaWJ1dGUsIGFzIGl0IG1lcmVseQo+Pj4+PiByZXBvcnRzIHdoZXRo
ZXIgY3Jhc2ggZWxmY29yZWhkciBpcyBhdXRvbWF0aWNhbGx5IHVwZGF0ZWQgb24gQ1BVIGhvdAo+
Pj4+PiBwbHVnL3VucGx1ZyBhbmQvb3Igb25saW5lL29mZmxpbmUgZXZlbnRzLgo+Pj4+IE5vdywg
aXQgaXMgbm90IGp1c3QgZWxmY29yZWhkcjsgdGhlcmUgY291bGQgYmUgbXVsdGlwbGUga2V4ZWMg
c2VnbWVudHMKPj4+PiBiYXNlZCBvbiB0aGUgYXJjaGl0ZWN0dXJlJ3MgbmVlZHMuCj4+Pj4gRm9y
IGV4YW1wbGUsIG9uIFBvd2VyUEMsIGl0IGlzIGVsZmNvcmVoZHIgYW5kIEZEVC4KPj4+IFJpZ2h0
LiBJIGFtIGV2ZW4gd29ya2luZyB3aXRoIGEgUG93ZXJWTSBMUEFSIG9uIGFuIEw5MjIgc3lzdGVt
IG5vdy4gOy0pCj4+Pgo+Pj4gT1RPSCBJIHdhcyBqdXN0IHRvbyBsYXp5IHRvIGludmVudCBteSBv
d24gZGVzY3JpcHRpb24sIHNvIEkgdG9vayBpdAo+Pj4gZnJvbSBEb2N1bWVudGF0aW9uL0FCSS90
ZXN0aW5nL3N5c2ZzLWRldmljZXMtc3lzdGVtLWNwdS4gVGhhdCBvbmUKPj4+IGNvdWxkIGJlIGlt
cHJvdmVkLiBBbmQgYSBjb3VwbGUgb2Ygb3RoZXIgcGxhY2VzLi4uIEV4cGVjdCBhIHBhdGNoLgo+
PiBUaGFua3MgZm9yIHBvaW50IGl0IG91dCwgSSB3aWxsIHNlbmQgYSBwYXRjaCB0byBmaXggdGhl
IEFCSSBkb2N1bWVudCBmb3IKPj4gY3Jhc2hfaG90cGx1ZyBhbmQgb3RoZXIgcGxhY2VzIGluIHRo
ZSBrZXJuZWwuIFRoYW5rcywKPiBPaCwgSSB3YXMgcGxhbm5pbmcgdG8gZG8gdGhhdCwgYnV0IGlm
IHlvdSB3YW50IHRvIHNlbmQgYSBwYXRjaAo+IHlvdXJzZWxmLCBJIHdvbid0IGR1cGxpY2F0ZSBl
ZmZvcnRzLiBUaGVyZSBhcmUgb3RoZXIgY2xlYW51cHMgb24gbXkKPiBUT0RPIGxpc3QuCgpZZXMs
IEkgd2lsbCB0YWtlIGNhcmUgb2YgdGhpcy4KClRoYW5rcywKU291cmFiaCBKYWluCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
