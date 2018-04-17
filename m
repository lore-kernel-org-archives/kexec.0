Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8Q5a-0007kd-2J
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 12:52:07 +0000
Date: Tue, 17 Apr 2018 13:51:35 +0100
From: Russell King <rmk@armlinux.org.uk>
Subject: Re: kdump in upstream kexec-tools
Message-ID: <20180417125134.GF23531@flint.armlinux.org.uk>
References: <CACi5LpOfCDgoaq6YphsqiR_cQGx+z_cTeZ-B=5_Bfm5632fPYQ@mail.gmail.com>
 <20180417090113.GA19564@flint.armlinux.org.uk>
 <CACi5LpNYx07WCXTYZ0ksDt1zwyEcO+JaAGypfLqC=3o8bHr1aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpNYx07WCXTYZ0ksDt1zwyEcO+JaAGypfLqC=3o8bHr1aQ@mail.gmail.com>
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

On Tue, Apr 17, 2018 at 04:20:00PM +0530, Bhupesh Sharma wrote:
> For e.g I use this tool on my arm64 board as follows:
> 
> a. Read out the 'elfcorehdr' env variable passed to the crash kernel
> and pass the same as an argument to the tool:
> 
> Assuming that the 'elfcorehdr' spans the range ->
> 0xffdf0000-0xffdf13ff, launch the tool as -
> 
> # kdump
> Cannot find the start of the core dump
> 
> # kdump 0xffdf0000 >> output_elf_file
> 
> # file output_elf_file
> output: ELF 64-bit LSB core file ARM aarch64, version 1 (SYSV)

The contents should basically be the same (possibly with a different
section ordering) as /proc/vmcore in the crashdump kernel.  If so,
kdump serves no useful purpose, and ends up confusing the situation
due to its inability to handle 32-bit ELF coredump files.

It seems to me that the presence of /proc/vmcore obsoletes the kdump
tool.

-- 
Russell King

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
