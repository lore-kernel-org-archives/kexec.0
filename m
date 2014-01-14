Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3DWs-0004Hm-Ve
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 23:36:19 +0000
Date: Tue, 14 Jan 2014 15:35:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kdump: Fix exported size of vmcoreinfo note
Message-Id: <20140114153554.88b4a8c193b88df9492f6973@linux-foundation.org>
In-Reply-To: <20140114193311.GL3096@redhat.com>
References: <20140114193311.GL3096@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Greg KH <gregkh@suse.de>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Dan Aloni <da-x@monatomic.org>

On Tue, 14 Jan 2014 14:33:11 -0500 Vivek Goyal <vgoyal@redhat.com> wrote:

> Right now we seem to be exporting the max data size contained inside
> vmcoreinfo note. But this does not include the size of meta data around
> vmcore info data. Like name of the note and starting and ending elf_note.
> 
> I think user space expects total size and that size is put in PT_NOTE
> elf header. Things seem to be fine so far because we are not using
> vmcoreinfo note to the maximum capacity. But as it starts filling up,
> to capacity, at some point of time, problem will be visible.

urgh.  This is what we get for adding undocumented interfaces.

Looking through the fd59d231f81cb0287 changelog and the various email
threads it points to I can find no mention of what vmcoreinfo is
*supposed* to contain.  It was just kinda silently tossed in there.

So as a remedial step, could we please get this and any associated
interfaces written down in a way which people can very belatedly
review?

Phrases like "I think user space expects" and "Things seem to be fine
so far" don't inspire a ton of confidence.  What are the chances of
userspace breakage here?  Would it be safer/saner to leave vmcoreinfo
alone and add a new vmcoreinfo2 with the altered behaviour?

> --- linux-2.6.orig/kernel/ksysfs.c	2014-01-14 14:09:42.107767503 -0500
> +++ linux-2.6/kernel/ksysfs.c	2014-01-14 14:15:24.385510314 -0500
> @@ -126,7 +126,7 @@ static ssize_t vmcoreinfo_show(struct ko
>  {
>  	return sprintf(buf, "%lx %x\n",
>  		       paddr_vmcoreinfo_note(),
> -		       (unsigned int)vmcoreinfo_max_size);
> +		       (unsigned int)sizeof(vmcoreinfo_note));
>  }
>  KERNEL_ATTR_RO(vmcoreinfo);
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
