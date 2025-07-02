Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3511FC83038
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 04:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WlKmP/29WizQlimvRDStAu5w0DiXyWNnU6BsrRO3Djo=; b=tPAR60D+c1OSbg2jqwDwbGzrDj
	F/pEhPjDV7hIYPn7G58exO+4a+KNwwZ+vNqEjJdItKOZUuAjO/425lAYeY891viBwQ2se5Y/b/RoZ
	8EfWNpugJsZtLpypXQbcLy8ti39F8xduP6mJ1e5pPBcpaCeMBpYpEB0RM6pioDsyr/Ys3pLPgVdNv
	sO/FRv6kL+x6Kle+QvXVSqdQeLfSag6U+W0MM8xdJxCXqEbb8v7N8nKs9MD5By4jTsBAJ/Kt7czmX
	/yS4uIhR0OhmWQvPvv+jWFnHIrBEgQ8+W/gIrY2GYrq/Mokjp3zapfQAqzlV3EEYYSIcP4cLVkLPY
	+lxONFlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpSN-00000007DMR-2iwr;
	Wed, 02 Jul 2025 04:52:27 +0000
Received: from mail-japaneastazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c405::1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpSL-00000007DM3-0LAl
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 04:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcIY/Io96B8DYsAUZiRg4TnwJtuuBz65yAVC4USOGWLMlDG5Uzxk/ipqudG3Ihh5wNHCyYeSJJ0gHa1ZwpPbVi5MA86e4losvH6alPM1/ARNl+lsc3nWJFe27L4TFsxwdzfxGIT12Bj5Uh7uSqPSBlJi6C9WLff7MeW1IBnz/it4IHIzq+MtbwvuprymRUDH9/6UTiM2Pkrf1IPGOYuV3c4gbJPXsFbfbZFnq9vh5THWBSYcOdLQq8nWpW9VzCiI/ci6cdRqb7it38rQUXhU+H9Ausj5YscTMRZdq5PqH4Qgtmu9NNSWVyNLQqcPe8Vz+AgGC+1/qyXmlnLUCwbz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlKmP/29WizQlimvRDStAu5w0DiXyWNnU6BsrRO3Djo=;
 b=MTlIdh55VA8qHnLjhmCcOi+keVSTIxt4BVuKnoJr/TE8j+sEF4cWhNPjjtGxOKsnq5Oc8B9MFUBjCuRBjNYEgAuz/ZNFT0GG1i1GuCVTQXasmfC7fRBiDFU2sCAyxQKfJuiczgoYzwp7xfNQ7/HfQ1u5Bg1GmDc+bp8RMrqpY627i4HX6Nmc5UMYVkpvZkCXDypbAev5WQG+hg518lxFZqjvxLzfa49h8JQEfaNO6Dvl3WnB3yNo6Kmpb4w3w6G12/Gr3HG1Vh5Vu+nmbuac3oaKH3tAw7F4hOGKzPP6PGlje0GWRQ9jFxC7mTnzhUb2ltlW0PTcbbF7U0O3dWFvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlKmP/29WizQlimvRDStAu5w0DiXyWNnU6BsrRO3Djo=;
 b=VzsF86mD/6QVZnJ40EC4XD5vwfepWc1M9DbBQ2y4SfFLMOGmywH5uoOP9W+VkFnQ4eT/BkXWDpAXAtlvjSRRf/Brw4sGfRftNlaxgBzapL73GDzy2Iqqb+SERbTqwqDOg3w0w7UbJjCwv7rM1F2+EXwKHn7Gt9v/8SuHiJGCNJoDkakKiA/Fu3K+L6PqK2uxz+AhZOqBtceL/inTBuJEFmZqeDOCXvWtL0THQP5vRTQiABSRftS2Kf26Eqxn/E+RtlP4Pw2Iu3kA6+Dmp3GIDSUP2Q5aCSuBB1zIjBzQfH/V3KywEZP8g0aLC5ku990qfqGcXjkxMhYMnyp8lmIqyg==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by OS9PR01MB16423.jpnprd01.prod.outlook.com (2603:1096:604:2bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 04:52:15 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 04:52:15 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "sourabhjain@linux.ibm.com"
	<sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Topic: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Index: AQHb5XiBHM/FX67D1ky3gbRMCQy+FbQc6x0AgAAGMoCAAQ/0AIAASZSAgAAEXwA=
Date: Wed, 2 Jul 2025 04:52:15 +0000
Message-ID: <e78c8c33-5718-4218-89a3-ea4d7e3a6c64@nec.com>
References: <20250625022343.57529-2-ltao@redhat.com>
 <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com>
 <CAO7dBbXweDPUpsEDYhFZqf-eAALGrFOBJh-=bQAYMUsj2ioNpw@mail.gmail.com>
In-Reply-To: <CAO7dBbXweDPUpsEDYhFZqf-eAALGrFOBJh-=bQAYMUsj2ioNpw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|OS9PR01MB16423:EE_
x-ms-office365-filtering-correlation-id: 66512352-71b8-4d27-2167-08ddb9243760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q083R2lUU0Y2ZnZoR0wrNXJUWUMwaWl4SVNhTkhTM3VsOTJ3V2FEVUN3SVB5?=
 =?utf-8?B?UTFEalFmVk1ydzZDY0ZZU1N0WXd2aWh4RjAzNnh0cVdOQkpybS9EOWkyZDZE?=
 =?utf-8?B?WVRLQkpzR0QzSDZWMFh5L294anAwNlhYNGxtQzRHR0FCSytBZk1xS2NzMlpi?=
 =?utf-8?B?OTBWcVV3bUVDK09wMnpGckxFbkY2NnBUR0E1ZHM1clVRUVFSaEd5TFVpMHdH?=
 =?utf-8?B?cnhOeTVnenBrek0yS3Y0NWk3SkI4NmRxWjZTUG5adnpVYUllTzdqK1ZuN2ZY?=
 =?utf-8?B?UnNpOHZiUlBlaGlBVFIyZVJOT1RXZHI5RzVQSGVuRy91NXdBTE56K2VxQURW?=
 =?utf-8?B?cHFkTXBQZFBZRW1LRE1wdjdOSEN2Y3JVNDJ6TTNwVnVwZ2xyR1g0VXZHRWdY?=
 =?utf-8?B?cU8zbUQ5QWtQckFQcFprZjRjY3ZLcE14bFp4Zm1oRFBPU1RkM2tOQ1hEcUdB?=
 =?utf-8?B?V05GWGRQNW0xY1lsZklpSGNYbE5sSGZhaDR2OFhKK3QrbVFqWm8xK05FWjQv?=
 =?utf-8?B?T0ZmMkZjOHNkVWlGM0ppc0ZOSjg1K3puaWdYeGtrTFh4N1VrdWJ5UUhmeUcx?=
 =?utf-8?B?OXNnaGxlZk9mNDdkUlZ3VVdaK1BJa1Q2L0l2RDljdlFYZjZCNFdnNmJENzdh?=
 =?utf-8?B?VGlJTE1UQXcyaGRscFROTkF6dndxbnROdldhWEVlaG9CeVRtS1p1WjFDM1Vn?=
 =?utf-8?B?QmNxc2k1M0lDb3JheUkzd2lieFM4STJuNUZoTE92dEV4NGRLVkpIb0ZHcnBQ?=
 =?utf-8?B?YXRBcTZpRzY3Qzc5TkZ4bGd5aXZoYy81NDFWYWdHMEZjMWYyRjZ4Zm10UEZn?=
 =?utf-8?B?WmJSNmVrcjk3eE92WFhKd24vVWk5TnlHeXhpM1Vub29zaEQ2eEE3ekd5MUsr?=
 =?utf-8?B?SW5QdkFtckIrQmVqWTBRR0VkTTRKOFB5ZXBNYUtiSUdBNFV0L21BY0EzSjNG?=
 =?utf-8?B?N1UrNlRVNFlYS3FDeXJYL0R6VDNOZkNuTFdjdVFpdXJ4Zk5Pc2VyNG9BMmJa?=
 =?utf-8?B?NkE5V1gyN2RINFloUVJLVnZ6TGZBdFJXMlF0VWlFcmhzR1dwaGlCVGZvNnhK?=
 =?utf-8?B?NzlWd2pnODZRbGFqODlvVGhPcnVEMWY0N09ESEJSRThKbVV1ZHdHeXRYNDJp?=
 =?utf-8?B?ODN3QTc4N2xUcjlHc3ZSTHpCYzNiNDBpRlBPMnRJTnFNNjZ0clZzUlp3N0tZ?=
 =?utf-8?B?QmdVSnN6REhuZzJBbG90a2QvRktFUW5rWktqVDR6UzlUcGdGV0drMCtESDdJ?=
 =?utf-8?B?emRDS2lCWEZTQURsZVpFWS9IaThSWmNpeE13Z1Zlc0JNdlc2ckJIdlBOMzJy?=
 =?utf-8?B?UVUzUGNYTHB1THVCZW9iZHM5MlloQld4TnFYa0VzNjR1R01haUpkR2M2M0Er?=
 =?utf-8?B?UnRyZkl2Njh6ZVZTenBDY2h2N3ptQzJDMTVBQXpYOW01WVZjd0MzLzl6eUR1?=
 =?utf-8?B?WlVwSFE2MkpGRG4wb3VhUW5Lbnc2cTVnUGNpWi92ays1eThHTW1uWVVqWXgy?=
 =?utf-8?B?ZkFYdWlWWEhpeUtCZVQwOE93WHd3SXA3ZTJ6eU1GR1JKNnZXSGZWd3owOU4y?=
 =?utf-8?B?QTdIQ0RlWlFCWU13Ym1TUVYrTXhTNkRZRUszY2ZNVkY4b29RVVMvZE5WY1Fv?=
 =?utf-8?B?Y09jVStRVkJiNzRrL201Y2Z1d1U1WkFuWWtZQ3ZYUHltSlcvOVdtVUt2QVNR?=
 =?utf-8?B?MkdkWmJPMjhXVHo1eGMwK2cybC9tejNHNW5pY0luOCtWOWM5NjhjOW1PdXNJ?=
 =?utf-8?B?ODBzNG81ZHdUQ2xpQ3NwMFB6WlJ1cDIxT01FMjU5ZEQzeWVmcjNiMS9QTEtE?=
 =?utf-8?B?OUlLK0gyVE5qcU00RGovMEd0MmdVdnJjcFVBRFAwTTdwYXMzY0RlbE5xR01r?=
 =?utf-8?B?dnJtTEJNb252Z2F4YTY1UzBFemd5VmlNb3RBN2xwZ3VZVWtscEV5eXEva0JH?=
 =?utf-8?B?RFlNY3M3amJOb3A5TC9IQW9VcjhxdklsWnZEWGtGdnprUGphYytkUW1iZno5?=
 =?utf-8?Q?RujAmrVa2cNIiv6GEjTBcKaN3UxY1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVRNamtJeXppR1REcG40SGlxNzlnSHQvaXJ5MHcyb0ZablA3c1FxNWl6REVG?=
 =?utf-8?B?cjJ6SjFSUG9SaXpxMy9RdnkrT0lkRVB2KzFVMU52MUI3OGExOFNCVHVpQllX?=
 =?utf-8?B?R2pVWktHWlVhZnpqTWJWTVRYelRFQ1pLYnNtOXgxelJuUUZuNFEycFE5OURZ?=
 =?utf-8?B?Y25zSFVkKzJMaGJkaXNSVTVzSGxTL3hLa3BxdXFDMGUydjR3akpNQVBRUFhM?=
 =?utf-8?B?UzdHczhOcGlwRDR2QWp0SWV3aDNkcmJ3cWxSRHd0RXF1Q3JDVnpiQkNuS0tm?=
 =?utf-8?B?TFNmaTkvTEV6T1pXenZSUmVPNUVHYXdvb3Y2ditPSDZrWExkNUJWRWR6VWhM?=
 =?utf-8?B?Y3lrRDV3anJPbFVITWhsTDJ2cHFxUWx0VEZlZExjTE54ai9uTEVXU1ltWThH?=
 =?utf-8?B?R0NEeXFXWDdQYXRTNFhadWw5Zk4ydlFsVEVERnRuZ1l6bk9lN3JuczVRTG1j?=
 =?utf-8?B?NThtU2syd0ZsQ1RJTDJWSkpLMmZjeGFKL0o0NjFKZWlEUkNUelJRd1JheXlT?=
 =?utf-8?B?dngydEJqSFU3WEZLNEFPb3kyMm9UMFZlZkpRWGxTNlE1RXJnME5aeUVmN2Mx?=
 =?utf-8?B?MnQ1clpKNnRpUVZKanlqV0gxZTBiVTFXWTBXdWRjc3V5VHM2QTFRSUNsUXli?=
 =?utf-8?B?azBaZnJYdmR5WjN3UjQ3cmw5eDZ4VURwMkZJazVqeFQwa2t5Y3VyVEFsbnNX?=
 =?utf-8?B?QlhnZmI0K2tVQ0xFa2pCMnN3YkZKRUNRMkZUbnpvY3l6Y2dwNFFwVkluT2pC?=
 =?utf-8?B?R0UvSFllT2YvTGZJdTF4M0plb1M5WmFYbHE3OEEyVVVjR1pnU1ZkYnZnSWt2?=
 =?utf-8?B?TWFnVS9aYlBuTldFY3Q3Ynl0dCtVTXM3ai9hNnZTd0hVWllyM0ltQmxabjZq?=
 =?utf-8?B?ejhWQU9DS0tScjFSTzVPNG5TQ0RCVmQwRWR1c0k5ejdGRlRSZzJDVm4zT1Vk?=
 =?utf-8?B?ZzYxcVJLUkdhbVArT1J2VHhGYXU0Z2lqTGxKVEdSYXRZVC94YTQwTnJoc1Zw?=
 =?utf-8?B?bXhOUm9DS1dZWGU3aEN0NDU2L2xlK3NQdFhJZENGS1FQN1MrMFgyak4xL0Yy?=
 =?utf-8?B?UmcyWUNmM3Z6MGJuSm1FdUtaTUFmbW1LS2RwVXh3ZVUzSTZBaGMyZjRXL3Qr?=
 =?utf-8?B?WHY0b1JuUE9KNVd4WXZMVkY2V01rWVJvUzVDMVNXQjZqMEpwMktNZEZrcWFu?=
 =?utf-8?B?WlhkTFIxNEt1OUhNS0ozZjcwVUFkbnpQeXRaclZZNUc5REQ0ZzN5VmdsNzdL?=
 =?utf-8?B?Sm5SY0ZrMXFBclBCVmdtWVh3VE8xcm5UZ1kxVWhGamRQUWszSTJuZmtXRWN4?=
 =?utf-8?B?WlVTSU5NV1pwWmJsMndxUXBzRUJDQnY0OW1zbVBwYzY2ckNwVUdpN0N0dnA3?=
 =?utf-8?B?RGlPbmN6NU0wbkF6cGFmWUI2UEpKTlA3RWM5TW1vV0JseGlGMlJhVUNyVGpP?=
 =?utf-8?B?NTVUU0dlTFdxNjlZa2ppUzRlUDVGbWd2V0I0RHhjQURnY1ZRZzZicmZRS0Uv?=
 =?utf-8?B?SWQ5RWdUcXhYS3FxSWwvdi90SlZXQTIxd1Iwb3E3eHZTYy9GU1pnd3RSb3Zt?=
 =?utf-8?B?dHNHNGcwNXZiWnN1bFVSd2dlcWJFRXFjdFcwNXV0dlNtMm0rcFkrUDBSbEVP?=
 =?utf-8?B?ODFxK2I1VVVhNW5IVjduTCtHeldlNHRkS2tZQ09Zcm1FelcrSXRoUVQ2NXRn?=
 =?utf-8?B?R2pLSGZmbmVaRzhxZERXQm5TUXc5WjJpM0NzY2pmZklIUXgvelEwR3VtTlZj?=
 =?utf-8?B?UElGSFo4QTZBclNDOFM5cTMxb05IajBuVVp1TCtJYnZnWG9aSlFwZ1VCOUN4?=
 =?utf-8?B?K3Y0NHdCK2MwWFFPc3ZiNklSZ3pZSlZ6V2txRnF5WVNnWURYZlREZzJ1c3Qr?=
 =?utf-8?B?WitURjd3bnhUUnBnT3RZdldDNkZDTkx0Zzc3QVpHN0dTNGFENUZDbGVVbExm?=
 =?utf-8?B?TGhLUkttUERYVVI3K3VJaUZ5UmtEbi8wVFYzRzFoYnJMZ0N1WnN5T2VZRTBy?=
 =?utf-8?B?Y3RLVzZ3dlFrRnphS0dlVnRBQ0dReE9oS3JLK3RmNTQ2N2Rmcndpd2hFM0ly?=
 =?utf-8?B?Q3hzZHZCaFpya0xYTGY3aDdabm94R1NiQTh2L2JzN21nRDBQWTZpN1h2WFpr?=
 =?utf-8?Q?Ruz0PB3a4alVBkjXwRqCxRMZB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E25C1400EAC1C2418073E0B1EC21314B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66512352-71b8-4d27-2167-08ddb9243760
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 04:52:15.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7pGuOr0NwFG52YaGSbFt6Hau4OYwylLf5GfC1ZB0iclbudzeuB2beeInyoXrcUtr9wiUcZFU7Y4Eogu3BoUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_215225_524367_4D680767 
X-CRM114-Status: GOOD (  23.09  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgVGFvLA0KDQpPbiAyMDI1LzA3LzAyIDEzOjM2LCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBLYXp1
LA0KPiANCj4gT24gV2VkLCBKdWwgMiwgMjAyNSBhdCAxMjoxM+KAr1BNIEhBR0lPIEtBWlVISVRP
KOiQqeWwvuOAgOS4gOS7gSkNCj4gPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
T24gMjAyNS8wNy8wMSAxNjo1OSwgVGFvIExpdSB3cm90ZToNCj4+PiBIaSBLYXp1LA0KPj4+DQo+
Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KPj4+DQo+Pj4gT24gVHVlLCBKdWwgMSwgMjAy
NSBhdCA3OjM44oCvUE0gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKSA8ay1oYWdpby1h
YkBuZWMuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gSGkgVGFvLA0KPj4+Pg0KPj4+PiB0aGFuayB5
b3UgZm9yIHRoZSBwYXRjaC4NCj4+Pj4NCj4+Pj4gT24gMjAyNS8wNi8yNSAxMToyMywgVGFvIExp
dSB3cm90ZToNCj4+Pj4+IEEgdm1jb3JlIGNvcnJ1cHQgaXNzdWUgaGFzIGJlZW4gbm90aWNlZCBp
biBwb3dlcnBjIGFyY2ggWzFdLiBJdCBjYW4gYmUNCj4+Pj4+IHJlcHJvZHVjZWQgd2l0aCB1cHN0
cmVhbSBtYWtlZHVtcGZpbGUuDQo+Pj4+Pg0KPj4+Pj4gV2hlbiBhbmFseXppbmcgdGhlIGNvcnJ1
cHQgdm1jb3JlIHVzaW5nIGNyYXNoLCB0aGUgZm9sbG93aW5nIGVycm9yDQo+Pj4+PiBtZXNzYWdl
IHdpbGwgb3V0cHV0Og0KPj4+Pj4NCj4+Pj4+ICAgICAgICBjcmFzaDogY29tcHJlc3NlZCBrZHVt
cDogdW5jb21wcmVzcyBmYWlsZWQ6IDANCj4+Pj4+ICAgICAgICBjcmFzaDogcmVhZCBlcnJvcjog
a2VybmVsIHZpcnR1YWwgYWRkcmVzczogYzAwMDFlMmQyZmU0ODAwMCAgdHlwZToNCj4+Pj4+ICAg
ICAgICAiaGFyZGlycSB0aHJlYWRfdW5pb24iDQo+Pj4+PiAgICAgICAgY3Jhc2g6IGNhbm5vdCBy
ZWFkIGhhcmRpcnFfY3R4WzkzMF0gYXQgYzAwMDFlMmQyZmU0ODAwMA0KPj4+Pj4gICAgICAgIGNy
YXNoOiBjb21wcmVzc2VkIGtkdW1wOiB1bmNvbXByZXNzIGZhaWxlZDogMA0KPj4+Pj4NCj4+Pj4+
IElmIHRoZSB2bWNvcmUgaXMgZ2VuZXJhdGVkIHdpdGhvdXQgbnVtLXRocmVhZHMgb3B0aW9uLCB0
aGVuIG5vIHN1Y2gNCj4+Pj4+IGVycm9ycyBhcmUgbm90aWNlZC4NCj4+Pj4+DQo+Pj4+PiBXaXRo
IC0tbnVtLXRocmVhZHM9TiBlbmFibGVkLCB0aGVyZSB3aWxsIGJlIE4gc3ViLXRocmVhZHMgY3Jl
YXRlZC4gQWxsDQo+Pj4+PiBzdWItdGhyZWFkcyBhcmUgcHJvZHVjZXJzIHdoaWNoIHJlc3BvbnNp
YmxlIGZvciBtbSBwYWdlIHByb2Nlc3NpbmcsIGUuZy4NCj4+Pj4+IGNvbXByZXNzaW9uLiBUaGUg
bWFpbiB0aHJlYWQgaXMgdGhlIGNvbnN1bWVyIHdoaWNoIHJlc3BvbnNpYmxlIGZvcg0KPj4+Pj4g
d3JpdGluZyB0aGUgY29tcHJlc3NlZCBkYXRhIGludG8gZmlsZS4gcGFnZV9mbGFnX2J1Zi0+cmVh
ZHkgaXMgdXNlZCB0bw0KPj4+Pj4gc3luYyBtYWluIGFuZCBzdWItdGhyZWFkcy4gV2hlbiBhIHN1
Yi10aHJlYWQgZmluaXNoZXMgcGFnZSBwcm9jZXNzaW5nLA0KPj4+Pj4gaXQgd2lsbCBzZXQgcmVh
ZHkgZmxhZyB0byBiZSBGTEFHX1JFQURZLiBJbiB0aGUgbWVhbnRpbWUsIG1haW4gdGhyZWFkDQo+
Pj4+PiBsb29wbHkgY2hlY2sgYWxsIHRocmVhZHMgb2YgdGhlIHJlYWR5IGZsYWdzLCBhbmQgYnJl
YWsgdGhlIGxvb3Agd2hlbg0KPj4+Pj4gZmluZCBGTEFHX1JFQURZLg0KPj4+Pg0KPj4+PiBJJ3Zl
IHRyaWVkIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUsIGJ1dCBJIGNvdWxkbid0IG9uIHg4Nl82NC4N
Cj4+Pg0KPj4+IFllcywgSSBjYW5ub3QgcmVwcm9kdWNlIGl0IG9uIHg4Nl82NCBlaXRoZXIsIGJ1
dCB0aGUgaXNzdWUgaXMgdmVyeQ0KPj4+IGVhc2lseSByZXByb2R1Y2VkIG9uIHBwYzY0IGFyY2gs
IHdoaWNoIGlzIHdoZXJlIG91ciBRRSByZXBvcnRlZC4NCj4+PiBSZWNlbnRseSB3ZSBoYXZlIGVu
YWJsZWQgLS1udW0tdGhyZWFkcz1OIGluIHJoZWwgYnkgZGVmYXVsdC4gTiA9PQ0KPj4+IG5yX2Nw
dXMgaW4gMm5kIGtlcm5lbCwgc28gUUUgbm90aWNlZCB0aGUgaXNzdWUuDQo+Pg0KPj4gSSBzZWUs
IHRoYW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uLg0KPj4NCj4+Pg0KPj4+Pg0KPj4+PiBEbyB5
b3UgaGF2ZSBhbnkgcG9zc2libGUgc2NlbmFyaW8gdGhhdCBicmVha3MgYSB2bWNvcmU/ICBJIGNv
dWxkIG5vdA0KPj4+PiB0aGluayBvZiBpdCBvbmx5IGJ5IGxvb2tpbmcgYXQgdGhlIGNvZGUuDQo+
Pj4NCj4+PiBJIGd1ZXNzIHRoZSBpc3N1ZSBvbmx5IGJlZW4gb2JzZXJ2ZWQgb24gcHBjIG1pZ2h0
IGJlIGR1ZSB0byBwcGMncw0KPj4+IG1lbW9yeSBtb2RlbCwgbXVsdGktdGhyZWFkIHNjaGVkdWxp
bmcgYWxnb3JpdGhtIGV0Yy4gSSdtIG5vdCBhbiBleHBlcnQNCj4+PiBvbiB0aG9zZS4gU28gSSBj
YW5ub3QgZ2l2ZSBhIGNsZWFyIGV4cGxhbmF0aW9uLCBzb3JyeS4uLg0KPj4NCj4+IG9rLCBJIGFs
c28gZG9uJ3QgdGhpbmsgb2YgaG93IHRvIGRlYnVnIHRoaXMgd2VsbC4uDQo+Pg0KPj4+DQo+Pj4g
VGhlIHBhZ2VfZmxhZ19idWYtPnJlYWR5IGlzIGFuIGludGVnZXIgdGhhdCByL3cgYnkgbWFpbiBh
bmQgc3ViDQo+Pj4gdGhyZWFkcyBzaW11bHRhbmVvdXNseS4gQW5kIHRoZSBhc3NpZ25tZW50IG9w
ZXJhdGlvbiwgbGlrZQ0KPj4+IHBhZ2VfZmxhZ19idWYtPnJlYWR5ID0gMSwgbWlnaHQgYmUgY29t
cG9zZWQgb2Ygc2V2ZXJhbCBhc3NlbWJseQ0KPj4+IGluc3RydWN0aW9ucy4gV2l0aG91dCBhdG9t
aWMgci93IChtZW1vcnkpIHByb3RlY3Rpb24sIHRoZXJlIG1pZ2h0IGJlDQo+Pj4gcmFjaW5nIHIv
dyBqdXN0IHdpdGhpbiB0aGUgZmV3IGluc3RydWN0aW9ucywgd2hpY2ggY2F1c2VkIHRoZSBkYXRh
DQo+Pj4gaW5jb25zaXN0ZW5jeS4gRnJhbmtseSB0aGUgcHBjIGFzc2VtYmx5IGNvbnNpc3RzIG9m
IG1vcmUgaW5zdHJ1Y3Rpb25zDQo+Pj4gdGhhbiB4ODZfNjQgZm9yIHRoZSBzYW1lIGMgY29kZSwg
d2hpY2ggZW5sYXJnZWQgdGhlIHBvc3NpYmlsaXR5IG9mDQo+Pj4gZGF0YSByYWNpbmcuDQo+Pj4N
Cj4+PiBXZSBjYW4gb2JzZXJ2ZSB0aGUgaXNzdWUgd2l0aG91dCB0aGUgaGVscCBvZiBjcmFzaCwg
anVzdCBjb21wYXJlIHRoZQ0KPj4+IGJpbmFyeSBvdXRwdXQgb2Ygdm1jb3JlIGdlbmVyYXRlZCBm
cm9tIHRoZSBzYW1lIGNvcmUgZmlsZSwgYW5kDQo+Pj4gY29tcHJlc3MgaXQgd2l0aCBvciB3aXRo
b3V0IC0tbnVtLXRocmVhZHMgb3B0aW9uLiBUaGVuIGNvbXBhcmUgaXQgd2l0aA0KPj4+ICJjbXAg
dm1jb3JlMSB2bWNvcmUyIiBjbWRsaW5lLCBhbmQgY21wIHdpbGwgb3V0cHV0IGJ5dGVzIGRpZmZl
ciBmb3INCj4+PiB0aGUgMiB2bWNvcmVzLCBhbmQgdGhpcyBpcyB1bmV4cGVjdGVkLg0KPj4+DQo+
Pj4+DQo+Pj4+IGFuZCB0aGlzIGlzIGp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwgaXMgdGhlIGlzc3Vl
IHJlcHJvZHVjZWQgd2l0aA0KPj4+PiBtYWtlZHVtcGZpbGUgY29tcGlsZWQgd2l0aCAtTzAgdG9v
Pw0KPj4+DQo+Pj4gU29ycnksIEkgaGF2ZW4ndCBkb25lIHRoZSAtTzAgZXhwZXJpbWVudCwgSSBj
YW4gZG8gaXQgdG9tb3Jyb3cgYW5kDQo+Pj4gc2hhcmUgbXkgZmluZGluZ3MuLi4NCj4+DQo+PiBU
aGFua3MsIHdlIGhhdmUgdG8gZml4IHRoaXMgYW55d2F5LCBJIHdhbnQgYSBjbHVlIHRvIHRoaW5r
IGFib3V0IGENCj4+IHBvc3NpYmxlIHNjZW5hcmlvLi4NCj4gDQo+IDEpIENvbXBpbGVkIHdpdGgg
LU8yIGZsYWc6DQo+IA0KPiBbcm9vdEBpYm0tcDEwLTAxLWxwNDUgbWFrZWR1bXBmaWxlXSMgLi9t
YWtlZHVtcGZpbGUgLWQgMzEgLWwgfi92bWNvcmUgL3RtcC9vdXQxDQo+IENvcHlpbmcgZGF0YSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBbMTAwLjAgJV0gLw0KPiAgICAg
ZXRhOiAwcw0KPiANCj4gVGhlIGR1bXBmaWxlIGlzIHNhdmVkIHRvIC90bXAvb3V0MS4NCj4gDQo+
IG1ha2VkdW1wZmlsZSBDb21wbGV0ZWQuDQo+IFtyb290QGlibS1wMTAtMDEtbHA0NSBtYWtlZHVt
cGZpbGVdIyAuL21ha2VkdW1wZmlsZSAtLW51bS10aHJlYWRzPTIgLWQNCj4gMzEgLWwgfi92bWNv
cmUgL3RtcC9vdXQyDQo+IENvcHlpbmcgZGF0YSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgOiBbMTAwLjAgJV0gfA0KPiAgICAgZXRhOiAwcw0KPiBDb3B5aW5nIGRhdGEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogWzEwMC4wICVdIFwNCj4gICAgIGV0
YTogMHMNCj4gDQo+IFRoZSBkdW1wZmlsZSBpcyBzYXZlZCB0byAvdG1wL291dDIuDQo+IA0KPiBt
YWtlZHVtcGZpbGUgQ29tcGxldGVkLg0KPiBbcm9vdEBpYm0tcDEwLTAxLWxwNDUgbWFrZWR1bXBm
aWxlXSMgY2QgL3RtcA0KPiBbcm9vdEBpYm0tcDEwLTAxLWxwNDUgdG1wXSMgY21wIG91dDEgb3V0
Mg0KPiBvdXQxIG91dDIgZGlmZmVyOiBieXRlIDIwNzg2NDE0LCBsaW5lIDEwODA2NA0KPiANCj4g
MikgQ29tcGlsZWQgd2l0aCAtTzAgZmxhZzoNCj4gDQo+IFtyb290QGlibS1wMTAtMDEtbHA0NSBt
YWtlZHVtcGZpbGVdIyAuL21ha2VkdW1wZmlsZSAtZCAzMSAtbCB+L3ZtY29yZSAvdG1wL291dDMN
Cj4gQ29weWluZyBkYXRhICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IFsx
MDAuMCAlXSAvDQo+ICAgICBldGE6IDBzDQo+IA0KPiBUaGUgZHVtcGZpbGUgaXMgc2F2ZWQgdG8g
L3RtcC9vdXQzLg0KPiANCj4gbWFrZWR1bXBmaWxlIENvbXBsZXRlZC4NCj4gW3Jvb3RAaWJtLXAx
MC0wMS1scDQ1IG1ha2VkdW1wZmlsZV0jIC4vbWFrZWR1bXBmaWxlIC0tbnVtLXRocmVhZHM9MiAt
ZA0KPiAzMSAtbCB+L3ZtY29yZSAvdG1wL291dDQNCj4gQ29weWluZyBkYXRhICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSB8DQo+ICAgICBldGE6IDBzDQo+
IENvcHlpbmcgZGF0YSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBbMTAw
LjAgJV0gXA0KPiAgICAgZXRhOiAwcw0KPiANCj4gVGhlIGR1bXBmaWxlIGlzIHNhdmVkIHRvIC90
bXAvb3V0NC4NCj4gDQo+IG1ha2VkdW1wZmlsZSBDb21wbGV0ZWQuDQo+IFtyb290QGlibS1wMTAt
MDEtbHA0NSBtYWtlZHVtcGZpbGVdIyBjZCAvdG1wDQo+IFtyb290QGlibS1wMTAtMDEtbHA0NSB0
bXBdIyBjbXAgb3V0MyBvdXQ0DQo+IG91dDMgb3V0NCBkaWZmZXI6IGJ5dGUgMjM5NDgyODIsIGxp
bmUgMTUxNzM5DQo+IA0KPiBMb29rcyB0byBtZSB0aGUgTzAvTzIgaGF2ZSBubyBkaWZmZXJlbmNl
IGZvciB0aGlzIGNhc2UuIElmIG5vIHByb2JsZW0sDQo+IHRoZSAvdG1wL291dFggZ2VuZXJhdGVk
IGZyb20gYm90aCBzaW5nbGUvbXVsdGkgdGhyZWFkIHNob3VsZCBiZQ0KPiBleGFjdGx5IHRoZSBz
YW1lLCBob3dldmVyIHRoZSBjbXAgcmVwb3J0cyB0aGVyZSBhcmUgZGlmZmVyZW5jZXMuIFdpdGgN
Cj4gdGhlIHYyIHBhdGNoIGFwcGxpZWQsIHRoZXJlIGlzIG5vIHN1Y2ggZGlmZmVyZW5jZToNCj4g
DQo+IFtyb290QGlibS1wMTAtMDEtbHA0NSBtYWtlZHVtcGZpbGVdIyAuL21ha2VkdW1wZmlsZSAt
ZCAzMSAtbCB+L3ZtY29yZSAvdG1wL291dDUNCj4gQ29weWluZyBkYXRhICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSAvDQo+ICAgICBldGE6IDBzDQo+IA0K
PiBUaGUgZHVtcGZpbGUgaXMgc2F2ZWQgdG8gL3RtcC9vdXQ1Lg0KPiANCj4gbWFrZWR1bXBmaWxl
IENvbXBsZXRlZC4NCj4gW3Jvb3RAaWJtLXAxMC0wMS1scDQ1IG1ha2VkdW1wZmlsZV0jIC4vbWFr
ZWR1bXBmaWxlIC0tbnVtLXRocmVhZHM9MiAtZA0KPiAzMSAtbCB+L3ZtY29yZSAvdG1wL291dDYN
Cj4gQ29weWluZyBkYXRhICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IFsx
MDAuMCAlXSB8DQo+ICAgICBldGE6IDBzDQo+IENvcHlpbmcgZGF0YSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBbMTAwLjAgJV0gXA0KPiAgICAgZXRhOiAwcw0KPiANCj4g
VGhlIGR1bXBmaWxlIGlzIHNhdmVkIHRvIC90bXAvb3V0Ni4NCj4gDQo+IG1ha2VkdW1wZmlsZSBD
b21wbGV0ZWQuDQo+IFtyb290QGlibS1wMTAtMDEtbHA0NSBtYWtlZHVtcGZpbGVdIyBjbXAgL3Rt
cC9vdXQ1IC90bXAvb3V0Ng0KPiBbcm9vdEBpYm0tcDEwLTAxLWxwNDUgbWFrZWR1bXBmaWxlXSMN
Cg0KdGhhbmsgeW91IGZvciB0ZXN0aW5nISAgc29ycnkgb25lIG1vcmUgdGhpbmcsDQpkb2VzIC0t
bnVtLXRocmVhZHM9MSBicmVhayB0aGUgdm1jb3JlPw0KDQpUaGFua3MsDQpLYXp1

