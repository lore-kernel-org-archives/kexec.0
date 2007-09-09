Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from palinux.external.hp.com ([192.25.206.14]
	helo=mail.parisc-linux.org)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUMQ2-0003Ih-7L
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 09:01:44 -0400
Date: Sun, 9 Sep 2007 07:01:39 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 4/5] Use extended crashkernel command line on IA64
Message-ID: <20070909130139.GF6809@parisc-linux.org>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083915.165288618@strauss.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070909083915.165288618@strauss.suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, Sep 09, 2007 at 10:39:18AM +0200, Bernhard Walle wrote:
> Because the total amount of System RAM must be known when calling this
> function, efi_memmap_init() is modified to return its comulated 

accumulated?

> total_memory variable in a pointer value. IMO that's better than making the
> variable global.

Why not make efi_memmap_init() return total_memory instead of void?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
