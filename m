Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B18C001DB
	for <kexec@archiver.kernel.org>; Mon,  7 Aug 2023 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OaKFsxYVylS+mIqo5RodA0lWNyACRUvPnCcMCd7a7Vc=; b=LY8o/ZANIUJTao2RUJL/yNjSO3
	9D5u0/pfCqyhnwG/G6PMc3ERVrfpNLcoWhIsu4AH5RWKdVpzQfmm2WG7yaM3xLgndkjPJVNIy5DVv
	nGnlRS45h08yjm3IHvJszMcPKUTl8uR8XQ2uo9WmKtwC9gMTkNTkdqzWhqCIUlH8ksQC/h09O30Lc
	ra4DW0lam2i6VRaGL55qOk/CVkgs3Nua4TahjJ38V1NqgHgIAV59D8YiRVHQvefYG38MvA8bPUZDP
	T3c1qDLgZk25wqEkDCkA64VHTeNK/ADOV9rOd/9GVZg9QAwOAjlP2j9aiiVLz4nTIr7jBQ7SeiLKe
	9pW+5+aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT92s-0011qW-0N;
	Mon, 07 Aug 2023 22:49:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT92o-0011pG-1n
	for kexec@lists.infradead.org;
	Mon, 07 Aug 2023 22:49:48 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377MnPRF012611;
	Mon, 7 Aug 2023 22:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+6CooSgnHbnLKTlBr/6t5AuLifIIHcmW0yn6xvZilv0=;
 b=pp1i/Kd9Tn5glsCsXwcVXmzJA4jj9Q8xn/75Pm4aIzf/mpXKaDh6aUGXSb2FehF/s9I+
 ffFw+T/eUhVlsbTylg6o6A6UsfhxqoI2toZyHiR2R4lD/XaTHKfRlS86k8lT+6Sld4La
 m/up6pIbYa9bqkECc4W0cQU6UWBP2g+DU2wKaBmLb/odwLYutCJ+kM/RRtBNuaNkGpwj
 VVnpOYQ/9q1kYs20MHjGqc5PgUl+o2wFd0R2fUxcUCIk58XkgaQ5XTZhFpACSTaadaOC
 NrZMkpj1omBw92I6m4uONDj7YqTbtIMOMDXq1arifOpVTruUKSts22J3iOWbMh291p+d Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb9r80046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 22:49:29 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377MnSqU012759;
	Mon, 7 Aug 2023 22:49:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb9r8003w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 22:49:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 377Mcm9V006656;
	Mon, 7 Aug 2023 22:49:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rssm4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 22:49:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 377MnQUS19989024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Aug 2023 22:49:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4D7758055;
	Mon,  7 Aug 2023 22:49:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D523658043;
	Mon,  7 Aug 2023 22:49:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Aug 2023 22:49:25 +0000 (GMT)
Message-ID: <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
Date: Mon, 7 Aug 2023 18:49:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mTcLWF4zRxTB3SOazcI_e657VvnRXgi0
X-Proofpoint-ORIG-GUID: xgMo4RPBwwSYeXY43PFBWfG-OK1BDWgv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_25,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070203
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_154946_610681_7C5AEF42 
X-CRM114-Status: GOOD (  36.58  )
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



On 8/1/23 17:21, James Bottomley wrote:
> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
> [...]
>> Truncating IMA log to reclaim memory is not feasible, since it makes
>> the log go out of sync with the TPM PCR quote making remote
>> attestation fail.
> 
> This assumption isn't entirely true.  It's perfectly possible to shard
> an IMA log using two TPM2_Quote's for the beginning and end PCR values
> to validate the shard.  The IMA log could be truncated in the same way
> (replace the removed part of the log with a TPM2_Quote and AK, so the
> log still validates from the beginning quote to the end).
> 
> If you use a TPM2_Quote mechanism to save the log, all you need to do
> is have the kernel generate the quote with an internal AK.  You can
> keep a record of the quote and the AK at the beginning of the truncated
> kernel log.  If the truncated entries are saved in a file shard it

The truncation seems dangerous to me. Maybe not all the scenarios with an attestation
client (client = reading logs and quoting) are possible then anymore, such as starting
an attestation client only after truncation but a verifier must have witnessed the
system's PCRs and log state before the truncation occurred.

I think an ima-buf (or similar) log entry in IMA log would have to appear at the beginning of the
truncated log stating the value of all PCRs that IMA touched (typically only PCR 10
but it can be others). The needs to be done since the quote itself doesn't
provide the state of the individual PCRs. This would at least allow an attestation
client to re-read the log from the beginning (when it is re-start or started for the
first time after the truncation). However, this alone (without the
internal AK quoting the old state) could lead to abuse where I could create totally
fake IMA logs stating the state of the PCRs at the beginning (so the verifier
syncs its internal PCR state to this state). Further, even with the AK-quote that
you propose I may be able to create fake logs and trick a verifier into
trusting the machine IFF it doesn't know what kernel this system was booted with
that I may have hacked to provide a fake AK-quote that just happens to match the
PCR state presented at the beginning of the log.

=> Can a truncated log be made safe for attestation when the attestation starts
only after the truncation occurred?

=> Even if attestation was occurring 'what' state does an attestation server
need to carry around for an attested-to system so that the truncation is 'safe'
and I cannot create fake AK-quotes and fake IMA logs with initial PCR states?
Can I ever restart the client and have it read the truncated log from the
beginning and what type of verification needs to happen on the server then?
It seems like the server would have to remember the state of the IMA PCRs upon
last truncation to detect a possible attack. This would make staring to monitor
a system after truncation impossible -- would be good to know these details.




> should have a beginning and end quote and a record of the AK used.
> Since verifiers like Keylime are already using this beginning and end
> quote for sharded logs, it's the most natural format to feed to
> something externally for verification and it means you don't have to
> invent a new format to do the same thing.
> 
> Regards,
> 
> James
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
