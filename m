Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIeWE-0001Bw-CI
 for kexec@lists.infradead.org; Thu, 30 Jun 2016 16:08:46 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UG4XUc128141
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:08:25 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09r459e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:08:24 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 13:08:22 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id ED7A1352006E
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:08:01 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UG8J1j16843080
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 13:08:19 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UG8IgN032029
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 13:08:19 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Thu, 30 Jun 2016 13:08:16 -0300
In-Reply-To: <20160630154119.GB3058@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1736656.LVyt5NrzWE@hactar>
 <20160630154119.GB3058@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <1786832.5GOvNa6ecY@hactar>
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
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, Eric Biederman <ebiederm@xmission.com>

Am Donnerstag, 30 Juni 2016, 11:41:19 schrieb Dave Young:
> On 06/29/16 at 06:09pm, Thiago Jung Bauermann wrote:
> > Am Mittwoch, 29 Juni 2016, 15:45:18 schrieb Dave Young:
> > > On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > > > Am Dienstag, 28 Juni 2016, 15:20:55 schrieb Dave Young:
> > > > > On 06/27/16 at 04:21pm, Dave Young wrote:
> > > It looks good except one nitpick inline..
> > > 
> > > > +/**
> > > > + * kexec_locate_mem_hole - find free memory to load segment or use
> > > > in
> > > > purgatory
> > > 
> > > It is not necessary to use only for purgatory load..
> > 
> > Ok, what about this?
> > 
> > /**
> > 
> >  * kexec_locate_mem_hole - find free memory in a given kimage.
> 
> Hmm, a given kimage sounds not correct, I can not get a better way to
> describe it. How about below with a little change to your previous one:
> 
> kexec_locate_mem_hole - find a free chunk of memory to load kexec segment.
> In powerpc the memory chunk can also be used for the purgatory stack.

That describes what the memory currently is used for. If powerpc or any 
other architecture starts to use the memory for something else, this comment 
would need to be updated. :-)

What the function really does is find free memory in the physical address 
space after the currently running kernel hands over control to whatever runs 
next. What that memory is used for is decided by the caller of the function.

Since (at least for now), the only things that run next are the purgatory 
and the next kernel, what about this?

kexec_locate_mem_hole - find free memory for the purgatory or the next 
kernel

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
