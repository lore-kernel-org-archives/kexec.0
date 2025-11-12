Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87AFCCFA1A
	for <kexec@archiver.kernel.org>; Wed, 12 Nov 2025 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tc28RC7WJ74WQbnHGj+6Kgo+hXr0KB57DyHNkBdt6tw=; b=e0mYzyq8r3ccrIk+ryT5EFQHB4
	Bp8wq3QmAKDQwDB14qPguVRsDquGO2XAMYIsTEfmFdQXDqUbdhGAhvHsgZOISaZjYEgBaFHV+A5me
	Y2rnyVRPKrpGXxcaJS+jNUoNQ/QtWzJKGUA8pWjNB9wI2G/qRo2YjZ7oO/7s6H2yOHm5eCH2WXNxc
	MDnJKymr5ikjyUgU3jq8SUX+YQYgmEjTKWKHC6u/8GNXVIDaDxEBLJK4oVpGrbL0fuCiVAFvkofeg
	CYBcpLW9MHSFkvnBKD22jezrM49j2YWN0B9HFq0GglHUWnoniFC9XjV59TENjfzDezUMKFLsME5aB
	+RBMj7PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ9gT-00000008kv5-22Wh;
	Wed, 12 Nov 2025 12:10:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ9gN-00000008kua-2UUP
	for kexec@lists.infradead.org;
	Wed, 12 Nov 2025 12:10:41 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC5uvwN025241;
	Wed, 12 Nov 2025 12:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tc28RC
	7WJ74WQbnHGj+6Kgo+hXr0KB57DyHNkBdt6tw=; b=f+fbNbYiF+rs+5Q91zeSgY
	Xvs2UN9Gf/+iJJwGZK3/68iwmnC2kRoW3OHEbue2KRu1AFDHLwP/2ECvKS/GrKXA
	KoVo0Kn8j/8RfGxoSYZsEIcJr+e/Satur2VrWBR0UWDU9HDJrOSZBQId7XwOLauB
	BA4smTZSB98U4d3FXT/WGMqVwDeFbrS/7WClLRKsnx6z04TJ+wuFepGc7Z7+an9J
	rESD4ElgxuEyK4k3Q2NZXWOTuGwSta5fPTAWVDGHXSsozYzWpN4nOL2zEvc2YQn/
	SJ25ztXt1a9LwmeMiu5yNpGhkK04+l2KC6B78lGnSJWGWD2b8nsl2udqblHWPNJw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjyv5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 12:10:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACAISe0011738;
	Wed, 12 Nov 2025 12:10:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1frbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 12:10:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACCATIw44106146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 12:10:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AFD42004B;
	Wed, 12 Nov 2025 12:10:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDE220040;
	Wed, 12 Nov 2025 12:10:27 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.20.75])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Nov 2025 12:10:26 +0000 (GMT)
Date: Wed, 12 Nov 2025 17:40:18 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Simon Horman <horms@kernel.org>
Cc: sourabhjain@linux.ibm.com, kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools 0/4] ppc64: Support kexec with initrd and DTB
 together
Message-ID: <v3hewal4wj7iyyb2xmtjfycr3ow5azid4orvxaewlrkcljhpml@mutaj75navee>
References: <20251022134611.8921-1-shivangu@linux.ibm.com>
 <aRM-VWmxjXaqQvDC@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRM-VWmxjXaqQvDC@horms.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ewGZU6UyemjQF6gW431O8gmPqxjIPw56
X-Proofpoint-ORIG-GUID: ewGZU6UyemjQF6gW431O8gmPqxjIPw56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX+I4x1XDx8z3/
 jzA/Axil9HDKm4KjqBWptu8U6Mc5PWyF99WOPROUL/RF1v3sN7gzs638JEmvWddyWanleZYJEsC
 upTtH0TSxcT24aSUo2xrZgTpioO3YFPbCGaOYMkeED+LO+vburEjXcEO8Q8FcpZO8b+8XzHaniI
 ilpi8YVE/DLF6PpHUAaDe6olikGrV5h1ddpQPckd2hJLLf7aGUosewIxPwiBkUc0dhljDsPGlC7
 0Us4TIYawziGRp7CQPmrz6ZEYJZ41S5/EuifSf0kmzCfB9NbxrAUSq5NJ66CdcU4COZetrgVG03
 Odl3Owkc7HNivNsPamxo3Na8qvY4jxCisrqYNvt8KasSsjixq2maTfpU+8sj6Xm/fK+EPCyRquv
 fri/gN/DWzBsP+GKY//ZFRluYXXFtg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6914793a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rkpUr8hPZpik8mjhtuIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_041039_954300_F3ACE2A9 
X-CRM114-Status: GOOD (  27.69  )
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

On Tue, Nov 11, 2025 at 01:47:01PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 07:16:05PM +0530, Shivang Upadhyay wrote:
> > Currently, on ppc64 systems, kexec cannot directly use a
> > user-provided devicetreeblob (dtb) when booting a new
> > kernel with an initrd. This limitation exists because the
> > dtb must be modified at runtime — for example, to include
> > the initrd’s memory location and size, and to add
> > /memreserve/ entries based on the current system memory
> > layout.
> > 
> > Previously, kexec handled this by generating a fresh dtb in
> > memory from the running system’s /proc/device-tree directory.
> > However, this approach prevents users from making
> > intentional modifications to the dtb — such as changin boot
> > arguments, enabling or disabling devices, or testing kernel
> > changes that depend on specific device tree properties.
> > 
> > Adding support for user-provided dtb (with appropriate
> > patching by kexec) allows more control for developers,
> > particularly when experimenting with custom kernels or
> > hardware configurations.
> > 
> > This patch series lifts this restriction and ensures that
> > the necessary /memreserve/ sections are properly added to
> > the new DTB. on ppc64, it is mandatory, for the rebooting
> > cpu to be present in the new kernel’s dtb, so additional
> > logic has been added to identify and mark one of available
> > cpu as reboot cpu on currect system.
> > 
> > A new architecture-specific function, arch_do_unload(), has
> > been introduced to perform the necessary cleanup during
> > kexec unload. in ppc64, the reboot CPU changes due to kexec,
> > and it gets reset back on kexec unload.
> > 
> > Shivang Upadhyay (4):
> >   ppc64: ensure /memreserve/ sections exist in user-provided FDT
> >   ppc64: handle reboot CPU in case of user provided DTB
> >   Add arch_do_unload hook for arch-specific cleanup
> >   ppc64: life the dtb and initrd restriction
> 
> Thanks, applied.
Thanks Simon

~Shivang.

