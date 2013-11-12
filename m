Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg8rN-0006fo-Dx
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 07:58:06 +0000
Date: Mon, 11 Nov 2013 23:58:31 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [patch 1/3 v2] Add function get_bootparam
Message-ID: <20131112075831.GA6213@kroah.com>
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com>
 <52819E71.70201@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52819E71.70201@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, dyoung@redhat.com, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

On Mon, Nov 11, 2013 at 07:20:17PM -0800, H. Peter Anvin wrote:
> On 11/11/2013 05:27 PM, Toshi Kani wrote:
> > On Tue, 2013-11-05 at 16:29 +0800, dyoung@redhat.com wrote:
> >> Not only setup_subarch will get data from debugfs file
> >> boot_params/data, later code for adding efi_info will
> >> also need do same thing. Thus add a common function here
> >> for later use.
> > 
> > get_bootparam() calls find_mnt_by_fsname("debugfs"), which assumes that
> > debugfs is mounted with device name "debugfs".  This function fails
> > when:
> >  - debugfs is not mounted, or
> >  - debugfs is mounted with a different device name, such as nodev [1].
> > 
> > This issue is not introduced by this patch.  But the original code,
> > which sets hardware_subarch, seems to work even if it failed to access
> > debugfs (which is ignored) since hardware_subarch is zero most of the
> > cases anyway.  With this change, however, this failure now makes the 2nd
> > kernel unbootable.  So, it needs to be addressed to make this code path
> > work reliably (or kexec should fail at least).
> > 
> 
> Greg, Ingo,
> 
> Since there is now a legitimate user of this stuff, can we actually
> export this in sysfs (or something else other than sploit^Wdebugfs)?

Hey, after Tejun is done with the kernelfs work, I'll be porting debugfs
to it so you can't call it sploitfs anymore :)

> kexec-tools can have a fallback to debugfs if we really need it, but
> making people mount debugfs to have some essential piece of
> functionality scares the heck out of me.

I agree, that would not be good.

I'm not sure what exactly the sysfs file is wanting to look like?  The
efi section variable sysfs file isn't ok (multiple lines with multiple
values.)  What is this going to look like?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
