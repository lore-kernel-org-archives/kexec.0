Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WvTX4-0003J3-9G
 for kexec@lists.infradead.org; Fri, 13 Jun 2014 15:36:46 +0000
Date: Fri, 13 Jun 2014 17:36:20 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140613153620.GG4751@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-8-git-send-email-vgoyal@redhat.com>
 <20140606065605.GE2785@dhcp-17-89.nay.redhat.com>
 <20140606181859.GK1526@redhat.com>
 <20140609021122.GB1924@darkstar.nay.redhat.com>
 <20140609053538.GA2874@dhcp-17-89.nay.redhat.com>
 <20140609154137.GD22049@redhat.com> <20140613075011.GA4751@pd.tnic>
 <20140613124609.GC5871@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140613124609.GC5871@redhat.com>
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

On Fri, Jun 13, 2014 at 08:46:09AM -0400, Vivek Goyal wrote:
> If not, then we really can't do anything about it. A large memory
> allocation will fail and user will get error.

Of course we can! You can't trust userspace and you need to check the
values it gives you through the syscall.

And you need a sane default. The fact that I even have to state this
explicitly...!

So what if userspace gives a maximum value for which allocation
succeeds? Does that mean that the kernel should blindly comply and
allocate? Of course not! That would be dumb.

> I disagree here. What if new kernel supports (2 * COMMAND_LINE_SIZE)
> length command line. We don't want to truncate command line to smaller
> size because running kernel does not support that long a command line.

Do you have a sensible use case where 2048 cmdline size (on x86) won't
be enough and you really need it larger?

And even if this is a problem - which I seriously doubt - it would be
problem with the 1st kernel too, not only with the kexec-ed one.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
