Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6546AC4332F
	for <kexec@archiver.kernel.org>; Thu, 24 Nov 2022 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=imhjzy5O2PVfLWmHdgKGmUmXZjGglBLZb+v70jJ9zP0=; b=nzVmlx25PBaay6
	e6TnE54EE8kh5BuCauIIRtPurdrkWYQ0jTbNmUIyLadz8y6mhXhaHME+m1guEVZCPH6Z+nVA/r/LI
	5VU+Y5uX0AFJif6A0Uv96W/s6CJu6T8TNT2n/ze8daatuzcv1xPwg7llkYs7Op1DPU48tTHAZrtxo
	wDXlKef/GxYH37DoxYIw9gexl3hIYtaaW7NmoXhq/bQYUOFlHIQW9Q8CvqNUW3j8q29LktYzcYETJ
	9jWdws+KolDvZbsyQuFmFvWdCeXX0XIQCFLWsOb34hVGKlhmHC0ON8FLAjAr2mt7bs1aI3M4GaB83
	/Xv75BoIfdXpyykQfqKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy0Rm-0039UP-EH; Thu, 24 Nov 2022 00:50:34 +0000
Received: from mail-tycjpn01on20606.outbound.protection.outlook.com ([2a01:111:f403:7010::606] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy0Rh-0039Rz-LP
	for kexec@lists.infradead.org; Thu, 24 Nov 2022 00:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwTmuPhI4KVtkwVpDxo9ylpLBwNt6EHRgX9nZFHGj1iRPWOE0w30KyjcKxncOfRs3+/isonHZluElWx8/lteNgFFFqE4vnRyHIYMKeVnfQLlg2yo4Fo+8P+4UC0FjCvCNlsSbZ9MmjaK+fORWPI1pqcbtRyMV631BCJYHrDq7cXpU3vt4IARGwtzc5tDFvgwanhwgC1FYgnZsl4aN1CpBQveO8YSw7nUD5V/MmQ5FADbcBz3yqI0BRDzfn8K1tvBHGYv7MSy0XVupEddjd3Tu89ZQ/YI822ionR1/6mlMdddaTn2Gf6VQuhkEJ+yqhZM8PoSSn2HjNwHMXAEVS05+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4+3uVhbJeaEJXRLXKh9/6eyKAt5wDNpXIoSwxqTCSM=;
 b=fjPu9IS69syi1SdWzMBOKAEgCgI4PrqkWb1LEs1hvk8ULH4K8JR0X5+Az4KFfAOy0JxsqUVR8KPlCLxmLs4PD2RxugsYK+0XIffXolw/RGSlI8xt6xWJrUCD+3aDk05iSVhRzUXgdakJbaq7Mt+bd5Q4itsBH3dqtbv3cW32tV3eK0CvwCYsYr0c+/HjY09maWdVm7aAN4LJ9QyeOLPB2JIOMAsAUhArYOC4L3d8/T0fV9mOi3efZGSpCifgvLEQ+Qbv49guJ7E7spjfj9YDZ4eOQSjJBrBQcILTvv0yvj/P8DavNKgYLFsetkmmxNq4fwvwz/1BcB4hxIq1/sRvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4+3uVhbJeaEJXRLXKh9/6eyKAt5wDNpXIoSwxqTCSM=;
 b=ijh+eEtk0GrW/9cnW+9SPsW3XXtHISlllpXZ6Yw6gIaSgBMrEwvhIiqwvdRYvi3SUJsPQOL/DLSU2/xMtzIjVP6rVauM6TX02Qqo1gmAwY24H02Hq0oDtcsK9LByel1OEAMHEEsiASv0ZFS93M8PW+3Szz03T+v95UB+hPKYOhg=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB10682.jpnprd01.prod.outlook.com (2603:1096:400:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 00:50:23 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::5905:d55d:b34b:addd]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::5905:d55d:b34b:addd%5]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 00:50:23 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "fontaine.fabrice@gmail.com" <fontaine.fabrice@gmail.com>
Subject: [PATCH makedumpfile] Handle __mips64 as __mips64__ to avoid build
 failure
Thread-Topic: [PATCH makedumpfile] Handle __mips64 as __mips64__ to avoid
 build failure
Thread-Index: AQHY/5677QQcSmDF70C8kby7nE8wjA==
Date: Thu, 24 Nov 2022 00:50:22 +0000
Message-ID: <b293ad8c-b380-4d6d-199a-3b9a496eb005@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB10682:EE_
x-ms-office365-filtering-correlation-id: 3d724f61-053d-489e-bf5b-08dacdb5de5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  LuCSQjs5XAgGfd553C2GdY1RyOG6ZCkMP4Yl1JNYrW/R6/EwR3w5szivTW6QlJx75sGhaduHWn/vrbjMRDdtwTbN8SdW3HRx6YG//RjvYdGnwk2D4E/lo4GlUNO7ilyfupYmiV90gHLu/PIMtlmxevPI+aWgnLhnQ17/0VXVR9u01QryBATTOczC5QA4UzzCmxjDpRaX5F+hrDB9gOQokxHDBBfxYgXH3KQZRv/lEhEOHEkb14wvqzK6+1I3SSaryLtik9AXRrcosvFgl+n2JsOvLtLg9PQlRnlmktf+KKtNGAYdG/TGqDZoq68u5NVCddgdMTJ0dWfjoRO4pB7kp9uXdkb1h5PJwp525pHBbmV7UKzjl74+kFvm+v8h9zyA6A4TRvin85w9G+kDTXE9f9Ap9MtAjzvb66ra8KsOhUkW9qXIwOEmz9STwAmNGzzqYgnPnroVTpTybe+uPRF/vpfcTjVzzXfCs5AeYMxtfFZEjY4OwkXNY1xkoPHQMnQSPhCsLSVXtuxQnEhFt7iexYCUZ19kXWuyiS5pYoI9PHs0g23K/WbMKwKXUjGhuaTz17OA2RtlpHnmGGDN48aqh94tUu4wFz2Usw0jp2ns/Rl7SeUQAaEHupNQy6jkCIDjGPZhS5POqVgiEvmp5iRWkTvdpFr9AEU8JWqgBJhFxbASsvW4J8johx8dIPYQzoG2x54gC05WzpBjicQsQmlOHgibZt6t/u+wKKAsYxpsOEevl6CSSTvmkMnSA8oUEMjYOOxkTyHGdsJQaTmNsoJ/Kw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(71200400001)(8936002)(5660300002)(2906002)(83380400001)(55236004)(66556008)(66946007)(66476007)(66446008)(64756008)(76116006)(26005)(316002)(86362001)(6916009)(6512007)(2616005)(31696002)(41300700001)(186003)(6506007)(4326008)(8676002)(85182001)(36756003)(38070700005)(38100700002)(966005)(6486002)(478600001)(122000001)(31686004)(82960400001)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TW1LdS9KMmo2UXJYdTZwdHUvRlFuNXN4VFpndWovc0cxV1BMR0F3eWxsUjNL?=
 =?utf-8?B?TnRmZXdSczgzcFZrdWNEemVEUEp4L3RDeEtEZWpnN2ZyWDl2clZZYys1UXRE?=
 =?utf-8?B?cW0rWE13Z2tJZllXUFBTcTdhdmdsRndzbWJQYy85SVN6OXNJYzZER3NBeEly?=
 =?utf-8?B?YWtpcDBsMzE3Qk1KR01lMCtHNW1qNkQwcEhKWUtMU0FoUHllNHJDVGdCUEl0?=
 =?utf-8?B?LzlNT0hOczhUaUhyNFRyUTBnQm1yajRVcldsRlpDNmFuakJIaWNLWW1MUkRB?=
 =?utf-8?B?MSs2YTRRRktVQmhDMThyT3hQcUVGbjB3SnZDd0tuMlB3YkJYdTEzV0ZjeU5r?=
 =?utf-8?B?UitYdjFjMkZFbVRYMUQ3SlljQlYzaUsvSzdRdE54ZVlSNTRPV3FlMlo1cjFB?=
 =?utf-8?B?OE9PV1d2RnpXR0U5OVpMV2ZDZDRYMmFPSUU0andYZEJSOCt5NDQ2WjRaeDBL?=
 =?utf-8?B?cWlURzBLbUlpL05sL1RmdjA3TU1QQzhQM3FpZDFDakNKOUIvamJZRWtkZmcy?=
 =?utf-8?B?SEtDTzJRdHFmSmdLSTF2eE1oQWlNQXo2NWxKZXVYY1NTMlJKb0RzRkVBcFhX?=
 =?utf-8?B?YXF1RERJT3dLVUJNU2NqWlV6NkJNTzNaYnVWV0U3eUtncDZDc0l1aTA5Visy?=
 =?utf-8?B?ZDNmVDVBVGo1dmh6RzVkT3hRd0xhcU9pMVpKL3FBc1FVdTkvY2NtaUJ2RXYw?=
 =?utf-8?B?ekE1Z0hJYXdNd0EwN1Y4c1dQTmNDV1ppaHBwc21iNTUzbEFYZlVCWTcvbzZ3?=
 =?utf-8?B?bGhIWi9QK1RoeWo1bGdmY3BpZjdmYThmM0lSMm9sUG5QVXIrZEliMndxSFkv?=
 =?utf-8?B?UXhtdG94OWkzWnBoQWFuanVldTE2UUpPelB4M3l0VnFiMExEMU53eW5vS3Qw?=
 =?utf-8?B?Q1JrckdTc2pkamd0OXVuampDcUNBVHpjOWR1L1ZDYlc1Z0NhSWhxV3NrU0xR?=
 =?utf-8?B?OEY0VVhDT2NGYmRzdEFsLy8ybzIzb2JQa2J1aE0vY0crUnk2RFBiL1hhRHoz?=
 =?utf-8?B?aFkrMDd6YkZYK2RhVkwxMXdMTkQyNUlzcDJZL0ljRHJJckdSbDdLM0NaaWRr?=
 =?utf-8?B?TklIZ29iTEVDUFlNUStoaFN6WDlwbFFNZ1o4cTkrM0p5aGVocVV6d1pURWZC?=
 =?utf-8?B?WEtSTW5IQlR0MERmZVZjOHZUYjBLTlVoMWVmNytmeXdGS0dYSVRra2dCdDJt?=
 =?utf-8?B?WWQ1Y0RMc1Q3cnFYUzM4MmhMYnJhRXB2cjlBZW9VNVp5RmFyMG14bFF2Tmlk?=
 =?utf-8?B?Y1ppeFF5WE9za2Juc1NrL3Q0d2tZVkFwa0ZEVjZJcGMwMU1oUHVINzRJZkJp?=
 =?utf-8?B?QWwwQXg0UTBQTHlLaGtGRzlKZFJaelVNSTdGSGlOL1BRSDBmbmdxVEo2NzdN?=
 =?utf-8?B?diszVFdkdG1ITThQRUtlajRibFlkckJLSzdXQ3lOamRDQUhqK1Y0emV0RWNG?=
 =?utf-8?B?N1g0ajVTVnhrSXhpS2M2RlZKZi9rUkZiWnkyRVRkay8wbWlIRlplR0lFQ1Zl?=
 =?utf-8?B?M3RSb052TlhTSWVNbXIxODdxOTczSDJra1ZXZG83U3ZuY2lzYmhwNys3S3pk?=
 =?utf-8?B?LzdURVE0dXBlVjYyaWErTTJOd3RLV0pGUVdXRURMQkhVYU1janhjclNWK3J2?=
 =?utf-8?B?QXhwYXVhK1ZWdzB3WTN3TkFZOWVQLzB6L1NheVZNVWVkU1FEcFM2TDZDQUNn?=
 =?utf-8?B?NmdJeU1GallYbzhyMGdmVTJpWk53bnk1VG1TR1JhcUVNUEE5M3FxS3BYN08x?=
 =?utf-8?B?ZmVOTlhXZnJBNVE4enFFM0k4M0lha2NCbXd3OFduN05ybUR0dHZyd1Y0VytM?=
 =?utf-8?B?VHp3em1GOGlNaW1UWHhOZ2NQTzA1cVVSaFU3L0hxQXY2VXBRck1xY3hDRXcw?=
 =?utf-8?B?cFVPUENlVlpaOHlTNEs5Q3FtaHJZeDNyUTM3TlVuVDZ6K2NKdkpiOEM3aWxS?=
 =?utf-8?B?ZlJ3UHlaOUtRSXJvdzZXd3p1VytXcHdieHlqRVBadnFKdXNyemVybHYvbWVz?=
 =?utf-8?B?VDhUSmV4c0x1L2lHZnhUc0hwOStnUFV2Z2pXVTFlNUMxZmtWL2tqYWN1ZUQ5?=
 =?utf-8?B?M3VXQlkzbjVTallNd2xKa2VScEdvNTc3RUlLZDJQOUZWWTVhQ2pvTmFsUHdw?=
 =?utf-8?Q?OFN4NESguW1AxbWH4hXjN+k2F?=
Content-ID: <544C4D458533AE4982B43DFE5F6D716D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d724f61-053d-489e-bf5b-08dacdb5de5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 00:50:22.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1d95JAXaSMVA+THOyB4wgkLuK2xm7ShIyq2MO0DTyP1E3hquEgnu7nmUhhE/SSmshcvfUS1x7hqsu+o7MtLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10682
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_165030_153910_938B15C3 
X-CRM114-Status: GOOD (  13.19  )
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

From: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Handle __mips64 as __mips64__ to avoid the following build failure:

makedumpfile.c: In function 'is_kvaddr':
makedumpfile.c:1613:39: error: 'KVBASE' undeclared (first use in this function)
   return (addr >= (unsigned long long)(KVBASE));
                                        ^~~~~~

Fixes:
  - http://autobuild.buildroot.org/results/94824fa8baa8edb99a5ca245e5561e0c4e430638

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
  arch/mips64.c  | 2 +-
  makedumpfile.h | 6 +++---
  2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips64.c b/arch/mips64.c
index ab45b6e..fd987b0 100644
--- a/arch/mips64.c
+++ b/arch/mips64.c
@@ -16,7 +16,7 @@
   * along with this program; if not, write to the Free Software
   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
   */
-#ifdef __mips64__
+#if defined(__mips64__) || defined(__mips64)
  
  #include "../print_info.h"
  #include "../elf_info.h"
diff --git a/makedumpfile.h b/makedumpfile.h
index 70a1a91..3842f9c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -963,7 +963,7 @@ typedef unsigned long pgd_t;
  
  #endif          /* sparc64 */
  
-#ifdef __mips64__ /* mips64 */
+#if defined(__mips64__) || defined(__mips64) /* mips64 */
  #define KVBASE			PAGE_OFFSET
  
  #ifndef _XKPHYS_START_ADDR
@@ -1204,7 +1204,7 @@ unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr);
  #define arch_crashkernel_mem_size()	stub_false()
  #endif		/* sparc64 */
  
-#ifdef __mips64__ /* mips64 */
+#if defined(__mips64__) || defined(__mips64) /* mips64 */
  int get_phys_base_mips64(void);
  int get_machdep_info_mips64(void);
  int get_versiondep_info_mips64(void);
@@ -2364,7 +2364,7 @@ int get_xen_info_ia64(void);
  #define get_xen_info_arch(X) FALSE
  #endif	/* sparc64 */
  
-#ifdef __mips64__ /* mips64 */
+#if defined(__mips64__) || defined(__mips64) /* mips64 */
  #define kvtop_xen(X)	FALSE
  #define get_xen_basic_info_arch(X) FALSE
  #define get_xen_info_arch(X) FALSE
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
