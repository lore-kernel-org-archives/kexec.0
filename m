Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFDCC43334
	for <kexec@archiver.kernel.org>; Tue, 14 Jun 2022 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ovmDMhrigqkn6Np8PyS0UBGQvHTVEcmf/YtDSE1xejY=; b=whu/fFTyiK5scU
	Pjgl2QZKI+Ftgll3UywsKkIHzepWQbEu6GhiLQPvscmRoJTfK9fURIaonD2LfwC0K/VIJmbOt+vw8
	onxPBZHZe2fX/s1kUua1ovjhAiS3dDczp83kP7whxzgIug0aynu6fwyie+lGnNMHFNAd+YvVzEZ1H
	f1fI57isCMcAxAviXtFgVkis8PlcLKbw9sbhftBFLrJSKZxrb5ukRmCDjUHq7hZuLtNsT8Npv0ecO
	ohrZGAQM5Mph0ThNRa6+o3SweBXkWEjxJ9kz2ZQVfrImhoYPoQKCm+Ze3j2Nk9V1/hhFwXMxpDHV4
	V+26DJynRwOI/56s3fKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o19Vs-00AMig-U8; Tue, 14 Jun 2022 16:35:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o19Vp-00AMhW-M9
	for kexec@lists.infradead.org; Tue, 14 Jun 2022 16:35:31 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EGWCnC031708;
	Tue, 14 Jun 2022 16:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kdYemmIxQATwcwemwRHS0viNBOr9M0TmqxY4ZJueRGs=;
 b=kp1Sb+4d3gLMWexrCezMihy+NANGhkTRp7ayfVv6tVNjkElEcn/dySa2PIeIAi5RBBnZ
 XGDK3X39o4YvFgJGTIJuIiDL2mz+i29ItDk+Z1Iwum9phmkSA84goSdLhUMNe15UCr2R
 jCc2y7M/Dylmgdv9KYybTtZ6TQ7nT+gSRDy99pctWfm572GCEjL1E8XyqaaK0iFVTk2p
 qvibzYPC4klEsGZfMjR7EemfrYuF9+0aKQUnJ/gadvYsjSkvaWJyTUWwikfxa0caJ/zf
 QCat+mvVpLuPoLPeggcqZG0ZblxikR0g9MOJWLlSIN/cADnFpRLagcmiLQn6kwe6NYG7 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpq696dva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:35:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EGWFJ2032091;
	Tue, 14 Jun 2022 16:35:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpq696dun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jun 2022 16:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYXG8neDvU3JI6ci0z6Z44XtuLI8xvnrdqthR41yIL5GpnemuDpS/xHM1mhNmQAibXCwQwE2pm/s9kY1sUjpWFwZGj+JsQye1WePceWn2emAF4VXQd/R8eLna5k4R16+Zt2L/PDN9EMMCGNe6A9MYgtWm5N0lsbGUZKs1Z6l3/Zwa5U+5uI2Z9ctu9UNqof28QLct4LJmM95ZhfYZaH/i1x7XawfUC3LtKDUX736UaQc9nOZzjcTJRVB/DEuy/G0rD/i6/qJLcWgzMzXChmzH691si2VQTGvkkXWPZGqzH/JTxEGT3njMPyH1fHmQp/w8VTjWd+UQVakGK/pwGYGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdYemmIxQATwcwemwRHS0viNBOr9M0TmqxY4ZJueRGs=;
 b=j1+I8exz6wpLb6gSEz2RssBVKFdoTN2iPiJqiWifEIveNjE9pHWEncpcm8eobCAWniNbtfpI4RAYqngr0bI32WuyjsZdCWN8guVhbyjeJRFLTuDSZXJfQ1Abra/YcbF4+uBFd2IS1U3AAx58H+DIsCCJCeFck8eujynZzSurFg4D2sHG72iG0zG5LN4xXpTXYU29lWqpwmikp+kXCbifIhnOihEyoF9e8jrNcZh1Ql183xHVGJud7ZhSXgvedLrl7bwX7ErxgD+qghxain2iSEygH9sC3myFs4zQ7QVqH5nrb2O0P2TcvIpB11xPSQkBBuZslDpu84NF5vWzEfoc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in.ibm.com; dmarc=pass action=none header.from=in.ibm.com;
 dkim=pass header.d=in.ibm.com; arc=none
Received: from MWHPR15MB1150.namprd15.prod.outlook.com (2603:10b6:320:2f::8)
 by BN7PR15MB2306.namprd15.prod.outlook.com (2603:10b6:406:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 16:35:23 +0000
Received: from MWHPR15MB1150.namprd15.prod.outlook.com
 ([fe80::c5da:1dc2:98c7:a9ab]) by MWHPR15MB1150.namprd15.prod.outlook.com
 ([fe80::c5da:1dc2:98c7:a9ab%12]) with mapi id 15.20.5332.020; Tue, 14 Jun
 2022 16:35:22 +0000
From: Nageswara R Sastry <nasastry@in.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/3] of: kexec: Refactor IMA buffer related functions to
 make them reusable
Thread-Topic: [PATCH 1/3] of: kexec: Refactor IMA buffer related functions to
 make them reusable
Thread-Index: AQHYgAmjqxbwvF7w2UqKYsL6wAsdJa1PGGvy
Date: Tue, 14 Jun 2022 16:35:22 +0000
Message-ID:  <MWHPR15MB115022663BCD26A3044A97A7EBAA9@MWHPR15MB1150.namprd15.prod.outlook.com>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
 <20220614161258.1741427-2-stefanb@linux.ibm.com>
In-Reply-To: <20220614161258.1741427-2-stefanb@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e664b7f9-9e39-48df-1122-08da4e23e0cf
x-ms-traffictypediagnostic: BN7PR15MB2306:EE_
x-microsoft-antispam-prvs:  <BN7PR15MB2306F62CD0DAC2CC0C94E4E0EBAA9@BN7PR15MB2306.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Ud5yWVpnkeqUFqfT+cBHsUhh19DtaBszHcoInnwen7wQP9x9CZN1MTuGPGeawyUEVhC0RpRFwz/x7nZ51CAXXvEXOXQqRkFrBUA8ly3nKgxvtBBgMNxqc44EQlm3+0q3oOMA4MmeXbgMEwDC3zh40mU/Bku44ikKb4xyKGX6ke7vtynNdExEXBRbUCSlBX/m4EIfT4Ej7mMwI8WM3dlT4dsxnZazqPOBQQBGoMYDkJVHAWAt5NQmH2UyJWk+vKR4PCvLMayDJyEiNQ6lCNQ9gHoOmc2Bg7WJaiW/iR5d6HMr+2LNG3fxm/Hf9sMz27GdSPH9iI3HNRRM4grO0gnrjG3G5i+GOTyVb4XHhS47A5LaqxYDU/tm27jemU6QaB2k/tLoYvoxr/EixCfLzy44yh8m8OE3SdHinigCpccNx4QxS7rI+XAedlm+1+XFjLzjz5XCi6fXJjnWlkjT4EcozL8sfbbiyLjCzG3wc8DdMXXuedqMYcVgmiEgI7+zOnWNL8eIRyTYBY5/NrmWj3Cs9ZSvku7eJckLbYyqJID2PYNPB1roRKgU5C3JSb/DnNBkbTvA4GmRd+AZ39QN5YjRWkAIfwQUs/ACuev2cOMlik5YLwc2artrgOaEfMPfHKrSb0AWbNZ95PdSVe1PEdoyymAHno82g5NL+odrUSphI/LA++WhynDJOkERmGqKAK11ELCKgUSREKhIXGnazO73Pw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR15MB1150.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4326008)(64756008)(66446008)(66946007)(66476007)(76116006)(8676002)(91956017)(4744005)(66556008)(38100700002)(52536014)(6506007)(71200400001)(8936002)(38070700005)(2906002)(5660300002)(7696005)(55236004)(26005)(53546011)(83380400001)(86362001)(55016003)(54906003)(316002)(110136005)(186003)(9686003)(508600001)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?EnuTpflxEUKZ0qD+dsLcG6sRZCZzblNEKb3mD28LuWwHBTEiEeexjktO1X?=
 =?iso-8859-1?Q?2+KAQMm/zhtO106gcGwZabdEgTzgYd3DUU89F3SJ2csYboEMNbJLX5HerK?=
 =?iso-8859-1?Q?a/gbqBTSUh0j/GS2rg4Sn+RYazK5iVfUDk4vtG28fyhnoXiBdv6vFke5UG?=
 =?iso-8859-1?Q?Yr3FtixeYQUVMVHlFPGHZ/PeK5WvtpfqiC5sRpQ2fmBf+VQ8p8Dk5meWdG?=
 =?iso-8859-1?Q?P67HIzPYYtacnxmKz/MRyfkgcuvc3XLL1xEiCYyfQ9iNr6hRKLYUsoKlr3?=
 =?iso-8859-1?Q?vOgXQnMy1B0KuykLSdth2/6OAmYXLq7i02TlcuOz/Cg7EZYZ5IEB1l3wMv?=
 =?iso-8859-1?Q?l/4X9//sGj1AJNNjPTQdz0X/YEo9NDAyv1LU5KBQvLgkwFrcqrkOg6tPC5?=
 =?iso-8859-1?Q?/N455a4jCAAlI0pmKpHbV/USjlm6t4PArPXs79l/MoCfGTLL4gxLNdgQTP?=
 =?iso-8859-1?Q?NUtsX8e6K6uIo3MUIFhH5yn0fskucaq8LlaCP5d7RGP9LdqEX4MVh9z4rN?=
 =?iso-8859-1?Q?e2v3ueW6LcyeW5RYDvrt5Y6CWGquojQhTsQPZI1reqdz2laW2zjfwWIYr5?=
 =?iso-8859-1?Q?WlPsEj3Nguyr9nYssQEhkcwqPDVumENGHjtZdPPCr0NHat7VbSbJ7D/kbb?=
 =?iso-8859-1?Q?deKZZLG3PkaFwA8gjtfwbasmhYZELevZ45TyaGs/YhOwpgSz2xhzHGUB95?=
 =?iso-8859-1?Q?PF9t4M3bxKt1hZSQNK3VYUg7URuYAk9RWO7qR2TTyl7emijzEDWe9sb5vv?=
 =?iso-8859-1?Q?jFo0OyCLhS/q3Idco7DoC7c/DVCN2XaZELmLa0E2b1QdrEUDA5T50QavHI?=
 =?iso-8859-1?Q?TWcH1AJGB0lZzfB8/9nqOe++9gk1ANTai0dlPjBXcv3lDnMK7lgTj6quZz?=
 =?iso-8859-1?Q?8of0NrkrNsXSiIKNZP6CxBWEaaqOZZEw/qmAXgGviMm1+gV1YEkgVQksfT?=
 =?iso-8859-1?Q?TGxxqEO2bZykxtGVDffLhpxku+7gF6Z4ymxp2y3BN9Y68/iEN7RR9URsaP?=
 =?iso-8859-1?Q?5pdI7yBo8CbRaXbWEwDakMLd3dum336PujxVGkOgOFlra7eCNsgpSe8026?=
 =?iso-8859-1?Q?gejlZabJJsd1Pa0uBHhvAiemPvh57TktMMhNSjP+qX+B/ikLZvBNptEokB?=
 =?iso-8859-1?Q?+0YLMbVvCe/2T6o8LTnEHy4ZIcgWM+3PBON/V2AW2aT1+f61iExfCmNfy8?=
 =?iso-8859-1?Q?Y44PTzex80j3jHENZBqQRB5eW2Vo2zrNhbb00ubJp1O7jljIh9QQ2GqIKz?=
 =?iso-8859-1?Q?UFPdP5OWLsm4XsgTg9N3MwV3/FNiP9lt45VF2keqWWACRp9HeZZyCS/Rrl?=
 =?iso-8859-1?Q?UxEPL6LxV9hlcQCe4zYpQev7QobTc2djL89oF/VBs4yTd7zfiTumwzqwuQ?=
 =?iso-8859-1?Q?y7PfxejJssa8iybqnk50mCH3V4cdIVT3YrPOe4OgKBcdY6PWkIq8+dGaMd?=
 =?iso-8859-1?Q?0PTa3gJql3r2dcxzK8P9ls3X4FddYWGMdFvs1Qadpu0FroQ1/Qz0EkQHx9?=
 =?iso-8859-1?Q?JkHBQcuFKS1/PlUiKyIaHLPIihc5kkcgItALV+GzPhRkXEqij1ME2mrga+?=
 =?iso-8859-1?Q?f8VrAnWvSb0MyIcAHBNdksnFu4jboK4uLefMIIPmR6Lkewn9c+egHRZWrb?=
 =?iso-8859-1?Q?2W3HDtWDPPvgwaBax2ustrxlEJDy6GM32wATqAie9fvO8nh/iUKlu83l3H?=
 =?iso-8859-1?Q?oKBfBJnqmxR4kN+uAknmSfOaFGSLISTG7c8XXiMUub6eyLg5lFMxUQb/+U?=
 =?iso-8859-1?Q?CvUOxVqL2oE9+OhG7WxFuUvqN4i31VdIL3g+LY9OPEvYhifC7wqsM+gZCu?=
 =?iso-8859-1?Q?o3EGStUezw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: in.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR15MB1150.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e664b7f9-9e39-48df-1122-08da4e23e0cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 16:35:22.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihN6fljUY5dN4FWKF0VTMMreSjKWCYeCr9FXkF5ueDeoFjCUOSbYhNkOJW9pUm1Hn04i2wPTGJke75n13QDEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2306
X-Proofpoint-GUID: 6UGpl17_qxZVECz-d2eN6oN7LW7MzBlv
X-Proofpoint-ORIG-GUID: 3ijgO9VzSKfNT5FeIUT7ZDGkqBIZnmDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_06,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011 mlxlogscore=965
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_093529_772491_C3FF8B48 
X-CRM114-Status: GOOD (  12.92  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org




> From: Stefan Berger <stefanb@linux.ibm.com>
> Sent: 14 June 2022 9:42 PM
> To: kexec@lists.infradead.org <kexec@lists.infradead.org>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>
> Cc: nayna@linux.ibm.com <nayna@linux.ibm.com>; Nageswara R Sastry <nasast=
ry@in.ibm.com>; Stefan Berger <stefanb@linux.ibm.com>; Rob Herring <robh+dt=
@kernel.org>; Frank Rowand <frowand.list@gmail.com>
> Subject: [PATCH 1/3] of: kexec: Refactor IMA buffer related functions to =
make them reusable =

=A0
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Nageswar R Sastry <rnsastry@linux.ibm.com>

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> ---

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
