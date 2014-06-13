Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WvMQB-00043x-VN
 for kexec@lists.infradead.org; Fri, 13 Jun 2014 08:01:13 +0000
Date: Fri, 13 Jun 2014 16:00:28 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140613080028.GK15034@dhcp-17-89.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, jkosina@suse.cz, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 06/13/14 at 09:50am, Borislav Petkov wrote:
> On Mon, Jun 09, 2014 at 11:41:37AM -0400, Vivek Goyal wrote:
> > IIUC, COMMAND_LINE_SIZE gives max limits of running kernel and it does
> > not tell us anything about command line size supported by kernel being
> > loaded.
> 
> Whatever you do, you do need a sane default because even querying the
> boot protocol is not reliable as the to-be-loaded kernel's boot protocol
> might be manipulated too, before signing (who knows what people do
> in the wild).

Make sense.

> 
> So having a sane, unconditional fallback COMMAND_LINE_SIZE from the
> first kernel is a must, methinks.

By greping for COMMAND_LINE_SIZE for different arch, I think 8K being
the fallback, in general, is good for now and the future:

alpha/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     256

arm/include/uapi/asm/setup.h
19:#define COMMAND_LINE_SIZE 1024

avr32/include/uapi/asm/setup.h
14:#define COMMAND_LINE_SIZE 256

cris/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     256

frv/include/uapi/asm/setup.h
15:#define COMMAND_LINE_SIZE       512

ia64/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     2048

m32r/include/uapi/asm/setup.h
8:#define COMMAND_LINE_SIZE       512

m68k/include/uapi/asm/setup.h
14:#define COMMAND_LINE_SIZE 256

mips/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     4096

parisc/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     1024

powerpc/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     2048

s390/include/uapi/asm/setup.h
9:#define COMMAND_LINE_SIZE     4096

um/include/asm/setup.h
8:#define COMMAND_LINE_SIZE 4096

x86/include/asm/setup.h
6:#define COMMAND_LINE_SIZE 2048

xtensa/include/uapi/asm/setup.h
14:#define COMMAND_LINE_SIZE    256

c6x/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE   1024

microblaze/include/uapi/asm/setup.h
14:#define COMMAND_LINE_SIZE    256

mn10300/include/uapi/asm/param.h
16:#define COMMAND_LINE_SIZE 256

score/include/uapi/asm/setup.h
4:#define COMMAND_LINE_SIZE     256

tile/include/uapi/asm/setup.h
18:#define COMMAND_LINE_SIZE    2048

arc/include/asm/setup.h
15:#define COMMAND_LINE_SIZE 256

arm64/include/uapi/asm/setup.h
24:#define COMMAND_LINE_SIZE    2048

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
