Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VkrMi-0006pj-0B
 for kexec@lists.infradead.org; Mon, 25 Nov 2013 08:17:56 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: /proc/vmcore mmap() failure issue
Date: Mon, 25 Nov 2013 08:10:10 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971C5AB3@BPXM01GP.gisp.nec.co.jp>
References: <5284A689.70903@jp.fujitsu.com>
 <20131114151359.GA3913@redhat.com> <5285EC60.1060906@jp.fujitsu.com>
 <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
 <20131118135511.GA30637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C3862@BPXM01GP.gisp.nec.co.jp>
 <20131120145901.GB27924@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C43E3@BPXM01GP.gisp.nec.co.jp>
 <528DC4F2.5040000@jp.fujitsu.com> <20131121165237.GG16208@redhat.com>
In-Reply-To: <20131121165237.GG16208@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>

On 2013/11/22 1:53:14, kexec <kexec-bounces@lists.infradead.org> wrote:
> On Thu, Nov 21, 2013 at 05:31:46PM +0900, HATAYAMA Daisuke wrote:
> 
> [..]
> > > So I think the patch I sent is enough, the policy will be simpler as
> > > "Don't use mmap() for buggy kernels".
> > > 
> > > [PATCH] Fall back to read() when mmap() fails.
> > > http://lists.infradead.org/pipermail/kexec/2013-November/010199.html
> > > 
> > 
> > I think logic becomes not so complex. For example, if input vmcore
> > format is ELF, then:
> > 
> > o in update_mmap_range():
> >   - first calculate a range of the corresponding PT_LOAD entry truncated with
> >     PAGE_SIZE.
> >   - Then, truncate range of mmap() by the truncated range of the corresponding
> >     PT_LOAD entry, i.e., exlucde partial pages from mmap() target range.
> >   - Then determine offsets of two partial pages; the number of partial pages
> >     are always at most two. The offsets can easily be calculated from the
> >     original range of the corresponding PT_LOAD entry
> > 
> > o in read_from_vmcore(), if a given offset belongs to either of two partial
> >   pages, then go to read() path; if not, go to mmap() path.
> 
> I agree that we should do mmap() on all non-partial pages and do read()
> on all partial pages. Otherwise we lose the benefit of faster speed of
> mmap().

I agree to avoid this issue by fixing makedumpfile as workaround while to
fix kernel is so tough and risky. However, it sounds strange to me to fix
userspace side elaborately for such definite kernel issue whose cause is
known, so we should fix the kernel itself.

Otherwise, will you continue to add specific fixes into user tools to
address kernel issues like this case ?


Thanks
Atsushi Kumagai

> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
