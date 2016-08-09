Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX7d7-0001wy-Iw
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 14:03:46 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79DsTVu055006
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 10:03:20 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24ncdd2jcm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 09 Aug 2016 10:03:20 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 19:33:17 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 60D463940064
 for <kexec@lists.infradead.org>; Tue,  9 Aug 2016 19:33:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79E3F7f36765886
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 19:33:15 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79E3CbO029355
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 19:33:14 +0530
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 10:02:57 -0400
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F50D431@AcuExch.aculab.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
 <063D6719AE5E284EB5DD2968C1650D6D5F50D431@AcuExch.aculab.com>
Mime-Version: 1.0
Message-Id: <1470751377.2881.137.camel@linux.vnet.ibm.com>
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
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ima-devel@lists.sourceforge.net" <linux-ima-devel@lists.sourceforge.net>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 'Thiago Jung Bauermann' <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

On Tue, 2016-08-09 at 13:35 +0000, David Laight wrote:

> Also why '__packed' - guarantees sub-optimal code generation.
> Much better to include explicit padding to align everything.

This patch set does not define a new format, but piggy backs on top of
the existing <securityfs>/ima/binary_runtime_measurements list.  The
prefixed buffer header includes a version, so that if in the future we
need to modify the format, we would be able to.

In terms of the prefixed header, how would you define the fields:
version, buffer size, number of measurements? 

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
