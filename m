Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qj75U-0007q5-B2
	for kexec@lists.infradead.org; Tue, 19 Jul 2011 09:59:37 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.4/8.13.1) with ESMTP id p6J9xQpr010855
	for <kexec@lists.infradead.org>; Tue, 19 Jul 2011 15:29:26 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6J9xPb32641998
	for <kexec@lists.infradead.org>; Tue, 19 Jul 2011 15:29:25 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6J9xONH008572
	for <kexec@lists.infradead.org>; Tue, 19 Jul 2011 19:59:25 +1000
Message-ID: <4E25557C.2080509@linux.vnet.ibm.com>
Date: Tue, 19 Jul 2011 15:29:24 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading module
	debuginfo.
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110715183541.e9f5e604.oomichi@mxs.nes.nec.co.jp>
	<4E2014B2.70105@linux.vnet.ibm.com>
	<20110719112749.88d83252.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110719112749.88d83252.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ich,

On 07/19/2011 07:57 AM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Fri, 15 Jul 2011 15:51:38 +0530
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>>>
>>> On my machine (RHEL5 x86_64), I cannot compile makedumpfile with this patch.
>>> I guess that it is due to old elfutils of my machine, and I am trying this
>>> problem by newer elfutils.
>>>
>>> I'd like to get some hints, so can you tell me your environment ?
>>> RHEL6 x86_64 ?
>>
>> Yes, I had tested these patches on RHEL6.0 and RHEl6.1 x86_64. As far as
>> I know RHEL6.0 had elfutils-0.148.
>>
>> I did not try my patches on RHEL5 x86-64. Let me see if I can get a
>> RHEL5 x86_64 box to verify.
> 
> I can compile it with elfutils-0.137 and some compiling options on RHEL5.
> We need the following change in Makefile.
> 
> -       $(CC) $(CFLAGS) $(OBJ_ARCH) -o $@ $< -static -ldw -lelf -lz
> +       $(CC) $(CFLAGS) $(OBJ_ARCH) -o $@ $< -static -ldw -lbz2 -lebl -ldl -lelf -lz
> 
> 
> By the way, do you have any documents/samples for dwfl_XXXX functions ?
> I'd like to see them for reviewing this patch.

As far as I know there is no formal documentation available for
dwfl_xxxx functions apart from 'elfutils/libdwfl/libdwfl.h' from
elfutils sources. In fact the elfutils itself lacks the Documentation
part for most of it's APIs.

I used 'elfutils/libdwfl/libdwfl.h' from elfutils sources as a reference
which has neat explanation for each dwfl_xxx() functions. Apart from
libdwfl.h I also used to go through actual function implementations
available under elfutils sources.

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
