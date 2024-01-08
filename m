Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210E1C3DA6E
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bzswO+IMlazfrfNsGdLm/KmY74PjO+u7yyzuGQM6mw0=; b=U00BUeFbrI6A9D
	ahG9pxKI85sHXoER9vZfM9Phyr6H8H/edJ0AAbxBsrYud/HJZHsqjZErDNwgxwglsk3CwSFBkUtMC
	g0FGmp24Ak9VlAgTi7xMnuOzN3JIYpcqCmuDsZyvJwGIc3pnBBCsx1Obj04tbcPCpC4oygkumnthH
	5B9xXNunLGEY/aToi5pWAtP6+Khze7WKNjFvnMa13CvQ6w4JWBVbB/boC19bg9q/0QGttpa4+xJyn
	VMbnOxsWugGjX1wASX7ye4rx+V6ZMUWw4JDjtvhOiGWQ5Wn+hXxL8UO9FvDOt8uC6aqYDU/LLyWkJ
	/u+OU1ipxaxcMGFCAt1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMk80-004Bcf-1f;
	Mon, 08 Jan 2024 07:32:56 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMk7w-004Bbf-2N;
	Mon, 08 Jan 2024 07:32:54 +0000
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4083W4jo025153;
	Mon, 8 Jan 2024 07:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pRwL7tB0nJKbdGk2WmSX08I3bGiRbyCJpV6DOrHHcdA=; b=jm
	QjQkEP2MycG3N/fOeBFYRABy7Ct5r4NaE22+DLl4DY/H1v75skDIJBM+uN/8XVIO
	UMJq4DMeh6RwSS+pt+rLmBf/D75Dk6qm4MBssqJljnxLYtUL+f48km8UldKq/abV
	B1ljXRLW+7AryX8Cwty/aJeNMi8/qo+nB6P+gpqqs2fGJt8olqKOf32JOMbWC1v6
	hKVz3ACCGtNN6N2PWpCUQ02NbCUIhrVMIqpdhMbhyfffD4m74qxE88MKFIJSRV/v
	DkmYeQgIpMGth47hKnPMh3BtxE3pXMyYFXuQy+wf0wKk2XuKrz5qGLczNZGTBm+5
	5NGISjWIbRjYfzyE28xg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg97b0bqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 07:32:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4087WduE006648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 07:32:39 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 7 Jan
 2024 23:32:32 -0800
Message-ID: <2e7ad0c9-ec5a-a65a-899d-a575b6201510@quicinc.com>
Date: Mon, 8 Jan 2024 13:02:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump
 module
To: ruipeng qi <ruipengqi7@gmail.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <bhe@redhat.com>,
        <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <zalbassam@google.com>, <dianders@chromium.org>,
        <mark.rutland@arm.com>, <lecopzer.chen@mediatek.com>, <maz@kernel.org>,
        <arnd@arndb.de>, <yury.norov@gmail.com>, <brauner@kernel.org>,
        <mcgrof@kernel.org>, <maninder1.s@samsung.com>,
        <michael.christie@oracle.com>, <samitolvanen@google.com>,
        <linux-arm-kernel@lists.infradead.org>, <qiruipeng@lixiang.com>
References: <20231221130930.32634-1-ruipengqi7@gmail.com>
 <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
 <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
 <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
 <CADHLONHHZAeubePPfZbG1N0Nv3ZJM5OWaJWqchBUpiN5Q27UdQ@mail.gmail.com>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CADHLONHHZAeubePPfZbG1N0Nv3ZJM5OWaJWqchBUpiN5Q27UdQ@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uw-DguUr1t_QwRl5eDO3byLAwgnp72FB
X-Proofpoint-ORIG-GUID: uw-DguUr1t_QwRl5eDO3byLAwgnp72FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=854 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_233252_916968_303A87BE 
X-CRM114-Status: GOOD (  11.76  )
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

CgpPbiAxMi8yMy8yMDIzIDk6MDAgUE0sIHJ1aXBlbmcgcWkgd3JvdGU6Cj4gT24gU2F0LCBEZWMg
MjMsIDIwMjMgYXQgMTE6MTPigK9QTSBydWlwZW5nIHFpIDxydWlwZW5ncWk3QGdtYWlsLmNvbT4g
d3JvdGU6Cj4gCj4+PiBJIGRvbid0IHNlZSBhIHByb2JsZW0gd2h5IG1pbmlkdW1wIGNhbm5vdCBk
byBpdC4KPj4gUWNvbSBtaW5pZHVtcCBhbGxvd3Mgb25lIGtlcm5lbCBjbGllbnQgdG8gcmVnaXN0
ZXIgaXRzIHJlZ2lvbiB0byBkdW1wLCBhbmQgdGhlbgo+PiBkcml2ZXIgd2lsbCBjcmVhdGUgYW5k
IG1haW50YWluIG9uZSBlbGYgaGVhZCBmb3IgaXQuCj4+IEJ1dCBvc2R1bXAgd2lsbCBkdW1wIHRo
b3VzYW5kcyBvZiBub24tY29udGludW91cyByZWdpb25zLiBJZiB5b3UgcmVnaXN0ZXIgb25lCj4+
IGJ5IG9uZSwgYW5kIGFkZCBhbiBlbGYgaGVhZCBmb3IgZWFjaCwgaXQgd2lsbCBjYXVzZSBoZWF2
eSBvdmVyaGVhZC4gU28gaXQgc3RvcmUKPj4gZGF0YSBpbiBiaW5hcnksIGFuZCByZWFzc2VtYmxl
IGEgc3RhbmRhcmQgZWxmIGZvcm1hdCBmaWxlIG9mZmxpbmUgZm9yIGRlYnVnLgo+Pgo+IE9zZHVt
cCB3aWxsIG9ubHkgZHVtcCB1c2VmdWwgZGF0YSwgd2hpY2ggbWF5IGhhdmUgYmVlbiBhbGxvY2F0
ZWQgYmVmb3JlIGJ1dAo+IGZyZWVkIG5vdy4gSW4gYSB3b3JkLCB1c2VmdWwgZGF0YSBhcmUgY2hh
bmdpbmcgYWxsIHRoZSB0aW1lLiBJIHRoaW5rIHRoaXMgaXMgbm90Cj4gc3VpdGFibGUgZm9yIFFj
b20gbWluaWR1bXAncyBmcmFtZXdvcmvjgIIKCgpIZXkgQHJ1aXBlbmcsCgpJIGxpa2UgdGhlIGlk
ZWEsIEhvd2V2ZXIsIGFzIGkgYWxyZWFkeSBzYWlkIGhlcmUKCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvNTIwZTM3N2QtZTk5MC1jMTg1LTRhMjAtMDc4MDY4NzNlNTA2QHF1aWNpbmMuY29t
LwoKVGhpcyBsb29rcyBtb3JlIGNsb3NlIHRvIHBzdG9yZSByYW1vb3BzIGJhc2VkIG9uIFJhbSBi
YWNrZW5kLCBhcyB5b3VyIAplbnRpcmUgdGhpbmcgaXMgYmFzZWQgb24gUkFNIGNvbnRlbnQgdG8g
YmUgcHJlc2VydmVkIGFjcm9zcyBib290IGFuZAp0aGF0IHdheSBpdCBhbGlnbnMgdG8gcHN0b3Jl
IHJhbW9vcHMgY29uY2VwdC4KCkFsc28gbW9zdCBvZiB0aGUgc3R1ZmYgbGlrZSBjb21wcmVzc2lv
biBpcyBhbHJlYWR5IGF2YWlsYWJsZSBpbiBwc3RvcmUuClNvLCBsZXQgbWUga25vdyBpZiB5b3Ug
dGhpbmsgdGhhdCB3YXksIHdpbGwgYmUgaGFwcHkgdG8gY29sbGFib3JhdGUgYW5kIAp0ZXN0IHRo
aXMuCgotTXVrZXNoCgo+IAo+IEJlc3QgUmVnYXJkcwo+IFJ1aXBlbmcKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
