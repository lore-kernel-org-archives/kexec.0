Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA36C7EE22
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3H8gnTcDcSO4EBeOzrHaxBWU7W+IycUJAYRr329gM/0=; b=gZ9sEC7l9S4bFlrvb7GVhVzN64
	YgwEy6flcjCX4GHHKa+X/pRMvhwj8cSemEOyOalZXC4fWkytIzGK1jo9b279AhlNeQ6DcP4K0R3rf
	39LKCUBtv+DabUFxfZHRmtJxJygCA0QdtmLcbQJhipn83jF6YVdiZCGQprGQuDMTsRsWxzoaZDpCK
	HbIjWw3yGz527ZOdhi3cYj9jdtsLr8/b/2noD8qGOQIrBWL39MGDjize4YafFl65BeF9FcZbUdph8
	l/RQBxc0Y1bG+aq/j8OJCo2S/kF31O53iKgQkbomHzpVCnfvz51QifZ8J5kQDCpueNYF+BJcT0FTl
	lMrGwb8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prvn4-005d5H-2g;
	Thu, 27 Apr 2023 07:11:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prvn1-005coN-2N
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 07:11:41 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R77AeR028416;
	Thu, 27 Apr 2023 07:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1moAoHtil6lEu7K2DGne1pxfJDqkbBHuvXsp8jQzFYo=;
 b=ie5EFFisl+gxLHmulGXZ8eDBgcXsZ/xjlrMP11fMB3t1aET1nC/gO4NEwsRIP8P5ixSI
 yKTr+yBKfqhpiKQi8pS7IClKiAg5/2XZjQokWYJOJbr7zb5WCZACITwAeGnqH47sp26y
 UyLgYGR/0ZltB3eZ9JGY2zkBhO8GKTiit7FzyLgRHoRo6LRdejRcEblt0y2NRq0ST1f9
 btinXPrk2QBhHNVXvDQN+AklHHpJNHA3Pzg8C5ec6coLkbL5IpEzbDJmD7ygRMOWIjlE
 8/360wdNfpfldu+YGBckDquQK0CVZNKAf1R4taYlp+ECizkcNofH+g/ysz3zXhS4RUuv Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7m7rr6yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Apr 2023 07:09:00 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R778s4028379;
	Thu, 27 Apr 2023 07:08:59 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7m7rr6tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Apr 2023 07:08:59 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33R487OD032104;
	Thu, 27 Apr 2023 07:08:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3q477729y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Apr 2023 07:08:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33R78p6K6488618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 07:08:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B19CC2004B;
	Thu, 27 Apr 2023 07:08:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 612A820043;
	Thu, 27 Apr 2023 07:08:46 +0000 (GMT)
Received: from [9.43.11.206] (unknown [9.43.11.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Apr 2023 07:08:46 +0000 (GMT)
Message-ID: <2bc7d559-d827-bae9-33e0-4b7ca172ce5d@linux.ibm.com>
Date: Thu, 27 Apr 2023 12:38:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LjrBv1jfrpPeAR5_o7oQjwI0FVfREAjz
X-Proofpoint-GUID: YlfV2DA4ospcZQkqGsyhCpEdHhEnnNId
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_001139_784281_736FBAF0 
X-CRM114-Status: GOOD (  28.33  )
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

Hi Eric,

On 04/04/23 11:33 pm, Eric DeVolder wrote:
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.
> 
> The elfcorehdr describes to kdump the CPUs and memory in the system,
> and any inaccuracies can result in a vmcore with missing CPU context
> or memory regions.
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
> elfcorehdr) by the userspace kexec utility. In the original post I
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash handler that registers with
> the CPU and memory notifiers. Upon CPU or memory changes, from either
> hot un/plug or off/onlining, this generic handler is invoked and
> performs important housekeeping, for example obtaining the appropriate
> lock, and then invokes an architecture specific handler to do the
> appropriate elfcorehdr update.
> 
> Note the description in patch 'crash: change crash_prepare_elf64_headers()
> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
> enables further optimizations related to CPU plug/unplug/online/offline
> performance of elfcorehdr updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory; thus no involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>     Add the following as the first lines to the RHEL udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:
> 
>     # The kernel updates the crash elfcorehdr for CPU and memory changes
>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
>     With this changeset applied, the two rules evaluate to false for
>     CPU and memory change events and thus skip the userspace
>     unload-then-reload of kdump.
> 
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load() syscall.
> 
> This kernel patchset also supports kexec_load() with a modified kexec
> userspace utility. A working changeset to the kexec userspace utility
> is posted to the kexec-tools mailing list here:
> 
>   http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

With the in-kernel update, the size is anyway getting calculated in
kernel for kexec_file_load case, how about passing the recommended size
for elfcorehdr segment and any other segment that needs an in-kernel 
update as a sysfs attribute instead of kexec-tools having to do the
calculation again in the userspace  (get_elfcorehdrsz()) for kexec_load
case. That makes segment size calculation less error prone.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
