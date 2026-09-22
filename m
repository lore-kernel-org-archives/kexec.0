Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD386C982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r9mQcKnRoBYgpFB9rmm9mjOTYait0+LcCI/gOCTAZNY=; b=O19jAGiObG3223iZ6KIAuuwo11
	aAbISWo9aeL3YIRbRH23mSecmkR1Mk2YYX0UJ8ShMXja6CxQvjZc17mm3EnWepIhLC2DC8VdSm4uL
	5XIRYGVOtqGLZdrLH0tw9bm781UWxd9els8e4V0NihLthWlz++gECDqJoN7VjRDx4u5/hCoHb3BjP
	it+uFuoWVoiAVywBVzQtI+FsMiNlKa7dxX3RLnlZswA0ytUKhqbD2XK6jScSquFGeasyPUlPIGlr5
	3gdTaweV7ywB0WswOYWMYaJukOJHbyjRAAH2tGXPkOX4ZrQVD+4gWuyr0oaYpsCXG/rnyEbmwb60h
	OkvusCCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90Pe-00000005Uor-1xyo;
	Tue, 22 Sep 2026 13:19:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90Pc-00000005Uo9-1jCW
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 13:19:57 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBZxCr344073;
	Tue, 22 Sep 2026 13:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r9mQcK
	nRoBYgpFB9rmm9mjOTYait0+LcCI/gOCTAZNY=; b=gFjlTr+Vz2LleKZ0H9sZh7
	6BB+XUB+YgWzq5RiqM5QGZdgTrx+tiogfRTUeL669471uRw0NZfF+5na+Z+SROmG
	P0m8TrVJnzvZeseJJmXjmlIzFj95qinh9LOIea7VoyrRymTyo9hQ38XN3lV9V2W/
	TKMdfCbGfJuTbLf6jjasJXEny4XFVgvRd/TdgHfaCvKONMUAEXLhgbljicOkP2lm
	ltDXBbCe0HUo0JaFMLszZ6rTwKFGCz22jNkc1fmdeKCslYz/YFro4qJeuTofmF7z
	CUhBOiEOP5dLSpIsg5KErfmUZeN6yNPyzl2FTtiwlOzBeyzyNWUEQ0EUUXq7fyTQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv5m9u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 13:19:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBWTSF2751909;
	Tue, 22 Sep 2026 13:19:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjsxm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 13:19:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MDJaOe39780862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 13:19:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE1A62004B;
	Tue, 22 Sep 2026 13:19:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C99920040;
	Tue, 22 Sep 2026 13:19:34 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 13:19:34 +0000 (GMT)
Message-ID: <5c8ed4b7-e740-424e-beed-e34cf5c10932@linux.ibm.com>
Date: Tue, 22 Sep 2026 18:49:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes
 before allocation
To: George Guo <dongtai.guo@linux.dev>, pratyush@kernel.org
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, graf@amazon.com,
        changyuanl@google.com, akpm@linux-foundation.org,
        chenhuacai@kernel.org, liukexin@kylinos.cn, guodongtai@kylinos.cn,
        kexec@lists.infradead.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <2vxz1par7amw.fsf@kernel.org>
 <20260918093317.12216-1-dongtai.guo@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260918093317.12216-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 87AK1B9mEztPQkSf0G_DppO4qm63DQGB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfX/AtLnrIwey3b
 JkX70rIQAk1Y7fj+OdLjZmKQB9KU6hjYVtWaoJvuUL+Wy03ZGI+VWVNGKORM11QDm543Ahi6fV0
 IjIm2IclEX+TeKA87ZBvDgIPeyh9whI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2806c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xLVVGacSiyHbIRLvvMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VcKO_7tJv7M8Dxm83gVGSP1EYRW-VZ20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfX2E9QoJ3BhLS6
 kbIg5XO7q6jYhPZcOkB9U7GP4SrS+4Mc7dmYgAtCddKhr5gjpY3xdR5Tc/jtnt7NjlaC2/Xw8zX
 MfX5843cfq6NbkPrC/Y/B47NuiCITjZ9rMy+ZDCxxo8oNv0goKtzJHUUBZ1GXLlHgvFu4+5jBQV
 MwdcDcJYnl+9G6krVgo52LSlPTkYiXCzFfYTym8Fy3tBTNFKL7XPsJkzsfGkqjYzzJBZ51LL1Ct
 6CpuczdZPG4Yf5OtuYVLG5E/piavBvHpEAuka2vlc+xrpAb0DclS2JJOxxTs/5PB605dquyg6kQ
 qJD9rcvWXaq6q2XqWsaNQi2svws5ZacCnIP9Z64YMY/sTgGHBlu9Mi1LKzw/6Q7AbTwalEzuGBF
 6+SeBNjQTUTxnWZ4/OG2z03Shr9XFIVd82011/jLKHZiKmJ0AZAp3Es7rAtPKGCMalxxtFfgk+Q
 c3Af03MqFN9V1xq+X4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220190
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_061956_576721_1C4A6330 
X-CRM114-Status: GOOD (  26.61  )
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



On 18/09/26 15:03, George Guo wrote:
> Hi Sourabh, Pratyush,
>
>> But in practice, this problem is only on CONFIG_NUMA=n and I don't think
>> in practice KHO or LUO is being used in non-NUMA systems. So while I
>> think it is worth fixing, I think we should also have a test where we
>> enable CONFIG_NUMA.
> Confirmed. My vmtest kernel has CONFIG_NUMA unset, and your analysis
> matches the data.
>
> I reran the vmtest with Sourabh's debug prints on both configurations:
> same kernel, same QEMU command, and without my this fix patch, so the
> default percentage policy is exercised. The only difference is
> CONFIG_NUMA.
>
> Without CONFIG_NUMA:
>
>    KHO: Before low and global scratch allocations
>    KHO: low size = 330185 KB
>    KHO: global size = 322 MB
>    KHO: Per node 0 = 672 MB
>    KHO: After low and global scratch allocations
>    KHO: low size = 330185 KB
>    KHO: global size = 322 MB
>    KHO: Per node 0 = 672 MB
>    KHO: Failed to reserve nid 0 scratch buffer
>    KHO: Failed to reserve scratch area, disabling kexec handover
>
> With CONFIG_NUMA=y:
>
>    KHO: Before low and global scratch allocations
>    KHO: low size = 330197 KB
>    KHO: global size = 322 MB
>    KHO: Per node 0 = 96 MB
>    KHO: After low and global scratch allocations
>    KHO: low size = 330197 KB
>    KHO: global size = 322 MB
>    KHO: Per node 0 = 96 MB
>    KHO: After per node allocation
>    KHO: low size = 428501 KB
>    KHO: global size = 418 MB
>    KHO: Per node 0 = 288 MB

[...]

>
> In the run without CONFIG_NUMA, the reserved-kern sum the sizing sees
> is 330185 KB, which is the 98.45 MiB baseline plus the 224 MiB lowmem
> scratch area: with memblock_get_region_node() hardcoded to return 0,
> the NUMA_NO_NODE lowmem area is counted as node 0's kernel reservation.
> Node 0 therefore requests 200% of (98.45 MiB + 224 MiB), rounded up to
> 32 MiB alignment: 672 MiB. That no longer fits next to the other areas
> in the 1 GiB guest, and KHO disables itself.
>
> In the run with CONFIG_NUMA=y, the real node ID excludes the
> NUMA_NO_NODE regions, so node 0 requests 96 MiB. The allocation
> succeeds and is visible in the sums printed afterwards (330197 KB ->
> 428501 KB), and the KHO selftest passes end to end ("KHO: found kexec
> handover data", restore succeeds).
>
> Sourabh, this also answers your question. Your PowerPC system runs
> CONFIG_NUMA=y, so the node filter excludes the lowmem and global areas
> and your numbers stay flat. Your experiment and mine are the two halves
> of the same mechanism.
>
>> I think on NUMA systems the problem is the other way round. The
>> calculation for the global scratch also counts per-node allocations.
>> So I think the proper fix for scratch sizing is what this patch does
>> and then a fixup for the global scratch calculation as well.
> Agreed. For v2 I plan to:
>
>    - Compute all scratch sizes (lowmem, global, per-node) before any
>      scratch area is allocated, per Mike's comment. The sizes are a
>      function of the pre-allocation state, so this seals both feedback
>      directions at once.
>    - State the !CONFIG_NUMA condition in the commit message. The feedback
>      described there is not unconditional, which is what triggered the
>      question.
>    - Add the LLM attribution Mike asked for.
>    - Include the CONFIG_NUMA=y vmtest result as coverage.
>    - Look at the global scratch calculation on NUMA systems as a
>      follow-up.

I have sent a fix to handle global scratch calculation on NUMA systems.
https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com/

Please review the changes and share your comments.

- Sourabh Jain

