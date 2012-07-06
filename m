Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn9qX-00064g-6L
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 14:49:27 +0000
Message-Id: <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
Date: Fri, 06 Jul 2012 15:50:20 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S
 during kexec boot
References: <20120705210607.GA26908@aepfle.de>
 <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
 <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de> <20120706141419.GA21951@aepfle.de>
In-Reply-To: <20120706141419.GA21951@aepfle.de>
Mime-Version: 1.0
Content-Disposition: inline
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
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

>>> On 06.07.12 at 16:14, Olaf Hering <olaf@aepfle.de> wrote:
> On Fri, Jul 06, Olaf Hering wrote:
> 
>> I will cleanup my debug changes and post the output.
> 
> What I see is that the content of the uncompressed vmlinux is
> appearently already corrupted after decompress().  After I made small
> changes to arch/x86/boot/compressed/misc.c and arch/x86/kernel/head_64.S
> the offset in memory changed from 0x2c to 0x8.
> 
> This could mean that the unzip code is broken, but this is rather
> unlikely. The odd thing is, if the first kernel is forced to return
> false in xen_hvm_platform() to disable the PVonHVM features then kexec
> works ok.
> 
> Could it be that some code tweaks the stack content used by decompress()
> in some odd way? But that would most likely lead to a crash, not to
> unexpected uncompressing results.

Especially if the old and new kernel are using the exact same
image, how about the decompression writing over the shared
info page causing all this? As the decompressor wouldn't
expect Xen to possibly write stuff there itself, it could easily be
that some repeat count gets altered, thus breaking the
decompressed data without the decompression code necessarily
noticing.

If that's the case, there would be a more general problem here
(for kdump at least), as granted pages could also still get written
to when the new kernel already is in the process of launching.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
