Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IBACl-0007hW-D1
	for kexec@lists.infradead.org; Wed, 18 Jul 2007 10:08:42 -0400
Subject: Re: Determine version of kernel that produced vmcore
In-reply-to: <20070716123633.GA10920@in.ibm.com>
Message-Id: <20070718230740oomichi@mail.jp.nec.com>
References: <20070716123633.GA10920@in.ibm.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Wed, 18 Jul 2007 23:07:40 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: Neil Horman <nhorman@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dan Aloni <da-x@monatomic.org>


Hi,

2007/07/16 18:06:33 +0530, Vivek Goyal <vgoyal@in.ibm.com> wrote:
>On Mon, Jul 16, 2007 at 02:28:54PM +0200, Bernhard Walle wrote:
>> * Vivek Goyal <vgoyal@in.ibm.com> [2007-07-16 14:25]:
>> > 
>> > Ok. Now there seems to be two ways for accessing such info.
>> > - Through global variables
>> > - Export through ELF notes.
>> > 
>> > Personally, I like the approach taken by Dan Aloni of exporting required
>> > info through ELF notes. That seems to be more standard in the sense we 
>> > are not dependent on somebody removing above variable tomorrow.
>> > 
>> > Dan, are you planning to put the modified patch for discussions on LKML?
>> 
>> You mean the proposal with the makedumpfile-compatible ELF note?
>> Although I like that idea, I think Ken'ichi Ohmichi was against it.
>> 
>
>Yes, makedumpfile compatible ELF note one. Ken'ichi did not like the idea
>too much, but I am not sure we discussed his objections in detail. I had
>also responded with a mail with some of the advantages of ELF note based
>approach. No response on that.

Sorry for my delayed response, I took a short vacation.

I'm not against with the proposal adding PT_NOTE segment to /proc/vmcore.
I don't like only point that adds the necessary information list
(some symbols, structures, etc.) for makedumpfile to kernel code.

The content of mkdfinfo file has been increasing whenever adding
features and correcting bugs. The content is increasing even now.
And, the feature addition is done not only for new kernels but also
for old upstream kernels. When the content of mkdfinfo file is taken 
into the kernel and fixed, the feature addition in the future is
remarkably limited. So makedumpfile needs mkdfinfo file outside of
the kernel.

I propose the solution including Dan's, Vivek's and Bernhard's opinions.
How about the following sequence for distributors ?
(It is not necessary to rebuild 2nd-kernel initrd even if 1st-kernel changes.
 A new option "--mkdfinfo" is added to kexec command.)

* On the kernel building system
  1. Create the kernel files.
     # cd linux-2.6.xx
     # make
  2. Create the mkdfinfo file from the vmlinux.
     # makedumpfile -g mkdfinfo-2.6.xx -x vmlinux
     (OSRELEASE is taken from the vmlinux.)
  3. Pack the kernel package with the kernel files and the mkdfinfo file.

* On each system
  4. Preload 2nd-kernel and the mkdfinfo file.
     # kexec -p vmlinux-kdump --mkdfinfo=mkdfinfo-2.6.xx ...
     - 2nd-kernel is preloaded.
     - 1st-kernel's PAGESIZE is taken by sysconf().
     - The mkdfinfo file and the above PAGESIZE is preloaded
       into /proc/vmcore's PT_NOTE segment.
  5. Panic happens, and the system switchs to 2nd-kernel.
  6. Create a filtered dump file.
     # makedumpfile -cd31 /proc/vmcore dumpfile
     (User doesn't need to specify the mkdfinfo file, because the
      contents of the mkdfinfo file is included into /proc/vmcore.)


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
