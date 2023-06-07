Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2528EC7EE23
	for <kexec@archiver.kernel.org>; Wed,  7 Jun 2023 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/UcV5Xk+PaZWXix2r9rd4mP+rkgaFBtQKe5wxpSi6Lg=; b=yh4MCfNV8lz3zk
	BK4+X2VgkmazpEf82EuvuBUnHGm4vXGGyMNy6VcxZWpReumlzzeH1342jKBUAGbU0q/2F2wjm3eEA
	TVIT+zAk0BGR7MxAkt7CiA3pzkas0adyeidAxuHsAyS5T4ZQHSeLknyX7CnUnRYfUYB6sb9bRZgqQ
	SHwt9R/A9sMwBS33I/BkCkGKH7+CQB/owBPjpc8uDH2H3cB+EXxgmPcCNd+C4SsMe+qCqwn4zEZsS
	WZbaRybpwMQWjH6fu9KJ8Cd+UDI7IuvqKJHPMi+cyNTRqcH3BdukKC3xt22WVujuJR94f0Xhuko18
	Oh+YO2CAcqaB6KmePtuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6y7p-006sif-2u;
	Wed, 07 Jun 2023 18:43:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6y7m-006sgp-24
	for kexec@lists.infradead.org;
	Wed, 07 Jun 2023 18:43:16 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357IHb0D020648;
	Wed, 7 Jun 2023 18:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2bXPJh0M9CyvA8ONrgYdPv6D9q8iWZ5CObDcZOjqHEs=;
 b=P4/ywpaI/3xC6Ldeh76UnqTq5j8IaQlIJm7129W6n0FNQsvS9iKIbyPq5Z3LoBVSIK35
 O3WYMaozwlr49HQgaKeL91XwvEdEvsCxT3WSV823yqiuGx4JplNe1SIFe2U4rEUwEg4E
 2PqlUSih79Baf4n8SIymiFAZCpwF/rPBxIVOLLl3XP68oWvQXFR78PBFe2cMmcFIu5gF
 SMm0+5qZ9dFCfSAiJoMNlzPPo65r09reFueffV2FPnCh2GUJ/LOSfbe4QjH90/2EQM/B
 4rLSRc7oVnuIWzN7xKrJYHeLR4N2+7X2S/L2LplQx7F1oMuHuhmkH+aVOuis1zuLhcWU Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2y1q8fmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jun 2023 18:42:54 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357IZPuO017904;
	Wed, 7 Jun 2023 18:42:53 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2y1q8fmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jun 2023 18:42:53 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 357GjwH2002032;
	Wed, 7 Jun 2023 18:42:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
	by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r2a767rkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jun 2023 18:42:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 357Igokc57082278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jun 2023 18:42:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C823858054;
	Wed,  7 Jun 2023 18:42:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 922855805D;
	Wed,  7 Jun 2023 18:42:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jun 2023 18:42:49 +0000 (GMT)
Message-ID: <dcc8f01e-0971-e826-3a48-ea0c1f2381ae@linux.ibm.com>
Date: Wed, 7 Jun 2023 14:42:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: need help: patches to capture events between kexec load and
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Jonathan McDowell <noodles@fb.com>, bauermann@kolabnow.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, code@tyhicks.com
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
 <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
 <87775c1e-d1d3-519c-599b-30cdb1691cb2@linux.microsoft.com>
 <4eff26f794254c1f06ace12e68527fd3452ac47d.camel@linux.ibm.com>
 <41270374-dc5e-3aa2-d2ed-9b8fc73ad65f@linux.microsoft.com>
 <8308a411a50a1168aa5a1a0d70138b29cea73914.camel@linux.ibm.com>
 <3748147f-85f5-4aeb-0083-cbeef375e12a@linux.ibm.com>
 <91dd069c090522be1e3369e83520d3813336b5bf.camel@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <91dd069c090522be1e3369e83520d3813336b5bf.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: shzeJ4WtPfeBeBMkzgKXUidhw8QwnNAt
X-Proofpoint-ORIG-GUID: kjhksj5oLYRBnX6-cPoUe3wN5gufu-52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_114314_889310_82866176 
X-CRM114-Status: GOOD (  29.73  )
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



On 6/6/23 11:59, Mimi Zohar wrote:
> On Tue, 2023-06-06 at 11:37 -0400, Stefan Berger wrote:
>>
>> On 5/31/23 18:43, Mimi Zohar wrote:
>>> On Wed, 2023-05-31 at 15:02 -0700, Tushar Sugandhi wrote:
>>>> Hi Mimi,
>>>>
>>>> On 5/31/23 04:39, Mimi Zohar wrote:
>>>>> Hi Tushar,
>>>>>
>>>>> On Thu, 2023-05-25 at 10:21 -0700, Tushar Sugandhi wrote:
>>>>>
>>>>>> The issue of IMA measurements getting lost between kexec 'load' and 'execute' still exists.
>>>>>> I verified it on the mainline kernel 6.4.rc3. See *Appendix A* for details.
>>
>> I think there's a 2nd problem.  Once the IMA measurement list is frozen (at kexec 'exec' stage)
>> IMA must stop extending PCRs. It can log (into the void) if it wanted to but the PCR extensions
>> have to stop otherwise the TPM's PCR state won't match the log in the kexec'ed-to kernel. I have
>> seen that on PPC64 some processes are being kicked off by kexec 'exec' that end up causing TPM
>> driver error message due to what seems to be a shutdown of the driver subsystem at this point.
>> I am not sure what an elegant method would be to stop PCR extensions. Maybe a flag on the level
>> of IMA would do? Or notifying the TPM driver to reject PCR extensions or just any command?
> 
> Thank you for raising this concern.
> 
> Agreed "kexec exec" might trigger additional measurements.  As long as
> these are known, consistent measurements, they could be pre-measured
> before calling "kexec exec".
> 

Tushar, Mimi,

   I tried this now on ppc64 and with the following patch applied on top of yours it seems to work.
Also the problem with the TPM PCR extensions seems to be gone with your changes to
ima_add_template_entry()  -- it's probably worth mentioning this in the patch description.

phys_to_page doesn't seem to be generally available, so hopefully this will be a solution for more architectures.
[I haven't tested this on x86_64 since I couldn't get kexec to work just to begin with in any of my VMs.]

Regards,
    Stefan

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f0bbdd403b6c..30ab7f81b508 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -966,7 +966,7 @@ void *kimage_map_segment(struct kimage *image,
                 else if (entry & IND_SOURCE) {
                         if (dest_page_addr >= addr && dest_page_addr < eaddr) {
                                 src_page_addr = entry & PAGE_MASK;
-                               src_pages[i++] = phys_to_page(src_page_addr);
+                               src_pages[i++] = virt_to_page(__va(src_page_addr));
                                 if (i == npages)
                                         break;
                                 dest_page_addr += PAGE_SIZE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
