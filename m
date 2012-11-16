Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZNOi-000449-GQ
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 15:00:01 +0000
Date: Fri, 16 Nov 2012 09:59:51 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121116145951.GB4515@redhat.com>
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com>
 <50A3CFAD.6090008@linux.vnet.ibm.com>
 <20121114175304.GK20215@redhat.com>
 <50A4E524.8020702@linux.vnet.ibm.com>
 <20121115154914.GE2529@redhat.com>
 <50A61F37.7030205@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50A61F37.7030205@linux.vnet.ibm.com>
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
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, buendgen@de.ibm.com

On Fri, Nov 16, 2012 at 04:40:47PM +0530, Aravinda Prasad wrote:

[..]
> > Ok, are these the only places where key is. Can a copy of it exist in
> > some other buffers? We don't clear these.
> 
> 
> I don't think a copy exist in other places

I am wondering how does ssh work. User's private key is stored in .ssh/
and when authentication with server is happening then we must be signing
something with that private key and most likely it will be in some
buffer somewhere (user space buffer).

> 
> > 
> > Also, if key is the only issue, why not just write this logic in
> > makedumpfile and provide another option, --clear-kernel-keys.
> > 
> > Why to introduce such generic scheme.
> 
> 
> key is not the only issue, it was just an example. There could be other
> things as well (data in socket buffers, device driver buffers, etc)
> which customers may consider sensitive/private and are interested in
> scrubbing.
> 
> Also this is an extension to the already existing generic solution
> implemented in makedumpfile, where rules can be specified using --config
> option. This extension is built on the existing infrastructure and
> provides a more flexible and powerful way to specify the data to be
> scrubbed. For eg, scrubbing the keyring data mentioned in one of my
> previous mails would not be possible with --config option.

I am not against building infrastructure to scrub vmcore. I am only
concerned about size bloat of makedumpfile.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
