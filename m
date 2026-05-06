Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F669CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdPMJxlbte8RRzpulxeEXf2hwSNrdDamBDw0NGX+/iQ=; b=M0+8Cq5J8EhPuN8ob02YCFQOjw
	tMJssOpY86ieIaHRzDQKOs/fVI7MNTdWeTryFfkr41+cpCPjPKjpRXw+7MA8trMKuSmgUG8eiWy3L
	1uuEio99nCO1RX4g9YNeabRabpTrTqnQGkKj+TzRT2bLsDKAEOEG/FhPLgiIXR6xx7ZRYK6jSDzXQ
	gmD1OBc0pZs90GUDk4W+jeSYcopnBkqqoE8NOWjpHH/gi1EOS3GoVBTlTgXgyQ+VGKlaumD5pawuh
	smzVu7wE7F07mwHDf80mcXzuyOAPXg12ztfj/t5yBYTZkrZCwnkCHVPCdYNDzw9Jge6GOiF/M+cJ9
	HukfCu+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKck4-00000000ybT-0S5Y;
	Wed, 06 May 2026 13:56:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKck2-00000000yaX-3YFm
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 13:56:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6464IMH71011760;
	Wed, 6 May 2026 13:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TdPMJx
	lbte8RRzpulxeEXf2hwSNrdDamBDw0NGX+/iQ=; b=W41InzKuEnKLwzjM2f4Xmn
	aq8P7VElqt+n6hbKOkc8jnp17n5RCHCLRfnv9j7vW7YX3T35uinELyvtQrZZGSkl
	TMTpwlVxHQMp3gIJS+mcEbQSMgCO3hh3OCTBr1j2J0HMYDWGD4X5mGjVRnO19KHi
	UUuoKXx0a1hC7vgdvDSm41hipzyuSrZMXSNkdlDKDJwuAe5vNrF2JL0mKRvv1j9z
	Tfw6bMl0+xhVs3CgpgNzk+vuJ5NE66881vUmGk+rSugpP0wKbU5z8UCyieBBSkFS
	bkm5QP/zu+HOlVf/JFGn0ZoBFIQb+pt1u5H8TkRJxA6MQ3x7kGgGZiV2lQfycpCw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4rb4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:56:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DsSJg023835;
	Wed, 6 May 2026 13:56:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqen20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:56:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646DuMSU41615622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 13:56:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B3842004F;
	Wed,  6 May 2026 13:56:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C931820043;
	Wed,  6 May 2026 13:56:18 +0000 (GMT)
Received: from [9.124.208.31] (unknown [9.124.208.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 13:56:18 +0000 (GMT)
Message-ID: <b6a29516-ff17-4a36-b90c-812160fa8d19@linux.ibm.com>
Date: Wed, 6 May 2026 19:26:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-4-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260501234342.2518281-4-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNCBTYWx0ZWRfX+OIqKkBCeiFx
 bcZ+n+v/FfXDCXC8oJi80fhWrzVjspMHE+SG5ZNvSsGCwpeNcl+Io+QnRYFUHfy5lZhomNoNcFV
 1+j3R8z/j5MC2pK12Is87+CU3XGuJsRZKfErvj7OdToIZtCIAykr64nwIMlfj4dTKRs9iNdi5WX
 FVG5rk3cKmQ9KwmP4jHAfDylL46VRkHSn/ceOgTyUa4NatxHDIAj43+ERIGqeP0SluhQt/5CxXU
 wF/JYzVAneDH/cWH2+uv6PUG9kD3AVyLQpOrP5DFpDQn2oBfD5B2KH3VLasQGPAZqy+5p1P6Gc7
 QxTt4TwJhnBZTKLk4sLavcwUgDz3AW5DdUMWJj4rZhGb+DsY0NUAdQmtWXbl1F6so/w0PT3zz9p
 Dd6csN7VQc6ePGUarc3J8NPn3xKsvgboL42gsgKhNFl8DpAc76CaysijI4e+133cBNTUb2Ev5yw
 PvgYZQNHqMqEDh1KarQ==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb4889 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=yykyRpDHwrTCM8KGDVYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sq2gUFsxyOg-spKC2V7oQqoOsWaaahR3
X-Proofpoint-ORIG-GUID: ZzVuH9N9anvlaACgUbC4Kjzf_M6QvfKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_065647_001155_B949AD8F 
X-CRM114-Status: GOOD (  23.28  )
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



On 02/05/26 05:13, Coiby Xu wrote:
> If writing to the configfs group happens concurrently during
> kexec_file_load syscall, it may lead to the following issues,
>    - buffer overflow if dm-crypt keys are added after allocation
>    - stale total_keys if dm-crypt keys are removed during iteration
>    - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>      set true
>
> So hold config_keys_subsys.su_mutex for the entire sequence during the
> kexec_file_load syscall to ensure a consistent snapshot.


Yes, this will solve many synchronization problems when a  user tries to
perform any operation under our configfs_subsystem while the kernel is
executing the kexec_file_load system call.

Now, regarding the third point about freeing key_header: this will work
only if configfs takes the su_mutex lock before invoking the store callback.
I am not sure whether it actually does.

However, based on my previous comment on (2/9), if we keep 
config_keys_reuse_store()
under the kexec lock, this will be taken care of. This is because the entire
kexec_file_load system call already runs under the kexec lock.


>
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 4d8a3331bbe7..6377ee86ec50 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -429,6 +429,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	};
>   	int r = 0;
>   
> +	mutex_lock(&config_keys_subsys.su_mutex);
>   
>   	if (key_count <= 0) {
>   		kexec_dprintk("No dm-crypt keys\n");
> @@ -479,6 +480,9 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>   		kfree_sensitive(keys_header);
>   		keys_header = NULL;
>   	}
> +
> +	if (mutex_is_locked(&config_keys_subsys.su_mutex))
> +		mutex_unlock(&config_keys_subsys.su_mutex);
How about release the lock in crash_load_dm_crypt_keys() itself? Given 
that config_keys_reuse_store() is placed under kexec lock?


- Sourabh Jain

>   }
>   
>   static int __init configfs_dmcrypt_keys_init(void)


