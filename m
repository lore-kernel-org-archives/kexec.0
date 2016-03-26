Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ajptn-0007D8-5U
 for kexec@lists.infradead.org; Sat, 26 Mar 2016 15:13:11 +0000
Date: Sat, 26 Mar 2016 23:17:13 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH V2 0/2] kexec: Make a pair of map/unmap reserved pages in
 error path
Message-ID: <20160326151713.GA28137@dhcp-128-25.nay.redhat.com>
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
 <56D56684.9000908@redhat.com> <20160323024836.GC2567@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160323024836.GC2567@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Xunlei Pang <xlpang@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, akpm@linux-foundation.org, ebiederm@xmission.com

On 03/23/16 at 10:48am, Baoquan He wrote:
> On 03/01/16 at 05:53pm, Xunlei Pang wrote:
> > This is a bug fix.
> > 
> > After this, I will try to do a cleanup for crash_unmap/map_reserved_pages()
> > (only used by S390) to consolidate it with arch_kexec_unprotect/protect_crashkres().
> 
> Hi Xunlei, Minfei,
> 
> I think you need discuss together about how to do clean up codes in this
> place. From my point of view, arch_map/unmap_reserved_pages and
> arch_kexec_protect/unprotect_crashkres() are for the same goal but by
> different ways on different arch. So for Xunlei's patchset, you might
> need to rethink your implementation, the name of function. I personally
> think you just implement a x86 specific arch_map/unmap_reserved_pages.
> It may need a more generic name, and then add your x86 arch specific
> implementation. Sorry I can't see your patches on my mail client,
> Xunlei. Since Andrew asked, I just checked these.
> 
> I am fine with Minfei's patch 1/2. But for patch 2/2, it's a little
> comfortable to me. Is it really necessary to abstract code block from
> kexec_load, then wrap them into a newly added function do_kexec_load()?
> Without this wrapping is there a way to do your bug fix? Is there
> possibility that do_kexec_load will be called in other places? What's
> the benefit to wrap it into do_kexec_load against not wrapping?

Hi, Bao.

There is a suggestion from Vivek to wrap a new function do_kexec_load to
fix this issue, since there are a lot of logic handling in function
kexec_load. And this issue doesn't conflict with xlpang@'s patchset,
except for code confliction.

Thanks
Minfei

> 
> Thanks
> Baoquan
> 
> > 
> > Regards,
> > Xunlei
> > 
> > On 03/01/2016 at 04:02 PM, Minfei Huang wrote:
> > > v1:
> > > - Bisect the patch according to Andrew Morton's suggestion
> > >
> > > Minfei Huang (2):
> > >   kexec: Make a pair of map/unmap reserved pages in error path
> > >   kexec: Do a cleanup for function kexec_load
> > >
> > >  kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
> > >  1 file changed, 63 insertions(+), 49 deletions(-)
> > >
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
