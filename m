Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXT2L-0004FK-W1
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 12:55:15 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ACsTN7015082
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 08:54:48 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9qn50x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 08:54:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 22:54:43 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 296342BB0055
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 22:54:41 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7ACsf1g22479074
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 22:54:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7ACse0N000920
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 22:54:41 +1000
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 08:54:36 -0400
In-Reply-To: <87vaz9rlx2.fsf@concordia.ellerman.id.au>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar> <87r39xthnv.fsf@concordia.ellerman.id.au>
 <18857164.IzlezsQllh@hactar> <87vaz9rlx2.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Message-Id: <1470833676.2881.183.camel@linux.vnet.ibm.com>
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

On Wed, 2016-08-10 at 19:52 +1000, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > Am Mittwoch, 10 August 2016, 13:41:08 schrieb Michael Ellerman:
> >> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> >> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> >> >> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> >> >> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes: 
> >> >> > > +/* Some details preceding the binary serialized measurement list
> >> >> > > */
> >> >> > > +struct ima_kexec_hdr {
> >> >> > > +	unsigned short version;
> >> >> > > +	unsigned long buffer_size;
> >> >> > > +	unsigned long count;
> >> >> > > +} __packed;
> >> >> > > +
> >> >> > 
> >> >> > Am I understanding it correctly that this structure is passed between
> >> >> > kernels?
> >> >> 
> >> >> Yes, the header prefixes the measurement list, which is being passed on
> >> >> the same computer to the next kernel.  Could the architecture (eg.
> >> >> LE/BE) change between soft re-boots?
> >> > 
> >> > Yes. I am able to boot a BE kernel from an LE kernel with my patches.
> >> > Whether we want to support that or not is another question...
> >> 
> >> Yes you must support that. BE -> LE and vice versa.
> >
> > I didn't test BE - LE yet, but will do.
> 
> Thanks.

Ok. There have been requests for making the binary_runtime_measurements
architecture independent.  As this was not a network facing interface,
we left it in native format.  With the kernel now consuming this data,
it makes sense for the binary_runtime_measurements to be in an
architecture independent format.

Unfortunately, as the <securityfs>/ima/binary_runtime_measurements is
not prefixed with any metadata, this change would need to be Kconfig
based, but kexec would always use the architecture independent format.

> >> You should also consider the possibility that the next kernel is not
> >> Linux.

Oh!

> > If the next kernel is an ELF binary and it supports the kexec "calling 
> > convention", it should work too. What could possibly go wrong? I can try 
> > FreeBSD (I suppose it's an ELF kernel) and see what happens.
> 
> At least for old style kexec (not sys_kexec_load()) I don't think it
> even needs to be an ELF binary.
> 
> I think there are folks working on FreeBSD (or $?BSD), so I think the
> basic kexec part works.
> 
> There's nothing (yet) that wants to use this measurement list obviously,
> but it should be designed such that it could be used by an unknown
> future kernel that knows the ABI.
> 
> So given what you have above, you'd use something like:
> 
> struct ima_kexec_hdr {
> 	u16 version;
> 	u16 _reserved0;
> 	u32 _reserved1;
> 	u64 buffer_size;
> 	u64 count;
> };
> 
> cheers

Thanks, I'll make this change.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
