Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2947D39420
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0gFINy0J7hWuSvPyF4Me4RwxZxrtep5gKamQFyCNyNA=; b=K7J+vZsty8mNIyqBo9X24XWVH9
	xqb0Ms0WVVlxYY+Kz7ITgBPCqZNXPyGxUoKwBSWy6ZU06QYGpHRHJL1RhRD3tlnqe4dSWrrprDbzw
	QRKgaG4b+BVWpFNlc7Hlj8laf48dRLQZ0SRMNP31SyX+/7aI/WOU4lB7zjt2SSyqSQDXNseN7FsGO
	9izNm+TZjhO3HrYd8JLVtev5LMHdTmoNdq3HNZ5hRAfBxr+z0Mq7eey3GlpvzAy572eyE7C+ptfoP
	dcIgyI3t4pYSxO5/l+cCLMMK4VtLMC2lVKMwNjZwt4R8zzTs1ufm7KPwe8ONbbeR1BPAD5/ORSzgn
	92mKpjIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HGO-0000000056m-3iSg;
	Thu, 02 Apr 2026 12:35:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Fl0-0000000HTh4-0hPi;
	Thu, 02 Apr 2026 10:58:39 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632AtPbk3747399;
	Thu, 2 Apr 2026 10:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0gFINy
	0J7hWuSvPyF4Me4RwxZxrtep5gKamQFyCNyNA=; b=ojGOrxnCUvdzydYHvSVTnA
	aCREMJ1+dHb6lGYgjcl+9JLNDbp6kXiIk3LVupebs8lBF9FbGRzard4JbrcKnIEa
	X8QYs6M6pLmM8eru24rmv3oIwoMOpfSwd4tTEYkis9zKhhWAx/PePPRgmx2HA3aQ
	0OkV3SKLULF74dQ0KXQ9phYk9MZX19fLFD6phVwN/dWFKH2RFT8y0ogAydf2Xqsj
	ilWshU4BzEGaBjitQBz5UIOWHA7brAkhA0QBpx9cw7AXF63RHml6nNzqfuckqgKD
	I36vdi8CYXhm0j5wlLdjPb47elLDBuh2SB6F8M8Bbw8ZeZKQAeY0cWMWfGgcdoyQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msbg4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:58:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6325kFcn022227;
	Thu, 2 Apr 2026 10:58:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan9prq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:58:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632Aw6Iw45023654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:58:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3140520043;
	Thu,  2 Apr 2026 10:58:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8D1220040;
	Thu,  2 Apr 2026 10:57:52 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 10:57:52 +0000 (GMT)
Message-ID: <cd9fc3a0-701a-45f9-a218-86a846b091fc@linux.ibm.com>
Date: Thu, 2 Apr 2026 16:27:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/15] powerpc/crash: Fix possible memory leak in
 update_crash_elfcorehdr()
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
        peterz@infradead.org, pawan.kumar.gupta@linux.intel.com,
        feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
        kees@kernel.org, elver@google.com, paulmck@kernel.org,
        lirongqing@baidu.com, rppt@kernel.org, leitao@debian.org,
        ardb@kernel.org, jbohac@suse.cz, cfsworks@gmail.com,
        tangyouling@kylinos.cn, ritesh.list@gmail.com, hbathini@linux.ibm.com,
        eajames@linux.ibm.com, guoren@kernel.org, songshuaishuai@tinylab.org,
        kevin.brodsky@arm.com, vishal.moola@gmail.com,
        junhui.liu@pigmoral.tech, coxu@redhat.com, fuqiang.wang@easystack.cn,
        liaoyuanhong@vivo.com, takahiro.akashi@linaro.org, james.morse@arm.com,
        lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        kexec@lists.infradead.org
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
 <20260402072701.628293-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260402072701.628293-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ce4bc4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=VlouDxB3MAwdfIDnmSwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX7sTiPpQy79zU
 K27F0Aadqv20eVmWi70LMSBPyFOePevJ8HXyavRnK2TMzHBaqSwuLuxWghuZlrQko5p05QNG2B+
 9Bgt6FzwoOQe968GS2CqUCWPF85d/PVlPRIHZxewHdS/5BZRUaIOvRMExp1EA0wnq/FfmfkRbml
 xUoUXHVAC39mqNXXBSfHbajz0Jy/x3ZUV/ETZpslbrsNw6IuxYsEP9fksyG6DmoBcTvr0vzUs7p
 +NMUSXiYvqxVsqVr2xYwpkjuI4M8zrAJ9QmTnvurotV7fIoCBsSulbmEh6HFEQfxV+LhGIu+pD3
 ZkhK78O/fbw0C/N0oaillpJX3t5VHm7NQrh0Rt1lDmpLs33W+LZxzNIlnrJzPTtWD6qTBPjbzCv
 THCMfLanh5h1/u6vlboXEIhI/aKd0Ic+FIzYIGcrqQgvJfN9B4u08rwVs/g8A7mVn8Dgt16cloJ
 0Db6BgmrWybcSycnenw==
X-Proofpoint-GUID: y-dDzylxSChSlhSY3DLcHWQcfmdGadgb
X-Proofpoint-ORIG-GUID: qB0ckh-l6XGO78PdLdPfSeeapsEZWdAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_035838_332693_60FE6B43 
X-CRM114-Status: GOOD (  18.38  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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



On 02/04/26 12:56, Jinjie Ruan wrote:
> In get_crash_memory_ranges(), if crash_exclude_mem_range() failed
> after realloc_mem_ranges() has successfully allocated the cmem
> memory, it just returns an error but leaves cmem pointing to
> the allocated memory, nor is it freed in the caller
> update_crash_elfcorehdr(), which cause a memory leak, goto out
> to free the cmem.
>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 849599b702ef ("powerpc/crash: add crash memory hotplug support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/powerpc/kexec/crash.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index a325c1c02f96..1d12cef8e1e0 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -440,7 +440,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
>   	ret = get_crash_memory_ranges(&cmem);
>   	if (ret) {
>   		pr_err("Failed to get crash mem range\n");
> -		return;
> +		goto out;
>   	}
>   
>   	/*
Thanks for fixing this Jinjie.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

