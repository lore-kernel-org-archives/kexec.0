Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fNG2H-00080V-Q7
 for kexec@lists.infradead.org; Mon, 28 May 2018 11:09:59 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4SB96rA014457
 for <kexec@lists.infradead.org>; Mon, 28 May 2018 07:09:44 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j8g6ts7rk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 28 May 2018 07:09:43 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Mon, 28 May 2018 12:09:42 +0100
Date: Mon, 28 May 2018 13:09:37 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH] kexec/s390: Add support for kexec_file_load
In-Reply-To: <20180522081104.calxgxzxel4fqh6j@verge.net.au>
References: <20180516122718.15440-1-prudo@linux.ibm.com>
 <20180521062440.GB6036@dhcp-128-65.nay.redhat.com>
 <20180522081104.calxgxzxel4fqh6j@verge.net.au>
MIME-Version: 1.0
Message-Id: <20180528130937.76e32ce0@ThinkPad>
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
To: Simon Horman <horms@verge.net.au>
Cc: linux-s390@vger.kernel.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

On Tue, 22 May 2018 10:11:04 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Mon, May 21, 2018 at 02:24:40PM +0800, Dave Young wrote:
> > On 05/16/18 at 02:27pm, Philipp Rudo wrote:  
> > > Since kernel 4.17-rc2 s390 supports the kexec_file_load system call. Add
> > > the new system call to kexec-tools and provide the -s (--kexec-file-syscall)
> > > option for s390 to support this new feature.
> > > 
> > > Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>  
> 
> ...
> 
> > Acked-by: Dave Young <dyoung@redhat.com>  
> 
> Thanks, applied.
> 

Sorry for the late answer, I had the last week off.
Nevertheless thanks to both of you.

Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
