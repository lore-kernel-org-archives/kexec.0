Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNxU1-0005VU-EU
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 07:24:29 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6F7NYoZ053276
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 03:24:04 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 246kcjm9m2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 03:24:03 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 15 Jul 2016 17:24:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E2FF3578053
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 17:23:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6F7NwXJ23527446
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 17:23:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6F7Nw8u019035
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 17:23:58 +1000
Received: from [9.124.158.81] ([9.124.158.81])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u6F7Nv6U019016
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 17:23:58 +1000
Subject: Re: IO memory read from /proc/vmcore leads to hang.
References: <57841399.1030703@cisco.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 15 Jul 2016 12:53:57 +0530
MIME-Version: 1.0
In-Reply-To: <57841399.1030703@cisco.com>
Message-Id: <bcc40ddc-885e-a61d-e900-90fab3c0de29@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On 07/12/2016 03:16 AM, Daniel Walker wrote:
> 
> Hi,
> 
> I found found that on my Powerpc machine there is some IO memory which
> will cause the box to hang if I read it. It's a custom device that was
> added to the board for a special purpose.
> 
> I was looking for a way to exclude this memory from the dump, and while
> doing that I found that kexec makes a list of memory segments that go
> into the core file. I was wondering why most of the kexec architecture
> don't appear to exclude device memory like what's listed in /proc/iomem.
> 
> Is there a good reason why that's not the case?

Kexec/Kdump is designed to capture entire old kernel's memory that will
be available in /proc/vmcore. There is a different userspace tool called
'makedumpfile' (https://sourceforge.net/projects/makedumpfile/), which
can be used to exclude certain memory pages from the dump while reading
from /proc/vmcore. See if that helps you.

Thanks,
-Mahesh.

> 
> Daniel
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
