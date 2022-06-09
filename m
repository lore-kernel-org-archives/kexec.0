Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353DDC43334
	for <kexec@archiver.kernel.org>; Thu,  9 Jun 2022 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SMhuCE2L2H175v+8gO4tDmDPXP133Khv+epAk547Dvk=; b=W/uEueFucp9VxB
	bC/SK0RGeHxLhM3cDexnyRtFyHHqi/BPUSE4GokatbyslY5BiK8uIub0wrdIuyNWzFV9bWcLvizTR
	Qxfh9LwVYfBO8uE5J/0fepEkDxPiAtx2f9cwd+YljnW7KdNvrDMIEnprpGYpTmqUKUi/ZH6XCPVRh
	hwlmAnjOREkRWpTMc0lRdmbc2A7wysgXp+w2hjMcYUUyRtfCdlF/L4xC3Rd/+pYWKRrxl2D5zoxS+
	4AQmwRWEIG2zN46VJaUfPl6tv6VYWfGf+t/8N9ANR1WDMDWWewrLLjvJf3j1CS7vXpTo4cMeZNUd/
	l0RUGwOSUnYc/t8yHlYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzQAK-004JJb-R6; Thu, 09 Jun 2022 21:58:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzQA9-004JHg-Sz; Thu, 09 Jun 2022 21:57:59 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259LeP1f001277;
	Thu, 9 Jun 2022 21:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/4BBPAchM/ULle0Yy7F5eLNhfs7+FxPP29f9TFF6zSk=;
 b=cQOJ/HYrto4UP/nF+Ekz3ZIO4C5XXUumppXukg4aPfBEFba4yu1EMXNktT5I1ll4Ubl1
 xLYKnChP5Cbs66SY6K9SYvh58GrqUWthlCauKNJUDpGbcoZaMRXL5UdTdPUkWDI0f4tY
 ZrrPBHwOjAC/fS+1vC2fpf/4ow/MDsME8fL6pQWEjdaO4IgzcViFOuAWfVTbzW1bz/Ay
 OowS7AfgNut8vXKaCIzI7D9osv++Cf2DHUdqsS2ll/Sljt68HFR6mGuq9Tj4Y5RG5Aeu
 atACxURUD9UWXbirKCclYd9ybycWvhO+ekGcGvFESt6evVHEn6XdhjQ076ftuYidc7fF FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkrysg7we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 21:57:48 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 259LpHU6011517;
	Thu, 9 Jun 2022 21:57:48 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkrysg7vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 21:57:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259LoYqO015642;
	Thu, 9 Jun 2022 21:57:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 3gfy19fek5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 21:57:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 259LvNHZ16187656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jun 2022 21:57:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 870DB11C054;
	Thu,  9 Jun 2022 21:57:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5821C11C04A;
	Thu,  9 Jun 2022 21:57:42 +0000 (GMT)
Received: from sig-9-65-64-6.ibm.com (unknown [9.65.64.6])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jun 2022 21:57:42 +0000 (GMT)
Message-ID: <97fe71b97d0fe70511e9747823d98a8409dc43d7.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] kexec: clean up arch_kexec_kernel_verify_sig
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Suchanek
 <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman"
 <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 09 Jun 2022 17:57:41 -0400
In-Reply-To: <20220512070123.29486-2-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <20220512070123.29486-2-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7BlaBGA9OOIOErFZqxHIP-5vXPRyI_oe
X-Proofpoint-ORIG-GUID: 4qbOklQPAMwShicpIiAG1mOYuTtXHJ8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_145758_213955_B05E36A8 
X-CRM114-Status: GOOD (  13.07  )
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

On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
>  kimage_validate_signature(struct kimage *image)
>  {
>         int ret;
>  
> -       ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
> -                                          image->kernel_buf_len);
> +       ret = kexec_image_verify_sig(image, image->kernel_buf,
> +                       image->kernel_buf_len);

Please indent the above line to line up with the open parenthesis.

thanks,

Mimi

>         if (ret) {
>  
>                 if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
