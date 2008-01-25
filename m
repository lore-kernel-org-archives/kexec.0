Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JIUZp-0003n4-3Z
	for kexec@lists.infradead.org; Fri, 25 Jan 2008 19:51:07 +0000
Date: Fri, 25 Jan 2008 14:50:58 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
References: <20080114134303.GA947@hmsreliant.think-freely.org>
	<20080115152710.GA24435@redhat.com>
	<20080115170950.GA24359@hmsendeavour.rdu.redhat.com>
	<20080115173753.GB24435@redhat.com>
	<20080125123558.GA5627@hmsreliant.think-freely.org>
	<20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <479A03DD.5030308@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Jan 25, 2008 at 07:44:29AM -0800, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >Hi Neil,
> >
> >I had a closer look at the code and following are my thoughts.
> >
> >If I look at the 2.6.24 x86 boot code, I think this code does not expect a
> >boot loader to put 2048 size command line in 4K page (so called zero page).
> >I think what it expects is that a boot loader puts command line somewhere
> >outside the zero page and just pass the pointer to that command line in 
> >zero
> >page.
> 
> No, and it never has to the best of my knowledge.
> 
> >So far kexec has been putting command line in zero page. I think it worked
> >because command line was small (256) and zero page had lots of free
> >reserved area. (E820MAX was 32). 
> >
> >Now in latest kernel code E820MAX has been increased to 128 and I don't see
> >lot of free space in bootparam where we can put the 2048 size command line.
> >
> >If we just continue to do what we are doing and just extend the command
> >line size to 2048 in kexec-tools, i think this will overlap with some other
> >area, either with EDD or E820 map etc and real mode code will overwrite 
> >part
> >of command line as passed by kexec, on some systems.
> >
> >So I think we should modify kexec-tools and start putting the 2048
> >size command line outside the setup/zero page.
> >
> >CCing HPA and Eric. They should be able to guide us better.
> 
> You should put it outside struct bootparams.  Furthermore, you should 
> expect an increasing amount of information to be needed beyond struct 
> bootparams in the future; the intent is to have a tagged linked list of 
> expansion information in the future.
> 
> We are already out of e820 *and* EDD information space...
> 

Actually, unless I'm mistaken, thats what horms tree does already.  It was
different in Erics tree IIRC, but in horms tree we just find an open space in
the reserved area to store our parameter header adn point to it, from
elf_x86_64_load:
....
struct x86_linux_faked_param_header *hdr;
                unsigned long param_base;
                const unsigned char *ramdisk_buf;
                off_t ramdisk_length;
                struct entry64_regs regs;
                int rc=0;

                /* Get the linux parameter header */
                hdr = xmalloc(sizeof(*hdr));
                param_base = add_buffer(info, hdr, sizeof(*hdr), sizeof(*hdr),
                        16, 0, max_addr, 1);

....

And then we just point to it inside setup_linux_bootloader_parameters:
...
if (real_mode->protocol_version >= 0x0202) {
                real_mode->cmd_line_ptr = real_mode_base + cmdline_offset;
        }
....

So it seems, given that we already don't put it inside struct bootparam, we
should be able to just expand it, yes?


Regards
Neil


-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
