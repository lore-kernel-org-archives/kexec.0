Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1tB-0006E6-0e
	for kexec@lists.infradead.org; Fri, 27 May 2011 18:36:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172618.GB18295@in.ibm.com> <m11uzk80vx.fsf@fess.ebiederm.org>
	<20110527182210.GH8053@redhat.com>
Date: Fri, 27 May 2011 11:35:53 -0700
In-Reply-To: <20110527182210.GH8053@redhat.com> (Vivek Goyal's message of
	"Fri, 27 May 2011 14:22:10 -0400")
Message-ID: <m1hb8g6lfa.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch 6/6] Crash: Recognise slim coredumps and process new
	elf-note sections
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wang Chao <wang.chao@cn.fujitsu.com>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, prasad@linux.vnet.ibm.com, crash-utility@redhat.com

Vivek Goyal <vgoyal@redhat.com> writes:

> On Fri, May 27, 2011 at 11:16:34AM -0700, Eric W. Biederman wrote:
>> "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
>> 
>> > Crash: Recognise slim coredumps and process new elf-note sections
>> >
>> > The Linux kernel will begin to support SlimDump for certain types of crashes
>> > and the 'crash' tool needs to recognise them. For these types of coredumps, it
>> > need not lookout for usual elf-structures and start gdb. Also process new
>> > elf-note sections that contain additional information about the crash.
>> 
>> I suppose patching crash make sense.
>> 
>> Unfortunately crash doesn't work on  99% of the  kernels I run so, so I
>> stopped caring a while ago.
>
> Are these patched kernels? Otherwise Dave Anderson is pretty good about
> keeping crash running across multiple kernels.

Only slightly patched.  But they are definitely kernels I have built
myself.  It might just be a logistics problem where if I want to use
crash I need to upgrade it when I upgrade my kernels.

I got frustrated a while ago trying to get something out of crash
(and I'm afraid it shows), and I have just gone to extracting the
dmesg.  Which gives me all of the information I generally have time
to process.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
