Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLnJf-0007Iv-L9
 for kexec@lists.infradead.org; Tue, 07 Apr 2020 12:26:56 +0000
Date: Tue, 7 Apr 2020 14:26:52 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [v2 0/2] Fix --kexec-syscall-auto on s390x
Message-ID: <20200407122652.GD17530@vergenet.net>
References: <20200313140929.29551-1-ptesarik@suse.cz>
 <20200401124009.GB29376@vergenet.net>
 <20200403134504.4a0304e9@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403134504.4a0304e9@ezekiel.suse.cz>
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
Cc: kexec mailing list <kexec@lists.infradead.org>

On Fri, Apr 03, 2020 at 01:45:04PM +0200, Petr Tesarik wrote:
> On Wed, 1 Apr 2020 14:40:09 +0200
> Simon Horman <horms@verge.net.au> wrote:
> 
> > On Fri, Mar 13, 2020 at 03:09:27PM +0100, Petr Tesarik wrote:
> > > From: Petr Tesarik <ptesarik@suse.com>
> > > 
> > > As noticed by Raymund Will, kexec -la does not work on kernels without
> > > the kexec_file_load(2) syscall, revealing some shortcomings in the
> > > automatic syscall selection.
> > > 
> > > Petr Tesarik (2):
> > >   kexec-tools: Fix kexec_file_load(2) error handling
> > >   kexec-tools: Reset getopt before falling back to legacy syscall
> > > 
> > >  kexec/kexec.c | 120 ++++++++++++++++++++++++++++++++--------------------------  
> > 
> > Thanks, applied.
> 
> Thank you very much.
> 
> IBM has just found an issue with the patch, and I've already sent a
> follow-up fix. Sorry for the extra noise.

No problem, thanks for the follow-up.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
