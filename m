Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A7FEB64DA
	for <kexec@archiver.kernel.org>; Wed, 12 Jul 2023 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JInEJqMmRHr6OGcpgVsYOijX7SWVYcoAljNcAFWwEtk=; b=QUfTl/K2YHkJEH
	1hkXVb5L9+AyedQKBy6KcbxgqOGjGE551cC3Y7cVdL0VfYZr2Nsbq469I0ZwBASLgVv8Tj2Me3bbS
	TD+k2CEZGW9To156WqGcUfi92inO8jNLuZE0BqC6wVqTwMSW6X5QPRkjOq8XTF/Sel7LOLEzvAtjf
	IogTAtm59cATZht5tlcpkIJxezSRdVho0dSuxLB7L2JGcB5+6qM+v5UvSORZz5yPkOuaT+qQhhulu
	2BoRazJHz6Ca+VSEiexUHzgNJl15Lic4RHbzniWzNpTc1qSiO5tut14lWlW0pjc1n6YPr/r8572r/
	HVHjfEQ3bcohvnztHvWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJc1y-000P7i-11;
	Wed, 12 Jul 2023 15:45:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJc1v-000P6U-1M
	for kexec@lists.infradead.org;
	Wed, 12 Jul 2023 15:45:29 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CFgZ2o028515;
	Wed, 12 Jul 2023 15:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=d08nYyuveInuFgoMGYmyl5DZ69xKe06D0LuDLAxx+TA=;
 b=jXXyHBuq88hmCX4ELu9BdxxUmzmaqqa/HNdJZb0HFugkr+2oTwl+oe34pLLyW2UbbzxQ
 bGky26u7I9PhM1UFHbtGb1ufelWt4oV5Fpkc9LVYzFK8vYcRPgW0JICoBgcWb9C3gESd
 qQ05S0BXkux6l0ttIAYQdVkdNtPc7eLRTiOWPFne6WMJmb3+AD1l/ZSUbn+alYJqvk2C
 A1/9qgN0LH+mQQAEuHInQPy0HU4ovqtanW5WBjRzdxIgOjCmjn0MfLg7eV4gE2094zAz
 RNtyYpT5zcnnqj1+v2N5TJ9eUrmPUWyCfvWDCaorCSJs3gk3BpKQaFSTCPZRP3ZwKG8+ Dw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsy28g3gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 15:45:14 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CC04nH014032;
	Wed, 12 Jul 2023 15:45:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
	by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rpye5v94e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 15:45:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CFj9x853608954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jul 2023 15:45:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B9658056;
	Wed, 12 Jul 2023 15:45:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C77C58068;
	Wed, 12 Jul 2023 15:45:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.165.208])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jul 2023 15:45:08 +0000 (GMT)
Message-ID: <0adc4f1754dcbb0412603f48c18bebb25a6cd2a8.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric
	Biederman <ebiederm@xmission.com>
Date: Wed, 12 Jul 2023 11:45:08 -0400
In-Reply-To: <9b7db004-0517-9163-e9d5-9555b416144c@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
	 <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
	 <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
	 <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
	 <9b7db004-0517-9163-e9d5-9555b416144c@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F-SZoSHOURCe-sivmwFw1NYco2UGjrX5
X-Proofpoint-GUID: F-SZoSHOURCe-sivmwFw1NYco2UGjrX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=922 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_084527_463929_3F8B54C4 
X-CRM114-Status: GOOD (  27.46  )
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

On Tue, 2023-07-11 at 12:08 -0700, Tushar Sugandhi wrote:
> Adding Eric to cc.
> 
> On 7/7/23 12:49, Mimi Zohar wrote:
> > On Fri, 2023-07-07 at 11:01 -0400, Mimi Zohar wrote:
> >> Hi Tushar,
> >>
> >> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> >>
> >>> +/*
> >>> + * Called during kexec execute so that IMA can update the measurement list.
> >>> + */
> >>> +static int ima_update_kexec_buffer(struct notifier_block *self,
> >>> +				   unsigned long action, void *data)
> >>> +{
> >>> +	void *new_buffer = NULL;
> >>> +	size_t new_buffer_size, cur_buffer_size;
> >>> +	bool resume = false;
> >>> +
> >>> +	if (!kexec_in_progress) {
> >>> +		pr_info("%s: No kexec in progress.\n", __func__);
> >>> +		return NOTIFY_OK;
> >>> +	}
> >>> +
> >>> +	if (!ima_kexec_buffer) {
> >>> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> >>> +		return NOTIFY_OK;
> >>> +	}
> >>> +
> >>> +	ima_measurements_suspend();
> >>> +
> >>> +	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
> >>> +	new_buffer_size = ima_get_binary_runtime_size();
> >>> +	if (new_buffer_size > cur_buffer_size) {
> >>> +		pr_err("%s: Measurement list grew too large.\n", __func__);
> >>> +		resume = true;
> >>> +		goto out;
> >>> +	}
> >> This changes the current behavior of carrying as many measurements
> >> across kexec as possible.  True the measurement list won't verify
> >> against the TPM PCRs, but not copying the measurements leaves the
> >> impression there weren't any previous measurements.
> >>
> >> This also explains the reason for allocating an IMA buffer (patch 1/10)
> >> and not writing the measurements directly into the kexec buffer.
> > If not carrying even a partial measurement list across kexec is
> > desired, then in addition to the "boot_aggregate" record, define a new
> > record containing the TPM pcrcounter.  With this information,
> > attestation servers will at least be able to detect if the measurement
> > list was truncated.

> Sure.  Recording TPM pcrcounter at boot aggregate and
> Kexec 'load' should provide the necessary information to the
> attestation servers.  We can implement this if needed, based on how
> rest of the series evolves.

Recording the TPM pcrcounter should be done independently of this patch
set.  This patch set would have a dependency on it.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
