Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZdPT-0006XX-9c
	for kexec@lists.infradead.org; Thu, 13 Mar 2008 02:43:11 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: bug/patch for i386 EFI boot
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
	<20080305092731.GB3979@verge.net.au>
	<p06230913c3f4655358a8@[192.168.9.5]>
Date: Wed, 12 Mar 2008 20:39:42 -0600
In-Reply-To: <p06230913c3f4655358a8@[192.168.9.5]> (Scott D. Davilla's message
	of "Wed, 5 Mar 2008 10:08:25 -0500")
Message-ID: <m163vrxs7l.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

"Scott D. Davilla" <davilla@4pi.com> writes:
> Done and resubmitted with a proper subject line with commented out 
> lines removed. VMware was mangling the leading tabs on the drag and 
> drop from Linux to OS X ???
>
> And as follow up question. It there any access to 
> screen_info.orig_video_isVGA besides linking to the kernel? If there 
> is access to orig_video_isVGA then kexec can setup the screen boot 
> params as the bootloader intended instead of assuming a default VGA 
> config. The orig_video_isVGA is the only parameter missing to clone 
> the initial screen_info information.

Let me take a stab at answering part of this.

Originally I recall kexec passed a configuration for no screen at all.

I think that is still the default of how we setup the data
structures.  Then I merged a patch that detected which
type of screen there is (which you have recently amended).

The goal in kexec in this area has always been to use the user space
APIs and generate the data a normal bootloader or the 16bit setup code
would, without performing the BIOS calls.

If you can see a better way to do this we should go for it.

What we want is not so much the screen layout that the bootloader
provided but the current video mode.  In frame buffer consoles
generally this can not change so it is a pass through.

Hopefully this helps a little.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
