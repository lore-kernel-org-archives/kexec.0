Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX6fg-0004ri-39
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 13:02:16 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79Ct1hu058285
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 09:01:54 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24na1xsf00-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 09 Aug 2016 09:01:45 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 18:31:39 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2EE1A1258061
 for <kexec@lists.infradead.org>; Tue,  9 Aug 2016 18:34:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79CxeMd5046386
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 18:29:40 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79D1PcT010586
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 18:31:26 +0530
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 09:01:13 -0400
In-Reply-To: <87wpjqtdg8.fsf@concordia.ellerman.id.au>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Message-Id: <1470747673.2881.118.camel@linux.vnet.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index b5728da..84e8d36 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -102,6 +102,13 @@ struct ima_queue_entry {
> >  };
> >  extern struct list_head ima_measurements;	/* list of all measurements */
> >  
> > +/* Some details preceding the binary serialized measurement list */
> > +struct ima_kexec_hdr {
> > +	unsigned short version;
> > +	unsigned long buffer_size;
> > +	unsigned long count;
> > +} __packed;
> > +
> 
> Am I understanding it correctly that this structure is passed between kernels?

Yes, the header prefixes the measurement list, which is being passed on
the same computer to the next kernel.  Could the architecture (eg.
LE/BE) change between soft re-boots?

> If so it's an ABI and should use types with well defined sizes, as if it was
> going out to userspace, shouldn't it?

Ok

Mimi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
