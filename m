Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIeEH-0006NG-5o
 for kexec@lists.infradead.org; Thu, 30 Jun 2016 15:50:13 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UFjCxB002985
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 11:49:52 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23uw5rjcmf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 11:49:51 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 12:49:49 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id AB3783520068
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 11:49:29 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UFnkQA4460784
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:49:46 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UFnkFM024214
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:49:46 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Thu, 30 Jun 2016 12:49:44 -0300
In-Reply-To: <20160630150700.GA3058@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1994502.0E8c14rYFh@hactar>
 <20160630150700.GA3058@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <1866019.1p7Z0CLUZh@hactar>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Am Donnerstag, 30 Juni 2016, 11:07:00 schrieb Dave Young:
> On 06/29/16 at 06:18pm, Thiago Jung Bauermann wrote:
> > Am Mittwoch, 29 Juni 2016, 15:47:51 schrieb Dave Young:
> > > On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > > > +/**
> > > > + * struct kexec_buf - parameters for finding a place for a buffer
> > > > in
> > > > memory + * @image:   kexec image in which memory to search.
> > > > + * @mem:     On return will have address of the buffer in memory.
> > > > + * @memsz:   Size for the buffer in memory.
> > > > + * @buf_align:       Minimum alignment needed.
> > > > + * @buf_min: The buffer can't be placed below this address.
> > > > + * @buf_max: The buffer can't be placed above this address.
> > > > + * @top_down:        Allocate from top of memory.
> > > > + */
> > > > +struct kexec_buf {
> > > > +     struct kimage *image;
> > > > +     unsigned long mem;
> > > > +     unsigned long memsz;
> > > > +     unsigned long buf_align;
> > > > +     unsigned long buf_min;
> > > > +     unsigned long buf_max;
> > > > +     bool top_down;
> > > > +};
> > > 
> > > Rethink about the first patch, you dropped the user buffer in
> > > kexec_buf
> > > But later your passing IMA digests buffer patchset may need use it.
> > > 
> > > So keep it in kexec_buf should be better.
> > 
> > I'm not following. The IMA buffer patchset doesn't use
> > kexec_locate_mem_hole nor struct kexec_buf.
> 
> It does not use kexec_locate_mem_hole, but the buffer being passed is
> very similar to a kexec_buf struct, no?

If what you're saying is that the arguments passed to 
kexec_add_handover_buffer in the IMA buffer patchset are very similar to the 
arguments passed to kexec_add_buffer then yes, it's true.

> So you may refactor kexec_add_buffer and your new function to pass only
> kimage and a kbuf, it will be better than passing all those arguments
> separately.

To be honest I think struct kexec_buf is an implementation detail inside 
kexec_locate_mem_hole, made necessary because the callback functions it uses 
need to access its arguments. Callers of kexec_locate_mem_hole, 
kexec_add_handover_buffer and kexec_add_buffer shouldn't need to know it 
exists.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
