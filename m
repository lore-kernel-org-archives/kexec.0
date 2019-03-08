Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2Fp5-0006jk-4u
 for kexec@lists.infradead.org; Fri, 08 Mar 2019 13:46:04 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x28DiKDO046060
 for <kexec@lists.infradead.org>; Fri, 8 Mar 2019 08:46:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r3p6n9csv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 08 Mar 2019 08:46:01 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 8 Mar 2019 13:46:00 -0000
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 08 Mar 2019 08:45:44 -0500
In-Reply-To: <20190308024450.GC7223@dhcp-128-65.nay.redhat.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
 <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
 <1551366343.10911.173.camel@linux.ibm.com>
 <20190308024450.GC7223@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1552052744.4134.26.camel@linux.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org

On Fri, 2019-03-08 at 10:44 +0800, Dave Young wrote:
> Hi Mimi,
> 
> Still did not get change to have a look at V2,  but seems you missed the
> last chunk of comments about the secure boot mode in previous reply?
> 
> I just copy it hear:
> '''
> Do you want to get the Secureboot status here?
> I got some advice from Peter Jones previously, thus we have below
> in our kdump scripts:
> https://src.fedoraproject.org/cgit/rpms/kexec-tools.git/tree/kdump-lib.sh
> 
> See the function is_secure_boot_enforced(), probably you can refer to
> that function and check setup mode as well.
> '''

Thank you for the pointer to the kdump scripts and reminder.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
