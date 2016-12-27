Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cLlOY-0007Wn-J2
 for kexec@lists.infradead.org; Tue, 27 Dec 2016 06:37:59 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBR6Y4ca145397
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 01:37:37 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27kdjk2sca-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 01:37:36 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 27 Dec 2016 12:07:33 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E6E6E125804F
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 12:08:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBR6al7a27066504
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 12:06:47 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBR6bTtW011454
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 12:07:29 +0530
Subject: Re: [RFC PATCH 0/4] eppic: Create kernel version compatible scripts
References: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E8EBE7@BPXM01GP.gisp.nec.co.jp>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Tue, 27 Dec 2016 12:07:25 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E8EBE7@BPXM01GP.gisp.nec.co.jp>
Message-Id: <ad97a55d-df7e-8491-9fd8-1d6e5eb4fd20@linux.vnet.ibm.com>
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



On Tuesday 27 December 2016 10:52 AM, Atsushi Kumagai wrote:

Hi Atsushi-San,

>> This patch series creates eppic scripts a for range kernel versions
>> they are compatible with. Eppic scripts directory host sample
>> scripts to scrub sensitive information from the dump file generated
>> using makedumpfile.
>>
>> The initial version of these scripts was based on Fedora 19 kernel.
>> In brief, these scripts rely on hard coded kernel data structure
>> member offsets. Kernel data structures are bound to change in due course
>> and leading to failure when assumptions about the offsets differ.
>>
>> Atsushi-San suggested that, it's better to have different version of
>> eppic scripts, those will be valid for the range of kernel release and
>> their naming convention hinting, of the release they are valid across.
>>
>> The first patch renames the existing eppic script to reflect the kernel
>> release they are compatible with. Following the format:
>> <eppic_script>-<valid from kernel version>_to_<valid until kernel version>.c
>>
>> Rest of three patches creates new eppic scripts to match with the kernel
>> data structures they work with.
> Thank you for reflecting my comments, looks good to me.
> v1.6.1 is ready now, these patches will be merged into v1.6.2.

Thank you for the reviews and picking them. Happy New Year.

-- 
cheers,
Kamalesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
