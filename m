Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWT4B-0002KS-Ai
 for kexec@lists.infradead.org; Wed, 25 Jan 2017 19:17:13 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0PJ9RMb107900
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2017 14:16:50 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 287053cf9f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2017 14:16:49 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 26 Jan 2017 05:16:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 16D7E2CE8056
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2017 06:16:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0PJGaJd26804240
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2017 06:16:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0PJGCDl022522
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2017 06:16:12 +1100
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
 <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 00:45:52 +0530
MIME-Version: 1.0
In-Reply-To: <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
Message-Id: <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
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
To: Tony Luck <tony.luck@gmail.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, kexec-ml <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>



On Tuesday 24 January 2017 11:53 PM, Tony Luck wrote:
> On Tue, Jan 24, 2017 at 10:11 AM, Hari Bathini
> <hbathini@linux.vnet.ibm.com> wrote:
>
>> Hello IA64 folks,
>>
>> Could you please review this patch..?
> It looks OK in principal.  My lab is in partial disarray at the
> moment (just got back from a sabbatical) so I can't test
> build and boot. Have you cross-compiled it (or gotten a success
> build report from zero-day)?

I haven't gotten a success/failure build report from zero-day. Not sure 
what to make of it.
But I did try cross-compiling and it was successful. Should that do?

Thanks
Hari


> If you have ... then add an Acked-by: Tony Luck <tony.luck@intel.com>
>
> -Tony
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
