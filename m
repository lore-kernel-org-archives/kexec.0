Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WweAC-0000u8-7T
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 21:10:00 +0000
Date: Mon, 16 Jun 2014 23:09:27 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140616210927.GJ8170@pd.tnic>
References: <20140606181859.GK1526@redhat.com>
 <20140609021122.GB1924@darkstar.nay.redhat.com>
 <20140609053538.GA2874@dhcp-17-89.nay.redhat.com>
 <20140609154137.GD22049@redhat.com> <20140613075011.GA4751@pd.tnic>
 <20140613124609.GC5871@redhat.com> <20140613153620.GG4751@pd.tnic>
 <20140616173823.GC4515@redhat.com> <20140616200526.GF8170@pd.tnic>
 <20140616205331.GA13257@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616205331.GA13257@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, jkosina@suse.cz, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Mon, Jun 16, 2014 at 04:53:31PM -0400, Vivek Goyal wrote:
> Kdump kernel uses a different command line. It adds extra command line
> options to currently running kernels.
> 
> Till recent past we used to pass new kernel's memory map using command
> line "memmap=" and when command line size was 256, we could easily exhaust
> command line on large machines.
> 
> Now we support 2048 and we have not seen that issue and now we have
> moved to passing memory ranges in bootparams so that issue does not
> exist. But kernel still does allow passing memmap= on command line.
> 
> One can do same thing using kexec too.
> 
> Agreed that it is a very corner case use case. Now we can say that we
> will not support it. I am fine with that but I atleast wanted a discussion
> and common understanding of what new syscall will support and what it
> will not.
> 
> Some arches still seem to have COMMAND_LINE_SIZE 256. They will more
> likely to hit this scenario at some point of time.
> 
> Given the fact you feel so strongly on putting this upper limit, I will
> introduce it. And put a comment that if the kernel we are kexecing into
> supports longer command line, the we will not support that size and one
> needs to upgrade first kernel.

Nah, I don't feel strongly about it - I just don't trust userspace and
think that every value we get from it should be "sanitized".

But if you say that you want to be able to pass bigger command line to
2nd kernel because this is how kexec passes info, then I'm fine with it.
This is actually a very valid use case which I was asking for, thanks!

I guess if a malicious user goes at lenths to manipulate
header->cmdline_size just so that kmalloc still succeeds and we're fine
with it then I certainly don't have anything against it. I.e., if user
really wants to shoot himself in the foot, user can.

So it is a good thing we talked about it then. :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
