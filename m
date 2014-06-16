Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wweiz-00080J-VM
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 21:45:58 +0000
Date: Mon, 16 Jun 2014 17:45:23 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 11/13] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140616214523.GC1870@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-12-git-send-email-vgoyal@redhat.com>
 <20140615163515.GA17016@pd.tnic> <20140616200608.GD4515@redhat.com>
 <20140616205743.GI8170@pd.tnic> <20140616211500.GA1870@redhat.com>
 <20140616212720.GL8170@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616212720.GL8170@pd.tnic>
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
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Mon, Jun 16, 2014 at 11:27:20PM +0200, Borislav Petkov wrote:
> On Mon, Jun 16, 2014 at 05:15:00PM -0400, Vivek Goyal wrote:
> > Do we want to show all the rejection messages from bzImage64 and
> > bzImage32 loaders. It might be too verbose to show users that before
> > vmlinux loader accepted the image other loaders on this arches rejcted
> > the image.
> 
> I get all that. But, if people want to get feedback from the system
> about *why* their image didn't load, they absolutely have to enable
> dynamic debug. And this is not optimal IMO because they will have to
> look at the code first to see what they need to do.
> 
> Or is kexec-tools going to be taught to interpret return values from the
> syscall?

In most of the cases return code is -ENOEXEC so kexec-tools can't figure
out what's wrong.

> 
> In any case, we want information about why an image fails loading to
> reach the user in the easiest way possible. And why should the user need
> to enable dynamic debug if he can get the info without doing so?
> 
> Oh, and not everyone knows about dynamic debug so...
> 
> And I don't think it'll be too much info - only the line which fails
> the check will be printed before the image loader fails so that's
> practically one error reason per failed image.
> 

Ok, there will be one line of error and that's not too bad. I will
convert these pr_debug() statements in bzImage_probe() to pr_err().

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
