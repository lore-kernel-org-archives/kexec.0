Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F9D1F9D3
	for <kexec@archiver.kernel.org>; Thu,  4 Dec 2025 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+kCI+cSwBA6MYzwzTGn/+WusjYfWIJ4f6CQzyP67rI=; b=Hn+/Kx+MjiHcY0MbAkPv4QcX8M
	0/4q0+u1d5x3TV9JI5FPvWaY+Ern7TzORJHIUZQygKuPR08G98SEvZlWUfT1pikYqo/dXXHyVA7zX
	bVMYsmsNrspKp7U/4qmXFeuC2F5vGYBn4Uf2JuaoFBMUbXwd4+aotnBt98SfTCCadcXXZ2a5YMepF
	jOMMiNDOiNjV6FqTG++YczZMaeJRm1GQgkFEXyLzPI1tRFdPVbdGM3APTCMa9kFC/7oAuJ0cUydTu
	g8OD2AJYAjL0J7SLmREwdiA9ElmAVnPbWDzi+32AYQkXR82f8fcyJdPTXke6whYVnnb7ohVkqcziR
	aq63XpKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR8Hp-00000007yP2-13gb;
	Thu, 04 Dec 2025 12:18:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR8Hm-00000007yOc-3Uqa
	for kexec@lists.infradead.org;
	Thu, 04 Dec 2025 12:18:15 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4BM0pI016686;
	Thu, 4 Dec 2025 12:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F+kCI+
	cSwBA6MYzwzTGn/+WusjYfWIJ4f6CQzyP67rI=; b=g3S21gArcn4OBzd5/RUvKr
	YoL7pGJw4rY/UfsOFMCanvz6iIh0gbsU8C+GnHFol3PGtKxYhxQ8JKWzRcFW0lsH
	lLsUEYDvwyDJFRr8Rf9ojpRE8DKw9YE2OVNeFhJQUK+On+yGg7BLinWpgcSb0ivZ
	J+AHyUzkzDpsfNI++PjVYyN+iadrdm0E3vJsJzfWLR4S/ZQUrYtrAaBR2QmeBirh
	YmfbvH0HyU5hCj4nF86B15iOVUPCjuIZB1ipBaSMkPJ99ZWF6mzG6rJF8sMGls/T
	eB8CqgBkn4QAayAKhGn8XBfbV3zZnNFnNRkgIGosbD2uljm0vLjZivavZVM7e3EQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbggcva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 12:18:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4BUxda019035;
	Thu, 4 Dec 2025 12:18:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy7qex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 12:18:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4CI73k61473272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 12:18:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64AD820040;
	Thu,  4 Dec 2025 12:18:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDDDC2004B;
	Thu,  4 Dec 2025 12:18:05 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 12:18:05 +0000 (GMT)
Message-ID: <5be9a0d7-f014-41a7-97a2-75a3ba23f1d9@linux.ibm.com>
Date: Thu, 4 Dec 2025 17:48:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required for
 kexec_load
To: Qiang Ma <maqianga@uniontech.com>, akpm@linux-foundation.org,
        bhe@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@kernel.org>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251126084427.3222212-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _jFrXzjMXe-o0GbKWS5D07tWTHgcAvq8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXyrZvT9Ggy6WA
 +z1RjHGJW/84ifiEO1CFrCyUiTqucjP0GTsmrAcHAchEppNhAod0xkfNU1OQaorlbAkw6MXLMyc
 XujGBBSVRwsLT4WTufpsCV16Lyq7p4wvir1AgHMfH0GuqQcCwkzFJl3f7kakuOvq9z7x2Ac3lbu
 4UFuwbX1SFOh2nSIPKis3BvY7WhN+V93k8oRW7yBP4McfDP05CRK8o3omnhV3fcZ6+R4mxSZ57Q
 ccXXYd9h7DWqLpeO3DvrvilfMQano7WuB5XCK/+xSFyH6cwFM1HAQKax8BkYECMPwrQupX25fUs
 iDCp4rMJLWCKjNb0sG88QLJc0AoQRSKXfHdS0xautJQpFGxzEKNXaiGMnyRVWZhj8mXNSjh0Hes
 azjHZhC3RkUm/p02WV1lV1qUpkc75g==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=69317c02 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HhvaSgjEsw3fMc6jZ2oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _jFrXzjMXe-o0GbKWS5D07tWTHgcAvq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_041814_904167_748AE653 
X-CRM114-Status: GOOD (  32.40  )
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

Hello All,

I read this patch series, including the older versions, and this is what I
think about the changes.

There are two main reasons I see for why this patch series is proposed
(these were not mentioned in the cover letter or commit messages):

1. Commit eb7622d908a09 ("kexec_file, riscv: print out debugging message
    if required") and commit 6f8c1da071a4 ("kexec_file, arm64: print out
    debugging message if required") moved some kexec-related debug prints to
    kexec_dprintk instead of pr_debug or pr_notice.

    These commits made it easier to control the updated debug prints using
    the -d option of kexec tool for kexec_file_load system call. But since
    kexec_dprintk is not available for the kexec_load system call, those 
prints
    are no longer available for kexec_load at all. So patch series try 
to bring
    those logs for kexec_load system call.

2. Patch 03/03 prints additional logs about the kexec image type, start,
     head, and flags via kexec_dprintk for the kexec_load system call.

This is done by enabling the kexec_dprintk for kexec_load, so that logs
from point 1 and the new logs from point 2 can be printed for kexec_load
system call.

However, the patch series does not explain why these additional debug logs
are needed for kexec_load. Since most of the work involved in loading
kexec images through kexec_load happens in the kexec userspace tool, and
the tool already provides enough logs to debug issues, the need for these
extra kernel logs is not clear.

So adding the need for the additional debug logs in the cover letter or
commit message is needed to decide whether it is worth adding the code
change proposed in this patch series Also, I found it hard to map the 
commit message to the changes introduced in the commits. And finally If 
I review the patches only based on the code changes: 01/03 The commit 
message refers to kexec_dbg_print as kexec_core_dbg_print. 02/03 I think 
kexec_dbg_print should be set to false at the end of kimage_free, not at 
the start. 03/03 There is duplication of debug logs for architectures 
that already print the same information. For example, arm64. - Sourabh Jain
On 26/11/25 14:14, Qiang Ma wrote:
> Overview:
> =========
> The commit a85ee18c7900 ("kexec_file: print out debugging message
> if required") has added general code printing in kexec_file_load(),
> but not in kexec_load().
>      
> Since kexec_load and kexec_file_load are not triggered simultaneously,
> we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
>      
> Next, we need to do some things in this patchset:
>      
> 1. rename kexec_file_dbg_print to kexec_dbg_print
> 2. Add KEXEC_DEBUG
> 3. Initialize kexec_dbg_print for kexec
> 4. Fix uninitialized struct kimage *image pointer
> 5. Set the reset of kexec_dbg_print to kimage_free
>
> Testing:
> =========
> I did testing on x86_64, arm64 and loongarch. On x86_64, the printed messages
> look like below:
>
> unset CONFIG_KEXEC_FILE:
> [   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 head:0x10a4b9002 flags:0x3e0010
>
> set CONFIG_KEXEC_FILE
> [   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 0xd78400
> [   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
> [   36.821826] kexec-bzImage64: Loaded boot_param, command line and misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
> [   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 bufsz=0xd73400 memsz=0x2ab7000
> [   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 bufsz=0x16f40a8 memsz=0x16f40a8
> [   36.821920] kexec-bzImage64: Final command line is: root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
> [   36.821925] kexec-bzImage64: E820 memmap:
> [   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
> [   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
> [   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
> [   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
> [   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
> [   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
> [   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
> [   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
> [   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
> [   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
> [   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
> [   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
> [   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
> [   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
> [   36.872348] kexec_file: nr_segments = 4
> [   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
> [   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
> [   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
> [   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
> [   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 head:0x101a2e002 flags:0x8
>
> Changes in v3:
> ==========
> - Rename kexec_core_dbg_print to kexec_dbg_print
> - Remove unnecessary segments prints
> - Remove patch "kexec_file: Fix the issue of mismatch between loop variable types"
>
> Qiang Ma (3):
>    kexec: Fix uninitialized struct kimage *image pointer
>    kexec: add kexec flag to control debug printing
>    kexec: print out debugging message if required for kexec_load
>
>   include/linux/kexec.h      | 9 +++++----
>   include/uapi/linux/kexec.h | 1 +
>   kernel/kexec.c             | 8 +++++++-
>   kernel/kexec_core.c        | 4 +++-
>   kernel/kexec_file.c        | 4 +---
>   5 files changed, 17 insertions(+), 9 deletions(-)
>


