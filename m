Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WvQsY-0002rg-Qo
 for kexec@lists.infradead.org; Fri, 13 Jun 2014 12:46:47 +0000
Date: Fri, 13 Jun 2014 08:46:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140613124609.GC5871@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-8-git-send-email-vgoyal@redhat.com>
 <20140606065605.GE2785@dhcp-17-89.nay.redhat.com>
 <20140606181859.GK1526@redhat.com>
 <20140609021122.GB1924@darkstar.nay.redhat.com>
 <20140609053538.GA2874@dhcp-17-89.nay.redhat.com>
 <20140609154137.GD22049@redhat.com> <20140613075011.GA4751@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140613075011.GA4751@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, jkosina@suse.cz, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Fri, Jun 13, 2014 at 09:50:11AM +0200, Borislav Petkov wrote:
> On Mon, Jun 09, 2014 at 11:41:37AM -0400, Vivek Goyal wrote:
> > IIUC, COMMAND_LINE_SIZE gives max limits of running kernel and it does
> > not tell us anything about command line size supported by kernel being
> > loaded.
> 
> Whatever you do, you do need a sane default because even querying the
> boot protocol is not reliable as the to-be-loaded kernel's boot protocol
> might be manipulated too, before signing (who knows what people do
> in the wild).

If signature verification is on, that should catch any manipulation to
to protocol headers.

If not, then we really can't do anything about it. A large memory
allocation will fail and user will get error. 

This is not different than length of kernel or length of initrd. Somebody
might prepare a very huge file and pass that fd to kernel and kernel will
try to read the whole thing in. If file is too large, memory allocation
will fail and user space will get error. We don't try to put an upper
limit on size of kernel image or initrd.

> 
> So having a sane, unconditional fallback COMMAND_LINE_SIZE from the
> first kernel is a must, methinks.

I disagree here. What if new kernel supports (2 * COMMAND_LINE_SIZE) length
command line. We don't want to truncate command line to smaller size
because running kernel does not support that long a command line.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
