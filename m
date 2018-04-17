Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8MWe-0000zw-Ls
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 09:03:46 +0000
Date: Tue, 17 Apr 2018 10:01:13 +0100
From: Russell King <rmk@armlinux.org.uk>
Subject: Re: kdump in upstream kexec-tools
Message-ID: <20180417090113.GA19564@flint.armlinux.org.uk>
References: <CACi5LpOfCDgoaq6YphsqiR_cQGx+z_cTeZ-B=5_Bfm5632fPYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpOfCDgoaq6YphsqiR_cQGx+z_cTeZ-B=5_Bfm5632fPYQ@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: khalid.aziz@hp.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Apr 17, 2018 at 10:20:08AM +0530, Bhupesh Sharma wrote:
> Hi,
> 
> I was working on improving documentation/structure of the upstream
> kexec-tools and I was wondering what is the purpose of the 'kdump'
> directory inside the kexec-tools.
> 
> This kdump utility seems to cause confusion with the 'kdump' utility
> present inside some distributions (for e.g.  '/usr/sbin/kdump' present
> inside fedora) due to the same naming convention and so we should
> populate/modify the kdump man page to indicate the same, so as to
> avoid confusion.
> 
> Presently here are the contents of this directory:
> 
> # ls kdump/
> kdump.8  kdump.c  Makefile
> 
> - Out of these the kdump man documentation (kdump.8) is just a
> placeholder as suggested by the man page documentation: "kdump - This
> is just a placeholder until real man page has been written"
> 
> - Looking at kdump.c :
> 
> 1. I understand that this code is mainly used to read a crashdump from
> memory. One can run the same using:
> 
> # kdump <start_addr>
> 
> where start_addr is basically the start address of the core dump
> (which can also be represented via the 'elfcorehdr' environment
> variable being passed to the crash kernel which represents the
> physical address of the start of the ELF header)
> 
> 2. This tool needs READ_ONLY access to /dev/mem (so we need to set
> CONFIG_STRICT_DEVMEM configuration option accordingly).
> 
> 3. The code thereafter reads (via mmap) and verifies the ELF header.
> Subsequently it reads (via mmap) the program header.
> 
> 4. Then we collect all the notes and write on STDOUT all the headers
> and notes found in the crashdump collected from memory.
> 
> So, as per my understanding even in absence of (more powerful) tools
> like crash (or gdb), we can still go ahead and read the crashdump from
> memory and display all the headers and notes present in the same on
> standard serial out interface using this kdump utility.
> 
> This is probably a good to have feature for systems which have very
> simple/minimal rootfs (and I see that a few arm32 systems seem to use
> the same as well) or are low on memory availability.
> 
> Now, I wanted to confirm if the 'kdump' utility for reading crashdump
> collected from memory is still needed (as the last commit is dated
> back to 2016 and was done for arm32 systems). If yes, I can go ahead
> and enhance the kdump man page to include the description given above
> - so that it helps users understand how to run the tool.
> 
> Please share your opinions.

Firstly, please use:

  git://git.armlinux.org.uk/~rmk/kexec-tools.git

for ARM systems - this has some important fixes that aren't in the
mainline repository.

I think the kdump tool is dead.  It only supports the 64-bit ELF
format, and 32-bit ARM can either be 32-bit ELF or 64-bit ELF format
coredumps, depending whether LPAE is enabled.  I've asked questions
about this, and not got anywhere, so I now recommend not using that
tool.

Have you checked whether objcopy can copy the coredump from
/proc/vmcore to the filesystem?  That would permit saving of the
coredump image for later inspection by gdb.

-- 
Russell King

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
