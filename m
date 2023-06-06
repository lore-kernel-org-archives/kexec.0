Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB66C7EE24
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sUfJVXIngUbOzwqV6bNobtF4ZKN5/oCjJrh8KopZRZw=; b=UFCDW7/HZaD5fJUyBjVoiUPtlh
	eYbbFbtJEbSB+vHIsIzaTcX9PwvyluxLMdaSq+Dojm1tKKW2MBZnJOqEjVo/DoqF0h9RzVFAKb+u6
	ti2JWfj2zONZhGsFYwX7PsanjyqfgLRYE+Dhg41M6eN20FFG5WLgNr5h4kU7X7bOx/ItZB7wSk/qZ
	JujRoaXoCGHSm/+ToxI2L2Tpgz+FT70jfyQ7mEyQLuR1OF8rYMRrfptAaHyHXm7l5UIIMDMO4Lve7
	25CK1jzaHoP0Lx6u2VREnpevCmA+0xCeyCnHVwdCE7Cy7s1K7ZUU0MetYgTxv6li0Es/9SDUYotLC
	37QE6G1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6M2G-00HP15-2C;
	Tue, 06 Jun 2023 02:03:00 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6M2C-00HOzl-1W
	for kexec@lists.infradead.org;
	Tue, 06 Jun 2023 02:02:58 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355HiK1L017855;
	Tue, 6 Jun 2023 02:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U8eTMPAOS4VcDAv1qZx+CqBfWks7/7JFIN86J+iPpVY=;
 b=WI98m3Cyy71wObafmZCAmot1KisDv5hdXXqu9b4cSMIhuK9g4LY2BxyYmBuZVbuNNDEg
 AP1cA5CXE+lV+i0qIf5m16BrjfZDpB6AaSIret3Ha7LFbmbzDPryM62Ychz0c157ee9G
 3bkV9vFzlM8UmegbfE8PAm17habbIhmXy8xVOQ9PCsfoWgqpvgxYQJfHfhL5fSr+Ct6/
 z6t1KtluPAldVpXqpDZDSczDVvEUvUHf6d/xl+p+P3jUxAwJcPRZ//lS4ag3HGORj+6U
 kw9+6VHTq6FK81sPfc3h+D4yUs6XAB6/Ts3+sOewtLYTAw2jjCqGFP9lJhlCpEY637tg qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2c4da5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jun 2023 02:02:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3561eXvE020110;
	Tue, 6 Jun 2023 02:02:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tsx09ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jun 2023 02:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUzKR8uHPNvpMH0EkYU2M6Bdgf+lNWHzeCiPxiBEVZuNLEtTsGrzGVYrAK3yLmNswDEhtEVUFcq2qyfjl7u8EUcK3ZkjQSbkSItrCuXMm8q+W3dQarJ2tMASUN7iTHorSaA7m/QbD5tswrlHgM5Uz6OMXztBJpTqYsa37AQVjPexQMVZ8efnUy7Osh+HZpm1est5qD7UnE4EYJ+EEEWXoVUR1797NeUdV7zk0ZfJhKFmyQ7d2r4PTWcmAkFzHiPH0cJ7Bh5YJrgUipXgZS6rNR+79rUSMbPVaZwzM2cyDiMljCnc9NvPffIvRgGcxLi4d9rnJJNOWTrwyavXlmOy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8eTMPAOS4VcDAv1qZx+CqBfWks7/7JFIN86J+iPpVY=;
 b=l963YBa6vrgRuUtC3lQm57MqJrUtY8mvM4ggDBezLeROZf+6jJswbJnM/w6FAuUi6z9X13bylv/Jf75l/Mo5zWfHdeVV1MbYOj7qGbjf2RwKY6EtL5LXJUVp4Fz9Ty3dRLD6DuUHAu+OcQbdyeB6QBggTf1UOUhpvXMbn6KZ3YhFm1dlkJXwF7YsnMsnWmCeDx3qENlvIiY3plQ7/1Y5NoOpd7++Zyi1JOuIarZfXNGRpAygtMnIN5sw2s9b83oSo00OtyWXwTRkMCaW7ib5XTWyGHGwmmQtosXLlBvPQvRN9jFKn5gpKd/BKOwKiY5mbpcLyyEibZTf3HQ439ZIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8eTMPAOS4VcDAv1qZx+CqBfWks7/7JFIN86J+iPpVY=;
 b=fvCfWN4/Cxwc5bHaJYLjPjQwS0JhGWRGbrhY/M8kc0SvwiI4a3LdA33NWzZzPOGFBWMHLKKGDsQyKLGw7X606x5J6fcQz0nGyAeTBP7Uh51jeubGGVdhyrpD9u0D8cJAOv+QUSVuW2irMftQomsBVs8sQqvJXSV1+nOAlKmCkY8=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 02:02:00 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f%2]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 02:01:59 +0000
Message-ID: <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
Date: Mon, 5 Jun 2023 19:01:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
To: Coiby Xu <coxu@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
 <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 466785d4-4a85-497c-1cbd-08db66320374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0JXVTN3HqxBxZBg+6EwZrEi+mZGzIVtAzF6GMpKVgXTbd/RoTAPjwycZmJCtF5qD2o7byUfshozFQrEKnNRfLpT/vvdKrk/3SmCAldoc62NRa9jQU6ToKi2ZDPCeG7ZgORu+4yn70xdaUHIYJVCvMwDR6M3LFyBBjU2Sqo+PNP8g0St7mhRGYZ604kUd80672CmwDbWRZKWnISYX5qa5Qbil7UDvrIQXUyDfN6pvFW6PtA/ebBQV2cdwXpbXb2DYba2DlgVtwQyO625kk7xsEs8Ywfomd4GSw978OTPWR54GqXpu0WWuu1Lxs+cqQotkTSPrx4IzW8pPE6zV6v15tKFl3JFLUs4zw9NK9XITQNvYoAbVvvFHj/bPKAfQvOMsH1JxBZbTqll2NjnTnVoh7sZhyaIJS7YaQP0j0q06yEAsEaknG/BezQhCjKVZHqW8fQNZ3KeE+gqapv3kiMBL+QakEPoVbunrxR8VYh8cNbRsCWD1lj0Qi0r3FvB9Bvo0Ond2bIoRJtJpBBFLyJstBTda/qz5Yfctbuecs21I8nc8WDn0eOcc9mgAA1aIKPznvDRq9FDdDWXRgVi8uzp3HGuiTPEaQ/D7S87OlYF3fQP+HDJ3JszooqvmxXIR02E3ZjM3KjOFIWXxHiZeOi0wE25RRz53ibkuPIPjgdBqJazFLaMS3wkdmjgCIGhfY2K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(6506007)(31686004)(53546011)(6512007)(26005)(186003)(2616005)(966005)(7416002)(83380400001)(6486002)(6666004)(36756003)(2906002)(8676002)(8936002)(44832011)(478600001)(38100700002)(6916009)(5660300002)(31696002)(19273905006)(86362001)(66476007)(66556008)(4326008)(316002)(41300700001)(66946007)(45980500001)(43740500002)(563064011)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tvUHRKM3RVOWxiTnRqZ2RNVzFsY2pHVDJvOHF5WUxBNk5TTmw2d0RESlhr?=
 =?utf-8?B?S01OYlJnWU9KNlBhR21scGVzWVZSeVAzWnliUHJMSFdic0p6R2tkTVJsU1l5?=
 =?utf-8?B?QnVqc2M1ODgwZTk0eDJIOXpubzBkNGdwVjVXbU02OWZYbWZLWGN2SkRKc2Zx?=
 =?utf-8?B?WkpWdTNqZTJFSlZUSVVaS1JUZlMrU2tlVUR0NXV6OW5ZTEgvb3RuQXF4SXI5?=
 =?utf-8?B?WnVaOEVOczREL0pxMlZaTzNUQU12Q2V3L1NBeDBtUjduRFVqbEFBVUx2SG0y?=
 =?utf-8?B?WE03eWVsREJObXJ3d0lmbzF6OFFVenRFUUVnait1SzBvMGRNZmJxMlhjNnB6?=
 =?utf-8?B?b0k4TFJrRWVCNXZpOHBJcmFmNEM4UWxDNlRnS2dtYVpuSE9xMkJUUllwVk5z?=
 =?utf-8?B?aFM0ZFZvbW4vTngzRHFqUTdqTWFpYnpLWUZPTDl4a01PMldjeDlweDFGWmtM?=
 =?utf-8?B?ODZyTUdIc3NtbGhMYm1EaEdiQWZ3OVRRa3BNc1AxcnJ3bE9EOFZ2aDJibXB4?=
 =?utf-8?B?U092UkZrbjNrRnR6RUZSSGxOTGdHMnJUQ0U0NHpNYmE5SHM3VTFSZDk4OWE2?=
 =?utf-8?B?V0FkR0EwR3J5YTNiUXpYSnBsZTdvSDVYbGZoMWZrbEVmMi9hcTNLUStPVXFE?=
 =?utf-8?B?U3NVcFM5Z2RtWlBockNKTmF4bEdLelcyQUQrRGljTE1Lbjh0VWYrWmNsVVMx?=
 =?utf-8?B?UFplZFlSdjlrb0JXbTFFUFdqY0YrdnpSRmtmV05adC9Wc3pmdW5xd0ZpM1Ro?=
 =?utf-8?B?TzRiQmVKcjV6dHZSQmE1Y1BjRFEwNVBVQlluZWJNdmI1S2dHMG9JTXpwVno2?=
 =?utf-8?B?Qk13aldEd2J2Wk5TRVNGMzM2czlldmEwbmdIU1VselZ4Q0lFL0V4cUIxRzBY?=
 =?utf-8?B?Rm5JY20rSjd4WXZJdHBLZkhVWGFLSUhpRVUyUDZ1ZVN2MXdCbUU2Yzc2R09o?=
 =?utf-8?B?YTNPNzlIbU1UU2NudEJmUmc2U1B1Y0huUHBhRUpTNU1RdjBxMGJXT1FyZUsx?=
 =?utf-8?B?NUFkZVpkU2gxbzFWUVQ5c3kwQXd3cjRsSGVDTEYwNThveC9XTk1VK1M0WTVZ?=
 =?utf-8?B?TkNTU1psTnZ5WE1ORWVFWXFFTUs5WkIzb2ZJcE51Sk9uNCtXdk1hOUx4dHVu?=
 =?utf-8?B?d2xieVk1VnhPRitoZUxpYTEvNlV6UkEvdk1vNUVueE11Q3VkcFYwMVhFZ1RC?=
 =?utf-8?B?MlFmMlZXdDUxTk0wNlRERitjMElkckg0aDRveHkyRStjaVJuejFEb0hLVW1G?=
 =?utf-8?B?TWVXYjlUTjUzWG5PdndZd3NncDJFd3FrVkpiM1RPSUpzSWxLVVd4R0Q4RWM4?=
 =?utf-8?B?K2w2MkxZaGhrMXJCRFQ3U0RSRnN1cEd3anRkNnBwOU80eDk4cHFtcDhZZEk4?=
 =?utf-8?B?TGxKTmdqL0VUZitLY1Zvd0Zhc2owaUt5TlBjZDlPRHcxNW1CUkhmMnJvYjRk?=
 =?utf-8?B?Uk0rcERpUzBYYTQ5ZjUwK29KN0FPUzlpYWFGZDFtcDFETlZPWGdZOTB1ajRa?=
 =?utf-8?B?RjJFVFVpTGN5NnZ0cEUrN3VpYnhxZ0sxVUQyYkFBMU9SSWNNWlZEcVZaUTN5?=
 =?utf-8?B?TnpkZGR0Q09QNTJhOUxmZWxBeUtPK256UFF2WmpOS0RlVkdwUUxYWDZuR1cv?=
 =?utf-8?B?SVNKZ1d3NVh6MGtBZllIbXRTY2J1N3N0MG1hV2VSSFRreDBESmRvbGo1MkVT?=
 =?utf-8?B?NVBpOEF3Y2IxTS9sYkRFYlo4eTVGb3hrYk13TGNnUEdwU1pYdm56bHR4Y0p2?=
 =?utf-8?B?bU04bjRTa3hkaXB6YkpIWHVqYkpkKzJwbW1BYWhqU1I1U0kycE5CWWxxZml0?=
 =?utf-8?B?dzhFQmc0Zk9CUmJoWHRGeVhCcytYSWQ0QVFrdjEvTmszcTZXYlkxaEZuTStL?=
 =?utf-8?B?NURub1J2UnI3QTVnMGNSWHJUSVJKbUE3YnRRWURkbktZcUZrcGJVa0JHTG85?=
 =?utf-8?B?OXZ0UktINGVoNG80bExDa2Zxck03cFprL1BOUlhBaGRoS21wZVFEMFg3L0tV?=
 =?utf-8?B?SEVIdVo1SFFQejFqcmRtS1RtYnVxVmRhR2ZHdHhRN1VvVFltdU4vR21aUW8y?=
 =?utf-8?B?dW5vQXhSUnBTRWl3ZE9hekZpZkpiRGpzTHdQSE9IKzNIbEh0Q2dCK3Fzc0tx?=
 =?utf-8?B?RWYwQ2RYSXQ2cS8zREZ0VFVVUWU3MDEvWXFLYW1teHRHdTlPZFMzaGFWNVFR?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?THpzeGVLWHpoWC95MllKc09BRFp3TEt5VWhITWxPcmxZU1RaOEg2U045Z044?=
 =?utf-8?B?VWlPT0lFdFk2Y1lyRlpsWVZKZVloMHhhQTM5czMwczgvaW1BMnd1TXNVWGJB?=
 =?utf-8?B?Ri9oQzJURU42RDZsNS9DZFNpWDhVcEI2dStHa0IzUHhKTi9QU3AySXVmQVN0?=
 =?utf-8?B?NzlZOEZoaWN1TzRRWFRLelRIVHdJL25vUy9VdHpaNXdqaHU0MFo3cGRsWWlU?=
 =?utf-8?B?VXk1YkRpZ1FTTFhoV1c1NmFyQmZqZWF5K1FtT3ZuT09CYlE0ZWszS2VSTnY2?=
 =?utf-8?B?ZDNzM256RFZNQTN5SUk1ZzB6dTlmSWMvaEhMS05TSVBBdG50NVNKcGlwUVlq?=
 =?utf-8?B?VGs4dy90Sm1XN0RTSGtSQWRCVkZuSDd4bnMwcEZQNEZhT2pLZ3dNNFcvSitQ?=
 =?utf-8?B?K3RBZStQYTYvc2l2N1lsN0hLM0tBMjJ1d1pvenRodzRJcC85Z3A5Rk14RFYv?=
 =?utf-8?B?Z3NzS05rM0xQWTU3Q1gwa3Q2aEduclE0bGZRS05LWGVFb0tqWDVJdWNtZ3F5?=
 =?utf-8?B?a0IrdnNoNGdDcjZBaVM3YUJKbTdDYnp0WTBjWDRHZUluUGlFOEpWcGpnQ1dP?=
 =?utf-8?B?aTJtZnloaWhMR2JGN3oyWlJiMmFYWFpZNmJvWGpnZFFTQUIxQnJQSjZVcTB6?=
 =?utf-8?B?ZG9IYXFNVWtWTmxKR0hQZnd3OUNLVUo3cmh0WWk2ZTZodCtZK1BuV0hnRFZ0?=
 =?utf-8?B?UmlaN1VuY0tSVzRyZ3duRUZ6aGM3aFkvdGRsRlJMczdrVFBiK2hMNW43MllR?=
 =?utf-8?B?MjRlSGF6ZGh3cUVrMGk1M3RYMUdTMzQzNXlwVVdsUWU4eks5WHpUUG9jK2Jj?=
 =?utf-8?B?ZURoT2ZrNkZ4dEpRMG1ZM0FMR2xRNXdpZCtNME9nL3NsMXN4QXVHOTdnK091?=
 =?utf-8?B?RjVVcFFDbXo2Y0hCRThaUXk4eFE2NlhHekZnWXlQRFlwVW4wS2h5N0s1SjJw?=
 =?utf-8?B?MThtMlFmSmN5cVhpRFZPbGxaa0xQcGJXdDdxckNRVE5nU2dzSTFITkxDNGk5?=
 =?utf-8?B?eHZkNGx3amlkNnVIUWxqTjlNVVBRMWJ5WnFqZlZtQU5tdllzd25NS0NNcGVI?=
 =?utf-8?B?VHpYdkhVSHJRK05wUmZiTXFNNVQrQ0xVdit4NGJJYUFDd216ZlBRMHM2L1dx?=
 =?utf-8?B?YnlnQVhjb1E1eUJvdFJWdUdHamZiSlR3dzBETTFyUDVWZGZTUE5OejErMjE4?=
 =?utf-8?B?Q21uRVBYd1AwUGRVY3hZcmxkWk1tN2hXSnVDMWFTTU1ua2U4SVRqZWl2bDBC?=
 =?utf-8?B?bXNIazF1WkwwZ2dUdnpGS3ZSMFRaSEpkc2FDU20wZ0ZCaUJZdVpxVTU1eDBD?=
 =?utf-8?B?d1RUVU9zYy9ONkRLckI2WmZEUGxJeHZLeFVBMUdLdjJieHhFQnJoL1dhalhR?=
 =?utf-8?B?ZXdEZVhldGdFaTZIRzkrUzdlWVhPbVVRdE9SenhxTDhSOHhza0FKdWdhRjNa?=
 =?utf-8?B?Y0hqMTRMS2NmQXYvRkE0Ri9IdUVkNWt2bk8xY3VXeFczTGZqcjdiUHphWTB3?=
 =?utf-8?B?ZmVHajkwUjJQelFBUzZ3Y3FxNGxCSFpNYkcxWWV4TnI2Tk94UFoxNGFVbW5K?=
 =?utf-8?B?UWZkR3JuOFBobGxBcDZLUU94TTcvZGNnT0xZQ01naExVcUpaZW8yb29BaWxD?=
 =?utf-8?B?VUJhREJXVFlOdU82L2EweDBRcmRMdEZFbGV6clIxcFlyek4vMW5PUndWcG1p?=
 =?utf-8?B?U3FZaUI0R2VyY2xWYVlRci8vVjBQUVhOK1JNVDFMb0FmUmsybzd5ZlhqNW5J?=
 =?utf-8?Q?VU4z5V5xlnlbGTdkRrEvyuF4NAJhKeYfn96YJyy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466785d4-4a85-497c-1cbd-08db66320374
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 02:01:59.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3HKSnjZG+3moMgmDQmkBGgLZO7o2XL+srwlERhPJM/H8ee31SRxIX75Ej/lY1eKRjp/5a8mQX/b6Gy8i47JyoPCpek2LYrdYwaS3Mo/80U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060017
X-Proofpoint-ORIG-GUID: xfGtnFe5BAgga85BYe2G0wqdAjJilStX
X-Proofpoint-GUID: xfGtnFe5BAgga85BYe2G0wqdAjJilStX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_190256_632832_7A403F1E 
X-CRM114-Status: GOOD (  28.43  )
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

SGkgQ29pYnksCgpPbiA2LzQvMjMgNzo0MCBQTSwgQ29pYnkgWHUgd3JvdGU6Cj4gSGkgQW50aG9u
eSwKPgo+IE9uIFdlZCwgQXByIDI2LCAyMDIzIGF0IDA1OjA4OjQzUE0gLTA3MDAsIEFudGhvbnkg
WXpuYWdhIHdyb3RlOgo+PiBUaGUgUEtSQU0gc3VwZXIgYmxvY2sgaXMgdGhlIHN0YXJ0aW5nIHBv
aW50IGZvciByZXN0b3JpbmcgcHJlc2VydmVkCj4+IG1lbW9yeS4gQnkgcHJvdmlkaW5nIHRoZSBz
dXBlciBibG9jayB0byB0aGUgbmV3IGtlcm5lbCBhdCBib290IHRpbWUsCj4+IHByZXNlcnZlZCBt
ZW1vcnkgY2FuIGJlIHJlc2VydmVkIGFuZCBtYWRlIGF2YWlsYWJsZSB0byBiZSByZXN0b3JlZC4K
Pj4gVG8gcG9pbnQgdGhlIGtlcm5lbCB0byB0aGUgbG9jYXRpb24gb2YgdGhlIHN1cGVyIGJsb2Nr
LCBvbmUgcGFzc2VzCj4+IGl0cyBwZm4gdmlhIHRoZSAncGtyYW0nIGJvb3QgcGFyYW0uIAo+Cj4g
SSdtIGN1cmlvdXMgdG8gYXNrIGhvdyB3aWxsIHRoZSAncGtyYW0nIGJvb3QgcGFyYW0gYmUgcGFz
c2VkLiBJdCBzZWVtcyBJCj4gY2FuJ3QgZmluZCB0aGUgYW5zd2VyIGluIHRoaXMgcGF0Y2ggc2V0
LgoKVGhlIHBmbiBvZiB0aGUgc3VwZXIgYmxvY2sgcmVhZCBmcm9tIC9zeXMva2VybmVsL3BrcmFt
IGlzIHBhc3NlZCB0bwoKdGhlIG5leHQga2VybmVsIGJ5IGFkZGluZyB0aGUgYm9vdCBwYXJhbWV0
ZXIsIHBrcmFtPTxzdXBlciBibG9jayBwZm4+LgoKVGhlIG5leHQga2VybmVsIHBpY2tzIGl0IHVw
IHRocm91Z2ggdGhlIGVhcmx5X3BhcmFtKCJwa3JhbSIsIApwYXJzZV9wa3JhbV9zYl9wZm4pCgpp
biB0aGlzIHBhdGNoIGJlbG93LgoKCkFudGhvbnkKCgo+Cj4KPj4gRm9yIHRoYXQgcHVycG9zZSwg
dGhlIHBrcmFtIHN1cGVyCj4+IGJsb2NrIHBmbiBpcyBleHBvcnRlZCB2aWEgL3N5cy9rZXJuZWwv
cGtyYW0uIElmIG5vbmUgaXMgcGFzc2VkLCBhbnkKPj4gcHJlc2VydmVkIG1lbW9yeSB3aWxsIG5v
dCBiZSBrZXB0LCBhbmQgYSBuZXcgc3VwZXIgYmxvY2sgd2lsbCBiZQo+PiBhbGxvY2F0ZWQuCj4+
Cj4+IE9yaWdpbmFsbHktYnk6IFZsYWRpbWlyIERhdnlkb3YgPHZkYXZ5ZG92LmRldkBnbWFpbC5j
b20+Cj4+IFNpZ25lZC1vZmYtYnk6IEFudGhvbnkgWXpuYWdhIDxhbnRob255Lnl6bmFnYUBvcmFj
bGUuY29tPgo+PiAtLS0KPj4gbW0vcGtyYW0uYyB8IDEwMiAKPj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+PiAxIGZpbGUgY2hh
bmdlZCwgMTAwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9tbS9wa3JhbS5jIGIvbW0vcGtyYW0uYwo+PiBpbmRleCBkYTE2NmNiNmFmYjcuLmM2NmIyYWU0
ZDUyMCAxMDA2NDQKPj4gLS0tIGEvbW0vcGtyYW0uYwo+PiArKysgYi9tbS9wa3JhbS5jCj4+IEBA
IC01LDE1ICs1LDE4IEBACj4+ICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Cj4+ICNpbmNsdWRlIDxs
aW51eC9pby5oPgo+PiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4+ICsjaW5jbHVkZSA8bGlu
dXgva29iamVjdC5oPgo+PiAjaW5jbHVkZSA8bGludXgvbGlzdC5oPgo+PiAjaW5jbHVkZSA8bGlu
dXgvbW0uaD4KPj4gI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+PiAjaW5jbHVkZSA8bGludXgv
bXV0ZXguaD4KPj4gI2luY2x1ZGUgPGxpbnV4L25vdGlmaWVyLmg+Cj4+ICsjaW5jbHVkZSA8bGlu
dXgvcGZuLmg+Cj4+ICNpbmNsdWRlIDxsaW51eC9wa3JhbS5oPgo+PiAjaW5jbHVkZSA8bGludXgv
cmVib290Lmg+Cj4+ICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgo+PiAjaW5jbHVkZSA8bGludXgv
c3RyaW5nLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvc3lzZnMuaD4KPj4gI2luY2x1ZGUgPGxpbnV4
L3R5cGVzLmg+Cj4+Cj4+ICNpbmNsdWRlICJpbnRlcm5hbC5oIgo+PiBAQCAtODIsMTIgKzg1LDM4
IEBAIHN0cnVjdCBwa3JhbV9ub2RlIHsKPj4gI2RlZmluZSBQS1JBTV9BQ0NNT0RFX01BU0vCoMKg
wqAgMwo+Pgo+PiAvKgo+PiArICogVGhlIFBLUkFNIHN1cGVyIGJsb2NrIGNvbnRhaW5zIGRhdGEg
bmVlZGVkIHRvIHJlc3RvcmUgdGhlIAo+PiBwcmVzZXJ2ZWQgbWVtb3J5Cj4+ICsgKiBzdHJ1Y3R1
cmUgb24gYm9vdC4gVGhlIHBvaW50ZXIgdG8gaXQgKHBmbikgc2hvdWxkIGJlIHBhc3NlZCB2aWEg
Cj4+IHRoZSAncGtyYW0nCj4+ICsgKiBib290IHBhcmFtIGlmIG9uZSB3YW50cyB0byByZXN0b3Jl
IHByZXNlcnZlZCBkYXRhIHNhdmVkIGJ5IHRoZSAKPj4gcHJldmlvdXNseQo+PiArICogZXhlY3V0
aW5nIGtlcm5lbC4gRm9yIHRoYXQgcHVycG9zZSB0aGUga2VybmVsIGV4cG9ydHMgdGhlIHBmbiB2
aWEKPj4gKyAqIC9zeXMva2VybmVsL3BrcmFtLiBJZiBub25lIGlzIHBhc3NlZCwgcHJlc2VydmVk
IG1lbW9yeSBpZiBhbnkgCj4+IHdpbGwgbm90IGJlCj4+ICsgKiBwcmVzZXJ2ZWQgYW5kIGEgbmV3
IGNsZWFuIHBhZ2Ugd2lsbCBiZSBhbGxvY2F0ZWQgZm9yIHRoZSBzdXBlciAKPj4gYmxvY2suCj4+
ICsgKgo+PiArICogVGhlIHN0cnVjdHVyZSBvY2N1cGllcyBhIG1lbW9yeSBwYWdlLgo+PiArICov
Cj4+ICtzdHJ1Y3QgcGtyYW1fc3VwZXJfYmxvY2sgewo+PiArwqDCoMKgIF9fdTY0wqDCoMKgIG5v
ZGVfcGZuO8KgwqDCoMKgwqDCoMKgIC8qIGZpcnN0IGVsZW1lbnQgb2YgdGhlIG5vZGUgbGlzdCAq
Lwo+PiArfTsKPj4gKwo+PiArc3RhdGljIHVuc2lnbmVkIGxvbmcgcGtyYW1fc2JfcGZuIF9faW5p
dGRhdGE7Cj4+ICtzdGF0aWMgc3RydWN0IHBrcmFtX3N1cGVyX2Jsb2NrICpwa3JhbV9zYjsKPj4g
Kwo+PiArLyoKPj4gwqAqIEZvciBjb252ZW5pZW5jZSBzYWtlIFBLUkFNIG5vZGVzIGFyZSBrZXB0
IGluIGFuIGF1eGlsaWFyeSAKPj4gZG91Ymx5LWxpbmtlZCBsaXN0Cj4+IMKgKiBjb25uZWN0ZWQg
dGhyb3VnaCB0aGUgbHJ1IGZpZWxkIG9mIHRoZSBwYWdlIHN0cnVjdC4KPj4gwqAqLwo+PiBzdGF0
aWMgTElTVF9IRUFEKHBrcmFtX25vZGVzKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIGxpbmtl
ZCB0aHJvdWdoIHBhZ2U6OmxydSAqLwo+PiBzdGF0aWMgREVGSU5FX01VVEVYKHBrcmFtX211dGV4
KTvCoMKgwqDCoMKgwqDCoCAvKiBzZXJpYWxpemVzIG9wZW4vY2xvc2UgKi8KPj4KPj4gKy8qCj4+
ICsgKiBUaGUgUEtSQU0gc3VwZXIgYmxvY2sgcGZuLCBzZWUgYWJvdmUuCj4+ICsgKi8KPj4gK3N0
YXRpYyBpbnQgX19pbml0IHBhcnNlX3BrcmFtX3NiX3BmbihjaGFyICphcmcpCj4+ICt7Cj4+ICvC
oMKgwqAgcmV0dXJuIGtzdHJ0b3VsKGFyZywgMTYsICZwa3JhbV9zYl9wZm4pOwo+PiArfQo+PiAr
ZWFybHlfcGFyYW0oInBrcmFtIiwgcGFyc2VfcGtyYW1fc2JfcGZuKTsKPj4gKwo+PiBzdGF0aWMg
aW5saW5lIHN0cnVjdCBwYWdlICpwa3JhbV9hbGxvY19wYWdlKGdmcF90IGdmcF9tYXNrKQo+PiB7
Cj4+IMKgwqDCoMKgcmV0dXJuIGFsbG9jX3BhZ2UoZ2ZwX21hc2spOwo+PiBAQCAtMjcwLDYgKzI5
OSw3IEBAIHN0YXRpYyB2b2lkIHBrcmFtX3N0cmVhbV9pbml0KHN0cnVjdCBwa3JhbV9zdHJlYW0g
Cj4+ICpwcywKPj4gwqAqIEBnZnBfbWFzayBzcGVjaWZpZXMgdGhlIG1lbW9yeSBhbGxvY2F0aW9u
IG1hc2sgdG8gYmUgdXNlZCB3aGVuIAo+PiBzYXZpbmcgZGF0YS4KPj4gwqAqCj4+IMKgKiBFcnJv
ciB2YWx1ZXM6Cj4+ICsgKsKgwqDCoCAlRU5PREVWOiBQS1JBTSBub3QgYXZhaWxhYmxlCj4+IMKg
KsKgwqDCoCAlRU5BTUVUT09MT05HOiBuYW1lIGxlbiA+PSBQS1JBTV9OQU1FX01BWAo+PiDCoCrC
oMKgwqAgJUVOT01FTTogaW5zdWZmaWNpZW50IG1lbW9yeSBhdmFpbGFibGUKPj4gwqAqwqDCoMKg
ICVFRVhJU1Q6IG5vZGUgd2l0aCBzcGVjaWZpZWQgbmFtZSBhbHJlYWR5IGV4aXN0cwo+PiBAQCAt
Mjg1LDYgKzMxNSw5IEBAIGludCBwa3JhbV9wcmVwYXJlX3NhdmUoc3RydWN0IHBrcmFtX3N0cmVh
bSAqcHMsIAo+PiBjb25zdCBjaGFyICpuYW1lLCBnZnBfdCBnZnBfbWFzawo+PiDCoMKgwqDCoHN0
cnVjdCBwa3JhbV9ub2RlICpub2RlOwo+PiDCoMKgwqDCoGludCBlcnIgPSAwOwo+Pgo+PiArwqDC
oMKgIGlmICghcGtyYW1fc2IpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPj4g
Kwo+PiDCoMKgwqDCoGlmIChzdHJsZW4obmFtZSkgPj0gUEtSQU1fTkFNRV9NQVgpCj4+IMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRU5BTUVUT09MT05HOwo+Pgo+PiBAQCAtNDA0LDYgKzQzNyw3IEBA
IHZvaWQgcGtyYW1fZGlzY2FyZF9zYXZlKHN0cnVjdCBwa3JhbV9zdHJlYW0gKnBzKQo+PiDCoCog
UmV0dXJucyAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvbiBmYWlsdXJlLgo+PiDCoCoKPj4gwqAqIEVy
cm9yIHZhbHVlczoKPj4gKyAqwqDCoMKgICVFTk9ERVY6IFBLUkFNIG5vdCBhdmFpbGFibGUKPj4g
wqAqwqDCoMKgICVFTk9FTlQ6IG5vZGUgd2l0aCBzcGVjaWZpZWQgbmFtZSBkb2VzIG5vdCBleGlz
dAo+PiDCoCrCoMKgwqAgJUVCVVNZOiBzYXZlIHRvIHJlcXVpcmVkIG5vZGUgaGFzIG5vdCBmaW5p
c2hlZCB5ZXQKPj4gwqAqCj4+IEBAIC00MTQsNiArNDQ4LDkgQEAgaW50IHBrcmFtX3ByZXBhcmVf
bG9hZChzdHJ1Y3QgcGtyYW1fc3RyZWFtICpwcywgCj4+IGNvbnN0IGNoYXIgKm5hbWUpCj4+IMKg
wqDCoMKgc3RydWN0IHBrcmFtX25vZGUgKm5vZGU7Cj4+IMKgwqDCoMKgaW50IGVyciA9IDA7Cj4+
Cj4+ICvCoMKgwqAgaWYgKCFwa3JhbV9zYikKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5P
REVWOwo+PiArCj4+IMKgwqDCoMKgbXV0ZXhfbG9jaygmcGtyYW1fbXV0ZXgpOwo+PiDCoMKgwqDC
oG5vZGUgPSBwa3JhbV9maW5kX25vZGUobmFtZSk7Cj4+IMKgwqDCoMKgaWYgKCFub2RlKSB7Cj4+
IEBAIC04MjUsNiArODYyLDEzIEBAIHN0YXRpYyB2b2lkIF9fcGtyYW1fcmVib290KHZvaWQpCj4+
IMKgwqDCoMKgwqDCoMKgIG5vZGUtPm5vZGVfcGZuID0gbm9kZV9wZm47Cj4+IMKgwqDCoMKgwqDC
oMKgIG5vZGVfcGZuID0gcGFnZV90b19wZm4ocGFnZSk7Cj4+IMKgwqDCoMKgfQo+PiArCj4+ICvC
oMKgwqAgLyoKPj4gK8KgwqDCoMKgICogWmVybyBvdXQgcGtyYW1fc2IgY29tcGxldGVseSBzaW5j
ZSBpdCBtYXkgaGF2ZSBiZWVuIHBhc3NlZCBmcm9tCj4+ICvCoMKgwqDCoCAqIHRoZSBwcmV2aW91
cyBib290Lgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCBtZW1zZXQocGtyYW1fc2IsIDAsIFBB
R0VfU0laRSk7Cj4+ICvCoMKgwqAgcGtyYW1fc2ItPm5vZGVfcGZuID0gbm9kZV9wZm47Cj4+IH0K
Pj4KPj4gc3RhdGljIGludCBwa3JhbV9yZWJvb3Qoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpub3Rp
ZmllciwKPj4gQEAgLTgzMiw3ICs4NzYsOCBAQCBzdGF0aWMgaW50IHBrcmFtX3JlYm9vdChzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sgCj4+ICpub3RpZmllciwKPj4gewo+PiDCoMKgwqDCoGlmICh2YWwg
IT0gU1lTX1JFU1RBUlQpCj4+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBOT1RJRllfRE9ORTsKPj4g
LcKgwqDCoCBfX3BrcmFtX3JlYm9vdCgpOwo+PiArwqDCoMKgIGlmIChwa3JhbV9zYikKPj4gK8Kg
wqDCoMKgwqDCoMKgIF9fcGtyYW1fcmVib290KCk7Cj4+IMKgwqDCoMKgcmV0dXJuIE5PVElGWV9P
SzsKPj4gfQo+Pgo+PiBAQCAtODQwLDkgKzg4NSw2MiBAQCBzdGF0aWMgaW50IHBrcmFtX3JlYm9v
dChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgCj4+ICpub3RpZmllciwKPj4gwqDCoMKgwqAubm90aWZp
ZXJfY2FsbCA9IHBrcmFtX3JlYm9vdCwKPj4gfTsKPj4KPj4gK3N0YXRpYyBzc2l6ZV90IHNob3df
cGtyYW1fc2JfcGZuKHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+PiArwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGtvYmpfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCj4+ICt7Cj4+ICvCoMKgwqAgdW5z
aWduZWQgbG9uZyBwZm4gPSBwa3JhbV9zYiA/IFBGTl9ET1dOKF9fcGEocGtyYW1fc2IpKSA6IDA7
Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gc3ByaW50ZihidWYsICIlbHhcbiIsIHBmbik7Cj4+ICt9
Cj4+ICsKPj4gK3N0YXRpYyBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgcGtyYW1fc2JfcGZuX2F0dHIg
PQo+PiArwqDCoMKgIF9fQVRUUihwa3JhbSwgMDQ0NCwgc2hvd19wa3JhbV9zYl9wZm4sIE5VTEwp
Owo+PiArCj4+ICtzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqcGtyYW1fYXR0cnNbXSA9IHsKPj4g
K8KgwqDCoCAmcGtyYW1fc2JfcGZuX2F0dHIuYXR0ciwKPj4gK8KgwqDCoCBOVUxMLAo+PiArfTsK
Pj4gKwo+PiArc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgcGtyYW1fYXR0cl9ncm91cCA9
IHsKPj4gK8KgwqDCoCAuYXR0cnMgPSBwa3JhbV9hdHRycywKPj4gK307Cj4+ICsKPj4gKy8qIHJl
dHVybnMgbm9uLXplcm8gb24gc3VjY2VzcyAqLwo+PiArc3RhdGljIGludCBfX2luaXQgcGtyYW1f
aW5pdF9zYih2b2lkKQo+PiArewo+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgcGZuOwo+PiArwqDC
oMKgIHN0cnVjdCBwa3JhbV9ub2RlICpub2RlOwo+PiArCj4+ICvCoMKgwqAgaWYgKCFwa3JhbV9z
Yikgewo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2U7Cj4+ICsKPj4gK8KgwqDC
oMKgwqDCoMKgIHBhZ2UgPSBwa3JhbV9hbGxvY19wYWdlKEdGUF9LRVJORUwgfCBfX0dGUF9aRVJP
KTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcGFnZSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwcl9lcnIoIlBLUkFNOiBGYWlsZWQgdG8gYWxsb2NhdGUgc3VwZXIgYmxvY2tcbiIpOwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gK8KgwqDCoMKgwqDCoMKgIH0K
Pj4gK8KgwqDCoMKgwqDCoMKgIHBrcmFtX3NiID0gcGFnZV9hZGRyZXNzKHBhZ2UpOwo+PiArwqDC
oMKgIH0KPj4gKwo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIEJ1aWxkIGF1eGlsaWFyeSBk
b3VibHktbGlua2VkIGxpc3Qgb2Ygbm9kZXMgY29ubmVjdGVkIHRocm91Z2gKPj4gK8KgwqDCoMKg
ICogcGFnZTo6bHJ1IGZvciBjb252ZW5pZW5jZSBzYWtlLgo+PiArwqDCoMKgwqAgKi8KPj4gK8Kg
wqDCoCBwZm4gPSBwa3JhbV9zYi0+bm9kZV9wZm47Cj4+ICvCoMKgwqAgd2hpbGUgKHBmbikgewo+
PiArwqDCoMKgwqDCoMKgwqAgbm9kZSA9IHBmbl90b19rYWRkcihwZm4pOwo+PiArwqDCoMKgwqDC
oMKgwqAgcGtyYW1faW5zZXJ0X25vZGUobm9kZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBwZm4gPSBu
b2RlLT5ub2RlX3BmbjsKPj4gK8KgwqDCoCB9Cj4+ICvCoMKgwqAgcmV0dXJuIDE7Cj4+ICt9Cj4+
ICsKPj4gc3RhdGljIGludCBfX2luaXQgcGtyYW1faW5pdCh2b2lkKQo+PiB7Cj4+IC3CoMKgwqAg
cmVnaXN0ZXJfcmVib290X25vdGlmaWVyKCZwa3JhbV9yZWJvb3Rfbm90aWZpZXIpOwo+PiArwqDC
oMKgIGlmIChwa3JhbV9pbml0X3NiKCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHJlZ2lzdGVyX3Jl
Ym9vdF9ub3RpZmllcigmcGtyYW1fcmVib290X25vdGlmaWVyKTsKPj4gK8KgwqDCoMKgwqDCoMKg
IHN5c2ZzX3VwZGF0ZV9ncm91cChrZXJuZWxfa29iaiwgJnBrcmFtX2F0dHJfZ3JvdXApOwo+PiAr
wqDCoMKgIH0KPj4gwqDCoMKgwqByZXR1cm4gMDsKPj4gfQo+PiBtb2R1bGVfaW5pdChwa3JhbV9p
bml0KTsKPj4gLS0gCj4+IDEuOS40Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4+IGtleGVjIG1haWxpbmcgbGlzdAo+PiBrZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMKPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
