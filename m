Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c066N-00053b-SL
 for kexec@lists.infradead.org; Fri, 28 Oct 2016 12:17:40 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9SCEZ1E142815
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 08:17:19 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26c3eu9srp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 08:17:18 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 22:17:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 774BE2BB0045
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 23:17:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9SCHBn75898510
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 23:17:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9SCHBxr005111
 for <kexec@lists.infradead.org>; Fri, 28 Oct 2016 23:17:11 +1100
Subject: Re: [PATCH] Fix module module_init/init_size offsets for v4.5 kernel
References: <1477631234-15500-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <14d7f3de-37f1-786c-e7e3-96d7f9c89bed@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7B213@BPXM01GP.gisp.nec.co.jp>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 28 Oct 2016 17:47:08 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E7B213@BPXM01GP.gisp.nec.co.jp>
Message-Id: <d2442381-6e06-fba1-750d-560978df5a4f@linux.vnet.ibm.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Friday 28 October 2016 12:06 PM, Atsushi Kumagai wrote:
>> >On Friday 28 October 2016 10:37 AM, Kamalesh Babulal wrote:
>>> >>Kernel commit 7523e4dc50 (module: use a structure to encapsulate layout.)
>>> >>encapsulates core_layout and init_layout into module_layout structure.
>>> >>
>>> >>commit fa6a75a93 (Fix module core base and size offset for kernel v4.5)
>>> >>fixes offset value calculation for core layout's base and size, whereas
>>> >>Kernel v4.5 module changes also needs fixing of module init_size and
>>> >>module_init for the makedumpfile to read the correct module address.
>>> >>
>>> >>This patch fixes calculation of offsets values for module init_size and
>>> >>module_init.
>>> >>
>>> >>Signed-off-by: Kamalesh Babulal<kamalesh@linux.vnet.ibm.com>
>>> >>Cc: Pratyush Anand<panand@redhat.com>
>> >
>> >Reviewed-by: Pratyush Anand<panand@redhat.com>
> Thanks, but I think Guenther posted the same fix which you can see
> in the devel branch:
>
> commit 32dd46803944959f78e01e7c4847c465efca99a6
> Author: Guenther Hutzl<hutzl@linux.vnet.ibm.com>
> Date:   Wed Jul 6 20:00:54 2016 +0900
>
>      [PATCH] Fix module init base and size offset for kernel v4.5

Thank you for pointing out the commit. Should I rebase future patch
against devel branch.

Thanks,
Kamalesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
