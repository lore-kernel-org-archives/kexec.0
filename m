Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400042.outbound.protection.outlook.com
 ([40.107.140.42] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kISzQ-00033l-8o
 for kexec@lists.infradead.org; Wed, 16 Sep 2020 08:40:33 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: makedumpfile: a feature question about filtering
Date: Wed, 16 Sep 2020 08:40:26 +0000
Message-ID: <OSBPR01MB19912FCDF7C6FAC633A2D856DD210@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
 <OSBPR01MB1991C082928AD18ED5574DDBDD240@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <0b99591e-7117-7661-e728-684ece22787e@redhat.com>
 <OSBPR01MB19915EEEDE74943D073908D4DD230@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <e6f42e12-5c7c-67fa-0f5c-621d7508ee45@redhat.com>
 <OSBPR01MB1991A2DAB9596B60910C9CE6DD230@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <80e79f89-4d9d-b4de-5d90-4a9d4d242e70@redhat.com>
In-Reply-To: <80e79f89-4d9d-b4de-5d90-4a9d4d242e70@redhat.com>
Content-Language: ja-JP
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
To: piliu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pingfan,

-----Original Message-----
> >>>>> -----Original Message-----
> >>>>>> Hello,
> >>>>>>
> >>>>>> There is an appeal which only wants to save some user page including env
> >>>>>> and args pages, and discards the other user space pages.
> >>>>>
> >>>>> I understand that it's helpful to get them even with -d 31 for crash's
> >>>>> "ps -a" option..
> >>>>>
> >>>>>>
> >>>>>> To achieve this feature, mm_struct's members "arg_start, arg_end,
> >>>>>> env_start, env_end;" should be accessed. So we need to export mm_struct
> >>>>>> and init_mm through vmcore.
> >>>>>
> >>>>> How many offsets/sizes will be required to walk all tasks?
> >>>> At present, I think only the info "arg_start, arg_end, env_start,
> >>>> env_end" in mm_struct are required.
> >>>
> >>> ah what I wanted to ask mainly was the number of the offsets/sizes used to
> >>> walk through all (user) tasks in a system, because makedumpfile cannot get
> >>> to a task's arg_start only with OFFSET(mm_struct.arg_start).  Is it easy
> >>> enough to do it only with several vmcoreinfo entries?
> >> Yes, it is. Iterating over tasks requires to expose
> >> OFFSET(mm_struct.mmlist, and &init_mm. Then for each mm_struct, we need
> >> an access to "arg_start, arg_end, env_start,env_end"
> >
> > Hmm, but a Fedora 32 machine has an empty init_mm.mmlist.
> > (because of no used swap?)
> Aha, sorry that I made a mistake and mmlist is not used to organize all
> the mm any more.
> 
> In order to access all mm_strcut in the system, init_task.tasks
> linked-list should be exposed, and for each task we can access its
> mm_struct by OFFSET(task_struct.mm), then OFFSET(mm_struct.arg_start).
> >
> > crash> p init_mm.mmlist
> > $1 = {
> >   next = 0xffffffff826ee200 <init_mm+160>,
> >   prev = 0xffffffff826ee200 <init_mm+160>
> > }
> > crash> swap
> > SWAP_INFO_STRUCT    TYPE       SIZE       USED     PCT  PRI  FILENAME
> > ffff8badb5385a00  PARTITION  4153340k      0k       0%   -2  /dev/dm-1
> >
> > I might be still missing something.
> You are right. And could you foresee any problem with my new try?

as far as I took a glance at copy_process(), it looks good.

                if (thread_group_leader(p)) {
                        ...
                        list_add_tail_rcu(&p->tasks, &init_task.tasks);

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
