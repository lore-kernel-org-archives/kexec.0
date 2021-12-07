Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muYRc-008Epc-DM
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 11:15:37 +0000
Date: Tue, 7 Dec 2021 12:15:26 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem()
 for user pointer
Message-ID: <20211207111526.GA18554@lst.de>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com> <20211206140451.GA4936@lst.de>
 <Ya4bdB0UBJCZhUSo@casper.infradead.org> <20211206145422.GA8794@lst.de>
 <Ya4nI7ly15pJA5xp@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ya4nI7ly15pJA5xp@casper.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Amit Daniel Kachhap <amit.kachhap@arm.com>, linux-kernel@vger.kernel.org, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>

On Mon, Dec 06, 2021 at 03:07:15PM +0000, Matthew Wilcox wrote:
> > > What do you think to adding a generic copy_pfn_to_iter()?  Not sure
> > > which APIs to use to implement it ... some architectures have weird
> > > requirements about which APIs can be used for what kinds of PFNs.
> > 
> > Hmm.  I though kmap_local_pfn(_prot) is all we need?
> 
> In the !HIGHMEM case, that calls pfn_to_page(), and I think the
> point of this path is that we don't have a struct page for this pfn.

Indeed.  But to me this suggest that the !highmem stub is broken and
we should probably fix it rather than adding yet another interface.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
