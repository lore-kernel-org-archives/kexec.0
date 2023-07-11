Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6526EB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b5umknS1QldLwXqYSWV3UqqjkQkpwuPSXCQHg6HW2+0=; b=zPOQMJYhz+elS3
	G4DhRHm/lrXcC7HIerprnJ49AJiq4sbE2VHhFGnHBqUKxC6y+TK7thp0BfTh+HfnhY5GabvGqWrhc
	UGmbDnofo/kTWNBprHbKt4ocvBOxAeySiWjWd/oGBSnPHJnqiK+BQg6sdlNQXprRQfbzeEU31mCRk
	JpWPe7+dvpy7aQAlYyKmF0iQy/labCvrRTBDHD2z6zrA6y9wVLU5sELs+mcP+em/61ZsOHFeQ4obt
	qJVu7XV7Sa+X5Hn7bJvoDOEKH4+T6IdvQcvfXVssJG0A/qFkC8S/cFtYO1KkQIAjNa0SIBJNxWH/b
	weZ/J4NcXiMNVVBNEhKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJKeX-00FtsD-0t;
	Tue, 11 Jul 2023 21:12:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJKeU-00Ftrd-1F
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 21:12:08 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BL9jW1002442;
	Tue, 11 Jul 2023 21:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/jbmUM/Tz5PwYQ7xibcV54GFdtSsVEw7ymNllB0dx7E=;
 b=sNxzswunyHLLzZnCfQZdMcKPULi7FTMBca+QNXlM+j9G7dL/udJSddAvioNRPMlslYXU
 sjb9K8fwYmhCffM03mXg7QPxxdD+E+2xdgJjdEoKAccUbLZwUWV0w2JI17hZxZIo+Ujr
 Lj0EJhR6DKalQKZALXq/xEjnVH4OyDQV0whw9kz6qtmuQ5Za9QGI02u6bUYodrrwvuMt
 fVLB9cTT+yUPVzAVnCpASGAHTEwb49Xrf6uxWYB93fdi3tMIGHj+BT+8/nLj8kRvdp2t
 Ywv0RnKaMSl8YecZolTRdq/y/VewWk0sx/KuZpiBwvsq/uCQA5SG1UPKlBdx49YnJzMS Ow== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rseg8gaak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jul 2023 21:11:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEGJs7011647;
	Tue, 11 Jul 2023 21:11:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqk4mgjbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jul 2023 21:11:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BLBosr34734376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jul 2023 21:11:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52D9258058;
	Tue, 11 Jul 2023 21:11:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B5F58057;
	Tue, 11 Jul 2023 21:11:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.33])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Jul 2023 21:11:49 +0000 (GMT)
Message-ID: <66ca5d5504291161d887d141bc43ce2a4c14ff8c.camel@linux.ibm.com>
Subject: Re: [PATCH 01/10] ima: implement function to allocate buffer at
 kexec load
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric
	Biederman <ebiederm@xmission.com>
Date: Tue, 11 Jul 2023 17:11:47 -0400
In-Reply-To: <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
	 <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
	 <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
	 <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ajjQURlfE6K12wP7zNJ6D7w-6WsYI88s
X-Proofpoint-ORIG-GUID: ajjQURlfE6K12wP7zNJ6D7w-6WsYI88s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 mlxlogscore=967 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307110191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_141206_726546_66A63AD3 
X-CRM114-Status: GOOD (  30.15  )
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

T24gVHVlLCAyMDIzLTA3LTExIGF0IDEwOjU5IC0wNzAwLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6
Cj4gQWRkaW5nIEVyaWMgdG8gY2MuCj4gCj4gT24gNy83LzIzIDA2OjAwLCBNaW1pIFpvaGFyIHdy
b3RlOgo+ID4gSGkgVHVzaGFyLAo+ID4KPiA+IE9uIE1vbiwgMjAyMy0wNy0wMyBhdCAxNDo1NyAt
MDcwMCwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+ID4+IElNQSBkb2VzIG5vdCBwcm92aWRlIGEg
bWVjaGFuaXNtIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3IgSU1BIGxvZyBzdG9yYWdlCj4gPj4gZHVy
aW5nIGtleGVjIG9wZXJhdGlvbi4KPiA+IFRoZSBJTUEgbWVhc3VyZW1lbnQgbGlzdCBpcyBjdXJy
ZW50bHkgYmVpbmcgY2FycmllZCBhY3Jvc3Mga2V4ZWMsIHNvCj4gPiBvYnZpb3VzbHkgYSBidWZm
ZXIgaXMgYmVpbmcgYWxsb2NhdGVkIGZvciBpdC4gIElNQSBub3QgYWxsb2NhdGluZwo+ID4gbWVt
b3J5IGZvciB0aGUgbWVhc3VybWVudCBsaXN0IGlzIG5vdCB0aGUgcHJvYmxlbSBzdGF0ZW1lbnQu
ICBQbGVhc2UKPiA+IGNvbmNpc2VseSBwcm92aWRlIHRoZSBwcm9ibGVtIHN0YXRlbWVudCwgZXhw
bGFpbmluZyB3aHkgSU1BIG5lZWRzIHRvCj4gPiBhbGxvY2F0ZSB0aGUgYnVmZmVyLgo+ID4KPiBJ
IG1lYW50IElNQSBkb2VzIG5vdCBwcm92aWRlIHNlcGFyYXRlIGZ1bmN0aW9ucyB0byBhbGxvY2F0
ZSBidWZmZXIgYW5kCj4gcG9wdWxhdGUgbWVhc3VyZW1lbnRzLiAgQm90aCBvcGVyYXRpb25zIGFy
ZSB3cmFwcGVkIGluIGFuIGF0b21pYwo+IGltYV9kdW1wX21lYXN1cmVtZW50X2xpc3QoKS4KCk9r
LgoKPiBBcyBJIG1lbnRpb25lZCBpbiB0aGUgY29tbWVudCBpbiB0aGUgY292ZXIgbGV0dGVyLCBp
ZiB0aGVyZSBpcyBubyBzdWNoCj4gdGVjaG5pY2FsIGxpbWl0YXRpb24gdG8gYWxsb2NhdGUgdGhl
IGJ1ZmZlciBhbmQgY29weSB0aGUgbWVhc3VyZW1lbnRzIGF0Cj4ga2V4ZWMg4oCYZXhlY3V0ZeKA
mSDigJMgSSB3aWxsIG1ha2UgdGhlIG5lY2Vzc2FyeSBjb2RlIGNoYW5nZXMgYW5kIHVwZGF0ZSB0
aGUKPiBhYm92ZSBsaW5lIGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBhY2NvcmRpbmdseS4KClRo
ZSAibm9ybWFsIiB3YXkgb2YgbWFraW5nIHRoaXMgdHlwZSBvZiBjaGFuZ2Ugd291bGQgYmUgdG8g
c3BsaXQgdGhlCmV4aXN0aW5nIGltYV9kdW1wX21lYXN1cmVtZW50X2xpc3QoKSBmdW5jdGlvbi4g
IENvcHlpbmcgdGhlIG1lYXN1cmVtZW50Cmxpc3Qgd291bGQgc3RpbGwgYmUgbmFtZWQgaW1hX2R1
bXBfbWVhc3VyZW1lbnRfbGlzdCgpLiAgVGhlIG90aGVyIGNvdWxkCmJlIG5hbWVkIGltYV9hbGxv
Y19rZXhlY19idWYoKS4gIEJvdGggZnVuY3Rpb25zIGluaXRpYWxseSB3b3VsZCBiZQpjYWxsZWQu
CgpFcmljLCBiZXNpZGVzIHVwZGF0aW5nIHRoZSBidWZmZXIgYXQga2V4ZWMgZXhlY3V0ZSwgaXMg
dGhlcmUgYW55dGhpbmcKZWxzZSB0aGF0IG5lZWRzIHRvIGJlIGRvbmUgKGUuZy4gdXBkYXRpbmcg
ZGlnZXN0cyk/Cgo+ID4+IFRoZSBmdW5jdGlvbiBzaG91bGQgaGFuZGxlIHRoZSBzY2VuYXJpbyB3
aGVyZQo+ID4+IHRoZSBrZXhlYyBsb2FkIGlzIGNhbGxlZCBtdWx0aXBsZSB0aW1lcy4KPiA+IEN1
cnJlbnRseSB0aGUgYnVmZmVyIGlzIGJlaW5nIGZyZWVkIHdpdGggdGhlIGtleGVjICd1bmxvYWQn
LiAgV2l0aCB0aGlzCj4gPiBwYXRjaCBJTUEgaXMgYWxsb2NhdGluZyBhIGJ1ZmZlciBmb3IgdGhl
IG1lYXN1cmVtZW50IGxpc3QsIHdoaWNoIG5lZWRzCj4gPiB0byBiZSBmcmVlZCBpbmRlcGVuZGVu
dGx5IG9mIHRoZSBrZXhlYyAndW5sb2FkJy4KCj4gSWYgd2UgZW5kIHVwIGFsbG9jYXRpbmcgdGhl
IGJ1ZmZlciBhdCBrZXhlYyDigJhleGVjdXRl4oCZICh3aGljaCByZXN1bHRzIGluCj4gc29mdCBi
b290IHRvIG5leHQgS2VybmVsKSDigJMgaXMgaXQgdGVjaG5pY2FsbHkgcG9zc2libGUgdGhhdAo+
IGtleGVjIOKAmHVubG9hZOKAmSBiZWluZyBjYWxsZWQgYWZ0ZXIgY2FsbGluZyBrZXhlYyDigJhl
eGVjdXRl4oCZPwoKPiBJZiBub3QsIHNob3VsZCBJIHN0aWxsIGZyZWUgdGhlIGJ1ZmZlciBhdCBr
ZXhlYyDigJh1bmxvYWTigJkgaW4gdGhpcwo+IHNjZW5hcmlvPwoKVGhlIHF1ZXN0aW9uIGlzIGhv
dyB0byBhY2Nlc3MgdGhlIGJ1ZmZlciBvbmNlIGtleGVjX2FkZF9idWZmZXIoKSBpcwpjYWxsZWQu
CgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
