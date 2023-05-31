Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B7EC7EE23
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HJvOS5YEQ0s+T+qbggu786leRMSu+66od1d0leVcztE=; b=Jn3QpwZoMw79ae
	rAlHeSX3R7EqC4fWaX0i2zNfNzWOm/btGK4ttnI/SSAHMazLvWtwraNNzQe/lU5r+GHPaqTf+0wt7
	RCkBt1ukN6husPA4Ecs+6DEGQecMpOfgKl2buBVWo5kGOVOxjX0t57+DSMe3IT4MbmoQHCWyp52dx
	PfI3z9F2T/3Iuw+pG0FJTRArU4TlmhFlCTk4WtJ21GiOBNKsPpYLLYHU+wsXuyz7mNkzMsNF/pv6h
	1YCohDG3RlVvGyrjb5Ivy1mF0AeSPBzDfJ/dOR2DNmr5tUTPUxkoslVEpW1JyLo8T6jY43QbVFP3k
	lQzkinXNhLo6oJOJg2xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UYB-001N5a-1C;
	Wed, 31 May 2023 22:44:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UY7-001Mzk-1Q
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 22:44:13 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VMcZAl022574;
	Wed, 31 May 2023 22:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PjVB4V5KmDB8lsfGN3zFzOQHXrHxrw6zC+HWPORI3sE=;
 b=moyOfA5iKj9WNwO9wyqOB6vejN/j3qa2nX5CNHrH8LeMvwcwXXwSTy6kOp3kPuVEeKHw
 zhWD2gtvbsUxKn3NlvVcFsCDXyFZTNW25TryCMaoey/LorxaX6BzkGED7ebExwctYP0G
 1zLY0C95q9vTjnna9vLzMvPLm39PzgQLSi94HnHv+dOAOMGT7tJ5D0thocFNRrqA7NdZ
 01FI7REnxv+1mHas0Ec0UpoktTFUQUF1sE83/jvSqSMGzL18IJhl8U3hN4GGaYHf1H4P
 N6FsASgbS6JmiWLGPtxXwH9MtHulCwTLrbXwOWEJt2c3xBkuP5IVMTpJOqHBZ4zAx4xp PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxegnh2gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 22:43:58 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VMdLaf026689;
	Wed, 31 May 2023 22:43:58 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxegnh2gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 22:43:58 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLjErF019428;
	Wed, 31 May 2023 22:43:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3qu9g6sydd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 22:43:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34VMhtkB4981310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 22:43:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF60A58053;
	Wed, 31 May 2023 22:43:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3CF25805F;
	Wed, 31 May 2023 22:43:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.53.77])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 May 2023 22:43:54 +0000 (GMT)
Message-ID: <8308a411a50a1168aa5a1a0d70138b29cea73914.camel@linux.ibm.com>
Subject: Re: need help: patches to capture events between kexec load and
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Jonathan McDowell
	 <noodles@fb.com>, bauermann@kolabnow.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Alasdair G
 Kergon <agk@redhat.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, code@tyhicks.com
Date: Wed, 31 May 2023 18:43:54 -0400
In-Reply-To: <41270374-dc5e-3aa2-d2ed-9b8fc73ad65f@linux.microsoft.com>
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
	 <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
	 <87775c1e-d1d3-519c-599b-30cdb1691cb2@linux.microsoft.com>
	 <4eff26f794254c1f06ace12e68527fd3452ac47d.camel@linux.ibm.com>
	 <41270374-dc5e-3aa2-d2ed-9b8fc73ad65f@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CV_Oq2aiLFG7xGTH97I4fPYanXsv60BQ
X-Proofpoint-GUID: 1GAmHsKCCHXyMvfXT1TZYUMD3Vanscr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=758 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310190
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_154411_731276_7F1F6209 
X-CRM114-Status: GOOD (  37.68  )
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

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDE1OjAyIC0wNzAwLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6
Cj4gSGkgTWltaSwKPiAKPiBPbiA1LzMxLzIzIDA0OjM5LCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4g
SGkgVHVzaGFyLAo+ID4KPiA+IE9uIFRodSwgMjAyMy0wNS0yNSBhdCAxMDoyMSAtMDcwMCwgVHVz
aGFyIFN1Z2FuZGhpIHdyb3RlOgo+ID4KPiA+PiBUaGUgaXNzdWUgb2YgSU1BIG1lYXN1cmVtZW50
cyBnZXR0aW5nIGxvc3QgYmV0d2VlbiBrZXhlYyAnbG9hZCcgYW5kICdleGVjdXRlJyBzdGlsbCBl
eGlzdHMuCj4gPj4gSSB2ZXJpZmllZCBpdCBvbiB0aGUgbWFpbmxpbmUga2VybmVsIDYuNC5yYzMu
IFNlZSAqQXBwZW5kaXggQSogZm9yIGRldGFpbHMuCj4gPj4KPiA+PiBJIHdlbnQgdGhyb3VnaCBU
aGlhZ28ncyBwYXRjaGVzIGhlIHdyb3RlIHNldmVyYWwgeWVhcnMgYWdvLCBhbmQgdHJpZWQgdG8g
ZGV2ZWxvcCBhIHNvbHV0aW9uLgo+ID4+Cj4gPj4gSSB3YXMgZmFjaW5nIHNvbWUgaXNzdWVzIHdp
dGggcGh5c2ljYWwgdG8gdmlydHVhbCBhZGRyZXNzIHRyYW5zbGF0aW9uLgo+ID4+IE9uZSBvZiBt
eSBjby13b3JrZXIgYXQgTWljcm9zb2Z0IGhlbHBlZCBteSByZS13cml0ZSB0aGUgbG9naWMgd2hp
Y2ggc2VlbXMgdG8gYmUgd29ya2luZy4KPiA+PiBTZWUgdGhlIGF0dGFjaGVkIHBhdGNoIGFuZCAq
QXBwZW5kaXggQiogZm9yIGRldGFpbHMuCj4gPj4KPiA+PiBUaGUgYmFzaWMgZnVuY3Rpb25hbGl0
eSBpcyB3b3JraW5nLiBJIG5lZWQgdG8gcG9saXNoIHRoZSBjb2RlLCBhbmQgaGFuZGxlIGVycm9y
IHBhdGhzIGluIGEgYmV0dGVyIHdheS4KPiA+PiBCdXQgYmVmb3JlIGRvaW5nIHRoYXQsIEkgbmVl
ZCB5b3VyIGZlZWRiYWNrIG9uIHRoZSBmdW5kYW1lbnRhbCBhcHByb2FjaC4KPiA+PiBTaW5jZSBJ
IGFtIG5vdCBhIGtleGVjIGV4cGVydCwgaXTigJlkIGJlIGdyZWF0IGlmIEkgY291bGQgZ2V0IGhl
bHAgd2l0aCB0aGUgY29kZSByZXZpZXcKPiA+PiBhbmQgYWxzbyBzdWdnZXN0aW9ucyBvbiBzY2Vu
YXJpb3MgdG8gdGVzdCB0byB2YWxpZGF0ZSB0aGUgcGF0Y2ggdGhvcm91Z2hseS4KPiA+PiBMZXQg
bWUga25vdyBpZiBJIHNob3VsZCBmaXJzdCBwb3N0IHRoZSBwYXRjaCBhcyBSRkMgb24gcHVibGlj
IGZvcnVtcyBmb3IgdGhhdC4KPiA+IFRoYW5rcywgVHVzaGFyLiAgIE1lYXN1cmVtZW50cyBjYW4g
YW5kIGFyZSBjdXJyZW50bHkgYmVpbmcgYWRkZWQgdG8gdGhlCj4gPiBJTUEgbWVhc3VyZW1lbnQg
bGlzdCBiZXR3ZWVuIGtleGVjIGxvYWQgYW5kIGV4ZWN1dGUsIGJ1dCBhcmUgbm90IGJlaW5nCj4g
PiBjYXJyaWVkIGFjcm9zcyBrZXhlYy4gIFRoZXNlIG1lYXN1cmVtZW50cyBhbHNvIGV4dGVuZCB0
aGUgVFBNLiAgQWZ0ZXIKPiA+IHRoZSBzb2Z0IHJlYm9vdCwgd2l0aG91dCB0aGVzZSBhZGRpdGlv
bmFsIG1lYXN1cmVtZW50cyB0aGUgSU1BCj4gPiBtZWFzdXJlbWVudCBsaXN0IGNhbm5vdCBiZSB2
ZXJpZmllZCBhZ2FpbnN0IHRoZSBUUE0gUENScy4KPiBZdXAuIElNQSBtZWFzdXJlbWVudCBsaXN0
IGdvZXMgb3V0IG9mIHN5bmMgd2l0aCBUUE0gUENScyBhZnRlciB0aGUgc29mdCAKPiByZWJvb3Qu
Cj4gU28gdGhlIG1lYXN1cmVtZW50IGxpc3QgY2Fubm90IGJlIHZlcmlmaWVkIGFnYWluc3QgUENS
cy4gVGhhdCdzIHRoZSBpc3N1ZS4KPiBUaGFua3MgZm9yIGFja25vd2xlZGdpbmcgaXQuCj4gPiBZ
b3VyIHByb3Bvc2VkIHBhdGNoLCBsaWtlIFRoaWFnbydzLCBzYXZlZCB0aGUgZW50aXJlIElNQSBt
ZWFzdXJlbWVudAo+ID4gbGlzdCBhZ2Fpbi4gIEFzc3VtaW5nIHRoZSBidWZmZXIgc2l6ZSBjYW4n
dCBjaGFuZ2UgYmV0d2VlbiBrZXhlYyBsb2FkCj4gPiBhbmQgZXhlY3V0ZSwgYXMgcGVyIHRoZSBj
b21tZW50LCB3aHkgbm90IGp1c3QgYWxsb2NhdGUgdGhlIGJ1ZmZlciBvbgo+ID4ga2V4ZWMgbG9h
ZCBhbmQgZmlsbCBpdCBvbiBrZXhlYyBleGVjPwo+ID4KPiA+IFRvIHNpbXVsYXRlIHRoZSBleGlz
dGluZyBiZWhhdmlvciwgZmlsbCB0aGUgYnVmZmVyIHdpdGggYXMgbWFueQo+ID4gY29tcGxldGUg
bWVhc3VyZW1lbnQgcmVjb3JkcyBhcyB0aGUgYnVmZmVyIHdpbGwgaG9sZC4KCgo+IEkgd2FzIHVu
ZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgSSB3YXMgZG9pbmcgdGhlIHNhbWUuIGkuZS4gYWxsb2Nh
dGUgYXQgCj4gJ2xvYWQnIGFuZCBmaWxsIG9uICdleGVjdXRlJy4KPiBCdXQgSSByZWFsaXplZCB0
aGF0IGluIG15IHBhdGNoIGltYV9kdW1wX21lYXN1cmVtZW50X2xpc3QoKSBnZXRzIGNhbGxlZCAK
PiB0d2ljZSAtIG9uY2UgYXQgJ2xvYWQnIGFuZCBvbmNlIGF0ICdleGVjdXRlJy4KPiBJcyB0aGF0
IHdoYXQgeW91IG1lYW50IGJ5ICJteSBwYXRjaCBzYXZlZCB0aGUgZW50aXJlIElNQSBtZWFzdXJl
bWVudCAKPiBsaXN0IGFnYWluIiA/CgpFeGFjdGx5LCB0aGVyZSdzIG5vIG5lZWQgZm9yIGNvcHlp
bmcgdGhlIG1lYXN1cmVtZW50IGxpc3QgdHdpY2UuICBUaGUKZmlyc3QgTiBudW1iZXIgb2YgbWVh
c3VyZW1lbnRzIGhhdmVuJ3QgY2hhbmdlZC4KCj4gaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgp
IGNhbGxzIHZtYWxsb2MsIG1lbXNldCwgYW5kIG1lbWNweS4KPiBTbyB0aGVyZSBpcyBkZWZpbml0
ZWx5IHNvbWUgcmVkdW5kYW5jeS4gTGV0IG1lIHNlZSBob3cgY2FuIEkgb3B0aW1pemUgaXQuCgpQ
bGVhc2UgbG9vayBhdCBteSBzdWdnZXN0aW9uLgoKPiBBdHRhY2hpbmcgbXkgb3JpZ2luYWwgcGF0
Y2ggYWdhaW4gZm9yIHJlZmVyZW5jZS4KClBhdGNoZXMgc2hvdWxkIGJlIHBvc3RlZCBpbmxpbmUu
ICBQbGVhc2UgZG9uJ3QgZG8gdGhpcy4KCi0tIAp0aGFua3MsCgpNaW1pCgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
