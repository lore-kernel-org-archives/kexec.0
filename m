Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XSPPJ-0004LM-7P
 for kexec@lists.infradead.org; Fri, 12 Sep 2014 11:52:53 +0000
Date: Fri, 12 Sep 2014 07:52:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Put each per-cpu kdump ELF notes into a single page
Message-ID: <20140912115230.GA29945@redhat.com>
References: <20140905183314.23690175@hananiah.suse.cz>
 <20140911200110.GA24699@redhat.com>
 <20140911224330.0cec9b4c@hananiah.suse.cz>
 <20140911211637.GF17140@redhat.com>
 <20140912001537.5f877fe7@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140912001537.5f877fe7@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Fri, Sep 12, 2014 at 12:15:37AM +0200, Petr Tesarik wrote:
> On Thu, 11 Sep 2014 17:16:37 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Thu, Sep 11, 2014 at 10:43:30PM +0200, Petr Tesarik wrote:
> > > On Thu, 11 Sep 2014 16:01:10 -0400
> > > Vivek Goyal <vgoyal@redhat.com> wrote:
> > > 
> > > > On Fri, Sep 05, 2014 at 06:33:14PM +0200, Petr Tesarik wrote:
> > > > > On architectures that use percpu-vm, the percpu region is not guaranteed
> > > > > to be contiguous in physical space.
> > > > 
> > > > Petr,
> > > > 
> > > > Which are those arches?
> > > 
> > > All except nommu. Actually, percpu-km will be used instead even on MMU
> > > if SMP is disabled, but since SMP is pretty standard now, I guess the
> > > vast majority of all kernels out there is affected. ;-)
> > 
> > Hi Petr,
> > 
> > To make sure I understand it correctly I will just summarize what you
> > said.
> > 
> > alloc_percpu() code does not guarantee that an object will be on physically
> > contiguous pages if object crosses page boundary. That's why we are forcing
> > allocation of object aligned to nearest higher power of two boundary of
> > object size and that way object will always be on same page (as long as object
> > is not bigger than a page).
> > 
> > Is that a fair summary?
> 
> Yes. I might add a note why physically contiguous memory is needed
> here, but maybe it's obvious to anyone dealing with kdump.

I think adding couple of lines to explain why physically contiguous notes
are needed is a good idea. It will not be ovious to anybody new to kdump.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
