Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A32CD68FE
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 08:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jaAxslObFeGjJFxQDCHMtsJfrdUk88RsW0Ge3qez+pg=; b=UfavuhaUCt3eLa
	GvAjYP6WQKZx0muDsgKZhMPJAZRoXqQPedlpaSL8CehEZjpudC751X8b5eNMctLpKUraF8nPvG9Tn
	v5y/P6rHCDpzXbtamRHbY63w0/0Lcdc3pP3F8IanvL/6rgEf6F4Zqx75jyqQd1qx5MCpaZPtPE+iK
	s5yNIRR2ekOHvp6EH3FS/xou5pgNZJj0yz4AiGGUS+aKpAhOtWmLHkVdanAF7GYFczoDZUEG8Q+xq
	Df9wxeby7NuyiMlx1EaakUJPp2J4JCb/tDzQplPb+T44eVdYf23orSWJZ7JnZMDK6CH/TLG6jGwiu
	54FpBG8x/XFELwHL86wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq84S-00CpSQ-2q;
	Tue, 10 Oct 2023 08:26:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq84O-00CpQD-0v
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 08:26:28 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A8P4pQ031516;
	Tue, 10 Oct 2023 08:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sxnapVHKhUyMlOcgKPjAwwaPpExMmq9U92IVlVJOelw=;
 b=tPHuU4/6IEqMjDH5dxgsnZEUA6V7203XXdr+a13omiCGn0I7K6iyB4fT+QBc8FeI2xtP
 2GPCO2WelWcqbkcC64j24PM17i2sXbmtjjJA0p90vE0fp566gVXfJRoanuroJAyxymgw
 KW5BXrkDEO5uu+PjcyQ1PyBSxLSbbEpZQLwe5e9WTTuDiuTQ2f8zhwKsiRhy8M/KGYsp
 gf0mFk5NmDs3s+oJuuIdtqImrE9cZ893ogMJKDkp7ORr/WBAzYEDvQ23QEGWNDW2X/kM
 8yq2pqYB4cBEMkEgmvqm8CDdRVa59nIZNtRImGeUgE1BOL38TxwBimfb9gD7KyVllw6H Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn3318215-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 08:26:21 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39A8PF3t032000;
	Tue, 10 Oct 2023 08:26:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn33181ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 08:26:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39A778Fp028239;
	Tue, 10 Oct 2023 08:26:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1xy89h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 08:26:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39A8QG7p16843284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Oct 2023 08:26:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AB520043;
	Tue, 10 Oct 2023 08:26:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA25220040;
	Tue, 10 Oct 2023 08:26:14 +0000 (GMT)
Received: from [9.203.106.137] (unknown [9.203.106.137])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Oct 2023 08:26:14 +0000 (GMT)
Message-ID: <8216e3e3-8475-158f-dc79-1b5ba1032150@linux.ibm.com>
Date: Tue, 10 Oct 2023 13:56:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv8 3/5] powerpc/setup: Handle the case when boot_cpuid
 greater than nr_cpus
To: Pingfan Liu <piliu@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20231009113036.45988-1-piliu@redhat.com>
 <20231009113036.45988-4-piliu@redhat.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20231009113036.45988-4-piliu@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qcOiXTFHAunYHq7vNCh0S8FSdjk3elas
X-Proofpoint-ORIG-GUID: Fxt0V3M0qzpYiUXCdgmDEkVRqJdXDnQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_012624_455127_DE60D222 
X-CRM114-Status: GOOD (  28.39  )
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



On 09/10/23 5:00 pm, Pingfan Liu wrote:
> If the boot_cpuid is smaller than nr_cpus, it requires extra effort to
> ensure the boot_cpu is in cpu_present_mask. This can be achieved by
> reserving the last quota for the boot cpu.
> 
> Note: the restriction on nr_cpus will be lifted with more effort in the
> successive patches
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Wen Xiong <wenxiong@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: kexec@lists.infradead.org
> To: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/setup-common.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 81291e13dec0..f9ef0a2666b0 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -454,8 +454,8 @@ struct interrupt_server_node {
>   void __init smp_setup_cpu_maps(void)
>   {
>   	struct device_node *dn;
> -	int shift = 0, cpu = 0;
> -	int j, nthreads = 1;
> +	int terminate, shift = 0, cpu = 0;
> +	int j, bt_thread = 0, nthreads = 1;
>   	int len;
>   	struct interrupt_server_node *intserv_node, *n;
>   	struct list_head *bt_node, head;
> @@ -518,6 +518,7 @@ void __init smp_setup_cpu_maps(void)
>   			for (j = 0 ; j < nthreads; j++) {
>   				if (be32_to_cpu(intserv[j]) == boot_cpu_hwid) {
>   					bt_node = &intserv_node->node;
> +					bt_thread = j;
>   					found_boot_cpu = true;
>   					/*
>   					 * Record the round-shift between dt
> @@ -537,11 +538,21 @@ void __init smp_setup_cpu_maps(void)
>   	/* Select the primary thread, the boot cpu's slibing, as the logic 0 */
>   	list_add_tail(&head, bt_node);
>   	pr_info("the round shift between dt seq and the cpu logic number: %d\n", shift);
> +	terminate = nr_cpu_ids;
>   	list_for_each_entry(intserv_node, &head, node) {
>   
> +		j = 0;

> +		/* Choose a start point to cover the boot cpu */
> +		if (nr_cpu_ids - 1 < bt_thread) {
> +			/*
> +			 * The processor core puts assumption on the thread id,
> +			 * not to breach the assumption.
> +			 */
> +			terminate = nr_cpu_ids - 1;

nthreads is anyway assumed to be same for all cores. So, enforcing
nr_cpu_ids to a minimum of nthreads (and multiple of nthreads) should
make the code much simpler without the need for above check and the
other complexities addressed in the subsequent patches...

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
