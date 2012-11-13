Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJSf-00073W-4m
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:35:42 +0000
Date: Tue, 13 Nov 2012 11:35:37 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] vmcore-dmesg: Determine file data size based on e_machine
Message-ID: <20121113163537.GA12529@redhat.com>
References: <20121112203800.GE24254@redhat.com> <87d2zijlw0.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87d2zijlw0.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

On Mon, Nov 12, 2012 at 06:07:43PM -0800, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > A 32bit arch can prepare ELF64 headers. For example for PAE case to
> > preresent file offsets 64bit but data size at the offset still remains
> > 32bit. If we just base our decision based on EI_CLASS, then we will try
> > to read 64bit data from file and can run into various issues.
> >
> > We ran into following issue when we tried to run vmcore-dmesg on a 32bit
> > PAE system vmcore which had 64bit elf headers.
> >
> > No program header covering vaddr 0xc0a6a688c0b89100found kexec bug?
> >
> > Basically we try to read value of log_buf variable from address
> > log_buf_vaddr. We read in 64bit value and then pass that value again
> > to vaddr_to_offset() in an attempt to get to actual log_buf start
> > and get error message.
> >
> > So determine the data size based on arch and read the bytes from
> > file accordingly.
> 
> The basic code change is sound.  However the naming is problematic.
> 
> Let me suggest:
> 
> static unsigned machine_pointer_bits(void)
> {
>         uint8_t bits = 0;
> 
>         /* Default to the size of the elf class */
>         switch(ehdr.e_ident[EI_CLASS]) {
>         case ELFCLASS32:	bits = 32; break;
>         case ELFCLASS64:	bits = 64; break;
>         }
> 
>         /* Report the architectures pointer size */
>         switch(ehdr.e_machine) {
>         case EM_386:		bits = 32; break;
>         }
> 
>         return bits;
> }

Thanks Eric. Version 2 is on the way.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
