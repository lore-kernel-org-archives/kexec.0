Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZsG-0004vO-6a
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 19:25:12 +0000
Date: Thu, 21 Nov 2013 14:24:47 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131121192447.GO16208@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131121190350.GC17070@kroah.com>
 <20131121190620.GA25951@srcf.ucam.org>
 <20131121191305.GK16208@redhat.com>
 <20131121191907.GA26366@srcf.ucam.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121191907.GA26366@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <greg@kroah.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, ebiederm@xmission.com, hpa@zytor.com

On Thu, Nov 21, 2013 at 07:19:07PM +0000, Matthew Garrett wrote:
> On Thu, Nov 21, 2013 at 02:13:05PM -0500, Vivek Goyal wrote:
> > On Thu, Nov 21, 2013 at 07:06:20PM +0000, Matthew Garrett wrote:
> > > That would require a certain degree of massaging from userspace if we 
> > > want to be able to use the existing Authenticode signatures. Otherwise 
> > > we need to sign kernels twice.
> > 
> > I was thinking oof signing the same kernel twice. Can I sign authenticode
> > signed kernel again (using RSA signature as we do for modules) and append
> > the signature to bzImage. 
> 
> No, you'd need to do it the other way around.

Then I can't assume that RSA signatures are appened to bzImage, as we
do for modules.

Also I am assuming that authenticode signing will change something in
PE/COFF header and that would invalidate the bzImage signature.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
