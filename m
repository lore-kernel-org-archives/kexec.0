Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C40C433FE
	for <kexec@archiver.kernel.org>; Wed, 23 Nov 2022 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXupqBmflBBoyVCtE0ZNgp8/AKRYVykiRM/kGormfEc=; b=zrgcFzkZUrY/0HCsjd80UfWOuA
	LxECJP5eHZyRPo/fRiAfcMUH5gi1BCsroggE9lwPP05EoCGXn+gurWssbP5dnwja/46/9Xv3JA0d7
	NYk//auE0yagHv5U2LliPeTcCSB19pshLcPNdo01DkzPbR4adH2936TcwNxSCgBF1zXqxRHCgMcEA
	N4H3+g5P6hPJvzczlsHx6htzmEuhrJ/KObsIQtIpcicLP1tcsz3flNTbz0CzHXg5pRNGg6FPTUk0s
	NdWDAy/dSiuHa7mFPzr9N4EzABcnMe8v5fb6pYfQswpo5tqztdyiXhGk0xRaeHa0E1anQcGgtSq7Z
	QvXUy7wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxrlE-000TXP-Q5; Wed, 23 Nov 2022 15:34:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxrkn-000TUS-KQ
	for kexec@lists.infradead.org; Wed, 23 Nov 2022 15:33:39 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEarFl014362;
	Wed, 23 Nov 2022 15:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UcADcFV47xfsKjH963fVkenN94MZeq+RIy3Tyn231CM=;
 b=bm8OCy0FZHjM5ni6WNs58bt86d9cdO1t2qymlyPzRngY7HxZ6FCZL4YWkLe74gZuXqWo
 fHjuqNCiQoqDF7AsZ96jRY9he781PWwVWh/PKoM2AVjPjVgSbrpk9nhl07Enr+nMoE7Z
 6+EURMxXYT6rHQt0V3luR01YMuG3vQPYTSV4rhg/2HOqPn5SPj1OHoLgYmkdIFuYpNE0
 CS9ci21vxYjNi/H43nVqwSnqLDYi0v7ueZsFKXW/RAhqefuVUI9PfuIPhbNVNCIZKwDd
 GGOqMJHlcyvLY+OLOmRmvJJEbt1cECsZaE2SUoYRmqU4RRuZ69PEGGQgQq/kuwE5kNDx Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m1152ysyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Nov 2022 15:32:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANEbl9Z019653;
	Wed, 23 Nov 2022 15:32:11 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m1152yswm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Nov 2022 15:32:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANFKmek016489;
	Wed, 23 Nov 2022 15:32:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma03ams.nl.ibm.com with ESMTP id 3kxps8x59w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Nov 2022 15:32:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANFW64Q66650546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Nov 2022 15:32:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 399C842045;
	Wed, 23 Nov 2022 15:32:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C1B42049;
	Wed, 23 Nov 2022 15:32:01 +0000 (GMT)
Received: from [9.43.47.46] (unknown [9.43.47.46])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 23 Nov 2022 15:32:00 +0000 (GMT)
Message-ID: <3923f27e-2a35-3116-fffb-560fdb544de2@linux.ibm.com>
Date: Wed, 23 Nov 2022 21:01:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v14 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rn5vuJxmyRozbRqrxRu7m_C-1xsFaWgQ
X-Proofpoint-GUID: P1FRqF_m7efNGb07PxqT0jl5SFOmzrki
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_073337_775243_947A9098 
X-CRM114-Status: GOOD (  30.90  )
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


On 17/11/22 03:16, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
>
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (eg. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
>
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
>
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory; thus no
> involvement with userspace needed.
>
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
>
>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>     Add the following as the first lines to the RHEL udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:
>
>     # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>
>     These lines will cause cpu and memory hot un/plug events to be
>     skipped within this rule file, with this changset applied.
>
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load syscall.
>
> This kernel patchset also supports kexec_load() with a modified kexec
> userspace utility. A working changeset to the kexec userspace utility
> is posted to the kexec-tools mailing list here:
>
>   http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
>
> To use the kexec-tools patch, apply, build and install kexec-tools,
> then change the kdumpctl's standard_kexec_args to replace the -s with
> --hotplug. The removal of -s reverts to the kexec_load syscall and
> the addition of --hotplug invokes the changes put forth in the
> kexec-tools patch.
>
> Regards,
> eric
> ---
> v14: 16nov2022
>   - Rebased onto 6.1.0-rc5
>   - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
>     compilation of feature components, per Boris.
>   - Removed hp_action parameter to arch_crash_handle_hotplug_event()
>     as it is unused.

But what if an architecture has different actions based on hp type?

- Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
