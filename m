Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 6 Dec 2021 15:07:15 +0000
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for
 user pointer
Message-ID: <Ya4nI7ly15pJA5xp@casper.infradead.org>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com>
 <20211206140451.GA4936@lst.de>
 <Ya4bdB0UBJCZhUSo@casper.infradead.org>
 <20211206145422.GA8794@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206145422.GA8794@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>, linux-kernel@vger.kernel.org, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>

On Mon, Dec 06, 2021 at 03:54:22PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 06, 2021 at 02:17:24PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 06, 2021 at 03:04:51PM +0100, Christoph Hellwig wrote:
> > > This looks like a huge mess.  What speak against using an iov_iter
> > > here?
> > 
> > I coincidentally made a start on this last night.  Happy to stop.
> 
> Don't stop!
> 
> > What do you think to adding a generic copy_pfn_to_iter()?  Not sure
> > which APIs to use to implement it ... some architectures have weird
> > requirements about which APIs can be used for what kinds of PFNs.
> 
> Hmm.  I though kmap_local_pfn(_prot) is all we need?

In the !HIGHMEM case, that calls pfn_to_page(), and I think the
point of this path is that we don't have a struct page for this pfn.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
