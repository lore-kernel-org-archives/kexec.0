Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81963C55174
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1baXi8To+fUNopTQsvjls+SIISy5DF1xd3UbXgnBhg=; b=uLUJWC2MBw5IHIKohF+Ljdj1RK
	B/3QwTCuIebOaDa8SWte60Slri4CQKxhrbGGGFD2oBIvuCVTWONDe17yebiRZnUruky7JOai6Ne1l
	v8hLDFzL19E7PIgTZ5MdlwH5wHmTt6nZ2AtzJ/xinZCVkd/fWOcrchO5nvcWVVPfGxmB7l0NQG3IH
	xdK2xgzv3hLw4+Lmz4P+rT1mZ5kPLlV0pZkSN8zt7Ul8m310hajeIkgbu1MvrPOPfjluHRezC64Jq
	XA30NA7O+XsIVbFOACmNL7ZnEI3LWoGkLPw94sVc+Yt71tiJeHQHW/iMkZOlkmpQe5IepMMMuRjMk
	7URrHjag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZg2-00000003oG8-0BGZ;
	Wed, 05 Aug 2026 11:20:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZfz-00000003oFd-2KQN
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 11:20:48 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lnnl3438030;
	Wed, 5 Aug 2026 11:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m1baXi
	8To+fUNopTQsvjls+SIISy5DF1xd3UbXgnBhg=; b=k7od5wDLsLZG6wzUedXEWk
	FhyipTg/hK8HdcHuWhrSQe6u1wsBYxM7+qNO452Xoi/Q8j7xNuHdU4pHaN3h+Z7q
	Ukk78+J0KaQJvQ7QHV/HU/kOIdSwLHHnIC5N9DKOtdUaOhvaTJhB4BMdU4q38G5X
	zsxHavQMHHxk3paJ8rhAY0OZMLPNg/1IQC4mQwZ04J8JLo6bQeILkKjMgPhFJsVM
	KCw1lmJ500+xyqNA3oy3Gue9HM5fuWshvieqaKgWmMQbR7OUTERmm/EnARYSIEMX
	6GP2/SdEOTOlBNobZzyC+NFuc2T0Z2MCipAi90W2GtepLE/oH0kG/g6XpdXGoWMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eut6ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:20:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfZOQ006305;
	Wed, 5 Aug 2026 11:20:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k68mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:20:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BKSOO49742202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:20:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB32D2004E;
	Wed,  5 Aug 2026 11:20:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A64F02004B;
	Wed,  5 Aug 2026 11:20:25 +0000 (GMT)
Received: from [9.39.28.63] (unknown [9.39.28.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:20:25 +0000 (GMT)
Message-ID: <91b5adec-a9fd-4790-9ef4-ae99f54d95c4@linux.ibm.com>
Date: Wed, 5 Aug 2026 16:50:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] crash_dump: Free temporary dm-crypt keys_header
 buffer in kdump kernel
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-6-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729033654.311541-6-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1io9RBYzIySU7v8BPdNycSomfkFcOanQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfX6a7oLxRd4DkT
 TGaUOATi2L0+xiwi81cNGMr2XPvXVMylLiB1GUz31KbMNfO9QEu3lmnpqAUBajuU2ZYuKqJNSCf
 BCyoQv3/X+RCemsDI8HjdplPysWF17Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfX0N23kVcRFtZd
 l6v7SotQZuJ8bnOLOjowF4B8rFfMr7v6i2/jXamnns3Xqui+ijTIH2sXCsQ1VJnbm6xslhlFtL0
 /42lQ2JjxH30VdkOiJUuTdEpxaHk0X24rXQO0IPqw0KVa/6msgU/ZiwH0r+Wg4X1+MQPOHoYSnD
 adqiAleClZVRZt0A7YT4GaaXeT+in5+w7aWbfU1EBpWirPudFjlaN/aretkARTT0ZomdL21UnMN
 eDo56q/wMIsbJvQ0uWLIjr6sqG58rSasMI0KYDSPzE4ImvALCWHwPd5jjZrCT/7KgfkXvPtLn7A
 5Z8PwWcCX7p0Q7W+HRVH27KngzJ0i06uAGqIuivLwYhW/kiXMnccRiiGv9v1gTGXFu3mqW/O+1j
 jJg/LyhLLlenQPm+fv3BXvzfjShTS7p6iH0AZiyHx6vz15HHt/HDSxo8VuAFjaVy9XDlmWPbc3/
 9kejRuXyDEa1keJ5Pkw==
X-Proofpoint-GUID: fnyVc4WBUGUEhCJ-wy-TfwbGtYr1lfHt
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a731c80 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=KfXPnQ-rYdLxMRt8lZMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_042047_719839_9672ACB5 
X-CRM114-Status: GOOD (  15.25  )
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



On 29/07/26 09:06, Coiby Xu wrote:
> Although we expect the system to reboot immediately after vmcore dumping
> is finished, it's still good to free the temporary keys_header buffer.
>
> Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index a3996208738b..9a64e2d6841b 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -117,6 +117,7 @@ static int get_keys_from_kdump_reserved_memory(void)
>   
>   static int restore_dm_crypt_keys_to_thread_keyring(void)
>   {
> +	struct keys_header *keys_header __free(kfree_sensitive) = NULL;
>   	struct dm_crypt_key *key;
>   	size_t keys_header_size;
>   	key_ref_t keyring_ref;

Yeah, it's good to release the memory regardless.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

