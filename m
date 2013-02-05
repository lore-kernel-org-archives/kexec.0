Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U2kCm-0005Vr-9E
 for kexec@lists.infradead.org; Tue, 05 Feb 2013 15:13:05 +0000
Date: Tue, 5 Feb 2013 10:12:56 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, oldmem: support mmap on /dev/oldmem
Message-ID: <20130205151256.GB12853@redhat.com>
References: <33710E6CAA200E4583255F4FB666C4E20AC36B01@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AC36B01@G01JPEXMBYT03>
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
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "cpw@sgi.com" <cpw@sgi.com>

On Mon, Feb 04, 2013 at 04:59:35AM +0000, Hatayama, Daisuke wrote:
> Support mmap() on /dev/oldmem to improve performance of reading
> /proc/vmcore. Currently, read to /proc/vmcore is done by read_oldmem()
> that uses ioremap and iounmap per a single page; for example, if
> memory is 1GB, ioremap/iounmap is called (1GB / 4KB)-times, that is,
> 262144 times. This causes big performance degradation.
> 
> By this patch, we saw improvement on simple benchmark from
> 
>   200 [MiB/sec] to over 100.00 [GiB/sec].

Impressve improvement. Thanks for the patch.

[..]
> For design decision, I didn't support mmap() on /proc/vmcore because
> it abstracts old memory as ELF format, so there's range consequtive on
> /proc/vmcore but not consequtive on the actual old memory. For
> example, consider ELF headers on the 2nd kernel and the note objects,
> memory chunks corresponding to PT_LOAD entries on the first kernel.
> They are not consequtive on the old memory. So reampping them so
> /proc/vmcore appears consequtive using existing remap_pfn_range() needs
> some complicated work.

Can't we call remap_pfn_range() multiple times. Once for each sequential
range of memory. /proc/vmcore already has list of contiguous memory areas.
So we can parse user passed file offset and size and map into respective
physical chunks and call rempa_pfn_range() on all these chunks.

I think supporting mmap() both on /dev/oldmem as well as /proc/vmcore will
be nice.

Agreed that supporting mmap() on /proc/vmcore is more work as compared to
/dev/oldmem but should be doable.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
