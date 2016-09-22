Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmzp6-0000P0-8o
 for kexec@lists.infradead.org; Thu, 22 Sep 2016 08:57:41 +0000
Date: Thu, 22 Sep 2016 16:57:15 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/3] makedumpfile: Add support of mm randomization
Message-ID: <20160922085715.GA378@x1>
References: <1472460862-29842-1-git-send-email-bhe@redhat.com>
 <20160922084502.GB18585@dhcp-128-65.nay.redhat.com>
 <20160922084848.GA18964@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160922084848.GA18964@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, thgarnie@google.com

On 09/22/16 at 04:48pm, Dave Young wrote:
> Fix email address of Atsushi Kumagai..
> 
> On 09/22/16 at 04:45pm, Dave Young wrote:
> > Hi, Baoquan
> > 
> > On 08/29/16 at 04:54pm, Baoquan He wrote:
> > > Hi Atsushi and Thomas,

Did you apply below kexec patch either?

kexec/arch/i386: Add support for KASLR memory randomization

Please search it in kexec mailing list, Thomas posted it.

> > > 
> > > This is a draft patchset. I just checked x86_64 implementation according to
> > > Thomas's mm randomization related patches. Not sure if this will affect
> > > other ARCH or XEN. Especially for patch 1/3 and patch 2/3, just a original
> > > idea. I tested on x86_64, passed.
> > > 
> > > And also kernel patch need be adjusted so that number_table.X of makedumpfile
> > > can be used. Will add comment to Thomas's kernel patch.
> > > 
> > > Baoquan He (3):
> > >   makedumpfile: Get info->kernel_version from SYMBOL(init_uts_ns)
> > >     earlier
> > >   makedumpfile: Move get_versiondep_info calling earlier
> > >   makedumpfile: Add support for MM randomization
> > > 
> > >  arch/x86_64.c  | 26 +++++++++-----------------
> > >  makedumpfile.c | 45 ++++++++++++++++++++++++++++++++++++---------
> > >  makedumpfile.h |  3 +++
> > >  3 files changed, 48 insertions(+), 26 deletions(-)
> > > 
> > 
> > With these patch applied, I still get a makedumpfile failure below in Fedora:
> > Kernel applied your patch to export the 3 symbols.
> > 
> > kdump: saving vmcore-dmesg.txt complete                                        
> > kdump: saving vmcore                                                           
> > kdump: saving vmcore failed                                                    
> > [FAILED] Failed to start Kdump Vmcore Save Service. 
> > 
> > Thanks
> > Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
