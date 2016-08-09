Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX7go-0004mx-31
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 14:07:31 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79E4dIJ019722
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 10:07:08 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qchy57j0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 09 Aug 2016 10:07:08 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 00:07:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 979A42CE8046
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 00:07:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79E73cn28246266
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 00:07:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79E735S026749
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 00:07:03 +1000
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 10:06:58 -0400
In-Reply-To: <1470750957.2881.131.camel@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
 <1470750957.2881.131.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Message-Id: <1470751618.2881.140.camel@linux.vnet.ibm.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org

On Tue, 2016-08-09 at 09:55 -0400, Mimi Zohar wrote:
> On Tue, 2016-08-09 at 10:19 -0300, Thiago Jung Bauermann wrote:
> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> > > On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> > > > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > > > > diff --git a/security/integrity/ima/ima.h
> > > > > b/security/integrity/ima/ima.h
> > > > > index b5728da..84e8d36 100644
> > > > > --- a/security/integrity/ima/ima.h
> > > > > +++ b/security/integrity/ima/ima.h
> > > > > @@ -102,6 +102,13 @@ struct ima_queue_entry {
> > > > > 
> > > > >  };
> > > > >  extern struct list_head ima_measurements;	/* list of all 
> > measurements
> > > > >  */
> > > > > 
> > > > > +/* Some details preceding the binary serialized measurement list */
> > > > > +struct ima_kexec_hdr {
> > > > > +	unsigned short version;
> > > > > +	unsigned long buffer_size;
> > > > > +	unsigned long count;
> > > > > +} __packed;
> > > > > +
> > > > 
> > > > Am I understanding it correctly that this structure is passed between
> > > > kernels?
> > > Yes, the header prefixes the measurement list, which is being passed on
> > > the same computer to the next kernel.  Could the architecture (eg.
> > > LE/BE) change between soft re-boots?
> > 
> > Yes. I am able to boot a BE kernel from an LE kernel with my patches. 
> > Whether we want to support that or not is another question...
> 
> The <securityfs/ima/binary_runtime_measurements is system architecture
> dependent.  It looks like the khdr->version check in
> ima_restore_measurement_list() would fail if the architecture changes.
> 
> If/when we update the binary measurement list format to support multiple
> TPM PCRs, we should address the endianness as well.

That should have been "TPM PCR banks".  TPM 2.0 allows for multiple TPM
PCR banks.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
