Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29380C433EF
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m87iR7B1tRb+TaZ3xwt6pW9PEWUy9HL08Plg9rfv8uE=; b=CnNfZNVjMD/4DE
	Tl0CFHkuD/8KEDAlTyavQS+eyuo8F32v+Q2hhNMbjez+niiHLbsNGntDnQuqMrIEX/hgZ2SWc9pe0
	ZrbfZZynFixwZIAgnEz3NbK4xNGcjWZpjyQ9yqJiPMJNdKxzXSTVYlPNQso+EOH0qkQiRT5pKZ0Lq
	922/ynXFzxATI/bawoARf9T95iV3tO2o4RYJY1cT5k2kH6UHma0m6jp7fZsJsUKuALygW7VTpZZQs
	Eq+CGBuhGAttCokfwgE3wd5Vzv94iYd6vL4eKSiv/E3xYUow7wW8k/SmYIqzxYB45jQ17vlu3x91J
	EMHt5jXvzCsFOKQGvMkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9mV7-003U5f-UO; Fri, 08 Jul 2022 11:50:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9mV4-003U2W-T5
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 11:50:24 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268BM0tL029788;
	Fri, 8 Jul 2022 11:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9lirF09Kmt0HGQk1TfIGDd4fJQRMu7hqmmT+uH9e9ck=;
 b=lgR+wc0ahBhfEyMyrk6h1AMNSXqis1tdeTPEgqju57+bZIZ9Hd0Ai9Ywd9pDQbsLzEtc
 tb2HXyGeVKeE0ygxzM85Nm/PBM0HtsvXF0rlpC2tUlMfwLzZLXV71KLAYvyr9li0yXA4
 wyK61kWIlq/stLJl5YW357PcDTHHduFP4g9WXmx9XQNnXArw4MFRYOnr9y7ee5kW6VmX
 8ek5wdlaBXWn+pzzWDu7Vp2xJzZ6DqO64gIPdnq+Mp+ET5lKb/ylfi+jN6JrC14LaruN
 QNOpEJukgXgTsVc7ikRkvG4UM7/ynfe2Ot164wqLLYWkREHWKCiHn8B9wpN4rLMmypnp SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6kn4rgs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 11:50:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 268BNVM8031916;
	Fri, 8 Jul 2022 11:50:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6kn4rgr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 11:50:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 268BMHt9008105;
	Fri, 8 Jul 2022 11:50:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma06ams.nl.ibm.com with ESMTP id 3h4usd3x7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 11:50:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 268Bmg7s24248692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Jul 2022 11:48:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C65055204F;
	Fri,  8 Jul 2022 11:50:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.64.141])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B9CD452050;
	Fri,  8 Jul 2022 11:49:59 +0000 (GMT)
Message-ID: <01c9e6e230b54831091757fe7a09714ccf4bd898.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@fb.com>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org"
	 <kexec@lists.infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii
 Potoskuev <dpotoskuev@fb.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Date: Fri, 08 Jul 2022 07:49:58 -0400
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kTyHucsnhDSKbscf09Oh3zDa-C4FtSr_
X-Proofpoint-GUID: UwNG2QbbcUtmRMAfCoOHPXgyQiHrAfeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_045022_974748_D1F0CFAB 
X-CRM114-Status: GOOD (  43.33  )
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

On Fri, 2022-07-08 at 10:10 +0000, Jonathan McDowell wrote:
> This patchset is not yet complete, but it's already moving around a
> bunch of stuff so I am sending it out to get either some agreement that
> it's a vaguely sane approach, or some pointers about how I should be
> doing this instead.
> 
> It aims to add an option to IMA to measure the individual components
> that make up an initramfs that is being used for kexec, rather than the
> entire initramfs blob. For example in the situation where the initramfs
> blob contains some uncompressed early firmware and then a compressed
> filesystem there will be 2 measurements folded into the TPM, and logged
> into the IMA log.
> 
> Why is this useful? Consider the situation where images have been split
> out to a set of firmware, an initial userspace image that does the usual
> piece of finding the right root device and switching into it, and an
> image that contains the necessary kernel modules.
> 
> For a given machine the firmware + userspace images are unlikely to
> change often, while the kernel modules change with each upgrade. If we
> measure the concatenated image as a single blob then it is necessary to
> calculate all the permutations of images that result, which means
> building and hashing the combinations. By measuring each piece
> individually a hash can be calculated for each component up front
> allowing for easier analysis of whether the running state is an expected
> one.
> 
> The KEXEC_FILE_LOAD syscall only allows a single initramfs image to be
> passed in; one option would be to add a new syscall that supports
> multiple initramfs fds and read each in kimage_file_prepare_segments().
> 
> Instead I've taken a more complicated approach that doesn't involve a
> new syscall or altering the kexec userspace, building on top of the way
> the boot process parses the initramfs and using that same technique
> within the IMA measurement for the READING_KEXEC_INITRAMFS path.
> 
> To that end I've pulled the cpio handling code out of init/initramfs.c
> and into lib/ and made it usable outside of __init when required. That's
> involved having to pull some of the init_syscall file handling routines
> into the cpio code (and cleaning them up when the cpio code is the only
> user). I think there's the potential for a bit more code clean up here,
> but I've tried to keep it limited to providing the functionality I need
> and making checkpatch happy for the moment.
> 
> Patch 1 pulls the code out to lib/ and moves the global static variables
> that hold the state into a single context structure.
> 
> Patch 2 does some minimal error path improvements so we're not just
> passing a string around to indicate there's been an error.
> 
> Patch 3 is where I pull the file handling routines into the cpio code.
> It didn't seem worth moving this to somewhere other code could continue
> to use them when only the cpio code was doing so, but it did involve a
> few extra exported functions from fs/
> 
> Patch 4 actually allows the use of the cpio code outside of __init when
> CONFIG_CPIO is selected.
> 
> Patch 5 is a hack so I can use the generic decompress + gzip outside of
> __init. If this overall approach is acceptable then I'll do some work to
> make this generically available in the same manner as the cpio code
> before actually submitting for inclusion.
> 
> Patch 6 is the actual piece I'm interested in; doing individual
> measurements for each component within IMA.

Hi Jonathan,

Before going down this path, just making sure you're aware:
- of the IMA hooks for measuring and appraising firmware.

- of Roberto Sassu's "initramfs: add support for xattrs in the initial
ram disk" patch set that have been lingering for lack of review and
upstreaming.[1]   There's been some recent interest in it.

[1] Message-Id: <21b3aeab20554a30b9796b82cc58e55b@huawei.com>

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
