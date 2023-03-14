Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3072C74A5B
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 03:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:To:Subject:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RQPFkZqPdctu0OsR6+/3r23EgmA+pEWHij/RNxEa6w=; b=yl4ODmkloLzaNxy1INghBKUBOu
	FPVXUvefEb5rGtI2wndW0j2QJEbyL0NAgofanu9bM2hNG4Fb7tgKS6fgKcprGG5XxLcWruj3Aak1S
	7Oe2Dxa52SZzRpwtAbaiOUy6/eKnV9b90/vFxRBZH5Wnsb2YWbg6Otp7P/RcZY0N/xyM6X0wpiBbe
	A7titTE5eL3MatvH+0m4u2izlgzVhclR6CIW6sLKJ5hRpwX6rU8698flGeTCCoaVv5fydUVBmhxDH
	nRgj2/GDVpXPZe6W8CGLOyqc6a2xw8zrWxyhD++yE5kColAaGKJMwAPSa6mfK/ZoGaS+VSH47amCM
	JfOPGuOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbvUi-008sSg-4P; Tue, 14 Mar 2023 03:38:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbvUb-008sPs-MQ
	for kexec@lists.infradead.org; Tue, 14 Mar 2023 03:38:31 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E2kFcF001771;
	Tue, 14 Mar 2023 03:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FcbiC4dTFuB4GN/274JM92cXLby8h3uZleY3j+53RNM=;
 b=EjNxRmn9secllLbdKGwhwfVSzVms0u6xRouQ7g6F9yUASUBB7zp+R3VsYVWLHCdfanvG
 WpJCUj+wQRPlGLpyR4dkbBgGIuNFHN7AUbYa8t5QvNxpBJ5J+wUlyFso5thNQ5yvcIQ0
 XW9QqljURvI+MQ5KmjV2McUgrvwaDafI7hHnBQNCtT9CAvzRW9gu9fd/zdJlS5EhuSmS
 22Q31MgA1s3BVxsj1GNh1ce6y1rmY8rel8EySKPyq/UmZrJn6BL6OcFKV72JpDNXPJqR
 yu8HByq4aeBrNktFBNKrLPz7R2Ou5l/iRlIMNDPaTdJjLv9QA1cvPFt6fT5xVtkannjp 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3padrgmkde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 03:38:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E3ZX4m023228;
	Tue, 14 Mar 2023 03:38:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3padrgmkd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 03:38:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DEv0sV030084;
	Tue, 14 Mar 2023 03:38:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfc71a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 03:38:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32E3cBa057147854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Mar 2023 03:38:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782D82004B;
	Tue, 14 Mar 2023 03:38:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BB3620040;
	Tue, 14 Mar 2023 03:38:09 +0000 (GMT)
Received: from [9.43.46.246] (unknown [9.43.46.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Mar 2023 03:38:09 +0000 (GMT)
Message-ID: <5aa8fb1c-73a0-4cb2-daac-9e9f40289253@linux.ibm.com>
Date: Tue, 14 Mar 2023 09:08:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 0/6] PowerPC: in kernel handling of CPU hotplug events
 for crash kernel
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linuxppc-dev@ozlabs.org
References: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
 <ccf3a98d-60b6-a7db-c218-84b4eff69c1b@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ccf3a98d-60b6-a7db-c218-84b4eff69c1b@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v-AkdHlp4M4vU-lMhapOQm5NR5GchWh_
X-Proofpoint-GUID: ukwUPUnh7DdH0cZZf9Kg-HpXauTm8Ujf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_203830_019095_1D913107 
X-CRM114-Status: GOOD (  32.87  )
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
Cc: bhe@redhat.com, kexec@lists.infradead.org, mpe@ellerman.id.au, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGVsbG8gRXJpYywKCk9uIDEzLzAzLzIzIDIxOjEyLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4K
PiBPbiAzLzEyLzIzIDEzOjExLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+IFRoZSBQcm9ibGVtOgo+
PiA9PT09PT09PT09PT0KPj4gUG9zdCBob3RwbHVnL0RMUEFSIGV2ZW50cyB0aGUgY2FwdHVyZSBr
ZXJuZWwgaG9sZHMgc3RhbGUgaW5mb3JtYXRpb24gCj4+IGFib3V0IHRoZQo+PiBzeXN0ZW0uIER1
bXAgY29sbGVjdGlvbiB3aXRoIHN0YWxlIGNhcHR1cmUga2VybmVsIG1pZ2h0IGVuZCB1cCBpbiAK
Pj4gZHVtcCBjYXB0dXJlCj4+IGZhaWx1cmUgb3IgYW4gaW5hY2N1cmF0ZSBkdW1wIGNvbGxlY3Rp
b24uCj4+Cj4+IEV4aXN0aW5nIHNvbHV0aW9uOgo+PiA9PT09PT09PT09PT09PT09PT0KPj4gVGhl
IGV4aXN0aW5nIHNvbHV0aW9uIHRvIGtlZXAgdGhlIGNhcHR1cmUga2VybmVsIHVwLXRvLWRhdGUg
YnkgCj4+IG1vbml0b3JpbmcKPj4gaG90cGx1ZyBldmVudCB2aWEgdWRldiBydWxlIGFuZCB0cmln
Z2VyIGEgZnVsbCBjYXB0dXJlIGtlcm5lbCByZWxvYWQgZm9yCj4+IGV2ZXJ5IGhvdHBsdWcgZXZl
bnQuCj4+Cj4+IFNob3J0Y29taW5nczoKPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4+IC0gTGVhdmVzIGEgd2luZG93IHdoZXJlIGtlcm5lbCBjcmFz
aCBtaWdodCBub3QgbGVhZCB0byBhIHN1Y2Nlc3NmdWwgZHVtcAo+PiDCoMKgIGNvbGxlY3Rpb24u
Cj4+IC0gUmVsb2FkaW5nIGFsbCBrZXhlYyBjb21wb25lbnRzIGZvciBlYWNoIGhvdHBsdWcgaXMg
aW5lZmZpY2llbnQuCj4+IC0gdWRldiBydWxlcyBhcmUgcHJvbmUgdG8gcmFjZXMgaWYgaG90cGx1
ZyBldmVudHMgYXJlIGZyZXF1ZW50Lgo+Pgo+PiBNb3JlIGFib3V0IGlzc3VlcyB3aXRoIGFuIGV4
aXN0aW5nIHNvbHV0aW9uIGlzIHBvc3RlZCBoZXJlOgo+PiDCoCAtIGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDIwLzEyLzE0LzUzMgo+PiDCoCAtIAo+PiBodHRwczovL2xpc3RzLm96bGFicy5vcmcv
cGlwZXJtYWlsL2xpbnV4cHBjLWRldi8yMDIyLUZlYnJ1YXJ5LzI0MDI1NC5odG1sCj4+Cj4+IFBy
b3Bvc2VkIFNvbHV0aW9uOgo+PiA9PT09PT09PT09PT09PT09PT0KPj4gSW5zdGVhZCBvZiByZWxv
YWRpbmcgYWxsIGtleGVjIHNlZ21lbnRzIG9uIGhvdHBsdWcgZXZlbnQsIHRoaXMgcGF0Y2ggCj4+
IHNlcmllcwo+PiBmb2N1c2VzIG9uIHVwZGF0aW5nIG9ubHkgdGhlIHJlbGV2YW50IGtleGVjIHNl
Z21lbnQuIE9uY2UgdGhlIGtleGVjIAo+PiBzZWdtZW50cwo+PiBhcmUgbG9hZGVkIGluIHRoZSBr
ZXJuZWwgcmVzZXJ2ZWQgYXJlYSB0aGVuIGFuIGFyY2gtc3BlY2lmaWMgaG90cGx1ZyAKPj4gaGFu
ZGxlcgo+PiB3aWxsIHVwZGF0ZSB0aGUgcmVsZXZhbnQga2V4ZWMgc2VnbWVudCBiYXNlZCBvbiBo
b3RwbHVnIGV2ZW50IHR5cGUuCj4+Cj4+IFNlcmllcyBEZXBlbmRlY2llcwo+PiA9PT09PT09PT09
PT09PT09PT0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyB0aGUgY3Jhc2ggaG90cGx1
ZyBoYW5kbGVyIG9uIFBvd2VyUEMuIAo+PiBUaGUgZ2VuZXJpYwo+PiBjcmFzaCBob3RwbHVnIHVw
ZGF0ZSBpcyBpbnRyb2R1Y2VkIGJ5IAo+PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMy8zLzYv
MTM1OCBwYXRjaAo+PiBzZXJpZXMuCj4+Cj4+IEdpdCB0cmVlIGZvciB0ZXN0aW5nOgo+PiA9PT09
PT09PT09PT09PT09PT09PT0KPj4gVGhlIGJlbG93IGdpdCB0cmVlIGhhcyB0aGlzIHBhdGNoIHNl
cmllcyBhcHBsaWVkIG9uIHRvcCBvZiBkZXBlbmRlbnQgCj4+IHBhdGNoCj4+IHNlcmllcy4KPj4g
aHR0cHM6Ly9naXRodWIuY29tL3NvdXJhYmhqYWlucy9saW51eC90cmVlL2luLWtlcm5lbC1jcmFz
aC11cGRhdGUtdjkKPj4KPj4gVG8gcmVhbGlzZSB0aGUgZmVhdHVyZSB0aGUga2R1bXAgdWRldiBy
dWxlcyBtdXN0IGJlIGRpc2FibGVkIGZvciAKPj4gQ1BVL01lbW9yeQo+PiBob3RwbHVnIGV2ZW50
cy4gQ29tbWVudCBvdXQgdGhlIGJlbG93IGxpbmUgaW4ga2R1bXAgdWRldiBydWxlIGZpbGU6Cj4+
Cj4+IMKgwqAgUkhFTDogL3Vzci9saWIvdWRldi9ydWxlcy5kLzk4LWtleGVjLnJ1bGVzCj4+Cj4+
IMKgwqDCoMKgwqDCoCAjU1VCU1lTVEVNPT0iY3B1IiwgQUNUSU9OPT0ib25saW5lIiwgR09UTz0i
a2R1bXBfcmVsb2FkX2NwdSIKPj4gwqDCoMKgwqAjU1VCU1lTVEVNPT0ibWVtb3J5IiwgQUNUSU9O
PT0ib25saW5lIiwgR09UTz0ia2R1bXBfcmVsb2FkX21lbSIKPj4gwqDCoMKgwqAjU1VCU1lTVEVN
PT0ibWVtb3J5IiwgQUNUSU9OPT0ib2ZmbGluZSIsIEdPVE89ImtkdW1wX3JlbG9hZF9tZW0iCj4+
Cj4+IMKgwqAgU0xFUzogL3Vzci9saWIva2R1bXAvNzAta2R1bXAucnVsZXMKPj4KPj4gwqDCoMKg
wqAjU1VCU1lTVEVNPT0ibWVtb3J5IiwgQUNUSU9OPT0iYWRkfHJlbW92ZSIsIEdPVE89ImtkdW1w
X3RyeV9yZXN0YXJ0Igo+PiDCoMKgwqDCoCNTVUJTWVNURU09PSJjcHUiLCBBQ1RJT049PSJvbmxp
bmUiLCBHT1RPPSJrZHVtcF90cnlfcmVzdGFydCIKPj4KPgo+IFNvdXJhYmgsCj4KPiBUaGUgYWJv
dmUgc2VlbXMgdG8gY29udHJhZGljdCB3aGF0IEkgYW50aWNpcGF0ZSB0byBiZSB1ZGV2IHJ1bGVz
IAo+IGNoYW5nZXMgb25jZSB0aGUgYmFzZSBzZXJpZXMgaXMgYWNjZXB0ZWQuIFNwZWNpZmljYWxs
eSBJJ20gc3VnZ2VzdGluZyAKPiB0aGUgZm9sbG93aW5nOgo+Cj4gwqAtIFByZXZlbnQgdWRldiBm
cm9tIHVwZGF0aW5nIGtkdW1wIGNyYXNoIGtlcm5lbCBvbiBob3QgdW4vcGx1ZyBjaGFuZ2VzLgo+
IMKgwqAgQWRkIHRoZSBmb2xsb3dpbmcgYXMgdGhlIGZpcnN0IGxpbmVzIHRvIHRoZSBSSEVMIHVk
ZXYgcnVsZSBmaWxlCj4gwqDCoCAvdXNyL2xpYi91ZGV2L3J1bGVzLmQvOTgta2V4ZWMucnVsZXM6
Cj4KPiDCoMKgICMgVGhlIGtlcm5lbCBoYW5kbGVzIHVwZGF0ZXMgdG8gY3Jhc2ggZWxmY29yZWhk
ciBmb3IgY3B1IGFuZCBtZW1vcnkgCj4gY2hhbmdlcwo+IMKgwqAgU1VCU1lTVEVNPT0iY3B1Iiwg
QVRUUlN7Y3Jhc2hfaG90cGx1Z309PSIxIiwgR09UTz0ia2R1bXBfcmVsb2FkX2VuZCIKPiDCoMKg
IFNVQlNZU1RFTT09Im1lbW9yeSIsIEFUVFJTe2NyYXNoX2hvdHBsdWd9PT0iMSIsIAo+IEdPVE89
ImtkdW1wX3JlbG9hZF9lbmQiCj4KPiDCoMKgIFdpdGggdGhpcyBjaGFuZ2VzZXQgYXBwbGllZCwg
dGhlIHR3byBydWxlcyBldmFsdWF0ZSB0byBmYWxzZSBmb3IKPiDCoMKgIGNwdSBhbmQgbWVtb3J5
IGNoYW5nZSBldmVudHMgYW5kIHRodXMgc2tpcCB0aGUgdXNlcnNwYWNlCj4gwqDCoCB1bmxvYWQt
dGhlbi1yZWxvYWQgb2Yga2R1bXAuCj4KPiBUaGUgYWJvdmUgYWRkaXRpb25zIGFsbG93IGRpc3Ry
b3MgdG8gZGVwbG95IHRoZSB1ZGV2IHJ1bGUgaW1tZWRpYXRlbHkgCj4gYW5kIHdvcmsgcHJvcGVy
bHkgZXZlbiBpZiB0aGUgYmFzZSBwYXRjaHNldCBpc24ndCB5ZXQgbWVyZ2VkLCBvciBkb3duIAo+
IHRoZSByb2FkLCBlbmFibGVkL2NvbmZpZ3VyZWQuCj4KPiBBbSBJIG1pc3Npbmcgc29tZXRoaW5n
IHN1Y2ggdGhhdCB5b3VyIHJlY29tbWVuZGF0aW9uIGlzIGRpZmZlcmVudCB0aGFuIAo+IG1pbmU/
IF0KCkl0IGlzIGp1c3QgZm9yIHRoZSB0ZXN0IEkgaGF2ZSBiZWVuIHN1Z2dlc3RpbmcgdG8gZGlz
YWJsZSB0aGUgdWRldiAKcnVsZXMsIGJ1dCB5b3VyIHVkZXYgcnVsZXMgY2hhbmdlcyBpcyB0aGUg
d2F5IGZvcndhcmQuCgpJIHdpbGwgdXNlIHRoZSBhYm92ZSBjaGFuZ2VzIHRvIGNvbnRyb2wga2R1
bXAgc2VydmljZSByZWxvYWQuCgo+PiBOb3RlOiBvbmx5IGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxs
IHdpbGwgd29yay4gRm9yIGtleGVjX2xvYWQgbWlub3IKPj4gY2hhbmdlcyBhcmUgcmVxdWlyZWQg
aW4ga2V4ZWMgdG9vbC4KPgo+IFdpbGwgdGhpcyBiZSB0aGUgc2FtZS9zaW1pbGFyIGNoYW5nZSBh
cyBJIGhhdmUgcG9zdGVkLCBvciBkbyB5b3UgCj4gZW52aXNpb24gc29tZXRoaW5nIGRpZmZlcmVu
dD8KCkkgdGhpbmsgdGhlIGdlbmVyaWMgY2hhbmdlcyB3aWxsIGJlIHNhbWUuIEkgbWlnaHQgbmVl
ZCB0byBhZGQgc29tZSAKUG93ZXJQQyBzcGVjaWZpYyBjaGFuZ2VzIHRvCm1ha2Ugc3VyZSBlbGZj
b3JlaGRyIGFuZCBGRFQga2V4ZWMgc2VnbWVudCBzaG91bGQgaGF2ZSBhZGRpdGlvbmFsIGJ1ZmZl
ciAKc3BhY2UgdG8gYWNjb21tb2RhdGUKYWRkaXRpb25hbCBtZW1vcnkgcmFuZ2VzLgoKVGhhbmtz
IGZvciB0aGUgc3VnZ2VzdGlvbiwgSSB3aWxsIGFsaWduIHRoZSBQb3dlclBDIGtleGVjIHRvb2wg
Y2hhbmdlcyAKd2l0aCB5b3VyIGNoYW5nZXMuCgotIFNvdWFyYmgKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
