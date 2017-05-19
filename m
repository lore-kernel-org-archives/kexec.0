Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBcKW-0001AO-7E
 for kexec@lists.infradead.org; Fri, 19 May 2017 07:28:09 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4J7JsT5067428
 for <kexec@lists.infradead.org>; Fri, 19 May 2017 03:27:46 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ahmq68pq1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 19 May 2017 03:27:46 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 19 May 2017 08:27:44 +0100
Date: Fri, 19 May 2017 09:27:45 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Error on re-filtering the dump file with
 no free pages
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701ED9104@BPXM01GP.gisp.nec.co.jp>
References: <2d1847a4-0e3c-b282-a3ff-74755716eb69@linux.vnet.ibm.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED89ED@BPXM01GP.gisp.nec.co.jp>
 <20170518140254.3db3f205@TP-holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED9104@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Message-Id: <20170519092745.0bc956a3@TP-holzheu>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>

Am Fri, 19 May 2017 02:35:40 +0000
schrieb Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>:

> >> Hello Zaslonko,
> >>

[snip]

> >Since we don't have the symbols in VMCOREINFO (and IMHO don't need it?) the
> >exclude_free_page() functions fails with the described error message.
> 
> It seems that it's better if I update the condition check of exclude_free_page()
> for recent kernels, but those symbols are unnecessary in this case as you thought
> anyway. exclude_free_page() shouldn't be called for recent kernels, I don't think
> this is an actual problem.
> 
> >So our fix is to adjust the info->level before setup_page_is_buddy() is called.
> 
> I'm sure this fix is reasonable, I'll merge this into v1.6.2.

Thanks!

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
