Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD849EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MKFXQSef+tthO2KiY0uAWTQZYP+YQl7vHqAs8CD7c1k=; b=aMKV+Ha6p5bFgy
	iOY7vmjFfUF+BdwbOKG8NxFZVm8fnnxoZx0POn3mPx1jmV7JTGxxxRK2eB6I3cWLmdiuRrdBJ/bwn
	k9BFTRqPHklq8EYMIh+hEjYlF1r/odUhWYQTJVSNGWWBA23rhaxhk1U2cYUjt3HrSX30teHiJ84jk
	UOWZJNxjQQhJBNwUZBbDs0suInEO47ZfD4Ayc4/MjJFjCrufffVebUFpdi12sOJGZINQjmjPh5kq8
	osYgJJxqR0ApIQRpE8Xz0s1m9pFigcJT37Dhy2Tkdp2GQ1yltB2ReW/MECi8vE010o9ZaQt+t0RP+
	9hImRWmJ4DmaNiRsG5og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHkZl-004cqq-0P;
	Fri, 07 Jul 2023 12:28:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHkZi-004cpk-2E
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 12:28:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367CM5v8008790;
	Fri, 7 Jul 2023 12:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qZMm9yTjcJWUSWLm7JzzcwParFkZ3ZwO6pyqzRsLeJg=;
 b=JBdeuJEBQCmOqPx3HXA4bu7l5TLSFSEdKTitHuAwdqg6yAAbY38WgIxLsVC8Zkm1Ahl0
 jwnUGJFf48ERK1SL8ckJ4Z0kqI88thNocEnokjHwBRvYaTn3v88GTbKGTqHI2bxl5pne
 pawv72qVeqnVvNXl6Y9PBrU18E6Om5/ISZjPjw/V+9oR48+CRTzkqgWRTSjLa6FBOYiP
 IjP84AWQ4KAdjI63sXX9HE79DxQGf+0un4Sg2r/W0C27/otQFrAJlxjJkJqZ93elfGOz
 4G65sb5NgKDaNynvuyVQnD6+TXDXAi4g6E38OokNpkm/Qj5JX+2JqswJBzxXuRQTN6IB Fw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpjna040a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 12:28:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367Aeqm8001784;
	Fri, 7 Jul 2023 12:28:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
	by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3rjbs5a0pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 12:28:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367CSJYO25231950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jul 2023 12:28:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49E545805E;
	Fri,  7 Jul 2023 12:28:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66E6358056;
	Fri,  7 Jul 2023 12:28:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jul 2023 12:28:18 +0000 (GMT)
Message-ID: <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
Date: Fri, 7 Jul 2023 08:28:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/10] kexec: implement functions to map and unmap segment
 to kimage
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -_0LmGCmx17hBFyDp6E3G3bthskmOg0Y
X-Proofpoint-ORIG-GUID: -_0LmGCmx17hBFyDp6E3G3bthskmOg0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=868
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_052838_937924_8F37A541 
X-CRM114-Status: GOOD (  24.19  )
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



On 7/3/23 17:57, Tushar Sugandhi wrote:
> Currently, there's no mechanism to map and unmap segments to the kimage
> structure.  This functionality is needed when dealing with memory segments
> in the context of a kexec operation.
> 
> The patch adds two new functions: kimage_map_segment() and
> kimage_unmap_segment().
> 
> Implement kimage_map_segment() which takes a kimage pointer, an address,
> and a size.  Ensures that the entire segment is being mapped by comparing
> the given address and size to each segment in the kimage's segment array.
> Collect the source pages that correspond to the given address range,
> allocate an array of pointers to these pages, and map them to a contiguous
> range of virtual addresses.  If the mapping operation is successful, the
> function returns the start of this range.  Otherwise, it frees the page
> pointer array and returns NULL.
> 
> Implement kimage_unmap_segment() that takes a pointer to a segment buffer
> and unmaps it using vunmap().
> 
> Finally, move for_each_kimage_entry() macro to kexec.h.
> 
> Note: Use kimage_map_segment() and kimage_unmap_segment() carefully to
> avoid memory leaks and ensure that all mapped segments are properly
> unmapped when they're no longer needed.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

> +
> +	i = 0;
> +	for_each_kimage_entry(image, ptr, entry) {
> +		if (entry & IND_DESTINATION)
> +			dest_page_addr = entry & PAGE_MASK;
> +		else if (entry & IND_SOURCE) {
> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
> +				src_page_addr = entry & PAGE_MASK;
> +				src_pages[i++] = phys_to_page(src_page_addr);

Since phys_to_page is not defined on many/most architectures I change it for ppc64 and have successfully used the following:

+                               src_pages[i++] = virt_to_page(__va(src_page_addr))


After several kexecs the following check still works:

# evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements
Matched per TPM bank calculated digest(s).


    Stefan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
