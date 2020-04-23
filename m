Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRd6e-0001C6-5A
 for kexec@lists.infradead.org; Thu, 23 Apr 2020 14:45:36 +0000
Date: Thu, 23 Apr 2020 10:43:00 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <421536467.24687472.1587652980905.JavaMail.zimbra@redhat.com>
In-Reply-To: <OSBPR01MB19916965DAEB1238FEB962F6DDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB19916965DAEB1238FEB962F6DDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Subject: Re: [Crash-utility] new printk ringbuffer interface
MIME-Version: 1.0
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
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: kexec@lists.infradead.org, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>



----- Original Message -----
> ccing kexec list, vmcore-dmesg also uses vmcoreinfo related to printk..
> 
> > -----Original Message-----
> > 
> > ----- Original Message -----
> > > Hello Dave,
> > >
> > > You may or may not be aware that we are working on replacing [0] the
> > > Linux printk ringbuffer. Rather than a single buffer containing a single
> > > struct type, the new ringbuffer makes use of several different structs.
> > 
> > Yes, I am most definitely aware...
> > 
> > >
> > > I am writing to ask your advice about how this should be exported for
> > > the crash utility. Should all struct sizes and field offsets be
> > > exported? It would look something like this:
> > >
> > >         VMCOREINFO_SYMBOL(prb);
> > >
> > >         VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
> > >         VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
> > >         VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
> > >         VMCOREINFO_OFFSET(printk_ringbuffer, dict_data_ring);
> > >         VMCOREINFO_OFFSET(printk_ringbuffer, fail);
> > >
> > >         VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
> > >         VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
> > >         VMCOREINFO_OFFSET(prb_desc_ring, descs);
> > >         VMCOREINFO_OFFSET(prb_desc_ring, head_id);
> > >         VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
> > >
> > >         VMCOREINFO_STRUCT_SIZE(prb_desc);
> > >         VMCOREINFO_OFFSET(prb_desc, info);
> > >         VMCOREINFO_OFFSET(prb_desc, state_var);
> > >         VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
> > >         VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
> > >
> > >         VMCOREINFO_STRUCT_SIZE(prb_data_blk_lpos);
> > >         VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
> > >         VMCOREINFO_OFFSET(prb_data_blk_lpos, next);
> > >
> > >         VMCOREINFO_STRUCT_SIZE(printk_info);
> > >         VMCOREINFO_OFFSET(printk_info, seq);
> > >         VMCOREINFO_OFFSET(printk_info, ts_nsec);
> > >         VMCOREINFO_OFFSET(printk_info, text_len);
> > >         VMCOREINFO_OFFSET(printk_info, dict_len);
> > >         VMCOREINFO_OFFSET(printk_info, caller_id);
> > >
> > >         VMCOREINFO_STRUCT_SIZE(prb_data_ring);
> > >         VMCOREINFO_OFFSET(prb_data_ring, size_bits);
> > >         VMCOREINFO_OFFSET(prb_data_ring, data);
> > >         VMCOREINFO_OFFSET(prb_data_ring, head_id);
> > >         VMCOREINFO_OFFSET(prb_data_ring, tail_id);
> > >
> > > Or would it be enough to just recognize the new "prb" symbol and have
> > > all the structures defined in the crash utility? If the latter is
> > > preferred, should some sort of version number be exported? Or is the
> > > kernel version number enough?
> 
> first I don't think we can depend on the kernel version because distribution
> kernels backport upstream patches.  So we will need a version number of the
> ringbuffer if we choose that way.

With respect to the kernel version, you are absolutely correct, as we've been
burnt by that before with backports to distribution and the upstream longterm
kernels.  But I think John was talking about exporting a printk-structure-set
version number, so I think we're on the same page.

Also, if we go the version-number route, there would still not be a requirement
for the crash utility to duplicate the kernel data structures in its sources.
As John's proof-of-concept patch showed, it can still use the traditional
manner of getting structure sizes and member offsets.  With the version number
exported, there may have to be a few small adjustments in the MEMBER_OFFSET_INIT()
calls, but it would be fairly straight-forward to maintain.

But of course makedumpfile would have to replicate the kernel data structures.

Thanks,
  Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
