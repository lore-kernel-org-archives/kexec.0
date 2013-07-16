Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz7b7-0000Dz-Lh
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 15:55:30 +0000
Date: Tue, 16 Jul 2013 11:55:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130716155459.GB3398@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702154214.GC22603@redhat.com>
 <20130715154451.02a3a767@holzheu>
 <20130715142708.GB23772@redhat.com>
 <20130716112527.35decf17@holzheu>
 <20130716140418.GB4005@redhat.com>
 <20130716173709.3fed4c42@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130716173709.3fed4c42@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Jul 16, 2013 at 05:37:09PM +0200, Michael Holzheu wrote:

[..]
> The problem is that with the mmap patches we now use copy_oldmem_page()
> to copy the notes from oldmem into the notes_buf which has been allocated
> with vmalloc. The s390 version of copy_oldmem_page() bypasses the page
> tables and uses real copy. And this does not work on vmalloc memory.

I got that. I am trying to remember that in 3.10 why are we dropping
to real mode in s390 while copying pages.

I thought dropping to real mode was needed only to access HSA region.
HSA region comes into the picture only for zfcudump and /proc/vmcore support
for zfcpdump is not there yet

IOW, what if we start copying with page tables enabled in s390. Will
it not work for regular kdump case and take care of zfcpdump in 3.12.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
