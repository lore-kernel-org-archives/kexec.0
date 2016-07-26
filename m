Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bS3NH-0004MY-B0
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 14:30:24 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6QES0a3024186
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 07:30:00 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
 by mx0a-00082601.pphosted.com with ESMTP id 24dx653p7c-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 07:30:00 -0700
From: Vinnie Magro <vmagro@fb.com>
Subject: kexec-tools built with musl-libc can't load kernel
Date: Tue, 26 Jul 2016 14:29:58 +0000
Message-ID: <DA43C421-4BD8-4202-B7E9-918AF4210E64@fb.com>
Content-Language: en-US
Content-ID: <C1C41D08722E1942850A210833930EEF@namprd15.prod.outlook.com>
MIME-Version: 1.0
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,
 
I have built kexec-tools with musl-libc (using musl-gcc version 1.1.15), but kexec is unable to load my kernel with the error:
Overlapping memory segments at 0x40d000
sort_segments failed
Nothing has been loaded!
 
Building kexec with glibc produces a binary that is able to load the kernel, so the problem is not with the kernel that I am trying to load. However, the binary built with glibc is much larger, so I would prefer to be able to use a smaller libc.
 
Has anyone managed to compile a functioning kexec with musl-libc?
 
Thanks,
Vinnie


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
