Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg9OL-0007RQ-Iu
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 08:32:09 +0000
Date: Tue, 12 Nov 2013 00:31:10 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 4/7 v2] export more efi table variable to sysfs
Message-ID: <20131112083110.GA7892@kroah.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082717.561020034@dhcp-16-126.nay.redhat.com>
 <20131112004014.GA15377@kroah.com>
 <20131112081937.GE6999@dhcp-16-126.nay.redhat.com>
 <20131112082401.GA13899@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131112082401.GA13899@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, Nov 12, 2013 at 04:24:01PM +0800, Dave Young wrote:
> On 11/12/13 at 04:19pm, Dave Young wrote:
> > On 11/11/13 at 04:40pm, Greg KH wrote:
> > > On Tue, Nov 05, 2013 at 04:20:11PM +0800, dyoung@redhat.com wrote:
> > > > Export fw_vendor, runtime and config tables physical
> > > > addresses to /sys/firmware/efi/systab becaue kexec
> > > > kernel will need them.
> > > 
> > > sysfs files are one-value-per-file.
> > > 
> > > Please don't abuse this and add more values to this single file, in
> > > fact, it should be broken up into individual sysfs files as it is,
> > > because this isn't ok now.
> > > 
> > > Sorry, you don't get to abuse this anymore :(
> > 
> > Ok, I know this, just creating this without thinking about carefully.
> > Will redo the patch, thanks for catching.
> 
> I would like to add new files for the values used in this patchset.
> And will split the original systab later in another patchset.

That's fine with me, thanks.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
