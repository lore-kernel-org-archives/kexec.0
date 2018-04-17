Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8IZR-0001nw-S9
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 04:50:24 +0000
Received: by mail-lf0-f49.google.com with SMTP id d20-v6so25314498lfe.3
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2018 21:50:11 -0700 (PDT)
MIME-Version: 1.0
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 17 Apr 2018 10:20:08 +0530
Message-ID: <CACi5LpOfCDgoaq6YphsqiR_cQGx+z_cTeZ-B=5_Bfm5632fPYQ@mail.gmail.com>
Subject: kdump in upstream kexec-tools
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
To: rmk@arm.linux.org.uk, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com
Cc: khalid.aziz@hp.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi,

I was working on improving documentation/structure of the upstream
kexec-tools and I was wondering what is the purpose of the 'kdump'
directory inside the kexec-tools.

This kdump utility seems to cause confusion with the 'kdump' utility
present inside some distributions (for e.g.  '/usr/sbin/kdump' present
inside fedora) due to the same naming convention and so we should
populate/modify the kdump man page to indicate the same, so as to
avoid confusion.

Presently here are the contents of this directory:

# ls kdump/
kdump.8  kdump.c  Makefile

- Out of these the kdump man documentation (kdump.8) is just a
placeholder as suggested by the man page documentation: "kdump - This
is just a placeholder until real man page has been written"

- Looking at kdump.c :

1. I understand that this code is mainly used to read a crashdump from
memory. One can run the same using:

# kdump <start_addr>

where start_addr is basically the start address of the core dump
(which can also be represented via the 'elfcorehdr' environment
variable being passed to the crash kernel which represents the
physical address of the start of the ELF header)

2. This tool needs READ_ONLY access to /dev/mem (so we need to set
CONFIG_STRICT_DEVMEM configuration option accordingly).

3. The code thereafter reads (via mmap) and verifies the ELF header.
Subsequently it reads (via mmap) the program header.

4. Then we collect all the notes and write on STDOUT all the headers
and notes found in the crashdump collected from memory.

So, as per my understanding even in absence of (more powerful) tools
like crash (or gdb), we can still go ahead and read the crashdump from
memory and display all the headers and notes present in the same on
standard serial out interface using this kdump utility.

This is probably a good to have feature for systems which have very
simple/minimal rootfs (and I see that a few arm32 systems seem to use
the same as well) or are low on memory availability.

Now, I wanted to confirm if the 'kdump' utility for reading crashdump
collected from memory is still needed (as the last commit is dated
back to 2016 and was done for arm32 systems). If yes, I can go ahead
and enhance the kdump man page to include the description given above
- so that it helps users understand how to run the tool.

Please share your opinions.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
