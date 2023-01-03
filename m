Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E02BC46467
	for <kexec@archiver.kernel.org>; Tue,  3 Jan 2023 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=efBTBjuaH/8pwAE/eHhu5nzCqxwg3nUnCpFq4dT3Yp4=; b=MgXcNvf7l2e6pm
	HKw/n04nbI6Z7/lEgkC0kJKjGjEeOdKjI4ycb0cr3roB6pSpF45qmAqR3mK37LFUUOmfJvJXx+LfU
	jUX0RyXoux3U0CHuTq+KjBIGgW9tfgv87LOePh+hCBZb0HEp8jpu2oEjNd/A1rlsQTv98DqGxuzfC
	SAONnKwirs+/C7x3BM9F33+ncXbRGeChv6apXc0IRXwD13YB6noUgLiN7nymznZuXv2vazBPaUD/+
	5yfKNY+ueouNctPmjfCx4o5PX5+DVTVguvzjnq8keGT5/UMTOj/sH6BONtP8f4hmgW4Osw3/YlkCA
	/vtXZbk5C+axXJxdVhIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCkQL-0033xr-N6; Tue, 03 Jan 2023 16:46:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pChef-001fHL-1d
	for kexec@lists.infradead.org; Tue, 03 Jan 2023 13:49:13 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303Dhlpb013391;
	Tue, 3 Jan 2023 13:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l+taFLKvfRB9Eu0w25rmHirDbleycD90YP7KB7wSW4k=;
 b=dZ+ZhS73PvxPQ1QDK722mHvdmqD4vZ6Q01PHzD0N3xnY6uYMSegjtWeWFo/RKw4AHaZ1
 1vXqFl15j2Razdoh29oyPP0CrRDOsUoKGqevCx8g8eLgdfkf/DgnJMCzi61T9yqGIL9P
 u1Cl/lbzreFcHjUnY1hZ66kZj7YO3kC/sg6HNHsihmtOQ8p27GW9UwFKhNPU1QSFJM9y
 RRqPnYINrZ9gulGRi+nrE+ntCJwD1hJ7rHh8RHuKrmxPFDycym2vQW3DWutcbLuhKUnH
 l3hz2++YbWjsEXclAeGAdP76yq4DrhYYNYa/Tdscfr/DXo50RyFztZzfOa2lJkpDWiz6 Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjk23xha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 13:48:24 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303DfH0W018652;
	Tue, 3 Jan 2023 13:48:24 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjk23xh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 13:48:24 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303CnkPE030421;
	Tue, 3 Jan 2023 13:48:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
	by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3mtcq7eda6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 13:48:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303DmMsP21627550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Jan 2023 13:48:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F300658053;
	Tue,  3 Jan 2023 13:48:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C6B58059;
	Tue,  3 Jan 2023 13:48:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.32.150])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Jan 2023 13:48:21 +0000 (GMT)
Message-ID: <f60b7949dd7c453821f99a25e243b715ac36c290.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] selftests/kexec: enable lockdown tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: linux-integrity@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        open
 list <linux-kernel@vger.kernel.org>
Date: Tue, 03 Jan 2023 08:48:20 -0500
In-Reply-To: <20221230065850.897967-2-coxu@redhat.com>
References: <20221230065850.897967-1-coxu@redhat.com>
	 <20221230065850.897967-2-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sScxwIsk9a27FAE8IhARqXbmpYNz77lF
X-Proofpoint-GUID: bPm6wsvwDbivd2FpucRw98-4kh5RaoXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1011 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301030118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_054837_560451_FCEC90F6 
X-CRM114-Status: GOOD (  25.88  )
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

Hi Coiby,

On Fri, 2022-12-30 at 14:58 +0800, Coiby Xu wrote:
> When lockdown is enabled, kexec_load syscall should always fail.
> 
> For kexec_file_load, when lockdown is enabled, it should
>  - fail of missing PE signature when KEXEC_SIG is enabled
>  - fail of missing IMA signature when KEXEC_SIG is disabled

Appended kernel image signatures are supported, but differently on
powerpc and s390.  For s390, KEXEC_SIG is enabled.  For completeness
the above statements should reflect appended signatures.

> 
> Before this patch, test_kexec_load.sh fails (false positive) and
> test_kexec_file_load.sh fails without a reason when lockdown enabled and
> KEXEC_SIG disabled,
> 
>     # kexec_load failed [FAIL]
>     not ok 1 selftests: kexec: test_kexec_load.sh # exit=1
>     # kexec_file_load failed [PASS]
>     ok 2 selftests: kexec: test_kexec_file_load.sh
> 
> After this patch, test_kexec_load.sh succeeds and
> test_kexec_file_load.sh fails with the correct reason when lockdown
> enabled and KEXEC_SIG disabled,
> 
>     # kexec_load failed [PASS]
>     ok 1 selftests: kexec: test_kexec_load.sh
>     # kexec_file_load failed (missing IMA sig) [PASS]
>     ok 2 selftests: kexec: test_kexec_file_load.sh
> 
> Cc: kexec@lists.infradead.org
> Cc: linux-integrity@vger.kernel.org
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  .../selftests/kexec/kexec_common_lib.sh       | 16 +++++++++++
>  .../selftests/kexec/test_kexec_file_load.sh   | 27 +++++++++++++++++++
>  .../selftests/kexec/test_kexec_load.sh        | 12 ++++++---
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
> index 641ef05863b2..06c298b46788 100755
> --- a/tools/testing/selftests/kexec/kexec_common_lib.sh
> +++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
> @@ -110,6 +110,22 @@ get_secureboot_mode()
>  	return $secureboot_mode;
>  }
>  
> +is_lockdown_enabled()
> +{
> +	local ret=0
> +
> +	if [ -f /sys/kernel/security/lockdown ] \
> +	     && ! grep -qs "\[none\]" /sys/kernel/security/lockdown; then
> +		ret=1
> +	fi
> +
> +	if [ $ret -eq 0 ]; then
> +		log_info "lockdown not enabled"
> +	fi
> +
> +	return $ret
> +}
> +
>  require_root_privileges()
>  {
>  	if [ $(id -ru) -ne 0 ]; then
> diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
> index c9ccb3c93d72..790f96938083 100755
> --- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
> +++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
> @@ -139,6 +139,16 @@ kexec_file_load_test()
>  			log_fail "$succeed_msg (missing IMA sig)"
>  		fi
>  
> +		if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 1 ] \
> +		     && [ $pe_signed -eq 0 ]; then
> +			log_fail "$succeed_msg (missing PE sig)"
> +		fi

CONFIG_KEXEC_SIG being enabled does not require signature verification
to be enforced.  When the CONFIG_IMA_ARCH_POLICY is enabled, IMA
requires kexec signature verification.  Also on s390, CONFIG_KEXEC_SIG
verifies an appended signature, not a PE signature.  Instead of the
"missing PE sig" message, perhaps indicate lockdown requires kexec
signature verification. 

> +
> +		if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 0 ] && [ $ima_signed -eq 0 ] \
> +		     && [ $ima_modsig -eq 0 ]; then
> +			log_fail "$succeed_msg (missing IMA sig)"
> +		fi
> +

Similarly, only if IMA is enabled and requires the kexec signature
verficiation should this message be emitted.  Perhaps a single generic
lockdown message would be sufficient for both.

>  		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
>  		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
>  	            && [ $ima_read_policy -eq 0 ]; then
> @@ -181,6 +191,16 @@ kexec_file_load_test()
>  		log_pass "$failed_msg (possibly missing IMA sig)"
>  	fi
>  
> +	if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 1 ] \
> +	    && [ $pe_signed -eq 0 ]; then
> +		log_pass "$failed_msg (missing PE sig)"
> +	fi
> +
> +	if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 0 ] \
> +	    && [ $ima_signed -eq 0 ] && [ $ima_modsig -eq 0 ]; then
> +		log_pass "$failed_msg (missing IMA sig)"
> +	fi
> +

Similar comments as above.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
