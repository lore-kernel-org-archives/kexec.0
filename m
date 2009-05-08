Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2EoI-0007gm-Ha
	for kexec@lists.infradead.org; Fri, 08 May 2009 01:23:41 +0000
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 07 May 2009 18:23:09 -0700
In-Reply-To: <1241735222-6640-1-git-send-email-hpa@linux.intel.com> (H. Peter
	Anvin's message of "Thu\, 7 May 2009 15\:26\:48 -0700")
Message-ID: <m14ovwz8ua.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/14] RFC: x86: relocatable kernel changes
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com


Peter do you plan to update pxelinux or other bootloaders to use the
relocatable kernel feature?

Can we please kill the gosh awful impact lines?  They keep breaking my
concentration whenever I try and review these patches.  They are
horrible.  Something of very minimal significance jumping up and
screaming at me. 

The impact lines also fail to capture any of the significant ways I
can easily think of that this patch could cause problems.  A little
screw up could cause the kernel to fail to boot for a random portion
of our user base, and the patch as constructed will require changes
to existing bootloaders.

The direction of this patch seems reasonable.  The details are broken.
The common case for relocatable kernels today is kdump.  A situation
with very minimal memory.  In that situation the kernel needs to run
where we put it, modifying the kernel to not run where it gets put
is a problem.

With the code as it is today you can get the exact same behavior
by simply bumping up the minimum alignment to 16MB, and a lot less code
and no changes needed to any bootloaders.

Is your goal to setup a scenario where on small memory systems a bootloader
like pxelinux can support a relocatable kernel and load it a lower
address?  If so that seems reasonable.

With that said how about we change the logic to:

if (load_addr == legacy_load_addr) /* 0x100000 */
	use config_physical_start
else if aligned
	noop
else
        /* Crap this is bad align the kernel and hope something works. */

That gets the desired behavior we override bootloaders that are not
smart and taking relocation into account.  I am really not comfortable
with having code that will override a bootloader doing something
reasonable.

I expect we will still want to update kexec to be able to take
advantage of loadtime_size (runtime_size seems like the wrong name).

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
