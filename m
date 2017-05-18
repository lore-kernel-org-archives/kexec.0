Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBK9H-0007yN-Dd
 for kexec@lists.infradead.org; Thu, 18 May 2017 12:03:21 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4IBrmsi093237
 for <kexec@lists.infradead.org>; Thu, 18 May 2017 08:02:57 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2agyb2mgtb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 18 May 2017 08:02:57 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 18 May 2017 13:02:55 +0100
Date: Thu, 18 May 2017 14:02:54 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Error on re-filtering the dump file with
 no free pages
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701ED89ED@BPXM01GP.gisp.nec.co.jp>
References: <2d1847a4-0e3c-b282-a3ff-74755716eb69@linux.vnet.ibm.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED89ED@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Message-Id: <20170518140254.3db3f205@TP-holzheu>
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

Am Thu, 18 May 2017 04:37:20 +0000
schrieb Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>:

> Hello Zaslonko,
> 
> > When re-filtering the dump file after the free pages have already been
> > stripped out we get an error "Can't get necessary symbols for excluding
> > free pages" if newly specified dump level is below 16 (preserves free
> > pages).
> > According to the code, the check for the new dump level is done BEFORE
> > the new dump level is actually set (based on the dump level specified in
> > the command and the one from the input dump file).
> > Moving the new_dump_level calculation ahead would fix the error.
> 
> Well, I guess the real problem is different.
> The error you said is printed by exclude_free_page():
> 
>         if ((SYMBOL(node_data) == NOT_FOUND_SYMBOL)
>             && (SYMBOL(pgdat_list) == NOT_FOUND_SYMBOL)
>             && (SYMBOL(contig_page_data) == NOT_FOUND_SYMBOL)) {
>                 ERRMSG("Can't get necessary symbols for excluding free pages.\n");
>                 return FALSE;
>         }
> 
> I think the availability of these symbols are not related to free pages.
> exclude_free_page() is called if info->page_is_buddy is null, I estimate that
> this situation occurs only if the kernel is older(2.6.16 or before). 
> 
> However, I don't think you use such too old kernel, so I suspect that
> setup_page_is_buddy() should be updated for newer kernel.

Mikhail is on vacation now - so I try to explain:

The test case is as follows:

 1) We have a -d31 filtered dump "dump.d31"
 2) We want to compress the dump with "makedumpfile -c dump.31 dump31.compressed"

This fails with:

makedumpfile -c dump.31 dump.31.compressed
Excluding unnecessary pages        : [100.0 %]
exclude_free_page: Can't get necessary symbols for excluding free pages.
dump_level is changed to 31, because dump.31 was created by dump_level(31).
makedumpfile Failed.

The problem is that setup_page_is_buddy() is not called in this case because
info->dump_level is still 0 since it was not adjusted early enough:

        if (info->dump_level & DL_EXCLUDE_FREE)
                setup_page_is_buddy();

Because it is not set info->page_is_buddy is NULL and therefore the following
if condition gets true:

        if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
                if (!exclude_free_page(cycle))
                        return FALSE;

Since we don't have the symbols in VMCOREINFO (and IMHO don't need it?) the
exclude_free_page() functions fails with the described error message.

So our fix is to adjust the info->level before setup_page_is_buddy() is called.

Best Regards
Michael

> Could you tell me your kernel version and how to reproduce this issue ?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
