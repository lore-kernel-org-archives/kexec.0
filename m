Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B855BC6FD1D
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5M+LIN8hmIo0ckfA9kyZiVv4OlI3kBobZ7Vpx0YCtDA=; b=uOeHLkOrR6n2BxMokoDFaFK+ya
	DSf8nf5NW7zSmgG2yS44kU/NgupdOY6GmAH6uJnOh+L/LuSN70JsY7uXyLV+xTdud7Rq+4vrx+9p4
	TSDdps801fPdRqBKf7YnFAK3hoF7b+kXgBSrpuyTp4QTXsZL/o7HBs7Ebx7J9BAZkhQluXgjZ72Gb
	/XA9PAvCSqbLWKCx9NwPnmCGHzsbQAXdKspM2ZfmPSQVkHXGrlDisAIsq8OzjovzWPY7+2/nFd4XD
	CCnrJNwmYkBCfncTk16j6B/+OdG/vnT14m+eaNwHpSQhwonDSRtsSM46H784LfNZss3FedJ6fpK+o
	vLD9YVRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc5bP-00ASQ1-32;
	Tue, 14 Mar 2023 14:26:11 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc5bN-00ASPX-1o
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 14:26:10 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EDsOmQ009564;
	Tue, 14 Mar 2023 14:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0eWMIsdu1tWr+2aqIKMazbhub9Lj99uOB5QJzP+AjqM=;
 b=iuujMDxRch5wGTEPwnWyWCp9jhmTvO8Ff6Pp3TbZsI6uo+aaOoU5mymTOuoI5qMPJwSv
 r2kmL3vN0UmXTHKJoEOePRFm1VVP9hO/GmfhSx1oersXrfLB5qz1EbNuGNs9wDoX08jN
 CAffKujSrTOgtKyQvfFCyBuaaAzryzCqi3JIuWCAs6E60Ql8bbAEqIiFQwELG81fnZyq
 qFb0qy3BtHjN39zyf+T8otpZUKKVur2M4rshGq2vJYSPGvvO7dTbgPW4fEg9lcoecDev
 viL4gPzuNxGGLyVHpi3FPRbT+2KRt+5QNwUN1jSMAazDla2UCwxKuM6FykRX2xqn2PXi IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8h8teftq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Mar 2023 14:25:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ED2ekr015258;
	Tue, 14 Mar 2023 14:25:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g36qe0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Mar 2023 14:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqUX4dQcUoZbFzskKKTBtQi3JIsIcGm4EBomNmDN41rRJkxGQXT+sWCT1C/rhhWS9I8qnJU+T3zECNLqT69mo1QyuzmsDS+4K5uej+UwKldjep1vxE/hgYE046ZTy3wfyq9Dm2dm89f+XnX8uYKG/737ZwUmt1KOZX5KTwTgxOK2EnRcq68rexpEfNrYHc9KUz1BeYF+E+vV9enUR2E6viLOsRguVl+hKBNKiSbnLjmd571DgzeJbEAGvUKWFh7FmbFiJyObMU8sIULJx8zJzjn43Z7tHcHKuCdmqbW0Srn2iQqGK7AmpyZVuozbzzkpmyi0ljD+CZzN0j7L60QMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eWMIsdu1tWr+2aqIKMazbhub9Lj99uOB5QJzP+AjqM=;
 b=Tbb+uAdRZRWChSj/iK+tSdyWJ9QHJgBKazub+KkaotaILwaZTKxtjDTcxjDhbOqivspN58x742i7PP5jViU7A6727QBU4mW5yHVYd10TmY4lyqYsxml7c2VYnNc1zQIFqQpzN6/Eouy9oPxV0Vwavcgl2VVj4RWTen6i8dKqV3FcC6flTUp0f7D9r5KZaXxlQvgxbmIKUpA2HZvJOYnq95qGoTN1ogf3ldILEYJAZoqwjVesaDcfpt7ey5/NyrKIayxxtbQigYLtMAMWIoxKWSEqV/XKg6xw0wIncUZL8Kr5vzeYj5st8FNBVEPhyofz1E5hu5Qb2irBsGcXWc+FAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eWMIsdu1tWr+2aqIKMazbhub9Lj99uOB5QJzP+AjqM=;
 b=pcQR9YxkE8fMYyWgS5ejOt2XCVNTo1dna4nuXo5aDXS0bzO++BIb/svB5nEls5WA+qquEr+7XfFdJK4o7dzNWPbUN3Vlqp8Z8epP3gBziXDG/DiKcUN1aKk4+D8+mbFe+S5wBOhbIJbB4KyoNHcjtoZhb0pIgMAKhcPA5kl4B5Y=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 14:25:30 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 14:25:30 +0000
Message-ID: <57e05dec-1b85-1b3c-89c2-879fae97b941@oracle.com>
Date: Tue, 14 Mar 2023 09:25:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
 <2fd31764-b341-638a-f70e-43dc0d5b0092@oracle.com>
 <ZBCDPuTdjMY+7VrG@MiWiFi-R3L-srv>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZBCDPuTdjMY+7VrG@MiWiFi-R3L-srv>
X-ClientProxiedBy: DM6PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:5:337::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b45037-b26a-4fb0-4700-08db2497f6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	7nH7g8sVkqgI3aaeytOGNlbyrSsbNiDcMFhkz2xaL4h/gcYg2bE68CCKVnOGLucVodcscJuytuMoycwMAqKUdBhjcToagtrWqIUAvD2NH8w4kSLlTDnVkrbAyfHofHwcwaC7YtX+r9f1Fpw/cVOQlod/F9Hdt+6YxMztaSYcLr6SlYNo0ZlNZcueCek/koXc4tAjCAql45iPwbHk0R43f/xygpo0Bn7hL/Z2pPg/gT5kgoVMG/XFY+eTT3PFFHAWitJxdVpsegpXp2vyUtwOkCK7cPQv7HbehMULgh1mHvOVcedw6tRaTgwUfJ20MjaSFglqC4fpSubnyDg4TSGHkrDCJd6IKupzc2kPpr2pSc/WZiLNC07bLa3EVwYDhSOIwKESmQmr1IjuL2Q/RH5eh0A6zq3wQn5JcEMNmWoMDN/zRB48+0PCcQ1mJFxU5jxQ1IH7Vbt5qolslNwmVrJhqew9wO1k4PuZiFev80Q9pOAx0wIGvZ3x23VPS/+vyGRgL8fTw7g9qLtzwTIhqy98P18ER/zl9gXiRNQuDhqiuw5e/cRBRZF0dxtbTHsJUQWsuXvq/QWInSecIdaphb7CA/KgioXitWzgmEaLLV5TBkIjykJb8zlgY/Tsa26ZNqPk9mlVowsmnxS+wyifuSiforr+L1HR7R4r4z1DzLl9cBqBTtgN7Ip4dgRXa5dWVr99xHJYOL8nWUebi8HUQ7wFFs9hC+iE8SGUI4ORxVYG/5AZ6+Y5YwxSlxQfQ1fpP7Oe
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(36756003)(6486002)(186003)(2616005)(53546011)(107886003)(6666004)(83380400001)(6506007)(6512007)(41300700001)(8936002)(66476007)(4326008)(2906002)(6916009)(8676002)(66556008)(7416002)(66946007)(5660300002)(38100700002)(316002)(86362001)(478600001)(31696002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Q1VPdzZGdi9LekEwclVlNmxEK0hDY2pZTm5jeFNsWWxxaEtlSCtlaFk5U1ha?=
 =?utf-8?B?WHlOMmZ0c1p3d05SbUpMOHNscVVVc2YxaEZXeTNhSGN2M2lYY3ZPNUVsNEEw?=
 =?utf-8?B?VTBKNjczQ2kwakxaSDhHZVhYZEFvRmNldWk3NlZ2QUVJTDl4Y0RlcnhxRGtB?=
 =?utf-8?B?bUxoaXRNTWQwQWxxRmV5Z0tBWjJVVGp5WG5LdC9rM2l6SU1CR1R6SXF5ZHVV?=
 =?utf-8?B?aTFncTlVV0ptSWFqZkVqc1dsNmcvaGNuS3RKRTEzRUYwYjFQN29GWEdaTmNq?=
 =?utf-8?B?aFJJdU5iMU1lbXhuVTlVK3V6WHRWa3d3Rk1ra29sYVJ3YnhBbGtkOWJBTy9G?=
 =?utf-8?B?MlduM0E3ZjF6cUJDN3VHSW5wUVFHUjE0Z3NkaGhDZ0lsZWhRZitNM240STli?=
 =?utf-8?B?NkZJUEwzcTZhVkhJZ2pwR1lRQ2NqTzVXWmV2ck51OTdyUzh5M2hRK0RQR1oz?=
 =?utf-8?B?Z3VHVExTc2piS3dTMk1IUURCdk1GbVBBUGRDOCtaOS9mMS9GYzBVbTNydk5J?=
 =?utf-8?B?anIrSlpJVURpUFBlQ2plL3RvTnk0UXRLQ2lHRHh2ZlhWMDdwWUNWeWxmc1lr?=
 =?utf-8?B?YW5UQlBLbHlJenBLaUtLUldjM3Q2aXdmbDlRZEpyWVFvRGNHRjdpdHpiK2hP?=
 =?utf-8?B?NTFtQnNwclVhREtDUmpybmhMZllDUGFXTFZRRFM3WnlNcHROU1JwaHkyclQ2?=
 =?utf-8?B?T0NVMXphTXpoS21RWHVGOHJxbjVRNjhBOXdBS21YM3lWZVFWSWhaM0JSZjdQ?=
 =?utf-8?B?cG90UWIyUC9RdFludFVtcVUyVEM2QmlqeFRaTnd5aXg0M2hLK0hOTVYrdWEx?=
 =?utf-8?B?VXhjMHhMc213ZWs4RW9zU1gvUWNnNmo0N1FTd3kvRWhuUk9yT0Q3d05oMFUx?=
 =?utf-8?B?WStvMXNVYUdLdERUL2pYZmVLMkJESXNReDhmejJtZW5PR3lKZXFGa3NkUTIz?=
 =?utf-8?B?OEZFWVNFNlcxQnZ3ZVVSZ2tKQWhDWTlneVg0d05oaXFRa2ZXRFFxOEl5aCtv?=
 =?utf-8?B?Um8yZFF4K2RsU2FGN3dsSzZTTEZyZndISzB3RmlGUFN6MkJOWE1ZMVBld0tF?=
 =?utf-8?B?WjVwalF4WHpIVjhiMEdGcEUrQjJwVFRIYmhTTDZrOE9iY2YxMW8weG02Wmp4?=
 =?utf-8?B?MzR4VE1jNHphQUZXbEh5S2luTFRCWlRvSWlMeFVGU1FXMnRiaFRCTE9FQ25D?=
 =?utf-8?B?WStkaEd0NjBIZ0lCdmlGZUVaL2U4ME5yQnE4a0FZWjQwT09TZHFKVVAvaVNu?=
 =?utf-8?B?cnc5SjFPOUVtNHVMczhNcU81SmZxRjl1S1N2M2kwUzR3akhnNDZDY25oN2VW?=
 =?utf-8?B?YVQ5cWgwNFFnbURGQnNBZnZZbkYxcmJKTmgxSVk0eHlsbUJ2TEN2QWV5ZE55?=
 =?utf-8?B?R2FCZ0tyYnJUSUZYaTVPOXRtSm5LOHFpaHdobVluYkVKTHdVRDJWOXBacS91?=
 =?utf-8?B?NXpNbzJBVHBINEc3WjhvV2FwdEp6U05CRjlnNjBnVWQ4QTF4MGNRMmlFcEpv?=
 =?utf-8?B?M0ZDWHRsQ0M1VFNoOXVrYXRPQzBQTkdWQkh4OTJjNWw4NXlvNkw5TWJVeXJj?=
 =?utf-8?B?U29xRkp4Y2hiRlV3QjF6SncvSnlVQzFOYmg3dW1kVHZlOFM4Rm9wRjNHcU9K?=
 =?utf-8?B?UE83UEJ0UlUvWDFoUlZBK0ZyZ2Z1NWQ2SkZqR01DSEFpVVMrTzFmaHJBN0Vi?=
 =?utf-8?B?aTBkZTR3dEVHTkk3NzJJZWdjMHVkQlZSOTR6WThDN201bWdxTzhqUlBHTmJO?=
 =?utf-8?B?YTlWdWZBWmlxeStPNmxCWGt2aHhRY0JpZDBJL3VnVkJ2ZVU2Qm82M0pUaFNz?=
 =?utf-8?B?U1ZrNE5WOEhJZ21MKzNwdUNHV28wODZtek1mNG5YS3htYXo4ekozbU9XMUxl?=
 =?utf-8?B?YllFUDg3LytXcUZjdkR6NDJlMUZIL0w3TW9kRXlYNGhIN2ZVbWZoNG9xcjlF?=
 =?utf-8?B?dDVkUnAxYzhmRDRJNTd2QkRsRzlpSTZFWU83V1hDRkRUWk5WaS92bTZiejRy?=
 =?utf-8?B?MmFJN2ViTUhRSzJKMFpxMWVYcGVDMC84RlZIR2lGYmVFUzNob1I4dlZibUZE?=
 =?utf-8?B?ZjhnSWw0UlQwc2ZQMXk0TlhmMmhyMkplaUFiZkphSnBQWmRZa2tQYWVCa2tJ?=
 =?utf-8?B?dXNuR3BOL3pRY0V6WTJMRUFYd3gzckZMRHRWdjRBQjFiSmd5NUFHM0VIVkw3?=
 =?utf-8?Q?JAFa9OHGAh6WAQcI/kFITpY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?S29XcjVaYlJaSWlTQlV5WEl6ZDNHMVMybmtlbWxaTEVLMncrR24rTVBlQzdn?=
 =?utf-8?B?YlZkYWw4eWZ6bFRBVFBrME93czgvdGlTRVd2RnZNMjNxWDFmbTlqemVWS1N3?=
 =?utf-8?B?WXE4MEl2cnRnQWhmc0I5ZTNvMVp3U3NCcXZwZG56WFFEdms0REhMQ0dBMWp6?=
 =?utf-8?B?MHIwRFF2VDd6a2I0YWxLeThSV09mSHpUM29mWURzSGwxcFRhYXZhWnU4MGo5?=
 =?utf-8?B?eEhyOVhwL0JlUE40cWVjamY0QzdJaGRidHB2aEhyODcwTW4rME1wOFFkQVpi?=
 =?utf-8?B?THp0LzA0T1RpOTRKMU1uNlBjeDAxbktYMld2b3NZcGx6bFNYdjJ5MHZ0NWtl?=
 =?utf-8?B?bkt2OHFHQ2xJSUtySHlGbCtZR3hFSFJUbCtSWm81MkwyZjNsaE1Uci83ZXhF?=
 =?utf-8?B?M3hPWlYvZzc1NFZ5L0xXQmN5akdibDREenEzc1ZLenZEV2xuT01ROWtNdUk2?=
 =?utf-8?B?T3lZRVRKemxPWG53VDFKWEF5STFKZ25sR2tTYzEzRnAxMm1GZ3ZkcS9ZNFJz?=
 =?utf-8?B?akhsTUVYR20vME8yL3kxaG5NY3hTSVh2Vm5ZUzJ3MllFUGFpM1FkNS9VTUVF?=
 =?utf-8?B?Qm1vcExPWnVIVWlOVlZIVUl5bFlyd2JzSjVianpmSTRLbTBPcHlDL3k1NFV4?=
 =?utf-8?B?VUF3cjJtWjFFT1h6L1RPS1ZZQVFFc2JwUzZRdFF6L0h0MUtCbHZmU3B5OSs3?=
 =?utf-8?B?KzkxRVRiQnZlV2FjU1VpaDVVRFFHTTYyZ2FPdWJPTXJRQytEM1BFb1luUTV2?=
 =?utf-8?B?RDF1U2JyMldOK3k5WjhUeTByLytkOGR2UjVRbEFUNk5KSEl0aFRFeFF2d2Nr?=
 =?utf-8?B?V0ZrWTRJM1Rvb2VEZmh3NGE2aTBzSG90WVlYSUlBc0pMbjA3UlFxaFN6ajBw?=
 =?utf-8?B?dzkydzljL2M2Q0lyMkd6SnAySEJ6K2p3NGtLK0ZHaHpZRXpEVTBDeW80Q3ZK?=
 =?utf-8?B?djMzRElrMkhGTi9ZQWpSVHdoWnVGOE1GYUdEOTBoeHlnWk1sYkMwclpEbkU0?=
 =?utf-8?B?MnBvb2c2ZjZCd0JKQlNrSG1hb1k2RHo2U2t3T0ZNZ3E0a3VIdXZmNXpodllU?=
 =?utf-8?B?L0pNTG4yTDJIQ29GUVg5eWIyR01VdHF1di83ZDUwM3dSNWZid0lsUk0zMHFa?=
 =?utf-8?B?UGRTdGJ5K2lJQ3dSNWFuUVdkUE54MmhTV1d0c2c4R1NjRTRYVnhwbWZiZmZ2?=
 =?utf-8?B?RkRQOURXVlJHMVBQS25KWi9XNEF3WitYTVpORGlVU2Z3cUxHMUFqVDR2eGpO?=
 =?utf-8?B?b2F2L3VPZzlkMnZsWElYSFdQTGZwUkVKdEhXOFZQdjJnMkRsZHJQV2l6TjRl?=
 =?utf-8?B?VytOc3g0RUNIVEE3L0JXaG4xVk92amhocFF1SnhyeVV1YjJDSHp4bVhUMDhN?=
 =?utf-8?B?OFFZY0ZuaHBtY2ZqM0oyK1VjU0lES2JGOXFWUjliSVNMV2RLOEJKcWVub2Vy?=
 =?utf-8?B?UUZtcDIydEdsVTl3dHdWcG9wdlNvTFA1ZjRpbURvYnM5THVWRXg0aUNENFdx?=
 =?utf-8?B?eDMxdWc3T0xPTDErYkI0RG9FQ1BSUy9QYVJ6NHhKNkJxS3Y4N1pCbk0xTVJ5?=
 =?utf-8?Q?dr9qC4oahe/eG9GTzQFmB00z4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b45037-b26a-4fb0-4700-08db2497f6fe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 14:25:30.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZMHL72uSfU+Nx8WMKDDXPg1BF6ymH7e9AMIlS+XrXbXCU9aTM6rqEnzHXM3/llhtHX3dDvhjY7sRKR73DRlonxotWQh3OZhtxF+a7hitxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_08,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140121
X-Proofpoint-ORIG-GUID: PRmwuLuhRWkTWr6FK5ag_22USwQs_q6g
X-Proofpoint-GUID: PRmwuLuhRWkTWr6FK5ag_22USwQs_q6g
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_072609_713103_E48B4ACD 
X-CRM114-Status: GOOD (  19.51  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 3/14/23 09:22, Baoquan He wrote:
> On 03/14/23 at 08:28am, Eric DeVolder wrote:
> ......
>>>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>>>> +{
>>>> +	switch (val) {
>>>> +	case MEM_ONLINE:
>>>> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
>>>> +			KEXEC_CRASH_HP_INVALID_CPU);
>>>> +		break;
>>>> +
>>>> +	case MEM_OFFLINE:
>>>> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
>>>> +			KEXEC_CRASH_HP_INVALID_CPU);
>>>> +		break;
>>>> +	}
>>>> +	return NOTIFY_OK;
>>>> +}
>>>> +
>>>> +static struct notifier_block crash_memhp_nb = {
>>>> +	.notifier_call = crash_memhp_notifier,
>>>> +	.priority = 0
>>>> +};
>>>> +
>>>
>>> Because for_each_possible_cpu() is taken in
>>> crash_prepare_elf64_headers(), x86 doesn't need to respond to cpu
>>> hotplug or doesn't do anything with this patchset. This cpu part in
>>> infrastructure is only for the later powerpc usage, right?
>>
>> That is true, yes.
> 
> Given this patchset is aimed at crash hotplug on x86, while obviously it
> does't need to have the cpu hotplug support on x86 since the
> for_each_possible_cpu() adjustment. People looking into this may be
> confused if they don't follow the discussion thread of v18. Do we need
> to mention this in cover letter or somewhere else? I could miss that
> though it is has been told, please ignore this if yes.
> 
Good point, I'll update the cover letter to reflect this.
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
