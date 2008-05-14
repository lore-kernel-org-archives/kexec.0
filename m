Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwL6r-0006Mh-TH
	for kexec@lists.infradead.org; Wed, 14 May 2008 17:49:50 +0000
Date: Wed, 14 May 2008 13:49:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080514174934.GG30469@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514160329.GF30469@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080514160329.GF30469@redhat.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Wed, May 14, 2008 at 12:03:29PM -0400, Vivek Goyal wrote:
> On Thu, Mar 06, 2008 at 11:13:08AM +0800, Huang, Ying wrote:
> > This is a minimal patch with only the essential features. All
> > additional features are split out and can be discussed later. I think
> > it may be easier to get consensus on this minimal patch.
> > 
> 
> Hi Huang,
> 
> Ok, after a long time, I am back to testing and reviewing this patch.
> 
> 
> [..]
> > 7. Boot kernel compiled in step 1 (kernel C). Use the rootfs.gz as
> >    root file system.
> > 
> > 8. In kernel C, load the memory image of kernel A as follow:
> > 
> >    /sbin/kexec -l --args-none --entry=`cat kexec_jump_back_entry` dump.elf
> > 
> 
> How do I got back to original kernel without loading dump.elf. I mean,
> original kernel is already in memory and I don't have to first save
> it to disk and then reload back. Is there a way to do it? If not, then
> we need to modify kexec-tools to support that.
> 
> Something like
> 
> kexec --entry=<entry point>, should tell kexec that kernel is already
> loaded. Just do the bit to set the entry point properly.
> 

Never mind. I found it. Following worked for me for returning back to
original kernel.

kexec --load-jump-back-helper --entry=<entry point>

Just wondering if "--load-jump-back-helper" should be an explicit option
or kexec should silently assume it if no "-l" or "-p" is given.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
