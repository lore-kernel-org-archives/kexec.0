Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cIugb-0003U0-VE
 for kexec@lists.infradead.org; Mon, 19 Dec 2016 09:56:51 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ9sjYC131417
 for <kexec@lists.infradead.org>; Mon, 19 Dec 2016 04:56:28 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27e8jeah2d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 19 Dec 2016 04:56:28 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 15:26:25 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E1462125804F
 for <kexec@lists.infradead.org>; Mon, 19 Dec 2016 15:27:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJ9tgX121692574
 for <kexec@lists.infradead.org>; Mon, 19 Dec 2016 15:25:42 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJ9uMB6015147
 for <kexec@lists.infradead.org>; Mon, 19 Dec 2016 15:26:22 +0530
Subject: Re: [PATCH 1/2] eppic: vhost_net_buffers - Adopt to struct sk_buff
 changes
References: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E8CA8E@BPXM01GP.gisp.nec.co.jp>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 15:26:17 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E8CA8E@BPXM01GP.gisp.nec.co.jp>
Message-Id: <269b8b17-1067-7b4a-1665-b94bd5ab7e91@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Monday 19 December 2016 01:04 PM, Atsushi Kumagai wrote:
> Hello Kamalesh,
>
> Thanks for taking care of the scripts.
>
> The current scripts are created based on the same kernel version:
>
>     ===================================
>      Eppic scripts README
>     ==================================
>     
>     The eppic scripts are based on the fedora 19 kernel.
>
> So if you update a part of the scripts, the target kernel version of
> them will be complex and confusing.
> I don't think we need to update these scripts since they are just sample,
> the purpose is to tell users how to write a script.
>

Thank you for the review. Agree, these scripts are guide on how to write 
eppic
scripts. On the other hand, if the user tries to run these scripts on 
the latest kernel +
supported makedumpfile for that release, they would fail. These scripts 
are outdated,
when run on latest kernel due to data structure changes. I can take up the
responsibility of maintaining eppic scripts against kernel changes for 
every makedumpfile
release.

-- 
cheers,
Kamalesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
