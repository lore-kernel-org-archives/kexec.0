Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gv-out-0910.google.com ([216.239.58.191])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1N5L5G-0007D9-Qw
	for kexec@lists.infradead.org; Tue, 03 Nov 2009 15:14:16 +0000
Received: by gv-out-0910.google.com with SMTP id r4so739991gve.5
	for <kexec@lists.infradead.org>; Tue, 03 Nov 2009 07:14:09 -0800 (PST)
Message-ID: <4AF048D1.4090402@gmail.com>
Date: Tue, 03 Nov 2009 16:14:25 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
Subject: Re: kdump fails to load and crashes [was: mmotm 2009-11-01-10-01
	uploaded]
References: <200911011807.nA1I7o95016136@imap1.linux-foundation.org>
	<4AEF673E.5030509@gmail.com> <20091103144450.GB4235@redhat.com>
In-Reply-To: <20091103144450.GB4235@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mm-commits@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

On 11/03/2009 03:44 PM, Vivek Goyal wrote:
> On Tue, Nov 03, 2009 at 12:11:58AM +0100, Jiri Slaby wrote:
>> On 11/01/2009 07:07 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2009-11-01-10-01 has been uploaded to
>>
>> Hi, kdump loading crashes:
>> BUG: unable to handle kernel paging request at ffff8800010a7000
>> IP: [<ffffffff8101cd8b>] machine_kexec_prepare+0x16b/0x13e0
>> PGD 1806063 PUD 180a063 PMD 10001e1
...
>> ffff8800010a7000 should be OK, as crashkernel=64M@16M was passed to the
>> kernel.
>>
> 
> This is strange. As you said, ffff8800010a7000, should be a valid address
> as you reserved memory from 16M.

Hmm, PMD has not RW bit set and we do store (see below).

> I took above -mm and for me kernel loads fine. I reserved memory 64M@32M
> as by default kernel is loading at address 16M.
> 
> How does your /proc/iomem look like in first kernel?

I'm not any longer on that machine. init_pgtable() overwrites random
memory, so possibly even host's page tables, hence the oops above, I
suppose.

I'm currently chasing it down in the qemu virtual machine, since I
already got a garbage into my ~/.viminfo (some overwritten page got
flushed, I guess).

There /proc/iomem looks like:
00100000-12beffff : System RAM
  01000000-04ffffff : Crash kernel
    01000000-014680c2 : Kernel code
    014680c3-016f39f7 : Kernel data
    0175b000-017d97ab : Kernel bss

I'll keep you informed.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
