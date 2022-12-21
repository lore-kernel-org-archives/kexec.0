Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFDCC4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 02:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sj8pIBWPaDvevVyPuDD1ANUjpf6+se+8rtNreNCU7No=; b=SAYDeTbKTsFrTO
	FtIc2hqVm/mZECC+44QiEjmBls+1RUEZACWUyBzNgXp1cE0z1eH0Ldb1YrDQU4Q5gIqygMSpDH1x/
	aDkuE8KFcshvwiNMsTHV0wP5F/rR73wU3XNstnxpLes1u9Isy8fg9A6srJoM6MZcbambOpBMzH/AQ
	mbdyR0wWj/xFQwddE98SC8GbFIBVoXM9MHrqZraQs1C+f0V8+6PZuJbMcU3nT6yyvAqo8HEFv07V+
	69B4rsPyizZbeTC9U0xOpwkKwmgt/yj8o4obgYj6a2qBfMi3KyjNmb0EAE1LrumFfBIPi9rrGTgEY
	B87rc3MBFgjvGLskmNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7oVS-007VcG-KX; Wed, 21 Dec 2022 02:06:54 +0000
Received: from mail-os0jpn01on2082.outbound.protection.outlook.com ([40.107.113.82] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7oVO-007VRa-3s
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 02:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpOQ/X5WUgXVt+L98SUIDR4DsqAsDNHP0ncQa2zslqgwk8eJX5DvOV81nSTZ4du7NZDk0X3pK0UntHP2VpbDJPEQTkWuWZgf8NMGNWtHKh5iKGx/WvlCmkQGo5ArCaHn5sVAIfElpYGui7eFDDMZPsSEjsQln1CWOvlNAg85nH3gU66ggGFaUYvw75cQHxcXvBUQQ0JEyObptPiynmdXlOnzkCwQoZ2v+qSMUqh8Alx3xXXva4Z7wgYn2Nc0c4+hceV2BO8b7TSrjgiaA16iP1eQBO7tkFZ/zcSFPjphzvGLyoHt8hpFYLO+338rhevhP5A9pRS94OaNZ7tRE0A5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKv43UlQe7oKykPZEskIy7R6ICmx1TuSYmhrtHEfdso=;
 b=Q9it6GOuIOm3JmNpzkMs0f7UzvnGljXiN+y6Mxc3XDwLuMrQKLwinU1lmU3rATvc7w45FlF4P4u3SLmzgwrztGSM0eWRbV+o4S+6W/irYtlTVWBjfc4IzWFiqF7t2XELPl3TEQRlexUlvLZKLInCYQCTZbm7GdP0WQZ1YQ5/mCdwN7SpAwlS2Yy6lt1sJzv8KnrbPFanTbo9dfcsAjTsBCiwWZqE+7i53HO66CKm3ac8GM5gEQ6pQd3GMW6UQcOAzBasTrT2tqhsllHc7eGIbpVfNp1azkVkHiKuaXFdbeC5r4PVv73OWjdthqtYoB8+lSEEPJVXPMhtjPpnvIdCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKv43UlQe7oKykPZEskIy7R6ICmx1TuSYmhrtHEfdso=;
 b=KvS/B6DQUibhwHfy4OKKhY1F47PLzD1EOryeEjWwNljdbapM5Mt3XQ6VfNB5gcmEASr9kQTo3q8+cFxJV6vMY/AgCiN17W/uhDwL0pLiBZhHQLaY7yu+DdimnrJVspUM5rvxPuRzxB0Ka50SOHDWL4jGhVarDSGp3EyrhcNgoA8=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB8541.jpnprd01.prod.outlook.com (2603:1096:400:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 02:06:39 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::7841:9155:aaae:72a5]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::7841:9155:aaae:72a5%9]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 02:06:39 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [PATCH makedumpfile] Fix incorrect exclusion of slab pages on Linux
 6.2-rc1
Thread-Topic: [PATCH makedumpfile] Fix incorrect exclusion of slab pages on
 Linux 6.2-rc1
Thread-Index: AQHZFODcxWWDp5nypk+IZSMwRba77A==
Date: Wed, 21 Dec 2022 02:06:39 +0000
Message-ID: <1671588393-23443-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB8541:EE_
x-ms-office365-filtering-correlation-id: a6a5c079-e3de-444b-e968-08dae2f7ff1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wrwSjTr7qOuD4BMeffZPAUvhT1+nqGoiSSSRf17njffB7QXpZ+o75ncMGSbYBRLCCOe4+rq7n0lGlQ7T/Zuh13c7Dhq0NQjZXloYDkMuWDuoUcwW8Llvqn+s58qjfc0qcccnwUG+N+tnj1pSAH6LbfA3GNEGcw9CFgwzgwBxWkIJKcAWup9XiBHLLG5MMK6R0U69lVMuvNtZsuC0cmlq4d1cZzcqgpKr6XJpO4t6FtKvPcefOhlcaqHUgNe/BAy3wUA5/qu6cMmd4pU5ZqSTTUZLUXeHgS3L0Lc0R6nRm/L7mWB+QbmVoquRjzdGTiCO6puY7GSYkgfJxAD5DO6+KfBhRodNSwTVul5bPWq2KcaybvIbZ6Ui+xMGNlpr9NWMRCdsL1t1OVHJjjDsGU7UTVSKF+emgxrMPwIgM9C8pTFNclrE1Gqlv14FcJoAH6cCACkwknVFC03/wJEQTS9oGccBYIVMfyLfRYfwycIo69MPzpG31iFac7ggV9Yfp8cs4ZCAXWFw/PzjX+87Fx5hKtrFVcFQVUX4ep2Xj9qL4LAaDrDusBI4j6ekuwCiCY8UMhjurWlbKHk+66SAtMZDLDtO/DM1BWPtZ8XrBwE+w5cnoygGvghsGcz5ZNaWpuUOySsIpkw39rJSIaz8ma9kmFFtFcFD2d5jeKuGOuyA7mTl+RhDi/tYDxJwXL0A+pZKdCHhqSC1rY+Ld7UePT/HGQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(64756008)(71200400001)(2906002)(86362001)(8676002)(26005)(478600001)(55236004)(41300700001)(2616005)(316002)(6506007)(122000001)(83380400001)(38070700005)(82960400001)(38100700002)(6916009)(6512007)(5660300002)(66446008)(66946007)(76116006)(8936002)(66476007)(66556008)(6486002)(186003)(36756003)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-2022-jp?B?MVdOWnp0cWdYWmFoSHI2MlF0L2x0Y2ovOC9hTFl1Q3h4bHA0NnRETExj?=
 =?iso-2022-jp?B?cCtLSHB3WjhXTm82aEZwVnFWQzRuUXNxWDBIajBvWG9sWnhsbmVDZDdR?=
 =?iso-2022-jp?B?dXlRZ2dYdFpsckdOUmYvYlFYaTRnUXhNY3F0OEZUcW1DNGZHOTgzVy91?=
 =?iso-2022-jp?B?dm5RYW1lWU9wTDZPTTB4dVN1djdlN1ZWdUJaZ3lyMFpEYzB2MVdXT21m?=
 =?iso-2022-jp?B?VytPeldvYUJFcVUxTXEwZUpBbERNZVFsVThRYXNhOTlhMm5jYmZaK2pD?=
 =?iso-2022-jp?B?ZEpqekFyUkxEbXlEL1orekxRaEJrM3libjl5bVJQQnJFMDREMUhWSXRw?=
 =?iso-2022-jp?B?OXVUQWgrVnRobWVwN2daeVhFTkFrcGZ6L0FRSVJSYThhRW9NN1N3YXFx?=
 =?iso-2022-jp?B?WUYvREdoMW9TUEh2QUFDVXhteEQ5QlNLbXk0TnhpRTJYOWhJTTBWYnJ0?=
 =?iso-2022-jp?B?OTRJaVRpUGVXb1hUVlZnaXRWVUw0c1RiWEpPL0VVY0xxSVl6clZMTGVv?=
 =?iso-2022-jp?B?TVYyQVRYeXFINjNIelFrYXM4c2RaK1dtdjZGZnR4ZkJTYTkzRlgwL0Jw?=
 =?iso-2022-jp?B?ZmlKckdGRUg4Zk9HQzMwbkFzZEUrQ0lqVXNydXpBdmhUY29OclZERE8x?=
 =?iso-2022-jp?B?Q3drNnBjNHNlRzZwQUlsWE42ZERzaENRd29GeFJRalRZM2dSclVUNTk1?=
 =?iso-2022-jp?B?OWQrQ0FsNkNNWExEbEZKRGxjVzlFcWVPTG5OUjRwVldqZU1CcmRuU3gx?=
 =?iso-2022-jp?B?VGlyVnNZeTN0angwNm5GZENvVytPWTVCSWJtVm42MVNvYWhpUVRJRTYv?=
 =?iso-2022-jp?B?OHNPYUM3NHFNYU1mby9iVHlSVzA2cGVQb3JWdDR3ZmxIMWtRRnJreEY0?=
 =?iso-2022-jp?B?S2N3VDBDeXpGOGxTL0YvTEcrNW9QRFg1ZjZ6NUFMUDVpOWVYRTRqZnQ1?=
 =?iso-2022-jp?B?RGJEUzZFc3BybkdDMmdhQ21HWHp4d2c5QW54dTZaYzd4WHFJMWVGYjNC?=
 =?iso-2022-jp?B?c1A3SmNxM2J0cHhvNHVKam9vOUk2aW5RRnFSby9iVnpLbDgxTTVFVFl3?=
 =?iso-2022-jp?B?a2RtU2FmdkF4R0FsV29DNjBNY3hXaTBTanpVa3kwTVppVGowb2V2U0Zw?=
 =?iso-2022-jp?B?VnpERUE4bDlBNi95cHRxZy9nV0ROSmFYbDBoUC9aZXc4dENQci9mdVl1?=
 =?iso-2022-jp?B?RUdxUFpEdEdBUG5GZUZLeUlySkFvWHZSd0RKMXFIVTlRbk1LRjlzdjlM?=
 =?iso-2022-jp?B?Ty9DWFhEMnlVL3RVZGhOSVgwYWxXbGxKNTBpdDJFMnJmYjhSTkpSZjlL?=
 =?iso-2022-jp?B?SUpLQ0RJaDNjWURyakxPYUI0VXpmbzJSd1h2MjI3NVFvbkdrSVA4OXdO?=
 =?iso-2022-jp?B?QzFFdUFtRXRlQ0FZU1Jod21QMnkyOHF1YTNWQ1VFVWFscHFuM1lTOXoy?=
 =?iso-2022-jp?B?Q2dPZ3NlS2h5Y2NEaG8vNVEyWWpqVDR6emF0WjNvUDJLbi9JUHZwa0ZT?=
 =?iso-2022-jp?B?alRZcWNoN29CQWVycloxcElmdm5IbG1zdTB6blJXWXN0MWp6a1l3YWZO?=
 =?iso-2022-jp?B?ZXZ6SGxTSUtieDRCSjY5UEhFaHBKVGllSUxKcGg0emlEU3Rjd0FnSjlH?=
 =?iso-2022-jp?B?aVhyK2l6cEtNVzdUUDdZZVUzVXprYU5NalVSZXRCWFJUUk1ac2NzRk1Z?=
 =?iso-2022-jp?B?NGNmU2NsZXoxOUVnRzNBRCtJb2lRakNyNjdCTkwzRWxSb3o4MytxQTht?=
 =?iso-2022-jp?B?Um9mWjhCVktSRUR6SjhQT1BXMkE2cHpuL3FHYnFrSC9zajdCUTY0SjlW?=
 =?iso-2022-jp?B?YllpQ1F1Rjc3aVljdEZWYjBMSk96QXArZXhaREtyRUpUOHdOYWR0ejRp?=
 =?iso-2022-jp?B?blJaejJwYWRPbk8vN0luMXgybzdJNVdOQVBnd2VCeVM0WXZqNGxoR0FD?=
 =?iso-2022-jp?B?SnJ4QTRzQmhJOW85SkVwdVZpTEs5aGZENWUwZHBoK0xrUTlyemF6NlE2?=
 =?iso-2022-jp?B?bWVYa3NMb1lBSzNTREdIRG1ha0ZFNHNlck11SHdENXdWaUdOcEhQeFN0?=
 =?iso-2022-jp?B?cWN1SmV1ZEpENnVPa24yRml6YnJWSDdDdWVzU25SZE5CbkZmdTQzK1E1?=
 =?iso-2022-jp?B?Uzg0WUF2MEJkTTZqVTg2akpaYkptNkZVcUpYMjNRaVA5TTJRYTc0S1d5?=
 =?iso-2022-jp?B?VUdodjI5blkwSURiM1NrZmlBTE5vbTBaeWR1NjdRZkdEUjVBVVg1K2Zp?=
 =?iso-2022-jp?B?MFNkcnlwcmh6eVZvNVNrYmhWQzlZY2h5REh6Q25qVFlOWTUyNzI1aEVq?=
 =?iso-2022-jp?B?NE1OMlR1UUJISysyWTcybkljb0tTa01TZ2c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a5c079-e3de-444b-e968-08dae2f7ff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 02:06:39.0696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PbuODL/yQ2TzwtAMc/GsX/58BYj+XWIep92UqPFgYx55PUWeGXk8x4DAPobgCd+MFfn92baME3vOW8RgN/VyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8541
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_180650_675334_73D711CC 
X-CRM114-Status: GOOD (  12.20  )
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

From: Kazuhito Hagio <k-hagio-ab@nec.com>

* Required for kernel 6.2

Kernel commit 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to
allow larger rcu_head"), which is contained in Linux 6.2-rc1 and later,
made the offset of slab.slabs equal to page.mapping's one.  As a result,
"makedumpfile -d 8", which should exclude user data, excludes some slab
pages incorrectly because isAnon() returns true when slab.slabs is an
odd number.  With such dumpfiles, crash can fail to start session with
an error like this:

  # crash vmlinux dumpfile
  ...
  crash: page excluded: kernel virtual address: ffff8fa047ac2fe8 type: "xa_node shift"

Make isAnon() check that the page is not slab to fix this.

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 makedumpfile.c | 6 +++---
 makedumpfile.h | 9 +++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ff821ebd3eb0..f40368364cf3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6502,7 +6502,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && is_cache_page(flags)
-		    && !isPrivate(flags) && !isAnon(mapping)) {
+		    && !isPrivate(flags) && !isAnon(mapping, flags)) {
 			pfn_counter = &pfn_cache;
 		}
 		/*
@@ -6510,7 +6510,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && is_cache_page(flags)
-		    && !isAnon(mapping)) {
+		    && !isAnon(mapping, flags)) {
 			if (isPrivate(flags))
 				pfn_counter = &pfn_cache_private;
 			else
@@ -6522,7 +6522,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 *  - hugetlbfs pages
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
-			 && (isAnon(mapping) || isHugetlb(compound_dtor))) {
+			 && (isAnon(mapping, flags) || isHugetlb(compound_dtor))) {
 			pfn_counter = &pfn_user;
 		}
 		/*
diff --git a/makedumpfile.h b/makedumpfile.h
index 70a1a91d66be..21dec7d1145c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -161,12 +161,9 @@ test_bit(int nr, unsigned long addr)
 #define isSwapBacked(flags)	test_bit(NUMBER(PG_swapbacked), flags)
 #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
-
-static inline int
-isAnon(unsigned long mapping)
-{
-	return ((unsigned long)mapping & PAGE_MAPPING_ANON) != 0;
-}
+#define isSlab(flags)		test_bit(NUMBER(PG_slab), flags)
+#define isAnon(mapping, flags)	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 \
+				&& !isSlab(flags))
 
 #define PTOB(X)			(((unsigned long long)(X)) << PAGESHIFT())
 #define BTOP(X)			(((unsigned long long)(X)) >> PAGESHIFT())
-- 
2.31.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
