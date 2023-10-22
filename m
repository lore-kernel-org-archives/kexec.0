Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C64CDB474
	for <kexec@archiver.kernel.org>; Sun, 22 Oct 2023 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ht9nq3ZyleaWMtqxx+D2tFHx8AP66UwsZhAeCJTGz4s=; b=i8sWiX2mj7o5O/
	49wIDrX+GDx+zdr4dDcXq4uR14R0CxHDNrDkWAziuvjQgc+W9BUqrA8HmBqi8iJY/t8ieaBlw3vWv
	+u+cCaxHaFKidg2z5I3vVqHtcOZAxprfv1QmLsQR0OVxKf20yl3OAbO/kTbjESUHUyqirIg2Ff8Im
	+bdU3I2b0JeEWL8N1wZ4hfGA/rNofo2XYcXnPhIMubT5n7KZlaRUJnW2RV9/TPp/mek/YIJBVJShe
	+Gp77p5EFAy/ZXyAlsORkFAdz25Me/kUADLRCvkV101h++Ieef5qccxAYskN/jS5E/6060r8Wp2Rr
	VgZUwwr49MPK6prsOyEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qudkj-005qYd-2u;
	Sun, 22 Oct 2023 19:04:45 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qudkf-005qYJ-0V
	for kexec@lists.infradead.org;
	Sun, 22 Oct 2023 19:04:42 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MIwwBJ013066;
	Sun, 22 Oct 2023 19:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=maKKcoH6eUl7NYDIpjbc31lMxZYF8rVLYvLdNVhOu50=;
 b=inw/RrBe+b3sbOZ6FOoso7s6++PgipdH2mx7bkVyk1gm8CFF6FULJAzF2mo/WiXJtHWh
 RrEzOwt27WMsa5pYv4GHoslfUEDugiQMNGVdP7IVEwanYes5fmLHwzXTueQxgJHqDkw6
 ROc6q0U/ZNcqVDxAckrYaiznXP+h7gG9gbq7Sn/Vacds+98L/7mw2q42DmYdzpi/QTN3
 grBPdPvp1m+n6HeJpreovxpBwS2Py6Y7Isn8CfVpOIOb9EGuUfsRlzBSWx/ckILLnXcL
 KSocE+p6TkgHnQTcVDWDlYnWVAte+lp3OG9UgStMqZHr9gxgi/p9SPhvJyeLjsx8+WZp Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581hvdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Oct 2023 19:04:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MHFdbw031205;
	Sun, 22 Oct 2023 19:04:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv539qhv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Oct 2023 19:04:36 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MJ4ZQM013416;
	Sun, 22 Oct 2023 19:04:35 GMT
Received: from localhost.localdomain (dhcp-10-175-52-84.vpn.oracle.com [10.175.52.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv539qhu6-1;
	Sun, 22 Oct 2023 19:04:35 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] kdump: fix reference to nonexistent file
Date: Sun, 22 Oct 2023 21:04:24 +0200
Message-Id: <20231022190424.919982-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310220176
X-Proofpoint-GUID: OuayZRL-O4eZBxCVOODviB5CkcX2iDyO
X-Proofpoint-ORIG-GUID: OuayZRL-O4eZBxCVOODviB5CkcX2iDyO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231022_120441_198811_911BEDD7 
X-CRM114-Status: GOOD (  17.10  )
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

QWxsIHRoZSBzMzkwIGRvY3Mgd2VyZSBtb3ZlZCBmcm9tIERvY3VtZW50YXRpb24vczM5MC8gdG8K
RG9jdW1lbnRhdGlvbi9hcmNoL3MzOTAvIGJ1dCB0aGlzIHJlZmVyZW5jZSBkaWRuJ3QgZ2V0IHVw
ZGF0ZWQuIEZpeCBpdC4KCkZpeGVzOiAzNzAwMmJjNmI2MDMgKCJkb2NzOiBtb3ZlIHMzOTAgdW5k
ZXIgYXJjaCIpCkNjOiBFcmljIEJpZWRlcm1hbiA8ZWJpZWRlcm1AeG1pc3Npb24uY29tPgpDYzog
Q29zdGEgU2h1bHl1cGluIDxjb3N0YS5zaHVsQHJlZGhhdC5jb20+CkNjOiBUb255IEtyb3dpYWsg
PGFrcm93aWFrQGxpbnV4LmlibS5jb20+CkNjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CkNjOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4K
Q2M6IEhlaWtvIENhcnN0ZW5zIDxoY2FAbGludXguaWJtLmNvbT4KQ2M6IGtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKQ2M6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+CkNjOiBsaW51
eC1kb2NAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFZlZ2FyZCBOb3NzdW0gPHZlZ2Fy
ZC5ub3NzdW1Ab3JhY2xlLmNvbT4KLS0tCiBrZXJuZWwvS2NvbmZpZy5rZXhlYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2tlcm5lbC9LY29uZmlnLmtleGVjIGIva2VybmVsL0tjb25maWcua2V4ZWMKaW5kZXggOWJmZTY4
ZmU5Njc2Li43YWZmMjhkZWQyZjQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9LY29uZmlnLmtleGVjCisr
KyBiL2tlcm5lbC9LY29uZmlnLmtleGVjCkBAIC0xMTAsNyArMTEwLDcgQEAgY29uZmlnIENSQVNI
X0RVTVAKIAkgIEZvciBtb3JlIGRldGFpbHMgc2VlIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUv
a2R1bXAva2R1bXAucnN0CiAKIAkgIEZvciBzMzkwLCB0aGlzIG9wdGlvbiBhbHNvIGVuYWJsZXMg
emZjcGR1bXAuCi0JICBTZWUgYWxzbyA8ZmlsZTpEb2N1bWVudGF0aW9uL3MzOTAvemZjcGR1bXAu
cnN0PgorCSAgU2VlIGFsc28gPGZpbGU6RG9jdW1lbnRhdGlvbi9hcmNoL3MzOTAvemZjcGR1bXAu
cnN0PgogCiBjb25maWcgQ1JBU0hfSE9UUExVRwogCWJvb2wgIlVwZGF0ZSB0aGUgY3Jhc2ggZWxm
Y29yZWhkciBvbiBzeXN0ZW0gY29uZmlndXJhdGlvbiBjaGFuZ2VzIgotLSAKMi4zNC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
