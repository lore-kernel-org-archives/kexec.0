Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQOqe-0008Cr-51
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 20:43:45 +0000
Date: Mon, 22 Oct 2012 16:43:39 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121022204339.GG3401@redhat.com>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121019143112.GB27052@redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Fri, Oct 19, 2012 at 10:31:12AM -0400, Vivek Goyal wrote:

[..]
> - What happens to purgatory code. It is unsigned piece of code which
>   runs in kernel?

Thinking more about it, another not so clean proposal. 

- So only non-signed executable code user space loads is purgatory. What
  if we get rid of purgatory and let kernel do the pugatory's job.

- purgatory seems to be doing few things. (atleast on x86_64).
	1. Verifies the checksums of loaded segments.
	2. Copies the backup region.
	3. Prepares the environment for jumping into target executable.
	    (32bit entry or real mode entry etc).

   First should be easily doable in kernel. At load time kernel can calculate
   the checksum of loaded segments and can verify the chesum again before
   during execute time.

   Second one should be doable too in kernel as kernel can copy the
   contents to backup region. Just that we shall have to introduce per
   segment flags so that user space can tell kernel that a particular
   segment is backup segment. (say KEXEC_BACKUP_SEGMENT).

   Third one is most tricky as it requires passing extra information to
   kernel about what kind of setup to do before jumping to entry point. If
   we can define some generic per arch kexec flags to represent those 
   states, then kernel can do the job. 

Doing lots of things based on flags does not sound very clean to me. Over
a period of time we will end up defining more flags as people come up
with new situations. But at the same time it can simplify the problem 
a bit and one does not have to introduce an new system call.

Just a thought..., Still scratching my head on how to go about this signed
image thing without too much of work.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
