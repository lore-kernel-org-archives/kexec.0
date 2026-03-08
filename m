Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D690EA8545
	for <kexec@archiver.kernel.org>; Sun,  8 Mar 2026 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EpEbjDc3LPXe8dqsZJCZ7JLX+/M0KZBYRf+V6DsMR40=; b=HOsEZH+YS+c2X3cYgZDViPHl5j
	M7j5Y0M0HvKMK+v7ObRKU0/skGFGSrAvhHWbZ0d3pgQSjhcElrYrYCLhuwfzGKswlrk49VkgNVO78
	hhH5IMYGj0rvNPVW9ExRcwp0hZvJoZsE5msXP0T9V3eajI/Kde6H9t/25qr0qjX4WiJS+xCPPu3Dm
	DtSyXiygtmJDwkH72nsfA2AjAKhjwTrxxAoWImqqmCTfVchc7MGn9AH5DN4rj0EDVNPhK1hDlotBl
	2tLghTNQ7cHrw/7HIZCsaF1FlbgkUbNhrGVM5P/cJmG2Jap2bYB3C1cfTu/ZQ2VRTmGOU9xZqJ15T
	h7VkjUxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzLgv-00000006NCr-0usO;
	Sun, 08 Mar 2026 21:29:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzLgp-00000006NCQ-0AY3
	for kexec@lists.infradead.org;
	Sun, 08 Mar 2026 21:29:32 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628FWs3Y808461;
	Sun, 8 Mar 2026 21:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EpEbjDc3LPXe8dqsZJCZ7JLX+/M0KZ
	BYRf+V6DsMR40=; b=I9eqkDOFnbQPtTpEXW2D9xWLMxexiRK2xyasPtT4MKspvt
	zVs9StzDKbvhjzWBHyPTo+iH1chhrtF1ryaY/gvPfuf6Rm+ZJeK6fM98jc7Q4KlK
	2F/kueNByYrhOrQvKtrRsDRxnuvLbFjcmxcMcL6USQywoBYOzhqf8/du60eHyxKR
	9gf/Cwwc2eZypaiD/KjejGNcj8n6fS3aqsEnp5OUV4nmbuLiHSM4hfVbHmcedktF
	KUeRTaL6omup5rV3xiNW9qjHsClwE4/VVk5bb/V6WoAn/zFEQoK84kNN636+MGjC
	JwymKwH9vn92WgESUT1Tg3yGcDEPIy2zpuxyhNWw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr463y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 21:29:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628KxvVt009081;
	Sun, 8 Mar 2026 21:29:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy2pme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 21:29:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 628LTDiB55640494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Mar 2026 21:29:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A70F2004B;
	Sun,  8 Mar 2026 21:29:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4EB820043;
	Sun,  8 Mar 2026 21:29:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.213.155])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  8 Mar 2026 21:29:08 +0000 (GMT)
Date: Mon, 9 Mar 2026 02:59:05 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] powerpc/kexec/core: use big-endian types for crash
 variables
Message-ID: <aa3iczOcLm12Y3ln@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251224151257.28672-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224151257.28672-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDE5NSBTYWx0ZWRfX/k3e3XuZU+3K
 kAFQNCLYQXcmkpdC6sD2iT+Yw+p/d/yQLVI8jD4zB00sfnqi32yNK+/EkqYfSKWvUwNYsWTTS4U
 mScjpOBxreqdyzWuLZw9uVh1k3IF1Zsxe7lEucWrkrLUaWYjrC/FMQGVSSOClvDz7AwjeYEI/yQ
 36cSyIFlYcEpJCFpfCo+NqPhmsIALvantqlaVujOiYB1rW2MbWZS9pogVWFfwm2vhswQCfDAnue
 TWDS+O+ZZI0dS+GKy4/2m3OsvXDWC0+ohp6Lu6CikHryFaNPqEsqOLpAbcfIylCC+KVkDA9Ar7w
 3II3ju0sFqCacia24w4qRazkyXJiJC6HvOihqdFsPiqccEYjHOBVAATTXkSnZf+eNbhCtMgr5Jo
 BwJlqMrkpn0kUgzYquwHxMQLXbpIsWrn46nINVKVuTbl+UO1BkkAfC/uI7fWjXL/oHb6peh4CPq
 Xi5Cfsd1w0UhyCbJTyA==
X-Proofpoint-GUID: yhiZYhQiGnOrO4p-UGCj5pWqDrHpQDTT
X-Proofpoint-ORIG-GUID: Y-uzDVmMSGGAIbwm3_3UPe1NSofI-dWd
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69adea2e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=HzmoW7uitHk6_fZNSsMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603080195
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260308_142931_622242_7F090644 
X-CRM114-Status: GOOD (  16.23  )
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

On 25/12/24 08:42PM, Sourabh Jain wrote:
> Use explicit word-sized big-endian types for kexec and crash related
> variables. This makes the endianness unambiguous and avoids type
> mismatches that trigger sparse warnings.
> 
> The change addresses sparse warnings like below (seen on both 32-bit
> and 64-bit builds):
> 
> <...snip...>
> ...
>
>  /* Values we need to export to the second kernel via the device tree. */
> -static phys_addr_t crashk_base;
> -static phys_addr_t crashk_size;
> -static unsigned long long mem_limit;
> +static __be_word crashk_base;
> +static __be_word crashk_size;
> +static __be_word mem_limit;
> ...
>  
>  static struct property memory_limit_prop = {
>  	.name = "linux,memory-limit",
> -	.length = sizeof(unsigned long long),
> +	.length = sizeof(__be_word),
>  	.value = &mem_limit,

'mem_limit' has slight change here. it used to be 64bit always,
but now on ppc32 it will be 32bit

I see only one usage of this in arch/powerpc/kernel/prom.c, and don't
see any issue with usage due to the 32-bit/64-bit memory_limit

For the patch:
Reviewed-by: Aditya Gupta <adityaglinux.ibm.com>

Thanks,
- Aditya G


