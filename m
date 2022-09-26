Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD7CC07E9D
	for <kexec@archiver.kernel.org>; Mon, 26 Sep 2022 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2Ko5X2+44R0m9kCKHtMnBQHJrAHGczP6+KSrkHj4ksg=; b=HLBY7k8CJmzLhU
	XiPzXbQHWSvTEY8krImRWtn10h2ri7LPs0Aw9n06LQV7IQ2G1voLO3hdTWiIb1BVxDJihqoYzIm4N
	eU8E9lNolnve9YTEvevNOrVwqnNQ/QqYTEuJpVF0vzeCvWYjX37y3a5TOnU8yQ2js7n50ObpMd/Mn
	ap9SE86hxLe9yg+rGMMeYy/o8t0ZaYmGCcL+L18wGWpoc3/Li917lgeni2M1Zy+vFFpesMQxWmnYP
	WrZgfn4tL8jRKy47+beA3OhGeAsc8avUAtA6vx419tyeetzpcVvlgf85Nf8UvgmTknETOjqryR5Hc
	HhU3DYbteSnxOAHYK7Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ociTf-002j2h-MU; Mon, 26 Sep 2022 07:24:31 +0000
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ociTc-002j0C-Q7
	for kexec@lists.infradead.org; Mon, 26 Sep 2022 07:24:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664177069; x=1695713069;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=86ZqY8ZR25hMkjd0WpGxG9gvfn7hmgTIn9xbbz5adGw=;
  b=WnA992FE5gu6/jJ2uoio2VR1AWglLLu76DuKcCIL1NxbbywLFMY7HcZz
   ScabUuqtVseS+O6dpw261pjHuXLJA3dLxcNsrVmsLs0N7qLNoUrHUy3Bo
   Br34ZIg9KrvoDzUboo3aUBMFtY+D4y8iLEPOFbgUSz4pdzsXpHqei4iNG
   1X9jXKSuMUrh61N9LUF0coclREB8Fe9HbRfpc8KT9iiI/jtQfqO+CO1gn
   9Y4h40YzUpCZ/dQTxB4yTP6cAq1hLgZU4JhLnVCzMOT9rR+xl0eoGTIaG
   ixum2bcd4JWr4Euwh06lcu4hsmVxPNJLdXdDktnmF3PY9f2AElzo+nYvG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="65610717"
X-IronPort-AV: E=Sophos;i="5.93,345,1654527600"; 
   d="scan'208";a="65610717"
Received: from mail-fr2deu01lp2170.outbound.protection.outlook.com (HELO DEU01-FR2-obe.outbound.protection.outlook.com) ([104.47.11.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:24:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebqbizk5qoOpzBxToVlJXmOvs37HQtt0SAEq7NBvoFj2/rS7sAvtDWNqZjyr1VSDsN3hJNLMhMz9nrS8Acotuo/TRiYlmxCL6PFcdtq63p+Q8eNuT4I2anzFvXQ7GWY4yeT/EYxWYgB0v6ePJ8gOnhZlB4V6dXnXATDR5n87exMXJ5+fBWAL5ZpnJ/0OhY+Oe+TWSBVO/GlDKubCFqlkG3zNj13FMNRNmqzDl36d7sOK+ALgnY2WYSWbfm0N3cFvtiK0JGjsHqUYOBxeYdDJCjPBsS2r0w7b/JzpKCWLuuD/0gEGYN/SkqiRQM+CCtCzguf1DlizVbYHPiqt3QqS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNTv4LbeRPDSWS2RzHiBgjSO7KUTn8MA259LsGgIGZU=;
 b=cnW83+MzScJiN8sYERLGNbqAjH1jABOa0NAXsg7IAWa8k5RTgo9jXaDu7Pe6to/rCXa6yT5rr5NaWsrHudcAPlGa8IDCsm29vlOGbT+XF56o2qy6XW+Amo9zer5BcC2tblmk4qXjNBLusxzDGmhMnntNv05nP0NKpFXFlL2rfbo8C9MR2ZP3Y9thILhJA44JbKTv5kvbo7yow0AivNIT9VyP4mWWX46FugEGfKxToQVOzVq328tnAU1xXmT/vsgNLnLSVMDswqiG3yQFL+2nttgz8iGuvsFqvStYxoDTIjSG4sscLAvqyXiVfy5Rar8AnG+zbO+/J289G9rDBAfE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:29::6) by
 FR2P281MB2927.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:66::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.14; Mon, 26 Sep 2022 07:24:19 +0000
Received: from FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ad5b:c7bb:e342:34a8]) by FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ad5b:c7bb:e342:34a8%9]) with mapi id 15.20.5676.014; Mon, 26 Sep 2022
 07:24:19 +0000
From: "dietmar.hahn@fujitsu.com" <dietmar.hahn@fujitsu.com>
To: kexec mailing list <kexec@lists.infradead.org>
Subject: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't get
 the symbol of xenheap_phys_end.
Thread-Topic: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Index: AdjReGs1LM4LddpXRUOuXPWjEIJLGw==
Date: Mon, 26 Sep 2022 07:24:19 +0000
Message-ID:  <FR0P281MB2123EA0E029E96579F0C6DF894529@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=13df2377-81e6-4874-916b-43400f10a0c1;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED???;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-09-26T07:19:12Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2123:EE_|FR2P281MB2927:EE_
x-ms-office365-filtering-correlation-id: d07f360a-3755-426b-0cef-08da9f902092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  r6X2plw+zofrV95691uZdwRDTagO50BYyd9eHY/KJ37BzcJZ4EL6ANF4au1TC+g4Js0cl6gMHqf4DxE1cCH+TM05yNixoK0HAhgkebKRywGjKRLoGYA9lSvMzM4PEzf8vzxiqSB1yMd4YedqtNIuBmwhvI9s/GGSlKqy+dg5xUFKUA6Gy1cXD4KfDSvkOJJRRP5B7N87AbWd1IW0kzFoHtOsvDkLgUYj8JNxbgDLh898hrZjxUYGA6rwt94TmIgJ49LDmUPcsfoAKL3AXoWqCGJeiJPRUy2WMTECB0eAJ7WhqxTvgBWUt0HzRnScAb4WTwlhRSuggt35Je1Ug6ryBc+PYg6it2VAZS8TwbwwfimHErYnk4R5IcdD3iZH8IPafwDBhjoGfcJsBO7uGGUOPRuBzUE+MAQmof0WVJeQdEXV1/vsnaz5argfddE5LHsBGicptVW5hN3xE5NMTk0I7Gc2/kTrkiNtbUC/tOUEw11ROpS58GvZah7+eUrYcpzNJH6jl/g0DAiDqMwqfospHsxy4ZH0zWRHkJdWTEgXXZ2gQ/k/hfqOgm4rnZF0HQUwK2OttA6avtroJEkjI9TRlIX+T6q4CxzOKpj8C+GLPKcbuIAvYLnEPwvGRZwqp7X9cxxErfSk2NQz8gfFUkGZ1Da0UQInNtXsZat0SpSyoA0lj3NcAB0STxDdU32V8/mZ6byG9aBXb6DwBXZabC/4ZFmhKIbQTK8Ns6IRe9agMNgWCQ4pzNjEUfzgmw5BJ/GzI2uKf6OyZKL0bpF9Avnu8h105sG8ERmrZKSKhDUu7hI=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(66446008)(66556008)(66946007)(64756008)(38070700005)(8676002)(83380400001)(66476007)(76116006)(6916009)(316002)(33656002)(4744005)(5660300002)(2906002)(52536014)(41300700001)(8936002)(86362001)(26005)(122000001)(38100700002)(6506007)(9686003)(7696005)(186003)(55016003)(82960400001)(71200400001)(478600001)(15583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?MTDB72uEX4w0/f7JGibrHDDy26+ju+IN+ChfJwHo3Q+++S1bZVi6zt1Y8O?=
 =?iso-8859-1?Q?nu5NOGmTZKs5SzwzpEoPqAgLXr9wAmmH/sCa6lEmvOChlpB6N9W89/fETi?=
 =?iso-8859-1?Q?YdMDxElwjYN2sWx961X9r1Fvyre+S6sS7MbROJ6L/B/3Lodv2icamzNU53?=
 =?iso-8859-1?Q?mqUNQts2FrfIynwnj/Tnh8xu4XIfEzjgTig9fhsaglJDM2pY3qBokDMMH4?=
 =?iso-8859-1?Q?d788dqGz0gMA2xgYuKK42bypDL9+LhyTXvU+R7XOn0u7APpB9aNN7B/PM6?=
 =?iso-8859-1?Q?vcT9YjZO8HzLqB4jcx+drOzzwStxVLEY5RHmYug5XJ/P7CxffSlDqyfmgH?=
 =?iso-8859-1?Q?4b+iGkWBxH/SLEA5lJgdKiTRuQlza29dMKqn7uQhLIXsCc6hxX7aY0hOjQ?=
 =?iso-8859-1?Q?mf6R9AwAU1Kul24ib9WB52OWBKxPp8kh/D4mFvFZuBwf8zQUXk5qY+LZhd?=
 =?iso-8859-1?Q?ZquewR9vC4j4Tfxfw5AqWiXF4VXsf06m6A9lpQep1eiRMjXUuiV1Mlj9iK?=
 =?iso-8859-1?Q?H2ukIXWq4JtQ8+MMG+wQOd6IyioTk2m0+kmIvBeVSp+bQY1nuY0e1EfxsN?=
 =?iso-8859-1?Q?E67+guflW7z5UpUCc+/3w2hkfpVlkSg2xtVYgiHeI8zYesCg2OxzNfsaVo?=
 =?iso-8859-1?Q?5VYucGny5kbnlUw/ThM9S9ZKmFhKYXevcNZt/ledo88AM7eCO4GLAUKFy+?=
 =?iso-8859-1?Q?YgOjPR4fTlEEqGTs6orHM8xy5mvo+4iwO9xaAnw4rxi0k57sYlxvSiL4Tl?=
 =?iso-8859-1?Q?YoaYmhO9W9SMVK8fzCZrXEE3PJ3LJV8Yft5alg0YuiYhA+3sESdOdmwXYI?=
 =?iso-8859-1?Q?33i6/Kw2r78VeHzMyaWoqgBo4ekCnJBZKFABsh7D34sOZrArHjrjzT0CiB?=
 =?iso-8859-1?Q?ErqW0SmKpQ9+/uO7wCsZ3eTCMDnrbtCkT124cqKt18S2Mj/Wi0FRwsdAPP?=
 =?iso-8859-1?Q?K5ZLCmash1T4Alh3W55LvZo3CXx8/m3c8zNXck+r5SOpMnEl9KYu27r+aN?=
 =?iso-8859-1?Q?zL02e/IM379az6NFKfFRZo9ZamxxgvLKQUSa7lptXez5n+9KW7LO45FjvB?=
 =?iso-8859-1?Q?DDkMA3DjvMxTPvEI69iIx0m1nvnkqozv3W0Zvl/T8xlxlKYfF1HVCfhD8W?=
 =?iso-8859-1?Q?V5ZjQ1bN4XJ3TrGq4fzY6ZFgi3kjTR62hPg05g/4eq8XIxTPJamx1p6r7Q?=
 =?iso-8859-1?Q?fnVDLmayL2m5DvrBcRvEYQo9IJ74+Wf3XMsXdcuCzHIm31E1iLm2Grrtcu?=
 =?iso-8859-1?Q?4bv6otuFDAxaqQS1yJYXZqZl+pPEOY/TfcnTPgl3tAcjyMBLBT/tQw5qFa?=
 =?iso-8859-1?Q?QTJUa07mmguzRLp9T+rkyIMBxtL83pMVHzPJrH/fD8eGqh6MJYgAPtKG/g?=
 =?iso-8859-1?Q?c8Efg0xs1XJ0K0dfJrOl9Qug9AWrzTdjRXbAosRzsUqC9nrnPp09plKDxW?=
 =?iso-8859-1?Q?iI1/yB92jEdfdMeDcx+ReI1/LT3rtLxSSXLEDfhJMCGcvr5XcZfyPmJLPZ?=
 =?iso-8859-1?Q?mZsOlxr0M67nj7v5+i7jsN5Ux+0ocCo111gHLscKRAhupjY8XjqdzjPhlq?=
 =?iso-8859-1?Q?sRbmazO3zCgQDtii0KxYKnghAQSwuHfA1/hGxjBlnztelFQwIzli8GvIct?=
 =?iso-8859-1?Q?n6ujqOzSJz7Op+tG+mbH1101clmncWoYH9?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f360a-3755-426b-0cef-08da9f902092
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 07:24:19.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anxI7FWya3iCxZDdCxpo+PLHrzS9Jbru5LKW66GWPepEf8eNWcNOWHVwda0t7e1l5SGX2FcgRp0Mjz6KLeJBL1hczEc3TjQmTSUNBc6GOQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2927
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_002429_183077_2F214EE0 
X-CRM114-Status: GOOD (  14.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,
I have a Linux-dom0 running with Xen. The extraction of the vmcore via
makdumpfile shows the message:
get_xen_basic_info_x86_64: Can't get the symbol of xenheap_phys_end.

The commit 2651d571 changed the behaviour of init_xen_crash_info().
With
-       return TRUE;
+       ret = TRUE;
+
+out_error:
+       free(buf);
the buffer is released but it's still used because of
info->xen_crash_info.com = buf;
This leads to random data in the buffer and later to the mentioned
error.

With the change back the memory is not released.
But I'm not familiar enough with code to decide where to do this.

Thanks.
Dietmar.

Signed-off-by: Dietmar Hahn <dietmar.hahn@fujitsu.com>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 65d1c7c..a7cd982 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9710,7 +9710,7 @@ init_xen_crash_info(void)
        else
                info->xen_crash_info_v = 0;
 
-       ret = TRUE;
+       return  TRUE;
 
 out_error:
        free(buf);
-- 
2.26.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
