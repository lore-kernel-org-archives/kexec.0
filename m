Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bdrFv-00054n-8P
 for kexec@lists.infradead.org; Sun, 28 Aug 2016 03:59:36 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7S3x4qR100907
 for <kexec@lists.infradead.org>; Sat, 27 Aug 2016 23:59:12 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2533rjf2c4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sat, 27 Aug 2016 23:59:12 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sun, 28 Aug 2016 13:59:10 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DCABB2BB0055
 for <kexec@lists.infradead.org>; Sun, 28 Aug 2016 13:59:07 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7S3x7jx51773634
 for <kexec@lists.infradead.org>; Sun, 28 Aug 2016 13:59:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7S3x7RD017322
 for <kexec@lists.infradead.org>; Sun, 28 Aug 2016 13:59:07 +1000
Subject: Re: [PATCH v3 0/5] kexec_file: Add buffer hand-over for the next
 kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Sat, 27 Aug 2016 23:59:00 -0400
In-Reply-To: <2766587.yalBJ6tfVf@hactar>
References: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
 <2766587.yalBJ6tfVf@hactar>
Mime-Version: 1.0
Message-Id: <1472356740.2640.37.camel@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Balbir Singh <bsingharora@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Richter <erichte@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2016-08-25 at 19:17 -0300, Thiago Jung Bauermann wrote:
> Am Donnerstag, 25 August 2016, 14:12:43 schrieb Andrew Morton:
> > I grabbed these two patch series.  I also merged the "IMA:
> > Demonstration code for kexec buffer passing." demonstration patch just
> > to get things a bit of testing.
> 
> Thank you very much!

Thank you, Andrew.

> > I assume that once the "ima: carry the
> > measurement list across kexec" series has stabilised, I should drop the
> > demo patch and also grab those?  If so, pelase start cc'ing me.
> 
> I'm not sure how Mimi is planning to upstream that series.

I'll re-post the patches shortly, cc'ing you.  It will contain support
for saving the binary measurement list on one architecture (eg. little
endian) and restoring it on another (eg. big endian).

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
