Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CC4EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PyGA06qkg4WQ40j0qqBSAbOMF7hCPOWreGwLW3Y0HMY=; b=oWM/LW9u+dSYh5
	+RPTR4vrbAAP1A5micE2S86b8kkIUedJJ1LWhJjr3UR2UlQn5TkvFGeFjviLZ4k2eQNBGUX8lndCw
	/5b3r0Zfck+XizKGwovPhe9hXuEW8s2nDY/wa7dYYRwct1JyC3qlGlDIhNnxDO3cbhCXfHyznkfCW
	Lt3Byp3d7YvWZYph8rtBhMqbnLO0avAcymrTilt4LPBt3C7Z44ZLhnkq4Laj0r6LSMjq/dDpoIDiy
	HdOqcS2K36fgJy8t0GtjxuNgsAmSQkwharIzz7CYs5/zS+4abID4OCbA0PvYGdeM/PWwOadGjJGqu
	NoGl7a0THKI1DKga1hdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHrSs-005YtO-0I;
	Fri, 07 Jul 2023 19:50:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHrSp-005YsV-0M
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 19:50:00 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367JjoVt014509;
	Fri, 7 Jul 2023 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AASJHNPtyKDbFRB+w5mz4hm+dMa+gaONJyhB+7+OFpU=;
 b=bH/WPdlNUYSaj0rleW5MUwRaKWm0cZEJ6ixXwNiu8+kb2bbBdnQiqAgYnuu1Qs6bRBU3
 Y2Y2b0jpWRi+S4EdMjAQOw5B7Dn2+1aIl3MkbFMvme9L2us9QFYb/9g4kk5ntr2Cy9I2
 sgFv7AsWAITWbdFNLENkRRLdyjUkIpP16s0j8FqQPR4FVp9E/DbDKB1KV1OBmjGuSn17
 F3MrHqC5qeTBt2u7VkfBHePwT6djmCrcfWsfVmhCJJWErYagCMYiQ1fuU/Be2sANHAxr
 8ueFwmdvf7uaZ7Ni3qCpgoa8Q65qyCGOIpAz6/AG5I0QGl7Ykh+I1EA/uF/b2oM70HYw /Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rps5702sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 19:49:45 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367IIC8S008571;
	Fri, 7 Jul 2023 19:49:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6qtff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 19:49:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367Jnhk525887342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jul 2023 19:49:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9AEE58057;
	Fri,  7 Jul 2023 19:49:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7838558058;
	Fri,  7 Jul 2023 19:49:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jul 2023 19:49:42 +0000 (GMT)
Message-ID: <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Fri, 07 Jul 2023 15:49:42 -0400
In-Reply-To: <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
	 <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
	 <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 03WfiOs3JonS3QKomVcHVuyifMqn7Jp_
X-Proofpoint-GUID: 03WfiOs3JonS3QKomVcHVuyifMqn7Jp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=969 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070179
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_124959_394311_7352060F 
X-CRM114-Status: GOOD (  23.72  )
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

On Fri, 2023-07-07 at 11:01 -0400, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> 
> > +/*
> > + * Called during kexec execute so that IMA can update the measurement list.
> > + */
> > +static int ima_update_kexec_buffer(struct notifier_block *self,
> > +				   unsigned long action, void *data)
> > +{
> > +	void *new_buffer = NULL;
> > +	size_t new_buffer_size, cur_buffer_size;
> > +	bool resume = false;
> > +
> > +	if (!kexec_in_progress) {
> > +		pr_info("%s: No kexec in progress.\n", __func__);
> > +		return NOTIFY_OK;
> > +	}
> > +
> > +	if (!ima_kexec_buffer) {
> > +		pr_err("%s: Kexec buffer not set.\n", __func__);
> > +		return NOTIFY_OK;
> > +	}
> > +
> > +	ima_measurements_suspend();
> > +
> > +	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
> > +	new_buffer_size = ima_get_binary_runtime_size();
> > +	if (new_buffer_size > cur_buffer_size) {
> > +		pr_err("%s: Measurement list grew too large.\n", __func__);
> > +		resume = true;
> > +		goto out;
> > +	}
> 
> This changes the current behavior of carrying as many measurements
> across kexec as possible.  True the measurement list won't verify
> against the TPM PCRs, but not copying the measurements leaves the
> impression there weren't any previous measurements.
> 
> This also explains the reason for allocating an IMA buffer (patch 1/10)
> and not writing the measurements directly into the kexec buffer.

If not carrying even a partial measurement list across kexec is
desired, then in addition to the "boot_aggregate" record, define a new
record containing the TPM pcrcounter.  With this information,
attestation servers will at least be able to detect if the measurement
list was truncated.

thanks,

Mimi

> 
> > +	ima_populate_buf_at_kexec_execute(&new_buffer_size, &new_buffer);
> > +
> > +	if (!new_buffer) {
> > +		pr_err("%s: Dump measurements failed.\n", __func__);
> > +		resume = true;
> > +		goto out;
> > +	}
> > +	memcpy(ima_kexec_buffer, new_buffer, new_buffer_size);
> > +out:
> > +	kimage_unmap_segment(ima_kexec_buffer);
> > +	ima_kexec_buffer = NULL;
> > +
> > +	if (resume)
> > +		ima_measurements_resume();
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> >  #endif /* IMA_KEXEC */
> >  
> >  /*
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
