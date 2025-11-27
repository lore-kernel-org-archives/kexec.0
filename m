Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6732D11183
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pv7nsdjbKQv9iubFxYTqIAQMgWDrBEcHm35+3CjbOr4=; b=1lV5OBAICCnP3inYuq2R56j+3C
	DF+B4ho58vhwgGZwUA/mm+qSbRE/tLQFsFoyGUCcVYazz+Uv0Av3D3BmXCNhQMNAjlL0YotU8mydP
	KsxSGBAo3glolo6RwTfTarUqP6IIM8vNyIsUfdtITpk9UmUCs+b6p4fLwPsQ0SRreJnpencebPGbV
	aNI881Jwm5orGw2lzNPL6nQsIs+24vfC8TKTlrJBIs4+WMxR00SSBTOkV0tYIW0n5JmLD8ET0h/cM
	myew4EN6svp47qymm+WYWs3SjV3Qz8r4mhGlE50IZNWoWFCxXhV7+cRuC4ETEhFKCDcoQ8+DlfHBP
	89M0xYXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOah3-0000000GVrP-2pUd;
	Thu, 27 Nov 2025 12:01:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOah0-0000000GVph-17Xu
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 12:01:48 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28UlX024274;
	Thu, 27 Nov 2025 12:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pv7nsd
	jbKQv9iubFxYTqIAQMgWDrBEcHm35+3CjbOr4=; b=GH8zB5qeT2juyCkB2LSYhN
	WlNpm5LbXWYR5E2y/YL+AYAlyW0kbtv1JNDJ+WZ2n3vLxvFwJpJ6KpRmNSdj9lL5
	R3tuTA8GT4CnoJLP0ITTyqYtMyTI2hhEbznMXT6Nm9Rj9uhvbcJzF9gfUj+FtS1N
	yRroGWBhFyyxTtU6boGqw68nbUkataYDsiAe97TGThVmVZ8ETM3y1taPzcZpIPOr
	wAAoUIHPqTdzntdjbj4SY1kYclc+H9LZUxfTHri6snzP00zYf6rpS0XSvcKiNmQ7
	YVdS8EuuQEGrutVVuX+T6Fl+4qIKQLiezNb9L7gL+3MdZr+RNKeCOrfEfdALGWKQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj9kb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 12:01:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARBmgWE025083;
	Thu, 27 Nov 2025 12:01:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71qmnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 12:01:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ARC1Gi844040528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 12:01:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A651A20043;
	Thu, 27 Nov 2025 12:01:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53ABC20040;
	Thu, 27 Nov 2025 12:01:15 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Nov 2025 12:01:15 +0000 (GMT)
Message-ID: <7aadda55-d2a4-40f9-95ef-d284ec358646@linux.ibm.com>
Date: Thu, 27 Nov 2025 17:31:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required for
 kexec_load
To: Qiang Ma <maqianga@uniontech.com>, akpm@linux-foundation.org,
        bhe@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        shivang upadhyay <shivangu@linux.ibm.com>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251126084427.3222212-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX4zezFtDkm9EK
 3HS30GPJsAwrKeDb6OBWfHCAb24WBhM7quZlsO0/tkFLJXGteif3RIaJ4/7qvtpf2Ti+NEoGCDa
 i1MhaqaH0wModSU4ddI8rSGddxh5xGEEaKEfGzQ9J5V8L/8gg/9ScG1g/ig0/ydsXduAI11ykWh
 LaEwWiWRBpTFD9mb3u87qmXhKclkmDbYz8K3hgk7CZJ/CapN0a3cATGW/q7fphbZulYr0QaNyr7
 PE1R1qf2IPOk5oungLqjcyu90xuIJeam9/sVNyQF7IIpJAl0HHUTQgjRWq5BjmmaTfg+iohZdOg
 vZnVepefU4UqxGa+nROwCv9QqJbY84gnqQ1cg/x/8dpX/Il+WOdCUgRTvZ7Vu5PSZ5SLcxSW6fz
 tmv+JvMsmZ17sopnUtnt+7YbAzUjGA==
X-Proofpoint-ORIG-GUID: Ds1cXwc-Llk974YCi92alUFaV9uPO34Y
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69283d8f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NzmbAIDTTIUxRSf50IgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ds1cXwc-Llk974YCi92alUFaV9uPO34Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_040147_428617_EC134574 
X-CRM114-Status: GOOD (  19.02  )
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

Do we have plan to support KEXEC_DEBUG flag?

Because upstream kexec-tools already added support for KEXEC_DEBUG flag
and that breaks the kexec_load with -d option.

- kexec: add kexec flag to support debug printing
   https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=71d6fd99af7e


Thanks,
Sourabh Jain


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


