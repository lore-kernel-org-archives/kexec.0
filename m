Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3gJ-0003WT-8R
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 09:58:20 +0000
Date: Mon, 28 Jan 2019 17:58:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125140823.GC27998@zn.tnic>
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
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

On 01/25/19 at 03:08pm, Borislav Petkov wrote:
> On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > AFAIK, some people prefer to explictly reserve crash memory at high
> > region even if it is possible to reserve at low area.  May because
> > <4G memory is limited on large server, they want to leave this for other
> > use. 
> > 
> > Yinghai or Vivek should know more about the history, probably they can
> > recall some initial reason.
> 
> Yes, just "prefer" is not good enough. There should be a technical
> reason why that's there.
> 
> Also, if the user doesn't care, then the code should be free to force
> "high" and thus probe a different range for allocation.

Another reason is in case ,high we will need automatically reserve a
region in low area for swiotlb.  So for example one use
crashkernel=256M,high,  actual reserved memory is 256M above 4G and
another 256M under 4G for swiotlb.  Normally it is not necessary for
most people.  Thus we can not make ,high as default.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
