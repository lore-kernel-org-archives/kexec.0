Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXLig-0001tq-Ji
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 05:06:23 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A53v2J113110
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 01:06:00 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9s3gwt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 01:06:00 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 02:05:58 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 656181DC0051
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 01:05:48 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A55vkQ4931752
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 02:05:57 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A55uqw012818
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 02:05:57 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
Date: Wed, 10 Aug 2016 02:05:53 -0300
In-Reply-To: <87r39xthnv.fsf@concordia.ellerman.id.au>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar> <87r39xthnv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <18857164.IzlezsQllh@hactar>
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
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org

Am Mittwoch, 10 August 2016, 13:41:08 schrieb Michael Ellerman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> >> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> >> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes: 
> >> > > +/* Some details preceding the binary serialized measurement list
> >> > > */
> >> > > +struct ima_kexec_hdr {
> >> > > +	unsigned short version;
> >> > > +	unsigned long buffer_size;
> >> > > +	unsigned long count;
> >> > > +} __packed;
> >> > > +
> >> > 
> >> > Am I understanding it correctly that this structure is passed between
> >> > kernels?
> >> 
> >> Yes, the header prefixes the measurement list, which is being passed on
> >> the same computer to the next kernel.  Could the architecture (eg.
> >> LE/BE) change between soft re-boots?
> > 
> > Yes. I am able to boot a BE kernel from an LE kernel with my patches.
> > Whether we want to support that or not is another question...
> 
> Yes you must support that. BE -> LE and vice versa.

I didn't test BE - LE yet, but will do.

> You should also consider the possibility that the next kernel is not
> Linux.

If the next kernel is an ELF binary and it supports the kexec "calling 
convention", it should work too. What could possibly go wrong? I can try 
FreeBSD (I suppose it's an ELF kernel) and see what happens.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
