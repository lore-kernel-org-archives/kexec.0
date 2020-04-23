Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410051.outbound.protection.outlook.com
 ([40.107.141.51] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRhPV-0002EQ-PH
 for kexec@lists.infradead.org; Thu, 23 Apr 2020 19:21:23 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [Crash-utility] new printk ringbuffer interface
Date: Thu, 23 Apr 2020 19:21:14 +0000
Message-ID: <OSBPR01MB1991F08228D7E9BDBEF07105DDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB19916965DAEB1238FEB962F6DDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <421536467.24687472.1587652980905.JavaMail.zimbra@redhat.com>
 <OSBPR01MB1991CB3EC9C98B2387C61A1EDDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB1991CB3EC9C98B2387C61A1EDDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Content-Language: en-US
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
To: Dave Anderson <anderson@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Discussion list
 for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

> -----Original Message-----
> > -----Original Message-----
> > ----- Original Message -----
> > > ccing kexec list, vmcore-dmesg also uses vmcoreinfo related to printk..
> > >
> > > > -----Original Message-----
> > > >
> > > > ----- Original Message -----
> > > > > Hello Dave,
> > > > >
> > > > > You may or may not be aware that we are working on replacing [0] the
> > > > > Linux printk ringbuffer. Rather than a single buffer containing a single
> > > > > struct type, the new ringbuffer makes use of several different structs.
> > > >
> > > > Yes, I am most definitely aware...
> > > >
> > > > >
> > > > > I am writing to ask your advice about how this should be exported for
> > > > > the crash utility. Should all struct sizes and field offsets be
> > > > > exported? It would look something like this:
> > > > >
> > > > >         VMCOREINFO_SYMBOL(prb);
> > > > >
> > > > >         VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
> > > > >         VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
> > > > >         VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
> > > > >         VMCOREINFO_OFFSET(printk_ringbuffer, dict_data_ring);
> > > > >         VMCOREINFO_OFFSET(printk_ringbuffer, fail);
> > > > >
> > > > >         VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
> > > > >         VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
> > > > >         VMCOREINFO_OFFSET(prb_desc_ring, descs);
> > > > >         VMCOREINFO_OFFSET(prb_desc_ring, head_id);
> > > > >         VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
> > > > >
> > > > >         VMCOREINFO_STRUCT_SIZE(prb_desc);
> > > > >         VMCOREINFO_OFFSET(prb_desc, info);
> > > > >         VMCOREINFO_OFFSET(prb_desc, state_var);
> > > > >         VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
> > > > >         VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
> > > > >
> > > > >         VMCOREINFO_STRUCT_SIZE(prb_data_blk_lpos);
> > > > >         VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
> > > > >         VMCOREINFO_OFFSET(prb_data_blk_lpos, next);
> > > > >
> > > > >         VMCOREINFO_STRUCT_SIZE(printk_info);
> > > > >         VMCOREINFO_OFFSET(printk_info, seq);
> > > > >         VMCOREINFO_OFFSET(printk_info, ts_nsec);
> > > > >         VMCOREINFO_OFFSET(printk_info, text_len);
> > > > >         VMCOREINFO_OFFSET(printk_info, dict_len);
> > > > >         VMCOREINFO_OFFSET(printk_info, caller_id);
> > > > >
> > > > >         VMCOREINFO_STRUCT_SIZE(prb_data_ring);
> > > > >         VMCOREINFO_OFFSET(prb_data_ring, size_bits);
> > > > >         VMCOREINFO_OFFSET(prb_data_ring, data);
> > > > >         VMCOREINFO_OFFSET(prb_data_ring, head_id);
> > > > >         VMCOREINFO_OFFSET(prb_data_ring, tail_id);
> > > > >
> > > > > Or would it be enough to just recognize the new "prb" symbol and have
> > > > > all the structures defined in the crash utility? If the latter is
> > > > > preferred, should some sort of version number be exported? Or is the
> > > > > kernel version number enough?
> > >
> > > first I don't think we can depend on the kernel version because distribution
> > > kernels backport upstream patches.  So we will need a version number of the
> > > ringbuffer if we choose that way.
> >
> > With respect to the kernel version, you are absolutely correct, as we've been
> > burnt by that before with backports to distribution and the upstream longterm
> > kernels.  But I think John was talking about exporting a printk-structure-set
> > version number, so I think we're on the same page.
> >
> > Also, if we go the version-number route, there would still not be a requirement
> > for the crash utility to duplicate the kernel data structures in its sources.
> > As John's proof-of-concept patch showed, it can still use the traditional
> > manner of getting structure sizes and member offsets.  With the version number
> > exported, there may have to be a few small adjustments in the MEMBER_OFFSET_INIT()
> > calls, but it would be fairly straight-forward to maintain.
> >
> > But of course makedumpfile would have to replicate the kernel data structures.
> 
> Ah, indeed.  I vaguely thought makedumpfile also might be able to do like crash
> by setting sizes and offsets for each version..  But it will be hard to set them
> manually for every architectures.  I'll think about it more.

makedumpfile has some architecture or kernel version specific values in it and
switches them by conditions, but the reason why we can do this is that they are
mostly constants that rarely change and can be got from the kernel source easily.
With respect to structure sizes and memger offsets, I don't think of a way to do
this easily.

And then if we define all the structures in makedumpfile with the version number,
how can we implement them and switch for each version?  The new ringbuffer is
structured very much, I cannot imagine that it can be handled efficiently.

Any ideas?

If there is no efficient way, we will need all of the entries in VMCOREINFO.

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
