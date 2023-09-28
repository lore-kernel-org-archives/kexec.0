Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF04E743C2
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ANIspHVZIkjX/C/uMhGhPyMbmf4FbUBE8YcQv0l5iIo=; b=yC9xN/bLfoPgeK
	FecBdFuIXPfT0s60sJ+IBybdWBq+lGf+DndWTOL7rRXJ+GsylSokfP6kYDVTI5S1F3C+q0MG3IG/U
	y9XRVJvMZVumyFuridM+iJY8AoJ4Ee735oSHx+2rnBSJWQbp3mRrSLV0FSs7dCnXsbOtThzqC6xyh
	lLxUibLVal0HEndx1Hgq0qryS9LDDvOYOKwDzn7bXPuV8+XQsvbUh9IZgnK15UVM2WKwTYfGz2j3L
	oT+/UDcRF59kHxmnWQTmmPwFT+442nniPMnbxi8XBR1FV2wF3VyfMckMH5guOF87OvwQnj5WZ0FDg
	xiH5WwRCXv9xCvlu+P2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlxkP-006eQb-2y;
	Thu, 28 Sep 2023 20:36:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlxkM-006ePt-0h
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 20:36:32 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SKOKAB012813;
	Thu, 28 Sep 2023 20:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=Zbfd/EmNlXDWBZy/tPdXOOOcZoed+AzlVCMKbj0hak4=;
 b=sIZJil+LvzoUgYmPTRQMRxUt2dQqWH7FTq3iCz6qWIk68vYAUU9+EreitRLpmy8aabKt
 Qc0OKF1mdorZLZgl37u3TYcKVZs6A3uLI0XoXYYGy1yndu2ABOZIGi400F70PJqaamj8
 yRVkNW/ZAqmDcXVNNlUujIl567DvHTXVPT/jUHNV4b77fbRs8/XTktGK//7e1Q/bRumF
 lRv4qYu6LEinYlWf+C25xs03Tw8X6iyIoAmAzGDyxYN5NQn1LVkIyZhzo+cssCfb7/CS
 5BHMmtgeTz0aCZjuu52sVrWGtlVPD9R4dFMpL3OG499GuWfELz20SuCdiaXswSSD5TyX qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdggbrb72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 20:36:19 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SKSaTR024875;
	Thu, 28 Sep 2023 20:36:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdggbrb5h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 20:36:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9aXXixQVp44bmk9PQcX+1elziWVOVcWvfvDdD3VbdJ0QehSpVEBm+3LDHiLGIVZTz7irxr8rBFWXorD3WYg28MtX/AV89rceZehirvJ2vmUiS5gP01ddX+VaC6fU+D6TlZs/x3UkY1KOMwEAQCkDs97oHVJeIGvFgrUkwix9sDt7woIh3fDoyVOSHOuBwd1+md0mJj/Bpl2E2H0NQvdtNCDzFVdeD1mTZhxnzgLgV8AUCbUKM/4mn42HwLQlekNYUGX6zCltnpQg/RaXCbV8QWLZj/t9Y6qOyGSRmAgUhJXpvmZTXxnvLotEu0uNT8w4BGAYbXl5a65YA9qDYRjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbfd/EmNlXDWBZy/tPdXOOOcZoed+AzlVCMKbj0hak4=;
 b=Ji4qgfBtGWMdsIWjMy4gHeL67fYeEQ3KgrB3Wdyg9+OZjEd2yTT7Mz+sOm+ZxDSZYV4nozr4hy9ee7w5AJl7k7WINRYsXk8FIK7yXWRTITjqrf09HUTG4g3EwCs/9x7GNmm4AV90mjHmE3zjvajuX651jWoSXKmv1ZJWaiVL0biy2sx9W8EtlHikB/hrtMyZTUVkBwzHXjrt5YrwB3WefpjqqaeAZqPGH3I+5XKTaDOy9QNjJV/6C85GDGFQ7/ZlUyrVky1e0egtftkXLxCiMKozc0RjjFbt1ZtDqCKXGFeXrG1di27hqG4giiELGbRGCpl81L/nYNgXXCLhakgMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from BL3PR15MB5458.namprd15.prod.outlook.com (2603:10b6:208:3b9::7)
 by SA1PR15MB4572.namprd15.prod.outlook.com (2603:10b6:806:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 20:36:14 +0000
Received: from BL3PR15MB5458.namprd15.prod.outlook.com
 ([fe80::1fe3:c9ea:7cb6:b9bb]) by BL3PR15MB5458.namprd15.prod.outlook.com
 ([fe80::1fe3:c9ea:7cb6:b9bb%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 20:36:14 +0000
From: Wen Xiong <wenxiong@us.ibm.com>
To: Pingfan Liu <piliu@redhat.com>,
        "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
CC: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Thread-Topic: [EXTERNAL] [PATCHv7 2/4] powerpc/setup: Loosen the mapping
 between cpu logical id and its seq in dt
Thread-Index: AQHZ74WBt8xJRenf4UuqSF7N8hydorAwtx4w
Date: Thu, 28 Sep 2023 20:36:14 +0000
Message-ID: <BL3PR15MB54581456FAB1CF28C9F761B4F0C1A@BL3PR15MB5458.namprd15.prod.outlook.com>
References: <20230925075348.16654-1-piliu@redhat.com>
 <20230925075348.16654-3-piliu@redhat.com>
In-Reply-To: <20230925075348.16654-3-piliu@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR15MB5458:EE_|SA1PR15MB4572:EE_
x-ms-office365-filtering-correlation-id: 585cd3b9-7af5-472b-4b1f-08dbc0628f57
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /J/brsAaVzJHLv7LXUZPkrj/oNuGljSfut4MEdUecCd7IOolm8Wx7Sc13rfL+n+fq2/YnczUhhTD+5tgtYeHF0h75JpKjhVFSVHQN8vyaYlRPMpEmVn3PMuNJ/MYq83MK24lXviQkgdDYFjVMPqFGZBDyHhwwuOD8NEhirBAssh5ZBoi7MgjOvE+AcDSQTH0CSaT0RMlnj27ladIt6+SIfJ9jQOtdfYBcOaX4WNn5HtASipBc1wM7e0uC2McmTtqgApO1VS7QIFy/DHeN4xBjPG9fQxp+emMFKru+KKVtiFqaOn2U6fOFyHF4ovr/OV7DTcjCwFn4P+pfB4jP0ZJg14gXj2G/pJLMxqaqXy94aPSvgFkfEVWwOIWOoi1jybMF5ZOP7kl/4j+DNB74+mHjcuJZg/QGsEdqFxKVQQZwb5HghJHNfYZdHMzMyGZm6II8Y078fIWAK53XgqSOJXbZPYtN40y0CIZ+tvTNh2kvvBr63CgrUwAtBkRas0l6V5Op/v+ugNi2icVikqyJ86Op5QFHbSdOKcX5xajIppzKo3E87U+6OyzjJsKxfAnQJx4dLvIuKzRzudXFa7IevOw0HCWJrk+ZmmZUUjhas70UHXSiDo8QR/YQYt0PBbENvR1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR15MB5458.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(26005)(54906003)(66476007)(86362001)(64756008)(66556008)(53546011)(33656002)(9686003)(66446008)(7696005)(110136005)(478600001)(38070700005)(2906002)(122000001)(38100700002)(76116006)(83380400001)(55016003)(8936002)(66946007)(52536014)(316002)(5660300002)(4326008)(8676002)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hSeF8r5Mtd6uhiVBvvv4aoaPeWEEdbzbpP04rC0ZS67HXA7gUNtoEVRawXJ8?=
 =?us-ascii?Q?Ya9DbjclljHT19EBgxkY6wRomslXt5IoAIuFjw9midxg6zV724ZeARv5c05/?=
 =?us-ascii?Q?2P8UpEsVqRxRRRF4NHiVFd2plh1Oz9XsHneX7ZkDEyw4s62wYIJrQniQWGkq?=
 =?us-ascii?Q?eTKx0r8sscGfeT+IZZSAhw3R3Re/euLXko4T2yjLcVARCQjXRfqYKLfwdZPg?=
 =?us-ascii?Q?RHHsEDZirwJmiWaRt0uAHtRKtdanbhKgYZySFm6vlzPD0xNNVaZOvN56YUAX?=
 =?us-ascii?Q?47nCMLuxjhtLFAyijaNNyJ9YDIkpMXh8ATbIV928xpIUWsja2oFvvmJxwdNP?=
 =?us-ascii?Q?uw/smV3l+0t7GSIrGm+ocLu6BoOyI4N7jiaJDdIs9fWspaD40VOZeIg+O7G6?=
 =?us-ascii?Q?bYlFV7yPQtfqdf8gX3Jp985SulYB9Vf1GFu5LBdyFudppdnfe3oLAkPgevN4?=
 =?us-ascii?Q?E2bc6E0TXqDmUIn/FwrNFfMz2uuetCfzlmR229cKwukX7ScPvbd61zKpS5mV?=
 =?us-ascii?Q?nXnJqxhkDFgB5Cwi8CmCKTmTxyr5UnMaMDeaWtsSDPBjQkhot32eClj9BvZq?=
 =?us-ascii?Q?YBrMChOyRXiT4ZasqKtmScaud8ke6pEOHw6gYKjfLUw+uKeg5/gZuJGGTOTV?=
 =?us-ascii?Q?v5T05Ie0mcMlTqM4TlrfHBiQYeiEjANyQiWYBPeiIYJ9TBUWZuSrO76DD8oN?=
 =?us-ascii?Q?9KMvw+fOh7Quk8PKUR/Pwm03amuQhsKjaLWhbwyZobuF8xl/LbYXQLJjRlPV?=
 =?us-ascii?Q?dylHQBx8FFGhKfbXuBwLwfeXyMNqOnbqfNPYMcPgcTlxfRnvxXb3JbpuuBaC?=
 =?us-ascii?Q?nZqKYCFHzwHv1kO/KQ/j9GDkaedoMIKydZzIV61JLXb9e2/s4oKWPPSieeKl?=
 =?us-ascii?Q?+FrE2dhFOF4tAKWmdL70PWPmixj3lU52JIEnL2QBkwcaN/zzcqBLDJFIFZnv?=
 =?us-ascii?Q?JfjjqNVEr6X1ew8nSuHk/CRrpHUMS2hjKeDo/vMoOcJ0aIcUQBLkGiBNMIaA?=
 =?us-ascii?Q?zWFeacwTjHenVhPpJFqO3qFQ+KBzc5RozDLjDNWpC/4j8Smjv48h6HH6qZPc?=
 =?us-ascii?Q?pUD5oOFtU7gWOSqSY2HhCLuxgMOO1eOX4Xzg936GEmX76k5fp2C1XPeN3wfq?=
 =?us-ascii?Q?maaJCD8zeHIHYlHz/m68Pu+ZazJPGqlyYRfNJcPhtDwsTMRTHKHkvSpV4mcH?=
 =?us-ascii?Q?1zIObgFhwJGklGP5dEdojZBs4L4VoUgCJK963xLhmqwjfegzalyM+7C4ZKQs?=
 =?us-ascii?Q?OLiP5mZEg5gCbwHRuL9gu93QbZmvrh7loDYheFU6GyJrOfuNdYJXIPbBVUJK?=
 =?us-ascii?Q?L6flsmQDIWBQDz7K/6yxGc2NFkuhI9BpRbLkGUHcVhuLhWIxRiV6gxtbFSmz?=
 =?us-ascii?Q?DULXL1sGFEoLw8UTmZeJOiJ3+nclrqn+8O2RMG7WJnUf4TrasPIrptM7TW7l?=
 =?us-ascii?Q?ch7kK+2XWeWJbuHl3BqPKsu4/XgKEc1hu7M/LbWva5QEdb17B77Q/fHW7C/G?=
 =?us-ascii?Q?VxofOfuYkSRz7PXrNJv0UNwiK+SO1ptcFXpC2iIMY8MzlO+yJT88b9Dn8LXO?=
 =?us-ascii?Q?XyLc+u1W+j23zEnZfMs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR15MB5458.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585cd3b9-7af5-472b-4b1f-08dbc0628f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 20:36:14.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceIJqHY5vdOLk2uYx+JrKr3VJZZaSqy/IXKBPwllk66rGZ6P/o2StSUcF9lIk3aLcsZwyD7W1uBbrz0XL3O7qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4572
X-Proofpoint-ORIG-GUID: UblFiasWhnyfWBnX-VxsDm86snzHR8a-
X-Proofpoint-GUID: WzJPFH_1AFiRpsJtmtby1_fw7cc0Bb9G
Subject: RE:  [PATCHv7 2/4] powerpc/setup: Loosen the mapping between cpu logical id
 and its seq in dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_133630_620048_7154906A 
X-CRM114-Status: GOOD (  30.78  )
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

Hi Pingfan,

+		avail = intserv_node->avail;
+		nthreads = intserv_node->len / sizeof(int);
+		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			set_cpu_present(cpu, avail);
 			set_cpu_possible(cpu, true);
-			cpu_to_phys_id[cpu] = be32_to_cpu(intserv[j]);
+			cpu_to_phys_id[cpu] = be32_to_cpu(intserv_node->intserv[j]);
+			DBG("    thread %d -> cpu %d (hard id %d)\n",
+			    j, cpu, be32_to_cpu(intserv[j]));

Intserv is not defined. Should "be32_to_cpu(intserv_node->intserv[j])?
 			cpu++;
 		}
+	}

-----Original Message-----
From: Pingfan Liu <piliu@redhat.com> 
Sent: Monday, September 25, 2023 2:54 AM
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>; Michael Ellerman <mpe@ellerman.id.au>; Nicholas Piggin <npiggin@gmail.com>; Christophe Leroy <christophe.leroy@csgroup.eu>; Mahesh Salgaonkar <mahesh@linux.ibm.com>; Wen Xiong <wenxiong@us.ibm.com>; Baoquan He <bhe@redhat.com>; Ming Lei <ming.lei@redhat.com>; kexec@lists.infradead.org
Subject: [EXTERNAL] [PATCHv7 2/4] powerpc/setup: Loosen the mapping between cpu logical id and its seq in dt

*** Idea ***
For kexec -p, the boot cpu can be not the cpu0, this causes the problem of allocating memory for paca_ptrs[]. However, in theory, there is no requirement to assign cpu's logical id as its present sequence in the device tree. But there is something like cpu_first_thread_sibling(), which makes assumption on the mapping inside a core. Hence partially loosening the mapping, i.e. unbind the mapping of core while keep the mapping inside a core.

*** Implement ***
At this early stage, there are plenty of memory to utilize. Hence, this patch allocates interim memory to link the cpu info on a list, then reorder cpus by changing the list head. As a result, there is a rotate shift between the sequence number in dt and the cpu logical number.

*** Result ***
After this patch, a boot-cpu's logical id will always be mapped into the range [0,threads_per_core).

Besides this, at this phase, all threads in the boot core are forced to be onlined. This restriction will be lifted in a later patch with extra effort.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/prom.c         | 25 +++++----
 arch/powerpc/kernel/setup-common.c | 87 +++++++++++++++++++++++-------
 2 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c index ec82f5bda908..87272a2d8c10 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -76,7 +76,9 @@ u64 ppc64_rma_size;
 unsigned int boot_cpu_node_count __ro_after_init;  #endif  static phys_addr_t first_memblock_size;
+#ifdef CONFIG_SMP
 static int __initdata boot_cpu_count;
+#endif
 
 static int __init early_parse_mem(char *p)  { @@ -331,8 +333,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	const __be32 *intserv;
 	int i, nthreads;
 	int len;
-	int found = -1;
-	int found_thread = 0;
+	bool found = false;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0) @@ -355,8 +356,15 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	for (i = 0; i < nthreads; i++) {
 		if (be32_to_cpu(intserv[i]) ==
 			fdt_boot_cpuid_phys(initial_boot_params)) {
-			found = boot_cpu_count;
-			found_thread = i;
+			/*
+			 * always map the boot-cpu logical id into the
+			 * range of [0, thread_per_core)
+			 */
+			boot_cpuid = i;
+			found = true;
+			/* This works around the hole in paca_ptrs[]. */
+			if (nr_cpu_ids < nthreads)
+				set_nr_cpu_ids(nthreads);
 		}
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */ @@ -365,14 +373,13 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	}
 
 	/* Not the boot CPU */
-	if (found < 0)
+	if (!found)
 		return 0;
 
-	DBG("boot cpu: logical %d physical %d\n", found,
-	    be32_to_cpu(intserv[found_thread]));
-	boot_cpuid = found;
+	DBG("boot cpu: logical %d physical %d\n", boot_cpuid,
+	    be32_to_cpu(intserv[boot_cpuid]));
 
-	boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
+	boot_cpu_hwid = be32_to_cpu(intserv[boot_cpuid]);
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1b19a9815672..f6d32324b5a5 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -36,6 +36,7 @@
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/list.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/processor.h>
@@ -425,6 +426,13 @@ static void __init cpu_init_thread_core_maps(int tpc)
 
 u32 *cpu_to_phys_id = NULL;
 
+struct interrupt_server_node {
+	struct list_head node;
+	bool	avail;
+	int	len;
+	__be32 *intserv;
+};
+
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -446,11 +454,16 @@ u32 *cpu_to_phys_id = NULL;  void __init smp_setup_cpu_maps(void)  {
 	struct device_node *dn;
-	int cpu = 0;
-	int nthreads = 1;
+	int shift = 0, cpu = 0;
+	int j, nthreads = 1;
+	int len;
+	struct interrupt_server_node *intserv_node, *n;
+	struct list_head *bt_node, head;
+	bool avail, found_boot_cpu = false;
 
 	DBG("smp_setup_cpu_maps()\n");
 
+	INIT_LIST_HEAD(&head);
 	cpu_to_phys_id = memblock_alloc(nr_cpu_ids * sizeof(u32),
 					__alignof__(u32));
 	if (!cpu_to_phys_id)
@@ -460,7 +473,6 @@ void __init smp_setup_cpu_maps(void)
 	for_each_node_by_type(dn, "cpu") {
 		const __be32 *intserv;
 		__be32 cpu_be;
-		int j, len;
 
 		DBG("  * %pOF...\n", dn);
 
@@ -480,29 +492,68 @@ void __init smp_setup_cpu_maps(void)
 			}
 		}
 
-		nthreads = len / sizeof(int);
-
-		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
-			bool avail;
+		avail = of_device_is_available(dn);
+		if (!avail)
+			avail = !of_property_match_string(dn,
+					"enable-method", "spin-table");
 
-			DBG("    thread %d -> cpu %d (hard id %d)\n",
-			    j, cpu, be32_to_cpu(intserv[j]));
 
-			avail = of_device_is_available(dn);
-			if (!avail)
-				avail = !of_property_match_string(dn,
-						"enable-method", "spin-table");
+		intserv_node = memblock_alloc(sizeof(struct interrupt_server_node) + len,
+					__alignof__(u32));
+		if (!intserv_node)
+			panic("%s: Failed to allocate %zu bytes align=0x%zx\n",
+				__func__,
+				sizeof(struct interrupt_server_node) + len,
+				__alignof__(u32));
+		intserv_node->intserv = (__be32 *)((char *)intserv_node +
+						sizeof(struct interrupt_server_node));
+		intserv_node->len = len;
+		memcpy(intserv_node->intserv, intserv, len);
+		intserv_node->avail = avail;
+		INIT_LIST_HEAD(&intserv_node->node);
+		list_add_tail(&intserv_node->node, &head);
+
+		if (!found_boot_cpu) {
+			nthreads = len / sizeof(int);
+			for (j = 0 ; j < nthreads; j++) {
+				if (be32_to_cpu(intserv[j]) == boot_cpu_hwid) {
+					bt_node = &intserv_node->node;
+					found_boot_cpu = true;
+					/*
+					 * Record the round-shift between dt
+					 * seq and cpu logical number
+					 */
+					shift = cpu - j;
+					break;
+				}
+
+				cpu++;
+			}
+		}
 
+	}
+	cpu = 0;
+	list_del_init(&head);
+	/* Select the primary thread, the boot cpu's slibing, as the logic 0 */
+	list_add_tail(&head, bt_node);
+	pr_info("the round shift between dt seq and the cpu logic number: %d\n", shift);
+	list_for_each_entry(intserv_node, &head, node) {
+
+		avail = intserv_node->avail;
+		nthreads = intserv_node->len / sizeof(int);
+		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			set_cpu_present(cpu, avail);
 			set_cpu_possible(cpu, true);
-			cpu_to_phys_id[cpu] = be32_to_cpu(intserv[j]);
+			cpu_to_phys_id[cpu] = be32_to_cpu(intserv_node->intserv[j]);
+			DBG("    thread %d -> cpu %d (hard id %d)\n",
+			    j, cpu, be32_to_cpu(intserv[j]));
 			cpu++;
 		}
+	}
 
-		if (cpu >= nr_cpu_ids) {
-			of_node_put(dn);
-			break;
-		}
+	list_for_each_entry_safe(intserv_node, n, &head, node) {
+		len = sizeof(struct interrupt_server_node) + intserv_node->len;
+		memblock_free(intserv_node, len);
 	}
 
 	/* If no SMT supported, nthreads is forced to 1 */
--
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
