Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgjR9-0007VM-4z
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 23:01:28 +0000
Date: Wed, 13 Nov 2013 18:00:56 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: /proc/vmcore mmap() failure issue
Message-ID: <20131113230056.GA19663@redhat.com>
References: <20131113204130.GD7613@redhat.com>
 <20131113210432.GE7613@redhat.com> <5283EBCD.6070305@zytor.com>
 <20131113224104.GF7613@redhat.com> <528400DD.3040003@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528400DD.3040003@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Wed, Nov 13, 2013 at 02:44:45PM -0800, H. Peter Anvin wrote:
> On 11/13/2013 02:41 PM, Vivek Goyal wrote:
> > 
> > Hi Peter,
> > 
> > I noticed we seem to be trimming away partial pages in memblock.
> > 
> > memblock_x86_fill() {
> > 	/* throw away partial pages */
> >         memblock_trim_memory(PAGE_SIZE);
> > }
> > 
> > But not in e820 hence they show up in /proc/iomem.
> > 
> 
> Why does /proc/iomem matter?

Kexec-tools parse /proc/iomem and prepare PT_LOAD elf headers for all
the RAM regions which need to be dumped out, including the partial page ones.
Second kernel parses these headers and exports to user space in /proc/vmcore.
Makedumpfile tries to mmap() vmcore then tries to map the partial page pfn
too and we run into issues.

> 
> > How about something along the lines as below patch. This fixes my
> > /proc/vmcore mmap() issue.
> 
> I'm not sure if what you're seeing is something that is better handled
> in userspace.

I think it should be easy to truncate ELF headers in kexec-tools too when
we are preparing elf headers. I am not sure if it is right thing to do or
not. If some entry is showing up in /proc/iomem as RAM, then kexec-tools
need to believe that it is a possibility that kernel is using that pfn and
that pfn needs to be dumped out in vmcore. IMHO, kernel should fix this
issue.

Secondly, I am writing in-kernel kexec support too and I prepare ELF
headers there too. And I am facing the same problem there too. So if
we truncate partial pages in e820 both kexec-tools and in kernel kexec
implementation don't have to do anything.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
