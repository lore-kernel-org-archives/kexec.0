Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BBFC25B48
	for <kexec@archiver.kernel.org>; Thu, 26 Oct 2023 20:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JYVTsx/u5RVM1qJxzfVmNd+eMq9lDWS1hNEneM4o/BM=; b=m7V+kv/cpAfeBp
	URlwBTsnMAEIckg9CPdhXrcCgM7MsttZrKhmBWrVOE18eXey4+eqjMb3cksIQ4tEnk11U/4yTP0uF
	koWoQRbxQtbVAY1foTW1aGVIBgPbhNaEUK8zU17NCbQaHNrwKOVmZa+hIGHCTEwvFGVlfnLh8SToh
	VDZAdIVmH9rNt2bWzQzAWmXwNtAwQpM/3gyIKQRMlW8CGrg12FypPpwNEtHLBF5XKSyOFIr9xSW1i
	A0vvKz6NrXc+Xtnrvnva47YmG/12qC1MXu2t2s5ZvkUhrSji1jeUILKcYPD2GwNOqLrBOwcoqmdNM
	xAXgXlRUeQkwW/y83FKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw6pA-00F7A5-1r;
	Thu, 26 Oct 2023 20:19:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw6p3-00F75B-2T
	for kexec@lists.infradead.org;
	Thu, 26 Oct 2023 20:19:22 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QJoU3k017861;
	Thu, 26 Oct 2023 20:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2DG1HxntyqMQQCjGfSLDTWCmytflfPcq4+Rip69/fMI=;
 b=TFYQe/Os6uWuYID/b+1VD438xq0QqxzMLtsLh2npLCeniwCKZpKuLJUC3EdT/J2iFQvD
 wfVEg3bVpMzAPck2FGhcKhYTyCL6jQMGiVNy/AptFN7mnkUrooC13bH23H4GkH+Ug0j6
 nX1VqMx9UjRvYlslArgyYhmLu76fknnWpqfqYDvg+Kl3UqMOWRDoY/kQVZ7nFO8OHkre
 +4RxMQnAhx7z/kzFnIbUdIgkdfQNtS2A7Bu8zkQBsqAyBuQ+4C8dNk4FP2JWcuY5lDQh
 DecgBp+mZkEd/z5sdo3dFWTDKY0A9N3yM1QTcc1M9nkbpXedglpjHb0B8WLFeZjmBztl Mg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyxm48xr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Oct 2023 20:16:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39QInN4g021697;
	Thu, 26 Oct 2023 20:16:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqs8edn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Oct 2023 20:16:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39QKGqZ920710086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Oct 2023 20:16:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61F9258052;
	Thu, 26 Oct 2023 20:16:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96FA5805E;
	Thu, 26 Oct 2023 20:16:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Oct 2023 20:16:51 +0000 (GMT)
Message-ID: <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 26 Oct 2023 16:16:51 -0400
In-Reply-To: <20231005182602.634615-2-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
	 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -jMICOWNNEGbjvljbRMScLQxONmblViD
X-Proofpoint-GUID: -jMICOWNNEGbjvljbRMScLQxONmblViD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310260175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_131918_153689_01ACDB54 
X-CRM114-Status: GOOD (  44.17  )
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

Hi Tushar,

According to Documentation/process/submitting-patches.rst, the subject
line should be between 70-75 characters.

Perhaps something like "ima: define and call ima_alloc_kexec_buffer()".

On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
> IMA allocates memory and dumps the measurement during kexec soft reboot
> as a single function call ima_dump_measurement_list().  It gets called
> during kexec 'load' operation.  It results in the IMA measurements
> between the window of kexec 'load' and 'execute' getting dropped when the
> system boots into the new Kernel.  One of the kexec requirements is the
> segment size cannot change between the 'load' and the 'execute'.
> Therefore, to address this problem, ima_dump_measurement_list() needs
> to be refactored to allocate the memory at kexec 'load', and dump the
> measurements at kexec 'execute'.  The function that allocates the memory
> should handle the scenario where the kexec load is called multiple times

The above pragraph is unnecessary.

> Refactor ima_dump_measurement_list() to move the memory allocation part
> to a separate function ima_alloc_kexec_buf() to allocate buffer of size
> 'kexec_segment_size' at kexec 'load'.  Make the local variables in
> function ima_dump_measurement_list() global, so that they can be accessed
> from ima_alloc_kexec_buf().  Make necessary changes to the function
> ima_add_kexec_buffer() to call the above two functions.

Fix the wording based on the suggested changes below.

> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Before re-posting this patch set, verify there aren't any
"checkpatch.pl --strict" issues.
After applying each patch, compile the kernel and verify it still
works.

> ---
>  security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
>  1 file changed, 93 insertions(+), 33 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..307e07991865 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,61 +15,114 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +struct seq_file ima_kexec_file;

Define "ima_kexec_file" as static since it only used in this file.  
Since the variable does not need to be global, is there still a reason
for changing its name?   Minimize code change.

> +struct ima_kexec_hdr ima_khdr;
> +
> +void ima_clear_kexec_file(void)

The opposite of "set" is "clear" (e.g. set_git, clear_bit).  The
opposite of "alloc" would be "free" (e.g. ima_alloc_kexec_buf,
ima_free_kexec_buf)

> +{
> +	vfree(ima_kexec_file.buf);
> +	ima_kexec_file.buf = NULL;
> +	ima_kexec_file.size = 0;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = 0;
> +}
> +
> +static int ima_alloc_kexec_buf(size_t kexec_segment_size)
> +{
> +	if ((kexec_segment_size == 0) ||
> +	    (kexec_segment_size == ULONG_MAX) ||
> +	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
> +		pr_err("%s: Invalid segment size for kexec: %zu\n",
> +			__func__, kexec_segment_size);
> +		return -EINVAL;
> +	}

Please avoid code duplication.  If moving the test here, then remove it
from its original place.

> +
> +	/*
> +	 * If kexec load was called before, clear the existing buffer
> +	 * before allocating a new one
> +	 */

> +	if (ima_kexec_file.buf)
> +		ima_clear_kexec_file();

Perhaps instead of always freeing the buffer, check and see whether the
size has changed.  If it hasn't changed, then simply return.  If it has
changed, perhaps use realloc().  Possible wording:

"Kexec may be called multiple times.  Free and re-alloc the buffer if
the size changed."

> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(kexec_segment_size);
> +	if (!ima_kexec_file.buf) {
> +		pr_err("%s: No memory for ima kexec measurement buffer\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	ima_kexec_file.size = kexec_segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
> +
> +	memset(&ima_khdr, 0, sizeof(ima_khdr));
> +	ima_khdr.version = 1;
> +
> +	return 0;
> +}
> +
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
> -	struct ima_kexec_hdr khdr;
>  	int ret = 0;
>  
> -	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (!ima_kexec_file.buf) {
> +		pr_err("%s: Kexec file buf not allocated\n",
> +			__func__);
> +		return -EINVAL;
>  	}
>  
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> +	/*
> +	 * Ensure the kexec buffer is large enough to hold ima_khdr
> +	 */
> +	if (ima_kexec_file.size < sizeof(ima_khdr)) {
> +		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
> +			__func__);
> +		ima_clear_kexec_file();
> +		return -ENOMEM;
> +	}

Is this necessary?
 
> -	memset(&khdr, 0, sizeof(khdr));
> -	khdr.version = 1;
> +	/*
> +	 * If we reach here, then there is enough memory
> +	 * of size kexec_segment_size in ima_kexec_file.buf
> +	 * to copy at least partial IMA log.
> +	 * Make best effort to copy as many IMA measurements
> +	 * as possible.
> +	 */

Suggestion:

/* Copy as many IMA measurements list records as possible */

>  	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> -		if (file.count < file.size) {
> -			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
> +			ima_khdr.count++;
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
> -			ret = -EINVAL;
> +			ret = EFBIG;
> +			pr_err("%s: IMA log file is too big for Kexec buf\n",
> +				__func__);
>  			break;
>  		}
>  	}
>  
> -	if (ret < 0)
> -		goto out;
> -
>  	/*
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
>  	 */
> -	khdr.buffer_size = file.count;
> +	ima_khdr.buffer_size = ima_kexec_file.count;
>  	if (ima_canonical_fmt) {
> -		khdr.version = cpu_to_le16(khdr.version);
> -		khdr.count = cpu_to_le64(khdr.count);
> -		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
> +		ima_khdr.version = cpu_to_le16(ima_khdr.version);
> +		ima_khdr.count = cpu_to_le64(ima_khdr.count);
> +		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
>  	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
>  
>  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>  			     true);
>  
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> -out:
> -	if (ret == -EINVAL)
> -		vfree(file.buf);
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
> +
>  	return ret;
>  }

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
