Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qhk0N-0006Zk-IM
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 15:08:40 +0000
Received: by iyn15 with SMTP id 15so1410746iyn.36
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 08:08:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAA393vjc3vE3PG7EW70+8q3rTfv+yxcN-MbVGvH-nSUE9kCqVw@mail.gmail.com>
References: <CAA393vjc3vE3PG7EW70+8q3rTfv+yxcN-MbVGvH-nSUE9kCqVw@mail.gmail.com>
Date: Sat, 16 Jul 2011 00:08:36 +0900
Message-ID: <CAA393viZQaqUYgiVUSvHB8HyW7xdCAuC+ba1zRGqcEdWFZ75Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
From: "Ken'ichi Ohmichi" <ken1ohmichi@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hi Mahesh,

>> On my machine (RHEL5 x86_64), I cannot compile makedumpfile with this patch.
>> I guess that it is due to old elfutils of my machine, and I am trying this
>> problem by newer elfutils.
>>
>> I'd like to get some hints, so can you tell me your environment ?
>> RHEL6 x86_64 ?
>
> Yes, I had tested these patches on RHEL6.0 and RHEl6.1 x86_64. As far as
> I know RHEL6.0 had elfutils-0.148.

OK, Thanks.

> I did not try my patches on RHEL5 x86-64. Let me see if I can get a
> RHEL5 x86_64 box to verify.
>
> But in case we can not fix the compilation with RHEL5 environment, do
> you think we can go with one of following options:
>
> 1. When compiled with older elfutils library, build makedumpfile without
> this feature enabled.
> 2. Make newer elfutils vesion as pre-requisite for future makedumpfile
> releases.
>
> What do you think?

That is a good question.
I think option 2 is better, because option 1 stops the enhancement.
On current README file, makedumpfile needs elfutils-0.125 or latter,
and it should be changed to newer.
Anyway, I will be digging more for compling it on most envrionments.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
