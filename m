Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410079.outbound.protection.outlook.com
 ([40.107.141.79] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRcls-0002rF-8y
 for kexec@lists.infradead.org; Thu, 23 Apr 2020 14:24:09 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [Crash-utility] new printk ringbuffer interface
Date: Thu, 23 Apr 2020 14:23:59 +0000
Message-ID: <OSBPR01MB19916965DAEB1238FEB962F6DDD30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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
To: Dave Anderson <anderson@redhat.com>, "Discussion list for crash utility
 usage, maintenance and development" <crash-utility@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

ccing kexec list, vmcore-dmesg also uses vmcoreinfo related to printk..

> -----Original Message-----
> 
> ----- Original Message -----
> > Hello Dave,
> >
> > You may or may not be aware that we are working on replacing [0] the
> > Linux printk ringbuffer. Rather than a single buffer containing a single
> > struct type, the new ringbuffer makes use of several different structs.
> 
> Yes, I am most definitely aware...
> 
> >
> > I am writing to ask your advice about how this should be exported for
> > the crash utility. Should all struct sizes and field offsets be
> > exported? It would look something like this:
> >
> >         VMCOREINFO_SYMBOL(prb);
> >
> >         VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
> >         VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
> >         VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
> >         VMCOREINFO_OFFSET(printk_ringbuffer, dict_data_ring);
> >         VMCOREINFO_OFFSET(printk_ringbuffer, fail);
> >
> >         VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
> >         VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
> >         VMCOREINFO_OFFSET(prb_desc_ring, descs);
> >         VMCOREINFO_OFFSET(prb_desc_ring, head_id);
> >         VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
> >
> >         VMCOREINFO_STRUCT_SIZE(prb_desc);
> >         VMCOREINFO_OFFSET(prb_desc, info);
> >         VMCOREINFO_OFFSET(prb_desc, state_var);
> >         VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
> >         VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
> >
> >         VMCOREINFO_STRUCT_SIZE(prb_data_blk_lpos);
> >         VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
> >         VMCOREINFO_OFFSET(prb_data_blk_lpos, next);
> >
> >         VMCOREINFO_STRUCT_SIZE(printk_info);
> >         VMCOREINFO_OFFSET(printk_info, seq);
> >         VMCOREINFO_OFFSET(printk_info, ts_nsec);
> >         VMCOREINFO_OFFSET(printk_info, text_len);
> >         VMCOREINFO_OFFSET(printk_info, dict_len);
> >         VMCOREINFO_OFFSET(printk_info, caller_id);
> >
> >         VMCOREINFO_STRUCT_SIZE(prb_data_ring);
> >         VMCOREINFO_OFFSET(prb_data_ring, size_bits);
> >         VMCOREINFO_OFFSET(prb_data_ring, data);
> >         VMCOREINFO_OFFSET(prb_data_ring, head_id);
> >         VMCOREINFO_OFFSET(prb_data_ring, tail_id);
> >
> > Or would it be enough to just recognize the new "prb" symbol and have
> > all the structures defined in the crash utility? If the latter is
> > preferred, should some sort of version number be exported? Or is the
> > kernel version number enough?

first I don't think we can depend on the kernel version because distribution
kernels backport upstream patches.  So we will need a version number of the
ringbuffer if we choose that way.

I think that "exporting all things" can sometimes reflect changes in kernel
automatically and can reduce tool side effort more than "exporting a version
number".  But the former requires a lot of entries and it might be hard for
us to track the changes.  So having an explicit version might be better and
I'm ok with the latter.

But I hope no missing update of the version number..
Any thoughts from vmcore-dmesg side?

Thanks,
Kazu

> >
> > I appreciate your feedback.
> >
> > John Ogness
> 
> With respect to the crash utility, there are two answers.
> 
> When running crash session normally, i.e. running "crash vmlinux vmcore", the runtime
> "log" command does not use any VMCOREINFO entries that happen to be attached to a dumpfile.
> Since crash has the vmlinux debuginfo data available, it uses its own interfaces to get
> all kernel symbol and structure related information.
> 
> But there is a little-used capability where the the vmlinux file is not required,
> but rather just the vmcore, in its "crash --log vmcore" feature.  That functionality
> does require the VMCOREINFO entries to extract/dump the log, and exit.  Honestly I wish
> I had never even introduced that feature.  And I wonder if it were deprecated,
> would anybody care?
> 
> However, your question is highly relevant to the makedumpfile(8) facility
> for its "makedumpfile --dump-dmesg" option.  Since it doesn't have the
> luxury of a vmlinux file, it needs all of the VMCOREINF_xxx items.  Kazuhito
> Hagio is the makedumpfile maintainer, and since he is the primary customer
> of the VMCOREINFO entries, he would be a better person to answer your
> question.
> 
> That being said, due the sheer number VMCOREINFO entries required, I like
> your idea of providing a single version number.  But I defer to Kazu for
> his preference.
> 
> Thanks,
>   Dave
> 
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
